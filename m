Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC8666E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239576AbjALJpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbjALJoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:44:46 -0500
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBCCB4AE;
        Thu, 12 Jan 2023 01:42:28 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.460409|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0416294-0.000944656-0.957426;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.QqwgL03_1673516544;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.QqwgL03_1673516544)
          by smtp.aliyun-inc.com;
          Thu, 12 Jan 2023 17:42:24 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Add support for RTL8852BS
Date:   Thu, 12 Jan 2023 17:42:40 +0800
Message-Id: <20230112094240.49794-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the support for RTL8852BS BT controller on UART interface.
The necessary firmware file will be submitted to linux-firmware.

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 drivers/bluetooth/btrtl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 69c3fe649ca7..36c3a23324f8 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -198,6 +198,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8852bu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852bu_config" },
 
+	/* 8852B with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8852bs_config" },
+
 	/* 8852C */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xc, 0xc, HCI_USB),
 	  .config_needed = false,
@@ -965,5 +973,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_config.bin");
-- 
2.29.0

