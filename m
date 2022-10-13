Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7D5FD6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJMJON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJMJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:13:36 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E6F171CD5;
        Thu, 13 Oct 2022 02:13:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AB5E5C0088;
        Thu, 13 Oct 2022 05:13:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Oct 2022 05:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665652404; x=
        1665738804; bh=VNQ+rzhIH5hRx9r2piVwTWvHL+idSBOUdFscI6rLzxE=; b=J
        CA5Tta1qADmnwMO1RYaiaSS2ehgaXa7BsEORpl1pfzmZJLTokz8L92qW+AeWqt5E
        HY7IzdfYmVnoSDrr8smGWFOHJMcUtm7QRVdCEyDmR96IS/kuVy5fWGNISI3bCnQA
        Um2obI0kd/rJEzYDxVgPnvBokcbRCVXW3FFq8Xlu6ILAoj5fl9aexyTCUn9R2+v7
        sncBr1xe+L5Zor1QFn4ixeWTnPPcKSVkkZKKfrK0TLsw+UaqbeooVuv8Rp7G9R8u
        vtOsbf3l8eAJC7E1KCaPelWisDRzUk+7ZlHw+DIGyBFf1PjfASsbsSDrzeAsHayT
        l6djrAxq0vo2r3gf/mKyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665652404; x=
        1665738804; bh=VNQ+rzhIH5hRx9r2piVwTWvHL+idSBOUdFscI6rLzxE=; b=i
        WWqbhiB0MM6zxO5lHeriMLEd4LsvsxL0XAAhd1eKb1wJ4ia+tFEdMTceGn5G532V
        +kFhXvlyzgIQFMoHkWArUSHw6mZRFTHUJ8ZLxBPQEb5QHOxJOt5k9X5o7QN8b7Vj
        egVmLwu4k57qQOEOPF3vzCuecTALE8IgWvdW75lwMRP2DhffnXLD4OiCngIHn6Me
        BfWoKKc4Wqsp2PlIQVGOF8KIxxJs/tmV7/+J56Y5oh269ALQSONwEvo9qqAMkHS2
        YNujalNYD6cPIjbeFPOvsVuTaGq2y9baNyJfNnCT2e57nRw4YveFnkc3wWAhg3DJ
        0WFjNdV/qXndfolhb3ZnQ==
X-ME-Sender: <xms:tNZHY5q3jWfMwIGBGd1k5daD_KcxlYwbJNxGidsbLRdUtbFnMilFlA>
    <xme:tNZHY7qkOYDfqKUg0oOnSqHNnuDyBzzJ3eaB4rEUl9GdFl7bGXcJcbAibxVxyTuDm
    QEt2k0vYBLwHZdECZ0>
X-ME-Received: <xmr:tNZHY2OXYoE014XclLRhc7BIzTiHTchSXpryQyxQniSPfYK5p0AlpSCnLiQfdKf2R97pmiIwNXAklFjG4wrGIR4duQV8TADdjEM5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:tNZHY07TJFnGdQ2GYLE_A4tnA_yXJXfroNAk2Mwl9PtpABz_oX0BMw>
    <xmx:tNZHY47QsbbLWVvPNDm6s8Vkzo0MtC76Wjb8Ym39hEH2dGnyOSMHMw>
    <xmx:tNZHY8j843JiquTWKHWkgdT_LpxSAaYrfVs3YyxoMoDZzUH1yisgig>
    <xmx:tNZHY0qTbx4yVWt88oibjSm7646HdzT-VBe2uf0z8PelnJ992dh6pg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 05:13:24 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 13 Oct 2022 11:13:14 +0200
Subject: [PATCH v3 7/7] drm/vc4: Make sure we don't end up with a core clock too high
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220815-rpi-fix-4k-60-v3-7-fc56729d11fe@cerno.tech>
References: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech>
In-Reply-To: <20220815-rpi-fix-4k-60-v3-0-fc56729d11fe@cerno.tech>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Emma Anholt <emma@anholt.net>, Stephen Boyd <sboyd@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1996; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=ld8ipA25nQnVtvJwO2QQQ+Hw9FjcRy6PgrDDJON91qg=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMnu15awBd7JOJN9WGGF/I1fsz+veZC6vuVV87XUim39X5P+
 FUws6ihlYRDjYpAVU2SJETZfEndq1utONr55MHNYmUCGMHBxCsBEbPgZ/if9c0o5cjY0bNOJWbaHGK
 9unPOG7f3CKt/EQ4G/lF3M7woyMjy/He4seO3P07o7nRvy/9bNEWrpPrv292Gro99U7ziWPWcEAA==
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following the clock rate range improvements to the clock framework,
trying to set a disjoint range on a clock will now result in an error.

Thus, we can't set a minimum rate higher than the maximum reported by
the firmware, or clk_set_min_rate() will fail.

Thus we need to clamp the rate we are about to ask for to the maximum
rate possible on that clock.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index b45dcdfd7306..d241620fd5a7 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -397,8 +397,8 @@ static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
 	if (vc4->is_vc5) {
 		unsigned long state_rate = max(old_hvs_state->core_clock_rate,
 					       new_hvs_state->core_clock_rate);
-		unsigned long core_rate = max_t(unsigned long,
-						500000000, state_rate);
+		unsigned long core_rate = clamp_t(unsigned long, state_rate,
+						  500000000, hvs->max_core_rate);
 
 		drm_dbg(dev, "Raising the core clock at %lu Hz\n", core_rate);
 
@@ -432,14 +432,17 @@ static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_cleanup_planes(dev, state);
 
 	if (vc4->is_vc5) {
-		drm_dbg(dev, "Running the core clock at %lu Hz\n",
-			new_hvs_state->core_clock_rate);
+		unsigned long core_rate = min_t(unsigned long,
+						hvs->max_core_rate,
+						new_hvs_state->core_clock_rate);
+
+		drm_dbg(dev, "Running the core clock at %lu Hz\n", core_rate);
 
 		/*
 		 * Request a clock rate based on the current HVS
 		 * requirements.
 		 */
-		WARN_ON(clk_set_min_rate(hvs->core_clk, new_hvs_state->core_clock_rate));
+		WARN_ON(clk_set_min_rate(hvs->core_clk, core_rate));
 
 		drm_dbg(dev, "Core clock actual rate: %lu Hz\n",
 			clk_get_rate(hvs->core_clk));

-- 
b4 0.11.0-dev-7da52
