Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FD8700FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbjELUsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238806AbjELUrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:47:52 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC322109
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:47:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxZfb-0000Nf-4N; Fri, 12 May 2023 22:47:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxZfW-00330j-00; Fri, 12 May 2023 22:47:14 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pxZfU-003q4F-Rd; Fri, 12 May 2023 22:47:12 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Damien Le Moal <dlemoal@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        "open list:LIBATA SUBSYSTEM" <linux-ide@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org
Subject: [PATCH] ata: libata: Make ata_platform_remove_one return void
Date:   Fri, 12 May 2023 22:46:46 +0200
Message-Id: <20230512204646.137746-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12298; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ZAebgA4XtcKRV7cmTHKf6nNGpbfyJQRXa03X0M2rwCE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkXqWzrmzPTTAIn+aY/KQVjXtQ5HFJnplq4hCUv j9lQ1fpNGKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZF6lswAKCRCPgPtYfRL+ Tm2RB/9PjizDLCk27++FYSpdlAP3Xtv2JMB9cshy3ucah0hxgskBEQy4Oy82VhU23ZEkY8MGgkB eijP/KBn/Sej8oHMBAmVKk+w8K699J1mJRAvktpwKTq63Du/2rdCtaZcj+5PVL/oh3n+I2o+CJQ PaM3okqGdL2S8mFwrIrQMs4/8pX8m+VlZvGSKtDqfPbvLcjgfluHCkQVfr1NmsZwVld9lQohFyd HXlgO06XdLSMKcVV5zZDM3TYSVjI+Jxb9ydURUs8rL4B40yR8sf+7/aNCkwuKRPXHjo3VdP37G9 dNvFikSvbOSZB8iLU2wmMLHEhFa7aX78FiUQC97wggMuhjLv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function returned zero unconditionally, so the function returning an
int is something between useless and irritating. With the goal to make
platform drivers' remove function return void, it's helpful to convert
the function accordingly. This converts several drivers to the new
.remove_new callback that was introduced to smoothen the platform driver
conversion.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/ata/ahci_brcm.c        | 6 +++---
 drivers/ata/ahci_ceva.c        | 2 +-
 drivers/ata/ahci_da850.c       | 2 +-
 drivers/ata/ahci_dm816.c       | 2 +-
 drivers/ata/ahci_dwc.c         | 2 +-
 drivers/ata/ahci_imx.c         | 2 +-
 drivers/ata/ahci_mtk.c         | 2 +-
 drivers/ata/ahci_mvebu.c       | 2 +-
 drivers/ata/ahci_platform.c    | 2 +-
 drivers/ata/ahci_qoriq.c       | 2 +-
 drivers/ata/ahci_seattle.c     | 2 +-
 drivers/ata/ahci_st.c          | 2 +-
 drivers/ata/ahci_sunxi.c       | 2 +-
 drivers/ata/ahci_tegra.c       | 2 +-
 drivers/ata/ahci_xgene.c       | 2 +-
 drivers/ata/libata-core.c      | 4 +---
 drivers/ata/pata_ixp4xx_cf.c   | 2 +-
 drivers/ata/pata_of_platform.c | 2 +-
 drivers/ata/pata_platform.c    | 2 +-
 drivers/ata/sata_highbank.c    | 2 +-
 include/linux/libata.h         | 2 +-
 21 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 4e3dc2b6d67f..70c3a33eee6f 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -544,7 +544,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int brcm_ahci_remove(struct platform_device *pdev)
+static void brcm_ahci_remove(struct platform_device *pdev)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);
 	struct ahci_host_priv *hpriv = host->private_data;
@@ -552,7 +552,7 @@ static int brcm_ahci_remove(struct platform_device *pdev)
 
 	brcm_sata_phys_disable(priv);
 
-	return ata_platform_remove_one(pdev);
+	ata_platform_remove_one(pdev);
 }
 
 static void brcm_ahci_shutdown(struct platform_device *pdev)
@@ -573,7 +573,7 @@ static SIMPLE_DEV_PM_OPS(ahci_brcm_pm_ops, brcm_ahci_suspend, brcm_ahci_resume);
 
 static struct platform_driver brcm_ahci_driver = {
 	.probe = brcm_ahci_probe,
-	.remove = brcm_ahci_remove,
+	.remove_new = brcm_ahci_remove,
 	.shutdown = brcm_ahci_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index bc027468decb..c2b6be083af4 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -369,7 +369,7 @@ MODULE_DEVICE_TABLE(of, ceva_ahci_of_match);
 
 static struct platform_driver ceva_ahci_driver = {
 	.probe = ceva_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ceva_ahci_of_match,
diff --git a/drivers/ata/ahci_da850.c b/drivers/ata/ahci_da850.c
index ca0924dc5bd2..55a6627d5450 100644
--- a/drivers/ata/ahci_da850.c
+++ b/drivers/ata/ahci_da850.c
@@ -238,7 +238,7 @@ MODULE_DEVICE_TABLE(of, ahci_da850_of_match);
 
 static struct platform_driver ahci_da850_driver = {
 	.probe = ahci_da850_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_da850_of_match,
diff --git a/drivers/ata/ahci_dm816.c b/drivers/ata/ahci_dm816.c
index b08547b877a1..4cb70064fb99 100644
--- a/drivers/ata/ahci_dm816.c
+++ b/drivers/ata/ahci_dm816.c
@@ -182,7 +182,7 @@ MODULE_DEVICE_TABLE(of, ahci_dm816_of_match);
 
 static struct platform_driver ahci_dm816_driver = {
 	.probe = ahci_dm816_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = AHCI_DM816_DRV_NAME,
 		.of_match_table = ahci_dm816_of_match,
diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index 4bfbb09cdc02..9604a2f6ed48 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -478,7 +478,7 @@ MODULE_DEVICE_TABLE(of, ahci_dwc_of_match);
 
 static struct platform_driver ahci_dwc_driver = {
 	.probe = ahci_dwc_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.shutdown = ahci_platform_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
index 3a8c248e7c0e..9fa005965f3b 100644
--- a/drivers/ata/ahci_imx.c
+++ b/drivers/ata/ahci_imx.c
@@ -1223,7 +1223,7 @@ static SIMPLE_DEV_PM_OPS(ahci_imx_pm_ops, imx_ahci_suspend, imx_ahci_resume);
 
 static struct platform_driver imx_ahci_driver = {
 	.probe = imx_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = imx_ahci_of_match,
diff --git a/drivers/ata/ahci_mtk.c b/drivers/ata/ahci_mtk.c
index 0bf83a297091..5083fb6c4927 100644
--- a/drivers/ata/ahci_mtk.c
+++ b/drivers/ata/ahci_mtk.c
@@ -173,7 +173,7 @@ MODULE_DEVICE_TABLE(of, ahci_of_match);
 
 static struct platform_driver mtk_ahci_driver = {
 	.probe = mtk_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_of_match,
diff --git a/drivers/ata/ahci_mvebu.c b/drivers/ata/ahci_mvebu.c
index 596cf017f427..764501518582 100644
--- a/drivers/ata/ahci_mvebu.c
+++ b/drivers/ata/ahci_mvebu.c
@@ -245,7 +245,7 @@ MODULE_DEVICE_TABLE(of, ahci_mvebu_of_match);
 
 static struct platform_driver ahci_mvebu_driver = {
 	.probe = ahci_mvebu_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.suspend = ahci_mvebu_suspend,
 	.resume = ahci_mvebu_resume,
 	.driver = {
diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index 299ee686ac49..ab30c7138d73 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -96,7 +96,7 @@ MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 
 static struct platform_driver ahci_driver = {
 	.probe = ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.shutdown = ahci_platform_shutdown,
 	.driver = {
 		.name = DRV_NAME,
diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index 0ba764d283c8..3d01b118c9a1 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -359,7 +359,7 @@ static SIMPLE_DEV_PM_OPS(ahci_qoriq_pm_ops, ahci_platform_suspend,
 
 static struct platform_driver ahci_qoriq_driver = {
 	.probe = ahci_qoriq_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_qoriq_of_match,
diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 9eda7bbd2151..2c32d58c6ae7 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -187,7 +187,7 @@ MODULE_DEVICE_TABLE(acpi, ahci_acpi_match);
 
 static struct platform_driver ahci_seattle_driver = {
 	.probe = ahci_seattle_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.acpi_match_table = ahci_acpi_match,
diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index f2c1edb36986..d4a626f87963 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -239,7 +239,7 @@ static struct platform_driver st_ahci_driver = {
 		.of_match_table = st_ahci_match,
 	},
 	.probe = st_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 };
 module_platform_driver(st_ahci_driver);
 
diff --git a/drivers/ata/ahci_sunxi.c b/drivers/ata/ahci_sunxi.c
index 076c12b4ba08..04531fa95e40 100644
--- a/drivers/ata/ahci_sunxi.c
+++ b/drivers/ata/ahci_sunxi.c
@@ -292,7 +292,7 @@ MODULE_DEVICE_TABLE(of, ahci_sunxi_of_match);
 
 static struct platform_driver ahci_sunxi_driver = {
 	.probe = ahci_sunxi_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = ahci_sunxi_of_match,
diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
index 8e5e2b359f2d..21c20793e517 100644
--- a/drivers/ata/ahci_tegra.c
+++ b/drivers/ata/ahci_tegra.c
@@ -609,7 +609,7 @@ static int tegra_ahci_probe(struct platform_device *pdev)
 
 static struct platform_driver tegra_ahci_driver = {
 	.probe = tegra_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = tegra_ahci_of_match,
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 83f5ff54ef5b..eb773f2e28fc 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -868,7 +868,7 @@ static int xgene_ahci_probe(struct platform_device *pdev)
 
 static struct platform_driver xgene_ahci_driver = {
 	.probe = xgene_ahci_probe,
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = xgene_ahci_of_match,
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 8bf612bdd61a..e9fc69fbe06b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -6141,13 +6141,11 @@ EXPORT_SYMBOL_GPL(ata_pci_device_resume);
  *	LOCKING:
  *	Inherited from platform layer (may sleep).
  */
-int ata_platform_remove_one(struct platform_device *pdev)
+void ata_platform_remove_one(struct platform_device *pdev)
 {
 	struct ata_host *host = platform_get_drvdata(pdev);
 
 	ata_host_detach(host);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_platform_remove_one);
 
diff --git a/drivers/ata/pata_ixp4xx_cf.c b/drivers/ata/pata_ixp4xx_cf.c
index 99a2ce723495..b1daa4d3fcd9 100644
--- a/drivers/ata/pata_ixp4xx_cf.c
+++ b/drivers/ata/pata_ixp4xx_cf.c
@@ -303,7 +303,7 @@ static struct platform_driver ixp4xx_pata_platform_driver = {
 		.of_match_table = ixp4xx_pata_of_match,
 	},
 	.probe		= ixp4xx_pata_probe,
-	.remove		= ata_platform_remove_one,
+	.remove_new	= ata_platform_remove_one,
 };
 
 module_platform_driver(ixp4xx_pata_platform_driver);
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 178b28eff170..4956f0f5b93f 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -89,7 +89,7 @@ static struct platform_driver pata_of_platform_driver = {
 		.of_match_table = pata_of_platform_match,
 	},
 	.probe		= pata_of_platform_probe,
-	.remove		= ata_platform_remove_one,
+	.remove_new	= ata_platform_remove_one,
 };
 
 module_platform_driver(pata_of_platform_driver);
diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
index 87479bc893b2..232c3dad7ee8 100644
--- a/drivers/ata/pata_platform.c
+++ b/drivers/ata/pata_platform.c
@@ -223,7 +223,7 @@ static int pata_platform_probe(struct platform_device *pdev)
 
 static struct platform_driver pata_platform_driver = {
 	.probe		= pata_platform_probe,
-	.remove		= ata_platform_remove_one,
+	.remove_new	= ata_platform_remove_one,
 	.driver = {
 		.name		= DRV_NAME,
 	},
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index 8237ece4a46f..d6b324d03e59 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -614,7 +614,7 @@ static SIMPLE_DEV_PM_OPS(ahci_highbank_pm_ops,
 		  ahci_highbank_suspend, ahci_highbank_resume);
 
 static struct platform_driver ahci_highbank_driver = {
-	.remove = ata_platform_remove_one,
+	.remove_new = ata_platform_remove_one,
         .driver = {
                 .name = "highbank-ahci",
                 .of_match_table = ahci_of_match,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 311cd93377c7..01f9fbb69f89 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1276,7 +1276,7 @@ extern int ata_pci_device_resume(struct pci_dev *pdev);
 
 struct platform_device;
 
-extern int ata_platform_remove_one(struct platform_device *pdev);
+extern void ata_platform_remove_one(struct platform_device *pdev);
 
 /*
  * ACPI - drivers/ata/libata-acpi.c
-- 
2.39.2

