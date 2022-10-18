Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0638603545
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJRVvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiJRVvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:51:32 -0400
Received: from mail1.bemta33.messagelabs.com (mail1.bemta33.messagelabs.com [67.219.247.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B47CAE55;
        Tue, 18 Oct 2022 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com;
        s=Selector; t=1666129889; i=@motorola.com;
        bh=8C4mpLzfAGmUvqoBtRBj2oPSMTlDzsJxu1HgUPQnxFc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Transfer-Encoding;
        b=qX84A6D9CB5ogQPXoUAJL4ECeD6qUMTDh7ABwIrIdel4AhXNiJaqt8/O/tpWT/EfJ
         7acGYcMF1G6FRTzLvR2BTZQf2Rar6sy4vBtmiCBkhbA4ZuNU5CTzMeGguDGLQ3yBJZ
         SbdL5cx3FDq0yNMOquGW8O7aht9QB1oUfWR9BEhg0uWBvKfV290Eg55wzCrSRe/Qxz
         xljd5T4nzlYnVKPwwc+xGYQsvBW96btMR80Q+Yy875EI9wpX8OckkfvxqjCuFQYnD3
         hlu2nBBOS98xc2F1p67PG/QPgzDywcf/qzfKoWmcK8iIjYcZ4jWPmtADkmxbZ9yytj
         kR/iDfrGizpkw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRWlGSWpSXmKPExsWS8eKJuO4Def9
  kg7cPhC2OtT1ht3hyoJ3RonfZHjaL5sXr2Sw6Jy5ht1jYtoTF4vKuOWwWi5a1MltsabvCZPHj
  Tx+zxaoFB9gduD1md8xk9di0qpPNY//cNewei/sms3r0/zXw2LL/M6PH501yAexRrJl5SfkVC
  awZDQdfsRTcNaiY/PgWcwPjN80uRi4OIYEZTBLT1z5ghHDWMUlMfXiQvYuRk4NNQE1iwetVzC
  C2iICsxOErv5lBipgFnjNLHP60DiwhLBAgcebTazYQm0VAVeLXoueMIDavgKXE1d13wQZJCMh
  L7D94FqyeU8BKouthGwuILQRU87j1CitEvaDEyZlPwOLMQPXNW2czT2DknYUkNQtJagEj0ypG
  s+LUorLUIl1DS72kosz0jJLcxMwcvcQq3US90mLd1MTiEl0jvcTyYr3U4mK94src5JwUvbzUk
  k2MwNBPKXL/uYNx/rI/eocYJTmYlER553zzSxbiS8pPqcxILM6ILyrNSS0+xCjDwaEkwcsp5Z
  8sJFiUmp5akZaZA4xDmLQEB4+SCG+aDFCat7ggMbc4Mx0idYpRl6Nzf9cBZiGWvPy8VClxXm5
  ZoCIBkKKM0jy4EbCUcIlRVkqYl5GBgUGIpyC1KDezBFX+FaM4B6OSMO8BkFU8mXklcJteAR3B
  BHSE6RY/kCNKEhFSUg1MM3iy9x158saluiVWxXOZZNvmLT/ffZrqeNBn4WWTun1fvRuuVefMu
  zajbtWLv+sb3lqKb5DaJvfnbuyvlVHl82S1s5e/zd9Y5uj1T0RFbIHc0133l7FULp7hP+fp4S
  81U7SuXpupP5XlyNbZWtpyRT+slzJc8Bb/sk5Y8MA11U1v4jOic3eZ7FzELn+TxfDGhuaz6i/
  8T8keOjrPmeXJ96Rt/lfOW3b0SqoW5zyaKdp4XXOxTs6Vpv+qqTPi9sfL5P8Tr5z84fi81lfc
  wWapNh6n9r65KtXH7Vdqca8iXUlL7Z0X6+k6n8yXIhMZ7/P3eFyYdq/JhEO91z703fd7bV+Ek
  zbPli0LeK4rM5FhjRJLcUaioRZzUXEiAIYJe2KEAwAA
X-Env-Sender: w36195@motorola.com
X-Msg-Ref: server-12.tower-715.messagelabs.com!1666129888!57532!1
X-Originating-IP: [104.232.228.23]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20118 invoked from network); 18 Oct 2022 21:51:28 -0000
Received: from unknown (HELO va32lpfpp03.lenovo.com) (104.232.228.23)
  by server-12.tower-715.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Oct 2022 21:51:28 -0000
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4MsSHM6xjrz50WfM;
        Tue, 18 Oct 2022 21:51:27 +0000 (UTC)
Received: from p1g3.mot.com (unknown [100.64.172.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: w36195)
        by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4MsSHM5G9Mzf6WS;
        Tue, 18 Oct 2022 21:51:27 +0000 (UTC)
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
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 5/6] usb: gadget: uvc: make interrupt skip logic configurable
Date:   Tue, 18 Oct 2022 16:50:41 -0500
Message-Id: <20221018215044.765044-6-w36195@motorola.com>
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

Some UDC hw may not support skipping interrupts, but still support the
request. Allow the interrupt frequency to be configurable to the user.

Signed-off-by: Dan Vacura <w36195@motorola.com>
---
V1 -> V2:
- no change, new patch in series
V2 -> V3:
- default to baseline value of 4, fix storing the initial value
V3 -> V4:
- no change

 Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
 Documentation/usb/gadget-testing.rst              | 2 ++
 drivers/usb/gadget/function/f_uvc.c               | 3 +++
 drivers/usb/gadget/function/u_uvc.h               | 1 +
 drivers/usb/gadget/function/uvc.h                 | 2 ++
 drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
 drivers/usb/gadget/function/uvc_queue.c           | 6 ++++++
 drivers/usb/gadget/function/uvc_video.c           | 3 ++-
 8 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
index 611b23e6488d..5dfaa3f7f6a4 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
+++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
@@ -8,6 +8,7 @@ Description:	UVC function directory
 		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
 		streaming_interval	1..16
 		function_name		string [32]
+		req_int_skip_div	unsigned int
 		===================	=============================
 
 What:		/config/usb-gadget/gadget/functions/uvc.name/control
diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 2278c9ffb74a..f9b5a09be1f4 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -794,6 +794,8 @@ The uvc function provides these attributes in its function directory:
 			    sending or receiving when this configuration is
 			    selected
 	function_name       name of the interface
+	req_int_skip_div    divisor of total requests to aid in calculating
+			    interrupt frequency, 0 indicates all interrupt
 	=================== ================================================
 
 There are also "control" and "streaming" subdirectories, each of which contain
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 6e196e06181e..e40ca26b9c55 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -655,6 +655,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 		cpu_to_le16(max_packet_size * max_packet_mult *
 			    (opts->streaming_maxburst + 1));
 
+	uvc->config_skip_int_div = opts->req_int_skip_div;
+
 	/* Allocate endpoints. */
 	ep = usb_ep_autoconfig(cdev->gadget, &uvc_control_ep);
 	if (!ep) {
@@ -872,6 +874,7 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 
 	opts->streaming_interval = 1;
 	opts->streaming_maxpacket = 1024;
+	opts->req_int_skip_div = 4;
 	snprintf(opts->function_name, sizeof(opts->function_name), "UVC Camera");
 
 	ret = uvcg_attach_configfs(opts);
diff --git a/drivers/usb/gadget/function/u_uvc.h b/drivers/usb/gadget/function/u_uvc.h
index 24b8681b0d6f..6f73bd5638ed 100644
--- a/drivers/usb/gadget/function/u_uvc.h
+++ b/drivers/usb/gadget/function/u_uvc.h
@@ -24,6 +24,7 @@ struct f_uvc_opts {
 	unsigned int					streaming_interval;
 	unsigned int					streaming_maxpacket;
 	unsigned int					streaming_maxburst;
+	unsigned int					req_int_skip_div;
 
 	unsigned int					control_interface;
 	unsigned int					streaming_interface;
diff --git a/drivers/usb/gadget/function/uvc.h b/drivers/usb/gadget/function/uvc.h
index 40226b1f7e14..29f9477c92cc 100644
--- a/drivers/usb/gadget/function/uvc.h
+++ b/drivers/usb/gadget/function/uvc.h
@@ -107,6 +107,7 @@ struct uvc_video {
 	spinlock_t req_lock;
 
 	unsigned int req_int_count;
+	unsigned int req_int_skip_div;
 
 	void (*encode) (struct usb_request *req, struct uvc_video *video,
 			struct uvc_buffer *buf);
@@ -155,6 +156,7 @@ struct uvc_device {
 	/* Events */
 	unsigned int event_length;
 	unsigned int event_setup_out : 1;
+	unsigned int config_skip_int_div;
 };
 
 static inline struct uvc_device *to_uvc(struct usb_function *f)
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 4303a3283ba0..419e926ab57e 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -2350,6 +2350,7 @@ UVC_ATTR(f_uvc_opts_, cname, cname)
 UVCG_OPTS_ATTR(streaming_interval, streaming_interval, 16);
 UVCG_OPTS_ATTR(streaming_maxpacket, streaming_maxpacket, 3072);
 UVCG_OPTS_ATTR(streaming_maxburst, streaming_maxburst, 15);
+UVCG_OPTS_ATTR(req_int_skip_div, req_int_skip_div, UINT_MAX);
 
 #undef UVCG_OPTS_ATTR
 
@@ -2399,6 +2400,7 @@ static struct configfs_attribute *uvc_attrs[] = {
 	&f_uvc_opts_attr_streaming_interval,
 	&f_uvc_opts_attr_streaming_maxpacket,
 	&f_uvc_opts_attr_streaming_maxburst,
+	&f_uvc_opts_attr_req_int_skip_div,
 	&f_uvc_opts_string_attr_function_name,
 	NULL,
 };
diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 0aa3d7e1f3cc..02559906a55a 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -63,6 +63,12 @@ static int uvc_queue_setup(struct vb2_queue *vq,
 	 */
 	nreq = DIV_ROUND_UP(DIV_ROUND_UP(sizes[0], 2), req_size);
 	nreq = clamp(nreq, 4U, 64U);
+	if (0 == video->uvc->config_skip_int_div) {
+		video->req_int_skip_div = nreq;
+	} else {
+		video->req_int_skip_div = min_t(unsigned int, nreq,
+				video->uvc->config_skip_int_div);
+	}
 	video->uvc_num_requests = nreq;
 
 	return 0;
diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index dd1c6b2ca7c6..c1a80c5d1f63 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -423,7 +423,8 @@ static void uvcg_video_pump(struct work_struct *work)
 		if (list_empty(&video->req_free) ||
 		    buf->state == UVC_BUF_STATE_DONE ||
 		    !(video->req_int_count %
-		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
+		       DIV_ROUND_UP(video->uvc_num_requests,
+			       video->req_int_skip_div))) {
 			video->req_int_count = 0;
 			req->no_interrupt = 0;
 		} else {
-- 
2.34.1

