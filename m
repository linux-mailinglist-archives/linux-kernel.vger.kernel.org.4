Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650961ED64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 09:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiKGIuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 03:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGIuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 03:50:00 -0500
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54A5F13DC3;
        Mon,  7 Nov 2022 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=yCkgxRq/DrTG8PICQM
        d07ag8t4w0Vq+N3ydkR28Y4xU=; b=dWJgKq40vmuJttDAfJX9i0cClHlbYr1HxV
        WV8na8S6GLejvaisP5b1MUywpplunu9lzTSgnbDlD8eI39n9SesLUW6mSYXpPQtA
        D+cLoyoW1T5rudueMUwG6oCSKvVTwjXdNVT9HL2hQJxzPfLSJzX6xmw24vim9+kL
        xUZIQ6RF0=
Received: from localhost.localdomain (unknown [43.134.191.38])
        by smtp5 (Coremail) with SMTP id HdxpCgDn6SVpxmhjffuMqA--.40446S2;
        Mon, 07 Nov 2022 16:48:45 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     mani@kernel.org, gregkh@linuxfoundation.org,
        loic.poulain@linaro.org
Cc:     dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH v2] bus: mhi: host: pci_generic: Add macro for some VIDs
Date:   Mon,  7 Nov 2022 16:48:26 +0800
Message-Id: <20221107084826.8888-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgDn6SVpxmhjffuMqA--.40446S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFyfCr13Kr4rKr1ftr43KFg_yoW5WrWfpF
        4YkrWvvF4Dtr4UK3WvyayDZF95Aa17Cry3K3Z7tw4F9F4qkF4Fgr92vryayFyaqa4kWrWa
        qF1DZrWUK3Wqkr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziaZXrUUUUU=
X-Originating-IP: [43.134.191.38]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRuyZFyPfQfdJgABsH
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make code neat and for convenience purpose, use macro for
some VIDs. These macros are supposed to be added to pci_ids.h.
But until the macros are used in multiple places, it is not
recommended. So adding it locally for now.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
v2: Update description and format issue
---
 drivers/bus/mhi/host/pci_generic.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index c4259cb2d289..3a789bb2f631 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -24,6 +24,10 @@
 
 #define HEALTH_CHECK_PERIOD (HZ * 2)
 
+/* PCI VID definitions */
+#define PCI_VENDOR_ID_THALES	0x1269
+#define PCI_VENDOR_ID_QUECTEL	0x1eac
+
 /**
  * struct mhi_pci_dev_info - MHI PCI device specific information
  * @config: MHI controller configuration
@@ -557,11 +561,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
 	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
 		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
-	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
-	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
+	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
 		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
 	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
@@ -585,16 +589,16 @@ static const struct pci_device_id mhi_pci_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
 		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
 	/* MV31-W (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00b3),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
 	/* MV31-W (Cinterion), based on new baseline */
-	{ PCI_DEVICE(0x1269, 0x00b4),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b4),
 		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
 	/* MV32-WA (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00ba),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00ba),
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	/* MV32-WB (Cinterion) */
-	{ PCI_DEVICE(0x1269, 0x00bb),
+	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00bb),
 		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
 	{  }
 };
-- 
2.17.1

