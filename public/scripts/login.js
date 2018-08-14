const userInfo = document.getElementById('user-info');

const backHandler = () => {
    userInfo.innerHTML =
        `<div id="user-modal-header" class="modal-header">
          <h5 class="modal-title" id="loginModalLabel">Log In</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <form class="login-form" action="/" method="post">
                <span>
                  Username: <input type="text" name="username" placeholder="Enter your username"/>
                </span>
                <span>
                  Password: <input type="password" name="password" placeholder="Enter your password"/>
                </span>
                <input class="btn btn-primary user-info-btn" type="submit" value="Log In">
            </form>
        </div>
        <div class="modal-footer">
          <button id="forgot-btn" type="button" class="btn btn-info" data-dismiss="modal">Forgot username / password</button>
          or
          <button onclick="signupHandler()" id="signup-btn" type="button" class="btn btn-info">Sign up</button>
        </div>`;
};

const signupHandler = () => {
    userInfo.innerHTML =
        `<div id="user-modal-header" class="modal-header">
          <button class="btn btn-secondary" onclick='backHandler()'><i class="fas fa-chevron-left"></i></button>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
         <form class="login-form" action="/signup" method="post">
            <input type="text" name="email" placeholder="Email"/>
            <input type="password" name="password" placeholder="Password"/>
            <input type="password" name="reenter_password" placeholder="Re-enter your password"/>
            <input type="text" name="firstname" placeholder="First name"/>
            <input type="text" name="lastname" placeholder="Last name"/>
            <input type="text" name="birthday" placeholder="Birthday MM-DD-YYYY"/>
            <input class="btn btn-primary user-info-btn" type="submit" value="Sign up">
          </form>
        </div>`;
};