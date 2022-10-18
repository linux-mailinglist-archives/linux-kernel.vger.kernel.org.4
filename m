Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5386D603547
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbiJRVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJRVvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:51:42 -0400
Received: from mail1.bemta35.messagelabs.com (mail1.bemta35.messagelabs.com [67.219.250.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD01CE98A;
        Tue, 18 Oct 2022 14:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666129892; i=@motorola.com;
        bh=uujB7YfI4RYuL9Qe9Qd8cFtPSbJRkCOtgIQ1f9GJcPA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding;
        b=D5pWJRyhX93G1EAaFkYYRwFywAV0cK+R1QDJfIVeCu1jjGHtVnciMFGgUVQLqLnay
         lP83LIOWDM5Cws1N2eAD5x52UDjEsyi5oDbMYVOiy+GFVFcl04HBHcgHX54DE0TVvU
         NaJsNWGPVpf6T6NGTIa5zUkUlgcoq+qVuq6c7kusGWxk/nwe91YmGt5ItEgic1aPnl
         lFIU2ObwFltRFfKGP8mMHDGy/FYQesDoHamfTWAXTzIHUr7HDsHAzFB6ZMJ1Er8XOu
         pTIW0DqO4Y+7bN475GnozDK+aLxitDvHwd0x7FnN21f0rKkLJHQK7WbS5qHtO1C8RD
         b/20zHZbQkk4Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRWlGSWpSXmKPExsWS8eKJmO4jef9
  kg3n9NhbH2p6wWzw50M5o0btsD5tF8+L1bBadE5ewWyxsW8JicXnXHDaLRctamS22tF1hsvjx
  p4/ZYtWCA+wO3B6zO2ayemxa1cnmsX/uGnaPxX2TWT36/xp4bNn/mdHj8ya5APYo1sy8pPyKB
  NaM5xN3Mhbc0q7YeOMvcwPjbdUuRi4OIYEZTBJXev6yQjjrmCRObH3M2MXIycEmoCax4PUqZh
  BbREBW4vCV38wgRcwCz5klpu28xdTFyMEhLOAj0bDUAKSGRUBVYsbLnWwgNq+ApcT3pd/BeiU
  E5CX2HzwLZnMKWEl0PWxjAbGFgGoet15hhagXlDg58wlYnBmovnnrbOYJjLyzkKRmIUktYGRa
  xWhWnFpUllqka2Sol1SUmZ5RkpuYmaOXWKWbqFdarFueWlyia6SXWF6sl1pcrFdcmZuck6KXl
  1qyiREY+ClF6c92MLYs+6N3iFGSg0lJlHfON79kIb6k/JTKjMTijPii0pzU4kOMMhwcShK8nF
  L+yUKCRanpqRVpmTnAKIRJS3DwKInwpskApXmLCxJzizPTIVKnGI05ps7+t5+Zo3N/1wFmIZa
  8/LxUKXFeblmgUgGQ0ozSPLhBsORwiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw7wGQhTyZ
  eSVw+14BncIEdIrpFj+QU0oSEVJSDUzq23p+i+96uXHxirBdLrX3Ba9bHJ1YfHjJtoZ9E4M1U
  uqiEhQ4yxZ6Vf0uvFhXkJLQ8McssX7DQpGWNT1LlW8f3FG77vVJ64YzGwyOVUrp/GZMqOJQ+u
  I4O31arzhvx4X8Qn8LLqFFEU+tvl4wTp84m+u2x0R3jTWcLO9K8tLv75PyOuqm8vYfr3F34a4
  77o9vTv+pu+TtR899vk/Un86brXyNy2H32cXnDynUr3tyrNT4+EklpkyzpKYItrJlX4/4uemI
  Oe/ivXDn4rxaRdd7T9WT1Fu+Wp8tulbxNnbJzP+rd5RlL1aax/cuyIp/Cid7UGNt+eTSp8YMb
  vXiZY+LLv6cvrft2+M1x6LPWy5TYinOSDTUYi4qTgQANw1zN4kDAAA=
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-12.tower-655.messagelabs.com!1666129890!235854!1
X-Originating-IP: [104.232.228.22]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30631 invoked from network); 18 Oct 2022 21:51:30 -0000
Received: from unknown (HELO va32lpfpp02.lenovo.com) (104.232.228.22)
  by server-12.tower-655.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Oct 2022 21:51:30 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4MsSHP6bHKz50GH2;
        Tue, 18 Oct 2022 21:51:29 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4MsSHP4sQlzf6WS;
        Tue, 18 Oct 2022 21:51:29 +0000 (UTC)
From:   Dan Vacura <w36195@motorola.com>
To:     linux-usb@vger.kernel.org
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Dan Vacura <w36195@motorola.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Paul Elder <paul.elder@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 6/6] usb: gadget: uvc: add configfs option for sg support
Date:   Tue, 18 Oct 2022 16:50:42 -0500
Message-Id: <20221018215044.765044-7-w36195@motorola.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018215044.765044-1-w36195@motorola.com>
References: <20221018215044.765044-1-w36195@motorola.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scatter gather support doesn't appear to work well with some UDC hw.
Add the ability to turn off the feature depending on the controller in
use or other platform quirks. The default is for the uvc gadget to
support sg as long as the UDC hw supports it.

The specific failure was with the dwc3 controller, but fixes and
improvements are pending for those failures. This capability is now
more intended for future unexpected failures or poor sg support on a
given platform.

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
V1 -> V2:
- no change, new patch in series
V2 -> V3:
- default on, same as baseline
V3 -> V4:
- update comment and documentation, refactor use of opts->sg_supported 
  directly in uvc_queue

 Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
 Documentation/usb/gadget-testing.rst              | 4 ++++
 drivers/usb/gadget/function/f_uvc.c               | 1 +
 drivers/usb/gadget/function/u_uvc.h               | 1 +
 drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
 drivers/usb/gadget/function/uvc_queue.c           | 4 +++-
 6 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 5dfaa3f7f6a4..839a75fc28ee 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -9,6 +9,7 @@ Description:	UVC function directory
 		streaming_interval	1..16
 		function_name		string [32]
 		req_int_skip_div	unsigned int
+		sg_supported		0..1
 		===================	=============================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/control
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index f9b5a09be1f4..be72577a03e9 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -796,6 +796,10 @@ The uvc function provides these attributes in its function directory:
 	function_name       name of the interface
 	req_int_skip_div    divisor of total requests to aid in calculating
 			    interrupt frequency, 0 indicates all interrupt
+	sg_supported        allow for scatter gather to be used if the UDC
+			    hw supports it, this is default on and only
+			    intended to be temporally turned off if a given
+			    platform doesn't work well with scatter gather
 	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index e40ca26b9c55..83d96e81c05f 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -875,6 +875,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	opts->streaming_interval = 1;
 	opts->streaming_maxpacket = 1024;
 	opts->req_int_skip_div = 4;
+	opts->sg_supported = 1;
 	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");
 
 	ret = uvcg_attach_configfs(opts);
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 6f73bd5638ed..5ccced629925 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -25,6 +25,7 @@ struct f_uvc_opts {
 	unsigned int					streaming_maxpacket;
 	unsigned int					streaming_maxburst;
 	unsigned int					req_int_skip_div;
+	unsigned int					sg_supported;
 
 	unsigned int					control_interface;
 	unsigned int					streaming_interface;
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 419e926ab57e..3784c0e02d01 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2351,6 +2351,7 @@ UVCG_OPTS_ATTR(streaming_interval, streaming_interval, 16);
 UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
 UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
 UVCG_OPTS_ATTR(req_int_skip_div, req_int_skip_div, UINT_MAX);
+UVCG_OPTS_ATTR(sg_supported, sg_supported, 1);
 
 #undef UVCG_OPTS_ATTR
 
@@ -2401,6 +2402,7 @@ static struct configfs_attribute *uvc_attrs[] = {
 	&f_uvc_opts_attr_streaming_maxpacket,
 	&f_uvc_opts_attr_streaming_maxburst,
 	&f_uvc_opts_attr_req_int_skip_div,
+	&f_uvc_opts_attr_sg_supported,
 	&f_uvc_opts_string_attr_function_name,
 	NULL,
 };
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 02559906a55a..aee405663d6e 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -21,6 +21,7 @@
 #include <media/videobuf2-vmalloc.h>
 
 #include "uvc.h"
+#include "u_uvc.h"
 
 /* ------------------------------------------------------------------------
  * Video buffers queue management.
@@ -141,6 +142,7 @@ int uvcg_queue_init(struct uvc_video_queue *queue, struct device *dev, enum v4l2
 {
 	struct uvc_video *video = container_of(queue, struct uvc_video, queue);
 	struct usb_composite_dev *cdev = video->uvc->func.config->cdev;
+	struct f_uvc_opts *opts = fi_to_f_uvc_opts(video->uvc->func.fi);
 	int ret;
 
 	queue->queue.type = type;
@@ -149,7 +151,7 @@ int uvcg_queue_init(struct uvc_video_queue *queue, struct device *dev, enum v4l2
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.ops = &uvc_queue_qops;
 	queue->queue.lock = lock;
-	if (cdev->gadget->sg_supported) {
+	if (opts->sg_supported && cdev->gadget->sg_supported) {
 		queue->queue.mem_ops = &vb2_dma_sg_memops;
 		queue->use_sg = 1;
 	} else {
-- 
2.34.1

