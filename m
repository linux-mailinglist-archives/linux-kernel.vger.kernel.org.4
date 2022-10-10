Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7235F9EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbiJJM1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiJJM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:27:28 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1C85F225;
        Mon, 10 Oct 2022 05:27:27 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-12c8312131fso12281360fac.4;
        Mon, 10 Oct 2022 05:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XimozxtCM3OTFQP29kmIOvI38zdZ6QInZnUvN9y4CQ=;
        b=ooDAWRy+Ua7ow2fbN4i30Z1+WcLRwoRzamViqj9UO0W8OTey/VcVtc9snMREQ2vef2
         TiE6AwXWDn5oSx4hnBORfQPYwqwiKUtq2kr1F+dyOvD5/d/czWH0nYMUlCMoCpJuh48t
         c0j6jWOO4wa7l1l/5r6QVhSsDcH9lCKSml/eo1Ob1DZHUDUiR1U2zM1G9zUtwdm8uIAh
         dFgay5jUEDhB0T+iO2yFp3JRtsTgki0uWTGRoUySiRAhaeuV2U3T4dgW1GJ1ChpYNQja
         Y0cHwNOErTXiCDiZRu7BFdqJLGTTH/aaKPfWva2aBl76MuIx6lDRAD5UR0oN2/0MIoAK
         hfQg==
X-Gm-Message-State: ACrzQf23C4rzhGcAGi2/a/PZ0SOZNXLFluNbtg3kbDlDao/oEINwRkfO
        YspaqrKlyZnvXpvvDdTqdA==
X-Google-Smtp-Source: AMsMyM4Wraf8Vgk7cNKGKpmIo2CmacT/qVRhLbZIlf30aykw5iXbY/fXUC23XjS4RuVb6w1V6WP4Ow==
X-Received: by 2002:a05:6870:9a05:b0:132:ebf:dc61 with SMTP id fo5-20020a0568709a0500b001320ebfdc61mr9506149oab.76.1665404846584;
        Mon, 10 Oct 2022 05:27:26 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q13-20020a9d654d000000b0066193fe498bsm2043389otl.28.2022.10.10.05.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:27:26 -0700 (PDT)
Received: (nullmailer pid 442613 invoked by uid 1000);
        Mon, 10 Oct 2022 12:27:27 -0000
Date:   Mon, 10 Oct 2022 07:27:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: apple,aic: Document A7-A11
 compatibles
Message-ID: <20221010122727.GA432201-robh@kernel.org>
References: <20221007200022.22844-1-konrad.dybcio@somainline.org>
 <20221007200022.22844-2-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007200022.22844-2-konrad.dybcio@somainline.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:00:21PM +0200, Konrad Dybcio wrote:
> Document the compatibles for Apple A7-A11 SoCs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
> Changes since v3:
> - Bindings: A7-A10+M1 only get SoC compat and generic fallback,
> A11 gets M1 fallback and generic fallback (removed A11 compatible)

I have no idea if that makes sense or not. Do I have to go read the 
rationale in the prior version?

The question to ask on fallbacks, is would s/w that only understands the 
fallback compatible work as-is?

> - Drop Rob's A-b as this is essentially yet another rewrite..
> 
>  .../bindings/interrupt-controller/apple,aic.yaml | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> index e18107eafe7c..1427ea9b04a2 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
> @@ -36,9 +36,19 @@ allOf:
>  
>  properties:
>    compatible:
> -    items:
> -      - const: apple,t8103-aic
> -      - const: apple,aic
> +    oneOf:
> +      - items:
> +          - enum:
> +              - apple,s5l8960x-aic
> +              - apple,s8000-aic
> +              - apple,t7000-aic
> +              - apple,t8010-aic
> +              - apple,t8103-aic
> +          - const: apple,aic
> +      - items:
> +          - const: apple,t8015-aic
> +          - const: apple,t8103-aic
> +          - const: apple,aic
>  
>    interrupt-controller: true
>  
> -- 
> 2.37.3
> 
> 
