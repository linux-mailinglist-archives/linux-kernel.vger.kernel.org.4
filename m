Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441C681F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjA3XDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjA3XDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:19 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A291EBF4;
        Mon, 30 Jan 2023 15:02:08 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id cm26-20020a056830651a00b00684e5c0108dso4984662otb.9;
        Mon, 30 Jan 2023 15:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0jawajjjnkHJhuPxje0z7yClNTVk1TmmqI/vlaXQok=;
        b=U2Qn948Ao/Mt86MHySdQ/fxxcKzAHWchLC7h5qkxnu+nSPaJmnIn4xgleBMhLrFokO
         nllGxGpc+jrr/6Pyd8MNxot+eW3DI2wuBniV2zHyp/yYEQZ/1/fBcxX+67YgFkl25U/J
         RXSruaxz3RpUMMRG26Cgjb0MSS5c9MYI9LpCYe84nG8jTom+/E4q/qc9DZoxfEUmuCYo
         LDfNE4OWNeECScsRQzEXcumlFNYeCFYhRVQjPR8yIVOfEAwxEGgtqN+2UcTa9PuRSVUu
         4XUrGLXR5Tza8JJVPDtMDGBAsgGjDJgJX8z7Loeyb2e6jWtOuWo9572Ko0imwcsC+Qjb
         6rEQ==
X-Gm-Message-State: AO0yUKW2mLLI1jIZyUSfnG96WTvxtvqb7d/OQv4cMRoZ9zYZ8JqgRFH1
        U9pwLRy63mMLQ+CQYcsaVA==
X-Google-Smtp-Source: AK7set+cGK349DCIxfF5DN7FHzgOx7N3weMrrqfscIdhVvAiLXRQTYTQG/ji0kRn8hdlBqB08TxjTQ==
X-Received: by 2002:a9d:4c98:0:b0:68b:df2f:cefd with SMTP id m24-20020a9d4c98000000b0068bdf2fcefdmr554512otf.1.1675119565376;
        Mon, 30 Jan 2023 14:59:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q18-20020a4a88d2000000b004f227a05684sm3452850ooh.34.2023.01.30.14.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:59:25 -0800 (PST)
Received: (nullmailer pid 3682930 invoked by uid 1000);
        Mon, 30 Jan 2023 22:59:24 -0000
Date:   Mon, 30 Jan 2023 16:59:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: add the interrupts
 property
Message-ID: <20230130225924.GA3682264-robh@kernel.org>
References: <20230130134328.178591-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130134328.178591-1-brgl@bgdev.pl>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 02:43:28PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The interrupts property is used in all nodes using this binding but not
> defined in the document itself - hence dtbs_check fails for them. Add
> the property and update the example.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/qcom-wdt.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index 27fb484d5f8d..45940d643b92 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -46,6 +46,10 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  interrupts:
> +    minItems: 1
> +    maxItems: 5

What is each interrupt?

> +
>  required:
>    - compatible
>    - reg
> @@ -55,9 +59,16 @@ unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
>      watchdog@208a038 {
>        compatible = "qcom,kpss-wdt-ipq8064";
>        reg = <0x0208a038 0x40>;
>        clocks = <&sleep_clk>;
>        timeout-sec = <10>;
> +      interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
>      };
> -- 
> 2.37.2
> 
