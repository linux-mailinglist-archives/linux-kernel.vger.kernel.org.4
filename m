Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921247042B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEPBQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEPBQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:16:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37465FF9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:16:29 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2ac79d4858dso141032901fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684199788; x=1686791788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhKJ9K8sXPUHNu8qgCXbMx2ph04nrQv3JOCNnJ3r0tc=;
        b=Zin4aDiiD4dr5lMMf7axMkePl2KMRXRtEnqdqfxlifKpRjXquUxHpqqEL814lrzSYs
         7Pg+/C1a1TOGSIgSbEavUT9A/qURTYxy98faWggMB1v77BiQv9cReT3igi6XZviir7NO
         bPyV4MvvzMqIeqa/cy7d0IipDRz9Nb9iZ6XSwQ62gWdis8nipTDQgat4LCLmhbmlUsYU
         RjML3cBiFSb25Qcpcqye1jWvh4b8ngCTPvb15CmVSuNGH3wFznjQ70tYL7q39Dk5AOjM
         H89CS17IysRyxxB3TE268OPO/7sKnr8GJZR56JgGGoFMVDJ3aBZGo0yIrj8nhbUUo4mM
         YxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684199788; x=1686791788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhKJ9K8sXPUHNu8qgCXbMx2ph04nrQv3JOCNnJ3r0tc=;
        b=FKWw+WpKLm9w3kd4xSot8HajeEwsUo6FRjwyPc0VeRtyqfKYOrQJbBvCNtH2g0t5vR
         qAIGyekVuTFHYDaNKtTOps067XAUJBi5BG3csoEw9EnnHNFuEeEBW8JI1S4eF/BuCNe1
         coMFTMAetqISvgonwNNMqnbHhQBs/mArOYoUZkEiqHtTc4zqRLjLGNkEXSQrkOaihlze
         20X6+E9zmoovI3txQ95Op++aolCYkYPOCKJDw/3ScMrqvJT/km1fFNS685KklAOCJFUR
         YtTWY2ZYBWG+y85NCx+0lIMO8I641/k7K2AAwVr0JtErr0JijCEcurkUVzaZpF/VyKcy
         Bu3g==
X-Gm-Message-State: AC+VfDxf2D0qJINf1TuhKofJpoiFyXK4zFXEEZ2AROW3rhWNaQDWw5zC
        um/Soaw+fjEDmSpM6JnSJSYmTQ==
X-Google-Smtp-Source: ACHHUZ7FF4CwV/cjiS18zH9a4OjJ2CQEvHfXtMS7xd3A0Bop7xeqC+uSDo35dCJW1pJ+xQThi+u7Sg==
X-Received: by 2002:a05:651c:212:b0:2ac:8c5e:e151 with SMTP id y18-20020a05651c021200b002ac8c5ee151mr7562822ljn.31.1684199787856;
        Mon, 15 May 2023 18:16:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id h4-20020a2e9ec4000000b002a8c32fd2f3sm3989061ljk.89.2023.05.15.18.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:16:27 -0700 (PDT)
Message-ID: <4e62a790-192c-90b6-76dc-193dc52cc996@linaro.org>
Date:   Tue, 16 May 2023 03:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Lepton Wu <lepton@chromium.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230511145908.597683-1-robdclark@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230511145908.597683-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11.05.2023 16:59, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
> 
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
> Suggested-by: Lepton Wu <lepton@chromium.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..66e191773099 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -496,20 +496,21 @@ static const struct qcom_smmu_match_data qcom_smmu_500_impl0_data = {
>  /*
>   * Do not add any more qcom,SOC-smmu-500 entries to this list, unless they need
>   * special handling and can not be covered by the qcom,smmu-500 entry.
>   */
>  static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,msm8996-smmu-v2", .data = &msm8996_smmu_data },
>  	{ .compatible = "qcom,msm8998-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,qcm2290-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,qdu1000-smmu-500", .data = &qcom_smmu_500_impl0_data  },
>  	{ .compatible = "qcom,sc7180-smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	{ .compatible = "qcom,sc7180-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sc7280-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8180x-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sc8280xp-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sdm630-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sdm845-smmu-500", .data = &sdm845_smmu_500_data },
>  	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
>  	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
> @@ -540,12 +541,18 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu)
>  		/* Match platform for ACPI boot */
>  		if (acpi_match_platform_list(qcom_acpi_platlist) >= 0)
>  			return qcom_smmu_create(smmu, &qcom_smmu_500_impl0_data);
>  	}
>  #endif
>  
>  	match = of_match_node(qcom_smmu_impl_of_match, np);
>  	if (match)
>  		return qcom_smmu_create(smmu, match->data);
>  
> +	/* If you hit this WARN_ON() you are missing an entry in the
> +	 * qcom_smmu_impl_of_match[] table, and GPU per-process page-
> +	 * tables will be broken.
> +	 */
Nit: I think people generally do
/*
 * 

but I'm not the maintainer

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: <stable@vger.kernel.org>

Konrad
> +	WARN_ON(of_device_is_compatible(np, "qcom,adreno-smmu"));
> +
>  	return smmu;
>  }
