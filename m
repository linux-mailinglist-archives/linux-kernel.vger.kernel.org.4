Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5837109EA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbjEYKR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjEYKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:17:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21661B5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:16:39 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 67BD85C01A2;
        Thu, 25 May 2023 06:16:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 25 May 2023 06:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1685009799; x=
        1685096199; bh=hCn80S16t5KWMrqhGJtFmBVIPiQ9NKvnaZBu9C4Y5xc=; b=S
        pX+U/7bbNrznA7H2rB6zu/T594d7BHGsU1A5ERwF0Xgu9TYlHw1XjggBptgpLH/x
        jF/EHY+ykLsMS3bSZVw2WcED+vJtDDVh3K5lphxGcy5QyVNG5p7MrYPbqbaiRnM+
        mCDh9M3xkAjKR0mSgl97bAvDqWsWr65H6IjExxTbd/ZC4nlixOWdu7bC8iH3IVaO
        XMBefErDfgizeI09MXW8HlnkcQLxTSSV4XGbQTaycND9ZHhm7XItdStXJ5TKyEpX
        EuitHfReSaucXfZjoRX7tv0XzRRNqOkXD6IneJM5BCoVL4l6WiwRXioRGb2WCGkN
        BhOl15iPWZmfEThmHNMrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; t=1685009799; x=1685096199; bh=h
        Cn80S16t5KWMrqhGJtFmBVIPiQ9NKvnaZBu9C4Y5xc=; b=ygaLTXeBUT6MZMicC
        7rM0fte9LEZe6X/8daKcUvK1/RTt132TipqEhhdaUzWKXhnDBScr3rIixUCvkmkH
        2Mgmq8NC9VloOvPo88+fCco4P0uoLUpAgBScWq+tpqSkg5FxHZbFSdFAxUR2BPmJ
        J0RCpPyzeBHokygzF2iWFYan+p5wm7pG3a6+Zoz/EySqsMEy4g9DlQdSNIU/lO2g
        jVL4jwSBG2ybzws89yb2rjQ1PtihB/411JkJoMRxqG24EpIWsBk1md+jNaFwa96x
        bVX7r7dnEl1B9adPu+w3l0bc+P60Uhn9ql0PqWAHhyGYslphrvG5mWvuhuxLIMtQ
        kse5w==
X-ME-Sender: <xms:hzVvZOgb1dl4bdUcCqlM4uepxOpNmfmQ4CXXHJliwSo7V60gR3_nMQ>
    <xme:hzVvZPBtpWiMK9SFKGgJJxRA55p5CPigyiRn6j4zciAS1g6I85rjpC6WrPvMXgGKV
    P3ZoGv5oKxwXQ6HLH8>
X-ME-Received: <xmr:hzVvZGHH1Z9L9isOR6hojdTHe0AiQVsdq-CMzLG5z9iB8sBUldB1H9-ZtGaB_XqqsfAQ5oGJSVoHe8uqi8Xoai88QlvJ2FbokOIi9kQRC6hZUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveefffefke
    etgfevgeefleehfffhueejtdejveethfekveektdejjedvtdejhfejnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:hzVvZHR2dk-CIUaPq6wyfsKYDrBBo7PbxjP_J0KUiggtxQBczbrajA>
    <xmx:hzVvZLxrEEuAGofHI0ouYd8VNG3wT2nzq7SKH98eiO0AINzYPllDwg>
    <xmx:hzVvZF5j_5D-AacAZt-wI6fFvfnnTtdEGcBTiaFd_Es0hUYyILiIwQ>
    <xmx:hzVvZJYPtpnVo4zAiii2nZOXwHjP_LAnHvCuiD0n34DjZXr9A2gVuQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 06:16:38 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/12] firewire: cdev: code refactoring to operate event of response
Date:   Thu, 25 May 2023 19:16:20 +0900
Message-Id: <20230525101625.888906-8-o-takashi@sakamocchi.jp>
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

