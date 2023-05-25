Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64997109F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241001AbjEYKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjEYKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:45 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95363E51
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 11DCA5C0073;
        Thu, 25 May 2023 06:16:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 May 2023 06:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009806; x=
        1685096206; bh=CwMQ3mRgLz5XKiLhS8Bwc8Qm3NwjUti4uZQkCUexV3s=; b=X
        6ADm6VmVdvfMbXrcDmvKQF75wkZM1Y9gmHEjaOdUk0zeZ7sXuBp4j+V7/qjWut30
        ULMvUTP/Yx3X5oh2AZn98pzXFuAzqq2WzHMjZI5629/Z/XCq6+6igd1piOgHsImS
        LKAfrTkk9c3yiWoKGKMHwRF0XlsB49wOnlXZ+cg2cig5zyqbYxbPHh9E9w7U8p6V
        C8Ckk+WJue2suAlhCNn48uG2PRRajJGu8imzvuw79irtIgaJpNJmEmuCCQVZArvP
        1sr8eYZhOo6yrMF9cxrlzBKvqWlsudQ793uzKlZ6Y4w4fek4D72iYySDQIljLsWU
        o1Wkj6O1qtU8KuLVcLr8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009806; x=1685096206; bh=C
        wMQ3mRgLz5XKiLhS8Bwc8Qm3NwjUti4uZQkCUexV3s=; b=DY+SVeD85NeZ9wveQ
        L5SDs4ppqzV8x53QxsZi23SPlWTe084qAu/tQQR8oGjkDPjbODW8F+NHxACAW0zB
        z0Ns7A5m1wewrclY7Do388+MQzbFCmhwp/uau9uX5UpgD2EFbNzJ3dAhOLrnkeNW
        15j48ZbOwImtewdA1hhFe2N8WRf99w4nViz+kWfaghIuRE0kxKcVMzoQVqShd8zs
        zGYIs9u/pNPd+e9V+m5kbZSU8YHxWOXMoOR67u1J1eh7kWK6H1D6gVVB6QS5jaT7
        CHz74ZsgcYU1/zPLdqFLchuRyuBoyuUxbBfV9E+tunSG4leWiMr6Bxq0ES1v9vtl
        Ks+yw==
X-ME-Sender: <xms:jTVvZAEO3YBaoC6vJuzv_q4YJol0xuO4SfTK5L92hGM9e278_qI5ow>
    <xme:jTVvZJX4lYdgzOpSNcR0CdRD516vXRW3UQpeYoR1mnnWaUDhJW-5VS_YcaC-IwOh_
    JyeEf2x1tS1QnqkL54>
X-ME-Received: <xmr:jTVvZKIN7c4OhoUzeRreLFQFcVNDfmCgJW7FDyZDmGrXzlEd-g4FjaSFG6UP7bjSVtb-SpRxlSNalRwZs0zVf6fsYYEEdxZg1Q3m_T0Irp4Wfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:jTVvZCHGaWc57wKanTfcDP4J_5HJEurAQtPg7Jvv-vDv7agu06dR8A>
    <xmx:jTVvZGXGupAB4LwbHbyzvJw-5Xz6CUH-peyMYpHrGTHtqB1vReGLlw>
    <xmx:jTVvZFPTx2mmPzwlNefCElMvrLjND2Idw0XteO_uLs5ya1Vgyf080g>
    <xmx:jjVvZPd8vab4db_FGv9y8x1BhEar7bHPCpzc3IxP380KZDEdV6Z0BQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:44 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/12] firewire: cdev: implement new event relevant to phy packet with time stamp
Date:   Thu, 25 May 2023 19:16:25 +0900
Message-Id: <20230525101625.888906-13-o-takashi@sakamocchi.jp>
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
2.39.2

