Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A390765A753
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiLaWCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiLaWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:01:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C7264C6;
        Sat, 31 Dec 2022 14:01:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 20D4F5C00AF;
        Sat, 31 Dec 2022 17:01:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 17:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672524112; x=1672610512; bh=Of
        0xMXPiylA4jEfEw42JIYQDYz/9F74OJjr6iVQvau4=; b=ZtVwNinm/RpM0BF/8n
        PJsJKk0KygymBCIAtE3iFPJgywtNXNjJHhXRmg2JPeUpEQUlHn2MGHyOYURQdEDz
        qC7f20sSNOczGEi0szqVyko9sKEw8IXB7Da5HSJC2iCvBdbZzm2qobf/y8QM8Dge
        8EVfYoqn28YJ8HkEtuIKvaPX7TXQBHcf9E+uY67NZk/4Dv4y3g5H+v0BKh8CyWJf
        uDAwFpO+XTi+5rpxtoSv5ka7qg0VESI5FqLH/ljKqtdrtiQ0Dv/k2hPVRfQOUrD+
        747ghfg/q89gUP5a0xKVxVjqL/CEdgd59goHus+aH7G8U6W2xhIDYoeq/+O3+h2T
        MBDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672524112; x=1672610512; bh=Of0xMXPiylA4j
        EfEw42JIYQDYz/9F74OJjr6iVQvau4=; b=OwHK5qO2/4aDZGB5DGZ/hUW7iIeNu
        RtZV5v/8WuTM+DRux4vF1WzAs2Lsg2+dqHQXo3Egd8vlSicV6k8xE5dTTveBecY/
        xAfGfWvG02dPvxhZ5+B5l59J+Cs7waj4GCYAFlvTAwekKnumOGd3b2Whn7EiOtNN
        64HXNlvklQ+vvBr6QiPiGIPJUjeahO1G2wenG2JBhvkyfROXKWdyf/NG2HfWgHoE
        KbLfubEzbHYBINk7cDcU9n8Qe2jy2n/nahB19neL5c+gmvf9XCVb6hamqjvimtm8
        QuHvWcIP0P9ABaiQ46tumgR3jeYEG8zSZj5He7vLdyyZXN17mOCHgnq+g==
X-ME-Sender: <xms:T7GwYzB1Rg8xL_sl_VbihINQ2TubtreQHmZ8My0MBoscDJUgZEcU0A>
    <xme:T7GwY5ghf74rrxuSMHU7XqTTrWoYp_6PJbFUvt02MQNRzyFXWmwZ0SMc0UzvN6qHs
    oRXGHS8IzSLTZE-eQ>
X-ME-Received: <xmr:T7GwY-k10BMt7a-shmDDSnQvIyb4HVD5dCqbKcfvg3IfPR-PYWw84pIFJgWM9tKoU06AQ-ZybdQun4ZfKoFAcyjceuveQN7V8vGbvTpOQSwo6svZwfHQE3b900WScr4K2gRKqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:ULGwY1y2xYVyqhRfrpWaB8QXB6YMR0XVv2daCa8Um0xl2Tk6FnPb7A>
    <xmx:ULGwY4QRGbj-wZhVYzaONRqkcdTwzMCV9QNZVdkl8HqbkJjCwva8kw>
    <xmx:ULGwY4ap_waPZDn8ytvxG5Mf8NJIhA7tvAqy-E-VdH1apWdfFpkR7A>
    <xmx:ULGwYxAamVEpoRXdVh6rpqbWNtg5Q8tQQD2DRrTCxwq0leGQQh7khg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 17:01:51 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] crypto: sun8i-ce - Add TRNG clock to the D1 variant
Date:   Sat, 31 Dec 2022 16:01:44 -0600
Message-Id: <20221231220146.646-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231220146.646-1-samuel@sholland.org>
References: <20221231220146.646-1-samuel@sholland.org>
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

At least the D1 variant requires a separate clock for the TRNG.
Without this clock enabled, reading from /dev/hwrng reports:

   sun8i-ce 3040000.crypto: DMA timeout for TRNG (tm=96) on flow 3

Experimentation shows that the necessary clock is the SoC's internal
RC oscillator. This makes sense, as noise from the oscillator can be
used as a source of entropy.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - New patch for v2

 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 1 +
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 9f6594699835..a6865ff4d400 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -118,6 +118,7 @@ static const struct ce_variant ce_d1_variant = {
 		{ "bus", 0, 200000000 },
 		{ "mod", 300000000, 0 },
 		{ "ram", 0, 400000000 },
+		{ "trng", 0, 0 },
 		},
 	.esr = ESR_D1,
 	.prng = CE_ALG_PRNG,
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 8177aaba4434..27029fb77e29 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -105,7 +105,7 @@
 
 #define MAX_SG 8
 
-#define CE_MAX_CLOCKS 3
+#define CE_MAX_CLOCKS 4
 
 #define MAXFLOW 4
 
-- 
2.37.4

