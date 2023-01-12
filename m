Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C52DA6669E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 05:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjALEAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 23:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjALEAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 23:00:15 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D853DBC9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:00:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d30so21710699lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 20:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5EVhIygjFXI/wEoux14pr0fCdUTfx0iiJBUloQllnVI=;
        b=Xyrya5U/NSLY9sRln6RfP1MnF8iETi9sdYaEYQ3HOPpDcBIMdx7sYtCsIMF0NIQp8a
         PmlRe/AZTNHVl5dEKFw5BVzkBCLifL0RJD4rYy4kkm8V4FodOS4jGGNbHCyu+XNSBhgQ
         ZsYBUD6nT/9AY5rR7XpXiBMZu+ATk3qaMRGSVA/XvSoC801HMzBSKwh5WuHkKWVX3/Hm
         lTHqk9K5TvTtvm/wcOkCYSJpFPuMrEHvkXvOHEeSPYwYSPs2Hc696i/R4b8Pl8vqjAYH
         W+jq6L4ikY5/LRdQQCyYyomDfb7abVEEEYCYX3zLqQZ81EGgY3BGoVdPAoL9aHk98QDG
         O7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5EVhIygjFXI/wEoux14pr0fCdUTfx0iiJBUloQllnVI=;
        b=mgs9DWQnoRmvgjCaCLx9rQh+rr32adNUwJ+Zja6WLIHnOTXOIfDfV9deIIAnnfMovw
         icHvp2F0etTDcCaDAGsXFhvU2obi37dDoQmrg0Q+d34JLD51wboNfYqaexXIbgzB9sD/
         9QoS0UTfYPc5uISaADXfX5Z81sgK4Sz8OLe1gsp6cUz7bHdkIXFqmi40aOjPv3wqWD00
         4kMt/My/QNgUCzlSI9id6Id6roo+Oq5a0WiZvwYJYt5RJqFgLtFnK63wytyapTrMQjBA
         5SXyPW3OYBOZNb+li/K4zNVWse9u7x3HryLs0P26vYOKCcUvRr253dLRTtbuDisJEoGl
         Tqew==
X-Gm-Message-State: AFqh2koQc27WoCTd8lXZmqacZOvIl6Mz80yElmvDiIWVpiDqw64806dx
        Lopi4AM8CNzZkJLCDG1NUBKKgA==
X-Google-Smtp-Source: AMrXdXudJ6zq35HX6LsvmUjQfgdbWkNYChpGbSjoQYJvDsgM9+AJHJISaSV38xz2ki3wZGsoSiVeNg==
X-Received: by 2002:a05:6512:340d:b0:4b6:ec96:bb9a with SMTP id i13-20020a056512340d00b004b6ec96bb9amr26246255lfr.60.1673496011595;
        Wed, 11 Jan 2023 20:00:11 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id y4-20020a0565123f0400b004cc590975f7sm3051138lfa.183.2023.01.11.20.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 20:00:10 -0800 (PST)
Message-ID: <f851bca5-d0e1-fe40-9b06-e6f2af37cce0@linaro.org>
Date:   Thu, 12 Jan 2023 06:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 2/6] dt-bindings: arm: msm: Convert and split kpss-acc
 driver Documentation to yaml
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20230110183259.19142-1-ansuelsmth@gmail.com>
 <20230110183259.19142-3-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230110183259.19142-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 20:32, Christian Marangi wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, split the Documentation
> to 2 different schema, v1 as clock-controller and v2 for
> power-controller as per msm-3.10 specification, the exposed regs handle
> power domains.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 -------------
>   .../bindings/clock/qcom,kpss-acc-v1.yaml      | 72 +++++++++++++++++++
>   .../bindings/power/qcom,kpss-acc-v2.yaml      | 47 ++++++++++++
>   3 files changed, 119 insertions(+), 49 deletions(-)
>   delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
>   create mode 100644 Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt b/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> deleted file mode 100644
> index 7f696362a4a1..000000000000
> --- a/Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
> +++ /dev/null
> @@ -1,49 +0,0 @@
> -Krait Processor Sub-system (KPSS) Application Clock Controller (ACC)
> -
> -The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> -There is one ACC register region per CPU within the KPSS remapped region as
> -well as an alias register region that remaps accesses to the ACC associated
> -with the CPU accessing the region.
> -
> -PROPERTIES
> -
> -- compatible:
> -	Usage: required
> -	Value type: <string>
> -	Definition: should be one of:
> -			"qcom,kpss-acc-v1"
> -			"qcom,kpss-acc-v2"
> -
> -- reg:
> -	Usage: required
> -	Value type: <prop-encoded-array>
> -	Definition: the first element specifies the base address and size of
> -		    the register region. An optional second element specifies
> -		    the base address and size of the alias register region.
> -
> -- clocks:
> -        Usage: required
> -        Value type: <prop-encoded-array>
> -        Definition: reference to the pll parents.
> -
> -- clock-names:
> -        Usage: required
> -        Value type: <stringlist>
> -        Definition: must be "pll8_vote", "pxo".
> -
> -- clock-output-names:
> -	Usage: optional
> -	Value type: <string>
> -	Definition: Name of the output clock. Typically acpuX_aux where X is a
> -		    CPU number starting at 0.
> -
> -Example:
> -
> -	clock-controller@2088000 {
> -		compatible = "qcom,kpss-acc-v2";
> -		reg = <0x02088000 0x1000>,
> -		      <0x02008000 0x1000>;
> -		clocks = <&gcc PLL8_VOTE>, <&gcc PXO_SRC>;
> -		clock-names = "pll8_vote", "pxo";
> -		clock-output-names = "acpu0_aux";
> -	};
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
> new file mode 100644
> index 000000000000..a466e4e8aacd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,kpss-acc-v1.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,kpss-acc-v1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v1
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region. ACC v1 is currently used as a
> +  clock-controller for enabling the cpu and hanling the aux clocks.
> +
> +properties:
> +  compatible:
> +    const: qcom,kpss-acc-v1
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region
> +    minItems: 1
> +
> +  clocks:
> +    minItems: 2
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: pll8_vote
> +      - const: pxo
> +
> +  clock-output-names:
> +    description: Name of the aux clock. Krait can have at most 4 cpu.
> +    enum:
> +      - acpu0_aux
> +      - acpu1_aux
> +      - acpu2_aux
> +      - acpu3_aux
> +
> +  '#clock-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - clock-output-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,gcc-ipq806x.h>
> +
> +    clock-controller@2088000 {
> +      compatible = "qcom,kpss-acc-v1";
> +      reg = <0x02088000 0x1000>, <0x02008000 0x1000>;
> +      clocks = <&gcc PLL8_VOTE>, <&pxo_board>;
> +      clock-names = "pll8_vote", "pxo";
> +      clock-output-names = "acpu0_aux";
> +      #clock-cells = <0>;
> +    };
> +
> +...
> diff --git a/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> new file mode 100644
> index 000000000000..91af95569ae6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/qcom,kpss-acc-v2.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/qcom,kpss-acc-v2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Krait Processor Sub-system (KPSS) Application Clock Controller (ACC) v2
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description:
> +  The KPSS ACC provides clock, power domain, and reset control to a Krait CPU.
> +  There is one ACC register region per CPU within the KPSS remapped region as
> +  well as an alias register region that remaps accesses to the ACC associated
> +  with the CPU accessing the region. ACC v2 is currently used as a
> +  power-controller for enabling the cpu.
> +
> +properties:
> +  compatible:
> +    const: qcom,kpss-acc-v2
> +
> +  reg:
> +    items:
> +      - description: Base address and size of the register region
> +      - description: Optional base address and size of the alias register region
> +    minItems: 1
> +
> +  '#power-domain-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#power-domain-cells'

This dictates that if at some point we implement the kps-acc-v2 driver, 
it will return a single power domain. I can not confirm that this would 
be the case. I see that you want to migrate from the clock-controller as 
the acc-v2 doesn't provide clocks. I'd suggest instead using the neutral 
`power-manager@...` node name. It doesn't demand anything, so we can 
drop the (unused and unsupported) #power-domain-cells property.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    power-controller@f9088000 {
> +      compatible = "qcom,kpss-acc-v2";
> +      reg = <0xf9088000 0x1000>,
> +            <0xf9008000 0x1000>;
> +      #power-domain-cells = <0>;
> +    };
> +...

-- 
With best wishes
Dmitry

