Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513FB739D96
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjFVJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFVJjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:39:55 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62D4C07
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:31:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b4619ef079so86224761fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687426276; x=1690018276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0su4etilG9DUxoAHiiXtsXNHxIThfP1qbA8hYKFV+4=;
        b=AS2CcnaQCTsVrrCP5p669RDfFRtDFV/9lb2w0L4BLRKxXV18Xc3VNg2lYDlEuB7T9x
         l1gLwir8dhDeVU7ndAVojN/mL8BTUzIw8ScyC0s85MB7GbttatCo5351X4yjRrLjWUwW
         d9KHT2XwtZpvjkSBM+29pxGLkMdV9WCCVt9sk8XhHy9J9gCfHKRpSYQP6/O/R6pfjqdO
         Kl0EL4KoAaf6EQ+6mPEYXd79ybOeoHagiHjto/RweaYmozNx3Gz8StgudIO/GiOdGzg7
         gtYt3geovHMSb55bhHQCEAFF80ILpmAq3HKMrxQSr6kTmcs1NYrhF1aGhrzi4l7tqKFv
         xuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687426276; x=1690018276;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0su4etilG9DUxoAHiiXtsXNHxIThfP1qbA8hYKFV+4=;
        b=Yafpb1j67Pf85v5+hY65Vrx+yfFE2hoclqdMPCSsQhAKV2+i/jMhzuH7vROZAVRiGm
         NX9uvd/DlwR16VYbxCHpOiWhL5JoHBF66+8Dv3qwwUgnYFeH7DEO/GYcZaeVYIOMmsYB
         vpziUHFVsbpzCiD8mKlYl6jiXmLSDA86jscB/AA1mg8r/GGfni/cF5hJE6oLHpw+jaE1
         a9Vtn2qbDgiw+9pAdOxlFshjiMqY9e4/AaTKG23OxHCjxQLH28jD6TN+FuTUYsuBZFId
         ByemFXGMn600tqNzwy5jMpa3kpmi41m8jLlBJlLAIJBW+oB2iAbRNXdH7UDAOBekka79
         cqLA==
X-Gm-Message-State: AC+VfDwAHKMKnTcm51VfZNkbVUxjpP/MOsV7c0ioyYGMI0YyZMyVC0SR
        Lw+ryXnAE9RXUYQcLFoopmEYkg==
X-Google-Smtp-Source: ACHHUZ71vwoNNEacKd0FTRQZr1ek70tsPteUvGY5LcMuqNFwVZ2JS6uYFjlBXTUj1lQSIEg5pD3i+g==
X-Received: by 2002:a2e:98cf:0:b0:2b5:1b80:264b with SMTP id s15-20020a2e98cf000000b002b51b80264bmr6153288ljj.12.1687426276202;
        Thu, 22 Jun 2023 02:31:16 -0700 (PDT)
Received: from [192.168.1.101] (abyl165.neoplus.adsl.tpnet.pl. [83.9.31.165])
        by smtp.gmail.com with ESMTPSA id x10-20020a2e880a000000b002b2255c4950sm1240578ljh.41.2023.06.22.02.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 02:31:15 -0700 (PDT)
Message-ID: <0fc42dbb-3b23-70d2-b18e-92424e04418f@linaro.org>
Date:   Thu, 22 Jun 2023 11:31:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/6] iommu/qcom: Use the asid read from device-tree if
 specified
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, luca@z3ntu.xyz, dmitry.baryshkov@linaro.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, robdclark@gmail.com,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
        Marijn Suijten <marijn.suijten@somainline.org>
References: <20230622092742.74819-1-angelogioacchino.delregno@collabora.com>
 <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230622092742.74819-3-angelogioacchino.delregno@collabora.com>
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
> As specified in this driver, the context banks are 0x1000 apart but
> on some SoCs the context number does not necessarily match this
> logic, hence we end up using the wrong ASID: keeping in mind that
> this IOMMU implementation relies heavily on SCM (TZ) calls, it is
> mandatory that we communicate the right context number.
> 
> Since this is all about how context banks are mapped in firmware,
> which may be board dependent (as a different firmware version may
> eventually change the expected context bank numbers), introduce a
> new property "qcom,ctx-asid": when found, the ASID will be forced
> as read from the devicetree.
> 
> When "qcom,ctx-asid" is not found, this driver retains the previous
> behavior as to avoid breaking older devicetrees or systems that do
> not require forcing ASID numbers.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> [Marijn: Rebased over next-20221111]
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index a503ed758ec3..8face57c4180 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -531,7 +531,8 @@ static int qcom_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  	 * index into qcom_iommu->ctxs:
>  	 */
>  	if (WARN_ON(asid < 1) ||
> -	    WARN_ON(asid > qcom_iommu->num_ctxs)) {
> +	    WARN_ON(asid > qcom_iommu->num_ctxs) ||
> +	    WARN_ON(qcom_iommu->ctxs[asid - 1] == NULL)) {
>  		put_device(&iommu_pdev->dev);
>  		return -EINVAL;
>  	}
> @@ -617,7 +618,8 @@ static int qcom_iommu_sec_ptbl_init(struct device *dev)
>  
>  static int get_asid(const struct device_node *np)
>  {
> -	u32 reg;
> +	u32 reg, val;
> +	int asid;
>  
>  	/* read the "reg" property directly to get the relative address
>  	 * of the context bank, and calculate the asid from that:
> @@ -625,7 +627,17 @@ static int get_asid(const struct device_node *np)
>  	if (of_property_read_u32_index(np, "reg", 0, &reg))
>  		return -ENODEV;
>  
> -	return reg / 0x1000;      /* context banks are 0x1000 apart */
> +	/*
> +	 * Context banks are 0x1000 apart but, in some cases, the ASID
> +	 * number doesn't match to this logic and needs to be passed
> +	 * from the DT configuration explicitly.
> +	 */
> +	if (!of_property_read_u32(np, "qcom,ctx-asid", &val))
> +		asid = val;
> +	else
> +		asid = reg / 0x1000;
> +
> +	return asid;
>  }
>  
>  static int qcom_iommu_ctx_probe(struct platform_device *pdev)
