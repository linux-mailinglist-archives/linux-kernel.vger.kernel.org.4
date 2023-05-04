Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835E36F7149
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEDRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjEDRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:41:57 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657BF133
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:41:56 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso9501721fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683222114; x=1685814114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=79MOg7QbCHRbZVd2yVEk/t8BbXdEpJCqhPy1l88Ze6o=;
        b=WrS356SMAo46HY+ISN51yC+xVSCUXioS5qyyYwBRnIFtu7ynnJBKqSn2QvtL8zwmW8
         yrhXI/X1/HChLcDXRl3srNrMVHeG4Wt4fFeIQYZmXiKbsZ86s7HvY8Gk7g7pp9L7dQEx
         BmOkZfyOY1tZNOBaKnTGbiUhfPWZWAAmpLJiYxlfGhPO+1bf/nDi+kP9O6FRqSoG/7H8
         8SjzqZXZvf6TH1clb+HAVD2ZVAJ1bhYQ8s0g0LiOQrSIfcPRAygRC+6ufWGJk9g14jjl
         TmIGvkafcDKjHfLpE1AVmvaV3t8x1EgEjefdkZ7BTweV04BE48rOx61aESnuycdHgwOc
         wxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222114; x=1685814114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=79MOg7QbCHRbZVd2yVEk/t8BbXdEpJCqhPy1l88Ze6o=;
        b=cTZu4vIvkqZBqbEKj1NBHoSBHw6kIn0nTHWXED4hUwVwGeBX/NmMNtxh94RngFXA/k
         zOrLGv8MLO2uWYGh0d7HlkUKVgM97+B3Bk1zJRO5pO+nKCyIg0YS1dXDc7rWnrO+xxY/
         1Nr8/qtc/+KbmSAHx7iy4nBXNcvIG3QFXQeO1qQ7gvIHVSREppDRdpzC0oloa1OPwcHb
         JynU0gfTB1rseS04kTa7vAz/JEs7/+4KH/EMDHnm2Od/iRwu6yZe9Rof4H2ZJTyiw/K2
         RuxfedoxbvGy7bqiRM5/KYBB6Rr3Alj3m5Rikb3+HPTx8p7CqCCYH2i9FGQXb2knM9Rr
         V0zg==
X-Gm-Message-State: AC+VfDxTpMReNR+UHyo40pNUhbj6AN1jlAmzIXlMEei4LP4mz5u2ToRY
        ABzVGID/WYTQDABKc5xjxwMf7+2NSNVXtZl4u1A=
X-Google-Smtp-Source: ACHHUZ6RbSS1yohK8MisAsSW0zXZnlYws8g3m0szZIM5R4qggWj81HSXrdgWs5S78o7j/OVy2AcpKg==
X-Received: by 2002:a2e:83c8:0:b0:2ab:e50:315a with SMTP id s8-20020a2e83c8000000b002ab0e50315amr1040763ljh.51.1683222114606;
        Thu, 04 May 2023 10:41:54 -0700 (PDT)
Received: from [192.168.1.101] (abyl248.neoplus.adsl.tpnet.pl. [83.9.31.248])
        by smtp.gmail.com with ESMTPSA id h7-20020a2e3a07000000b002a7aefa4bf7sm6633903lja.53.2023.05.04.10.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:41:54 -0700 (PDT)
Message-ID: <db8ef06b-a729-a085-8671-2b4d99a8e2b2@linaro.org>
Date:   Thu, 4 May 2023 19:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Fix missing adreno_smmu's
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
References: <20230502160950.1758826-1-robdclark@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230502160950.1758826-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.05.2023 18:09, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When the special handling of qcom,adreno-smmu was moved into
> qcom_smmu_create(), it was overlooked that we didn't have all the
> required entries in qcom_smmu_impl_of_match.  So we stopped getting
> adreno_smmu_priv on sc7180, breaking per-process pgtables.
> 
> Fixes: 30b912a03d91 ("iommu/arm-smmu-qcom: Move the qcom,adreno-smmu check into qcom_smmu_create")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
I believe the issue here is the lack of qcom,sc7180-smmu-v2 instead.

qcom,adreno-smmu does not have to imply the "qcom smmu v2" impl

Konrad
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index d1b296b95c86..88c89424485b 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -512,20 +512,25 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>  	{ .compatible = "qcom,sm6115-smmu-500", .data = &qcom_smmu_500_impl0_data},
>  	{ .compatible = "qcom,sm6125-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm6350-smmu-v2", .data = &qcom_smmu_v2_data },
>  	{ .compatible = "qcom,sm6350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm6375-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8150-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8250-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8350-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,sm8450-smmu-500", .data = &qcom_smmu_500_impl0_data },
>  	{ .compatible = "qcom,smmu-500", .data = &qcom_smmu_500_impl0_data },
> +	/*
> +	 * Should come after the qcom,smmu-500 fallback so smmu-500 variants of
> +	 * adreno-smmu get qcom_adreno_smmu_500_impl:
> +	 */
> +	{ .compatible = "qcom,adreno-smmu", .data = &qcom_smmu_v2_data },
>  	{ }
>  };
>  
>  #ifdef CONFIG_ACPI
>  static struct acpi_platform_list qcom_acpi_platlist[] = {
>  	{ "LENOVO", "CB-01   ", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
>  	{ "QCOM  ", "QCOMEDK2", 0x8180, ACPI_SIG_IORT, equal, "QCOM SMMU" },
>  	{ }
>  };
>  #endif
