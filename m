Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D016CFDCC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjC3ILy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbjC3ILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:11:40 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF27A9B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:21 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k37so23521431lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyJIgsUOOOCRdd0ubh8HtsfsGd6xZNvYXX0CDtJnD9k=;
        b=iryJXA+4LjPh0/+Ka19xyb/tnSFLlemtsy53TqXrlZkX9Fbz4o5c6AfktAlgQ3aFxD
         rWWxuovYFK42P1nSKIwZR3GndO4MOPd8a8tySxM9iHUMI3hWk5ER8wjLwq9vI391Pii2
         G5DQaS4uRsxcTxp9dqu+xKFfk3KYbM8Tbp3VrJChTbT1lwCvOyEAr3R1pXByIfgXJGZB
         eOKg8gvShvRKOjSXoTgrrzWorrXSWcGSCGcotoIik4WE1GHA/wi3z9WX+wpUaSHFexfA
         xJ/HQImqTTxpEpeHVxX7IQaf2SwsRIV3OHhlMSaE82kji5EPvb29eaUFGweFmIfjiaqb
         1GrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163879;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyJIgsUOOOCRdd0ubh8HtsfsGd6xZNvYXX0CDtJnD9k=;
        b=6ulr2BMrpxYCYP2JtiIVFhPPKIUATRq+jU5n4Lt/e00G0EiC8QR2SMx6h6ideXrykj
         oJqplaKQF9o7A2D28EC3SkCmTrjBZhQV639b8uMcNkrOYq/8wumzss+IagsMKD4LTozw
         drHj3KSJ9fsD6Q0UpPZ9CQtFrTxNDpcXHCF4qtZhSPv6ibWqTkUiE9mrJH3U5TemTiDU
         z3LdRTuB6i5AXEIEGMUM40XagUV1EvGXPlYDZMDt/tP0oqz7UWaGifopXt8Tsk+XUDae
         t/anlDj2HojquAbyZEDaWyUO2ACLC+pWFI29AFBcGyIumLtNBbZMXYkWyFuw3PtI9eW8
         kszw==
X-Gm-Message-State: AAQBX9fuLrmDGQd4cOraSMxYqnVXlIk3jgTrK8QcOQEEA8PWOEZpKT0x
        TgjCdWS7z/aFWUVih8+CnzCl4Q==
X-Google-Smtp-Source: AKy350bCaP/GZdqKBobADkm5Qp009Tut0mPKaKkQmqDmVEDDdPujZGvxE8oBpNFbe1WRYwMZzcOCeg==
X-Received: by 2002:a05:6512:4ce:b0:4eb:1606:48e0 with SMTP id w14-20020a05651204ce00b004eb160648e0mr3046900lfq.27.1680163879659;
        Thu, 30 Mar 2023 01:11:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q4-20020ac25284000000b004e1b880ba20sm5787149lfm.292.2023.03.30.01.11.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:11:19 -0700 (PDT)
Message-ID: <76982d25-cba5-2a18-387f-b1735eef21fe@linaro.org>
Date:   Thu, 30 Mar 2023 10:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/9] dt-bindings: dma: Add support for SM6115 and
 QCM2290 SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
References: <20230328092815.292665-1-bhupesh.sharma@linaro.org>
 <20230328092815.292665-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328092815.292665-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 11:28, Bhupesh Sharma wrote:
> Add new compatible for BAM DMA engine version v1.7.4 which is
> found on Qualcomm SM6115 and QCM2290 SoCs. Since its very similar
> to v1.7.0 used on SM8150 like SoCs, mark the comptible scheme
> accordingly.
> 
> While at it, also update qcom,bam-dma bindings to add comments
> which describe the BAM DMA versions used in SM8150 and SM8250 SoCs.
> This provides an easy reference for identifying the actual BAM DMA
> version available on Qualcomm SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  .../devicetree/bindings/dma/qcom,bam-dma.yaml | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> index f1ddcf672261..624208d20a34 100644
> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> @@ -15,13 +15,21 @@ allOf:
>  
>  properties:
>    compatible:
> -    enum:
> -        # APQ8064, IPQ8064 and MSM8960
> -      - qcom,bam-v1.3.0
> -        # MSM8974, APQ8074 and APQ8084
> -      - qcom,bam-v1.4.0
> -        # MSM8916 and SDM845
> -      - qcom,bam-v1.7.0
> +    oneOf:
> +      - items:

Drop "items". This is just an enum.

> +          - enum:
> +              # APQ8064, IPQ8064 and MSM8960
> +              - qcom,bam-v1.3.0

Best regards,
Krzysztof

