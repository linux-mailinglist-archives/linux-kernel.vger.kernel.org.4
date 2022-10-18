Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE70602D74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiJRNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiJRNxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:06 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89691CF1A0;
        Tue, 18 Oct 2022 06:53:04 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4C01D3200564;
        Tue, 18 Oct 2022 09:53:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 18 Oct 2022 09:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101181; x=
        1666187581; bh=gtRPidfBht3s3mfnhidv0jmAjwR4x/ZpX6vTRpwG0a4=; b=I
        xbn3kSr195n1Ku828GGqT9LNGbZYN9khyCSnY4wBk2NpoD+ADDKH3qhEt74snp1G
        RkEToqTq3c5poMxn53/x9SHOi52Unf0jEkIhGXczJPFHbdR6xIYramB39TqmXGzj
        9S61cbdqFEfVn7E72pn7JNi+U3sDTcanQpulGCWURIGPujZlcJhhtr7zqiLGd3Ht
        5HnqP2zpq9gqVdas81sGMJnY2sC84gknwP72baruxA9pfi4kHS9/SxTCLGHWisYG
        /LKaMmzckbVDHFXBGCDfAexwLKJClaGMHiE7J/zr+oXh1IUZ61I/L9KCPR5BFpkx
        Df9oLN+RIZOO4nz3fNTIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101181; x=
        1666187581; bh=gtRPidfBht3s3mfnhidv0jmAjwR4x/ZpX6vTRpwG0a4=; b=l
        gbGJKF9TJJX4ozkCOqMcnIH8mEjozHYZ+NCoIuZmSiqkUueqPlGGWVYc70mEyBR7
        Lt6A5QNi4p1CrVZSikL9uH0hJwF30AsjnZjJlsnFqYj3QpYHiZVwxKs1m2PAtyAD
        5FEMtOA+D+MUkNh3XLJVP9CiyKtB3CRSX0XkwJGXRbhaP32WDY5PC2UjTVkpvfYC
        q2eO5mWRZeKTeQFB/crV5Baqnwp7LtZacSRJf2RrnhNKd8NPab+ypkFbPGggMXiX
        yYKJZdu0Ed1nAmXQ/08ZjD2X0s9IrkWCo4Bdqe8tOyk1TX7XR9qweMHGesjQZrA9
        sj5ZGV9eW3bbe5H6M8e5g==
X-ME-Sender: <xms:va9OY84ouvRRXcT28nj_hY6wMudOrElTdmBSBI97JbJt7GfXlkjqOA>
    <xme:va9OY96Pyv1fqG3iAszBiLYMnqWNsrX6CiiPB09PSQtm7m6liHT24hLGrpkyUGwci
    noijse8o_KbG5pDr8w>
X-ME-Received: <xmr:va9OY7cNiSjSSYPavPSMB-E93P_AXt1d6zntMkiP_yKfL-VNb80kyCJmi4WI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:va9OYxKtRAB6mc3l7clMCYXkIYGLg59d7mxee9o_dcKl-WUl_lh-aA>
    <xmx:va9OYwKhlzVGkUasDQBED9IjVK4HFeM3dHSKD6gn3SWpgsXH2CIuJg>
    <xmx:va9OYyz29bbAbJPOpYIzxTNfIOIXdTc3RlsiSgO1UcivuNg4RwtOag>
    <xmx:va9OY1G_av1rnJRI0Jp6O5AiUtAHOCLk3eXotm-Aeg5mdAhVdDDQDg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:53:01 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:52:56 +0200
Subject: [PATCH 1/4] clk: Remove WARN_ON NULL parent in clk_core_init_rate_req()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-range-checks-fixes-v1-1-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=zafRG0QXl+PXtxAm4Bsu+gNoZDPQ5i9BnzeNzVpJFUE=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+63fq613QnCGifVvqiPD2noefCzazdHF/+TPhz8sfsZFO
 Res+dpSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiPcIM/2Pv8Wd5/pdo477bt0JXNm
 bVO+U1bRMX3tW+MltY4mr8WhZGhrasfcuLNZfc7rsz//mT6oKOO48e7jukfercAt3HPEq2J7kA
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

If a clock has CLK_SET_RATE_PARENT, but core->parent is NULL (most
likely because it's orphan), callers of clk_core_init_rate_req() will
blindly call this function leading to a very verbose warning.

Since it's a fairly common situation, let's just remove the WARN_ON but
keep the check that prevents us from dereferencing the pointer.

Interestingly, it fixes a regression on the Mediatek MT8195 where the
GPU would stall during a clk_set_rate for its main clock. We couldn't
come up with a proper explanation since the condition is essentially the
same.

It was then assumed that it could be timing related since printing the
warning stacktrace takes a while, but we couldn't replicate the failure
by using fairly large (10ms) mdelays.

Fixes: 262ca38f4b6e ("clk: Stop forwarding clk_rate_requests to the parent")
Reported-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c3c3f8c07258..37d623c7b73b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1459,7 +1459,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 {
 	struct clk_core *parent;
 
-	if (WARN_ON(!core || !req))
+	if (!core || WARN_ON(!req))
 		return;
 
 	memset(req, 0, sizeof(*req));

-- 
b4 0.11.0-dev-7da52
