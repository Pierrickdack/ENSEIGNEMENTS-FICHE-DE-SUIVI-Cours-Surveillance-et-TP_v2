@section('contenu')
    <nav class="navbar navbar-expand-lg main-navbar sticky">
        <div class="form-inline mr-auto">
            <ul class="navbar-nav mr-3">
                <li>
                    <a href="#" data-toggle="sidebar" class="nav-link nav-link-lg collapse-btn">
                        <i data-feather="align-justify"></i>
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link nav-link-lg fullscreen-btn">
                        <i data-feather="maximize"></i>
                    </a>
                </li>
                <li>
                    <form class="form-inline mr-auto">
                        <div class="search-element">
                            <input class="form-control" type="search" placeholder="Search" aria-label="Search" data-width="200">
                            <button class="btn" type="submit">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </form>
                </li>
            </ul>
        </div>
        <ul class="navbar-nav navbar-right">
            <li class="dropdown dropdown-list-toggle">
                <a href="#" data-toggle="dropdown" class="nav-link nav-link-lg message-toggle">
                    <i data-feather="mail"></i>
                    <span class="badge headerBadge1">

                    </span>
                </a>
                <div class="dropdown-menu dropdown-list dropdown-menu-right pullDown">
                    <div class="dropdown-header">
                        Messages
                        <div class="float-right">
                            <a href="#">Mark All As Read</a>
                        </div>
                    </div>
                <div class="dropdown-list-content dropdown-list-message">

                </div>
                <div class="dropdown-footer text-center">
                    <a href="#">View All <i class="fas fa-chevron-right"></i></a>
                </div>
                </div>
            </li>
            <li class="dropdown dropdown-list-toggle"><a href="#" data-toggle="dropdown"
                class="nav-link notification-toggle nav-link-lg"><i data-feather="bell" class="bell"></i>
                </a>
                <div class="dropdown-menu dropdown-list dropdown-menu-right pullDown">
                <div class="dropdown-header">
                    Notifications
                    <div class="float-right">
                    <a href="#">Mark All As Read</a>
                    </div>
                </div>


                <div class="dropdown-footer text-center">
                    <a href="#">View All <i class="fas fa-chevron-right"></i></a>
                </div>
                </div>
            </li>
            <li class="dropdown">
                <a href="#" data-toggle="dropdown" class="nav-link dropdown-toggle nav-link-lg nav-link-user">
                    <img alt="image" src="{{ asset('asset/Images/prof.png') }}" >
                    <span class="d-sm-none d-lg-inline-block"></span>
                </a>
                <div class="dropdown-menu dropdown-menu-right pullDown">
                    <div class="dropdown-title">Hello</div>
                    <a href="profile.html" class="dropdown-item has-icon">
                        <i class="far fa-user"></i>
                        Profile
                    </a>
                    <a href="timeline.html" class="dropdown-item has-icon">
                        <i class="fas fa-bolt"></i>
                        Activities
                    </a>
                    <a href="#" class="dropdown-item has-icon">
                        <i class="fas fa-cog"></i>
                        Settings
                    </a>
                    <div class="dropdown-divider"></div>
                    <a href="#" class="dropdown-item has-icon text-danger" onclick="event.preventDefault(); document.getElementById('logout-form').submit();">
                        <i class="fas fa-sign-out-alt"></i>
                        Logout
                    </a>
                    <form id="logout-form" action="{{ route('enseignant.logout') }}" method="POST" style="display: none;">
                        @csrf
                    </form>

                </div>
            </li>
        </ul>
    </nav>
@endsection
