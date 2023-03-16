Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541266BC6EB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCPHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCPHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:18:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72D240D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:18:47 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn21so3979644edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NnXgwqMa80GgQcjZaphhuCryiuQqQv6hvEmtAcagRtY=;
        b=Y6rCA9o2f/NI+S8BIN3TvXbjfq9ybMB1G7Q9KQX3B+K4Cp2J0Ehi5nlbqDi/MjIz3C
         D7csLNuQSuZRrKjPRxEvZJyJTwlyECGyVgp3ERZx4Xg53boHF8Zy0MNE3q9itV1Vm30Q
         eXwA2APfJHxQcYMFPjsRyyPusvx5XoIry2qv0gYOEcq1WtP/NtXcLNYG+ve+JO18nxHs
         nWLnDsFFbh1+shFw70JrGq3+adeq8zrsnxXIwxPDPb7OSV2hgx/JkUj0gc7z/TP4HT0w
         gJ8wfmgek9zr2TQnF3A0MMqKPjqwvt2Ad1i20sN6cGg2d8MDAXls9pbOnkC/sfmk7SEX
         Hs6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951126;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NnXgwqMa80GgQcjZaphhuCryiuQqQv6hvEmtAcagRtY=;
        b=hCOHtlADgkE+cBVEcOmdSflD//PpuyIa8/Wl4loo9C9mPvuSSgdSVwSoWa2qLMjmdJ
         933rBFWOWxYgWVg724y94xua8or35nTI5kDOUXfNNAZMr3hszaAZvqZoxTGOoMl/ZsVT
         UCcemMBCVR+w8PKPozWTTqUM3a6KHnrT57LwwsRh9x8a6ounFr+AY7h4aTBk0NiPkMSL
         cToW070Lx/0uyZJyVJQn0qhT4ES/lzCw1KpkqEQxpExKZCUZAKw8tHZp4toyTuByYc7C
         OgSR8zPT0kCq0yJSjT1McJSF/9okVPNJxbWrlLN9ayzvu3qhLzCpEHxyZBFvNU3yvDEz
         Su9g==
X-Gm-Message-State: AO0yUKU4lHRQu6H4sO3Tt4M4mmNup0yn7s/sCJRet7t5QHuEu9kmiKpO
        ymJaSvfPIkD+H1pntomnqyWXJ1HJgEVHBuhkIf8=
X-Google-Smtp-Source: AK7set8KeJ1ASIpRhtbE5CF8uaaqBb8UCVuakG6IHDgYISCsD2RCx+znpN/mu0oRZl2mQ+YHVYN89A==
X-Received: by 2002:aa7:c04f:0:b0:4fa:b302:84d0 with SMTP id k15-20020aa7c04f000000b004fab30284d0mr5511978edo.15.1678951122577;
        Thu, 16 Mar 2023 00:18:42 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id v1-20020a50c401000000b004acbda55f6bsm3401675edf.27.2023.03.16.00.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:18:42 -0700 (PDT)
Message-ID: <d3dd5001-1b97-cc94-0a78-0420dc97614b@linaro.org>
Date:   Thu, 16 Mar 2023 08:18:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next 03/11] dt-bindings: net: qcom,ethqos: Convert
 bindings to yaml
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        bhupesh.sharma@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, peppe.cavallaro@st.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
        linux@armlinux.org.uk, veekhee@apple.com,
        tee.min.tan@linux.intel.com, mohammad.athari.ismail@intel.com,
        jonathanh@nvidia.com, ruppala@nvidia.com, bmasney@redhat.com,
        andrey.konovalov@linaro.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, ncai@quicinc.com,
        jsuraj@qti.qualcomm.com, hisunil@quicinc.com
References: <20230313165620.128463-1-ahalaney@redhat.com>
 <20230313165620.128463-4-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230313165620.128463-4-ahalaney@redhat.com>
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

On 13/03/2023 17:56, Andrew Halaney wrote:
> From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> 
> Convert Qualcomm ETHQOS Ethernet devicetree binding to YAML.
> 

(...)

> diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> new file mode 100644
> index 000000000000..68ef43fb283d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/qcom,ethqos.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Ethernet ETHQOS device
> +
> +maintainers:
> +  - Bhupesh Sharma <bhupesh.sharma@linaro.org>
> +
> +description:
> +  This binding describes the dwmmac based Qualcomm ethernet devices which

Drio "This binding describes", but say what is the hardware here.

> +  support Gigabit ethernet (version v2.3.0 onwards).
> +
> +  So, this file documents platform glue layer for dwmmac stmmac based Qualcomm
> +  ethernet devices.
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,qcs404-ethqos
> +      - qcom,sm8150-ethqos
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: stmmaceth
> +      - const: rgmii
> +
> +  interrupts:
> +    items:
> +      - description: Combined signal for various interrupt events
> +      - description: The interrupt that occurs when Rx exits the LPI state
> +
> +  interrupt-names:
> +    items:
> +      - const: macirq
> +      - const: eth_lpi
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: pclk
> +      - const: ptp_ref
> +      - const: rgmii
> +
> +  iommus:
> +    maxItems: 1

Isn't this new property? Last time I asked to mention the changes to the
binding done during conversion. Explain shortly why you are adding new
properties.

> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names

reg-names

> +
> +unevaluatedProperties: false
> +


Best regards,
Krzysztof

