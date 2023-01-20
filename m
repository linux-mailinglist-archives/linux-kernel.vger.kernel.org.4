Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3F674F8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjATIhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjATIhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:37:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3BD4B890
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:37:37 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c10-20020a05600c0a4a00b003db0636ff84so3107715wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRB/IiyXkdMMdJYWq/oocHtZQhTzcGoBGgStdMxQEkw=;
        b=aQCzV1rrOsBjLCZDxBjCiGyNhxU09x9w4zNPSffiYPybicZPBpw5eHyP+D+HeklZNq
         QbLrNWUCp8C9de5Q0/p6+Vt3/knbzKKep07tNHkBXEyRUH8XFXHIhKuceeu35JT1E2qm
         GvwmTccz5gGPNnSOFmk0cOkvEsrzg8RKbovVKR2XdSPgRXiH6//ZG4RgCe6iy+bCDlPj
         caIEpfauK4c0t1Y2eQU5KCZtW966u4voBCi36drxCaKAMXk8w4LnY3lJ0Ffa+N32cI51
         nm8ATa0ZteYH353zL3I/354QvRV+ZwscBjrb3paOcuXPtQ2O8L7Lx753LNHF7qGWnW3z
         y4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nRB/IiyXkdMMdJYWq/oocHtZQhTzcGoBGgStdMxQEkw=;
        b=446Z44SwMB/yyEPLUYW/ZemOIzeEOavwwCWhR9qH3JKVeKqhYgvwzNg9JU7jNexOXJ
         hjj9SNMWehwLWSorHq1//hAkf1bAv1mbtg+J3kL44UGb+tIb82M5rLbK7ipOTHU1idgK
         ArI4DA8Xl07FEo3QTCobF82YG33YPZSnIpHOtiizP1qKou5KsPFm8+osXYEElsAIAjIC
         Ar42xp1H/z52JVF0nP55Wm22Pw8WsZ10grYmN/KlKAIsTpE/LZ1H5b2XSUDplz5gks2u
         wPUUgtWr/m+Y4NJhVCLT6BB5Wf11Ello3rCW2grYtZtfYo9pj3bpLMgpLGUSGK9Zanfg
         mHjA==
X-Gm-Message-State: AFqh2kpk49eQnDm6F8xF+IFXgnbjOLG7mA5fZx818xtzWcU8k6wnCA0P
        ijHlS59B7kH3nfKSvP77fHlOcA==
X-Google-Smtp-Source: AMrXdXu9lCM+7+IWBdyR6kVSpX6jWUxs3qZCsnNi5zklrSwpeQ0OleSeZJB/ZVVmYCatA6ZC95IHBQ==
X-Received: by 2002:a05:600c:5405:b0:3d3:5709:68e8 with SMTP id he5-20020a05600c540500b003d3570968e8mr13014847wmb.36.1674203856285;
        Fri, 20 Jan 2023 00:37:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id fc17-20020a05600c525100b003db1d9553e7sm1693878wmb.32.2023.01.20.00.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 00:37:35 -0800 (PST)
Message-ID: <7befa113-c45a-93d0-2696-17bbf62af711@linaro.org>
Date:   Fri, 20 Jan 2023 09:37:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: PCI: qcom: Add SM8550 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119112453.3393911-1-abel.vesa@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119112453.3393911-1-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 12:24, Abel Vesa wrote:
> Add the SM8550 platform to the binding.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v2 was here:
> https://lore.kernel.org/all/20230118111704.3553542-1-abel.vesa@linaro.org/
> 
> Changes since v2:
>  * dropped the pipe from clock-names
>  * removed the pcie instance number from aggre clock-names comment
>  * renamed aggre clock-names to noc_aggr
>  * dropped the _pcie infix from cnoc_pcie_sf_axi
>  * renamed pcie_1_link_down_reset to simply link_down
>  * added enable-gpios back, since pcie1 node will use it
> 
> Changes since v1:
>  * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
>  * dropped enable-gpios property
>  * dropped interconnects related properties, the power-domains
>  * properties
>    and resets related properties the sm8550 specific allOf:if:then
>  * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
>    allOf:if:then clock-names array and decreased the minItems and
>    maxItems for clocks property accordingly
>  * added "minItems: 1" to interconnects, since sm8550 pcie uses just one,
>    same for interconnect-names
> 
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index a5859bb3dc28..93e86dfdd6fe 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -34,6 +34,7 @@ properties:
>        - qcom,pcie-sm8250
>        - qcom,pcie-sm8450-pcie0
>        - qcom,pcie-sm8450-pcie1
> +      - qcom,pcie-sm8550
>        - qcom,pcie-ipq6018
>  
>    reg:
> @@ -65,9 +66,11 @@ properties:
>    dma-coherent: true
>  
>    interconnects:
> +    minItems: 1
>      maxItems: 2

1. Why do you skip cpu-pcie interconnect on SM8550?
2. This should not be allowed on other variants.

>  
>    interconnect-names:
> +    minItems: 1
>      items:
>        - const: pcie-mem
>        - const: cpu-pcie
> @@ -102,6 +105,10 @@ properties:
>    power-domains:
>      maxItems: 1
>  
> +  enable-gpios:
> +    description: GPIO controlled connection to ENABLE# signal
> +    maxItems: 1
> +
>    perst-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -197,6 +204,7 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        properties:
>          reg:
> @@ -611,6 +619,41 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8550
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 7
> +          maxItems: 8
> +        clock-names:
> +          minItems: 7
> +          items:
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: noc_aggr # Aggre NoC PCIe AXI clock
> +            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
> +        iommus:
> +          maxItems: 1
> +        iommu-map:
> +          maxItems: 2

1. Don't define new properties in allOf. It makes the binding
unmaintainable.

2. Why only SM8550?

> +        resets:
> +          minItems: 1

Why second reset is optional?

> +          maxItems: 2
> +        reset-names:
> +          minItems: 1
> +          items:
> +            - const: pci # PCIe core reset
> +            - const: link_down # PCIe link down reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -694,6 +737,7 @@ allOf:
>                - qcom,pcie-sm8250
>                - qcom,pcie-sm8450-pcie0
>                - qcom,pcie-sm8450-pcie1
> +              - qcom,pcie-sm8550
>      then:
>        oneOf:
>          - properties:

Best regards,
Krzysztof

