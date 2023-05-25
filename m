Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A825D7109ED
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbjEYKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240923AbjEYKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:21 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85A8E45
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 323365C0360;
        Thu, 25 May 2023 06:16:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 May 2023 06:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009802; x=
        1685096202; bh=19oDU4fEk+sheHYZWOnoN5cHboklhnnlKJrCnG0DjSI=; b=r
        BcmxBjGPa1eBGC55TNvobO2r/EacjmyELkVNJjhNSrrsdqhMUQjGjHbEbHtzkpag
        BKKj2nUCyldCEcOO15mV8bgnbrr3n6vXwqua9BkYOUcp3sKp/TzoM3Mmr5uhVcZV
        JZnn5sog2scuNy+fyoopUzm4MWV6NN7cvpO1K/eY9u2ypczIsfNE3yIm99BqF/1A
        FakuQc+Qo3IOxaXWmk9nCS6aQ9GPfIP9lV2tzgK/Cntu4iYtcDclrNq/Op9pqJtl
        zVe6Zr9HIK0YdoDkVZrCbkPjG5MF1NVIipQtE9nCofZCyx1e1eE81wbl0QZMskkL
        5lJymfrr2Hs7QBU0keIJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009802; x=1685096202; bh=1
        9oDU4fEk+sheHYZWOnoN5cHboklhnnlKJrCnG0DjSI=; b=Oba7zdEb4kSo36YfS
        uIefAHiT5zoGkmJxoesxCekOJJ/x29uz9n3kRQM2nikLOnmOug3omkdHy/v+MDgp
        FaNNcugGG3/dx25TxkDIndNZ7r28xSGButJYDGo9KXMziNcGPm0QqiLAdR01ENsu
        /w3RiMSbbZIdAJrqochccTMCq5fDgCVVH2EnbQdCecNF1qzhLHYQFgFSyC87cMRR
        HwWWiKGM7N9p8jAfWvOxNTnuWUcAL2MjF80/kWJq60wRaK9prlsI33vGOHz5f7ML
        w+Ne/YCS5ByLy57CdPiidttssGTjJNTMOJH08At4xN150jPIFG8n9BoHlFZChmNa
        +pH1A==
X-ME-Sender: <xms:ijVvZEy_JTqJ4VyqDMDxOgHPCHp1RP7znIPmoonMLpvtVwvExwiiNA>
    <xme:ijVvZITX9jU9z3546ax1iaOsblMtjSq1MetvmanIXyYoLG8_1r7DGaCMfX_AWuB_I
    X1yxFSaBpR1kVgs-Kg>
X-ME-Received: <xmr:ijVvZGWzytwpwmEFq1Lvl6Je1V9vCHnFyBZAsVLmvfWjlKwWzRk0HnyHMuApAAhuAKRGOmxO8dhGEGbbfCwTqf_24p48qATAo-iWy9VLCExmGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ijVvZCiMelv9h1xiw_AlH6ZlBPisnYfKz3hr6DmPgL6XPxEWCvacDQ>
    <xmx:ijVvZGBhPS5cWsyy7pFJBx9ijOOu3RpyWBr0VHBAgN7zglddr1IFVg>
    <xmx:ijVvZDJSBVtaWKGYw5j1cWZV4HBVKgJAPSpTSkYFg-qjZ0Dqtfgfkg>
    <xmx:ijVvZBr4cixshRFshzLNq0Y5IRJue5awdtUqNSnGYue157xkdhEdDA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:41 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] firewire: cdev: implement new event to notify response subaction with time stamp
Date:   Thu, 25 May 2023 19:16:22 +0900
Message-Id: <20230525101625.888906-10-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525101625.888906-1-o-takashi@sakamocchi.jp>
References: <20230525101625.888906-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

