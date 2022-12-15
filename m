Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F3A64DD5A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLOPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 10:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiLOPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 10:10:52 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358942A94B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:10:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g7so16138993lfv.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=petCtMT6h9gBTrPqM4wSXPuKYj7TltVBXvRJZq1Vl4A=;
        b=wxAxGHVqRSAWNyWfmK7P70u9SxsXJSH1r5fH7taXrSq+Rfu6lZsny9oPYIOPs8dfUI
         Au5EXXc7iW4c4KkVhWpjHc0/brvLjJ5i2+OG2OBKvIhvzP24oce4CpugSmER6l54FebS
         7W1RwoY/HEFeVHT0lyCyC2RZuR+XSsYgDB+sHt2UWdcBiKMWcT4IA6x6bvN72p29Hdgg
         krpL0Fr8Y+DroU3qi9xpQHisGZfOcIBstLZ2jXAClrCKcOPF+xZ3P9Qdx8c/UN7BJ78P
         VwJ0NyhO1g2gQjnvd6Tuc3hd/sY0p7OhuMy04LH2xjvkjAqomlNP/VnfiEL2sRdNMwMi
         Tbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=petCtMT6h9gBTrPqM4wSXPuKYj7TltVBXvRJZq1Vl4A=;
        b=QU4AUn4+B5QGEuJ8uNtRRusW7ZMvKYzQ6JW+c0QaD8n5YyapT9f87RrbiraOQnlbct
         wYeZCvQy8IYHd/v4sVUaPOfgUEZY+SiMi8eup3x25ZyNMVcwH8fecluzEEFRtgsiJ4mw
         A+si7rYIpatR/CIMa+pQPXYIIHieejFK4SDdNd0kxWgHMi4O4160jjnjT215ZkDMZQmN
         LVScapS2xIZrPpYL7G4XSMu6gxjA75UGQGGlFiQU9LEUd0zENMjnMrNL10MLWn5pjTcV
         OQGHrUoD8r24oX8eKqhFC9JyQRZ0HZT0fnb0GfGQPjVygWuc9GRoqxLMzLVJPQYJE6gp
         mI9A==
X-Gm-Message-State: ANoB5pnLqqLyVr6fxUnR8fBDwPrHdQJCvmJgsXPnl3avGV57RXzSfFN2
        8E8IHcpfJuh/JvNdwa+zHAyNmw==
X-Google-Smtp-Source: AA0mqf4mYmzjbcewsbtx2GMO4Z0urxIS7tt5k3wtucHMuRDUfjlTrJFPUq3Rj8Jakr44QpceqaDxVw==
X-Received: by 2002:ac2:4e4e:0:b0:4a4:68b9:608a with SMTP id f14-20020ac24e4e000000b004a468b9608amr6993443lfr.21.1671117049557;
        Thu, 15 Dec 2022 07:10:49 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w5-20020a05651234c500b004b0b131453csm1183121lfr.49.2022.12.15.07.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 07:10:48 -0800 (PST)
Message-ID: <9e94c0b9-f901-5ac9-2abb-40e958cbe5a2@linaro.org>
Date:   Thu, 15 Dec 2022 17:10:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 5/8] iommu/arm-smmu-qcom: Add SM6115 support
Content-Language: en-GB
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Adam Skladowski <a39.skl@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
 <20221030094258.486428-6-iskren.chernev@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221030094258.486428-6-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/10/2022 11:42, Iskren Chernev wrote:
> From: Adam Skladowski <a39.skl@gmail.com>
> 
> Add the Qualcomm SM6115 platform to the list of compatible,
> this target uses MMU500 for both APSS and GPU.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>

This needs to rebased on linux-next (or 6.2-rc1 once it's out).

> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2708de25ea3..526fec79b4fe 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -432,6 +432,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
>   	{ .compatible = "qcom,sc8280xp-smmu-500" },
>   	{ .compatible = "qcom,sdm630-smmu-v2" },
>   	{ .compatible = "qcom,sdm845-smmu-500" },
> +	{ .compatible = "qcom,sm6115-smmu-500" },
>   	{ .compatible = "qcom,sm6125-smmu-500" },
>   	{ .compatible = "qcom,sm6350-smmu-500" },
>   	{ .compatible = "qcom,sm6375-smmu-500" },

-- 
With best wishes
Dmitry

