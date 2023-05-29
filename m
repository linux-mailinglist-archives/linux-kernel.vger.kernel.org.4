Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6621E7148A2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjE2LfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjE2Lex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:53 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780413A
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 60C0232003AC;
        Mon, 29 May 2023 07:34:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 May 2023 07:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360072; x=
        1685446472; bh=fzYN89ZMFMfUx+g08kllNmIdNawZyAy6SkyrK59Skkc=; b=k
        q3hQNcEvdYLw7WNM+QLeh3rgSjaYsz613Grs8OI7jadHAgNSo1gJqCR6/MfyRqOC
        siD6aLZYuLvHi0QoEtS10YWdpVZ0Q6vE770Q+7Fm/DkzCfbozlE0u6vvShaBYX5S
        AWeXGIbu2zBQckWsdXpBts2sEFTZyhXpQgEbj2a9nrBgEmbGe61ozCKf+YgP4/Pz
        AI7MPB2Bo+wOahuKgf6lvF3yyO8uOIXAUz8R5NLqK+/m9hZSDLs9w8LulSUQTm7j
        y104fYWcBWv+Si2RrD8Rh2yeWENCiLUHo7NA7Y+z5JMcSijC52CcyTJwQwchiH9O
        cRZE0Z2GW7iVghUPlPB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360072; x=1685446472; bh=f
        zYN89ZMFMfUx+g08kllNmIdNawZyAy6SkyrK59Skkc=; b=BLufKp+ELSaoycQKt
        Q8YQSe4Mhqp7965Ghn0MdjqVQnfnQ9psuPSwhbBSi1BAP4XIjw+GT8gu3x73+omL
        6+CEQYSJ8fUgz0uF0PB7eOJ6SwHHy5GH8Nl6g6Z7J3ny3rO1jCf1/Y0P97T0UhiF
        Zy3ZAbl5oEuQAhsa9z7rXyJQZ3q93iG7fuGH3vbFVFN1ZPD/I/AFE26JfEBDnsso
        +XgBIBb4egA70fpIvSEBOWCPQAANbcpdvS17oKJYCrNsZEqklA6zrgpOsW3DNwoP
        UIfvUMHLnZwqVOvdPApq+7X9F4pNR1XpxfVNwEAlD4Niq3MySkkdqBgODnybOEf+
        na4/w==
X-ME-Sender: <xms:yI10ZF9hoE3mT1TGCURsy8r2gZ2496y8IldiHhTuYsxo1Y4m4SBPBA>
    <xme:yI10ZJvrTpI_srTNYUlNy7aKy6LebZ33gpgmudsvtuK0myc8AQyuJl72vSG1bMRv8
    F7JqjirdypECSPkhDA>
X-ME-Received: <xmr:yI10ZDDri8cdNrOJspKA2goYrlx8xty04uBg39jQnm4ftoaCk_KRR6EUUlXW5RkYkQyLhvcYfi7ax3gEgVymEZnkrZgw6tHIc-rDq03UExcaFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:yI10ZJevA2GpZoC-YzgEiTgP7knI-JacI61cTLByYG_nuXlDjCdiwA>
    <xmx:yI10ZKMxy6sN8YGs6yNVCFWuem25gqZLWgiJFLvNvPEqu9cIITl5zQ>
    <xmx:yI10ZLkwR1ExU6wFawRz1GoFA6uhM8IgQO00x9BBhk5TOchzfB4Wfg>
    <xmx:yI10ZEU-WZZep8qHwwo1B6fMWXoHrixQDAiCFPhuZhKvNEw92lsYdA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:31 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] firewire: cdev: code refactoring to dispatch event for phy packet
Date:   Mon, 29 May 2023 20:34:04 +0900
Message-Id: <20230529113406.986289-11-o-takashi@sakamocchi.jp>
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

