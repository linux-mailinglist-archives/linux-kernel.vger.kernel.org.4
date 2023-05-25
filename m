Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F077109E7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbjEYKRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240840AbjEYKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:02 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059BF1A8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 64BEA5C01ED;
        Thu, 25 May 2023 06:16:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 25 May 2023 06:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009795; x=
        1685096195; bh=vLnKaQC1H8MrzTAmo/K64YxxQOflNTjfEH6QTfOvlSY=; b=r
        Me9UGIKIYubaxAzCMoCJuLL34vKW9rQ3GKszPnxYTlYZ1j8KDBcMffbPNecKOSXH
        cRKo3FdfbF2rlgaibRS2mNdaq9LGhseuxU2Fb3PviqgSrOfacDVquY3Fj6dVyn1X
        +bspzWcyN5IZVHGR1c2MdoKVmWxMMixL9KRE01X45W7zRBxYGMcQy5nA/zq7ZSM0
        DP01O7xVbW+x2UMNy9XCrgernAQMZ2rcM4LusRFuWA5MGGbj02cQJ+TKE/rAlyy3
        gok6gx22YZh9T7suL7AoWCm/7ZKgQ8449UA203Av61ZP070y8c7rgNxPH66UrM1B
        EiQdMORotKg6Px9NyXaiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009795; x=1685096195; bh=v
        LnKaQC1H8MrzTAmo/K64YxxQOflNTjfEH6QTfOvlSY=; b=lS+pVgxAzWARH2r9Y
        T+6JkJEWcgIJaDGl6EQORgrlc6Qet4reqm7KqQ7q8CifGvzj/l/01Zv5to9yXvu9
        vu0mT3Neil9g2/rJB3/rggUHOvVH0prXaxQDJ7/KLc5q/kJNjRys/KWAgw8DmZKq
        v3caOZUX70cjtwWiAVy//MeJvDzoRLv6g703KVhDJac10ReHOPz7OJLoKWKnbs29
        DYHQYiHGuFXCurMBuEQuSO7Mg74hlKBk+SW1U0JnNg+ZdFDFMM6WFveV96w1eZh8
        ASDku0nzuqR2KYHRTxnLHSxdYM56gAR0sHvSBDDPuPs9qL7a++t30YHnB+S4ksk1
        hfNDQ==
X-ME-Sender: <xms:gzVvZDiLeO2Ilb1O7r8A9qSvlafVXxrU7LqhejSEjiSqvKxKvVl9SQ>
    <xme:gzVvZACz_Zjig1fHlJu6qDyRn_2ftK6GS3rLU4GzEpBmr_2ByBVFXRKRAtlwUQ2JW
    _-DxRrcnriEoSFCRKU>
X-ME-Received: <xmr:gzVvZDGPNw7YWCFk8hMURW9-3qewoJB_S4mJK8ZT3-cYsLIFoD66ewSuW48eyFvMfOmZiNZdtGwa1GlqaO4Tf95JpQlyfSYXHbPTT4_rkekStg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:gzVvZARqXbz7l7agSqVFoc-EkbiJ_o_PYPbUZE1UlpqTwSSe9iZhmw>
    <xmx:gzVvZAyA-ZDTL87eH3RoKzgXXzXK2SEwMo3977AmgtbvYB7vnolXIg>
    <xmx:gzVvZG7pPNf-RknkjVMzIyYDawFALVsb_G9wYMsafYTgpBAEstayPA>
    <xmx:gzVvZGYBe6CXKYnWGH1Y_Q9qI1hmljMaZlwvmhKpCCKwtoqH9w9YrA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:34 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] firewire: cdev: implement new event to notify request subaction with time stamp
Date:   Thu, 25 May 2023 19:16:17 +0900
Message-Id: <20230525101625.888906-5-o-takashi@sakamocchi.jp>
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

