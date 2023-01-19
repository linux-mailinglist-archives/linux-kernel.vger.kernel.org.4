Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A122567378A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjASLzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjASLzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:55:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529D7A9E;
        Thu, 19 Jan 2023 03:55:28 -0800 (PST)
Received: from ideasonboard.com (unknown [IPv6:2401:4900:1c80:b229:a6c1:a673:925f:1ed6])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BE34904;
        Thu, 19 Jan 2023 12:55:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674129326;
        bh=+2m5Q5uisZYK67wWg5nGeKHwzAofWrbg8tigUbHvT18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZncKF16cS9d18BztnABZ5/jiuTPr1UOSfmQtAyuTR7n41B4v+39Om3KgA7nSpzNa
         avwek1ox7serHewseJx3sc94gDYRbHYF1nhXDlv9Ncf2c7u6dAys6qDrn9FCEI7MrF
         HbutwZ/Mjnx8cVFIPhLDMirbsAR1dloLWnv7YmJY=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v5 1/6] staging: vc04_services: Drop __VCCOREVER__ remnants
Date:   Thu, 19 Jan 2023 17:24:58 +0530
Message-Id: <20230119115503.268693-2-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119115503.268693-1-umang.jain@ideasonboard.com>
References: <20230119115503.268693-1-umang.jain@ideasonboard.com>
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

Commit 8ba5f91bab63("staging: vc04_services: remove __VCCOREVER__")
was meant to remove all of __VCCOREVER__ definitions but missed to
remove a few. Hence, drop them now.

Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
---
 drivers/staging/vc04_services/bcm2835-audio/Makefile  | 2 +-
 drivers/staging/vc04_services/bcm2835-camera/Makefile | 3 +--
 drivers/staging/vc04_services/vchiq-mmal/Makefile     | 3 +--
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
index d59fe4dde615..fc7ac6112a3e 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
 snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
 
-ccflags-y += -I $(srctree)/$(src)/../include -D__VCCOREVER__=0x04000000
+ccflags-y += -I $(srctree)/$(src)/../include
diff --git a/drivers/staging/vc04_services/bcm2835-camera/Makefile b/drivers/staging/vc04_services/bcm2835-camera/Makefile
index 3a76d6ade428..3494c82b271a 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-camera/Makefile
@@ -7,5 +7,4 @@ obj-$(CONFIG_VIDEO_BCM2835) += bcm2835-v4l2.o
 
 ccflags-y += \
 	-I $(srctree)/$(src)/.. \
-	-I $(srctree)/$(src)/../vchiq-mmal/ \
-	-D__VCCOREVER__=0x04000000
+	-I $(srctree)/$(src)/../vchiq-mmal/
diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/staging/vc04_services/vchiq-mmal/Makefile
index b2a830f48acc..c7d3b06e17ce 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
+++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
@@ -5,5 +5,4 @@ obj-$(CONFIG_BCM2835_VCHIQ_MMAL) += bcm2835-mmal-vchiq.o
 
 ccflags-y += \
 	-I$(srctree)/$(src)/.. \
-	-I$(srctree)/$(src)/../include \
-	-D__VCCOREVER__=0x04000000
+	-I$(srctree)/$(src)/../include
-- 
2.38.1

