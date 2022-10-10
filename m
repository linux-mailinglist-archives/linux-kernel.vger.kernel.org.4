Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F505FA06D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJJOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJJOrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:47:52 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F24647DE;
        Mon, 10 Oct 2022 07:47:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3ACA532007BE;
        Mon, 10 Oct 2022 10:47:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 10 Oct 2022 10:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665413268; x=
        1665499668; bh=9sqFsZNNl51RhUWDFFlTZugs83JAbNTW+MguCcEIsH0=; b=R
        wXAGvxeGYuGznb+t5u66uyzl7wfOu5fA7zC1AjsAejrvAM0nLM+zmT6G+qEvLctf
        FQFeqFqo6w9GRs/gSyvT/WrP1gYQYZMV/PqjehqtrgyX2Dyu9UrE32fS84egV9UU
        o0Kh6rAPOmzLthZIRaRC4DqYirWJo+WFyyxBjxgszEg/Ddp8MG1NHkB3jTd6TTUw
        aQGn3jBAaM9yRNBX5zLxzepl6GurR3q1UL6acV9Q685QK6KcP4jMk2//dCBAYmfG
        gPAP2g9UUcmJYWTwjup8QGoJF5fXDieWE63wQduPYkt4xHDxcqtkBHDmVdX3x2PO
        WjQTtbAHVnRg3z7d8UvzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665413268; x=
        1665499668; bh=9sqFsZNNl51RhUWDFFlTZugs83JAbNTW+MguCcEIsH0=; b=o
        39NGHgyFpPHHvz3+Jx6udxEoub0JqoGQ8egJP4tZA3baYizTnoIPu4EaBWE9i2Uu
        tDvOGk3rQPgyMR2XoMr2jLcWiGtW7KcGeiU+Aa+3O6PiFefC7jmxPfgEnSXUr4sC
        wQT83nlsYVoGJ1+QJNaAFAJClWueiy9LI5myzvimDQVvjuXU/H7oIQkKwViiOJsL
        LhqD4pWDgU8g/VbAr3dESz+Jd2gTOqQBmghxpGLmzUYEnFJxfK2I2p44+pKJCzhe
        Nq8132pZ/7iZnPB7Z5Zurptcqjv10RVjH7sbUKaElAxphFRL9ZnwK1sJXe0Ol2h/
        S093IMGTaa+ItMBLTyy7g==
X-ME-Sender: <xms:lDBEY8Hf7Uabw9xfWCqDkjSf3D_aLq0lr8dGkxqJOpMFMJ55K0b1MQ>
    <xme:lDBEY1XHMdalWt-5aiUoDiDeNpQiD81lgU7PLOUCZaFxj9tZZ-j4DhyQMP9dc-rOG
    reRo4bBMcvU6bF2O6E>
X-ME-Received: <xmr:lDBEY2KVBFxaD6wd9t8-t1DuoLCu-36FpQc0EVhZvuPDEG2zxSjyulnNVl2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnheplefhjedthedtgfdvgeetkeegfeeggfeifedvtdegffekteeivdehveef
    geekffejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgv
    tghh
X-ME-Proxy: <xmx:lDBEY-ESZUPeeqVbvSHlfsGq6z383fhrpKvA4m4f2mXmupObrfwzhA>
    <xmx:lDBEYyX0rkLDkMp0rDSRWWR6KMz-O1dxDMI3dRPfH-4sb4nTfMIuPg>
    <xmx:lDBEYxPO2TwgkgietOPjJSD1PzAxFilyHmj5fxjcWLW51c1v6rojTg>
    <xmx:lDBEY0feflghHESyWi_A1eIcpkvtqijjUs64eL0OZTBLWB91ot7vTw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 10:47:48 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Mon, 10 Oct 2022 16:47:38 +0200
Subject: [PATCH 1/2] clk: Update req_rate on __clk_recalc_rates()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221010-rpi-clk-fixes-again-v1-1-d87ba82ac404@cerno.tech>
References: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
In-Reply-To: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=5969; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=Ks0lq0K5/EYAMogpYjI5VVgAh5118kcALUO3PZkjYvk=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkuBn3HNypNM5xaOKe9d+nf7nsGbilnb0fb/1F7HsumzHxz
 Th9HRykLgxgXg6yYIkuMsPmSuFOzXney8c2DmcPKBDKEgYtTACbi95uR4ZXVxAZBp3npd6S+51ccv6
 PYfWd9bpbh7yl8996ZR79X3srIMPtRJW+02Z8t8iHxfW83Ldit8uqgueyep3t2bdjhzM/nyggA
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

Commit cb1b1dd96241 ("clk: Set req_rate on reparenting") introduced a
new function, clk_core_update_orphan_child_rates(), that updates the
req_rate field on reparenting.

It turns out that that function will interfere with the clock notifying
done by __clk_recalc_rates(). This ends up reporting the new rate in
both the old_rate and new_rate fields of struct clk_notifier_data.

Since clk_core_update_orphan_child_rates() is basically
__clk_recalc_rates() without the notifiers, and with the req_rate field
update, we can drop clk_core_update_orphan_child_rates() entirely, and
make __clk_recalc_rates() update req_rate.

However, __clk_recalc_rates() is being called in several code paths:
when retrieving a rate (most likely through clk_get_rate()), when changing
parents (through clk_set_rate() or clk_hw_reparent()), or when updating
the orphan status (through clk_core_reparent_orphans_nolock(), called at
registration).

Updating req_rate on reparenting or initialisation makes sense, but we
shouldn't do it on clk_get_rate(). Thus an extra flag has been added to
update or not req_rate depending on the context.

Fixes: cb1b1dd96241 ("clk: Set req_rate on reparenting")
Link: https://lore.kernel.org/linux-clk/0acc7217-762c-7c0d-45a0-55c384824ce4@samsung.com/
Link: https://lore.kernel.org/linux-clk/Y0QNSx+ZgqKSvPOC@sirena.org.uk/
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Mark Brown <broonie@kernel.org>
Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c | 39 +++++++++++----------------------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index dee5f39bfa90..c3c3f8c07258 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1759,6 +1759,7 @@ static unsigned long clk_recalc(struct clk_core *core,
 /**
  * __clk_recalc_rates
  * @core: first clk in the subtree
+ * @update_req: Whether req_rate should be updated with the new rate
  * @msg: notification type (see include/linux/clk.h)
  *
  * Walks the subtree of clks starting with clk and recalculates rates as it
@@ -1768,7 +1769,8 @@ static unsigned long clk_recalc(struct clk_core *core,
  * clk_recalc_rates also propagates the POST_RATE_CHANGE notification,
  * if necessary.
  */
-static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
+static void __clk_recalc_rates(struct clk_core *core, bool update_req,
+			       unsigned long msg)
 {
 	unsigned long old_rate;
 	unsigned long parent_rate = 0;
@@ -1782,6 +1784,8 @@ static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 		parent_rate = core->parent->rate;
 
 	core->rate = clk_recalc(core, parent_rate);
+	if (update_req)
+		core->req_rate = core->rate;
 
 	/*
 	 * ignore NOTIFY_STOP and NOTIFY_BAD return values for POST_RATE_CHANGE
@@ -1791,13 +1795,13 @@ static void __clk_recalc_rates(struct clk_core *core, unsigned long msg)
 		__clk_notify(core, msg, old_rate, core->rate);
 
 	hlist_for_each_entry(child, &core->children, child_node)
-		__clk_recalc_rates(child, msg);
+		__clk_recalc_rates(child, update_req, msg);
 }
 
 static unsigned long clk_core_get_rate_recalc(struct clk_core *core)
 {
 	if (core && (core->flags & CLK_GET_RATE_NOCACHE))
-		__clk_recalc_rates(core, 0);
+		__clk_recalc_rates(core, false, 0);
 
 	return clk_core_get_rate_nolock(core);
 }
@@ -1900,23 +1904,6 @@ static void clk_core_update_orphan_status(struct clk_core *core, bool is_orphan)
 		clk_core_update_orphan_status(child, is_orphan);
 }
 
-/*
- * Update the orphan rate and req_rate of @core and all its children.
- */
-static void clk_core_update_orphan_child_rates(struct clk_core *core)
-{
-	struct clk_core *child;
-	unsigned long parent_rate = 0;
-
-	if (core->parent)
-		parent_rate = core->parent->rate;
-
-	core->rate = core->req_rate = clk_recalc(core, parent_rate);
-
-	hlist_for_each_entry(child, &core->children, child_node)
-		clk_core_update_orphan_child_rates(child);
-}
-
 static void clk_reparent(struct clk_core *core, struct clk_core *new_parent)
 {
 	bool was_orphan = core->orphan;
@@ -1986,8 +1973,6 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *core,
 	clk_reparent(core, parent);
 	clk_enable_unlock(flags);
 
-	clk_core_update_orphan_child_rates(core);
-
 	return old_parent;
 }
 
@@ -2033,7 +2018,6 @@ static int __clk_set_parent(struct clk_core *core, struct clk_core *parent,
 		clk_reparent(core, old_parent);
 		clk_enable_unlock(flags);
 
-		clk_core_update_orphan_child_rates(core);
 		__clk_set_parent_after(core, old_parent, parent);
 
 		return ret;
@@ -2657,9 +2641,8 @@ static void clk_core_reparent(struct clk_core *core,
 				  struct clk_core *new_parent)
 {
 	clk_reparent(core, new_parent);
-	clk_core_update_orphan_child_rates(core);
 	__clk_recalc_accuracies(core);
-	__clk_recalc_rates(core, POST_RATE_CHANGE);
+	__clk_recalc_rates(core, true, POST_RATE_CHANGE);
 }
 
 void clk_hw_reparent(struct clk_hw *hw, struct clk_hw *new_parent)
@@ -2743,9 +2726,9 @@ static int clk_core_set_parent_nolock(struct clk_core *core,
 
 	/* propagate rate an accuracy recalculation accordingly */
 	if (ret) {
-		__clk_recalc_rates(core, ABORT_RATE_CHANGE);
+		__clk_recalc_rates(core, true, ABORT_RATE_CHANGE);
 	} else {
-		__clk_recalc_rates(core, POST_RATE_CHANGE);
+		__clk_recalc_rates(core, true, POST_RATE_CHANGE);
 		__clk_recalc_accuracies(core);
 	}
 
@@ -3642,7 +3625,7 @@ static void clk_core_reparent_orphans_nolock(void)
 			__clk_set_parent_before(orphan, parent);
 			__clk_set_parent_after(orphan, parent, NULL);
 			__clk_recalc_accuracies(orphan);
-			__clk_recalc_rates(orphan, 0);
+			__clk_recalc_rates(orphan, true, 0);
 
 			/*
 			 * __clk_init_parent() will set the initial req_rate to

-- 
b4 0.11.0-dev-7da52
