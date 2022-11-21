Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33C96328D0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKUP6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiKUP6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:58:38 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3CCCB6AE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:58:37 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:4821:1ba5:2638:5c3a])
        by laurent.telenet-ops.be with bizsmtp
        id n3yb2800D5WXlCv013ybwv; Mon, 21 Nov 2022 16:58:35 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9Bq-0019GF-Nt; Mon, 21 Nov 2022 16:58:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ox9Bp-00BRbY-Vb; Mon, 21 Nov 2022 16:58:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] media: staging: stkwebcam: Restore MEDIA_{USB,CAMERA}_SUPPORT dependencies
Date:   Mon, 21 Nov 2022 16:58:33 +0100
Message-Id: <a50fa46075fb760d8409ff6ea2232b2ddb7a102b.1669046259.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By moving support for the USB Syntek DC1125 Camera to staging, the
dependencies on MEDIA_USB_SUPPORT and MEDIA_CAMERA_SUPPORT were lost.

Fixes: 56280c64ecacc971 ("media: stkwebcam: deprecate driver, move to staging")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/staging/media/deprecated/stkwebcam/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/deprecated/stkwebcam/Kconfig b/drivers/staging/media/deprecated/stkwebcam/Kconfig
index 4450403dff41fb64..7234498e634ac61c 100644
--- a/drivers/staging/media/deprecated/stkwebcam/Kconfig
+++ b/drivers/staging/media/deprecated/stkwebcam/Kconfig
@@ -2,7 +2,7 @@
 config VIDEO_STKWEBCAM
 	tristate "USB Syntek DC1125 Camera support (DEPRECATED)"
 	depends on VIDEO_DEV
-	depends on USB
+	depends on MEDIA_USB_SUPPORT && MEDIA_CAMERA_SUPPORT
 	help
 	  Say Y here if you want to use this type of camera.
 	  Supported devices are typically found in some Asus laptops,
-- 
2.25.1

