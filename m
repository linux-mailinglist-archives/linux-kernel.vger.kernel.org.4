Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682A168B90A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBFJwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBFJwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:52:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55D1CF70
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:52:10 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id dr8so32426222ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baVP657n8icmklgNe0xOuxc0O0JI+5IT7IAu1E1Ky7k=;
        b=PejvlXRJZwnjHFmZqjeyDC4631Qf/DpedicCiPcMmDPWobE3+8JEzNN1MwoQmE+Cr7
         +oFSLhPspjpUKKhrMcKxXcV8MsF5/V3T8eJGFT1UrBxuF68gHdFP9TreXoaNb85YRB8K
         Ur7y33M7x+ITEV9HLoWL95S1YTMuLAvlPHWBTEmWL8rya1rAjFB4ATVitCHz0dft91OZ
         xsdYv5X9rKND35Pdx4s8Htag48DNIOhY+aXoswR4+hVMcFJK5Q/2YVHE2ZOQXFkw3kow
         7fMEcRA6UGv6JE0rAgT99W5yCSd+zP7Zozmb+6hnR31RnWd7gMFejjANtV1ZOFrEiMDd
         rMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=baVP657n8icmklgNe0xOuxc0O0JI+5IT7IAu1E1Ky7k=;
        b=7JX/0fqylNXGmXuoN0PsR89HS9RKWklu1ZTNVBqtFh2H56k5MuCA6+wiLQ/8ei8Yug
         GTib+1oM7XPVdGgZpKHbNZFsFtXkvYw1NMGYwLtOR20c+kTzk4RHMRx7LP/5bKoFtpHj
         29KwpMRE3NMv64mrEc9aYxubELrMPWZjXOtjNa64Juj86rGB4oadIlBGovJx+gctNav4
         pwJYmuQ7MK1aIXKpv7Mpe5cWF4urJ++Dwl08iQbFz7HG3NqmWJ/+Dd52+uT4OWQgvd/F
         UvxJjrYazK+w9wHVf5B3ZM7+mSpwOD1dg9Q9ONdD+2sH0pL1uh2KSygfCKpYtaGhYOVv
         88lA==
X-Gm-Message-State: AO0yUKWUQcNEAixvYzcnE8I5Sz0gb779f+xrYAJKMgJaadIS5uNBxRDd
        AbdSAPdhC8cy0VlmVFAlGGdmX5VrFPIECoW6
X-Google-Smtp-Source: AK7set819Bt8yINrBhs7qYEWhkifE9mWvvy3wPSDQiyXOb5hzFTlwkg1yIxUDyAiQZ1LDgExVDz4qA==
X-Received: by 2002:a17:906:3608:b0:878:711d:9310 with SMTP id q8-20020a170906360800b00878711d9310mr20275052ejb.1.1675677129200;
        Mon, 06 Feb 2023 01:52:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id uj19-20020a170907c99300b0088c804c4ae2sm5126434ejc.201.2023.02.06.01.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 01:52:08 -0800 (PST)
Message-ID: <03d6c92a-c9f3-915c-218a-14ff5c5250d2@linaro.org>
Date:   Mon, 6 Feb 2023 11:52:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 4/9] dt-bindings: clock: Add Qualcomm IPQ5332 GCC
Content-Language: en-GB
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        krzysztof.kozlowski@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        nfraprado@collabora.com, robimarko@gmail.com,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-5-quic_kathirav@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230206071217.29313-5-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 09:12, Kathiravan T wrote:
> Add binding for the Qualcomm IPQ5332 Global Clock Controller.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V3:
> 	- Actually I missed to remove the clocks in V2 which are supposed to
> 	  be removed. In V3 I have removed those and they are
> 	  GCC_APSS_AHB_CLK, GCC_APSS_AHB_CLK_SRC, GCC_APSS_AXI_CLK
> 	- For the same, didn't add the Reviewed-By tags from Stephen and
> 	  Krzysztof
> 
> Changes in V2:
> 	- property 'clocks' is marked required
> 	- Renamed the include file name to match with compatible
> 
>   .../bindings/clock/qcom,ipq5332-gcc.yaml      |  61 +++
>   include/dt-bindings/clock/qcom,ipq5332-gcc.h  | 356 ++++++++++++++++++
>   2 files changed, 417 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
>   create mode 100644 include/dt-bindings/clock/qcom,ipq5332-gcc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> new file mode 100644
> index 000000000000..961311af400c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq5332-gcc.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq5332-gcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller on IPQ5332
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +description: |
> +  Qualcomm global clock control module provides the clocks, resets and power
> +  domains on IPQ5332.
> +
> +  See also:: include/dt-bindings/clock/qcom,gcc-ipq5332.h
> +
> +allOf:
> +  - $ref: qcom,gcc.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,ipq5332-gcc
> +
> +  clocks:
> +    items:
> +      - description: Board XO clock source
> +      - description: Sleep clock source
> +      - description: PCIE 2lane PHY pipe clock source
> +      - description: PCIE 2lane x1 PHY pipe clock source (For second lane)
> +      - description: USB PCIE wrapper pipe clock source
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +      - const: sleep_clk
> +      - const: pcie_2lane_phy_pipe_clk
> +      - const: pcie_2lane_phy_pipe_clk_x1
> +      - const: usb_pcie_wrapper_pipe_clk

pcie3x1_0_pipe_clk_src, pcie3x1_1_pipe_clk_src, pcie3x2_pipe_clk_src 
usb0_pipe_clk_src are missing.

> +
> +required:
> +  - compatible
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    clock-controller@1800000 {
> +      compatible = "qcom,ipq5332-gcc";
> +      reg = <0x01800000 0x80000>;
> +      clocks = <&xo_board>,
> +               <&sleep_clk>,
> +               <&pcie_2lane_phy_pipe_clk>,
> +               <&pcie_2lane_phy_pipe_clk_x1>,
> +               <&usb_pcie_wrapper_pipe_clk>;
> +      #clock-cells = <1>;
> +      #power-domain-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +...

-- 
With best wishes
Dmitry

