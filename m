Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023F7668AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjAMEVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbjAMEUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:20:35 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09E6719C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:16:53 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bt23so31342338lfb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heBIA7OkFo1be9hGuAS5uBJi61k6Fgf0lA93SEHuWXo=;
        b=RDnk+5jTaGGQogsxrMRq6oJCbAPlByl3TcjNHl2k1YASTcmvoqnpy0COr4rxvjywET
         hIGCjV69Sv98FZ8yUAPUhvVz5rk3SiiSHs7RoI93Rjm1xr9mDldpK4svC7b0602TbRnl
         eTthdhNbGueSWnlhbzUvu91oQYHz88fUezTEDeMBtsWetozFxkAJQmAqGb/d1x2h2Qng
         Eg2xSRz0Mv3DUI1ue6Xk5DPwI5ek5A7C8sudsxk+wBNgfphIC7pvRWRUdFAs6O2uo/o5
         KY/UPe8TFJ8SjE6pmufxt/mthesnAZy5tmA+mPZiRNfrwdlq/ZmgatxEQBE+Sw5wIUvf
         MkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heBIA7OkFo1be9hGuAS5uBJi61k6Fgf0lA93SEHuWXo=;
        b=HvXswTU/FSxkqa+n/SmSRDqPZtegbWtzkVMb62k1zokIYKgZHfAHZb7FaO5COFzvDu
         O4SnW1+K6J9jNQ6P9uiEjUyfLTIcMGJZTcGNl7IOfEYEAtnSLCILbrzSFY3XccqrkUbM
         aqlxjrQm+X5InEXMoHrfZDdUqUPvSPQMGJshHOySJvXbBQBnDl3UDhbfbVEOCNovZJGS
         zK4I+8U51kBrmMxTHxjvUA0sYIPpehcFGYZbIVUCPb1o5Ij/zPy4bx+dLoidyPJV4n8y
         0nHyBRWOPwLM+qdKDD00Ef3ekf/WXIdhdX5UlXKvterojEUdKxJOiLFEW+cN2i7yXfU1
         qIjw==
X-Gm-Message-State: AFqh2kpqrnv1FwHMVAdRe4ZAFoyZ0Q1hITot6w+g0KXbtvFeOP5O/krk
        FruOGSHN3rW6//tq3ozbboi5mA==
X-Google-Smtp-Source: AMrXdXsyNDah0AafD2x1N6FLi6xp5Xf6tvHYOs9VEnDuLD82U0I1Cg4tSBIaCwMgh2l5Gj93eLxxOQ==
X-Received: by 2002:ac2:498f:0:b0:4a4:86ff:9562 with SMTP id f15-20020ac2498f000000b004a486ff9562mr4084747lfl.38.1673583411896;
        Thu, 12 Jan 2023 20:16:51 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id v20-20020a056512349400b004b55075f813sm3667026lfr.227.2023.01.12.20.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 20:16:50 -0800 (PST)
Message-ID: <60da722a-9481-0e8d-8f74-1a4205e471eb@linaro.org>
Date:   Fri, 13 Jan 2023 05:16:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] iommu/arm-smmu-qcom: Select identity domain for sc8280xp
 MDSS
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230113041104.4189152-1-quic_bjorande@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230113041104.4189152-1-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.01.2023 05:11, Bjorn Andersson wrote:
> The Qualcomm display driver installs a translation domain once it has
> mapped a framebuffer. Use the identity domain for this device on
> SC8280XP as well, to avoid faults from EFI FB accessing the framebuffer
> while this is being set up.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 4c53824582d4..cebc10c0492d 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -250,6 +250,7 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>  	{ .compatible = "qcom,sc7280-mdss" },
>  	{ .compatible = "qcom,sc7280-mss-pil" },
>  	{ .compatible = "qcom,sc8180x-mdss" },
> +	{ .compatible = "qcom,sc8280xp-mdss" },
>  	{ .compatible = "qcom,sm8250-mdss" },
>  	{ .compatible = "qcom,sdm845-mdss" },
>  	{ .compatible = "qcom,sdm845-mss-pil" },
