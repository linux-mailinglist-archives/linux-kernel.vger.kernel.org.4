Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA15C688B4B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjBCACZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjBCACN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:02:13 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D986615;
        Thu,  2 Feb 2023 16:01:32 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-16332831ed0so4745889fac.10;
        Thu, 02 Feb 2023 16:01:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzCNlKDHqyGavA9ZfvqMT//V/aBYx/XujrMdimkMJgw=;
        b=13KBZzkqpHcDf3+iBbnjxm6mniN+eLuricfPYDJlfjUxY/yOdkIqlySepxNb0x2Ywu
         Nc4w0o/vFJwrq5YEV9holEG94ILQ/h+9U5K5qSgnB1NXR2e8d9/NV2/Ax3Cfz7ksiBE/
         Ju7yDh4gbZJsK6YwPTlrxmMrfb7APpdvJolMX+Jlf/hjSNL4KgOBZe1JvFgUhZr+3D4E
         7OwTS3ecmxukZnCj22Y+erdyA9vg/ouyEWluweCEMh56BXOxtFFfpD4+6ep+xkKKNidD
         yinw8VBbHtqFmuGVvU00W0bWZ8oCziM8ANZ+co86DwoAGHHHVzIi8JQrXY8wHGxrFbi8
         wtqA==
X-Gm-Message-State: AO0yUKVFxQd6KKpj5gOA13V81jcfwaaPAvPhwyBg7YsTbDq0aqDyZ9qq
        JTwFmTY5zmbXM9HF8ucSng==
X-Google-Smtp-Source: AK7set9Vevd3I7OG7VcsGrL40svPIpgtKAFa3g7Lynam2B2jnkIcsZQDOMXxctq3yTo16ubt9Ymkxg==
X-Received: by 2002:a05:6870:f28a:b0:15d:fe1e:2741 with SMTP id u10-20020a056870f28a00b0015dfe1e2741mr1607957oap.4.1675382492142;
        Thu, 02 Feb 2023 16:01:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv18-20020a056870d89200b001639d2bc9desm368338oab.9.2023.02.02.16.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:01:31 -0800 (PST)
Received: (nullmailer pid 2935258 invoked by uid 1000);
        Fri, 03 Feb 2023 00:01:30 -0000
Date:   Thu, 2 Feb 2023 18:01:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Vinod Koul <vkoul@kernel.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, Iskren Chernev <me@iskren.info>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dt-bindings: pinctrl: qcom,msm8909: correct
 GPIO name pattern and example
Message-ID: <20230203000130.GA2934311-robh@kernel.org>
References: <20230202104452.299048-1-krzysztof.kozlowski@linaro.org>
 <20230202104452.299048-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202104452.299048-3-krzysztof.kozlowski@linaro.org>
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

On Thu, Feb 02, 2023 at 11:44:44AM +0100, Krzysztof Kozlowski wrote:
> The MSM8909 TLMM pin controller has GPIOs 0-112, so narrow the pattern
> and gpio-ranges in the example.
> 
> Fixes: c249ec7ba1b1 ("dt-bindings: pinctrl: Add DT schema for qcom,msm8909-tlmm")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>  .../devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index 449e6e34be61..85082adc1811 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -63,7 +63,7 @@ $defs:
>            subnode.
>          items:
>            oneOf:
> -            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-7])$"
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-2])$"
>              - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
>                        sdc2_data, qdsd_clk, qdsd_cmd, qdsd_data0, qdsd_data1,
>                        qdsd_data2, qdsd_data3 ]
> @@ -127,7 +127,7 @@ examples:
>          interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>          gpio-controller;
>          #gpio-cells = <2>;
> -        gpio-ranges = <&tlmm 0 0 117>;
> +        gpio-ranges = <&tlmm 0 0 113>;

I thought 112 was the max?

>          interrupt-controller;
>          #interrupt-cells = <2>;
>  
> -- 
> 2.34.1
> 
