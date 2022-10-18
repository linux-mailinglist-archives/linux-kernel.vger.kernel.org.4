Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FEB602D79
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJRNxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiJRNxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:33 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05375CF86D;
        Tue, 18 Oct 2022 06:53:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 78F173200923;
        Tue, 18 Oct 2022 09:53:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 18 Oct 2022 09:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101190; x=
        1666187590; bh=ibUWEHKj/QGYphdrbN1NQxPjpBdpTfdPpbW8Zfp5n24=; b=q
        fdt2iuJGXRsapKcoIvKsndV90b43m3LdWkH/T7RkSR37uK3Nf75NrrJTWAPsIWRl
        QhKGn23g0Z5onkcIaAi2zzoIhQ2nWQuCd9PbfZM3pRM76w/TY+yC9SRtT1jBSpZn
        8B1Sv4OUP5A58Rw7C50iU/TARLMoEUElP5n+KpAwSSQuhTdTmpbgKFWWSWsFD/vD
        EyNmXdZNVridtOg9lGdYTW8J2w6WyOGDY33ZhZeuT/1tziodY5KwmUKB7nTPV+y/
        bMEP7Jw7J6IdgwsS/3NsOeKI4VOHQPl/IJ6/hyAvINzNUdd3f0V122q4IuFws5y1
        4l6px5eFUT3L2KgJNzwNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101190; x=
        1666187590; bh=ibUWEHKj/QGYphdrbN1NQxPjpBdpTfdPpbW8Zfp5n24=; b=g
        1B5U4uPMB2vzrOREFU+bd7TP+W4tMKIawGq74S8XCMEPT3rdOQlrxJgKApq3+10D
        qKJw8MjqMOlba/tCmAXE7pR67YYDkFrcgMV0n7ZlHR1jtQyIkXSafp1ThM3+BtAP
        pTcsHhwrGmHmjWrV8Bahoc1t8oXGSvg76bE3XwybOqBUg/UKO4c4ZCjWGP/UVU/E
        MMtZl0cuk3/PbyewIHO5EYA2q+VjV2iyqPLenhwPeCROk5Sj/q3r73FLbVnny39O
        KIAMozQyWo56b3GXammZP5O18PpqOkRNXwl9cVTzchror5rH6h5Wh5s9TSvMg5NN
        y0D7yY9RfuO4d6xhNzg6w==
X-ME-Sender: <xms:xa9OY61zsfZn6yGktQvMg84rdFC1oyz67_PckVlnyLl2Eu0OgoMgNA>
    <xme:xa9OY9HK7Whx-zWhNxBhpkgRqWGT3E1jgpezNjrYWCMmGGLctqabIsLfySKknIgWP
    PVBqVZlmod-1mc0Sv4>
X-ME-Received: <xmr:xa9OYy55g3_NdSTeVgb_5AhUMkgbJPz0clSuQqrwjxL9m9Pboy96UDOwVMW7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:xq9OY71YJUkDks77RSXRsaKll73g92JsM34S7DlyAL4cPo4csdlvNA>
    <xmx:xq9OY9FaIKO8wTintDSwollAe9sSqmfgDxAQQAEZ1ARCuO1UvFRaeA>
    <xmx:xq9OY08N8f3mA_vAPPJixlv7LlB6iLBEzfKBMfOI22JWJDIV_nyTKQ>
    <xmx:xq9OYxgBsqRgqkJZ2B4HH8eLaimdsLnScQjh06h9Cb_zYN0jDM3aNg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:53:09 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:52:59 +0200
Subject: [PATCH 4/4] clk: Warn if we register a mux without determine_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-range-checks-fixes-v1-4-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=oxdhfLzGwvzQhDYbvHA+Mn0OUJuj34vZoXZ5WdkABms=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+63fu+nej4e7DpG87NtquvJnTrMMx62dzYNLNbXErnauY
 2wrvdZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAi6coM/90MRYpaOizO27CvW3v6es
 tUDa/H0y/p5RuocE679bJngxAjw8lgu7haNeP4yMWLlsUXLdALn5O/vTs66PqqVbcPXPIM5wYA
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

The determine_rate hook allows to select the proper parent and its rate
for a given clock configuration. On another hand, set_parent is there to
change the parent of a mux.

Some clocks provide a set_parent hook but don't implement
determine_rate. In such a case, set_parent is pretty much useless since
the clock framework will always assume the current parent is to be used,
and we will thus never change it.

This situation can be solved in two ways:
  - either we don't need to change the parent, and we thus shouldn't
    implement set_parent;
  - or we don't want to change the parent, in this case we should set
    CLK_SET_RATE_NO_REPARENT;
  - or we're missing a determine_rate implementation.

The latter is probably just an oversight from the driver's author, and
we should thus raise their awareness about the fact that the current
state of the driver is confusing.

It's not clear at this point how many drivers are affected though, so
let's make it a warning instead of an error for now.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 57b83665e5c3..11c41d987ff4 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3700,6 +3700,11 @@ static int __clk_core_init(struct clk_core *core)
 		goto out;
 	}
 
+	/* TODO: Promote to an error */
+	if (core->ops->set_parent && !core->ops->determine_rate)
+		pr_warn("%s: %s must implement .set_parent & .determine_rate\n",
+			__func__, core->name);
+
 	if (core->num_parents > 1 && !core->ops->get_parent) {
 		pr_err("%s: %s must implement .get_parent as it has multi parents\n",
 		       __func__, core->name);

-- 
b4 0.11.0-dev-7da52
