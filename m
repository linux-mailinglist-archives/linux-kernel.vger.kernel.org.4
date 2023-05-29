Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D371488F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjE2Lea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjE2LeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:22 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2CD8
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:21 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 28BE232003AC;
        Mon, 29 May 2023 07:34:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 29 May 2023 07:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360060; x=
        1685446460; bh=vLnKaQC1H8MrzTAmo/K64YxxQOflNTjfEH6QTfOvlSY=; b=C
        ltzJyT9C90mD+pOF+VQG7jxa6Xa3pLsm6imlObuloFvVeKLNHwxcT1RBDHFCAhoz
        ep0okZriQIJTF2P678LVrgOadawGS+mX8/G+FkUWRgoJI1Nd/B1GICVcbluy595Z
        2a9Uz6k90vtL6Ix5YxCNxPt1BMImKjVQ13ThqnUCkKfBIGL4vyFQD5ZVpgBNcfrg
        YI78/8+RPkaG4fdabMzEX2M4NuvjtuiUI45acVjHKyzOGEq6f/aNW73eHgBse2IM
        0ncuiTCPB0z0hf06v4vzUS1NJobzjson/yaoyOxw4h+bA8fw492Tk+seIK01gokF
        0yF8WJ/WycDGY7OfIaGeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360060; x=1685446460; bh=v
        LnKaQC1H8MrzTAmo/K64YxxQOflNTjfEH6QTfOvlSY=; b=N5ZJrem5eSTvzJ0hB
        qgp6y/SpeBdP1HkTBp30KjO5q7gEqUrIu5Q4RQA0GG9VqkLRbuMKHSxsoVS7ho6V
        E7AEglwqijH5baaUismXk/bwhVjCHLoO+2qw+FMI4gTRUEEsRqL/Qso+QqDh5zH1
        vzkn2ynHKZzn9bP8bnIPR0OP2+jtXQXaIfv+yhD8DBE3ntFsAfZmuWj68cAhVpB2
        Lde/JFzKWiDCGrck5/cmPdOnkNYVW4FjapK+DbSYTgZ3aF3hfAROzys+iwPLoD9/
        9iTZ5N+4GaC9ZfMUGWux/tt+9kE5z7KvmMe/QIc7r1VI1drEO4MLT+pBFRyPmPEl
        IPU+g==
X-ME-Sender: <xms:vI10ZPcRWAkGy_IQRfl1Um4Qs8tgQ5PkZIrV2iG7GQo8fbkQDBppxg>
    <xme:vI10ZFOsTSS0su6-Rsvk1ipWrKxJljzFSqnle0LloI02UMnXTy9sW9CthP5id_gd4
    cA-ZUBVGnHx9NkvgoE>
X-ME-Received: <xmr:vI10ZIhJyQtJAXdrdQq_eNqvYTrVpDZDYIrealLprac3_JuomAap2YJz5rhXW61RNhNiYZ-CznqvcZm6i-hy3H90DZNdhTPU8WBA522zYj9HUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:vI10ZA_rB9tj0dm017vFHMoo1qIJXKZvbfPwNwe1bGILxJuDBmWakA>
    <xmx:vI10ZLtTpk-3eMWPWR1CevA813FPFZQxRAiT_tNpeyS9csJ--DYFIw>
    <xmx:vI10ZPFEVjQMzoIXDFFe5ZqB76Ll873Gdky1hECN6jjojmGCEan__Q>
    <xmx:vI10ZJ0Pk8q45dcsbawWTQ3RczRz21ePe2BDQXkrDgBRzAD6rn4zsw>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:19 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/12] firewire: cdev: implement new event to notify request subaction with time stamp
Date:   Mon, 29 May 2023 20:33:58 +0900
Message-Id: <20230529113406.986289-5-o-takashi@sakamocchi.jp>
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
2.39.2

