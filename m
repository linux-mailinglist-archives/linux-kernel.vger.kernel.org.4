Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC9E67B241
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbjAYMD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbjAYMDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:39 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F1458671
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:24 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8CCB55C01BD;
        Wed, 25 Jan 2023 07:03:23 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 25 Jan 2023 07:03:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648203; x=
        1674734603; bh=emwjPuAJA02+UQjUpJ9j6SBs61cts4zb343YeiC8Exw=; b=d
        qLEnG1ZrdLHsiaHZH7Se3GHhqs9Br/qGT+OGCKVkk1WJf1PB4HRHwu8k46120LIj
        PDH2waylB5SM/c2A+ki42oiziu0kS8+coqzRqsAiSZQ2gA1EUSGYucmX8DyefT0E
        ZqMsn54i7Y89l8FFex2XQyJ4HDlFO1ILUlE8s2T/gDVGEIGC4PD6D8nDC7DsNBhk
        Fnlz/kZmirHX3g21HBn3wa+29U0C61VCNJdUGl+Q+vyRzYc1OYg7MT/Z+wkSjH5D
        o+pJQOT+A8YNdti2Hbe1+zxWKSl9bCtotfN6HzAkJAte1NSiByPpmT+fmQoNLArF
        qSeQQKG5bA8mr3IHoJShw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648203; x=1674734603; bh=emwjPuAJA02+U
        QjUpJ9j6SBs61cts4zb343YeiC8Exw=; b=DpKHuLaiwd3eJEJYICQnRol7s+Ptu
        xXknM4A4Li1yjpuGRojoxJexGfFWGbGJvqoskK6UIZedwQJKI1rlRRczVzLW+ezM
        IoIt6vs0RPGUhOYvqmHxsEQuQcVo8fXKIjVPfkfE27zrOC+yyl3+5n+3M/dhRv+H
        ryuvEF80cQgUh9GaM7vD/o1o8L5waLHwRFJYpMwLLh0CLFv8zZQmH3Lq4eGN6CYk
        VNwzCNKX7VVIpcLEBlR+9JTmyAFu7jB3cN/eXk6frG4rf4Jz8jTtDhWuSJo5HIRB
        +iNwGPHd9/8jU30qZKUWOX6YkzvpEujAD6NER6Ybb8YhNvImpUNekXjlQ==
X-ME-Sender: <xms:ixrRY0S-3tzrGlVNlNYM_LVTNOlNIL_N3nwX69zoyOvgCKAua6MJig>
    <xme:ixrRYxw3btDGKVmzIcFt_wvRVFrQoDFevMOBVSRg5YSl78T2RQJuQk0gmy4a5eP_k
    B1z06SXlwz_DlmJO1I>
X-ME-Received: <xmr:ixrRYx33oNEBw5CdP1HGMBVmMA8kYwl-q86MnGTXKD87vah1kn98iCsRBjCN7BsIY6mlcguPx0W-RyZb-YzugRgJ5tdzqa1zCpIk20ffPRn7JWNz-pZajQE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:ixrRY4CxLBkkvhuO2afuXqPCUzcVUTA8AhLyEsn1i0yLo56yOkH6ZA>
    <xmx:ixrRY9hXxL2JVUMF9R2ixxFb17jlClKscQC8RSLFDJtsrWQK00ztMg>
    <xmx:ixrRY0oTjP_hARGD2gyMvEn9ZJAVi6zSMXXqKWERG4DdZu_1EhGc9w>
    <xmx:ixrRYwuI4f9425BldjjUg0OPbYpzDrX93e-4u8w56EMm5oSAzO-Gkw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:22 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 11/11] firewire: cdev: implement new event relevant to phy packet with time stamp
Date:   Wed, 25 Jan 2023 21:03:01 +0900
Message-Id: <20230125120301.51585-12-o-takashi@sakamocchi.jp>
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

In 1394 OHCI, the OUTPUT_LAST descriptor of Asynchronous Transmit (AT)
context has timeStamp field, in which 1394 OHCI controller record the
isochronous cycle when the packet was sent for the request subaction.
Additionally, the trailing quadlet of Asynchronous Receive (AR) context
has timeStamp field as well in which 1394 OHCI controller record the
isochronous cycle when the packet arrived. The time stamps are also
available for the cases to send and receive phy packet.

This commit implements new events with time stamp field for user space.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 90 +++++++++++++++++++++++++++---------
 1 file changed, 68 insertions(+), 22 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 2220de3c945e..6274b86eb943 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -206,6 +206,7 @@ struct outbound_phy_packet_event {
 	struct fw_packet p;
 	union {
 		struct fw_cdev_event_phy_packet without_tstamp;
+		struct fw_cdev_event_phy_packet2 with_tstamp;
 	} phy_packet;
 };
 
@@ -213,6 +214,7 @@ struct inbound_phy_packet_event {
 	struct event event;
 	union {
 		struct fw_cdev_event_phy_packet without_tstamp;
+		struct fw_cdev_event_phy_packet2 with_tstamp;
 	} phy_packet;
 };
 
@@ -1555,7 +1557,6 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 		container_of(packet, struct outbound_phy_packet_event, p);
 	struct client *e_client = e->client;
 	u32 rcode;
-	struct fw_cdev_event_phy_packet *pp;
 
 	switch (status) {
 	// expected:
@@ -1583,10 +1584,31 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 		break;
 	}
 
-	pp = &e->phy_packet.without_tstamp;
-	pp->rcode = rcode;
-	pp->data[0] = packet->timestamp;
-	queue_event(e->client, &e->event, &e->phy_packet, sizeof(*pp) + pp->length, NULL, 0);
+	switch (e->phy_packet.without_tstamp.type) {
+	case FW_CDEV_EVENT_PHY_PACKET_SENT:
+	{
+		struct fw_cdev_event_phy_packet *pp = &e->phy_packet.without_tstamp;
+
+		pp->rcode = rcode;
+		pp->data[0] = packet->timestamp;
+		queue_event(e->client, &e->event, &e->phy_packet, sizeof(*pp) + pp->length,
+			    NULL, 0);
+		break;
+	}
+	case FW_CDEV_EVENT_PHY_PACKET_SENT2:
+	{
+		struct fw_cdev_event_phy_packet2 *pp = &e->phy_packet.with_tstamp;
+
+		pp->rcode = rcode;
+		pp->tstamp = packet->timestamp;
+		queue_event(e->client, &e->event, &e->phy_packet, sizeof(*pp) + pp->length,
+			    NULL, 0);
+		break;
+	}
+	default:
+		WARN_ON(1);
+		break;
+	}
 
 	client_put(e_client);
 }
@@ -1596,13 +1618,12 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 	struct fw_cdev_send_phy_packet *a = &arg->send_phy_packet;
 	struct fw_card *card = client->device->card;
 	struct outbound_phy_packet_event *e;
-	struct fw_cdev_event_phy_packet *pp;
 
 	/* Access policy: Allow this ioctl only on local nodes' device files. */
 	if (!client->device->is_local)
 		return -ENOSYS;
 
-	e = kzalloc(sizeof(*e) + 4, GFP_KERNEL);
+	e = kzalloc(sizeof(*e) + sizeof(a->data), GFP_KERNEL);
 	if (e == NULL)
 		return -ENOMEM;
 
@@ -1616,11 +1637,23 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 	e->p.header_length	= 12;
 	e->p.callback		= outbound_phy_packet_callback;
 
-	pp = &e->phy_packet.without_tstamp;
-	pp->closure = a->closure;
-	pp->type = FW_CDEV_EVENT_PHY_PACKET_SENT;
-	if (is_ping_packet(a->data))
-		pp->length = 4;
+	if (client->version < FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP) {
+		struct fw_cdev_event_phy_packet *pp = &e->phy_packet.without_tstamp;
+
+		pp->closure = a->closure;
+		pp->type = FW_CDEV_EVENT_PHY_PACKET_SENT;
+		if (is_ping_packet(a->data))
+			pp->length = 4;
+	} else {
+		struct fw_cdev_event_phy_packet2 *pp = &e->phy_packet.with_tstamp;
+
+		pp->closure = a->closure;
+		pp->type = FW_CDEV_EVENT_PHY_PACKET_SENT2;
+		// Keep the data field so that application can match the response event to the
+		// request.
+		pp->length = sizeof(a->data);
+		memcpy(pp->data, a->data, sizeof(a->data));
+	}
 
 	card->driver->send_request(card, &e->p);
 
@@ -1655,20 +1688,33 @@ void fw_cdev_handle_phy_packet(struct fw_card *card, struct fw_packet *p)
 	spin_lock_irqsave(&card->lock, flags);
 
 	list_for_each_entry(client, &card->phy_receiver_list, phy_receiver_link) {
-		struct fw_cdev_event_phy_packet *pp;
-
 		e = kmalloc(sizeof(*e) + 8, GFP_ATOMIC);
 		if (e == NULL)
 			break;
 
-		pp = &e->phy_packet.without_tstamp;
-		pp->closure = client->phy_receiver_closure;
-		pp->type = FW_CDEV_EVENT_PHY_PACKET_RECEIVED;
-		pp->rcode = RCODE_COMPLETE;
-		pp->length = 8;
-		pp->data[0] = p->header[1];
-		pp->data[1] = p->header[2];
-		queue_event(client, &e->event, &e->phy_packet, sizeof(*pp) + 8, NULL, 0);
+		if (client->version < FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP) {
+			struct fw_cdev_event_phy_packet *pp = &e->phy_packet.without_tstamp;
+
+			pp->closure = client->phy_receiver_closure;
+			pp->type = FW_CDEV_EVENT_PHY_PACKET_RECEIVED;
+			pp->rcode = RCODE_COMPLETE;
+			pp->length = 8;
+			pp->data[0] = p->header[1];
+			pp->data[1] = p->header[2];
+			queue_event(client, &e->event, &e->phy_packet, sizeof(*pp) + 8, NULL, 0);
+		} else {
+			struct fw_cdev_event_phy_packet2 *pp = &e->phy_packet.with_tstamp;
+
+			pp = &e->phy_packet.with_tstamp;
+			pp->closure = client->phy_receiver_closure;
+			pp->type = FW_CDEV_EVENT_PHY_PACKET_RECEIVED2;
+			pp->rcode = RCODE_COMPLETE;
+			pp->length = 8;
+			pp->tstamp = p->timestamp;
+			pp->data[0] = p->header[1];
+			pp->data[1] = p->header[2];
+			queue_event(client, &e->event, &e->phy_packet, sizeof(*pp) + 8, NULL, 0);
+		}
 	}
 
 	spin_unlock_irqrestore(&card->lock, flags);
-- 
2.37.2

