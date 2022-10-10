Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033795F9D92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbiJJL2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiJJL1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:27:47 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23456EF0B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:27:41 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id l19so6934489qvu.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 04:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6KLFalUAyDYRRAuo2RZEo0CIB7dAfq1L+VrdHdQSF6M=;
        b=ZJ9JbKxFDyiBd5daTqxJj86MOdeWinWUnr80mi1bPPACzfNeK9IvC/g6gqx/LXA9TJ
         MPWcdYUyUamm4i3pL63JnHFDjFRnK+nRIcJU523efyNUnGOublJ+QAOpvO9tGknp0y68
         1O4CsyiJ4oTUucISC5Yu3lmbM9wQrEpCsU2bg/+HgKrO/9ilAC1cNBFi8/zcd3erdzPt
         qnCV9ZClNByB4GjT5MyOyJaTTsGK6w10otN49B8UOqhZmi+d0Xv+2x3KUFXboPEcgntn
         lboXJDeOkj+0bI29uA7ufSEJHQeYVIRk6JxQIfRAqOO6NxJ7xdqFe+fcxVvNlpyk+qpB
         jMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KLFalUAyDYRRAuo2RZEo0CIB7dAfq1L+VrdHdQSF6M=;
        b=g4Q81q5jY4F3T/a+uB2Cq5uqRXYzDl3yi1ilHzSRCTxBXIKkEVTvKUIMbonggiOYNn
         wLXj715qgnnIhMXRimtWMW/sNmrnymXj3BqB6ceY+Mn0IqI1l4Qqy/w42FERrZav4FXE
         62RHkKHozReYWiZIn6UK3LLMIFUdEpzL5hl+oMjrnV5CyS3PgRRsIb7ETL6V3xjwu2h+
         b1uBr1H2EcIMoYY9D3auFeTS787AtKxB5GpezTfI/8Ff89H2mzkqY+pOCWdjp0/b5Gdu
         Ca/LLF/ZoN9+kaUHXdVgIHEZJX+2CqOivGTrvrUqqMDpe7doQI/HKuuSBEwquJi95PQ5
         1wzQ==
X-Gm-Message-State: ACrzQf1K/cTcMY+sd2k7q7tcyTCCZzb//nu/oyK2WWgI/bUfBlEvs+n1
        ery7tLJOLkhtrPxUciuSqHuX5w==
X-Google-Smtp-Source: AMsMyM4mKTBEEm7Io1Pjk/bSULDpUWutUdTQql6wf7Yl68LM838llzxU2f41GEwsTa6+bZ1fOSHG9g==
X-Received: by 2002:a05:6214:5cc5:b0:4b3:dd79:cc7e with SMTP id lk5-20020a0562145cc500b004b3dd79cc7emr8205111qvb.76.1665401261100;
        Mon, 10 Oct 2022 04:27:41 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id t28-20020a37ea1c000000b006cdd0939ffbsm9977560qkj.86.2022.10.10.04.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 04:27:40 -0700 (PDT)
Message-ID: <bf471795-8821-6206-408e-4460c59fff5b@linaro.org>
Date:   Mon, 10 Oct 2022 07:25:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 09/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6735 pin controller
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-10-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221007125904.55371-10-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 08:59, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add bindings for the pin controller found on MediaTek MT6735 and
> MT6735M SoCs, including describing a method to manually specify
> a pin and function in the pinmux property making defining bindings
> for each pin/function combination unnecessary. The pin controllers
> on those SoCs are generally identical, with the only difference
> being the lack of MSDC2 pins (198-203) on MT6735M.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 46 ++++++++++++++++++-
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> index 71a9aae2cc8c..7b120803a1a5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> @@ -10,6 +10,7 @@ maintainers:
>    - Andy Teng <andy.teng@mediatek.com>
>    - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>    - Sean Wang <sean.wang@kernel.org>
> +  - Yassine Oudjana <y.oudjana@protonmail.com>
>  
>  description:
>    The MediaTek pin controller on MT6779 is used to control pin
> @@ -18,6 +19,8 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - mediatek,mt6735-pinctrl
> +      - mediatek,mt6735m-pinctrl
>        - mediatek,mt6765-pinctrl
>        - mediatek,mt6779-pinctrl
>        - mediatek,mt6795-pinctrl
> @@ -63,6 +66,33 @@ required:
>  
>  allOf:
>    - $ref: "pinctrl.yaml#"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt6735-pinctrl
> +              - mediatek,mt6735m-pinctrl
> +    then:
> +      properties:
> +        reg:
> +          minItems: 8
> +          maxItems: 8
> +
> +        reg-names:
> +          items:
> +            - const: gpio
> +            - const: iocfg0
> +            - const: iocfg1
> +            - const: iocfg2
> +            - const: iocfg3
> +            - const: iocfg4
> +            - const: iocfg5
> +            - const: eint
> +
> +        interrupts:
> +          items:
> +            - description: EINT interrupt

Blank line

Best regards,
Krzysztof

