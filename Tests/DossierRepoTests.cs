﻿using MRGSP.ASMS.Core.Model;
using MRGSP.ASMS.Data;
using NUnit.Framework;

namespace MRGSP.ASMS.Tests
{
    [TestFixture]
    public class DbUtilTestses : BaseRepoTests
    {
        [Test]
        public void CountWhereTest()
        {
            DbUtil.CountWhere<District>(new {Name = "Ialoveni"}, new ConnectionFactory().GetConnectionString());
        }
    }

    [TestFixture]
    public class DossierRepoTests : BaseRepoTests
    {
        readonly DossierRepo repo = new DossierRepo(new ConnectionFactory());

        [Test]
        public void Insert()
        {
            var d = new Dossier { AdminFirstName = "athene", HasContract = true };
            
            var id = repo.Insert(d);
            var dos = repo.Get(id);

            dos.AdminFirstName.IsEqualTo(d.AdminFirstName);
            dos.HasContract.IsEqualTo(true);
        }
    }
}