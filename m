Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B38974C6E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 19:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGIRtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 13:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGIRtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 13:49:13 -0400
X-Greylist: delayed 447 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 09 Jul 2023 10:49:11 PDT
Received: from ir1.moh53n.ir (unknown [178.22.121.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DDBF;
        Sun,  9 Jul 2023 10:49:11 -0700 (PDT)
From:   Mohsen Tahmasebi <moh53n@moh53n.ir>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moh53n.ir; s=mail;
        t=1688924499; bh=iJYrTItc+o4wTOiWggWofOtB5wsxdcRkznp9Hpuab3s=;
        h=From:To:Cc:Subject;
        b=GCq2WPAz9CWScHy7H+lYwAzwRUXC30E6wC6Rmgcm+wcgwUe2Fb6pTb64KoOTaqGPb
         9D2INJBBlQBEWQT4F+z5/LqDf/erssCQcewZcQL+3ZaE9OvlOf9t6Jb7PhCCmO0JoC
         HZxC/UP8a1C/UPhpJecywQqezkfP7PEYeqtOaS0L9+/f0426ZbLe3RHYmRiBLYQrKP
         cJUtjELD7TWcGFQ/EYHj9+YC3EU8i5YS6ZfOLFUpC/txeDs+/H3+ZKuyu8LlDrvWA1
         fNApO+O1V7wsvZR/f8N1FzuNrlzXtt0+GVklu9M5Klo/swZZyeuvum0cxisyVHNPwv
         aBA7AAH/cOkOaZ5Nk31Elt1fvgviUPUZrC2dtSlGVG3NdN+frk+q24tNhy3DRZRggJ
         /p5qkycmqMWYxyAN1e+/JufUIwGICCz6VgrfvECAkhYxx0P2jAxalg2hTbYjnEWy7g
         yJHtGktRC8QyD6VaHD//+1eFAhddNRbAbGcYd8akeyeGhvZExIVwsQPXpvrTKrvDVb
         MggZ6KYaFmpA/wE6EII0gBmLP0hTv5S5OuO6YfuO2IlSYFRoO5CeHwjpebStP116/F
         vkHv4FEcyhYZVQBsHtTlbZI91wjF/+Ar1W0h4bTpP7pDuMFscZG1i02GeywZAhduT7
         xjZJyqK88+8rcExaX/gUiHJI=
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, moh53n@moh53n.ir,
        Mostafa Ghofrani <mostafaghrr@gmail.com>
Subject: [PATCH] USB: serial: option: add Quectel EC200A module support
Date:   Sun,  9 Jul 2023 21:11:30 +0330
Message-ID: <20230709174130.8867-1-moh53n@moh53n.ir>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mohsen Tahmasebi <moh53n@moh53n.ir>
Tested-by: Mostafa Ghofrani <mostafaghrr@gmail.com>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 288a96a74266..ed4405efc18f 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -271,6 +271,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EM061K_LWW		0x6008
 #define QUECTEL_PRODUCT_EM061K_LCN		0x6009
 #define QUECTEL_PRODUCT_EC200T			0x6026
+#define QUECTEL_PRODUCT_EC200A			0x6005
 #define QUECTEL_PRODUCT_RM500K			0x7001
 
 #define CMOTECH_VENDOR_ID			0x16d8
@@ -1228,6 +1229,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200U, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200S_CN, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200A, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500K, 0xff, 0x00, 0x00) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
-- 
2.41.0

