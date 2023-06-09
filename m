Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2D772A664
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbjFIWys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFIWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:54:46 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C13199D;
        Fri,  9 Jun 2023 15:54:45 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-777b4c9e341so102106639f.0;
        Fri, 09 Jun 2023 15:54:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686351285; x=1688943285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pT8d709lUwR0H+C5hIKfiTzNt8kqiCGgM0Vbs93RSBI=;
        b=iVfnN24Gzrxa6cN2tsyP05ZbU5QbFBw0n0K6+9cCza2GZf2GG0QafUPAqajiP3SQA5
         GVoByI+4Qjd7U9WnbnCGqYP5nmx9DjWGiS+b6KeRXyti0wVSC12Ms5B+FHpnHhfdvm7p
         8IX7S+phQ6ukr4Zuao9Rm1VIzo8Ro+QYvMGpx3hpvl7wb/q4NI8jbiwNA2k1eJxE4HvG
         FPn1BRn9WYqesWEOPBFJCXsIqlErOTWYDa6lP9rTKrPRP6kegO2x67SBYnaUMUBifHmw
         uhkBVdHOIkOVXBe4k7FIa0YLWzVRdZ49h3dOKkWFLBJpzU/icKIUS0UySbj9H6V4R7NA
         78NA==
X-Gm-Message-State: AC+VfDwinI1aD2AA1cSKelwH9K7Hs3UIdbBG3Mf0eAh83u0xh/5niVT2
        PajPRynLwK3C0Xqbf+rXPA==
X-Google-Smtp-Source: ACHHUZ4hkrjWTx1JroAsVMcvyH4QcGLOHYyPwn37uUR6Q/8eLHeqERimu9M7VUet3JdIarbD7Tic1A==
X-Received: by 2002:a5e:c017:0:b0:778:735c:9bed with SMTP id u23-20020a5ec017000000b00778735c9bedmr2869964iol.0.1686351284694;
        Fri, 09 Jun 2023 15:54:44 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p22-20020a02b396000000b00420af1d2ce0sm1241761jan.5.2023.06.09.15.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:54:43 -0700 (PDT)
Received: (nullmailer pid 2601357 invoked by uid 1000);
        Fri, 09 Jun 2023 22:54:42 -0000
Date:   Fri, 9 Jun 2023 16:54:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: intel,ixp4xx: drop unneeded quotes
Message-ID: <20230609225442.GA2588193-robh@kernel.org>
References: <20230609140745.65046-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140745.65046-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 04:07:45PM +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/crypto/intel,ixp4xx-crypto.yaml         | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

You missed $id and $schema values.

Within drivers/crypto, there's also:

diff --git a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml b/Documentation/devicetree/bi
ndings/crypto/amlogic,gxl-crypto.yaml
index ecf98a9e72b2..948e11ebe4ee 100644
--- a/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/amlogic,gxl-crypto.yaml
@@ -19,8 +19,8 @@ properties:
 
   interrupts:
     items:
-      - description: "Interrupt for flow 0"
-      - description: "Interrupt for flow 1"
+      - description: Interrupt for flow 0
+      - description: Interrupt for flow 1
 
   clocks:
     maxItems: 1

Can you add this in here. No reason to split this up more that 1 patch 
per subsystem really. 

As I mentioned, I have a WIP tree[1] with yamllint checks enabled and 
I scripted many of the changes. It was clean, but there's some new ones 
since rebasing to v6.4-rc1:

../Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml:30:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml:31:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml:42:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/hwmon/starfive,jh71x0-temp.yaml:43:16: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:38:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:39:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:40:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:41:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:42:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max9808x.yaml:43:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml:34:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml:35:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml:36:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5631.yaml:37:11: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml:65:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml:74:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml:83:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml:93:15: [error] string value is redundantly quoted with any quotes (quoted-strings)
../Documentation/devicetree/bindings/sound/cirrus,cs35l45.yaml:117:15: [error] string value is redundantly quoted with any quotes (quoted-strings)

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=dt/yamllint
