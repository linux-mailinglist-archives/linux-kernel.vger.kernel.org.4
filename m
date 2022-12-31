Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38165A5CD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiLaQqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiLaQqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:46:35 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795842CB;
        Sat, 31 Dec 2022 08:46:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E78D55C00C9;
        Sat, 31 Dec 2022 11:46:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 31 Dec 2022 11:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672505193; x=1672591593; bh=UI
        LhNGgAzXEExQUtc1nNgyH89N42rlAHuhv77zefq20=; b=wxutMGFlw5JuLTULHY
        ICfG5YZe8MGmJd13HbOs49Rwr1BTJMYmTJF7RanCKX5v/pIkIolcu+XB0QPs1t0p
        aF1VCBdvM5FTYjuOr32gnnPH6li9riPD1+THcukilntiAQM5f8Lr1V0asrRbTZuX
        ebwljvg691LN4J1kTgjOnbCXV1NQKfkd92CxbDamvNCeUlwEmAdtzD2N6zKInssO
        zZsFCInQpe9DcmlIqrTgNkWTPvyhDM7vCdXwvAGRXvBBLriK/BOTb+UqDASfw4Sx
        t8OwQAxuKX6DgWip+gW/dAQ7cNeHxVrfpQW4AJYAz6v2WSPCe/SpXivmILbW5q/H
        K2KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672505193; x=1672591593; bh=UILhNGgAzXEEx
        QUtc1nNgyH89N42rlAHuhv77zefq20=; b=W2R7B7UuVmY4PqOUJ+Pl+jCR/n30I
        VMu3xI5IzfzIP6Lrql/4T/GS/1dlwjRt94y+iiHvd4lcQwmvbxQpSkBxUp031GmL
        /IKlHLiSH0FzMOhe0/7UEVELnuabns1r3GcAqNE6nNlI7Hx9SxAIoi4yxeXbX255
        frFsMCHFdpXim881nK1biCZ1t3+rG7KtP2bAR20b+jZS0zmTUEF6YgE2eXtey12x
        c43W9rNxo3KgHruxdCOekj4cZ4LKsYriH58CU3YQIBtGhNpoiTfB6qVcmQBKQy8j
        izezOOA7eQxXFQrrecJONMccXkb/YqLk95Eyl8p3KeqCnhoqkCWMXPAjA==
X-ME-Sender: <xms:aWewYwmnzfLZgQzcm3nf__685uZkbcKHVWv_anSvtZJzwLzUGdn2XQ>
    <xme:aWewY_1Q5Dc31wrZg7_KgDv9iTJWJkjkIGgzroXCl-TKOpfVqF-mDRAFNia7O45l8
    xNEsUZBUaBwsAmg6w>
X-ME-Received: <xmr:aWewY-ohlvMzAoDd_F8B7RyDXya3X5II5SGadfvb3PQL_62ouHdj99VDXX_Qv5DkRHTGNx3FUiLgN4f6x1IdIKfZTRbi90IP2vHV0sqeokFUhrjt1GHGbzZoVV-VHyYydqbivg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:aWewY8kYAA4LnC0T8wuzl6f9IgSvnl4T3d1e8hmiNx1tmxB5_XSiiA>
    <xmx:aWewY-3n3m_muuWkRR1FDc0Yqyaa45FxoB1Usrxu74aWcDsNfRW_Ug>
    <xmx:aWewYztKqru5VnxSO6czmIVMtDtyUnPGX5vd6PiXAtdFBAZCesJ-Iw>
    <xmx:aWewY1uVhnRUWthpZvDARZ3F6H_BxiJh74M-E_-FvdTWnMhKDjAnQg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:46:32 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 2/4] media: dt-bindings: cedrus: Make allwinner,sram optional
Date:   Sat, 31 Dec 2022 10:46:25 -0600
Message-Id: <20221231164628.19688-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231164628.19688-1-samuel@sholland.org>
References: <20221231164628.19688-1-samuel@sholland.org>
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

Allwinner SoCs can remap some bits of peripheral SRAM to a contiguous
range of addresses for use by early boot software. Usually the video
engine's SRAM is used for this purpose, so its mapping must be switched
back before the hardware can be used.

However, the D1 and related SoCs use the DSP SRAM for this purpose. As a
result, the video engine SRAM is not switchable, and there is no need
for an allwinner,sram reference in the devicetree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../bindings/media/allwinner,sun4i-a10-video-engine.yaml         | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
index d5be7f604e8c..74363b242fff 100644
--- a/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
+++ b/Documentation/devicetree/bindings/media/allwinner,sun4i-a10-video-engine.yaml
@@ -73,7 +73,6 @@ required:
   - clocks
   - clock-names
   - resets
-  - allwinner,sram
 
 additionalProperties: false
 
-- 
2.37.4

