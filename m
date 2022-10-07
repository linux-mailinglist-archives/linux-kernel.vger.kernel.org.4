Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31F55F7496
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJGHJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 03:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJGHJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 03:09:28 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F3ABB07F
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:09:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a12so4689276ljr.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 00:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=vCRWEF8VLHqnCH4WBhxkAT6aRcv54BJkl/Tn8yVW2Vo=;
        b=YBCTZw+sBWRkMCPLBQGtFEceujBSXZWXcLmkOGTiGGhC1iaXwMDvi+POzPsWx4Ap7t
         wCAwtKl8t+hGOjeBbv46LMXu1KvFbSA0dfm7465ub1uRvvWWw4hS/XwJu4VOlrrMX0vC
         N5iTFAzwKQ9sUHCPaNmCR1IXFYtX/gnGpCoX8rKqgdubi28+PHHNe3I3nCiApNJFSl1k
         PDpuz9XR4RGndtX1sfwzmsD4U9gCv0JHEtR08MmodI1grunwrhhzQTDD+/zBjJvSDOmt
         wWPku9B8B1gqyM2Ws4wjYahT3fekc9wMvlYM1MVl0kK6XPpy+ehoFvHfDx0UcHVYwvN2
         Q6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=vCRWEF8VLHqnCH4WBhxkAT6aRcv54BJkl/Tn8yVW2Vo=;
        b=K08mFBv8sfcc5OV9QPsr8N1CG5kyayEUotmpmLO2ZR4iAZhgmWikL5U6xQgQs9FOII
         VOKHwO9aEDhhq8tvk9EF/5DCYp8MRNa4ZmcNlc6KGtBj4kOZCUumlPf3VM/eUXqoXs2O
         B/IfIyY2LkcaT4LPew7s9L5uTEJPF1cqEKBl15Zdxsh+ITJaeoRILLtug9dtLDq179ap
         J5tkj+FcPVc81DjXRfP6u4B62ybO365ptp0LROK0XtTaEPQuiRFeFBiw6G3v/uliZyJr
         jS9gYJSP7pa2/ZjHv+8IEiBU61bLQQYOLxDgc7UbZTnjQk2q7h3v2ZSreD32Sm+zK1ET
         l0Sw==
X-Gm-Message-State: ACrzQf1HiB0Vzfbiq/RMmNrXP+nSrGGIZoEIxxiSEbHAMh4WOCs7nN51
        x201QNheUMxaM8ArouO38yDxkQ==
X-Google-Smtp-Source: AMsMyM69vs7GHGx7R6YuBNKkrQI65YrlPF7aY1rqRVO/tA8YuRScsTIIQAfzVZEErv0M3FWeYVzSQA==
X-Received: by 2002:a2e:bba2:0:b0:26b:e2d6:fe44 with SMTP id y34-20020a2ebba2000000b0026be2d6fe44mr1139102lje.286.1665126565048;
        Fri, 07 Oct 2022 00:09:25 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v26-20020ac2559a000000b0049964f68457sm172995lfg.262.2022.10.07.00.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 00:09:24 -0700 (PDT)
Message-ID: <da10e24f-3512-c111-13f0-a22851a99062@linaro.org>
Date:   Fri, 7 Oct 2022 09:09:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v8 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221006232219.37505-1-mailingradian@gmail.com>
 <20221006232219.37505-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221006232219.37505-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2022 01:22, Richard Acayan wrote:
> There is a new driver for the Snapdragon 670 TLMM (Top-Level Mode
> Multiplexer). Document it.
> 
> Adapted from qcom,sm6350-pinctrl.yaml.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> ---
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 129 ++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> new file mode 100644
> index 000000000000..e2f563ae6bbf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sdm670-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SDM670 TLMM block
> +
> +maintainers:
> +  - Richard Acayan <mailingradian@gmail.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer (TLMM) block found
> +  in the SDM670 platform.

Drop "This bindings describes the"

> +
> +allOf:
> +  - $ref: pinctrl.yaml#

Drop.

> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sdm670-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true

Use consistent " everywhere.

Best regards,
Krzysztof

