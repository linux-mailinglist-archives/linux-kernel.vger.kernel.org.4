Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897915E9327
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiIYMiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiIYMiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 08:38:18 -0400
Received: from valentin-vidic.from.hr (valentin-vidic.from.hr [IPv6:2001:470:1f0b:3b7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6802EF0F
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 05:38:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id 9D3AA28C96; Sun, 25 Sep 2022 14:38:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=valentin-vidic.from.hr; s=2020; t=1664109493;
        bh=sI5bSDz03qw9PgGUZ6xzO739DROzd9HDc5NcK+8TBOE=;
        h=From:To:Cc:Subject:Date:From;
        b=sD2FdlIJxv89+b0FdQl0JyDMjw9uyYZRP2n0trHwg0HlLcAPyO5ruu6ce+s1K5ZZE
         F3LMZ237chIWEA8ktWbtVM95DEHuJ+cJAMZ3hIvtXoDYTgEiqn9/1C34Lc4smVhPRs
         ehkMg03WvdzybepfguHF/FgKhuT2UayFEhDl7QoeuqkRBNkcdwWSKwBV1fIgeqd2Q5
         DG2n2QGrZoA44u8AAWTWmQx6IpwHc5w7lPqF9Hy3oA3Sn18vScusa97IrrGH31itR4
         TvLaLG+Oj8BVLzwfXW8B+0Pt/L3ITZeUisWJPkhQbTALv3454vG47UBXpgI9453sU1
         Biik47eHomhGXMDUw1Zbs8qQenZSOM0FgphN+/apIrwGFwDMapDMtU3kQRd7uS4sf7
         bcsVwArSUMsPxvEf3Zb2npPkKVtW51VhSr15UzEKPDDqUYaGbCVCcTY9fitxKBPzyz
         KaVYBM9rJOpQBizSQ5c0PwvAuwOuuHQNocb4UFaXyy//adYX+T6xlGxY5hGJPClO0A
         GiNUz5dWu15lGA7XefoOdp/fS6zWCGVjjPa4b8eET7FOX2RQRup+7DF7b3uQqz8VOc
         Am/uu5QmXJowlc7RUotzobk5WM9aC+0Wu93daK/V4A/wd8Sm1OKwuMjDW/iMFkmuF4
         IySMGKYyLwYj3tURR4nZPWT0=
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v2] staging: rtl8192e: fix CamelCase variables
Date:   Sun, 25 Sep 2022 14:38:10 +0200
Message-Id: <20220925123810.2492865-1-vvidic@valentin-vidic.from.hr>
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
v2: rebase on staging-testing branch

 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
index 886bf4ba2adf..81e1bb856c60 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
@@ -16,9 +16,9 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
 	struct r8192_priv *priv = (struct r8192_priv *)rtllib_priv(dev);
 
 	u8 tmp;
-	u16 LinkCtrlReg;
+	u16 link_ctrl_reg;
 
-	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &LinkCtrlReg);
+	pcie_capability_read_word(priv->pdev, PCI_EXP_LNKCTL, &link_ctrl_reg);
 
 	pci_read_config_byte(pdev, 0x98, &tmp);
 	tmp |= BIT4;
@@ -31,28 +31,28 @@ static void _rtl92e_parse_pci_configuration(struct pci_dev *pdev,
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

