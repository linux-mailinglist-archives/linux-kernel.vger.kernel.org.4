Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BDD65A758
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiLaWCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiLaWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:01:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A4964C2;
        Sat, 31 Dec 2022 14:01:53 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D9B355C007F;
        Sat, 31 Dec 2022 17:01:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 31 Dec 2022 17:01:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672524110; x=1672610510; bh=YD
        1dCkE7VO7jGYHFV07b3XoPDh4wUwU4Z7xaUFzeNeU=; b=aqrB7VAWbjJJvLqgKn
        L3f92W1zxrXMwyrcy1mjHTF1Je352X9rxEeZMDLBmK42qOGSSH8hWKenyrsrC5Eb
        T3yZayisJBAKP3H4iTWSFvOCyOoGIJMu8oZXwxeafELygWwIMM7osWnP0gCxae4W
        T4jUjvodpZSGmyOexh+KfiRvaz2wmr8krVZoznMU0bCHlkrb+sPYFuaA1GE7PvlJ
        91kGgl2yvZaqmhHsDghMSxPMP4T1EHD593yqsFgjRqY2AMHA9wmw7vcrc9zCbHm6
        jo2g/DeFznGpFGZK55kOXn8pprPsX4qEg7yi2RppoFpsUxDlRwkaDY0sFN+EhDo5
        ogcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672524110; x=1672610510; bh=YD1dCkE7VO7jG
        YHFV07b3XoPDh4wUwU4Z7xaUFzeNeU=; b=b8gJn1LGOHujgdAyncX5kI8yWh0x1
        S9NRtqRTDHj1IpijzpiohRas4bXySk0eTtxX4TDOCtRAO2OwPOHRHstWLugLwAR4
        P/+WoM3VCxLfr0BQQubry+c8/apjF93Gcw5fo03z2pRQzNzkkGuzw51QC6/A+69p
        QNBmHSbSvMsD2vYyZx5u6XoYLPwCjNAHfO9LsxPuA8IieEU5Ei2UI5rRIZGs6dkj
        WF7D/7Lc1BIQXr5qrfdMpK+lhbuevqn6X5mel2OhF2IaxomZHHOlnG1dycdA3yLI
        c0V9iDtips2fyuP4dfRJs3CarrK1WjOdiKQrNB7Ec14cBIA5j32J0qC0A==
X-ME-Sender: <xms:TrGwYxNQhTwq17POsIWNlUNKvGVSUt5wufEiFhKnqRiSFEymDKk5xw>
    <xme:TrGwYz9GLh6ZOm49caoAVsJgFdSP90x9hTsXQErbkJAemtu8wDB4DFpOjnDN3xtxY
    BnKwmOKpxot_3C9ow>
X-ME-Received: <xmr:TrGwYwTbRMhSUVtxWerzHY4qaIF0APaZA69sSPZTNo8L75wwPy6b3-mzGBp28XQdSqdT9u4wnLLVmv5luiozCqEJIUddBpvhG5vnYqlLF8BHLHR12S8o4rsuZdMRq09oDsQv7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:TrGwY9tEqsZKy2vYV1CHC_s3N8h0sby26R9jMXngPJ7jjQoUl0DZ-A>
    <xmx:TrGwY5fXgzD3svpI0neyE9ZGvqMu_uUfP6M1_VCR4rA3nTy6nFEpwg>
    <xmx:TrGwY50R700_3PQlxptAPCheyjaLexEGpN5KUyae8izDOS5dotzvAg>
    <xmx:TrGwY0t877uvRH0-8T7BqfPdK0sGswPSFOJvDyF1MRwfClybxI5tyQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 17:01:49 -0500 (EST)
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
Subject: [PATCH v2 1/3] dt-bindings: crypto: sun8i-ce: Add compatible for D1
Date:   Sat, 31 Dec 2022 16:01:43 -0600
Message-Id: <20221231220146.646-2-samuel@sholland.org>
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

D1 has a crypto engine similar to the one in other Allwinner SoCs.
Like H6, it has a separate MBUS clock gate.

It also requires the internal RC oscillator to be enabled for the TRNG
to return data, presumably because noise from the oscillator is used as
an entropy source. This is likely the case for earlier variants as well,
but it really only matters for H616 and newer SoCs, as H6 provides no
way to disable the internal oscillator.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
I noticed that the vendor driver has code to explicitly enable IOSC when
using the TRNG on A83T (search SS_TRNG_OSC_ADDR), but that is covered by
a different binding/driver in mainline.

Changes in v2:
 - Add TRNG clock

 .../bindings/crypto/allwinner,sun8i-ce.yaml   | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
index 026a9f9e1aeb..4287678aa79f 100644
--- a/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
+++ b/Documentation/devicetree/bindings/crypto/allwinner,sun8i-ce.yaml
@@ -14,6 +14,7 @@ properties:
     enum:
       - allwinner,sun8i-h3-crypto
       - allwinner,sun8i-r40-crypto
+      - allwinner,sun20i-d1-crypto
       - allwinner,sun50i-a64-crypto
       - allwinner,sun50i-h5-crypto
       - allwinner,sun50i-h6-crypto
@@ -29,6 +30,7 @@ properties:
       - description: Bus clock
       - description: Module clock
       - description: MBus clock
+      - description: TRNG clock (RC oscillator)
     minItems: 2
 
   clock-names:
@@ -36,6 +38,7 @@ properties:
       - const: bus
       - const: mod
       - const: ram
+      - const: trng
     minItems: 2
 
   resets:
@@ -44,19 +47,33 @@ properties:
 if:
   properties:
     compatible:
-      const: allwinner,sun50i-h6-crypto
+      enum:
+        - allwinner,sun20i-d1-crypto
 then:
   properties:
     clocks:
-      minItems: 3
+      minItems: 4
     clock-names:
-      minItems: 3
+      minItems: 4
 else:
-  properties:
-    clocks:
-      maxItems: 2
-    clock-names:
-      maxItems: 2
+  if:
+    properties:
+      compatible:
+        const: allwinner,sun50i-h6-crypto
+  then:
+    properties:
+      clocks:
+        minItems: 3
+        maxItems: 3
+      clock-names:
+        minItems: 3
+        maxItems: 3
+  else:
+    properties:
+      clocks:
+        maxItems: 2
+      clock-names:
+        maxItems: 2
 
 required:
   - compatible
-- 
2.37.4

