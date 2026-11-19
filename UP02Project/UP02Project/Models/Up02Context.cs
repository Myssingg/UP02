using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace UP02Project.Models;

public partial class Up02Context : DbContext
{
    public Up02Context()
    {
    }

    public Up02Context(DbContextOptions<Up02Context> options)
        : base(options)
    {
    }

    public virtual DbSet<City> Cities { get; set; }

    public virtual DbSet<Manufacturer> Manufacturers { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderStatus> OrderStatuses { get; set; }

    public virtual DbSet<PickupPoint> PickupPoints { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductCategory> ProductCategories { get; set; }

    public virtual DbSet<ProductsInOrder> ProductsInOrders { get; set; }

    public virtual DbSet<Role> Roles { get; set; }

    public virtual DbSet<Street> Streets { get; set; }

    public virtual DbSet<Supplier> Suppliers { get; set; }

    public virtual DbSet<UnitsOfMeansurement> UnitsOfMeansurements { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=UP02;Username=postgres;Password=postgres");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<City>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Cities_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.CityName)
                .HasColumnType("character varying")
                .HasColumnName("cityName");
        });

        modelBuilder.Entity<Manufacturer>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Manufacturers_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.ManufacturerName)
                .HasColumnType("character varying")
                .HasColumnName("manufacturerName");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Orders_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.CodeForObtaining).HasColumnName("codeForObtaining");
            entity.Property(e => e.DateOrder).HasColumnName("dateOrder");
            entity.Property(e => e.DeliveryDate).HasColumnName("deliveryDate");
            entity.Property(e => e.OrderStatusId).HasColumnName("orderStatusId");
            entity.Property(e => e.PickupPointId).HasColumnName("pickupPointId");
            entity.Property(e => e.UserId).HasColumnName("userId");

            entity.HasOne(d => d.OrderStatus).WithMany(p => p.Orders)
                .HasForeignKey(d => d.OrderStatusId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Orders_orderStatusId_fkey");

            entity.HasOne(d => d.PickupPoint).WithMany(p => p.Orders)
                .HasForeignKey(d => d.PickupPointId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Orders_pickupPointId_fkey");

            entity.HasOne(d => d.User).WithMany(p => p.Orders)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Orders_userId_fkey");
        });

        modelBuilder.Entity<OrderStatus>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("OrderStatuses_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.StatusName)
                .HasColumnType("character varying")
                .HasColumnName("statusName");
        });

        modelBuilder.Entity<PickupPoint>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PickupPoints_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.CityId).HasColumnName("cityId");
            entity.Property(e => e.HouseNumber)
                .HasMaxLength(5)
                .HasColumnName("houseNumber");
            entity.Property(e => e.Index)
                .HasMaxLength(6)
                .HasColumnName("index");
            entity.Property(e => e.StreetId).HasColumnName("streetId");

            entity.HasOne(d => d.City).WithMany(p => p.PickupPoints)
                .HasForeignKey(d => d.CityId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PickupPoints_cityId_fkey");

            entity.HasOne(d => d.Street).WithMany(p => p.PickupPoints)
                .HasForeignKey(d => d.StreetId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("PickupPoints_streetId_fkey");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Products_pkey");

            entity.Property(e => e.Id)
                .HasMaxLength(10)
                .HasColumnName("id");
            entity.Property(e => e.CategoryId).HasColumnName("categoryId");
            entity.Property(e => e.Description)
                .HasColumnType("character varying")
                .HasColumnName("description");
            entity.Property(e => e.Discount).HasColumnName("discount");
            entity.Property(e => e.ManufacturerId).HasColumnName("manufacturerId");
            entity.Property(e => e.PictureName)
                .HasColumnType("character varying")
                .HasColumnName("pictureName");
            entity.Property(e => e.Price).HasColumnName("price");
            entity.Property(e => e.ProductName)
                .HasColumnType("character varying")
                .HasColumnName("productName");
            entity.Property(e => e.Stock).HasColumnName("stock");
            entity.Property(e => e.SupplierId).HasColumnName("supplierId");
            entity.Property(e => e.UnitOfMeansurementId).HasColumnName("unitOfMeansurementId");

            entity.HasOne(d => d.Category).WithMany(p => p.Products)
                .HasForeignKey(d => d.CategoryId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Products_categoryId_fkey");

            entity.HasOne(d => d.Manufacturer).WithMany(p => p.Products)
                .HasForeignKey(d => d.ManufacturerId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Products_manufacturerId_fkey");

            entity.HasOne(d => d.Supplier).WithMany(p => p.Products)
                .HasForeignKey(d => d.SupplierId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Products_supplierId_fkey");

            entity.HasOne(d => d.UnitOfMeansurement).WithMany(p => p.Products)
                .HasForeignKey(d => d.UnitOfMeansurementId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Products_unitOfMeansurementId_fkey");
        });

        modelBuilder.Entity<ProductCategory>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("ProductCategories_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.CategoryName)
                .HasColumnType("character varying")
                .HasColumnName("categoryName");
        });

        modelBuilder.Entity<ProductsInOrder>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("ProductsInOrders_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.Count).HasColumnName("count");
            entity.Property(e => e.OrderId).HasColumnName("orderId");
            entity.Property(e => e.ProductId)
                .HasMaxLength(10)
                .HasColumnName("productId");

            entity.HasOne(d => d.Order).WithMany(p => p.ProductsInOrders)
                .HasForeignKey(d => d.OrderId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ProductsInOrders_orderId_fkey");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductsInOrders)
                .HasForeignKey(d => d.ProductId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("ProductsInOrders_productId_fkey");
        });

        modelBuilder.Entity<Role>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Roles_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.RoleName)
                .HasColumnType("character varying")
                .HasColumnName("roleName");
        });

        modelBuilder.Entity<Street>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Streets_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.StreetName)
                .HasColumnType("character varying")
                .HasColumnName("streetName");
        });

        modelBuilder.Entity<Supplier>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Suppliers_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.SupplierName)
                .HasColumnType("character varying")
                .HasColumnName("supplierName");
        });

        modelBuilder.Entity<UnitsOfMeansurement>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("UnitsOfMeansurement_pkey");

            entity.ToTable("UnitsOfMeansurement");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.Name)
                .HasColumnType("character varying")
                .HasColumnName("name");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("Users_pkey");

            entity.Property(e => e.Id)
                .UseIdentityAlwaysColumn()
                .HasColumnName("id");
            entity.Property(e => e.Fio)
                .HasColumnType("character varying")
                .HasColumnName("FIO");
            entity.Property(e => e.Login)
                .HasColumnType("character varying")
                .HasColumnName("login");
            entity.Property(e => e.Password)
                .HasColumnType("character varying")
                .HasColumnName("password");
            entity.Property(e => e.RoleId).HasColumnName("roleId");

            entity.HasOne(d => d.Role).WithMany(p => p.Users)
                .HasForeignKey(d => d.RoleId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("Users_roleId_fkey");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
