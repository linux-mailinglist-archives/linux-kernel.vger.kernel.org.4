Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B34F7148A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjE2LfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjE2Lew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:52 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F20121
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:32 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6FE6832004CE;
        Mon, 29 May 2023 07:34:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 May 2023 07:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360071; x=
        1685446471; bh=19oDU4fEk+sheHYZWOnoN5cHboklhnnlKJrCnG0DjSI=; b=f
        Vu2ThrHMZYnWxx/VPt3E9aDHlxv35J9s3YH7epWvBi8RJhUlJv8qRUAKHd2MpSUP
        Hh5x4ltcuv347uPGyT+JYANMH4c9hL5Gqlds+cR89gBjVI1gQ2w1N6a5N5R92Foo
        qyYzYxk5xFXFtAoLGV4Trq35ZnPZjf9/HdAQrkRuTaKZtLvPCMF2Mvot4OI7xDIV
        4A83JfWK8iy2ua4S/IIjJwv96cK+YKC5H0DGAXl5aaO+n9okgA5R29Bb5H8FbYxf
        nRLLis014TKu+e3SXP0I51elJd/MmgoKpunSKUB03bZuLpquy25g0wYUqLtfKCNF
        94XrmERtJ3lw2ALfDuAeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360071; x=1685446471; bh=1
        9oDU4fEk+sheHYZWOnoN5cHboklhnnlKJrCnG0DjSI=; b=YZdQMWgNnc91Co2nh
        CRi3lb9z9uwMwuAwY+QU8bivt0qVB5wJikOCSa5+drJJ2kQ28QZyHtLp6bUJL8pr
        WdIjtGPfQIFiBu6Qv8qmkQ4V6/x1t+T49Z//AYYsVBissiBnY4hNiv0ua8MjCywf
        5L8SAiYaPZoqfCifieUkmzmzYpH1Vh8qP8vN08CE+WBp+qfQdvmo/HhExJ5mHhT/
        JV2gOJH9RzRsfDWBbgskVBfS4qSmuC0Mu7W6b3uKypeeyNc1iDJ6qBS8UqoXv2E7
        qmfjCyZmcCzWNzCOX6HdjcovwAPoF+rJosVxPWV4lawU0uMHlIGTjayxV5Qv9ikq
        b4thQ==
X-ME-Sender: <xms:xo10ZO4VMOwh02NRcraHVqvbi7uLtXZJVJOGV2ZE4M_gY8a_7fM7kQ>
    <xme:xo10ZH5Gi6fdxesSTHV1fLpxeex5pSjNsVcHa6vNN_a4pu76lYnxQdZun9rkKGJqJ
    09JSN9pz2aAGPswODg>
X-ME-Received: <xmr:xo10ZNePKq-1QzLQ9kdDPDmQLHn6ZrssLDUZwFTgt5YPL6PmUnEEank3vwtUE8Qsc8jVl5mgLnkm3jco8EqdD2V-tk5pJg4zBUuHzkPz0Wi9zA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:xo10ZLLUcSMMaXMn28pis7TEjlbes_hYjMGiyJsi2dB-SfR7qUH8kw>
    <xmx:xo10ZCJA6wgswI2RScNKtnsdZ03nebOw0fQ_NbLLTcC41F_yCqza_Q>
    <xmx:xo10ZMx2B0SUcgWx04JrefZV3cdm1ZF5agam8fhSjoj0OYKUej_dLQ>
    <xmx:x410ZMwwM3-tnzNtdKtE5qgu9iXmXCiaj6w5JzbZ-dB-yRaHvzQxEA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:29 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] firewire: cdev: implement new event to notify response subaction with time stamp
Date:   Mon, 29 May 2023 20:34:03 +0900
Message-Id: <20230529113406.986289-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
References: <20230529113406.986289-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callback function now receives an argument for time stamps relevant
to asynchronous transaction. This commit implements a new event to
notify response subaction with the time stamps for user space.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 96 ++++++++++++++++++++++++------------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 315ebc8c545d..8b24abdd51b8 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -172,6 +172,7 @@ struct outbound_transaction_event {
 	struct outbound_transaction_resource r;
 	union {
 		struct fw_cdev_event_response without_tstamp;
+		struct fw_cdev_event_response2 with_tstamp;
 	} rsp;
 };
 
@@ -538,41 +539,64 @@ static void release_transaction(struct client *client,
 {
 }
 
-static void complete_transaction(struct fw_card *card, int rcode,
-				 void *payload, size_t length, void *data)
+static void complete_transaction(struct fw_card *card, int rcode, u32 request_tstamp,
+				 u32 response_tstamp, void *payload, size_t length, void *data)
 {
 	struct outbound_transaction_event *e = data;
-	struct fw_cdev_event_response *rsp = &e->rsp.without_tstamp;
 	struct client *client = e->client;
 	unsigned long flags;
 
-	if (length < rsp->length)
-		rsp->length = length;
-	if (rcode == RCODE_COMPLETE)
-		memcpy(rsp->data, payload, rsp->length);
-
 	spin_lock_irqsave(&client->lock, flags);
 	idr_remove(&client->resource_idr, e->r.resource.handle);
 	if (client->in_shutdown)
 		wake_up(&client->tx_flush_wait);
 	spin_unlock_irqrestore(&client->lock, flags);
 
-	rsp->type = FW_CDEV_EVENT_RESPONSE;
-	rsp->rcode = rcode;
+	switch (e->rsp.without_tstamp.type) {
+	case FW_CDEV_EVENT_RESPONSE:
+	{
+		struct fw_cdev_event_response *rsp = &e->rsp.without_tstamp;
+
+		if (length < rsp->length)
+			rsp->length = length;
+		if (rcode == RCODE_COMPLETE)
+			memcpy(rsp->data, payload, rsp->length);
+
+		rsp->rcode = rcode;
+
+		// In the case that sizeof(*rsp) doesn't align with the position of the
+		// data, and the read is short, preserve an extra copy of the data
+		// to stay compatible with a pre-2.6.27 bug.  Since the bug is harmless
+		// for short reads and some apps depended on it, this is both safe
+		// and prudent for compatibility.
+		if (rsp->length <= sizeof(*rsp) - offsetof(typeof(*rsp), data))
+			queue_event(client, &e->event, rsp, sizeof(*rsp), rsp->data, rsp->length);
+		else
+			queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length, NULL, 0);
 
-	/*
-	 * In the case that sizeof(*rsp) doesn't align with the position of the
-	 * data, and the read is short, preserve an extra copy of the data
-	 * to stay compatible with a pre-2.6.27 bug.  Since the bug is harmless
-	 * for short reads and some apps depended on it, this is both safe
-	 * and prudent for compatibility.
-	 */
-	if (rsp->length <= sizeof(*rsp) - offsetof(typeof(*rsp), data))
-		queue_event(client, &e->event, rsp, sizeof(*rsp),
-			    rsp->data, rsp->length);
-	else
-		queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length,
-			    NULL, 0);
+		break;
+	}
+	case FW_CDEV_EVENT_RESPONSE2:
+	{
+		struct fw_cdev_event_response2 *rsp = &e->rsp.with_tstamp;
+
+		if (length < rsp->length)
+			rsp->length = length;
+		if (rcode == RCODE_COMPLETE)
+			memcpy(rsp->data, payload, rsp->length);
+
+		rsp->rcode = rcode;
+		rsp->request_tstamp = request_tstamp;
+		rsp->response_tstamp = response_tstamp;
+
+		queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length, NULL, 0);
+
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+	}
 
 	/* Drop the idr's reference */
 	client_put(client);
@@ -583,7 +607,6 @@ static int init_request(struct client *client,
 			int destination_id, int speed)
 {
 	struct outbound_transaction_event *e;
-	struct fw_cdev_event_response *rsp;
 	void *payload;
 	int ret;
 
@@ -600,10 +623,21 @@ static int init_request(struct client *client,
 		return -ENOMEM;
 	e->client = client;
 
-	rsp = &e->rsp.without_tstamp;
-	rsp->length = request->length;
-	rsp->closure = request->closure;
-	payload = rsp->data;
+	if (client->version < FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP) {
+		struct fw_cdev_event_response *rsp = &e->rsp.without_tstamp;
+
+		rsp->type = FW_CDEV_EVENT_RESPONSE;
+		rsp->length = request->length;
+		rsp->closure = request->closure;
+		payload = rsp->data;
+	} else {
+		struct fw_cdev_event_response2 *rsp = &e->rsp.with_tstamp;
+
+		rsp->type = FW_CDEV_EVENT_RESPONSE2;
+		rsp->length = request->length;
+		rsp->closure = request->closure;
+		payload = rsp->data;
+	}
 
 	if (request->data && copy_from_user(payload, u64_to_uptr(request->data), request->length)) {
 		ret = -EFAULT;
@@ -615,9 +649,9 @@ static int init_request(struct client *client,
 	if (ret < 0)
 		goto failed;
 
-	fw_send_request(client->device->card, &e->r.transaction, request->tcode, destination_id,
-			request->generation, speed, request->offset, payload, request->length,
-			complete_transaction, e);
+	fw_send_request_with_tstamp(client->device->card, &e->r.transaction, request->tcode,
+				    destination_id, request->generation, speed, request->offset,
+				    payload, request->length, complete_transaction, e);
 	return 0;
 
  failed:
-- 
2.39.2

