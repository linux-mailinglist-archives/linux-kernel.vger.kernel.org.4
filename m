Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FB4631535
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKTQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:41:34 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3615626488;
        Sun, 20 Nov 2022 08:41:33 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so6054616ots.8;
        Sun, 20 Nov 2022 08:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veASM1Ru8k6BEeQlnYaoITQx/GQvi6pXHnL18k1poTo=;
        b=zvCojk/0ymvQGcrApCxtK0NJOtGD6HOTs53DjDm45+Z/cM+8vYqVHlGfjnPiGQLjmf
         FQl3VTzD/u+DzD13K3/1Ko4tj5rVZTVqCsZdPSNEkiPNb7LOPbpqyD02LFY5iKscJNvc
         WMr3kTgqQtx+HDuyGvuizaXVJnyJcvBreNSu+3KO3nhuP8aaLoPcEP58QyOsX6pjw8OF
         jxoBXWKtUj0udcgT0rJ5ZWSL/2AxCCBa/ZiQVl2UAcPbM6VSK7ngn2yoD6VkyEy/wxBE
         uVNsyWmd3Inip1vhDhS4pODDY1jwyC4w96XxHvD8InWMPxqxDnQWxn0pCyC5yuy/UZ8j
         EKrA==
X-Gm-Message-State: ANoB5plahgxZwTJtjCvWD/WeCPNYGgmRXeue/lmpidFuWABQaM7l06fh
        6ttSUnbDFxDO1etVlAdXi+0AiFeS/w==
X-Google-Smtp-Source: AA0mqf5lC0lP3+FtTjyt1UTtsFHeF9vc2w+gpHK+byaFWtEnCNtq0+ey+OkENKCa7dcNcZ81HZCswA==
X-Received: by 2002:a9d:4c93:0:b0:66d:6164:16f5 with SMTP id m19-20020a9d4c93000000b0066d616416f5mr7947867otf.207.1668962492446;
        Sun, 20 Nov 2022 08:41:32 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:5cb3:df5a:23c3:86fb:15a6])
        by smtp.gmail.com with ESMTPSA id f14-20020a056870210e00b0012752d3212fsm4748295oae.53.2022.11.20.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 08:41:32 -0800 (PST)
Received: (nullmailer pid 3177849 invoked by uid 1000);
        Sun, 20 Nov 2022 16:41:33 -0000
Date:   Sun, 20 Nov 2022 10:41:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sdm845-pinctrl: add GPIO hogs
Message-ID: <20221120164133.GA3166916-robh@kernel.org>
References: <20221118162101.145267-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118162101.145267-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 05:21:01PM +0100, Krzysztof Kozlowski wrote:
> Allow GPIO hogs in pin controller node.  qcom/sdm845-cheza.dtsi already
> uses it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> index c9627777ceb3..57bac7f7a4fc 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> @@ -48,6 +48,11 @@ patternProperties:
>              $ref: "#/$defs/qcom-sdm845-tlmm-state"
>          additionalProperties: false
>  
> +  "-hog(-[0-9]+)?$":
> +    $ref: /schemas/gpio/gpio-hog.yaml

You can drop this and just do:

required:
  - gpio-hog

As that's what selects the hog schema. Kind of an odd pattern I guess. 
We could make gpio.yaml define hog nodes instead I suppose.

> +    type: object
> +    unevaluatedProperties: false
> +
