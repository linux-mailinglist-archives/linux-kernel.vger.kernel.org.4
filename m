Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125E5602D75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiJRNx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJRNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:07 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE43ACF1B5;
        Tue, 18 Oct 2022 06:53:05 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 001613200923;
        Tue, 18 Oct 2022 09:53:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 09:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101184; x=
        1666187584; bh=DXf8wDkwySWMLPkhlz7v5fI4HEF/Edy2/upUN3ptl1c=; b=W
        xK35r7ljU4BDtTKPrb9jYhjuGcnQnK2WXcIAwVfIpYeor0GSJ51iXD4fOufGMKCE
        Cfldod0W+LyMeNCGtOaqeOW6A97X4E6DJsYMxpgt/vaMX+6lzk65vfdyuj5JpzBQ
        7DLopwQmcdoFFDRuPYGPb17k4H278/z7APijWRfg5TvyvZnbdouWv2mml+D5pBMd
        Xh7PyAxG7jSNAttkp2mf01H5ZpnfdsrDiSRFS3V0RRdHewzc9j93MKz4bs+RrfJd
        udxZicRl/2g20E3sjS15ev8MYZJHM3LEp57+v86SxaSBVwK0gUjy12MWCA2fMTqu
        lixSGPyC0VQtK1xhnCPYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101184; x=
        1666187584; bh=DXf8wDkwySWMLPkhlz7v5fI4HEF/Edy2/upUN3ptl1c=; b=q
        gVUOHXso0KugiT5m88dJHddyV03nCg07zZ/v0WJ815HbV9M8WUrCO2e9lrfK7wak
        ropcDjrukykTcOf0DB9m924vbcs1Tpyf7rCmZ+ldO23p0SyBkFCN3v0L1fffJcN0
        kPP2/MzmULSAYWUK7fAwpR6NDgZV1ELF/g8JFjdhPxmLP62MPWLxI02rgdSNBzon
        3echaQabWeyY9klS5IdPSQe8xVdaR/FCNyKvpkhemXBVoB+Ij9JrdmomsLjU9klJ
        eaSi9wDRMC5lSFR6jUtKtyrIOl0MHNPRXhKGF3+FOTno7bUcQBZo4OePGf61IFe7
        RiqsAT1BVeKbFNtmNkiNg==
X-ME-Sender: <xms:wK9OYzL6c6-nh4Jy7S6mJ78rY3YbLPiABr32VNXZP7vNvidVYZhalw>
    <xme:wK9OY3KPODGGILQOAYjwBgNu29eGA7Z6-lvdqj_ET1YY7vR2zWJzKeB11USDh_-Of
    -XWyh6hKSimlu6PoYI>
X-ME-Received: <xmr:wK9OY7vXbdamlVyMs_S6XmDIW7iUsSPj8CrEZh7qh-lC8VWJnyqHFZo5lP8n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:wK9OY8ZI3ksqod-R4lC9yXQOghCpER1oZ9qpLl2MMGWyjjcbRNsYfQ>
    <xmx:wK9OY6ak0gne44tqXlUjgMnA8mhWNMB1xmKG87AFsmChDSRX4o6eYA>
    <xmx:wK9OYwDbi6wOk26P2V6bXBkyyNYVdzTf8bZrgzKrPAGTaUJkiH4-iQ>
    <xmx:wK9OYxWqODtLFvQ4wnU_wW-vCXY63ZYsrJ7cZ9wAqjo0UKh4kACdOw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:53:04 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:52:57 +0200
Subject: [PATCH 2/4] clk: Initialize the clk_rate_request even if clk_core is NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-range-checks-fixes-v1-2-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1541; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=iJZ09jCGM7ggARymjXyYWOUrb3STDwvqi5POK1c/Slg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+63dq6W9+fcX56nXN+4c3tdwLyl5TKfcgpiBuVa3Mm6qj
 W/5GdJSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiq44wMixx/7ZvGuvy/wZeW2asiP
 l48fcxszdK7Sc8vtzIjE89+WUTI8Nthynz/lo+K1i6aplencGqY/sWd2+/Zdvw3PLerc+JE59yAgA=
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()"),
users that used to initialize their clk_rate_request by initializing
their local structure now rely on clk_hw_init_rate_request().

This function is backed by clk_core_init_rate_req(), which will skip the
initialization if either the pointer to struct clk_core or to struct
clk_rate_request are NULL.

However, the core->parent pointer might be NULL because the clock is
orphan, and we will thus end up with our local struct clk_rate_request
left untouched.

And since clk_hw_init_rate_request() doesn't return an error, we will
then call a determine_rate variant with that unitialized structure.

In order to avoid this, let's clear our clk_rate_request if the pointer
to it is valid but the pointer to struct clk_core isn't.

Fixes: c35e84b09776 ("clk: Introduce clk_hw_init_rate_request()")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 37d623c7b73b..eb2f9be9b9aa 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1459,11 +1459,14 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 {
 	struct clk_core *parent;
 
-	if (!core || WARN_ON(!req))
+	if (WARN_ON(!req))
 		return;
 
 	memset(req, 0, sizeof(*req));
 
+	if (!core)
+		return;
+
 	req->rate = rate;
 	clk_core_get_boundaries(core, &req->min_rate, &req->max_rate);
 

-- 
b4 0.11.0-dev-7da52
