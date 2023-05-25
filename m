Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375F57109EF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbjEYKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjEYKRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:25 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000C8E46
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 709885C0185;
        Thu, 25 May 2023 06:16:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 25 May 2023 06:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009803; x=
        1685096203; bh=fzYN89ZMFMfUx+g08kllNmIdNawZyAy6SkyrK59Skkc=; b=F
        0VuqqdXAeFD4ribq3a6zoFeRVwEo3s2BwQFhQ5Ed1FFNHntqvVgbEXJwIW2RfcnQ
        oTCygI1KZUTfueidnzaoHwMgWmHYt8j/VFrgC3gLuMq4WILf+Z9fWzHX2XuKsE86
        tRjS73fhtVt9oil9SHTaVRmN/1DsFUKXUCo5xKw4sAPAR+uAG9SSYpE5/HdYCMWF
        pvdKNXPPp96tR4hDoFlHX8eeX37vsoNGQFQt5BExpzTGYP0EEs7Tz3/2/yu+gzXS
        h6sjd5c8QbC7kJvWWet0Pj7BN1R2Cfy8NIZvT47hIOnaxS4uAkg873Ad2hsB5yK4
        hT8SytrSFr5qJPtAWBdBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009803; x=1685096203; bh=f
        zYN89ZMFMfUx+g08kllNmIdNawZyAy6SkyrK59Skkc=; b=EazNkTfe58wOJhsQA
        AAgUGJff6YdfIjNEzwaaEB+ESLjBKx9oBQ0dXA1Tc3xr1QSniFFi6ZE69PTjHD6x
        Y6j5WuCU+NO4pea3Atkn5JfjwPIk0mMarcfThFSLhcTV+DnsWkBveASBfTPeShvL
        SgNkWS0AbhIkjYS5RuO3n2fc98zcFMVD0BxRkoz3Dz88onvJUbUrJIFnfUxP6JEM
        r/b5tDXeOS63dqyqJsKkLQtwZQ8Zur9mTiIcEjHOp9KgyTAxPfvd2Y2wac/lj578
        Wmz0MPZVYxYx7/vDOxAbPGk3Z8q7SDVEObPqiACBs+7+MDLCWzxrRWev3WGD2ni/
        RiddQ==
X-ME-Sender: <xms:izVvZJaJFB-iVruVguui2rOl91uPvIl1H7Qt6thLFBj5GTlwcR1BZg>
    <xme:izVvZAZ1meGXTfj0zpWWIen2fNmFn58hhpAd3oR4KVopYeOtxDXbRrR6H9gNQbZ8p
    OcRW2ptZV-KaRLfTk4>
X-ME-Received: <xmr:izVvZL-PYvpdobdcgkZ4RWMiT_EsW_I46JRWAFdzz3ORUe-csYg-4o-L6GdZ2C1-hg9ybUUFGgNDIHwbe-UjXPn73HVVfm0e2gcWajMN4I2hBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:izVvZHo6FJQWucAsIODFrEI9A16zrzsr2toOoBjB4A0ZThxyUV3HhQ>
    <xmx:izVvZEpG4ik0WEYJ-qi5d7K36RdE4YD2GKEIhqlAesRx8kcApKl27Q>
    <xmx:izVvZNQFnZnj9W01Ze4NRAxXlrsNi8Ba3WWtxEN37vZGgmMQduwGxg>
    <xmx:izVvZLRF5A1c-kc37_xIRldbccDH7SXmBeFEHtdn39TmiLGTh2avUg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:42 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/12] firewire: cdev: code refactoring to dispatch event for phy packet
Date:   Thu, 25 May 2023 19:16:23 +0900
Message-Id: <20230525101625.888906-11-o-takashi@sakamocchi.jp>
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

In 1394 OHCI, both Asynchronous Transmit (AT) and Asynchronous Receive
(AR) contexts are used to deliver the phy packet of IEEE 1394. The time
stamp is available as well as the usual asynchronous transaction.

This commit is a preparation for future commit to handle the time stamp.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 78 +++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 8b24abdd51b8..2220de3c945e 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -204,12 +204,16 @@ struct outbound_phy_packet_event {
 	struct event event;
 	struct client *client;
 	struct fw_packet p;
-	struct fw_cdev_event_phy_packet phy_packet;
+	union {
+		struct fw_cdev_event_phy_packet without_tstamp;
+	} phy_packet;
 };
 
 struct inbound_phy_packet_event {
 	struct event event;
-	struct fw_cdev_event_phy_packet phy_packet;
+	union {
+		struct fw_cdev_event_phy_packet without_tstamp;
+	} phy_packet;
 };
 
 #ifdef CONFIG_COMPAT
@@ -1549,26 +1553,41 @@ static void outbound_phy_packet_callback(struct fw_packet *packet,
 {
 	struct outbound_phy_packet_event *e =
 		container_of(packet, struct outbound_phy_packet_event, p);
-	struct client *e_client;
+	struct client *e_client = e->client;
+	u32 rcode;
+	struct fw_cdev_event_phy_packet *pp;
 
 	switch (status) {
-	/* expected: */
-	case ACK_COMPLETE:	e->phy_packet.rcode = RCODE_COMPLETE;	break;
-	/* should never happen with PHY packets: */
-	case ACK_PENDING:	e->phy_packet.rcode = RCODE_COMPLETE;	break;
+	// expected:
+	case ACK_COMPLETE:
+		rcode = RCODE_COMPLETE;
+		break;
+	// should never happen with PHY packets:
+	case ACK_PENDING:
+		rcode = RCODE_COMPLETE;
+		break;
 	case ACK_BUSY_X:
 	case ACK_BUSY_A:
-	case ACK_BUSY_B:	e->phy_packet.rcode = RCODE_BUSY;	break;
-	case ACK_DATA_ERROR:	e->phy_packet.rcode = RCODE_DATA_ERROR;	break;
-	case ACK_TYPE_ERROR:	e->phy_packet.rcode = RCODE_TYPE_ERROR;	break;
-	/* stale generation; cancelled; on certain controllers: no ack */
-	default:		e->phy_packet.rcode = status;		break;
+	case ACK_BUSY_B:
+		rcode = RCODE_BUSY;
+		break;
+	case ACK_DATA_ERROR:
+		rcode = RCODE_DATA_ERROR;
+		break;
+	case ACK_TYPE_ERROR:
+		rcode = RCODE_TYPE_ERROR;
+		break;
+	// stale generation; cancelled; on certain controllers: no ack
+	default:
+		rcode = status;
+		break;
 	}
-	e->phy_packet.data[0] = packet->timestamp;
 
-	e_client = e->client;
-	queue_event(e->client, &e->event, &e->phy_packet,
-		    sizeof(e->phy_packet) + e->phy_packet.length, NULL, 0);
+	pp = &e->phy_packet.without_tstamp;
+	pp->rcode = rcode;
+	pp->data[0] = packet->timestamp;
+	queue_event(e->client, &e->event, &e->phy_packet, sizeof(*pp) + pp->length, NULL, 0);
+
 	client_put(e_client);
 }
 
@@ -1577,6 +1596,7 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 	struct fw_cdev_send_phy_packet *a = &arg->send_phy_packet;
 	struct fw_card *card = client->device->card;
 	struct outbound_phy_packet_event *e;
+	struct fw_cdev_event_phy_packet *pp;
 
 	/* Access policy: Allow this ioctl only on local nodes' device files. */
 	if (!client->device->is_local)
@@ -1595,10 +1615,12 @@ static int ioctl_send_phy_packet(struct client *client, union ioctl_arg *arg)
 	e->p.header[2]		= a->data[1];
 	e->p.header_length	= 12;
 	e->p.callback		= outbound_phy_packet_callback;
-	e->phy_packet.closure	= a->closure;
-	e->phy_packet.type	= FW_CDEV_EVENT_PHY_PACKET_SENT;
+
+	pp = &e->phy_packet.without_tstamp;
+	pp->closure = a->closure;
+	pp->type = FW_CDEV_EVENT_PHY_PACKET_SENT;
 	if (is_ping_packet(a->data))
-			e->phy_packet.length = 4;
+		pp->length = 4;
 
 	card->driver->send_request(card, &e->p);
 
@@ -1633,18 +1655,20 @@ void fw_cdev_handle_phy_packet(struct fw_card *card, struct fw_packet *p)
 	spin_lock_irqsave(&card->lock, flags);
 
 	list_for_each_entry(client, &card->phy_receiver_list, phy_receiver_link) {
+		struct fw_cdev_event_phy_packet *pp;
+
 		e = kmalloc(sizeof(*e) + 8, GFP_ATOMIC);
 		if (e == NULL)
 			break;
 
-		e->phy_packet.closure	= client->phy_receiver_closure;
-		e->phy_packet.type	= FW_CDEV_EVENT_PHY_PACKET_RECEIVED;
-		e->phy_packet.rcode	= RCODE_COMPLETE;
-		e->phy_packet.length	= 8;
-		e->phy_packet.data[0]	= p->header[1];
-		e->phy_packet.data[1]	= p->header[2];
-		queue_event(client, &e->event,
-			    &e->phy_packet, sizeof(e->phy_packet) + 8, NULL, 0);
+		pp = &e->phy_packet.without_tstamp;
+		pp->closure = client->phy_receiver_closure;
+		pp->type = FW_CDEV_EVENT_PHY_PACKET_RECEIVED;
+		pp->rcode = RCODE_COMPLETE;
+		pp->length = 8;
+		pp->data[0] = p->header[1];
+		pp->data[1] = p->header[2];
+		queue_event(client, &e->event, &e->phy_packet, sizeof(*pp) + 8, NULL, 0);
 	}
 
 	spin_unlock_irqrestore(&card->lock, flags);
-- 
2.39.2

