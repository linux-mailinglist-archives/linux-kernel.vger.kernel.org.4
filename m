Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CA97148A6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjE2Lfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjE2LfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:35:22 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3DE0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8C4DF320093D;
        Mon, 29 May 2023 07:34:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 May 2023 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360077; x=
        1685446477; bh=CwMQ3mRgLz5XKiLhS8Bwc8Qm3NwjUti4uZQkCUexV3s=; b=V
        LGXMcp4ht63Clh35SxVozb6VFsiRHdaUNdo/RlE5pwuoyuK5Z6Tt+29HiJD+02TV
        kJ7TwOw3ZErysVCDPK1NlBfWygR82xnO6BV5BpQDlUkpix5qvKYiTgfen+jqL/4U
        UfN6qd0+6MCyRzWMHoJRl6q8Lkhc+88ioxOpVju37vEIlgBgVM3/dbq65fnWSZSJ
        bwE05tV545c/noUtZVdbN/Dh8n8sK/QiU3qyFRRxw26qVEW7RCPz2mKOG3jc2Z4z
        6rq3e5A+7wQkEL7H92nrJAY5PsEKzNgmNH/ijEXfIy4UZxF4dleT+Vhrn79zcrA2
        7G0tZTMguGXxv5JAfhGiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360077; x=1685446477; bh=C
        wMQ3mRgLz5XKiLhS8Bwc8Qm3NwjUti4uZQkCUexV3s=; b=WmWPabBhTVuCAushw
        3v5jJwLROWfCyXLe3wqDCLrgheYHcLC+06904VXoc0+ufYc8nJnvBCLts29SiQkN
        XQSOL3BI/LpE2F9maHT4Ukk9gk8/74vSTie2bWLi9KfWVQFmqFIyY/cpzmXjAy+a
        AUxRdTXOnl9cdNL4xK+m253WGeinqk6JSCZmZSNBoLsrv7hPpPNj4RkV6hiFEsz6
        PipHBRo8LCm8wP0hPUZ0V0tcO84nKIaISzAi24sDiWzNmq9UyCEpy79pem1TK4Gv
        xhxmQ3Dvp7jQqDob4BM8Q/9gL6D1F+143feO/EOkL4dTe6Te+iV/eFWlksEwc+k0
        CFNOA==
X-ME-Sender: <xms:zY10ZCx1ieC2SMDd1topAglSqmES8wSL9KvH3gdJvGJ7c-YhUy46GQ>
    <xme:zY10ZOSHUo6Mv9hxFJSrL8dPtxhmmHIYj6v8TWqK9p7bMP9sKb_tkBCDJK2-cR0D7
    jaYwG3hJjWLBQz_upg>
X-ME-Received: <xmr:zY10ZEUMy7RV5WY_2LKSxq6xyzb237-OF8awBYoqykSLJu2bj1ZaJGhce0sBmhYm7CUi1TeyqMjHwGSHvxhccSsvo4cIFKIhFYyWbYMWSEHPvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:zY10ZIij-dGOIjWSS4NuMXVfqvuS8TDhnVQXDQ9be5DD8gtQk0WXLQ>
    <xmx:zY10ZECV2p3C6sK27O65Rm43nw3mvYjvD7GbrLj4Ah8tdRISsjjtGA>
    <xmx:zY10ZJKoDzAan6UBFb8vdbTg0RE8TP-OKewHKk7dasrZL7f0UJWTEQ>
    <xmx:zY10ZPqMETSksxt4ckpo6WONpU-6nJSvcXBIE3YN8blQEKuWvBkK6Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:36 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/12] firewire: cdev: implement new event relevant to phy packet with time stamp
Date:   Mon, 29 May 2023 20:34:06 +0900
Message-Id: <20230529113406.986289-13-o-takashi@sakamocchi.jp>
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

