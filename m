Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D335BBDAC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 13:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiIRLlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 07:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiIRLlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 07:41:09 -0400
X-Greylist: delayed 597 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Sep 2022 04:41:06 PDT
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41F01A048
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 04:41:06 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 3409B2902D; Sun, 18 Sep 2022 13:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1663500659;
        bh=gHJfx8wSWMuiP6oI38sMXPRksdK6pMWB/LxgIBgJZKc=;
        h=From:To:Cc:Subject:Date:From;
        b=WGyM9dpHvPOpyrir7J8omQczPSEez0B9XrR1mUtlhghMx39bb9ZhohQJVYkKLS08Q
         Csa4xtfeIear5GiEOJygeVKGISlF2xKPx8H5984CVvEhoPZlNXsePn20uIkvOofXU6
         yCzxdq3kjZ9991VhaHGr7zOkKnSR+pWfL/TL4YJZjmwISCdrYBNRipU2q4KjoJH4ei
         E3dkRGZv9PVRfppcWkB/ZzBv8GvU4kQBOP8qCIRbM1IxdieNFVnU/I8oDOAzDKB6y2
         lsdTNLuu/TahlmfgaATvy+Jy9KsBr4lL5OFW2loOkjefey3D46pRJ/+25aIydI8iNN
         +ZGAaGhpVtMnin5zAW6yUyQvVlrC9OKaB+8NOj8t8YuKKThqjIyQphWd4FO3I22YQM
         u4QIKfulk8CUGZTYiEFXWIe39bPhX3u5ZsSzMcEcAYroNWCWXpO+qZkryoWzr4hcCg
         VAEGoKAhYq4TVGO/SVwLHd2FEsUcVmXyRBptoEjDQ0ATBCFBFqolK+WSg+5bhgd5ee
         GCufOWi0+upxLScgt87UkF0AhkFEfaemLqjsdktfYuh/UUegNC4GAfc+/gV9SyoBbW
         Fd7YmO0lpKNnuUoZAu8hyqyATRplO5+1zJKxsP8dn1TmTfbNBkgPmafCfTvhg8wfTP
         4/3v+ni5rU6qX41wj8Hi2xX8=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH] staging: rtl8192e: fix CamelCase variables
Date:   Sun, 18 Sep 2022 13:30:41 +0200
Message-Id: <20220918113041.3805576-1-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings for variables: LinkCtrlReg, DeviceID,
RevisionID, IrqLine.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 26 ++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 1d992d5c4e17..7a9a24935da9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -16,11 +16,11 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
 	u8 tmp;
-	u16 LinkCtrlReg;
+	u16 link_ctrl_reg;
 
-	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &LinkCtrlReg);
+	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &link_ctrl_reg);
 
-	RT_TRACE(COMP_INIT, "Link Control Register =%x\n", LinkCtrlReg);
+	RT_TRACE(COMP_INIT, "Link Control Register =%x\n", link_ctrl_reg);
 
 	pci_read_config_byte(pdev, 0x98, &tmp);
 	tmp |= BIT4;
@@ -33,28 +33,28 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
 bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev)
 {
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
-	u16 DeviceID;
-	u8  RevisionID;
-	u16 IrqLine;
+	u16 device_id;
+	u8  revision_id;
+	u16 irq_line;
 
-	DeviceID = pdev->device;
-	RevisionID = pdev->revision;
-	pci_read_config_word(pdev, 0x3C, &IrqLine);
+	device_id = pdev->device;
+	revision_id = pdev->revision;
+	pci_read_config_word(pdev, 0x3C, &irq_line);
 
 	priv->card_8192 = priv->ops->nic_type;
 
-	if (DeviceID == 0x8192) {
-		switch (RevisionID) {
+	if (device_id == 0x8192) {
+		switch (revision_id) {
 		case HAL_HW_PCI_REVISION_ID_8192PCIE:
 			dev_info(&pdev->dev,
 				 "Adapter(8192 PCI-E) is found - DeviceID=%x\n",
-				 DeviceID);
+				 device_id);
 			priv->card_8192 = NIC_8192E;
 			break;
 		case HAL_HW_PCI_REVISION_ID_8192SE:
 			dev_info(&pdev->dev,
 				 "Adapter(8192SE) is found - DeviceID=%x\n",
-				 DeviceID);
+				 device_id);
 			priv->card_8192 = NIC_8192SE;
 			break;
 		default:
-- 
2.30.2

