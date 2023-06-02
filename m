Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A95720BB7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 00:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236782AbjFBWFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 18:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbjFBWFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 18:05:18 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15A21BC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 15:05:16 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b1bc451355so5354705ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 15:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685743516; x=1688335516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYT9g7A1uxTfGjyFEugvL3AXvNQ8WAq4xs51FmroEpE=;
        b=nK5w7yjJ2ZDaNLlhATxkXjSYyCzCpBlP7Li/vw+GEdE+1O8kttnNhGvAitz1dsxL2e
         865HJ4Ofuj3avvkyWxHFU9N/3ukIPwdalbB6t9DtYbOJScO4boFzGOXCyP7z2N56xH2c
         HzazY77/WnP7pB5qq8ZsrocG/jLpsWLuTRIGkMBfQzF8q/RjrsGXhCi9ug+NaxUcdKN3
         EfDIz98qYmocoB2F+ulyBHSoa2eX9MYl4XmxH0HdzTvp+VbAWVu3A37GKUeuyOiUNc+B
         rVL3asJXfPs6yE/VArZ/1K1jazWTHXlBK2jtshKyQEUKnedvcwVvypDkQ3MTFFjXhxqd
         wTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685743516; x=1688335516;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYT9g7A1uxTfGjyFEugvL3AXvNQ8WAq4xs51FmroEpE=;
        b=VCjbOujCLPsz10yzL8+XeTG6q5AiZ079OyJPFO7t/zu+uwBrF5oV7o1n4g7vgaWXts
         bPpw19sXowtt5fCIYezlITXdXeQy8uVcxYypqVMr7U2O+3Mrp8cuJ7Z0zBw7pUbIwrpi
         zaNlEqrOzmo6/403cUeFcBHlisPtLkH2NxoJCMTKoo6B9GTlmLOQRJADpKn62reQxMMX
         mCqi0QKbpU/DCoL1XArmHl+sZoDmBbuYZ/h1AvZjWkSb4t7sUOVJvkxrXcQgqlA6CwGs
         yy6qPGH7/dKYlrGHcUqeynZOzxq0rVmOYFnMNCBgoKCrgym8A33OsD7XUAGw9mlhGXaY
         xe4Q==
X-Gm-Message-State: AC+VfDxjUyLRxKsgfqqQGuN5nFzE9ME0svzLtWWWuJbS57v8hdOsfhdv
        bsBKqHPkpk0qn2910z8JcawaFLICIhKs
X-Google-Smtp-Source: ACHHUZ7pEdWJ7NvgBXRWYlvDIkhcQsS0dYnnyQn3NYEOuxUBBGxCliENNbka3sB447MQvu4T/MSHiByJMH86
X-Received: from hi-h2o-specialist.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3cef])
 (user=arakesh job=sendgmr) by 2002:a17:902:da8d:b0:1b1:a4e2:a2e3 with SMTP id
 j13-20020a170902da8d00b001b1a4e2a2e3mr315044plx.5.1685743516273; Fri, 02 Jun
 2023 15:05:16 -0700 (PDT)
Date:   Fri,  2 Jun 2023 15:04:55 -0700
In-Reply-To: <20230602211602.3b7rfa252wliiszp@synopsys.com>
Mime-Version: 1.0
References: <20230602211602.3b7rfa252wliiszp@synopsys.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230602220455.313801-1-arakesh@google.com>
Subject: [PATCH v3] usb: gadget: uvc: clean up comments and styling in video_pump
From:   Avichal Rakesh <arakesh@google.com>
To:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com
Cc:     thinh.nguyen@synopsys.com, arakesh@google.com, etalvala@google.com,
        gregkh@linuxfoundation.org, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch elaborates on some of the edge cases handled by
video_pump around setting no_interrupt flag, and brings the
code style in line with rest of the file.

Link: https://lore.kernel.org/20230602151916.GH26944@pendragon.ideasonboard.com/
Signed-off-by: Avichal Rakesh <arakesh@google.com>
---
Changelog:
v2:
  - Updated commit message to make it clear that userspace application is not
    required to match the ISOC rate.
  - Styling and comment revision based on review
v3:
  - Rebased on to Greg's usb-next where v1 had already merged
  - Updated commit message to match the actual changes after rebase.


 drivers/usb/gadget/function/uvc_video.c | 38 ++++++++++++++++---------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index e81865978299..91af3b1ef0d4 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -382,13 +382,13 @@ static void uvcg_video_pump(struct work_struct *work)
 {
 	struct uvc_video *video = container_of(work, struct uvc_video, pump);
 	struct uvc_video_queue *queue = &video->queue;
+	/* video->max_payload_size is only set when using bulk transfer */
+	bool is_bulk = video->max_payload_size;
 	struct usb_request *req = NULL;
 	struct uvc_buffer *buf;
 	unsigned long flags;
+	bool buf_done;
 	int ret;
-	bool buf_int;
-	/* video->max_payload_size is only set when using bulk transfer */
-	bool is_bulk = video->max_payload_size;

 	while (video->ep->enabled) {
 		/*
@@ -414,20 +414,19 @@ static void uvcg_video_pump(struct work_struct *work)

 		if (buf != NULL) {
 			video->encode(req, video, buf);
-			/* Always interrupt for the last request of a video buffer */
-			buf_int = buf->state == UVC_BUF_STATE_DONE;
+			buf_done = buf->state == UVC_BUF_STATE_DONE;
 		} else if (!(queue->flags & UVC_QUEUE_DISCONNECTED) && !is_bulk) {
 			/*
 			 * No video buffer available; the queue is still connected and
-			 * we're traferring over ISOC. Queue a 0 length request to
+			 * we're transferring over ISOC. Queue a 0 length request to
 			 * prevent missed ISOC transfers.
 			 */
 			req->length = 0;
-			buf_int = false;
+			buf_done = false;
 		} else {
 			/*
-			 * Either queue has been disconnected or no video buffer
-			 * available to bulk transfer. Either way, stop processing
+			 * Either the queue has been disconnected or no video buffer
+			 * available for bulk transfer. Either way, stop processing
 			 * further.
 			 */
 			spin_unlock_irqrestore(&queue->irqlock, flags);
@@ -435,11 +434,24 @@ static void uvcg_video_pump(struct work_struct *work)
 		}

 		/*
-		 * With usb3 we have more requests. This will decrease the
-		 * interrupt load to a quarter but also catches the corner
-		 * cases, which needs to be handled.
+		 * With USB3 handling more requests at a higher speed, we can't
+		 * afford to generate an interrupt for every request. Decide to
+		 * interrupt:
+		 *
+		 * - When no more requests are available in the free queue, as
+		 *   this may be our last chance to refill the endpoint's
+		 *   request queue.
+		 *
+		 * - When this is request is the last request for the video
+		 *   buffer, as we want to start sending the next video buffer
+		 *   ASAP in case it doesn't get started already in the next
+		 *   iteration of this loop.
+		 *
+		 * - Four times over the length of the requests queue (as
+		 *   indicated by video->uvc_num_requests), as a trade-off
+		 *   between latency and interrupt load.
 		 */
-		if (list_empty(&video->req_free) || buf_int ||
+		if (list_empty(&video->req_free) || buf_done ||
 		    !(video->req_int_count %
 		       DIV_ROUND_UP(video->uvc_num_requests, 4))) {
 			video->req_int_count = 0;
--
2.41.0.rc0.172.g3f132b7071-goog

