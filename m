Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7367B22B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 13:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjAYMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 07:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjAYMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 07:03:12 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95CB5689F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:03:11 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 50F5A5C01B0;
        Wed, 25 Jan 2023 07:03:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 25 Jan 2023 07:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1674648191; x=
        1674734591; bh=vxkfReO71prrNWdj/ls9FxWUEiwc8tsI0fkpO1vRHYI=; b=g
        CcUsXMhP/iS0ZOgXVGbyoru3SKvETDxPDdO5Ehqp8ekpRZheA6+4TarNidxmBu0y
        vqpCRqBvfSOfCV5TNmKVutRDatHnzP0DjsCK2Pb79iilVJ8K9OTCfI10F7h42qw+
        FMZqZVPJqkW1UNku6VtxOPXZMsYaci47IBfA4zS8Q8IJNx00aspL6/3qBOulcPtu
        BWb/zRjuvjttyt+05hugR9LU0c/RgPxp1BCIzcJU2b+3/UjuUC2smT69uWlSqPL7
        ku5MYIoaoTX0UW4mPyhvdW6EwOPi0dfJpsLPiaOaz8twX4LN6h5qrqMRpLP4BXqV
        rCo8PYYfjRwpiKYPN4tAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674648191; x=1674734591; bh=vxkfReO71prrN
        Wdj/ls9FxWUEiwc8tsI0fkpO1vRHYI=; b=mX6CP2QGKCJkbigXCYDQZXaVHQfZj
        AzXuA6i81ltjT2vf/dnG1WMPG2kGki7ljhKcGdpiuGe4TUox5LbV6eisuZVj3xvn
        NenozAQQkdAnZWDgPnIHQSqw3DiRdP79XMIrUbKY8enIL2UANxXfEWlJwZYlepsE
        FZL1Xh6/TkWiAB1GnPK9ANHHJrn7TLOSR06xkou/cm3kuwiGxEG0VMcPuVWy0aO1
        gNlRcy9DIk9vptIStQ+5KhS35zhI5SfDzMkCHU7GhMcG2QhkxIwvH/wIFKL2jiWu
        m/D9jzeQuPGckLGzKezl4qSRVfOk3xzAZkPTC6d2vtEoNxiR5okZnQdFg==
X-ME-Sender: <xms:fxrRY1q35njtVs8Db6C3MyxCorr6LrXqV3Mr5q-8sxH8nrEI2aMcbg>
    <xme:fxrRY3oJ5R0GwjBYZb81L4PM-GF8YnGJVPOgmbwBOk7tE7C_DpGhaH1akiTTWG0FX
    0CacfnlXS76AyKOoOI>
X-ME-Received: <xmr:fxrRYyP94AAKgRBXfzqMcTA-pB3jacdSwHoO4XkcsNC_xdQihra8c9kV-LKWzYs_pLKRw4hezEN9ZtnBCg1-bB1MOmnuZsWAGP95qCNa3m9DSPtNV5TjBDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvvddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:fxrRYw6mYH4yqGEnwOltXf2ON6gH_9uXRVqagITu7Ge03YY8of-hAA>
    <xmx:fxrRY04Mgxn1IGmFb5_iix5mkxadyUWBIN-evPOEnploAJMXSTdfog>
    <xmx:fxrRY4jtqBbi67Fy2V5JQPs848fU6FJUxYguoM__Mcut9X4Gm6mZ_w>
    <xmx:fxrRY0EVmqTXs6OcDQJGQwIfUe2j8LMIKw5K-pAXeXZ_wPwNJF5Z5Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jan 2023 07:03:09 -0500 (EST)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: [PATCH 03/11] firewire: cdev: implement new event to notify request subaction with time stamp
Date:   Wed, 25 Jan 2023 21:02:53 +0900
Message-Id: <20230125120301.51585-4-o-takashi@sakamocchi.jp>
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

In 1394 OHCI, the trailer quadlet of descriptor in Asynchronous Receive
(AR) request context has timeStamp field, in which the 1394 OHCI
controller record the isochronous cycle when the packet arrived.

Current implementation of 1394 OHCI controller driver stores the value
of field to internal structure as time stamp, while the implementation
of FireWire character device doesn't have a field for the time stamp,
thus it is not available in user space. The time stamp is convenient to
some kind of application in which data from several sources are compared
in isochronous cycle unit.

This commit implement the new event, fw_cdev_event_request3, with an
additional field, tstamp.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 88c8b5fac5e5..5a9446d30447 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -178,6 +178,7 @@ struct inbound_transaction_event {
 	union {
 		struct fw_cdev_event_request request;
 		struct fw_cdev_event_request2 request2;
+		struct fw_cdev_event_request3 with_tstamp;
 	} req;
 };
 
@@ -709,7 +710,7 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
 		req->handle	= r->resource.handle;
 		req->closure	= handler->closure;
 		event_size0	= sizeof(*req);
-	} else {
+	} else if (handler->client->version < FW_CDEV_VERSION_EVENT_ASYNC_TSTAMP) {
 		struct fw_cdev_event_request2 *req = &e->req.request2;
 
 		req->type	= FW_CDEV_EVENT_REQUEST2;
@@ -723,6 +724,21 @@ static void handle_request(struct fw_card *card, struct fw_request *request,
 		req->handle	= r->resource.handle;
 		req->closure	= handler->closure;
 		event_size0	= sizeof(*req);
+	} else {
+		struct fw_cdev_event_request3 *req = &e->req.with_tstamp;
+
+		req->type	= FW_CDEV_EVENT_REQUEST3;
+		req->tcode	= tcode;
+		req->offset	= offset;
+		req->source_node_id = source;
+		req->destination_node_id = destination;
+		req->card	= card->index;
+		req->generation	= generation;
+		req->length	= length;
+		req->handle	= r->resource.handle;
+		req->closure	= handler->closure;
+		req->tstamp	= fw_request_get_timestamp(request);
+		event_size0	= sizeof(*req);
 	}
 
 	queue_event(handler->client, &e->event,
-- 
2.37.2

