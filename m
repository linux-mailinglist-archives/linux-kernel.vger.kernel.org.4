Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DEE65A5F0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiLaRbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLaRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:30:58 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E238AF;
        Sat, 31 Dec 2022 09:30:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 41C305C0086;
        Sat, 31 Dec 2022 12:30:57 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 12:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672507857; x=1672594257; bh=rAkPHCX9plm+ABZSDox55LMS1
        3uIo7UeVXFHjSskAHQ=; b=Qo+VuWcep4oeUtwyEADa6CHvTwfGVZbGjif7a2tDY
        yaOJuMB+uFmLP4vDP1IpzFGe5v/SldOQBHCj6nuU2Klv87MY890lJnZ+VC6h3a6Q
        qfGYvYMCIMyWKL/tRJQS/dmbUhBA3lJ/1qDgRp7QD0DHGm1eCI7PlgbEZPi4uiLY
        kbfMrcsG7KMKC+MvAS9hUBLaR8bG8J0SmsYCaimRbn6hUZEGukaraUTpY/CzqASV
        OMFOA4Ew9nR0oCTpk5EkRBUqs6BRAXTizGzB7tBZi8mhRm6ssqlPmQpPzPvj0Rac
        CTsoTi6YSqYWK8jkM0YslUxGElEleE3fxJ1ZPkYcXnbXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672507857; x=1672594257; bh=rAkPHCX9plm+ABZSDox55LMS13uIo7UeVXF
        HjSskAHQ=; b=jwAQQAoEnZQwzdJNOZ2c0YFbC8dROsSnDKxlPJ4ufuQuGuggjth
        tF9zy3jo9BSw+GH97lJiGWbOudhd3Vis0H6wHpyL2y1Y48S8KFgF42QqbY321v81
        /Q555sswcdpg2UuhpSxEDTdvsnbj2Uy5JcrjqX4MvaQpdCNKxS6+kPvakAEEZEP3
        9k2zq2HQIzzz3Ks0kGndN2AVHWuhsLA8xFSaTjkhHV6kDc/KG5+lqWYhvkK+EzAI
        eYBt4reUQlqScDr1N4D67Qplg+lXsOsPfAX78LieG2PJh00DYyrqNkWsJnOui0UW
        y94odSVxCV56yKLP0RFoXDRkTpndYb8/++w==
X-ME-Sender: <xms:0XGwY_ZKARe42eaPoYyQrjdvGJvaOsQe4KdjBr6FbJO_ehg00aWu3A>
    <xme:0XGwY-YKpKselZ21u1O7gAOeCzSFkhXilr_XYFCqhxqyVzKiinEmSIweNs7o4q-FC
    hIYpQdVS824rElLlA>
X-ME-Received: <xmr:0XGwYx-gC-62ZyIB2s0zfYhSOJ-SmNxQ6Nn_OtDi8x0bXHoV-phi8D8nzo5EzmjBFSxE0oNDl_aqkTCbfBt2010jhLj51Re1KygY68e50BZyl9uBBn6nUlPyi2_su8swxyal1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:0XGwY1pzRpCQ9s53x8iqcIjQi_K2Z6lClej9oUXsQT4f6C2q3pJsDw>
    <xmx:0XGwY6q93VhxHwswr2B5Fa-QFuJj16NeYiUy-cb4qYXd5RseQCt89A>
    <xmx:0XGwY7QZb9SBPYQVPbxvVzTp-mHOHoy2DnWoaHUzheR8LsCz775CNQ>
    <xmx:0XGwY6IaXv_YN69rcA21xtJcpMGecoJRpadLPWVVrRrzYV-rUWjp7w>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 12:30:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2] clk: sunxi-ng: Avoid computing the rate twice
Date:   Sat, 31 Dec 2022 11:30:55 -0600
Message-Id: <20221231173055.42384-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccu_*_find_best() functions already compute a best_rate at the same
time as the other factors. Return this value so the caller does not need
to duplicate the computation.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Apply the same change also to nk, nkm, nkmp, and nm
 - Update the commit message

 drivers/clk/sunxi-ng/ccu_mp.c   | 11 ++++++-----
 drivers/clk/sunxi-ng/ccu_nk.c   |  9 +++++----
 drivers/clk/sunxi-ng/ccu_nkm.c  | 10 +++++-----
 drivers/clk/sunxi-ng/ccu_nkmp.c | 10 +++++-----
 drivers/clk/sunxi-ng/ccu_nm.c   |  9 +++++----
 5 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 57cf2d615148..cc94a694cb67 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -10,9 +10,9 @@
 #include "ccu_gate.h"
 #include "ccu_mp.h"
 
-static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
-			     unsigned int max_m, unsigned int max_p,
-			     unsigned int *m, unsigned int *p)
+static unsigned long ccu_mp_find_best(unsigned long parent, unsigned long rate,
+				      unsigned int max_m, unsigned int max_p,
+				      unsigned int *m, unsigned int *p)
 {
 	unsigned long best_rate = 0;
 	unsigned int best_m = 0, best_p = 0;
@@ -35,6 +35,8 @@ static void ccu_mp_find_best(unsigned long parent, unsigned long rate,
 
 	*m = best_m;
 	*p = best_p;
+
+	return best_rate;
 }
 
 static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
@@ -109,8 +111,7 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 	max_p = cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
 
 	if (!clk_hw_can_set_rate_parent(&cmp->common.hw)) {
-		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
-		rate = *parent_rate / p / m;
+		rate = ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
 	} else {
 		rate = ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
 							max_m, max_p);
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index c4fb82af97e8..8aa35d5804f3 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -15,8 +15,8 @@ struct _ccu_nk {
 	unsigned long	k, min_k, max_k;
 };
 
-static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
-			     struct _ccu_nk *nk)
+static unsigned long ccu_nk_find_best(unsigned long parent, unsigned long rate,
+				      struct _ccu_nk *nk)
 {
 	unsigned long best_rate = 0;
 	unsigned int best_k = 0, best_n = 0;
@@ -39,6 +39,8 @@ static void ccu_nk_find_best(unsigned long parent, unsigned long rate,
 
 	nk->k = best_k;
 	nk->n = best_n;
+
+	return best_rate;
 }
 
 static void ccu_nk_disable(struct clk_hw *hw)
@@ -104,8 +106,7 @@ static long ccu_nk_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nk.min_k = nk->k.min ?: 1;
 	_nk.max_k = nk->k.max ?: 1 << nk->k.width;
 
-	ccu_nk_find_best(*parent_rate, rate, &_nk);
-	rate = *parent_rate * _nk.n * _nk.k;
+	rate = ccu_nk_find_best(*parent_rate, rate, &_nk);
 
 	if (nk->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate = rate / nk->fixed_post_div;
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 67da2c189b53..a0978a50edae 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -16,8 +16,8 @@ struct _ccu_nkm {
 	unsigned long	m, min_m, max_m;
 };
 
-static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
-			      struct _ccu_nkm *nkm)
+static unsigned long ccu_nkm_find_best(unsigned long parent, unsigned long rate,
+				       struct _ccu_nkm *nkm)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_k = 0, best_m = 0;
@@ -45,6 +45,8 @@ static void ccu_nkm_find_best(unsigned long parent, unsigned long rate,
 	nkm->n = best_n;
 	nkm->k = best_k;
 	nkm->m = best_m;
+
+	return best_rate;
 }
 
 static void ccu_nkm_disable(struct clk_hw *hw)
@@ -122,9 +124,7 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate *= nkm->fixed_post_div;
 
-	ccu_nkm_find_best(*parent_rate, rate, &_nkm);
-
-	rate = *parent_rate * _nkm.n * _nkm.k / _nkm.m;
+	rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm);
 
 	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nkm->fixed_post_div;
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index 39413cb0985c..99359a06892d 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -29,8 +29,8 @@ static unsigned long ccu_nkmp_calc_rate(unsigned long parent,
 	return rate;
 }
 
-static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
-			       struct _ccu_nkmp *nkmp)
+static unsigned long ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
+					struct _ccu_nkmp *nkmp)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_k = 0, best_m = 0, best_p = 0;
@@ -65,6 +65,8 @@ static void ccu_nkmp_find_best(unsigned long parent, unsigned long rate,
 	nkmp->k = best_k;
 	nkmp->m = best_m;
 	nkmp->p = best_p;
+
+	return best_rate;
 }
 
 static void ccu_nkmp_disable(struct clk_hw *hw)
@@ -150,10 +152,8 @@ static long ccu_nkmp_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nkmp.min_p = 1;
 	_nkmp.max_p = nkmp->p.max ?: 1 << ((1 << nkmp->p.width) - 1);
 
-	ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
+	rate = ccu_nkmp_find_best(*parent_rate, rate, &_nkmp);
 
-	rate = ccu_nkmp_calc_rate(*parent_rate, _nkmp.n, _nkmp.k,
-				  _nkmp.m, _nkmp.p);
 	if (nkmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate = rate / nkmp->fixed_post_div;
 
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 9ca9257f4426..c1fd11542c45 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -27,8 +27,8 @@ static unsigned long ccu_nm_calc_rate(unsigned long parent,
 	return rate;
 }
 
-static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
-			     struct _ccu_nm *nm)
+static unsigned long ccu_nm_find_best(unsigned long parent, unsigned long rate,
+				      struct _ccu_nm *nm)
 {
 	unsigned long best_rate = 0;
 	unsigned long best_n = 0, best_m = 0;
@@ -52,6 +52,8 @@ static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 
 	nm->n = best_n;
 	nm->m = best_m;
+
+	return best_rate;
 }
 
 static void ccu_nm_disable(struct clk_hw *hw)
@@ -157,8 +159,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsigned long rate,
 	_nm.min_m = 1;
 	_nm.max_m = nm->m.max ?: 1 << nm->m.width;
 
-	ccu_nm_find_best(*parent_rate, rate, &_nm);
-	rate = ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
+	rate = ccu_nm_find_best(*parent_rate, rate, &_nm);
 
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /= nm->fixed_post_div;
-- 
2.37.4

