Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F32064DAF7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiLOMRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLOMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:17:09 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEE22E9DE;
        Thu, 15 Dec 2022 04:17:08 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6E565891;
        Thu, 15 Dec 2022 13:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671106627;
        bh=6dOVrvUU0H4p5nOyBqVTYjf4TVljXlFMdYCS2k9AV1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CPms7eFLwncpi4s3ntz7ft6mj+Lquet7x/yoZrgiRxW+iNAiT4qbBifXylEqPEftz
         +RmxlLKwOMu79/DbDADKUQl/KgI+9npHV7PsHBVudROmO7ur3xycMfI5XGsbpAs3TQ
         pQSfIQOCV+QS/2coAuBCdzfFAgI1wMK87gFvN0wE=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        sakari.ailus@linux.intel.com,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        niklas.soderlund+renesas@ragnatech.se,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        satish.nagireddy@getcruise.com, Tomasz Figa <tfiga@chromium.org>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v16 01/20] media: v4l2-subdev: Sort includes
Date:   Thu, 15 Dec 2022 14:16:15 +0200
Message-Id: <20221215121634.287100-2-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
References: <20221215121634.287100-1-tomi.valkeinen@ideasonboard.com>
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

Sort the includes alphabetically.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/media/v4l2-core/v4l2-subdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 5c27bac772ea..ca5b764d796d 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -8,20 +8,20 @@
  *	    Sakari Ailus <sakari.ailus@iki.fi>
  */
 
+#include <linux/export.h>
 #include <linux/ioctl.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/videodev2.h>
-#include <linux/export.h>
 #include <linux/version.h>
+#include <linux/videodev2.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
-#include <media/v4l2-ioctl.h>
-#include <media/v4l2-fh.h>
 #include <media/v4l2-event.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ioctl.h>
 
 #if defined(CONFIG_VIDEO_V4L2_SUBDEV_API)
 static int subdev_fh_init(struct v4l2_subdev_fh *fh, struct v4l2_subdev *sd)
-- 
2.34.1

