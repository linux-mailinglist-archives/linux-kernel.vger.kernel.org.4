Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BCF7179D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjEaITZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbjEaITW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:19:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C0E93
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:19:20 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96f7377c86aso956593266b.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685521159; x=1688113159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17G7fgccZw26IuKEnhcF6apgAkC9GALykdO8V5FR4Zc=;
        b=jIe6mWyUFq7h8o883sjF4wSXtBDd+bizNgKp2DtJauDCvI5g4VWQcvYx3wxWVLtPmq
         DwxwtXoa4Pog0Kchm7HKAqaML2QCVDfxTVIcZHUx9Q/nXjFeLO4p5BqWeMEiRSDRuBf3
         +EiqsspEnZsz+874OwruO1KbzkrW3v4QC1KeQeCafNQfI7P6qZ9NN8ZfNXxz8LENrZi7
         BQOTVODkD57MOtE1Jal69BticPl3JoW1oYtUQc0AFU7i65yvtcqSrP4CKXZubagVbX9V
         Td+OXZhyQk78D6E96Up6MMmP+hEKuk/bOjpPYjVPN/bb4Zuc1GWL7283Mxxh0pQIGqkK
         M3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685521159; x=1688113159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17G7fgccZw26IuKEnhcF6apgAkC9GALykdO8V5FR4Zc=;
        b=a7FJ0kfOHc13aZc0AymUtoqzv1gkB/XFYfdfQGEUwuIFy4iuzn/nXdMze0ceudkEtE
         hpTv5L1hs+O0sDslYqdy/NTmnU+9LwVK1LwkIQIZvRt+MtpLGvfok1PXWcNo3q/kGoXV
         6iK13iVu34i+ojIS6sY8eiI4GTcudr7NY7q43tLdU/hzsRTIzulbVXsG/pi/O+czZWzL
         TxEewJjoH/MEFm5LUmfJa4KWa9PNkV1akIaEQGPNT3wljyJqn/eTrSm20YZwIaYRZ/Xw
         W4KeQTzKJxFgq1rP6+bmdSdrKOkapLxW3JREc/9e6L3lrbhMI7ZbplofQu6obKAB3Qnb
         nM8w==
X-Gm-Message-State: AC+VfDylbUOBpWNDI3UBmFG+huEmyjt5Ic81+N00hSrrmjOtwKf5TczS
        yCJzM9tpMdM3ziipZX8VZXfhCA==
X-Google-Smtp-Source: ACHHUZ5ecctufjEICHVJOxqbmGFp4cMb86II1wutT7aAwcq/GT4AF70E5eF22KgMKCTBhO6z0IHKaA==
X-Received: by 2002:a17:907:1c84:b0:974:32e:7de9 with SMTP id nb4-20020a1709071c8400b00974032e7de9mr5775337ejc.56.1685521159179;
        Wed, 31 May 2023 01:19:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a6-20020a170906244600b00965b416585bsm8528500ejb.118.2023.05.31.01.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 01:19:18 -0700 (PDT)
Message-ID: <4fcbb3b7-ed44-d8e6-a601-e3e957c55ebf@linaro.org>
Date:   Wed, 31 May 2023 10:19:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 01/15] dt-bindings: PCI: qcom: Fix sc8180x clocks and
 interrupts
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530162454.51708-1-vkoul@kernel.org>
 <20230530162454.51708-2-vkoul@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530162454.51708-2-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 18:24, Vinod Koul wrote:
> Commit 45a3ec891370 ("PCI: qcom: Add sc8180x compatible") added sc8180x
> compatible and commit 075a9d55932e ("dt-bindings: PCI: qcom: Convert to
> YAML") converted the description to yaml
> 
> But there are still some errors specific to sc8180x which this change
> attempts to fix. The clocks and resets for sc8180 pcie controller are
> different so need to be documented separately

I don't get what's the error here to fix. The clocks you list are
already there as part of oneOf.

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 29 ++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4e554..40a1f451a3d3 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -476,6 +476,33 @@ allOf:
>            items:
>              - const: pci # PCIe core reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sc8180x
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 8
> +          maxItems: 8
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ref # REFERENCE clock
> +            - const: tbu # PCIe TBU clock
> +        resets:
> +          maxItems: 1
> +        reset-names:
> +          items:
> +            - const: pci # PCIe core reset
> +
>    - if:
>        properties:
>          compatible:
> @@ -524,7 +551,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,pcie-sc8180x
>                - qcom,pcie-sm8150
>                - qcom,pcie-sm8250
>      then:
> @@ -749,6 +775,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,pcie-sa8540p
> +              - qcom,pcie-sc8180x
>                - qcom,pcie-sc8280xp
>      then:
>        required:

Best regards,
Krzysztof

