// AWS Cognito Configuration
let cognitoConfig = {
    region: 'us-east-1',
    userPoolId: 'us-east-1_ozrN70qbK',
    clientId: '2ee8s2tlioeelhuli5sfn14p9m'
};

let userPool;
let cognitoUser;

// Initialize Cognito when config is available
function initializeCognito() {
    if (cognitoConfig.userPoolId && cognitoConfig.clientId) {
        const poolData = {
            UserPoolId: cognitoConfig.userPoolId,
            ClientId: cognitoConfig.clientId
        };
        userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);
        checkAuthStatus();
    }
}

// Check if user is already authenticated
function checkAuthStatus() {
    cognitoUser = userPool.getCurrentUser();
    
    if (cognitoUser != null) {
        cognitoUser.getSession((err, session) => {
            if (err) {
                console.log('Session error:', err);
                showLoginButton();
                return;
            }
            
            if (session.isValid()) {
                showLogoutButton();
                showWelcomeMessage(cognitoUser.getUsername());
            } else {
                showLoginButton();
            }
        });
    } else {
        showLoginButton();
    }
}

// Sign up new user
function signUp() {
    const username = document.getElementById('newUsername').value;
    const email = document.getElementById('email').value;
    const password = document.getElementById('newPassword').value;
    
    if (!username || !email || !password) {
        showAlert('Por favor completa todos los campos', 'danger');
        return;
    }
    
    if (!userPool) {
        showAlert('Configuración de autenticación no disponible', 'danger');
        return;
    }
    
    const attributeList = [
        new AmazonCognitoIdentity.CognitoUserAttribute({
            Name: 'email',
            Value: email
        })
    ];
    
    userPool.signUp(username, password, attributeList, null, (err, result) => {
        if (err) {
            console.log('Sign up error:', err);
            showAlert('Error al registrar: ' + err.message, 'danger');
            return;
        }
        
        showAlert('Usuario registrado exitosamente. Revisa tu email para confirmar la cuenta.', 'success');
        toggleForm(); // Switch back to login form
    });
}

// Sign in user
function signIn() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;
    
    if (!username || !password) {
        showAlert('Por favor ingresa usuario y contraseña', 'danger');
        return;
    }
    
    if (!userPool) {
        showAlert('Configuración de autenticación no disponible', 'danger');
        return;
    }
    
    const authenticationData = {
        Username: username,
        Password: password
    };
    
    const authenticationDetails = new AmazonCognitoIdentity.AuthenticationDetails(authenticationData);
    
    const userData = {
        Username: username,
        Pool: userPool
    };
    
    cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    
    cognitoUser.authenticateUser(authenticationDetails, {
        onSuccess: (result) => {
            console.log('Authentication successful');
            showAlert('Inicio de sesión exitoso', 'success');
            closeModal();
            showLogoutButton();
            showWelcomeMessage(username);
        },
        onFailure: (err) => {
            console.log('Authentication failed:', err);
            showAlert('Error al iniciar sesión: ' + err.message, 'danger');
        }
    });
}

// Sign out user
function signOut() {
    if (cognitoUser) {
        cognitoUser.signOut();
        showLoginButton();
        hideWelcomeMessage();
        showAlert('Sesión cerrada exitosamente', 'success');
    }
}

// UI Helper Functions
function showLoginButton() {
    document.getElementById('loginBtn').classList.remove('d-none');
    document.getElementById('logoutBtn').classList.add('d-none');
}

function showLogoutButton() {
    document.getElementById('loginBtn').classList.add('d-none');
    document.getElementById('logoutBtn').classList.remove('d-none');
}

function showWelcomeMessage(username) {
    // Create or update welcome message
    let welcomeMsg = document.getElementById('welcomeMessage');
    if (!welcomeMsg) {
        welcomeMsg = document.createElement('div');
        welcomeMsg.id = 'welcomeMessage';
        welcomeMsg.className = 'alert alert-success position-fixed top-0 end-0 m-3';
        welcomeMsg.style.zIndex = '9999';
        document.body.appendChild(welcomeMsg);
    }
    welcomeMsg.innerHTML = `¡Bienvenido, ${username}! <button type="button" class="btn-close" onclick="hideWelcomeMessage()"></button>`;
    welcomeMsg.classList.remove('d-none');
    
    // Auto hide after 5 seconds
    setTimeout(() => {
        hideWelcomeMessage();
    }, 5000);
}

function hideWelcomeMessage() {
    const welcomeMsg = document.getElementById('welcomeMessage');
    if (welcomeMsg) {
        welcomeMsg.classList.add('d-none');
    }
}

function showAlert(message, type) {
    // Remove existing alerts
    const existingAlerts = document.querySelectorAll('.temp-alert');
    existingAlerts.forEach(alert => alert.remove());
    
    const alert = document.createElement('div');
    alert.className = `alert alert-${type} temp-alert position-fixed top-0 start-50 translate-middle-x mt-5`;
    alert.style.zIndex = '9999';
    alert.innerHTML = `${message} <button type="button" class="btn-close" onclick="this.parentElement.remove()"></button>`;
    
    document.body.appendChild(alert);
    
    // Auto remove after 5 seconds
    setTimeout(() => {
        if (alert.parentElement) {
            alert.remove();
        }
    }, 5000);
}

function toggleForm() {
    const loginForm = document.getElementById('loginForm');
    const signupForm = document.getElementById('signupForm');
    const toggleText = document.getElementById('toggleText');
    
    if (loginForm.classList.contains('d-none')) {
        // Show login form
        loginForm.classList.remove('d-none');
        signupForm.classList.add('d-none');
        toggleText.textContent = '¿No tienes cuenta? Regístrate';
    } else {
        // Show signup form
        loginForm.classList.add('d-none');
        signupForm.classList.remove('d-none');
        toggleText.textContent = '¿Ya tienes cuenta? Inicia sesión';
    }
}

function closeModal() {
    const modal = bootstrap.Modal.getInstance(document.getElementById('loginModal'));
    if (modal) {
        modal.hide();
    }
}

// Event Listeners
document.addEventListener('DOMContentLoaded', function() {
    // Initialize Cognito if config is available
    initializeCognito();
    
    // Login button event
    document.getElementById('loginBtn').addEventListener('click', function() {
        const modal = new bootstrap.Modal(document.getElementById('loginModal'));
        modal.show();
    });
    
    // Logout button event
    document.getElementById('logoutBtn').addEventListener('click', signOut);
    
    // Enter key support for forms
    document.getElementById('password').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            signIn();
        }
    });
    
    document.getElementById('newPassword').addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            signUp();
        }
    });
    
    // Smooth scrolling for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Function to update Cognito config (will be called after deployment)
function updateCognitoConfig(userPoolId, clientId) {
    cognitoConfig.userPoolId = userPoolId;
    cognitoConfig.clientId = clientId;
    initializeCognito();
}
