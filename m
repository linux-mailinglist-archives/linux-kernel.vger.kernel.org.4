Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A8265A359
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiLaJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:23:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C090465B6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:23:19 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id g14so24282490ljh.10
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0R4kDWmGk1BegqtgUS7T9rZ6G6DpZfH2m/jdZtZGGs=;
        b=X3mUAFTkKsAOQJF85Qz2f1tHmb1PbZS2a9QZIn+U0wJEZTD4FiFwCJ0UIvrJ2EjrlW
         ybHVJdV75vvuKVnB1txkVh6oD8qbMyfvPPurEET+kAA5tsU4e8P3DjrUKk8ER8fDksc7
         u0HeGSykzXCjZwJUTsHCZCT6RZ/kpqrIwtXKobtkEOehcqdfnyX2iWlP/KG8kWHlCrfj
         GRBqrfiil8M8KG/cQQKsuSuQ1ITZRtL1hql47DKWVHU90LNmfkwFN2mjUahm+77UVvVz
         h05hQfkjP1zKhaJfqDTf51lEmX/DUrEgAgTCdGZNznUnheiBFWLEbrj9jSINwyeAvU0V
         N53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0R4kDWmGk1BegqtgUS7T9rZ6G6DpZfH2m/jdZtZGGs=;
        b=xzhks302xSRKR0pDfgnxPNGI6cNYTWvWYiFsJ08//PbDzTM2/URiIsBBMG9eRiV6Em
         MgEtZ05xVhEnls3OYkMXujJPWipRW8UWaygOWuqki7h526ln/cgu4P0Ov32sPHv7HfzT
         NV3tVraD/M22EFkpAsxRF6PDEmcN/HFwHQWXAOPLQ29T7INwvcMkTaniKp1gSFLsK9nC
         gV6l3Y2WIDWK89sv6PVi+VLJJeUHBMFSB7eKMcvkH+Is4fMjjUvKBUWkdmI6WL0hO2/N
         UNfzniHnmj7G9IqgIltb+bt0u9cMj1yWAtapG3k7bEH5i0pqUsb83UG/X5tDOCvCnnOJ
         o/xA==
X-Gm-Message-State: AFqh2kq7J0aYjQyvLxFgnGXJOlwbKRHDnemFCaKLl3yTXzfqJXY3EiMR
        IVVHREtK1qNpppi3yBcwmRZ3tza2b0r7s2Wiw+A=
X-Google-Smtp-Source: AMrXdXt52K1+3ysHBfOQAU5l4Kx0ngN9e4/J8tE0qVQSagTFut6Sp2Nz5FS1997r8HYBrp9phJ+p8B00YT6fNKmUds0=
X-Received: by 2002:a2e:8059:0:b0:27f:c047:62b7 with SMTP id
 p25-20020a2e8059000000b0027fc04762b7mr761189ljg.346.1672478597839; Sat, 31
 Dec 2022 01:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
 <202212311612.EwRjxghc-lkp@intel.com> <CALQpDLeQOrwsO5EjS5Q1Cy7DadNGqB966jkJvCTfsvqgZc=gZw@mail.gmail.com>
In-Reply-To: <CALQpDLeQOrwsO5EjS5Q1Cy7DadNGqB966jkJvCTfsvqgZc=gZw@mail.gmail.com>
From:   Yoochan Lee <yoochan1026@gmail.com>
Date:   Sat, 31 Dec 2022 18:23:06 +0900
Message-ID: <CALQpDLcaygYqVqx-JKGaw=FLBmaKexM0S=4CCC2wHGq77RHBjg@mail.gmail.com>
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
To:     kernel test robot <lkp@intel.com>
Cc:     matt.hsiao@hpe.com, oe-kbuild-all@lists.linux.dev, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I missed the error in my patches.

Here is fixed version of patches.

From 8e0501f6c9dd3925cacbb5fdc74548daf276fb04 Mon Sep 17 00:00:00 2001
From: Yoochan Lee <yoochan1026@gmail.com>
Date: Sat, 31 Dec 2022 18:22:23 +0900
Subject: [PATCH 2/2] fix error in previous patches

---
 drivers/misc/hpilo.c | 68 ++++++++++++++++++++++++--------------------
 drivers/misc/hpilo.h |  1 +
 2 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index b4a99676a642..d6691cbedb25 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -37,6 +37,7 @@ static const struct pci_device_id ilo_blacklist[] =3D {
  {}
 };

+static void ilo_delete(struct kref *kref);
 static inline int get_entry_id(int entry)
 {
  return (entry & ENTRY_MASK_DESCRIPTOR) >> ENTRY_BITPOS_DESCRIPTOR;
@@ -532,34 +533,6 @@ static __poll_t ilo_poll(struct file *fp, poll_table *=
wait)
  return 0;
 }

-static void ilo_delete(struct kref *kref)
-{
- struct ilo_hwinfo *ilo_hw =3D container_of(kref, struct ilo_hwinfo, refcn=
t);
-
- clear_device(ilo_hw);
-
- minor =3D MINOR(ilo_hw->cdev.dev);
- for (i =3D minor; i < minor + max_ccb; i++)
- device_destroy(ilo_class, MKDEV(ilo_major, i));
-
- cdev_del(&ilo_hw->cdev);
- ilo_disable_interrupts(ilo_hw);
- free_irq(pdev->irq, ilo_hw);
- ilo_unmap_device(pdev, ilo_hw);
- pci_release_regions(pdev);
- /*
- * pci_disable_device(pdev) used to be here. But this PCI device has
- * two functions with interrupt lines connected to a single pin. The
- * other one is a USB host controller. So when we disable the PIN here
- * e.g. by rmmod hpilo, the controller stops working. It is because
- * the interrupt link is disabled in ACPI since it is not refcounted
- * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
- */
- kfree(ilo_hw);
- ilo_hwdev[(minor / max_ccb)] =3D 0;
-
-}
-
 static int ilo_close(struct inode *ip, struct file *fp)
 {
  int slot;
@@ -719,6 +692,39 @@ static void ilo_unmap_device(struct pci_dev
*pdev, struct ilo_hwinfo *hw)
  pci_iounmap(pdev, hw->mmio_vaddr);
 }

+static void ilo_delete(struct kref *kref)
+{
+ int i, minor;
+ struct ilo_hwinfo *ilo_hw =3D container_of(kref, struct ilo_hwinfo, refcn=
t);
+ struct pci_dev *pdev =3D ilo_hw->pdev;
+
+ if(!ilo_hw)
+ return;
+
+ clear_device(ilo_hw);
+
+ minor =3D MINOR(ilo_hw->cdev.dev);
+ for (i =3D minor; i < minor + max_ccb; i++)
+ device_destroy(ilo_class, MKDEV(ilo_major, i));
+
+ cdev_del(&ilo_hw->cdev);
+ ilo_disable_interrupts(ilo_hw);
+ free_irq(pdev->irq, ilo_hw);
+ ilo_unmap_device(pdev, ilo_hw);
+ pci_release_regions(pdev);
+ /*
+ * pci_disable_device(pdev) used to be here. But this PCI device has
+ * two functions with interrupt lines connected to a single pin. The
+ * other one is a USB host controller. So when we disable the PIN here
+ * e.g. by rmmod hpilo, the controller stops working. It is because
+ * the interrupt link is disabled in ACPI since it is not refcounted
+ * yet. See acpi_pci_link_free_irq called from acpi_pci_irq_disable.
+ */
+ kfree(ilo_hw);
+ ilo_hwdev[(minor / max_ccb)] =3D 0;
+
+}
+
 static int ilo_map_device(struct pci_dev *pdev, struct ilo_hwinfo *hw)
 {
  int bar;
@@ -772,13 +778,12 @@ static int ilo_map_device(struct pci_dev *pdev,
struct ilo_hwinfo *hw)

 static void ilo_remove(struct pci_dev *pdev)
 {
- int i, minor;
  struct ilo_hwinfo *ilo_hw =3D pci_get_drvdata(pdev);

  if (!ilo_hw)
  return;

- kref_put(&hw->refcnt, ilo_delete);
+ kref_put(&ilo_hw->refcnt, ilo_delete);
 }

 static int ilo_probe(struct pci_dev *pdev,
@@ -820,7 +825,8 @@ static int ilo_probe(struct pci_dev *pdev,
  spin_lock_init(&ilo_hw->alloc_lock);
  spin_lock_init(&ilo_hw->fifo_lock);
  spin_lock_init(&ilo_hw->open_lock);
- kref_init(&iol_hw->refcnt);
+ kref_init(&ilo_hw->refcnt);
+ ilo_hw->pdev =3D pdev;

  error =3D pci_enable_device(pdev);
  if (error)
diff --git a/drivers/misc/hpilo.h b/drivers/misc/hpilo.h
index ebc677eb45ae..f8a857fb93eb 100644
--- a/drivers/misc/hpilo.h
+++ b/drivers/misc/hpilo.h
@@ -62,6 +62,7 @@ struct ilo_hwinfo {
  spinlock_t fifo_lock;

  struct cdev cdev;
+ struct pci_dev *pdev;
  struct kref refcnt;
 };

--
2.39.0

2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:56, =
Yoochan Lee <yoochan1026@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, there is some typos in my patch.
>
> Therefore, here are additional patches.
>
> diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
> index b4a99676a642..ea5bfbb231bd 100644
> --- a/drivers/misc/hpilo.c
> +++ b/drivers/misc/hpilo.c
> @@ -778,7 +778,7 @@ static void ilo_remove(struct pci_dev *pdev)
>         if (!ilo_hw)
>                 return;
>
> -       kref_put(&hw->refcnt, ilo_delete);
> +       kref_put(&ilo_hw->refcnt, ilo_delete);
>  }
>
>  static int ilo_probe(struct pci_dev *pdev,
> @@ -820,7 +820,7 @@ static int ilo_probe(struct pci_dev *pdev,
>         spin_lock_init(&ilo_hw->alloc_lock);
>         spin_lock_init(&ilo_hw->fifo_lock);
>         spin_lock_init(&ilo_hw->open_lock);
> -       kref_init(&iol_hw->refcnt);
> +       kref_init(&ilo_hw->refcnt);
>
>         error =3D pci_enable_device(pdev);
>         if (error)
>
> Sincerely,
> Yoocahn
>
>
> 2022=EB=85=84 12=EC=9B=94 31=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 5:51=
, kernel test robot <lkp@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Hi Yoochan,
> >
> > Thank you for the patch! Perhaps something to improve:
> >
> > [auto build test WARNING on char-misc/char-misc-testing]
> > [also build test WARNING on char-misc/char-misc-next char-misc/char-mis=
c-linus soc/for-next linus/master v6.2-rc1 next-20221226]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Yoochan-Lee/misc=
-hpilo-Fix-use-after-free-in-ilo_open/20221231-135458
> > patch link:    https://lore.kernel.org/r/20221231055310.2040648-1-yooch=
an1026%40gmail.com
> > patch subject: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
> > config: x86_64-rhel-8.3-bpf
> > compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> > reproduce (this is a W=3D1 build):
> >         # https://github.com/intel-lab-lkp/linux/commit/aca13e7e71e5c2b=
68742270a834fd67929850ef9
> >         git remote add linux-review https://github.com/intel-lab-lkp/li=
nux
> >         git fetch --no-tags linux-review Yoochan-Lee/misc-hpilo-Fix-use=
-after-free-in-ilo_open/20221231-135458
> >         git checkout aca13e7e71e5c2b68742270a834fd67929850ef9
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 olddefconfig
> >         make W=3D1 O=3Dbuild_dir ARCH=3Dx86_64 SHELL=3D/bin/bash driver=
s/misc/
> >
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/misc/hpilo.c: In function 'ilo_delete':
> >    drivers/misc/hpilo.c:541:9: error: 'minor' undeclared (first use in =
this function); did you mean 'iminor'?
> >      541 |         minor =3D MINOR(ilo_hw->cdev.dev);
> >          |         ^~~~~
> >          |         iminor
> >    drivers/misc/hpilo.c:541:9: note: each undeclared identifier is repo=
rted only once for each function it appears in
> >    drivers/misc/hpilo.c:542:14: error: 'i' undeclared (first use in thi=
s function)
> >      542 |         for (i =3D minor; i < minor + max_ccb; i++)
> >          |              ^
> >    drivers/misc/hpilo.c:547:18: error: 'pdev' undeclared (first use in =
this function); did you mean 'cdev'?
> >      547 |         free_irq(pdev->irq, ilo_hw);
> >          |                  ^~~~
> >          |                  cdev
> >    drivers/misc/hpilo.c:548:9: error: implicit declaration of function =
'ilo_unmap_device' [-Werror=3Dimplicit-function-declaration]
> >      548 |         ilo_unmap_device(pdev, ilo_hw);
> >          |         ^~~~~~~~~~~~~~~~
> >    drivers/misc/hpilo.c: At top level:
> >    drivers/misc/hpilo.c:715:13: warning: conflicting types for 'ilo_unm=
ap_device'; have 'void(struct pci_dev *, struct ilo_hwinfo *)'
> >      715 | static void ilo_unmap_device(struct pci_dev *pdev, struct il=
o_hwinfo *hw)
> >          |             ^~~~~~~~~~~~~~~~
> >    drivers/misc/hpilo.c:715:13: error: static declaration of 'ilo_unmap=
_device' follows non-static declaration
> >    drivers/misc/hpilo.c:548:9: note: previous implicit declaration of '=
ilo_unmap_device' with type 'void(struct pci_dev *, struct ilo_hwinfo *)'
> >      548 |         ilo_unmap_device(pdev, ilo_hw);
> >          |         ^~~~~~~~~~~~~~~~
> >    drivers/misc/hpilo.c: In function 'ilo_remove':
> >    drivers/misc/hpilo.c:781:19: error: 'hw' undeclared (first use in th=
is function)
> >      781 |         kref_put(&hw->refcnt, ilo_delete);
> >          |                   ^~
> > >> drivers/misc/hpilo.c:775:16: warning: unused variable 'minor' [-Wunu=
sed-variable]
> >      775 |         int i, minor;
> >          |                ^~~~~
> > >> drivers/misc/hpilo.c:775:13: warning: unused variable 'i' [-Wunused-=
variable]
> >      775 |         int i, minor;
> >          |             ^
> >    drivers/misc/hpilo.c: In function 'ilo_probe':
> >    drivers/misc/hpilo.c:823:20: error: 'iol_hw' undeclared (first use i=
n this function); did you mean 'ilo_hw'?
> >      823 |         kref_init(&iol_hw->refcnt);
> >          |                    ^~~~~~
> >          |                    ilo_hw
> >    cc1: some warnings being treated as errors
> >
> >
> > vim +/minor +775 drivers/misc/hpilo.c
> >
> > 9f7048412163d8 David Altobelli 2009-08-17  714
> > 89bcb05d9bbf8b David Altobelli 2008-07-02 @715  static void ilo_unmap_d=
evice(struct pci_dev *pdev, struct ilo_hwinfo *hw)
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  716  {
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  717          pci_iounmap(pde=
v, hw->db_vaddr);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  718          pci_iounmap(pde=
v, hw->ram_vaddr);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  719          pci_iounmap(pde=
v, hw->mmio_vaddr);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  720  }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  721
> > 80c8ae28926652 Bill Pemberton  2012-11-19  722  static int ilo_map_devi=
ce(struct pci_dev *pdev, struct ilo_hwinfo *hw)
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  723  {
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  724          int bar;
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  725          unsigned long o=
ff;
> > 23d51b81815127 Matt Hsiao      2021-05-31  726          u8 pci_rev_id;
> > 23d51b81815127 Matt Hsiao      2021-05-31  727          int rc;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  728
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  729          /* map the memo=
ry mapped i/o registers */
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  730          hw->mmio_vaddr =
=3D pci_iomap(pdev, 1, 0);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  731          if (hw->mmio_va=
ddr =3D=3D NULL) {
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  732                  dev_err=
(&pdev->dev, "Error mapping mmio\n");
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  733                  goto ou=
t;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  734          }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  735
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  736          /* map the adap=
ter shared memory region */
> > 23d51b81815127 Matt Hsiao      2021-05-31  737          rc =3D pci_read=
_config_byte(pdev, PCI_REVISION_ID, &pci_rev_id);
> > 23d51b81815127 Matt Hsiao      2021-05-31  738          if (rc !=3D 0) =
{
> > 23d51b81815127 Matt Hsiao      2021-05-31  739                  dev_err=
(&pdev->dev, "Error reading PCI rev id: %d\n", rc);
> > 23d51b81815127 Matt Hsiao      2021-05-31  740                  goto ou=
t;
> > 23d51b81815127 Matt Hsiao      2021-05-31  741          }
> > 23d51b81815127 Matt Hsiao      2021-05-31  742
> > 23d51b81815127 Matt Hsiao      2021-05-31  743          if (pci_rev_id =
>=3D PCI_REV_ID_NECHES) {
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  744                  bar =3D=
 5;
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  745                  /* Last=
 8k is reserved for CCBs */
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  746                  off =3D=
 pci_resource_len(pdev, bar) - 0x2000;
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  747          } else {
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  748                  bar =3D=
 2;
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  749                  off =3D=
 0;
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  750          }
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  751          hw->ram_vaddr =
=3D pci_iomap_range(pdev, bar, off, max_ccb * ILOHW_CCB_SZ);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  752          if (hw->ram_vad=
dr =3D=3D NULL) {
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  753                  dev_err=
(&pdev->dev, "Error mapping shared mem\n");
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  754                  goto mm=
io_free;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  755          }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  756
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  757          /* map the door=
bell aperture */
> > 98dcd59dd063dd Camuso, Tony    2012-06-10  758          hw->db_vaddr =
=3D pci_iomap(pdev, 3, max_ccb * ONE_DB_SIZE);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  759          if (hw->db_vadd=
r =3D=3D NULL) {
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  760                  dev_err=
(&pdev->dev, "Error mapping doorbell\n");
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  761                  goto ra=
m_free;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  762          }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  763
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  764          return 0;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  765  ram_free:
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  766          pci_iounmap(pde=
v, hw->ram_vaddr);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  767  mmio_free:
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  768          pci_iounmap(pde=
v, hw->mmio_vaddr);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  769  out:
> > c9fef1cc3dd367 Rusk, Mark      2016-09-19  770          return -ENOMEM;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  771  }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  772
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  773  static void ilo_remove(=
struct pci_dev *pdev)
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  774  {
> > 89bcb05d9bbf8b David Altobelli 2008-07-02 @775          int i, minor;
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  776          struct ilo_hwin=
fo *ilo_hw =3D pci_get_drvdata(pdev);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  777
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06  778          if (!ilo_hw)
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06  779                  return;
> > ebf1b764aa5cb3 Mark Rusk       2012-11-06  780
> > aca13e7e71e5c2 Yoochan Lee     2022-12-31 @781          kref_put(&hw->r=
efcnt, ilo_delete);
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  782  }
> > 89bcb05d9bbf8b David Altobelli 2008-07-02  783
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://01.org/lkp
