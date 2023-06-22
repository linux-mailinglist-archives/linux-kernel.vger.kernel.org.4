Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C42739D9E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjFVJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjFVJqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:46:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929647EF4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:36:19 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f85966b0f2so8709247e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687426517; x=1690018517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67rZhM+QgwlGcwzKaUtEZvhrSEWAZymRijH2qdW1fCY=;
        b=ABukT/hXnLXzfmBimx2rtbk7pHi+f71gjPnXfk1VSw0/duxQXGAwZPlqrZBnZQJL2w
         tudcPdmJ4LYcwJBSst03606AhFcKsQ0nt9Hmhaa5wZ8F7MPoP8VaiqS+imA40Cm9bBbS
         pqi9czxZzAzh4efOO+QAQkudKqtCztFpJqfZNkJg/axsX4slVSp2/AMe70Ah5e6wemfG
         SAvMOeDR4DDMvk1fK/tNdWn1gpDBmcyKypIb6ALCp8aU+KKiXIEDGxebW+6/RW22bJ+W
         2m/VkNhrgDkQ9i7d86ACzJFVu3d7x55CG7IshwMAxH9NeFzxL15w4VGkn5+vsg9QzIP6
         +yUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426517; x=1690018517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67rZhM+QgwlGcwzKaUtEZvhrSEWAZymRijH2qdW1fCY=;
        b=hfZo/dI9ZLYE0paBoWud2S6NQW4u8O/UcOXStsFpKKiF9AQ+2uVEA30m9rY4cxNNV5
         o8ssSF0U35N4xE13PQ+Fk+h8BevGNzZDe8w7Q+adqu/fECYxK3hV7MZn54LZ0SQd3gez
         Y4JufHrKRBuK775Pc77/sDSeKiha5SZf6n1CgZNcUmQC5eI9lD5uVnVKakqI1lz6b+bw
         Nv6vwMnhkoF72uGdtetXoFAwNvMoehXQOrNhhlwO6tBDtUIYko91bS2AREl+jAuQaXBt
         O2n1+eKcx/smDc5hzr0gJaTA7TwJ5Q3cKKgyvWrRjt+WriuD9BVsezaiSUJoRTTv5z6v
         S5LA==
X-Gm-Message-State: AC+VfDyWqFRcXAtDt4TCJzSGGXBA0ntxgfT8gh8sIdwhv8IJItVBi2G5
        Uqz02sFcFnFx4lTNn2Vs2KaloQ==
X-Google-Smtp-Source: ACHHUZ5o+RGBr/+jzq/74qzOacJvvuKkpMqh3zxtBxN0mPWEyXT+1kELL96iG2csgRid0klpZxkw1w==
X-Received: by 2002:ac2:464d:0:b0:4f8:6e6e:3f36 with SMTP id s13-20020ac2464d000000b004f86e6e3f36mr7871392lfo.4.1687426516860;
        Thu, 22 Jun 2023 02:35:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id t15-20020ac24c0f000000b004f625831d85sm1053448lfq.126.2023.06.22.02.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:35:16 -0700 (PDT)
Message-ID: <332770c4-1f2c-0bf5-c75e-192120ef77e2@linaro.org>
Date:   Thu, 22 Jun 2023 11:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 4/6] iommu/qcom: Index contexts by asid number to allow
 asid 0
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, luca@z3ntu.xyz, dmitry.baryshkov@linaro.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-5-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622092742.74819-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.06.2023 11:27, AngeloGioacchino Del Regno wrote:
> This driver was indexing the contexts by asid-1, which is probably
> done under the assumption that the first ASID is always 1.
> Unfortunately this is not always true: at least for MSM8956 and
> MSM8976's GPU IOMMU, the gpu_user context's ASID number is zero.
> To allow using a zero asid number, index the contexts by `asid`
> instead of by `asid - 1`.
> 
> While at it, also enhance human readability by renaming the
> `num_ctxs` member of struct qcom_iommu_dev to `max_asid`.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index f1bd7c035db8..9786fd094e7d 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -51,8 +51,8 @@ struct qcom_iommu_dev {
>  	struct clk_bulk_data clks[CLK_NUM];
>  	void __iomem		*local_base;
>  	u32			 sec_id;
> -	u8			 num_ctxs;
> -	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid-1 */
> +	u8			 max_asid;
> +	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
>  };
>  
>  struct qcom_iommu_ctx {
> @@ -94,7 +94,7 @@ static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid
>  	struct qcom_iommu_dev *qcom_iommu = d->iommu;
>  	if (!qcom_iommu)
>  		return NULL;
> -	return qcom_iommu->ctxs[asid - 1];
> +	return qcom_iommu->ctxs[asid];
>  }
>  
>  static inline void
> @@ -534,12 +534,10 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	qcom_iommu = platform_get_drvdata(iommu_pdev);
>  
>  	/* make sure the asid specified in dt is valid, so we don't have
> -	 * to sanity check this elsewhere, since 'asid - 1' is used to
> -	 * index into qcom_iommu->ctxs:
> +	 * to sanity check this elsewhere:
>  	 */
> -	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> -	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
> +	if (WARN_ON(asid > qcom_iommu->max_asid) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid] == NULL)) {
>  		put_device(&iommu_pdev->dev);
>  		return -EINVAL;
>  	}
> @@ -696,7 +694,7 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
>  
>  	dev_dbg(dev, "found asid %u\n", ctx->asid);
>  
> -	qcom_iommu->ctxs[ctx->asid - 1] = ctx;
> +	qcom_iommu->ctxs[ctx->asid] = ctx;
>  
>  	return 0;
>  }
> @@ -708,7 +706,7 @@ static void qcom_iommu_ctx_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> -	qcom_iommu->ctxs[ctx->asid - 1] = NULL;
> +	qcom_iommu->ctxs[ctx->asid] = NULL;
>  }
>  
>  static const struct of_device_id ctx_of_match[] = {
> @@ -755,11 +753,11 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
>  	for_each_child_of_node(dev->of_node, child)
>  		max_asid = max(max_asid, get_asid(child));
>  
> -	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid),
> +	qcom_iommu = devm_kzalloc(dev, struct_size(qcom_iommu, ctxs, max_asid + 1),
>  				  GFP_KERNEL);
>  	if (!qcom_iommu)
>  		return -ENOMEM;
> -	qcom_iommu->num_ctxs = max_asid;
> +	qcom_iommu->max_asid = max_asid;
>  	qcom_iommu->dev = dev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
