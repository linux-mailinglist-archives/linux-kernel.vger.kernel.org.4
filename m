Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E5622993
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiKILGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiKILGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:06:22 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B311AF04
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:06:20 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id r12so25127929lfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8RAA/2JkoTGNyapGh2q9Beoc29YH7Z+Geb7XyNgR3w=;
        b=lyopQQp5w5KQZH7Nz8eDdXrkpDTC7vbOta+N17UkBLBYc+WoSLfE91Tu/KsVyjQ1F0
         ClMnjiwGz69CwKtcHBMWNGIEkfFEYRAY/2J08vBQN66S2Jg2EloEU/+8qWXUoo5h9Q4+
         ULz0QPww49xX25fRPcr5URnv4bFT9rNbvtCu0HfTGbhT9UVJbzdaR2V5+Q/Fy3FK8s3L
         6oT4xn9/iPIXMUuaf/BqBEw3unC9biw56oemYB1dK0CZGSORq54DcbCjCE4vx+OuIUTH
         /QubpL38VRrY7cKVJTuts2m5Um0KrxV8wAkW7WxqzebqPYMuIzNJhnCf1VneV3HZQzbg
         3DAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8RAA/2JkoTGNyapGh2q9Beoc29YH7Z+Geb7XyNgR3w=;
        b=b3bvAY6FQenszLrrWEqAjfLEwvUBI+PsFj+KYu1gWJ/U8BHLdJ9iyo8+sQvF1+wKS9
         FHKHqyi0JAt2KFBk4Bq8doe9+aGUM9YXRO3P0v0TFSKdbwHjWTD50xB4Ck9q/Bp7vqm/
         k6w6EFPHogeyizDwYw7F7YmZxuC90STr+JeZZcriy3AFe4zAxwTuw5FZW+pY2X5Wld9w
         BmFw4+mqZxWgLvzRx4efTBIS8EwmamDsenfT51APxaHAjo4sieuprMfSTSMfVOkZyGAk
         wB9FYttRUNKugeDRCGRW4m0Zkvd1LYcbMDrVHrp6afBIQqzNtLaA+HlggXMDfybGZVeA
         KZHA==
X-Gm-Message-State: ACrzQf3wAVoMM3CrHDD4ZUhcMO4RanA+YDy3W7tUFfuVv1Brjj4zvynN
        IXVdzVAVqLMgzLsY2JUzXd3Y7w==
X-Google-Smtp-Source: AMsMyM7053TxcvJmmpde36tojf6fFo5DN2sahl4aQlEoMeEI0Z9V73RJn+15RtH4ssciWd+qNnylNQ==
X-Received: by 2002:a05:6512:2290:b0:4a2:abab:a37c with SMTP id f16-20020a056512229000b004a2ababa37cmr19576788lfu.609.1667991978941;
        Wed, 09 Nov 2022 03:06:18 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id br26-20020a056512401a00b00492c463526dsm2164102lfb.186.2022.11.09.03.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 03:06:18 -0800 (PST)
Message-ID: <1a5b2c83-dad2-3683-d374-d431d2049b67@linaro.org>
Date:   Wed, 9 Nov 2022 14:06:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RESEND PATCH] dt-bindings: PCI: qcom,pcie-ep: correct
 qcom,perst-regs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20221109105555.49557-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221109105555.49557-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 13:55, Krzysztof Kozlowski wrote:
> qcom,perst-regs is an phandle array of one item with a phandle and its
> arguments.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index 977c976ea799..5aa590957ee4 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -47,8 +47,10 @@ properties:
>                    enable registers
>       $ref: "/schemas/types.yaml#/definitions/phandle-array"
>       items:
> -      minItems: 3
> -      maxItems: 3
> +      - items:
> +          - description: Syscon to TCSR system registers
> +          - description: Perst enable offset
> +          - description: Perst separateion enable offset

typo: separation.

With that fixed:
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>   
>     interrupts:
>       items:

-- 
With best wishes
Dmitry

