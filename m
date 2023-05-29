Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8651371489F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjE2Lev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjE2Leq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:34:46 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE94FE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:34:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3DC163200929;
        Mon, 29 May 2023 07:34:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 May 2023 07:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685360066; x=
        1685446466; bh=hCn80S16t5KWMrqhGJtFmBVIPiQ9NKvnaZBu9C4Y5xc=; b=q
        3/PXv12ub3R543er7mtSqTG+UOl9z9RizPLl3+jLjcqk5V7W/0HqO8BjbPb5hmll
        ImZTRuZ+HREPQDUxoS0yCVs4zh2hBcGw8IDobLfre9D4Wbij9YFsJNd19CRuFYqp
        GjtzNwEgKBMun/4HXcr3Mp1BJsvhR0cQmTtCQnWQ03CKMa5NJnagzJXdBNwSm+Gd
        vttC3Gg+IJ+pQsd5N/2Pj5nyqP17wU+DU+3pObOUDoQlzvZVHeWQf8c+C311TJfT
        /KsezunhzL5BpsOh5Ql7ctUnRxPj0a0E7M/vMMzNwTBdcWHssoBO9TKvIHcgW871
        rpTEUf4F1i4e8W0mt+8eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685360066; x=1685446466; bh=h
        Cn80S16t5KWMrqhGJtFmBVIPiQ9NKvnaZBu9C4Y5xc=; b=BTn8MYuwszk8Iw27z
        MXblbdH/e4Ca9imlzuRm1qKQo6+2rKHcyIIXu1eK7vHR9dMvR537eRidlzctB8sD
        XzGHo48+GTorW3YpQpJQQuYR8Khuodiu1rpcJCDZvld6pPwQFVyMfnz3diiIBayy
        nhBOQB8mW1m7mGVCqDGxV8wtylJqL+IKSimuU0AnWuAT3uhFvn20NxtXF8+7AfK5
        jxOjpXXQMsZ8YUm1C1XTO5p6/KPBxdd9W3muxqos38PI5oIciOC/9HyGHzZLXR8B
        F+b93LZEUVkAvRsRrHdFJms9h+TMcGcyoLp8Q/crL1YqGAxFusUdGUnhFMfp53He
        /hXiA==
X-ME-Sender: <xms:wo10ZB6R9xdaUWVVttt73o5mkaRIzn_IsFj7OWDPYJ5ERMdTmRjHEQ>
    <xme:wo10ZO7ZZ7TSTSb42Ze14ZP9-npRHpIF5_qX7jfWi6pv5uI5ot-purP4zgBlX1tTo
    s4BvcXzhz9mJ5UA7S4>
X-ME-Received: <xmr:wo10ZIf2y2BOwdn6ZdhEfPx1OXOb6qQTbYnSL6dVI9bbY5yHysoCrX0Z4tAn-fmCYDUssID7fPQIPHUqnKy0NJkfPVFaR1DgwKCAHK3yxikNKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:wo10ZKKtrBHvKh0U43kM_jGvz8Q3SEfcFcx4LPcMLGVSraEvibrHNQ>
    <xmx:wo10ZFI-IXTAbUc9-F2rJjEXiRFixbBo06yrvDC45OKUWRpmiX4KnA>
    <xmx:wo10ZDzRo2CF_eFhgMYxMMktJDsKR5S1ij4wC_uwK2WCuJQuC26M7g>
    <xmx:wo10ZHy9OMs6zEbMzTMba4pqmM3AfhGcwH2m0t88_OrKgBWDJS8uAA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 07:34:25 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/12] firewire: cdev: code refactoring to operate event of response
Date:   Mon, 29 May 2023 20:34:01 +0900
Message-Id: <20230529113406.986289-8-o-takashi@sakamocchi.jp>
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
2.39.2

