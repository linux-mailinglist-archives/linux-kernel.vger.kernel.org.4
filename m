Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECAE622DE1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKIO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiKIO2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:28:15 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B53124097
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:27:59 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id l8so26021014ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCCELem9+mQDtxVmOT5L59PdtIw9jRovY2CaqHIo5Qw=;
        b=kEFWt4r9tEMxPT+vHVBSBAKa4tLC705OoaysqJn8fCKfLh5G6/IdpgFypIijS3utvV
         KyQsk4f/d+wHcGrp85NNgWBNl8Y/49bOu8MB2taVgPlKTZl2CEFeXkZxGjiXRIUzJbsS
         PQ4TAHdtaqPXVAgJOGg+j2QSF08K2L/RgzRr/uvibgtGgYfLTcTRFDyrrlY9ozgPMb+L
         TZ5tIiMkoiIbczaRI3vf0xJwFwgZY8x2pO+PI2InTlPQB0v5f5QiRFk3cbqZ45u/x5aH
         gTpeHfqmYA6b0uFLhKmF46UvUhEd7TWt9vTL48G1pi8oqb0tYJ2sj8uSD3Q9daGCJm38
         z5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCCELem9+mQDtxVmOT5L59PdtIw9jRovY2CaqHIo5Qw=;
        b=VuFY1Qrzg8pkYVVnRA22zIsxPmRiuOA1R2F4/iK7U3ax11gnwqk8mJaRrppsAqOYkv
         09E7Lj+kbxZry1LNeOSPoglci5B2a2V7lzAIgkLYsqKNpKQmyaqZrVmetBowa2XDjR++
         ftu1fLB1YuqaF7/5qI2A4vNkZmut/JjfSX+6abFBymtRzpRMAg1HW4JXaZIslq7shZLF
         t+q2eWg6aV+7EJnWFF4pScposEVgpmzSLv6AtqrjqVmFiQUXmbfA9NAuSSJeXSUivo2Y
         X+VbdfMieFDC/t34RDwCg6tIKPOy1xtattPNK5mJETBsmMTeqgG5gon+BSVXnME6XEKI
         eIlQ==
X-Gm-Message-State: ACrzQf11+GqXIbTuEgS0GDZIXwUeikTF/W6uC4hx93CRo76H5AxxGUC7
        hVC4QtRJcEXh31lyvBi8e8GueA==
X-Google-Smtp-Source: AMsMyM4dxnW2pb7F6347nlSZY36iTIEXOoos43IkaLCDPPV/eBW8vYQhRdoiS5OHBZu2zuj/g+QXFw==
X-Received: by 2002:a2e:888a:0:b0:277:eba:937 with SMTP id k10-20020a2e888a000000b002770eba0937mr8349365lji.207.1668004077492;
        Wed, 09 Nov 2022 06:27:57 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id m6-20020a2e9346000000b002770d8625ffsm2184463ljh.88.2022.11.09.06.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 06:27:56 -0800 (PST)
Message-ID: <df17e456-0267-4771-41e1-c986f710a368@linaro.org>
Date:   Wed, 9 Nov 2022 15:27:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] dt-bindings: clock: add QCOM SM6375 display clock
 bindings
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221109141855.52628-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109141855.52628-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 15:18, Konrad Dybcio wrote:
> Add device tree bindings for display clock controller for
> Qualcomm Technology Inc's SM6375 SoC.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Cool! Welcome!

> ---
>  .../bindings/clock/qcom,sm6375-dispcc.yaml    | 68 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm6375-dispcc.h    | 42 ++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm6375-dispcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
> new file mode 100644
> index 000000000000..4f905f0bc1d9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-dispcc.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license, please, unless you include here some stuff which prevents it.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm6375-dispcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock & Reset Controller Binding for SM6375

Adjust it to match style-refactoring:
https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=clk-for-6.2&id=ece3c3198182a13825a7f02844894ba6a03d58d1

> +
> +maintainers:
> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
> +
> +description: |
> +  Qualcomm display clock control module which supports the clocks, resets and
> +  power domains on SM6375.

Also here

> +
> +  See also:
> +  - dt-bindings/clock/qcom,dispcc-sm6375.h

And here

> +
> +properties:
> +  compatible:
> +    const: qcom,sm6375-dispcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO source
> +      - description: GPLL0 source from GCC
> +      - description: Byte clock from DSI PHY
> +      - description: Pixel clock from DSI PHY
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1

All these look like qcom,gcc.yaml

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=clk-for-6.2&id=842b4ca1cb8cf547dc63cfe37342f0704454ac2f

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +  - '#reset-cells'
> +  - '#power-domain-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
> +    #include <dt-bindings/clock/qcom,rpmh.h>
> +
> +    clock-controller@5f00000 {
> +      compatible = "qcom,sm6375-dispcc";
> +      reg = <0x05f00000 0x20000>;
> +      clocks = <&rpmhcc RPMH_CXO_CLK>,
> +               <&gcc GCC_DISP_GPLL0_CLK_SRC>,
> +               <&dsi_phy 0>,
> +               <&dsi_phy 1>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      #power-domain-cells = <1>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/qcom,sm6375-dispcc.h b/include/dt-bindings/clock/qcom,sm6375-dispcc.h
> new file mode 100644
> index 000000000000..b1de14677a61
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,sm6375-dispcc.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license


Best regards,
Krzysztof

