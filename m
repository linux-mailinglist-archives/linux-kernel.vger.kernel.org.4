Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B456F203F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346568AbjD1VqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346497AbjD1VqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:46:10 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCA926BA;
        Fri, 28 Apr 2023 14:46:09 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6a8955b3462so192553a34.2;
        Fri, 28 Apr 2023 14:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718369; x=1685310369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTM2mluHD/ZVuQ06t+XTsEI3ZhySwZO1SLbkiRH9asw=;
        b=j6aCp45ja1EdGzmZrGj5AN+i3DkJraEkfa+VKkqWwEFGsVdoKE93bJJci3hS1HfnBI
         Pl7gGGjObYvmqJ+yHC4q95PL9m/ayw8z0eV0JeJKT5jrN/XMJhtV6p+m4Y5G9uHnsdxh
         lm5mFPWRpu7Ht3XSsLYiUh7ozTK3XDYUbOkphDgHB/6OCPl4ToASzlAobIYAWzZ+HnhW
         ure0RR9xJl2frPnUA/f+UAPyii6s9NVekchqy4sTReKIG5vtsTPkUg0uiNQREL1u1kzf
         BH9ME1AG4O2qBRQPg/7iAXZChu676BLg4/b8NfKF8zijdPHgbmvYRz3bTHp771uIwrJG
         XRlQ==
X-Gm-Message-State: AC+VfDwGy636Az4wDOGlmAL/ggupNGdMLNmGcGW2IP3ZU4yhgmKmwjg/
        6qO24gc5MO3yfpNV1Xu8GQ==
X-Google-Smtp-Source: ACHHUZ7ILd+pYQIPWPAv2XKRDwq6NaoGnAux7/JTHMWijMavD87BT+jKgyaPYW41sX29xC4se2bTCg==
X-Received: by 2002:a05:6808:915:b0:38e:ada4:4512 with SMTP id w21-20020a056808091500b0038eada44512mr3056225oih.20.1682718368863;
        Fri, 28 Apr 2023 14:46:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 27-20020a4ae1bb000000b00541fbbbcd31sm7600624ooy.5.2023.04.28.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Apr 2023 14:46:08 -0700 (PDT)
Received: (nullmailer pid 332170 invoked by uid 1000);
        Fri, 28 Apr 2023 21:46:07 -0000
Date:   Fri, 28 Apr 2023 16:46:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Valentin Caron <valentin.caron@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: spi: stm32: add bindings regarding
 stm32h7 spi slave
Message-ID: <20230428214607.GA326858-robh@kernel.org>
References: <20230428121524.2125832-1-valentin.caron@foss.st.com>
 <20230428121524.2125832-5-valentin.caron@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428121524.2125832-5-valentin.caron@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 02:15:21PM +0200, Valentin Caron wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> Update the spi-stm32 binding yaml regarding to the SPI slave support.

Why? What problem are you trying to solve.

> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---
>  Documentation/devicetree/bindings/spi/st,stm32-spi.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> index c599eb359d56..1d26fa2658c5 100644
> --- a/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/st,stm32-spi.yaml
> @@ -27,6 +27,7 @@ allOf:
>      then:
>        properties:
>          st,spi-midi-ns: false
> +        spi-slave: false
>  
>  properties:
>    "#address-cells": true
> @@ -62,6 +63,13 @@ properties:
>        - const: rx
>        - const: tx
>  
> +  cs-gpios:
> +    description:
> +      In case of spi-slave not defined, cs-gpios behave as defined in
> +      spi-controller.yaml.
> +      In case of spi-slave defined, if <0>, indicate that SS should be
> +      detected via the dedicated HW pin

I don't understand. I though cs-gpios was for master mode. You want to 
define 'cs-gpios = <0>;'? How would that be different than just omitting 
cs-gpios?

Rob
