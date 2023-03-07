Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5716AE770
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjCGQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCGQ5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:57:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23D987355
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:53:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s20so17900322lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678208002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y08XOal2sgn9w+oPn6eHEeifVAZN/V1k1ETzFCvtzUw=;
        b=DmSXjgGrqTSxm9a6f5KXrU6uCRcQDbSZYnralTMu1sG9TkN3d7E8YwHm2nS/EJcKFL
         ix0+um5qTzy5d7M/8kJVbaHOe3vtf5C/0gn2gmz2AWk2FhnbyzolLSgbeUmLHgv4aV+a
         Pab5zT9nDYcf8rax2Gvy5KtZtYR2W0rep9QQ0UCDqg7n4qL7mUjaBsivKYeLyw602Au0
         Cgehi2m8L1PpuPp3edK7lHhQvKGqhjfS6Ih/KBykKPdUW9YWe8CYRAxsK5cwITPN4+70
         OKBq0GhHFS4szdGs9yPSVzH1ABwDzpeFPPytklhMwjliaAkUAWetTpxFJWo9fhCad+MI
         EcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678208002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y08XOal2sgn9w+oPn6eHEeifVAZN/V1k1ETzFCvtzUw=;
        b=rwcIwyW+VXBmZEZK0AxwH8XuqgiTCTI6onOoDlot7AM43CEeNEzubFwvApON4zy7Bb
         dH0405+MRHVjJrk1ZQRNbLnUAExxrglvka/rTpZsvnjCCrY5naBQp094cw8lHkDqFZqJ
         JLiL3wqcN26y6JKFnctbtwPUBJgQKx55wWnBracxh09dtwhJOG4AyECo89N38tmGgjbG
         aLCxGxDktxyuW8kxHcFuwT1H+7vjzPxoeXAncwJU4djqRgMVFkaxea59+d9jrAZ6qEzM
         0Z+xvZGUoETuUK9L+8NVs8c3dn4HgPj2N8DhxYmVOrOiUYMuwmmD4GEJcBLOb9+FBS/d
         hOGA==
X-Gm-Message-State: AO0yUKXrfCKXGW8WVU3fYVgrYzvfXPOadbbPpnv+ZIzvzaNtzhI4PN/W
        e/H9OkbNEvrpqAbokbUvGvEFDA==
X-Google-Smtp-Source: AK7set/TMsQfD3SSttUjeT2HgdBvrTfvMnAChaUCUF1G6wdV0NzcJSMh82qkk3rYfvqwTuFoI+Ldjw==
X-Received: by 2002:ac2:5096:0:b0:4b9:a91c:b0c9 with SMTP id f22-20020ac25096000000b004b9a91cb0c9mr3972936lfm.7.1678208002180;
        Tue, 07 Mar 2023 08:53:22 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u3-20020a056512094300b004d7d13387b5sm2077894lft.116.2023.03.07.08.53.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:53:21 -0800 (PST)
Message-ID: <8093d73c-aa26-65b0-529a-c7b482b315cb@linaro.org>
Date:   Tue, 7 Mar 2023 18:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 4/6] iommu/qcom: Index contexts by asid number to allow
 asid 0
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
 <20221115101122.155440-5-angelogioacchino.delregno@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115101122.155440-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 12:11, AngeloGioacchino Del Regno wrote:
> This driver was indexing the contexts by asid-1, which is probably
> done under the assumption that the first ASID is always 1.
> 
> Unfortunately this is not always true: at least for MSM8956 and
> MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
> To allow using a zero asid number, index the contexts by `asid`
> instead of by `asid - 1`.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index 49f4308f1bd2..94f51cafee17 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -52,7 +52,7 @@ struct qcom_iommu_dev {
>   	void __iomem		*local_base;
>   	u32			 sec_id;
>   	u8			 num_ctxs;
> -	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
> +	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
>   };
>   
>   struct qcom_iommu_ctx {
> @@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
>   	struct qcom_iommu_dev *qcom_iommu = d->iommu;
>   	if (!qcom_iommu)
>   		return NULL;
> -	return qcom_iommu->ctxs[asid - 1];
> +	return qcom_iommu->ctxs[asid];
>   }
>   
>   static inline void
> @@ -563,12 +563,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	qcom_iommu = platform_get_drvdata(iommu_pdev);
>   
>   	/* make sure the asid specified in dt is valid, so we don't have
> -	 * to sanity check this elsewhere, since 'asid - 1' is used to
> -	 * index into qcom_iommu->ctxs:
> +	 * to sanity check this elsewhere:
>   	 */
> -	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> -	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
> +	if (WARN_ON(asid >= qcom_iommu->num_ctxs) ||

Could you please change qcom_iommu to store max_asid rather than 
num_ctxs. This piece becomes logical then.

Looks good to me otherwise.

> +	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
>   		put_device(&iommu_pdev->dev);
>   		return -EINVAL;
>   	}
> @@ -726,7 +724,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>   
>   	dev_dbg(dev, "found asid %u\n", ctx->asid);
>   
> -	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
> +	qcom_iommu->ctxs[ctx->asid] = ctx;
>   
>   	return 0;
>   }
> @@ -738,7 +736,7 @@ static int qcom_iommu_ctx_remove(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, NULL);
>   
> -	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
> +	qcom_iommu->ctxs[ctx->asid] = NULL;
>   
>   	return 0;
>   }
> @@ -779,7 +777,7 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>   	struct device *dev = &pdev->dev;
>   	struct resource *res;
>   	struct clk *clk;
> -	int ret, max_asid = 0;
> +	int ret, num_ctxs, max_asid = 0;
>   
>   	/* find the max asid (which is 1:1 to ctx bank idx), so we know how
>   	 * many child ctx devices we have:
> @@ -787,11 +785,13 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>   	for_each_child_of_node(dev->of_node, child)
>   		max_asid = max(max_asid, get_asid(child));
>   
> -	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
> +	num_ctxs = max_asid + 1;
> +
> +	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, num_ctxs),
>   				  GFP_KERNEL);
>   	if (!qcom_iommu)
>   		return -ENOMEM;
> -	qcom_iommu->num_ctxs = max_asid;
> +	qcom_iommu->num_ctxs = num_ctxs;
>   	qcom_iommu->dev = dev;
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

-- 
With best wishes
Dmitry

