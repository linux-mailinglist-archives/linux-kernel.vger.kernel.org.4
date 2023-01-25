Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C7667B22E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjAYMD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235454AbjAYMDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:17 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBE568BF
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:16 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E12C95C00CC;
        Wed, 25 Jan 2023 07:03:15 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 25 Jan 2023 07:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648195; x=
        1674734595; bh=Td3n4i3eo0pZ/YzFAwc9ILQot5TU2fewRmEKzxit+m4=; b=k
        Uo0gQLyLNJW+UyVAOirV8jtoAfLzOmECRH+ra9/HiP4BjMmeHEOxQ5e68rTeMXdo
        FG7lbhieHIEmTVM7DdjS/ooqrY1gIWYfIyHz0OTyU1WmgJBPqLkQ+u9ZDDGhpOZg
        O53WZXQR7VIyHH73PS0ltggUvVdcGgjLveWyY/iw1BApSUTorZUGZ2tY9zZ1WC8x
        isitWWQz1T2/8o+hQJatHdIRQBiXZKUJ3wQKitVPdbADXsv1MWlxD1TTpDMKEi2k
        gd0YdN/T8zRFXdP65X3xYQ8EyQRZfVBn/e2AtTJuKJi5G8j2ta+Nbk3Rv39Y9aw6
        3YW1SYgYqZgekm7lxxxnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648195; x=1674734595; bh=Td3n4i3eo0pZ/
        YzFAwc9ILQot5TU2fewRmEKzxit+m4=; b=btzLo31dmt8bZiNJi7JAcRsOv+PsL
        ttF33H/qTOiQQ/Sf9qBfhAGXUc3sRusyannd+0/r3hdDwyTTuUOESOq/aiXsAu9G
        kKF0yxOO0CmZw3VbB5rReg4UJyhwNRiYHzT9KXViDmG3jDSR1KA8d0hS4+iBtNmc
        cBmdREuMh7s9P1PgcGswzynLr7n6Hmk3Z3o0sD8H0aieDkx/vPTNa1JQDSRVSVPH
        wyggnykR2W0YYwYPRVZfTisikoGsaQdOWOzeYsRaTtDxBPOtrVsRvK1W/uTnh200
        HglAzghZhKx6sGxXBN+XYxy/TsV0+3dBYtAJUzIzkoeusUdgudFn+Y/kw==
X-ME-Sender: <xms:gxrRY7pbFVm8nSrobsAHlg6ycL9L74sTc5L4CV6VDQhlcHSyP5_F-g>
    <xme:gxrRY1pG70GPUX79O6MisgQWAwwH9pmX1hAOMQdlxotRtXsZKNUqdXaF7dl-eDc4y
    l8NW2EJFXzqYN2zbfU>
X-ME-Received: <xmr:gxrRY4MobuolfeFhK_hHVFHy8K2LG3zeeHMm9X8aTJETnCNimf6dmpmXHgmMFqs9g9gQY9kP9xDymfKkzugAFUL3r0FWjUKW4OyxPH0ue1GZmt0Pms0FD8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:gxrRY-5d9AAIJQw6foTpNBdagXTFO3T75pTrP-xkaEKN2I2NpHWHfQ>
    <xmx:gxrRY66WGyxiVKZwYjPahncjtpSUqS8YVE751s-hP_Y7y8bo8oiZlw>
    <xmx:gxrRY2gYbt4oiu1iKQO6VRjZ76Wz_KD3AsO8jziTgzAozAZFy-qyow>
    <xmx:gxrRY6GLFWg8sDyhv3cnsSZuLe4PMpUx-G9Qs190jQTYmqGENDJjTg>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:14 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 06/11] firewire: cdev: code refactoring to operate event of response
Date:   Wed, 25 Jan 2023 21:02:56 +0900
Message-Id: <20230125120301.51585-7-o-takashi@sakamocchi.jp>
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

This commit is a preparation to handle time stamp of asynchronous
transaction for user space application.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 5a9446d30447..315ebc8c545d 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -170,7 +170,9 @@ struct outbound_transaction_event {
 	struct event event;
 	struct client *client;
 	struct outbound_transaction_resource r;
-	struct fw_cdev_event_response response;
+	union {
+		struct fw_cdev_event_response without_tstamp;
+	} rsp;
 };
 
 struct inbound_transaction_event {
@@ -540,7 +542,7 @@ static void complete_transaction(struct fw_card *card, int rcode,
 				 void *payload, size_t length, void *data)
 {
 	struct outbound_transaction_event *e = data;
-	struct fw_cdev_event_response *rsp = &e->response;
+	struct fw_cdev_event_response *rsp = &e->rsp.without_tstamp;
 	struct client *client = e->client;
 	unsigned long flags;
 
@@ -581,6 +583,8 @@ static int init_request(struct client *client,
 			int destination_id, int speed)
 {
 	struct outbound_transaction_event *e;
+	struct fw_cdev_event_response *rsp;
+	void *payload;
 	int ret;
 
 	if (request->tcode != TCODE_STREAM_DATA &&
@@ -594,14 +598,14 @@ static int init_request(struct client *client,
 	e = kmalloc(sizeof(*e) + request->length, GFP_KERNEL);
 	if (e == NULL)
 		return -ENOMEM;
-
 	e->client = client;
-	e->response.length = request->length;
-	e->response.closure = request->closure;
 
-	if (request->data &&
-	    copy_from_user(e->response.data,
-			   u64_to_uptr(request->data), request->length)) {
+	rsp = &e->rsp.without_tstamp;
+	rsp->length = request->length;
+	rsp->closure = request->closure;
+	payload = rsp->data;
+
+	if (request->data && copy_from_user(payload, u64_to_uptr(request->data), request->length)) {
 		ret = -EFAULT;
 		goto failed;
 	}
@@ -611,10 +615,9 @@ static int init_request(struct client *client,
 	if (ret < 0)
 		goto failed;
 
-	fw_send_request(client->device->card, &e->r.transaction,
-			request->tcode, destination_id, request->generation,
-			speed, request->offset, e->response.data,
-			request->length, complete_transaction, e);
+	fw_send_request(client->device->card, &e->r.transaction, request->tcode, destination_id,
+			request->generation, speed, request->offset, payload, request->length,
+			complete_transaction, e);
 	return 0;
 
  failed:
-- 
2.37.2

