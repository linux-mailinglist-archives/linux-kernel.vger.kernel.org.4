Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA769109A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBISr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBISr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:47:28 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48052166D5;
        Thu,  9 Feb 2023 10:47:27 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-16a7f5b6882so3726704fac.10;
        Thu, 09 Feb 2023 10:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNaA54ncyf5PWWN1fTCkDz/pbo/DWHHSJveDPsBxHU4=;
        b=RC5fDeLU4vuqW2lgOkZmG/ERSu/X56JhgOTDiJ33opR0qE6xsGWUSPAUbAI2+pN68J
         BF+Or19LaJNlJtubikdVvwliG7A/L8GtfNeXunbOSL5d9MI1WdDapVqM1Df8PJKJtYED
         e5n00a21wtPj5ZUaNl+1ruFP9svmvkggSpLlRGfTV5/MRsuLrn4YrTi044viEqhcNOlk
         DHjCl/7UUU77jSz9tKqQ7Dr7a35LBhUHo6uVEnzuRw2b7cTjsK9z71ZORNJpkSvhwXrP
         datW8n/N9EBpA+WBNSu0H8F2Bu/XWSYaN51laHBiHtB4Azs7LJZs5212/XVDavxkHUBD
         r0eA==
X-Gm-Message-State: AO0yUKXyEZfLNf0khnz3kTgc6ygOApyXTa9GK/wH78mz/znZy/lJKxVs
        V+CoHgBpS+29/G3HU+RHNw==
X-Google-Smtp-Source: AK7set+LpAAQrdDi21BmP35c4QuiXWbAckRokthyKVqKkwsAlsFerd9xp/Vfd28aqzRs2F+J01ZqkQ==
X-Received: by 2002:a05:6870:428f:b0:163:3f73:b0fc with SMTP id y15-20020a056870428f00b001633f73b0fcmr6970166oah.18.1675968446460;
        Thu, 09 Feb 2023 10:47:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u36-20020a056870b0e400b0014ff15936casm1008335oag.40.2023.02.09.10.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 10:47:26 -0800 (PST)
Received: (nullmailer pid 622962 invoked by uid 1000);
        Thu, 09 Feb 2023 18:47:25 -0000
Date:   Thu, 9 Feb 2023 12:47:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, - <patches@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Message-ID: <167596844504.622906.11149464288778013778.robh@kernel.org>
References: <20230208195235.453774-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208195235.453774-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Feb 2023 20:52:35 +0100, Krzysztof Kozlowski wrote:
> Convert the Wolfson WM1811/WM8994/WM8958 audio codecs bindings to DT
> schema.
> 
> Changes against original binding:
> 1. Add missing LDO1VDD-supply and LDO2VDD-supply.
> 2. Use "gpios" suffix for wlf,ldo1ena and wlf,ldo2ena (Linux kernel's
>    gpiolib already looks for both variants).
> 3. Do not require AVDD1-supply and DCVDD-supply, because at least on
>    Arndale board with Exynos5250 these are being supplied by internal
>    LDOs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Add LDO2VDD-supply.
> 2. Do not require AVDD1-supply on WM8994.
> 3. Move requiring of common supplies to top-level "required:".
> 
> DTS is being corrected here:
> https://lore.kernel.org/linux-samsung-soc/20230208172634.404452-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  .../devicetree/bindings/sound/wlf,wm8994.yaml | 194 ++++++++++++++++++
>  .../devicetree/bindings/sound/wm8994.txt      | 112 ----------
>  2 files changed, 194 insertions(+), 112 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8994.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8994.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

