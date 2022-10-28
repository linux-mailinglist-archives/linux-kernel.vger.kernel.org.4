Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA9610E95
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiJ1Keo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJ1Keg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:34:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C42AE78;
        Fri, 28 Oct 2022 03:34:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so6050367wrq.3;
        Fri, 28 Oct 2022 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iza2TaCkyzr/G3RQNexbZUSAsDCgwwO2VTwP3e6lVI8=;
        b=nW7fKiq0XchkjTwPif5/83pUEVQb8//GqUC5uhhUirUS6EJZuSMdXSHs6nLBgLTQaH
         RP+PV2sgBThhpc6tpxzcCKQDMB1ZWkJZWE7Yty8YssrnqRAcnAN8HMP7xGycQLjNhCVf
         Ii7EpJkfEE6yRF+jRooqGofJQ5AtBTSTL2Jg4RuipYp313d7aOp+Urtv0Wzzc5sNgVXn
         RZ+aF+vagSFcIDQEoGudviHGjkMTRfdxhJebL6KGym/eube2RhT+KuCqWlNO5rvm9q8S
         8ZA7lvHm3ny9+M75y0T++kY9JeGTEh7Pbtoy/f390PL2DHxJTLL4owiGBWD9UjIeOSJ2
         ryVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iza2TaCkyzr/G3RQNexbZUSAsDCgwwO2VTwP3e6lVI8=;
        b=noaecvtjlW/+DMv0MsiOfsyam45qvVFn48kpoHMHurZ5q+7fnnrbPh6fWT1O1yv2Ur
         zGiFA98kblzX06tuH16VgtBgqhWzquiKIzaSweRSniK0y0+/s0/bXsMVvS+Esluq4WS9
         2LMH5Ie/lfyKZsBgFRiQUQWKFeok8fEtinZklW1C40FxAxAs8UNTEV71X8fv+BJWe3EB
         5VT2tIFTb4H/a6YQTNK1p4kNMvl2GydRDqcjaU51KCtnRhVnCAMsIZtzkz4gbX/pS+PW
         KfBKTrs7PdWgsdLzI45NWQ2pcqi7SI1amVyi1P71IJY89+TEVbdxhsYHIdx8xI9OYrRZ
         PQCw==
X-Gm-Message-State: ACrzQf0DDMGHN20qXPH6edCXaYAUZIUFUo8OJpLM339zxRm++I9RAJvC
        wF8+zWJA5dIrElm8txRVvJQ=
X-Google-Smtp-Source: AMsMyM425b/N+g0Scv97lzZADj+stoYPE2Y6WXtnG+yIdY7m3olUmFU1QKZn1pPXOVtl9M455zj45w==
X-Received: by 2002:a05:6000:144f:b0:231:2053:ef7c with SMTP id v15-20020a056000144f00b002312053ef7cmr34870075wrx.179.1666953266605;
        Fri, 28 Oct 2022 03:34:26 -0700 (PDT)
Received: from localhost (94.197.40.204.threembb.co.uk. [94.197.40.204])
        by smtp.gmail.com with ESMTPSA id e8-20020adffd08000000b0022e653f5abbsm3300645wrr.69.2022.10.28.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 03:34:26 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tsbogend@alpha.franken.de, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] dt-bindings: ingenic,aic: Remove unnecessary clocks from schema
Date:   Fri, 28 Oct 2022 11:34:16 +0100
Message-Id: <20221028103418.17578-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
References: <20221028103418.17578-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AIC needs only the first two clocks: "aic" is a gate that's used
for gating the I2S controller when it's suspended, and "i2s" is the
system clock, from which the bit and frame clocks are derived. Both
clocks are therefore reasonably part of the AIC and should be passed
to the OS.

But the "ext" and "pll half" clocks are a little more questionable.
It appears these bindings were introduced when the schema was first
converted to YAML, but weren't present in the original .txt binding.
They are intended to be the possible parent clocks of "i2s".

The JZ4770 actually has three parents for its "i2s" clock, named
"ext", "pll0", and "pll1" in the Linux driver. The JZ4780 has two
parents but it doesn't have a "pll half" clock, instead it has an
"i2s_pll" clock which behaves much differently to the actual
"pll half" clock found on the JZ4740 & JZ4760. And there are other
Ingenic SoCs that share the JZ4780's clock layout, eg, the X1000.

Therefore, the bindings aren't really adequate for the JZ4770 and
a bit misleading for the JZ4780. Either we should fix the bindings,
or remove them entirely.

This patch opts to remove the bindings. There is a good case to be
made that "ext" and "pll half" don't belong here because they aren't
directly used by the AIC. They are only used to set the parent of
the "i2s" clock; they have no other effect on the AIC.

A good way to think of it is in terms of how the AIC constrains
clocks. The AIC can only generate the bit & frame clocks from the
system clock in certain ratios. Setting the sample rate effectively
constrains the frame clock, which, because of the clock dividers
controlled by the AIC, translates to constraints on the "i2s" clock.
Nothing in the AIC imposes a direct constraint on the parents of
the "i2s" clock, and the AIC does not need to enable or disable
the parents directly, so in principle the AIC doesn't need to be
aware of the parent clocks at all.

The choice of parent clock is still important, but the AIC doesn't
have enough information to apply such constraints itself. The sound
card does have that information because it knows how the AIC is
connected to other components. We need to use other DT mechanisms
to communicate those constraints at the sound card level, instead
of passing the clocks through to the AIC, and inventing ad-hoc ways
to plumb the constraints around behind the scenes.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 .../devicetree/bindings/sound/ingenic,aic.yaml         | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
index d607325f2f15..c4f9b3c2bde5 100644
--- a/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
+++ b/Documentation/devicetree/bindings/sound/ingenic,aic.yaml
@@ -37,15 +37,11 @@ properties:
     items:
       - description: AIC clock
       - description: I2S clock
-      - description: EXT clock
-      - description: PLL/2 clock
 
   clock-names:
     items:
       - const: aic
       - const: i2s
-      - const: ext
-      - const: pll half
 
   dmas:
     items:
@@ -82,10 +78,8 @@ examples:
       interrupts = <18>;
 
       clocks = <&cgu JZ4740_CLK_AIC>,
-               <&cgu JZ4740_CLK_I2S>,
-               <&cgu JZ4740_CLK_EXT>,
-               <&cgu JZ4740_CLK_PLL_HALF>;
-      clock-names = "aic", "i2s", "ext", "pll half";
+               <&cgu JZ4740_CLK_I2S>;
+      clock-names = "aic", "i2s";
 
       dmas = <&dmac 25 0xffffffff>, <&dmac 24 0xffffffff>;
       dma-names = "rx", "tx";
-- 
2.38.1

