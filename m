Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA75FA06F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiJJOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiJJOrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:47:55 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64871708;
        Mon, 10 Oct 2022 07:47:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4A5BD32008FE;
        Mon, 10 Oct 2022 10:47:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 10 Oct 2022 10:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665413272; x=
        1665499672; bh=VYzEzYyl82dyfftA+WmV6ia0U2mNve7T+OIZKjpk+VI=; b=a
        jXQKRMH7wE5HCdF56J1sigTi3wHAH6k5wPE/t2u30MKW781Hk0sHDAx72mtBC5tr
        LLvGte/WUbbmSxQdCKkn+1O41POODy7Y50vS4JKpQcv/xhfNcsS0nbR2pseSdoJQ
        jqqXioYeMfrBzn7W46KEeh/+r7L+WY0TlT1wb3vsDJ+ayHbfj1EqNH+jfyPDIffk
        l4m01PLMSV+A6TXBwEjYZPSP1njavIRchEzljt9vXkN3ed/R9RaNZnfeOOmhdXHT
        tLtTp7qSGgNw3MP/p8stPESEq7aT1bsVHd4WOeFbjk367+OXxstP+NK348olB1k/
        uj2x3uWx4KWJnD37yP//A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665413272; x=
        1665499672; bh=VYzEzYyl82dyfftA+WmV6ia0U2mNve7T+OIZKjpk+VI=; b=q
        savttqCZcIebpZoRbGJVNbvadUG/QBI7aASNETuE7pBFp82xCt5/iax6iz0wnFql
        LRYsv9bVUTbgMvIofP9b6KatN5QLN2QZn7Ppl7tSoyX+03tzPxZ3LRgy2uUC2Gqs
        iD4K7r4hwXeZhHesYwDX2jfwhGuOCzvc1rlCYGgfCOW0mzGjXbMnW0rKzV+2K8B+
        HAL+E4uRj1HLLP3O0dwWnLLrfV1BRGhx3m5lmKAFO44xx7StK3Hcy33J7cXE1I6E
        9iHOtOCQXbSIZudRuPvQjiMdK5dCVCurjc7+TuzALGVP6mNsr7y9Z127MYG19CEx
        +w3/gtfnWAkUoEY3DjJxg==
X-ME-Sender: <xms:mDBEYy5AYmFMF91wYJvwSjbV4SsShgIIQEfFs1SUcaApu-UP-hfhQg>
    <xme:mDBEY77D3BJnAlbHFg5Qcp5m57dOuqA1BISW0bHI8Ail04_flXu_f-kf4v6ks_iSd
    8FO99eaV30a_uSTVUs>
X-ME-Received: <xmr:mDBEYxdkZI5np61LBiy9TxArBnM4DOFsBY7yWaWTuPokpPC9g0cLRYghIXzZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:mDBEY_Kzwk6F82-S7gcMimsdl_opARjRV49NLEVOtoGD3mdiyY6JYw>
    <xmx:mDBEY2LO7XG5a4-A8OYL3HsUY_qlUIW4cE51JwEctpr5ENrSe5zRog>
    <xmx:mDBEYwyI6-gcZfn1XcglAt_TjTvh426dzSKsM_St-GRTlN7Uv1ZstQ>
    <xmx:mDBEY4iCAIw5ba6AiEyDW9KhbEmJ-IaBxTYqp994QvIkVxUSiYfQpQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 10:47:52 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Mon, 10 Oct 2022 16:47:39 +0200
Subject: [PATCH 2/2] clk: tests: Add tests for notifiers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221010-rpi-clk-fixes-again-v1-2-d87ba82ac404@cerno.tech>
References: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
In-Reply-To: <20221010-rpi-clk-fixes-again-v1-0-d87ba82ac404@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=5977; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=qsUxVzjg5I8tBKGM4PNlOQk2kkZdya2meK9l7sVQtUI=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMkuBn31dyqmtCwuvjFBJdd4Ss7h9sXaL9fnPHixcEXlihT5
 eetmd5SyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi9qsY/pnWyK1i2Jub/cHE2OX/tT
 MJ6+66Mx1eIOlVuNy2zWBD3W9GhuV7qiM38h+Ufxkd9nXFe725co94Xq5+FMK4cHNi1vF5dzgB
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

We're recently encountered a regression due to the rates reported
through the clk_notifier_data being off when changing parents.

Let's add a test suite and a test to make sure that we do get notified
and with the proper rates.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk_test.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index 509256c5567a..f9a5c2964c65 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -2239,10 +2239,166 @@ static struct kunit_suite clk_leaf_mux_set_rate_parent_test_suite = {
 	.test_cases = clk_leaf_mux_set_rate_parent_test_cases,
 };
 
+struct clk_mux_notifier_rate_change {
+	bool done;
+	unsigned long old_rate;
+	unsigned long new_rate;
+	wait_queue_head_t wq;
+};
+
+struct clk_mux_notifier_ctx {
+	struct clk_multiple_parent_ctx mux_ctx;
+	struct clk *clk;
+	struct notifier_block clk_nb;
+	struct clk_mux_notifier_rate_change pre_rate_change;
+	struct clk_mux_notifier_rate_change post_rate_change;
+};
+
+#define NOTIFIER_TIMEOUT_MS 100
+
+static int clk_mux_notifier_callback(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct clk_notifier_data *clk_data = data;
+	struct clk_mux_notifier_ctx *ctx = container_of(nb,
+							struct clk_mux_notifier_ctx,
+							clk_nb);
+
+	if (action & PRE_RATE_CHANGE) {
+		ctx->pre_rate_change.old_rate = clk_data->old_rate;
+		ctx->pre_rate_change.new_rate = clk_data->new_rate;
+		ctx->pre_rate_change.done = true;
+		wake_up_interruptible(&ctx->pre_rate_change.wq);
+	}
+
+	if (action & POST_RATE_CHANGE) {
+		ctx->post_rate_change.old_rate = clk_data->old_rate;
+		ctx->post_rate_change.new_rate = clk_data->new_rate;
+		ctx->post_rate_change.done = true;
+		wake_up_interruptible(&ctx->post_rate_change.wq);
+	}
+
+	return 0;
+}
+
+static int clk_mux_notifier_test_init(struct kunit *test)
+{
+	struct clk_mux_notifier_ctx *ctx;
+	const char *top_parents[2] = { "parent-0", "parent-1" };
+	int ret;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+	ctx->clk_nb.notifier_call = clk_mux_notifier_callback;
+	init_waitqueue_head(&ctx->pre_rate_change.wq);
+	init_waitqueue_head(&ctx->post_rate_change.wq);
+
+	ctx->mux_ctx.parents_ctx[0].hw.init = CLK_HW_INIT_NO_PARENT("parent-0",
+								    &clk_dummy_rate_ops,
+								    0);
+	ctx->mux_ctx.parents_ctx[0].rate = DUMMY_CLOCK_RATE_1;
+	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[0].hw);
+	if (ret)
+		return ret;
+
+	ctx->mux_ctx.parents_ctx[1].hw.init = CLK_HW_INIT_NO_PARENT("parent-1",
+								    &clk_dummy_rate_ops,
+								    0);
+	ctx->mux_ctx.parents_ctx[1].rate = DUMMY_CLOCK_RATE_2;
+	ret = clk_hw_register(NULL, &ctx->mux_ctx.parents_ctx[1].hw);
+	if (ret)
+		return ret;
+
+	ctx->mux_ctx.current_parent = 0;
+	ctx->mux_ctx.hw.init = CLK_HW_INIT_PARENTS("test-mux", top_parents,
+						   &clk_multiple_parents_mux_ops,
+						   0);
+	ret = clk_hw_register(NULL, &ctx->mux_ctx.hw);
+	if (ret)
+		return ret;
+
+	ctx->clk = clk_hw_get_clk(&ctx->mux_ctx.hw, NULL);
+	ret = clk_notifier_register(ctx->clk, &ctx->clk_nb);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void clk_mux_notifier_test_exit(struct kunit *test)
+{
+	struct clk_mux_notifier_ctx *ctx = test->priv;
+	struct clk *clk = ctx->clk;
+
+	clk_notifier_unregister(clk, &ctx->clk_nb);
+	clk_put(clk);
+
+	clk_hw_unregister(&ctx->mux_ctx.hw);
+	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[0].hw);
+	clk_hw_unregister(&ctx->mux_ctx.parents_ctx[1].hw);
+}
+
+/*
+ * Test that if the we have a notifier registered on a mux, the core
+ * will notify us when we switch to another parent, and with the proper
+ * old and new rates.
+ */
+static void clk_mux_notifier_set_parent_test(struct kunit *test)
+{
+	struct clk_mux_notifier_ctx *ctx = test->priv;
+	struct clk_hw *hw = &ctx->mux_ctx.hw;
+	struct clk *clk = clk_hw_get_clk(hw, NULL);
+	struct clk *new_parent = clk_hw_get_clk(&ctx->mux_ctx.parents_ctx[1].hw, NULL);
+	int ret;
+
+	ret = clk_set_parent(clk, new_parent);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = wait_event_interruptible_timeout(ctx->pre_rate_change.wq,
+					       ctx->pre_rate_change.done,
+					       msecs_to_jiffies(NOTIFIER_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, ctx->pre_rate_change.old_rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_EQ(test, ctx->pre_rate_change.new_rate, DUMMY_CLOCK_RATE_2);
+
+	ret = wait_event_interruptible_timeout(ctx->post_rate_change.wq,
+					       ctx->post_rate_change.done,
+					       msecs_to_jiffies(NOTIFIER_TIMEOUT_MS));
+	KUNIT_ASSERT_GT(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, ctx->post_rate_change.old_rate, DUMMY_CLOCK_RATE_1);
+	KUNIT_EXPECT_EQ(test, ctx->post_rate_change.new_rate, DUMMY_CLOCK_RATE_2);
+
+	clk_put(new_parent);
+	clk_put(clk);
+}
+
+static struct kunit_case clk_mux_notifier_test_cases[] = {
+	KUNIT_CASE(clk_mux_notifier_set_parent_test),
+	{}
+};
+
+/*
+ * Test suite for a mux with multiple parents, and a notifier registered
+ * on the mux.
+ *
+ * These tests exercise the behaviour of notifiers.
+ */
+static struct kunit_suite clk_mux_notifier_test_suite = {
+	.name = "clk-mux-notifier",
+	.init = clk_mux_notifier_test_init,
+	.exit = clk_mux_notifier_test_exit,
+	.test_cases = clk_mux_notifier_test_cases,
+};
+
 kunit_test_suites(
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
 	&clk_multiple_parents_mux_test_suite,
+	&clk_mux_notifier_test_suite,
 	&clk_orphan_transparent_multiple_parent_mux_test_suite,
 	&clk_orphan_transparent_single_parent_test_suite,
 	&clk_orphan_two_level_root_last_test_suite,

-- 
b4 0.11.0-dev-7da52
