Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61BD65A816
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiLaXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiLaXOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:14:39 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF9CD88;
        Sat, 31 Dec 2022 15:14:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C8E25C00B2;
        Sat, 31 Dec 2022 18:14:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 31 Dec 2022 18:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672528478; x=1672614878; bh=vV
        7vYH4agevEo5q+yfciQz3W+RJ72+EvdN+fDOEeFek=; b=jlddHFvbspOwBPLYXf
        qYITsjOeyq0HnzQCHkE3fAZjqQsTX9iSs9H4+Fo41ubJKLP7d+HXrHgfkzeWaMoV
        9EJXlOYlDSca0TWW12LtCg+mzMuo8sL+oVdC8B+FVWjuFVTDiFDXpxCJpxLBfvmf
        IGYDde2fw/OONOkKsrB1OBBLf67GvXKcPSWoQLZhNtmdXaE4RQXfNHe7BMLp0Oq0
        hLcKiGJ6/Dy/3+Q6CAqb0oxkxOruBXz1QQU4mfMaTZpPBKKRYZTt8+nXppXyK8C9
        PjJqrphtz0hHgzLSmw56P41mO0YSUwIc4oguovXBBAjx+M6hCXbBeNKYXk8F55Vw
        C5Lw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672528478; x=1672614878; bh=vV7vYH4agevEo
        5q+yfciQz3W+RJ72+EvdN+fDOEeFek=; b=WGx3j//KHynZU1d4sSGXSfeiYmt0R
        t68DjBq6DWJi0hwSZ4NeJPZYIjRerFW1fg2s1cHmc2Kj5NrG0CINZug/sLbecTrR
        dx91tl3eOymA9i5bGnHpxydhqsxYWz+IUSpnEP6vPZkj2VoiCmgZMtNx5hwBYfRX
        TqnRHgsPYCZ9syD7fwFt66hSNjxlBGSgLU9/UWXy6pf0GWL95tJF03rbODG81CJk
        4GbRye59LXM0Kh4PCPlJ5sLKKL5O5iJwi8UIoz+NqMGYR5zoiR6TUE06Uqzg8sab
        QhET3CpReEkXgDCDIBkIk6WGhDq8S6Fp8fCFSLYnP359f883EfYhwBmCQ==
X-ME-Sender: <xms:XcKwYwwD6aSSeHUBAhiRu4Dqm4PcmCdN5r34ThvcaEiE71bDivsWGw>
    <xme:XcKwY0Qw-Q7U80vLpBwOJALBUgunVezKwskpgdH59aUKNfruwbtrC6Eny0TdsBDTZ
    6v8b4LDH3mo6orVpg>
X-ME-Received: <xmr:XcKwYyX9hq9mGAu0ftrOi5gT4dFCy6iGvjgsLd6p1uo4sj2SwHq71H5Ji2z2wxcCG8UZzTxAMyXY1q91Rs4fEILSGTpXCngHZwczYZ0wkib-Dg6gJZaRsI9W8S8rzUgughEHNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:XcKwY-hy6Lwm2hfLgsMOXh_Pu5nmVRIwFxR38GdQguQf7PQW2peVLw>
    <xmx:XcKwYyAhWaAil7xuLU7CW5VppYACK_fTKb7tfll_-GvxBYQE7LDORw>
    <xmx:XcKwY_J2HCRJvv02xicRYkln5vdV0QbH4otQLWsoehoG6ibokpiI_w>
    <xmx:XsKwY8wzJWk0CC4eYsBFGZkYDSnZlMR6xfqVZ0PcCuC2otFm2F7LqA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:14:37 -0500 (EST)
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
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v2 5/6] dt-bindings: clock: Add D1 CAN bus gates and resets
Date:   Sat, 31 Dec 2022 17:14:28 -0600
Message-Id: <20221231231429.18357-6-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231231429.18357-1-samuel@sholland.org>
References: <20221231231429.18357-1-samuel@sholland.org>
MIME-Version: 1.0
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

The D1 CCU contains gates and resets for two CAN buses. While the CAN
bus controllers are only documented for the T113 SoC, the CCU is the
same across all SoC variants.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Move dt-bindings header changes to a separate patch

 include/dt-bindings/clock/sun20i-d1-ccu.h | 2 ++
 include/dt-bindings/reset/sun20i-d1-ccu.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/sun20i-d1-ccu.h b/include/dt-bindings/clock/sun20i-d1-ccu.h
index e3ac53315e1a..e143b9929763 100644
--- a/include/dt-bindings/clock/sun20i-d1-ccu.h
+++ b/include/dt-bindings/clock/sun20i-d1-ccu.h
@@ -152,5 +152,7 @@
 #define CLK_FANOUT0		142
 #define CLK_FANOUT1		143
 #define CLK_FANOUT2		144
+#define CLK_BUS_CAN0		145
+#define CLK_BUS_CAN1		146
 
 #endif /* _DT_BINDINGS_CLK_SUN20I_D1_CCU_H_ */
diff --git a/include/dt-bindings/reset/sun20i-d1-ccu.h b/include/dt-bindings/reset/sun20i-d1-ccu.h
index de9ff5203239..f8001cf50bf1 100644
--- a/include/dt-bindings/reset/sun20i-d1-ccu.h
+++ b/include/dt-bindings/reset/sun20i-d1-ccu.h
@@ -73,5 +73,7 @@
 #define RST_BUS_DSP_CFG		63
 #define RST_BUS_DSP_DBG		64
 #define RST_BUS_RISCV_CFG	65
+#define RST_BUS_CAN0		66
+#define RST_BUS_CAN1		67
 
 #endif /* _DT_BINDINGS_RST_SUN20I_D1_CCU_H_ */
-- 
2.37.4

