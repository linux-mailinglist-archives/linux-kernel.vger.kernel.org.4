Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84ADA60F822
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiJ0Mxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiJ0MxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:53:17 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198A2171CDC;
        Thu, 27 Oct 2022 05:53:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5583132000EB;
        Thu, 27 Oct 2022 08:53:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 27 Oct 2022 08:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666875194; x=
        1666961594; bh=67IzTCRh4qW/hzamLxKdjmxW1UKt2uwkux6U/mCqIrA=; b=H
        0nZKB4oiw7Md34HGAnVwK2EcAweJM0DLdoIp1psn3wQvc//rmFEVKqRcbUt/X9n4
        xzxH7m/eMOKu+qZ+IYldi2jSYVsj+pYCNwm5UIge6zshlFa9Kv3oHSIv4MmIAW63
        G6YejaGZtb27VIq3ocZHKgGTxXOFE0WZIMqCbAap3QB0LSvBzzCY2oljtw7zFB6Z
        uwYULMmR1KFuKgbPOxqKlWrBrLAQljB1+y3v5OIzX3ULbv3gnbCUFWopYPKLC7By
        1JZx3YLZ2iWns5gQT61b7jTTIm1kczN1U3n+6ykG1s7H3ZpxV5T/5EEZcRSbvRmk
        Rn35YuotNFM4WhNPt6x+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666875194; x=
        1666961594; bh=67IzTCRh4qW/hzamLxKdjmxW1UKt2uwkux6U/mCqIrA=; b=Y
        Gj7YkruB9joRZbx0jid5mEqvWWhOvUdab/b4P4+xT1/c3IMg7OF5ZwDHMILXueTy
        AIxF3k4lQtOc9WPSQrGRdzLMn1UD/THpd58O4Mk34GVzALXl0wDj7DtbKmInUjJg
        QqQb/U/w/TdMzQg2vbEvau8WeVN7R9SJ37Jb6dg4t00/kIbU9qPQzImtpaVj53rv
        E6y2MynFlYh5jhJr55pRW7VvYH/zyzQc5d9CnNAAcx7Ms/m1RHRqeWgWU8A31ZB8
        41oIUXauymemXnyNzEsurbEYuR533f9mwfRW5mR3zWD4ozXa80RQG7gEobbM71h7
        kX4WVIAmVkSfHn8txKOLw==
X-ME-Sender: <xms:On9aY4mE1aQ_PU-Q5kUs9kD7HDeRHBCGKawGtE8kbAzyh0nRl6wR0g>
    <xme:On9aY32gPkgg3TKUoOz2CSjCSeDXoxhepOUTPGI7PZ1P61hPj6WR3g9CVnOoyhVVF
    YH-MqGuTINc5v34ui0>
X-ME-Received: <xmr:On9aY2r7dldfwmk7DGCLZp1NT4WtHyMqsT7bXkTa4Eg0Q2Brfj8c4AmRc64fP02g4g7pf4S_PoaL2wfz2xAccLcRXQn45Jd4xCsNOB7q-dLq-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeduudduhfevjeetfeegvdffvdevvdejudegudekjeehtdelhfffveethfej
    ledtveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:On9aY0m0JRrYsdbfVf9447xMmY4gcjOEKC2HhujjCr3R069QXZd3hw>
    <xmx:On9aY20dl7_Gaw_0912NGpI7Pp2hxTVO_Qff3ZOguzwUNJcM67lj-A>
    <xmx:On9aY7sRKn--fqHGVew2GM48QJrLF3u9b0nQuvQKsjf-pSN3HDrP5A>
    <xmx:On9aY24yGEHVozGAySLRWaormtN7vHG4ObhS0rQHXOQqiAuMfVd-vA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Oct 2022 08:53:14 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Thu, 27 Oct 2022 14:52:47 +0200
Subject: [PATCH v5 7/7] drm/vc4: Make sure we don't end up with a core clock too high
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220815-rpi-fix-4k-60-v5-7-fe9e7ac8b111@cerno.tech>
References: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech>
In-Reply-To: <20220815-rpi-fix-4k-60-v5-0-fe9e7ac8b111@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@linux.ie>, Ray Jui <rjui@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, Dom Cobley <popcornmix@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
X-Mailer: b4 0.11.0-dev-99e3a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=idKX39IZNRr15VFsJbs3Y0d0YRgsqMO9SnCUIwEP+ZQ=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMlR9TJ7I+L36tWeeVRUMNn3s30OT4VKV8aKTWI+x0V/eMr1
 rfDuKGVhEONikBVTZIkRNl8Sd2rW6042vnkwc1iZQIYwcHEKwESU5BkZLr+VnFTzp+toilxleN2zj9
 mRPN/6lx+Ms56zd6u6EVPnT0aGk1fEq5RKzj6+UGl/4lvbk7KOm8vufv12ZtPtZfx1JyxOMQAA
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

Following the clock rate range improvements to the clock framework,
trying to set a disjoint range on a clock will now result in an error.

Thus, we can't set a minimum rate higher than the maximum reported by
the firmware, or clk_set_min_rate() will fail.

Thus we need to clamp the rate we are about to ask for to the maximum
rate possible on that clock.

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 4419e810103d..5c97642ed66a 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -396,8 +396,8 @@ static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
 	if (vc4->is_vc5) {
 		unsigned long state_rate = max(old_hvs_state->core_clock_rate,
 					       new_hvs_state->core_clock_rate);
-		unsigned long core_rate = max_t(unsigned long,
-						500000000, state_rate);
+		unsigned long core_rate = clamp_t(unsigned long, state_rate,
+						  500000000, hvs->max_core_rate);
 
 		drm_dbg(dev, "Raising the core clock at %lu Hz\n", core_rate);
 
@@ -431,14 +431,17 @@ static void vc4_atomic_commit_tail(struct drm_atomic_state *state)
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
b4 0.11.0-dev-99e3a
