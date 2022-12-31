Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9765A815
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiLaXOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235872AbiLaXOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:38 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B4C3E;
        Sat, 31 Dec 2022 15:14:37 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C45FE5C00AF;
        Sat, 31 Dec 2022 18:14:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:14:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672528476; x=
        1672614876; bh=gj3YwYb/ee2y+650wDSXXGGyk6dcEiCvb/zuXgo5cOk=; b=u
        NXjnlg9bd7th2Y70EJg23Yf/PzAnzeehqcU8N8cjWsniKEWF3j0erT7ilFJh2Y3M
        wVDUO3gJcz8wuicKAkeZK5V1J6cT7uxHsIJxI6RRkXG2nDwdKjSGBzlWB+RJm/zL
        GmiJSwjKZxjdGX75CwAAMN9MkPlFMsGypSw/vQIqkZ98yg/FwsJgFLdNXGrDdRuD
        0apCD2hB4e/qetG3PxjizPjSqtRP7k6pT1vWGtuVFgNZdPwrYUTOP7ohISKhqQPw
        m9tSXAZrimW36x2Xd99QtOHkpQR02JN6dJc2ADhYc7nnKKmtB1Od1jjfZyfkRoLF
        XuGaLp10LYGonzytc9GQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672528476; x=
        1672614876; bh=gj3YwYb/ee2y+650wDSXXGGyk6dcEiCvb/zuXgo5cOk=; b=h
        /hFhsVAlmBzPmp5Xg1CHBYrTX0IE2xrY0CEWj3t3BnyjbsGhyDJNYDcrob+YSSo3
        Z5khLEdvfRkL8Dczy88qvjucrmIS/tXk147RyEfC4aMs9ndQwbRki8hxH07S0A2L
        itHZOUyy8M9US2beCqelxD59mHfgXDgM6jn8eMGBHBDzuCtX2NGS9Tr9np94Dz3b
        esjlsfaiY60bvKc+pYexElNwzWbQ7SZgUI/3ywL6lePWLa8+TCCad2AMeh79TSCy
        0LYrBVe6s4YhE2aALZ9kfnoSXCIVkL5hCJ/surhDltbMY7eRAYnclTubnIhe0e9b
        pv7X02SUPV6tR3BiAtOxg==
X-ME-Sender: <xms:XMKwY7TXenYutuZu09XLhaBXRqiSBy0LC3_CGgEqZFzfJW8bpGDNZA>
    <xme:XMKwY8yr_wkag7oakk6ZZo6-4D6Bb0YVUYTRsbmVAblsz_8hVsXrLcurwqKuqVd1Q
    ChpXkhaApxsAwoy8A>
X-ME-Received: <xmr:XMKwYw3GpTW5XD6D6m-6q_y7rjBqfV2XiZ3d_UKKGu0mfiqPDC-EaFKKpo0eMJIzivj89H0hI0tTtsGlzvWOdTUCZANoU_LoAizbi-W4hUOF8_QAk6hLKoHlhey9yUDc-2Jzdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepfeeuveeufeefleehlefhleeglefggfeikeffveetfeevjeeuieet
    uefgfeeiheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XMKwY7BtZOZ8OgfjlorT-gbC-1PC_xI3wUtAmxrITbennHFRRxXeFw>
    <xmx:XMKwY0iY0k21qcFw_oXzSDCUUInsHZ4q57U9P_ZllYhyi3s9PxUzJQ>
    <xmx:XMKwY_oiwqqe7OA5TeCAARdnxXWzGhE8VBUAEXllsJ5bWLNNXs5t1Q>
    <xmx:XMKwY3VxGuOo34bMtN3UU4CcuC_DPJUOhHImhPjqJZYX85nYpL0m6Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:35 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C5=91?= <szemzo.andras@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 4/6] clk: sunxi-ng: d1: Mark cpux clock as critical
Date:   Sat, 31 Dec 2022 17:14:27 -0600
Message-Id: <20221231231429.18357-5-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231231429.18357-1-samuel@sholland.org>
References: <20221231231429.18357-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: András Szemző <szemzo.andras@gmail.com>

Some SoCs in the D1 family feature ARM CPUs instead of a RISC-V CPU.
In that case, the CPUs are driven from the 'cpux' clock, so it needs
to be marked as critical, since there is no consumer when DVFS is
disabled. This matches the drivers for other SoCs, and the "riscv"
clock in this driver.

Signed-off-by: András Szemző <szemzo.andras@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Expand commit message

 drivers/clk/sunxi-ng/ccu-sun20i-d1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
index 8ef3cdeb7962..c5a7df93602c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
+++ b/drivers/clk/sunxi-ng/ccu-sun20i-d1.c
@@ -240,7 +240,7 @@ static const struct clk_parent_data cpux_parents[] = {
 	{ .hw = &pll_periph0_800M_clk.common.hw },
 };
 static SUNXI_CCU_MUX_DATA(cpux_clk, "cpux", cpux_parents,
-			  0x500, 24, 3, CLK_SET_RATE_PARENT);
+			  0x500, 24, 3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
 
 static const struct clk_hw *cpux_hws[] = { &cpux_clk.common.hw };
 static SUNXI_CCU_M_HWS(cpux_axi_clk, "cpux-axi",
-- 
2.37.4

