Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75109601ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 22:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJQU4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 16:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJQU4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:56:06 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F606786F2;
        Mon, 17 Oct 2022 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666040134; i=@motorola.com;
        bh=siUzXqhiEXsKcm/ojeD2uOg1mn+jfEsHn/6c0+dqMI0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding;
        b=pLVSPewwst3xo4WJuXwgGxWTOs0QW09zqZwKERrtV08L6l00lIU9FkMJOXIWJ9N1C
         pv5zrPLRRxykTq8H6xaeEroTZkXSL2BLOfv7NBK/JTZ8ZXogw3mtN/y8qAZ+LY1d91
         vZo9yq9y5i6cQ/OezfTdPnV1l/sxaMkTk57IQfzJ/aB6f9YUWuBYf86R1UBsExngPf
         Wf9jCFaqY284E3OvRufH5AxDeTrmaO8LS6tlIn0ZHNLCc+8pgbOOtJwWrSf2rDTqpw
         OHmbaNJ/fNMT5MuQXM7XHwNnirKHevxxS9AROgej+GuktbjLsGWN3KaG/b5fs+jGpn
         X4PqmIC+VxF4w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRWlGSWpSXmKPExsUyYU+Di67rQd9
  kg0crjSyOtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MltsabvCZPHj
  Tx+zxaoFB9gduD1md8xk9di0qpPNY//cNewei/sms3r0/zXw2LL/M6PH501yAexRrJl5SfkVC
  awZLWv+sRZsVquYt+gMWwPjWsUuRi4OIYEpTBLntpxlg3DWMkn8+7OXtYuRk4NNQE1iwetVzC
  C2iICsxOErv5lBipgFnjNLTNt5iwkkISzgIzHx6n2gBg4OFgFViWsrkkDCvAKWEme3LmYDsSU
  E5CX2HzzLDFLCKWAlsWGqOkhYCKhk84EtrBDlghInZz5hAbGZgcqbt85mnsDIOwtJahaS1AJG
  plWMZsWpRWWpRbqGJnpJRZnpGSW5iZk5eolVuol6pcW6qYnFJbpGeonlxXqpxcV6xZW5yTkpe
  nmpJZsYgWGfUuQwYQfjt2V/9A4xSnIwKYnydszwTRbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwf
  tzB1BOsCg1PbUiLTMHGIMwaQkOHiUR3s5tQGne4oLE3OLMdIjUKUZjjqmz/+1n5ujc33WAWYg
  lLz8vVUqc98c+oFIBkNKM0jy4QbDUcIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO/9/UBT
  eDLzSuD2vQI6hQnolIz9XiCnlCQipKQamEonrnE5e/6aNCPPe2d9a4tnJ9v/bD7+lu3F64Jvs
  rGTtwTK8cz94XfAO+tv5qJlrOtUbl9ZznpbrvmtYP2ZJz3CWxPFv36p22/GbCwse31mTKs2a1
  OqVOGRyuu3fm1PP7KiuJrhRlvkrsgkbYkX0VZiVkIlcofncKQ6itzaVVGQ8974m3f7bw8WYQ+
  TwoOM+e4c6yLW5Qb+uPXhS73ykc37jJZkqf7hT7z3Jyz3S+QtyaWHv6TH/Mzfci5vwR/OJIap
  2yUKLC1fPucUZc169qTn35RW00WF9aqnv0752Xg7feUVgVuhSguFVs0S2/jo2697dbGa1X8i9
  z3yXhNwooljTyRb+ZLQlIyQxrTsK0osxRmJhlrMRcWJAD2nOkqIAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-8.tower-635.messagelabs.com!1666040133!17546!1
X-Originating-IP: [144.188.128.68]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 840 invoked from network); 17 Oct 2022 20:55:33 -0000
Received: from unknown (HELO ilclpfpp02.lenovo.com) (144.188.128.68)
  by server-8.tower-635.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Oct 2022 20:55:33 -0000
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4Mrq5K2lfWzc3HP;
        Mon, 17 Oct 2022 20:55:33 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4Mrq5K17Hlzbpxx;
        Mon, 17 Oct 2022 20:55:33 +0000 (UTC)
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
Subject: [PATCH v3 6/6] usb: gadget: uvc: add configfs option for sg support
Date:   Mon, 17 Oct 2022 15:54:44 -0500
Message-Id: <20221017205446.523796-7-w36195@motorola.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017205446.523796-1-w36195@motorola.com>
References: <20221017205446.523796-1-w36195@motorola.com>
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
Add the ability to turn on the feature depending on the controller in
use.

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
V1 -> V2:
- no change, new patch in serie
V2 -> V3:
- default on, same as baseline

 Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
 Documentation/usb/gadget-testing.rst              | 2 ++
 drivers/usb/gadget/function/f_uvc.c               | 2 ++
 drivers/usb/gadget/function/u_uvc.h               | 1 +
 drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
 drivers/usb/gadget/function/uvc_queue.c           | 4 ++--
 6 files changed, 10 insertions(+), 2 deletions(-)

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
index f9b5a09be1f4..8e3072d6a590 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -796,6 +796,8 @@ The uvc function provides these attributes in its function directory:
 	function_name       name of the interface
 	req_int_skip_div    divisor of total requests to aid in calculating
 			    interrupt frequency, 0 indicates all interrupt
+	sg_supported        allow for scatter gather to be used if the UDC
+			    hw supports it
 	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index e40ca26b9c55..d08ebe3ffeb2 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -656,6 +656,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 			    (opts->streaming_maxburst + 1));
 
 	uvc->config_skip_int_div = opts->req_int_skip_div;
+	uvc->video.queue.use_sg = opts->sg_supported;
 
 	/* Allocate endpoints. */
 	ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
@@ -875,6 +876,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
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
index 02559906a55a..3c7aa5c4bba2 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -149,11 +149,11 @@ int uvcg_queue_init(struct uvc_video_queue *queue, struct device *dev, enum v4l2
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.ops = &uvc_queue_qops;
 	queue->queue.lock = lock;
-	if (cdev->gadget->sg_supported) {
+	if (queue->use_sg && cdev->gadget->sg_supported) {
 		queue->queue.mem_ops = &vb2_dma_sg_memops;
-		queue->use_sg = 1;
 	} else {
 		queue->queue.mem_ops = &vb2_vmalloc_memops;
+		queue->use_sg = false;
 	}
 
 	queue->queue.timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY
-- 
2.34.1

