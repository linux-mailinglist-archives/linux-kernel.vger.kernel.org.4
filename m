Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E366E5EB229
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiIZUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiIZUdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:33:43 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E36A61C3;
        Mon, 26 Sep 2022 13:33:42 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-127dca21a7dso10766423fac.12;
        Mon, 26 Sep 2022 13:33:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GfIBGS2IdI4gzQSLH6IzC9uAsmoYqAP8zfJrjwFCCmc=;
        b=pMG7E6yjOyfog3wpJAz6HV7ia+fFRJttGzX2ru+AeZGWUqB9hI89D80leAYNOFs8qb
         Ug0ATdfZHtp1kGuWyaczh2ephF2KNqoQgbmJc+rRlzLLC5JQxT0UY/1b7uobofhFhR7e
         eZO3HvDd1bdesCdYFeZ0wtzApoABxXUsl40Owwus6kZ4AZpR84cT5mj+pNwHLqvv5x/3
         aZVAK2ZH3jTk7TaJ6nP0DBYeLLXqBxEsM8lKUMEO4laUVbOBXX9P6U/e7dZr/23iciu1
         9tlqym1L+EkS7VTwww9LR5lyZA915KwZsHIGNAzWV7zu1SSjar5dzvIPUVj0LY0BuIWe
         8Jgg==
X-Gm-Message-State: ACrzQf32m5LJifNAO5pphGMKHc2g8rKZJ1Glf/9vv+vplmGW+QZfIaXj
        7GnkgEH4SVokt0eb7agrTQ==
X-Google-Smtp-Source: AMsMyM4heuuVKUh/XvTLz6/suWyuiiJA5u26m4jtlIgfrq6LbeLgcUfQSQHg+TuFlGIXO2vZ5gNlzg==
X-Received: by 2002:a05:6870:a9a0:b0:12b:45b6:80e1 with SMTP id ep32-20020a056870a9a000b0012b45b680e1mr297124oab.209.1664224421295;
        Mon, 26 Sep 2022 13:33:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d23-20020a056870961700b0010e73e252b8sm9495211oaq.6.2022.09.26.13.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:33:41 -0700 (PDT)
Received: (nullmailer pid 2759993 invoked by uid 1000);
        Mon, 26 Sep 2022 20:33:40 -0000
Date:   Mon, 26 Sep 2022 15:33:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] dt-bindings: pinctrl: qcom,sc8280xp-lpass-lpi: fix
 gpio pattern
Message-ID: <20220926203340.GA2752484-robh@kernel.org>
References: <20220922195651.345369-1-krzysztof.kozlowski@linaro.org>
 <20220922195651.345369-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922195651.345369-2-krzysztof.kozlowski@linaro.org>
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

On Thu, Sep 22, 2022 at 09:56:40PM +0200, Krzysztof Kozlowski wrote:
> Fix double ']' in GPIO pattern to properly match "pins" property.
> Otherwise schema for pins state is not applied.

Huh? The schema is applied, but would fail, right?

Perhaps the example should have some child nodes to demonstrate this.

> 
> Fixes: 958bb025f5b3 ("dt-bindings: pinctrl: qcom: Add sc8280xp lpass lpi pinctrl bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> index 1f468303bb08..fb3ad6c0d80e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml
> @@ -58,7 +58,7 @@ patternProperties:
>            List of gpio pins affected by the properties specified in this
>            subnode.
>          items:
> -          pattern: "^gpio([0-1]|1[0-8]])$"
> +          pattern: "^gpio([0-1]|1[0-8])$"
>  
>        function:
>          enum: [ swr_tx_clk, swr_tx_data, swr_rx_clk, swr_rx_data,
> -- 
> 2.34.1
> 
> 
