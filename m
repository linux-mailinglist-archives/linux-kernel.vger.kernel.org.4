Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F3D6AE763
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjCGQzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCGQyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:54:40 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620729CFE7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:50:36 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id h3so13799583lja.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rYssbtmmhgu9B9C9m6GQuu1pkArWLaKZR93g4QNlPz8=;
        b=jUBJM89bQJ0VbXpwq/eE02FtMo8LTzyVZHHsxIsuWPmKn+Ke0/rpLCQcQmRvcs2YSd
         M1bymcSND1h3e3cNiNPfSkAHIZtvuPYwp5mgMHwCS+hGd6dD5Tvy+yFasgzOxp+DZBGZ
         4G7eBEuWBdIzklVLE1MNuI5I6YM9XSA/J0PJG1i3u6oj1B1IqlOmPAsVoL3YrHsCVNrB
         yzPDhVKkW338MWcwDIr9P9kB+7byILHIPGAyatg03pt1LX3TkXQzi8gldu/2uKRuzLO2
         //aLqJfC0vp+zYzMA+SK+/3/E/0SjH0eqJ0XIYl94artfPeY7GeL3aEFDoWptvWbULVK
         7JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207832;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYssbtmmhgu9B9C9m6GQuu1pkArWLaKZR93g4QNlPz8=;
        b=l8XC9HWJZ5XJaZnLRVKPNXs4EhwdrdlfYBUVn4MVn48gqU2tBDyDIvXNp1H+xJoEvq
         nAaA7+xpyG83yvAXfINqNIHkJdPL3PLFw6eQNMNlbcTYI/4nxWdmPTCSjf0PwPnfJ6rr
         Fgje7UXRYftBxt3hvYmMw4IXNWCH8WBmhAWs6JcrChcJsEpjJM7o38jFk9/9/5TnsX47
         yQI+WE1jWxQ2YLLoIA1gR6CxVa8XhJ5Y8MKMuRtdklLbbytjNEpw7pJObUNtfA4dloL/
         X8FkRrGOj7lZvhMYDE/hBoo4PXkPKy1d3tvyWd18iP/v2FjHpSDxwdh4V1xfHzMwBEdH
         QM1A==
X-Gm-Message-State: AO0yUKVo7oSGgXD7K49o9yboKAVKpiNvXCQnzSPe4cw/ZR4T6SQMcHVl
        F3NiBLh5D8k1xIXxfBGnNFgHYQ==
X-Google-Smtp-Source: AK7set/FOFnx34TmTCvs98ArnR9vbhwewn3n4P4va9WH3254HIa76G0ozUN8qX5nuN+io/E69nkoCw==
X-Received: by 2002:a2e:b0f6:0:b0:294:6e84:79bf with SMTP id h22-20020a2eb0f6000000b002946e8479bfmr4674994ljl.22.1678207831922;
        Tue, 07 Mar 2023 08:50:31 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id e30-20020a05651c039e00b002958c4e96fasm2236626ljp.3.2023.03.07.08.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:50:31 -0800 (PST)
Message-ID: <54615b1e-c452-7215-4aad-7a1c1f11aef5@linaro.org>
Date:   Tue, 7 Mar 2023 18:50:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 3/6] iommu/qcom: Properly reset the IOMMU context
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        marijn.suijten@somainline.org, kernel@collabora.com,
        luca@z3ntu.xyz, a39.skl@gmail.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20221115101122.155440-1-angelogioacchino.delregno@collabora.com>
 <20221115101122.155440-4-angelogioacchino.delregno@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115101122.155440-4-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 12:11, AngeloGioacchino Del Regno wrote:
> Avoid context faults by resetting the context(s) entirely at
> detach_dev() time and also do the same before programming the
> context for domain initialization.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Probably:
Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")

What causes context faults? Shouldn't the context be disabled once we 
write 0 to CB_SCTLR?

> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 491a8093f3d6..49f4308f1bd2 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -223,6 +223,20 @@ static irqreturn_t qcom_iommu_fault(int irq, void *dev)
>   	return IRQ_HANDLED;
>   }
>   
> +static void qcom_iommu_reset_ctx(struct qcom_iommu_ctx *ctx)
> +{
> +	iommu_writel(ctx, ARM_SMMU_CB_FAR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> +	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR1, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_PAR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_S1_MAIR0, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_TCR2, 0);
> +	iommu_writel(ctx, ARM_SMMU_CB_TCR, 0);
> +	iommu_writeq(ctx, ARM_SMMU_CB_TTBR0, 0);
> +	iommu_writeq(ctx, ARM_SMMU_CB_TTBR1, 0);
> +}
> +
>   static int qcom_iommu_init_domain(struct iommu_domain *domain,
>   				  struct qcom_iommu_dev *qcom_iommu,
>   				  struct device *dev)
> @@ -273,6 +287,8 @@ static int qcom_iommu_init_domain(struct iommu_domain *domain,
>   			ctx->secure_init = true;
>   		}
>   
> +		qcom_iommu_reset_ctx(ctx);

Is it enough to write 0 to ARM_SMMU_CB_SCTLR here instead of doing the 
full reset?

> +
>   		/* TTBRs */
>   		iommu_writeq(ctx, ARM_SMMU_CB_TTBR0,
>   				pgtbl_cfg.arm_lpae_s1_cfg.ttbr |
> @@ -401,8 +417,8 @@ static void qcom_iommu_detach_dev(struct iommu_domain *domain, struct device *de
>   	for (i = 0; i < fwspec->num_ids; i++) {
>   		struct qcom_iommu_ctx *ctx = to_ctx(qcom_domain, fwspec->ids[i]);
>   
> -		/* Disable the context bank: */
> -		iommu_writel(ctx, ARM_SMMU_CB_SCTLR, 0);
> +		/* Disable and reset the context bank */
> +		qcom_iommu_reset_ctx(ctx);
>   
>   		ctx->domain = NULL;
>   	}

-- 
With best wishes
Dmitry

