Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 379236AE72F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCGQsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCGQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:47:45 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8643B90B49
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:44:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bi9so17929472lfb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678207463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jec/YJBntXF7NHKZEpXUh8NFkpnLW/c2Gz9ThFGLfeI=;
        b=yALxQvO1kpWHGTqDi79BR+MNsahqht3wIulp4TkS1Y3cePv4ifagWmVPPrr91B0DJo
         r7VUrNxduesgZRYY3coaKwPcDTrUolG4MOrq0CUtkvZZepc7ESZa/cWjaXWiltlFLIQW
         NZagCRNp/Fffr0RTKKfhrYH7AT4I656IozHBYE2q+M7+3QUgmlhANKtK+irhJAGyzl88
         QZW/2xh1Bhf7/DacvRbKqzFJXpnkdSxr33OMmmX8JpSXdRxAplM6fpkSt1XGl87QcZor
         WHl9US1cy0BPiZ1cqaH/+D9gKVkuM5n1DAI8AhAybxYjuewlUshjtZ5wqkcxQmdxApJP
         ZGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678207463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jec/YJBntXF7NHKZEpXUh8NFkpnLW/c2Gz9ThFGLfeI=;
        b=owqbiz63hXj2GIMjCTNXsGRO//4C2UChTtJNYNFUQA8DHS52RlsE3sV4blpAieSLYJ
         tU35GJk4NMgqmOSpZLvfBikZ88wyjw+coctz5xYiCeZTnerMcYgmJUtL9GjMnclpw3p9
         ay+CgYFbGWXEOCop+b12HWoTdfN+OPQDON++1Pu6G7CMTPmoWbgZeTnW4bmpTHwMDp06
         y+Vl5NwmjFyoL0u9bMcTmQPNieSWp68YcGW3YV3eAQ1Ohqc3afs9f9rwqc+T+tYHb9Ez
         qdgrQcD9EKUrO/PnOOy0gfIeC84il2bjgyGyie1t6Pp5Bv2sA55325v8UFMb05+j9wUj
         eWYA==
X-Gm-Message-State: AO0yUKVw6EGTB4Mq5/+m5BhboWoFv+JwISWuKveIGS23vArPCRrFaReA
        OOsdNpt6NIQhbPnC+sfJh/dB1g==
X-Google-Smtp-Source: AK7set9xq1ale7lPzAks3xELtyMniUfJLF87VVRCjXOCHjIAV+En8YZiKbkUEk3nXwfKUnI7dFfAjg==
X-Received: by 2002:ac2:54ad:0:b0:4de:f972:6b1 with SMTP id w13-20020ac254ad000000b004def97206b1mr5620200lfk.32.1678207462753;
        Tue, 07 Mar 2023 08:44:22 -0800 (PST)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id w17-20020ac25991000000b004db3e08c8a4sm2072851lfn.70.2023.03.07.08.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:44:22 -0800 (PST)
Message-ID: <12f0800c-beb3-6fdc-b743-8624f0d5d6ac@linaro.org>
Date:   Tue, 7 Mar 2023 18:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
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
 <20221115101122.155440-3-angelogioacchino.delregno@collabora.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221115101122.155440-3-angelogioacchino.delregno@collabora.com>
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
> As specified in this driver, the context banks are 0x1000 apart but
> on some SoCs the context number does not necessarily match this
> logic, hence we end up using the wrong ASID: keeping in mind that
> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
> mandatory that we communicate the right context number.
> 
> Since this is all about how context banks are mapped in firmware,
> which may be board dependent (as a different firmware version may
> eventually change the expected context bank numbers), introduce a
> new property "qcom,ctx-num": when found, the ASID will be forced
> as read from the devicetree.
> 
> When "qcom,ctx-num" is not found, this driver retains the previous
> behavior as to avoid breaking older devicetrees or systems that do
> not require forcing ASID numbers.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index bfd7b51eb5db..491a8093f3d6 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -551,7 +551,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>   	 * index into qcom_iommu->ctxs:
>   	 */
>   	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
> +	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {

Separate change in my opinion. Please split it to a separate patch with 
proper Fixes: tag.

>   		put_device(&iommu_pdev->dev);
>   		return -EINVAL;
>   	}
> @@ -638,7 +639,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>   
>   static int get_asid(const struct device_node *np)
>   {
> -	u32 reg;
> +	u32 reg, val;
> +	int asid;
>   
>   	/* read the "reg" property directly to get the relative address
>   	 * of the context bank, and calculate the asid from that:
> @@ -646,7 +648,17 @@ static int get_asid(const struct device_node *np)
>   	if (of_property_read_u32_index(np, "reg", 0, &reg))
>   		return -ENODEV;
>   
> -	return reg / 0x1000;      /* context banks are 0x1000 apart */
> +	/*
> +	 * Context banks are 0x1000 apart but, in some cases, the ASID
> +	 * number doesn't match to this logic and needs to be passed
> +	 * from the DT configuration explicitly.
> +	 */
> +	if (of_property_read_u32(np, "qcom,ctx-num", &val))
> +		asid = reg / 0x1000;
> +	else
> +		asid = val;

As a matter of preference (and logic) I'd have written that as:

if (!of_property_read(np, "qcom,ctx-num", &val))
     asid = val;
else
     asid = reg / 0x1000;

LGTM otherwise

> +
> +	return asid;
>   }
>   
>   static int qcom_iommu_ctx_probe(struct platform_device *pdev)

-- 
With best wishes
Dmitry

