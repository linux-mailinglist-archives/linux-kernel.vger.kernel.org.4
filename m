Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A140767B22C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbjAYMDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbjAYMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:16 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0924B56EE3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 63D805C01B5;
        Wed, 25 Jan 2023 07:03:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 25 Jan 2023 07:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648194; x=
        1674734594; bh=Lh823ox4xQVLDrtgezk53A8XHMzDS8P8L+Vhf9BFKyo=; b=S
        4cU5eaxiMpzHoQ28J59/Dn97cmTI8UseH4oA8MhJtqG8zgXo4ky6drRWLyIcKBDl
        hLBP38LMM3ETaoyFe8l2ZiibLifTI8KU/aqf+TYJG+yKt69vBoMJSYPry/3Y3WQT
        VfRdQ+A7cNoYDrthvINWeFw1fh69L874ITvlKn/JKKmfs0PocSUvasATKsmeAMwP
        i/Jd7f5R3k5GQTe1s2oxcw927WA0O+o9U/8UTV2PJgy8PJVUsNm/4luC76QrJcsH
        sqWCChDpj/Qkv/U2iq0CTwE6LX43hUiqlMl7S8WB5O8kojvq/uA4sREU6QNEoxp3
        DsuUykvkUaHAWi9g8Npnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648194; x=1674734594; bh=Lh823ox4xQVLD
        rtgezk53A8XHMzDS8P8L+Vhf9BFKyo=; b=UV7tFSxmQ3HB8KTTHZhbDKeVBEkYO
        jMml0NH3R0hkGZHLqDpj3W7NwRGJYHYXl272AsIYIO/UNHnznGqKyT34/DFCQija
        YPzNJ0/Ik6vDIRX/RP/KLQlaqx3IfFauXP3Iuujy97XCahQ1g+64y8v1zjSW1ROd
        pklUOWZcGYxffLFsMXK3s2GLrbGlXaVjZOR1Ih1m0BIid/mTLgF6uwDnkuejY6Xf
        YcW/G7KCB9DME1gsDiqk8ic7NdmrpAvmfIqsQ0dsuHJkuoFa6xVfuiIIYVsjdrET
        dlIXbyI9845qpf2LpFGicw3RkYdgC3z3PqD3JoTJXWmH0ACPr7h26/8vQ==
X-ME-Sender: <xms:ghrRY8VwVKxvL6DCdPpvoZbQBRQu99CkhtU3vkCd6lofS-gD5Pmr7w>
    <xme:ghrRYwke11BptBSdDOrsRuBPnZ-TnWd7x_hPxVz1wUaCD1ebJHjC9Jdg-Ejj7-qLH
    jdKPRnUqMATFt3sL5Q>
X-ME-Received: <xmr:ghrRYwY4QCY4wiHGnsiyzAw_-R72C3JH9VvsLE0J6PeFSAhC5W1JO7EUJLOrNnmYCuYZUbVhfxlyzHnM68lLvFQcsrEqRscdvAOmHILQPqaNkzIwhHIyp0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ghrRY7WqGBqRwMFKwMyXaXrIkCvqmGLWYZV3Z2MQ1RcLfiwWDUqMGw>
    <xmx:ghrRY2kR_9YnsVSvhqsGW3WPcEjV6EQdD9eZkPKuKZZgSXhGh9dq4w>
    <xmx:ghrRYwdc8U-laz_AyJhWqz3KKC4V3yWD5l3MaFeh8f14yfam_l316Q>
    <xmx:ghrRY7yCqZqKcaISYzzzkHUZ5ehfT27tfVFH91YKbjnTYMNNomdYjg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:13 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 05/11] firewire: core: implement variations to send request and wait for response with time stamp
Date:   Wed, 25 Jan 2023 21:02:55 +0900
Message-Id: <20230125120301.51585-6-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
References: <20230125120301.51585-1-o-takashi@sakamocchi.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the previous commit, the core function of Linux FireWire subsystem
was changed for two cases to operate asynchronous transaction with or
without time stamp.

This commit changes kernel API for the two cases. Current kernel API,
fw_send_request(), is changed to be static inline function to call
__fw_send_request(), which receives two argument for union and flag of
callback function. The new kernel API, fw_send_request_with_tstamp() is
also added as static inline function, too. When calling, the two
arguments are copied to internal structure, then used in softIRQ
context.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-transaction.c | 41 +++++++++++------
 include/linux/firewire.h            | 69 +++++++++++++++++++++++++++--
 2 files changed, 92 insertions(+), 18 deletions(-)

diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index a20f97fdd06c..130b95aca629 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -316,7 +316,8 @@ static int allocate_tlabel(struct fw_card *card)
 }
 
 /**
- * fw_send_request() - submit a request packet for transmission
+ * __fw_send_request() - submit a request packet for transmission to generate callback for response
+ *			 subaction with or without time stamp.
  * @card:		interface to send the request at
  * @t:			transaction instance to which the request belongs
  * @tcode:		transaction code
@@ -326,7 +327,9 @@ static int allocate_tlabel(struct fw_card *card)
  * @offset:		48bit wide offset into destination's address space
  * @payload:		data payload for the request subaction
  * @length:		length of the payload, in bytes
- * @callback:		function to be called when the transaction is completed
+ * @callback:		union of two functions whether to receive time stamp or not for response
+ *			subaction.
+ * @with_tstamp:	Whether to receive time stamp or not for response subaction.
  * @callback_data:	data to be passed to the transaction completion callback
  *
  * Submit a request packet into the asynchronous request transmission queue.
@@ -363,10 +366,10 @@ static int allocate_tlabel(struct fw_card *card)
  * transaction completion and hence execution of @callback may happen even
  * before fw_send_request() returns.
  */
-void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
-		     int destination_id, int generation, int speed,
-		     unsigned long long offset, void *payload, size_t length,
-		     fw_transaction_callback_t callback, void *callback_data)
+void __fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
+		int destination_id, int generation, int speed, unsigned long long offset,
+		void *payload, size_t length, union fw_transaction_callback callback,
+		bool with_tstamp, void *callback_data)
 {
 	unsigned long flags;
 	int tlabel;
@@ -381,7 +384,19 @@ void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
 	tlabel = allocate_tlabel(card);
 	if (tlabel < 0) {
 		spin_unlock_irqrestore(&card->lock, flags);
-		callback(card, RCODE_SEND_ERROR, NULL, 0, callback_data);
+		if (!with_tstamp) {
+			callback.without_tstamp(card, RCODE_SEND_ERROR, NULL, 0, callback_data);
+		} else {
+			// Timestamping on behalf of hardware.
+			u32 curr_cycle_time = 0;
+			u32 tstamp;
+
+			(void)fw_card_read_cycle_time(card, &curr_cycle_time);
+			tstamp = cycle_time_to_ohci_tstamp(curr_cycle_time);
+
+			callback.with_tstamp(card, RCODE_SEND_ERROR, tstamp, tstamp, NULL, 0,
+					     callback_data);
+		}
 		return;
 	}
 
@@ -389,14 +404,12 @@ void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
 	t->tlabel = tlabel;
 	t->card = card;
 	t->is_split_transaction = false;
-	timer_setup(&t->split_timeout_timer,
-		    split_transaction_timeout_callback, 0);
-	t->callback.without_tstamp = callback;
-	t->with_tstamp = false;
+	timer_setup(&t->split_timeout_timer, split_transaction_timeout_callback, 0);
+	t->callback = callback;
+	t->with_tstamp = with_tstamp;
 	t->callback_data = callback_data;
 
-	fw_fill_request(&t->packet, tcode, t->tlabel,
-			destination_id, card->node_id, generation,
+	fw_fill_request(&t->packet, tcode, t->tlabel, destination_id, card->node_id, generation,
 			speed, offset, payload, length);
 	t->packet.callback = transmit_complete_callback;
 
@@ -406,7 +419,7 @@ void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
 
 	card->driver->send_request(card, &t->packet);
 }
-EXPORT_SYMBOL(fw_send_request);
+EXPORT_SYMBOL_GPL(__fw_send_request);
 
 struct transaction_callback_data {
 	struct completion done;
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index 365a07783604..962afd24c7ca 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -365,10 +365,71 @@ void fw_send_response(struct fw_card *card,
 		      struct fw_request *request, int rcode);
 int fw_get_request_speed(struct fw_request *request);
 u32 fw_request_get_timestamp(const struct fw_request *request);
-void fw_send_request(struct fw_card *card, struct fw_transaction *t,
-		     int tcode, int destination_id, int generation, int speed,
-		     unsigned long long offset, void *payload, size_t length,
-		     fw_transaction_callback_t callback, void *callback_data);
+
+void __fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
+		int destination_id, int generation, int speed, unsigned long long offset,
+		void *payload, size_t length, union fw_transaction_callback callback,
+		bool with_tstamp, void *callback_data);
+
+/**
+ * fw_send_request() - submit a request packet for transmission to generate callback for response
+ *		       subaction without time stamp.
+ * @card:		interface to send the request at
+ * @t:			transaction instance to which the request belongs
+ * @tcode:		transaction code
+ * @destination_id:	destination node ID, consisting of bus_ID and phy_ID
+ * @generation:		bus generation in which request and response are valid
+ * @speed:		transmission speed
+ * @offset:		48bit wide offset into destination's address space
+ * @payload:		data payload for the request subaction
+ * @length:		length of the payload, in bytes
+ * @callback:		function to be called when the transaction is completed
+ * @callback_data:	data to be passed to the transaction completion callback
+ *
+ * A variation of __fw_send_request() to generate callback for response subaction without time
+ * stamp.
+ */
+static inline void fw_send_request(struct fw_card *card, struct fw_transaction *t, int tcode,
+				   int destination_id, int generation, int speed,
+				   unsigned long long offset, void *payload, size_t length,
+				   fw_transaction_callback_t callback, void *callback_data)
+{
+	union fw_transaction_callback cb = {
+		.without_tstamp = callback,
+	};
+	__fw_send_request(card, t, tcode, destination_id, generation, speed, offset, payload,
+			  length, cb, false, callback_data);
+}
+
+/**
+ * fw_send_request_with_tstamp() - submit a request packet for transmission to generate callback for
+ *				   response with time stamp.
+ * @card:		interface to send the request at
+ * @t:			transaction instance to which the request belongs
+ * @tcode:		transaction code
+ * @destination_id:	destination node ID, consisting of bus_ID and phy_ID
+ * @generation:		bus generation in which request and response are valid
+ * @speed:		transmission speed
+ * @offset:		48bit wide offset into destination's address space
+ * @payload:		data payload for the request subaction
+ * @length:		length of the payload, in bytes
+ * @callback:		function to be called when the transaction is completed
+ * @callback_data:	data to be passed to the transaction completion callback
+ *
+ * A variation of __fw_send_request() to generate callback for response subaction with time stamp.
+ */
+static inline void fw_send_request_with_tstamp(struct fw_card *card, struct fw_transaction *t,
+	int tcode, int destination_id, int generation, int speed, unsigned long long offset,
+	void *payload, size_t length, fw_transaction_callback_with_tstamp_t callback,
+	void *callback_data)
+{
+	union fw_transaction_callback cb = {
+		.with_tstamp = callback,
+	};
+	__fw_send_request(card, t, tcode, destination_id, generation, speed, offset, payload,
+			  length, cb, true, callback_data);
+}
+
 int fw_cancel_transaction(struct fw_card *card,
 			  struct fw_transaction *transaction);
 int fw_run_transaction(struct fw_card *card, int tcode, int destination_id,
-- 
2.37.2

