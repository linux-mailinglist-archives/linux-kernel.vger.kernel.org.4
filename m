Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F05C7109E8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbjEYKRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240896AbjEYKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C5D139
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DD9E85C02D3;
        Thu, 25 May 2023 06:16:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 25 May 2023 06:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009796; x=
        1685096196; bh=hOQR9q6EZS1DH1YormYT1kFTGnL+BePtUImO4q3mnKw=; b=g
        r7hJ3vQm5QJME7340Sc4YOiTBy8PFPziGNXeIP3aH1d2oOIJh1EysP8CDBze8RVE
        IR7b+hVYG9XoBT4Mo5Xk8xFlJlxXb4YGNei3cLWe1cI1QHS4KtYVa30nx2sgTDUV
        CR0Fl5e+21oO8NwzLQAwHvqoEQPXMJnSHnkaf6f/rN/enLBTj/ffnjVOJOgViewb
        aGd5OxzPRa4r5DZ9Y0SJp0nbuIzQj/jDR2xYzp9siCJa3MbOU4gYcTYZQHPb8yBP
        NW3bvrzpCRYc9GCPUF4rVZH4fkJnoRt43KV7HjyLTnIUUvJVpdHwp83Z5s/pHtUF
        iltevI/SPI4EmDw7FEs9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009796; x=1685096196; bh=h
        OQR9q6EZS1DH1YormYT1kFTGnL+BePtUImO4q3mnKw=; b=LN7GnfEnUGzZRK5D6
        pK9987dlhXbcZBACuvDueol19Gtj0wnnw41bPSeC4+2jfWeHrNOya+x3XJHqSY7H
        1UqPA2r0tder52PtzpwQ3ehHtS2mF6WKqvoqlkfwaxIEaw/OTjYDyj+8T9OGhFdP
        7X+heh3WD9ynbsFA3F2JCYFwHMGBkvxJWSZmysT/0SmSu9iN1p3SclI2mRsB5/9L
        1yvQGYYwfdmLN7wg8xKnmWhKvEEmxNgdS4uFw7As990Je29fMPQTF2XMgXSbTNJI
        qSwES/xj540QBmBhOGqWRrjF05JvZPlkHkotwHUNkubfAlEjggeSStQ/fLyc6ca+
        npC4Q==
X-ME-Sender: <xms:hDVvZKLyziJ8uvTz8Vvx-OvGc8JzjuTtd4w6kzhhDwMA0W4IOMYxOw>
    <xme:hDVvZCL3aDFlHgwYNnO3pzoUJgWy1XgAJEfS9Zo1kSyLpmXNkntKlB_8rzkLqJ5A8
    7Uv-5I1NOZgVGzdid8>
X-ME-Received: <xmr:hDVvZKsdcp5YPHDPREAX2Rl0Ad9kmsrZZMi1K-XaF8JshHw7N07K_1V_ofd2Ci9G7TSvq8bugTqp7eplppGotn9gVcicGea6vWuhnAyGS3rplA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:hDVvZPavxeUdcygxVM3UforPgVetm-7SzbWbYz-KsCtOglT-tUukOA>
    <xmx:hDVvZBa0TjiuhUxpVx-3l8MJo1nqCJ4W84dPb8gUmIOI84-NBFhGKg>
    <xmx:hDVvZLANfUi61RQKEi7wwWriTf5LWsGkYZgxgWJWOCap78O1BEktVQ>
    <xmx:hDVvZCAlJ_R3mu0iI-dinftAcXNNiiU8fANwKCMO5ycSBnQa4wc2aA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:35 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/12] firewire: core: use union for callback of transaction completion
Date:   Thu, 25 May 2023 19:16:18 +0900
Message-Id: <20230525101625.888906-6-o-takashi@sakamocchi.jp>
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

In 1394 OHCI, the OUTPUT_LAST descriptor of Asynchronous Transmit (AT)
request context has timeStamp field, in which 1394 OHCI controller
record the isochronous cycle when the packet was sent for the request
subaction. Additionally, for the case of split transaction in IEEE 1394,
Asynchronous Receive (AT) request context is used for response subaction
to finish the transaction. The trailer quadlet of descriptor in the
context has timeStamp field, in which 1394 OHCI controller records the
isochronous cycle when the packet arrived.

Current implementation of 1394 OHCI controller driver stores values of
both fields to internal structure as time stamp, while Linux FireWire
subsystem provides no way to access to it. When using asynchronous
transaction service provided by the subsystem, callback function is passed
to kernel API. The prototype of callback function has the lack of argument
for the values.

This commit adds a new callback function for the purpose. It has an
additional argument to point to the constant array with two elements. For
backward compatibility to kernel space, a new union is also adds to wrap
two different prototype of callback function. The fw_transaction structure
has the union as a member and a boolean flag to express which function
callback is available.

The core function is changed to handle the two cases; with or without
time stamp. For the error path to process transaction, the isochronous
cycle is computed by current value of CYCLE_TIMER register in 1394 OHCI
controller. Especially for the case of timeout of split transaction, the
expected isochronous cycle is computed.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 58 +++++++++++++++++++++++------
 drivers/firewire/core.h             |  7 ++++
 drivers/firewire/ohci.c             | 17 ++++++++-
 include/linux/firewire.h            | 13 ++++++-
 4 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a9f70c96323e..a20f97fdd06c 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -70,8 +70,8 @@ static int try_cancel_split_timeout(struct fw_transaction *t)
 		return 1;
 }
 
-static int close_transaction(struct fw_transaction *transaction,
-			     struct fw_card *card, int rcode)
+static int close_transaction(struct fw_transaction *transaction, struct fw_card *card, int rcode,
+			     u32 response_tstamp)
 {
 	struct fw_transaction *t = NULL, *iter;
 	unsigned long flags;
@@ -92,7 +92,12 @@ static int close_transaction(struct fw_transaction *transaction,
 	spin_unlock_irqrestore(&card->lock, flags);
 
 	if (t) {
-		t->callback(card, rcode, NULL, 0, t->callback_data);
+		if (!t->with_tstamp) {
+			t->callback.without_tstamp(card, rcode, NULL, 0, t->callback_data);
+		} else {
+			t->callback.with_tstamp(card, rcode, t->packet.timestamp, response_tstamp,
+						NULL, 0, t->callback_data);
+		}
 		return 0;
 	}
 
@@ -107,6 +112,8 @@ static int close_transaction(struct fw_transaction *transaction,
 int fw_cancel_transaction(struct fw_card *card,
 			  struct fw_transaction *transaction)
 {
+	u32 tstamp;
+
 	/*
 	 * Cancel the packet transmission if it's still queued.  That
 	 * will call the packet transmission callback which cancels
@@ -121,7 +128,17 @@ int fw_cancel_transaction(struct fw_card *card,
 	 * if the transaction is still pending and remove it in that case.
 	 */
 
-	return close_transaction(transaction, card, RCODE_CANCELLED);
+	if (transaction->packet.ack == 0) {
+		// The timestamp is reused since it was just read now.
+		tstamp = transaction->packet.timestamp;
+	} else {
+		u32 curr_cycle_time = 0;
+
+		(void)fw_card_read_cycle_time(card, &curr_cycle_time);
+		tstamp = cycle_time_to_ohci_tstamp(curr_cycle_time);
+	}
+
+	return close_transaction(transaction, card, RCODE_CANCELLED, tstamp);
 }
 EXPORT_SYMBOL(fw_cancel_transaction);
 
@@ -140,7 +157,12 @@ static void split_transaction_timeout_callback(struct timer_list *timer)
 	card->tlabel_mask &= ~(1ULL << t->tlabel);
 	spin_unlock_irqrestore(&card->lock, flags);
 
-	t->callback(card, RCODE_CANCELLED, NULL, 0, t->callback_data);
+	if (!t->with_tstamp) {
+		t->callback.without_tstamp(card, RCODE_CANCELLED, NULL, 0, t->callback_data);
+	} else {
+		t->callback.with_tstamp(card, RCODE_CANCELLED, t->packet.timestamp,
+					t->split_timeout_cycle, NULL, 0, t->callback_data);
+	}
 }
 
 static void start_split_transaction_timeout(struct fw_transaction *t,
@@ -162,6 +184,8 @@ static void start_split_transaction_timeout(struct fw_transaction *t,
 	spin_unlock_irqrestore(&card->lock, flags);
 }
 
+static u32 compute_split_timeout_timestamp(struct fw_card *card, u32 request_timestamp);
+
 static void transmit_complete_callback(struct fw_packet *packet,
 				       struct fw_card *card, int status)
 {
@@ -170,28 +194,32 @@ static void transmit_complete_callback(struct fw_packet *packet,
 
 	switch (status) {
 	case ACK_COMPLETE:
-		close_transaction(t, card, RCODE_COMPLETE);
+		close_transaction(t, card, RCODE_COMPLETE, packet->timestamp);
 		break;
 	case ACK_PENDING:
+	{
+		t->split_timeout_cycle =
+			compute_split_timeout_timestamp(card, packet->timestamp) & 0xffff;
 		start_split_transaction_timeout(t, card);
 		break;
+	}
 	case ACK_BUSY_X:
 	case ACK_BUSY_A:
 	case ACK_BUSY_B:
-		close_transaction(t, card, RCODE_BUSY);
+		close_transaction(t, card, RCODE_BUSY, packet->timestamp);
 		break;
 	case ACK_DATA_ERROR:
-		close_transaction(t, card, RCODE_DATA_ERROR);
+		close_transaction(t, card, RCODE_DATA_ERROR, packet->timestamp);
 		break;
 	case ACK_TYPE_ERROR:
-		close_transaction(t, card, RCODE_TYPE_ERROR);
+		close_transaction(t, card, RCODE_TYPE_ERROR, packet->timestamp);
 		break;
 	default:
 		/*
 		 * In this case the ack is really a juju specific
 		 * rcode, so just forward that to the callback.
 		 */
-		close_transaction(t, card, status);
+		close_transaction(t, card, status, packet->timestamp);
 		break;
 	}
 }
@@ -363,7 +391,8 @@ void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
 	t->is_split_transaction = false;
 	timer_setup(&t->split_timeout_timer,
 		    split_transaction_timeout_callback, 0);
-	t->callback = callback;
+	t->callback.without_tstamp = callback;
+	t->with_tstamp = false;
 	t->callback_data = callback_data;
 
 	fw_fill_request(&t->packet, tcode, t->tlabel,
@@ -1047,7 +1076,12 @@ void fw_core_handle_response(struct fw_card *card, struct fw_packet *p)
 	 */
 	card->driver->cancel_packet(card, &t->packet);
 
-	t->callback(card, rcode, data, data_length, t->callback_data);
+	if (!t->with_tstamp) {
+		t->callback.without_tstamp(card, rcode, data, data_length, t->callback_data);
+	} else {
+		t->callback.with_tstamp(card, rcode, t->packet.timestamp, p->timestamp, data,
+					data_length, t->callback_data);
+	}
 }
 EXPORT_SYMBOL(fw_core_handle_response);
 
diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
index eafa4eaae737..2a05f411328f 100644
--- a/drivers/firewire/core.h
+++ b/drivers/firewire/core.h
@@ -247,6 +247,13 @@ void fw_fill_response(struct fw_packet *response, u32 *request_header,
 void fw_request_get(struct fw_request *request);
 void fw_request_put(struct fw_request *request);
 
+// Convert the value of IEEE 1394 CYCLE_TIME register to the format of timeStamp field in
+// descriptors of 1394 OHCI.
+static inline u32 cycle_time_to_ohci_tstamp(u32 tstamp)
+{
+	return (tstamp & 0x0ffff000) >> 12;
+}
+
 #define FW_PHY_CONFIG_NO_NODE_ID	-1
 #define FW_PHY_CONFIG_CURRENT_GAP_COUNT	-1
 void fw_send_phy_config(struct fw_card *card,
diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 17c9d825188b..06386c3b7f03 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -1623,6 +1623,8 @@ static void handle_local_request(struct context *ctx, struct fw_packet *packet)
 	}
 }
 
+static u32 get_cycle_time(struct fw_ohci *ohci);
+
 static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 {
 	unsigned long flags;
@@ -1633,6 +1635,10 @@ static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 	if (HEADER_GET_DESTINATION(packet->header[0]) == ctx->ohci->node_id &&
 	    ctx->ohci->generation == packet->generation) {
 		spin_unlock_irqrestore(&ctx->ohci->lock, flags);
+
+		// Timestamping on behalf of the hardware.
+		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ctx->ohci));
+
 		handle_local_request(ctx, packet);
 		return;
 	}
@@ -1640,9 +1646,12 @@ static void at_context_transmit(struct context *ctx, struct fw_packet *packet)
 	ret = at_context_queue_packet(ctx, packet);
 	spin_unlock_irqrestore(&ctx->ohci->lock, flags);
 
-	if (ret < 0)
-		packet->callback(packet, &ctx->ohci->card, packet->ack);
+	if (ret < 0) {
+		// Timestamping on behalf of the hardware.
+		packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ctx->ohci));
 
+		packet->callback(packet, &ctx->ohci->card, packet->ack);
+	}
 }
 
 static void detect_dead_context(struct fw_ohci *ohci,
@@ -2557,6 +2566,10 @@ static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 	log_ar_at_event(ohci, 'T', packet->speed, packet->header, 0x20);
 	driver_data->packet = NULL;
 	packet->ack = RCODE_CANCELLED;
+
+	// Timestamping on behalf of the hardware.
+	packet->timestamp = cycle_time_to_ohci_tstamp(get_cycle_time(ohci));
+
 	packet->callback(packet, &ohci->card, packet->ack);
 	ret = 0;
  out:
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 1716c01c4e54..d61693341da1 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -261,6 +261,15 @@ typedef void (*fw_packet_callback_t)(struct fw_packet *packet,
 typedef void (*fw_transaction_callback_t)(struct fw_card *card, int rcode,
 					  void *data, size_t length,
 					  void *callback_data);
+typedef void (*fw_transaction_callback_with_tstamp_t)(struct fw_card *card, int rcode,
+					u32 request_tstamp, u32 response_tstamp, void *data,
+					size_t length, void *callback_data);
+
+union fw_transaction_callback {
+	fw_transaction_callback_t without_tstamp;
+	fw_transaction_callback_with_tstamp_t with_tstamp;
+};
+
 /*
  * This callback handles an inbound request subaction.  It is called in
  * RCU read-side context, therefore must not sleep.
@@ -312,6 +321,7 @@ struct fw_transaction {
 	struct fw_card *card;
 	bool is_split_transaction;
 	struct timer_list split_timeout_timer;
+	u32 split_timeout_cycle;
 
 	struct fw_packet packet;
 
@@ -319,7 +329,8 @@ struct fw_transaction {
 	 * The data passed to the callback is valid only during the
 	 * callback.
 	 */
-	fw_transaction_callback_t callback;
+	union fw_transaction_callback callback;
+	bool with_tstamp;
 	void *callback_data;
 };
 
-- 
2.39.2

