Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5160E27C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiJZNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiJZNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:48:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA1106923;
        Wed, 26 Oct 2022 06:47:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 338005C0179;
        Wed, 26 Oct 2022 09:47:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Oct 2022 09:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666792051; x=
        1666878451; bh=45bUwAs9zMuezRr68evvNoGp71TZBRQX/Ua2y9yCqM8=; b=l
        GS48gbjeS71a8GPbP4Z1E/Hfl/saR+mMLW+hrCRjws/mmN0r3esjAbdFTZA84Rx9
        G/K0tP7bu3ATNA7+CuvMfWEyfEaCgJYahPPqrMVjr2mo/O4tXQNPLC1joTkRkb6K
        ynz9542UpIuyKzwguEhXNutLfAze4zoYIDC8NXcAoe29suwr5mqBsLgTkXYibFz0
        TsFuv2hgNV+WOjN5aLrDW3+8PMSm9XFZanYHE5vLsuP42LGw3Qh5hIs5BJl5G+Lj
        zKESjVviDiEbGmtwjtPmfPoGOyXL5pijWvFrQ2cY86bTnRtXId+sIJ4XpqjyKxIJ
        96c6G8V7p80wxqXZa+XJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666792051; x=
        1666878451; bh=45bUwAs9zMuezRr68evvNoGp71TZBRQX/Ua2y9yCqM8=; b=T
        pnLsRpLmLjSJ+ZHlEtuBk0xkfx++5TvLgslxGYCimRgqzxPiiP1M+8jM2G+StccW
        us5vnwl4TSw/iqFpBddhRu5cfb7U2vk3zTTxDHeRoyg/2rcK+TUsc5XddxNfxPJU
        Ca1vOSb87y1XodmlsIxyddkGuq/w6QPOaWS5lcLI85rywLonxB/T3Bb6ST6T/lD4
        /oMqpWvNcyc7Ymxj6Gl6lUL3MCD4ZvO6WAFcNFj4G+ZIjFdY+yG/zz2DKYzXci4L
        ksa2Jy/BZ/qNeynuQ1/MM1vHVflWoeO0Bf2KZqHCYJlFXuXr04T78fDVRZKFp4hR
        3CojllKVsVUWl1hciZjvg==
X-ME-Sender: <xms:czpZYyVCWHWhzp7W9kDqN2T2eP9ssDD7fu9Uxdzg9nwg0xkZyPwp7Q>
    <xme:czpZY-mDE5r3CH7eLI9jDevEHlGTzJ0CnQUsvKogwyPhGTaJ7cHqIF033ff0gSO6M
    8vd9r3pvU1xcYp8lLo>
X-ME-Received: <xmr:czpZY2bY_sKk-PjlN0olTImvjpAuGnXDsuKr7Ay-cSPHMLdYEo9XNYlJNTCYcVtpx50rfutEVDuXxk_yqJZckmMAJA9-iTCQe00WzNeb5Q51kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddvgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepmhgrgihi
    mhgvsegtvghrnhhordhtvggthhenucggtffrrghtthgvrhhnpeefudfhgeevhefhfedtue
    evueeluddutdetuddtvddvgeekheelvefhteekteeihfenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtg
    hh
X-ME-Proxy: <xmx:czpZY5Uz2TO0bgDARDXZEqjZv9LJ7_30ZM6rVQxWclSoH4NLRWWaRA>
    <xmx:czpZY8mYcjdXFCiLEQXaizshXZoC8qptOeEsR8EmQeHK7_u11wUInQ>
    <xmx:czpZY-c_QjmvLjcjm5qTDqNgLkNxecNYH4YCGp0bKVyrUXKZTF65KA>
    <xmx:czpZY39Lhq2FbaUvgxp90DXq__IxMsDf27QZvQDx_HtFUNPmtDVCAw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 09:47:30 -0400 (EDT)
From:   maxime@cerno.tech
Date:   Wed, 26 Oct 2022 15:46:58 +0200
Subject: [PATCH v2 1/2] clk: Store clk_core for clk_rate_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-rate-request-tracing-v2-1-5170b363c413@cerno.tech>
References: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech>
In-Reply-To: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=Cf1mYycsWJ2/45P+TgQHH1k5LjxSUSEf7IFdDRMwXJU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMmRViFeoWuDxHZUm/i8e3miY4ZQ1Xed8wcczrNLlBZIKLiq
 VOl1lLIwiHExyIopssQImy+JOzXrdScb3zyYOaxMIEMYuDgFYCJrdRj+p679t+GUr+TTWm67IJbgLI
 a2jq18K3/z/GeYx8hh7JFqwMgw4Qvfq/zSO1dbG3Jjes7PqFAVLVF9IDBXaU3K3YwbadNYAA==
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct clk_rate_request is meant to store the context around a rate
request such as the parent, boundaries, and so on.

However, it doesn't store the clock the rate request is submitted to,
which makes debugging difficult.

Let's add a pointer to the relevant clk_core instance in order to
improve the debugging of rate requests in a subsequent patch.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c            | 1 +
 include/linux/clk-provider.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 11c41d987ff4..bc6f964cb676 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1468,6 +1468,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 	if (!core)
 		return;
 
+	req->core = core;
 	req->rate = rate;
 	clk_core_get_boundaries(core, &req->min_rate, &req->max_rate);
 
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 267cd06b54a0..842e72a5348f 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -44,6 +44,7 @@ struct dentry;
  *
  * Should be initialized by calling clk_hw_init_rate_request().
  *
+ * @core: 		Pointer to the struct clk_core affected by this request
  * @rate:		Requested clock rate. This field will be adjusted by
  *			clock drivers according to hardware capabilities.
  * @min_rate:		Minimum rate imposed by clk users.
@@ -55,6 +56,7 @@ struct dentry;
  *
  */
 struct clk_rate_request {
+	struct clk_core *core;
 	unsigned long rate;
 	unsigned long min_rate;
 	unsigned long max_rate;

-- 
b4 0.10.1
