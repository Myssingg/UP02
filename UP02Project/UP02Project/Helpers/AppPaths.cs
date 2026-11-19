using System.IO;

namespace UP02Project.Helpers
{
    /// <summary>
    /// Путь к папке с изображениями товаров (папка Images в каталоге проекта).
    /// </summary>
    public static class AppPaths
    {
        public static string ImagesDirectory =>
            Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, @"..\..\..\Images"));

        public static string DefaultPictureName => "picture.png";

        public static string DefaultPicturePath => Path.Combine(ImagesDirectory, DefaultPictureName);
    }
}
