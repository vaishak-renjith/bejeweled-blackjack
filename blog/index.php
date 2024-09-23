<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Blog</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header>
        <div class="container">
            <h1><a href="index.php">My Blog</a></h1>
            <nav>
                <ul>
                    <li><a href="#about">About</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="content-container">
        <main>
            <div class="container">
                <article>
                    <h2>Blog Post Title</h2>
                    <p class="meta">Posted on June 18, 2024 by Author</p>
                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam...</p>
                    <a href="/blog/post.php">Read more</a>
                </article>
                <article>
                    <h2>Another Blog Post</h2>
                    <p class="meta">Posted on June 17, 2024 by Author</p>
                    <p>Quis ipsum suspendisse ultrices gravida. Risus commodo viverra maecenas accumsan lacus vel facilisis...</p>
                    <a href="/blog/post.php">Read more</a>
                </article>
            </div>
        </main>

        <aside class="sidebar">
            <?php include 'sidebar.html'; ?> <!-- Include sidebar.php content here -->
        </aside>
    </div>
</body>
</html>
