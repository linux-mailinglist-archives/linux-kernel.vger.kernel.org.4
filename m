Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C136362DE82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbiKQOoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240100AbiKQOnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:43:32 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED9397
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:43:29 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z24so2989064ljn.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQLQpf3kqVigsxlHZz3VInqB29DX3Of3V5vUpblQjaE=;
        b=cgEyuXJ9bSA2nbbeLhNB/uy9KIR0uK9QNQwKu5wOFqsIeCJ9+AwrtgI/d2KpiRUTs8
         GWR0arDbaBDl0MVo+Dtx+mM+bkRFgxla9SBM0YbFI/3nSOFb+8Is86Tw5fnv5gkSJ2Q0
         JLE142Ah2VMsEeKe+AwVz0lN65TV9i+LF9txiuORSY/fseVNcQq2GSMjPyvlATNAHPKF
         IC9nlrDeLffvuvallMwZZp1vqnYLr57l9yiD3i6+srDDJID4MPV0jwUDy1H5wA7tVctv
         ker2R3Gq398hxtYIKX8wRSWHsQgY2FrPFCBqmbLxkyggfbkIRr+TuN0bnB/iIfOAynYj
         SGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQLQpf3kqVigsxlHZz3VInqB29DX3Of3V5vUpblQjaE=;
        b=AOmqhStdJfu7ti+Fn6QhoXR9A0lGb+Q3IPDTs+3JjmOjITnH0IfKJUXiCf5kdEJXOH
         4Xv+HWqeM5KB8mWNgeniYU0hgD6/UkGQoF1v8bzRdwT39C1laSj2O+3GQ7RGvFuqB0cs
         tADz7jWzYpuatunDqZsfsZSQr8DvGzSVl4kUPmyr6fZ7IDi/B4kfRsL44uMVcorRLorV
         4nQwHp+K+/2aG5GsJdtOdQLQiCU9DVs92nOQZfMjPZVPhoIrn67jf0V0CMMXw7QMy//F
         JOA3ICUJ/J58AJnC6t+m6meIk7pGQ2djLyz/ly5pPXmViDbg8+kCUBeeK5Nq3V8V6bfF
         dr1A==
X-Gm-Message-State: ANoB5pnt1X5yRbWzG3705GG3ZiVqVuHWhMQn4y0zHAj4fJsEYWcaROCa
        zP276PnDfH9lr/FfjepdNM0zdw==
X-Google-Smtp-Source: AA0mqf6KhLVQFBsdyDJL/myJ+eCpADXPNWOU/Inb33v6Vdhy3hm3CLZ95yi7AADthY2wEk9Y5+1DFA==
X-Received: by 2002:a2e:9456:0:b0:278:eef5:8d19 with SMTP id o22-20020a2e9456000000b00278eef58d19mr1023924ljh.429.1668696207539;
        Thu, 17 Nov 2022 06:43:27 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k20-20020ac24f14000000b0049ad315cfc3sm176956lfr.162.2022.11.17.06.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 06:43:27 -0800 (PST)
Message-ID: <2cfdec0d-4c03-012a-df29-6d92cd87bab5@linaro.org>
Date:   Thu, 17 Nov 2022 15:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/6] dt-bindings: qcom: geni-se: document I2C Master Hub
 wrapper variant
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v1-0-64449106a148@linaro.org>
 <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v1-1-64449106a148@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-i2c-master-hub-v1-1-64449106a148@linaro.org>
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

On 16/11/2022 11:21, Neil Armstrong wrote:
> The I2C Master Hub is a stripped down version of the GENI Serial Engine
> QUP Wrapper Controller but only supporting I2C serial engines without
> DMA support.
> 
> This documents the variant compatible and forbids UART and SPI sub-nodes,

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> and removes requirement for the Master AHB clock and iommu property.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml | 43 ++++++++++++++++++----
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> index 2bf5293fc995..6657e74df629 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
> @@ -21,20 +21,15 @@ properties:
>    compatible:
>      enum:
>        - qcom,geni-se-qup
> +      - qcom,geni-se-i2c-master-hub
>  
>    reg:
>      description: QUP wrapper common register address and length.
>      maxItems: 1
>  
> -  clock-names:
> -    items:
> -      - const: m-ahb
> -      - const: s-ahb
> +  clock-names: true

minItems: 1, maxItems: 2, instead.

>  
> -  clocks:
> -    items:
> -      - description: Master AHB Clock
> -      - description: Slave AHB Clock
> +  clocks: true

minItems: 1, maxItems: 2, instead.

>  
>    "#address-cells":
>      const: 2
> @@ -81,6 +76,38 @@ patternProperties:
>      description: GENI Serial Engine based UART Controller.
>      $ref: /schemas/serial/qcom,serial-geni-qcom.yaml#
>  
> +if:

Put it under allOf, to avoid re-indenting when number of if's grow.

> +  properties:
> +    compatible:
> +      contains:
> +        const: qcom,geni-se-i2c-master-hub
> 

Best regards,
Krzysztof

