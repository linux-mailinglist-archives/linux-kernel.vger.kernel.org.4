Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FD66C0F94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjCTKqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjCTKq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:46:28 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C072312A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:44:20 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id q16so3440782lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679308926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k16MUxzAr7So06ek3jaPuSWRMbCu5blX7yixTU1VOIo=;
        b=yeL7UQSEl7jxwbF+hiCfIPXVpJOFWcmKPNTDVlbXSiMaDqQKl14bXg52B3O8Jd5bfj
         cnsiJshIg73GzFW0UqBuR+zMaCPyHONlpuy6GCwi4fznClsRfR4pPvry5kUAOskkmo0K
         jxPFuc1h0bOnK5locxjGh4qc5YQQxwpcIVc10edsXIm3jV+9wohQxpa8Id/x3e7i0Cqt
         QdplhuFyvPQM/Sp8li3H+1nCsvWt4cv0bbAvoSGAVjMPpA1w6PUdPNQx96u6nfy+uU7/
         jhW19gHBX2PLS86+WnYLU4/svMBt914HAGx/haMQZMbGfWEBKwiRCMFQESSeuUnbfpfI
         7dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k16MUxzAr7So06ek3jaPuSWRMbCu5blX7yixTU1VOIo=;
        b=Zo9qV1pDXd0ax3LzR375KhSLMIUEzrYRUGfMdPJ9OPRKYR6Op54cwpiBT3spdB2WDf
         4LZdkg0GuPQsehLpwmiki3Y1xHDLf9hDO1AZpls2bYQNx/SkKE5r5SSP5CRLxycjeCaf
         ccq5nG/fZDcrow14ZAeHLTJxI77UTbwofXkF866ntMDowYAbEXfDMAAY448Tym3IUKjJ
         LdO8DO22aJwkiaL8cIB4DlXmMoQWXNycBOL0hdymsm/DSGvwVTOd6DggUVu8RhEgEEvR
         Uk+BgMaqU1aE7fp4fOneWc2qE+8Ys/JO+bVFYmV1m0SCA5P/16CY95glWDWddyr1/jEa
         IG3A==
X-Gm-Message-State: AO0yUKWkkZ+101HnreTGDQKC89VZf3tyHnj8reM/RSb+3nHeJQbW3pz7
        6QXPfswMP8mqKE8j+zn+lhY2Fg==
X-Google-Smtp-Source: AK7set8rHwqmHn+7sNRobBB28oMLRWp7yGgCfY/k3lB8f0Hw3GPmtlFfnPKnKWQkObtFPzP1JQGv4Q==
X-Received: by 2002:ac2:5097:0:b0:4b5:2ef3:fd2a with SMTP id f23-20020ac25097000000b004b52ef3fd2amr7744823lfm.47.1679308926377;
        Mon, 20 Mar 2023 03:42:06 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id r8-20020a19ac48000000b004e8b90e14a8sm1659531lfc.25.2023.03.20.03.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 03:42:06 -0700 (PDT)
Message-ID: <0a8fcd57-94dc-61e6-0ba0-b1591e05e6f2@linaro.org>
Date:   Mon, 20 Mar 2023 11:42:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] dmaengine: qcom: bam_dma: Add support for BAM engine
 v1.7.4
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        dmaengine@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, vkoul@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org
References: <20230320071211.3005769-1-bhupesh.sharma@linaro.org>
 <20230320071211.3005769-2-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230320071211.3005769-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20.03.2023 08:12, Bhupesh Sharma wrote:
> Qualcomm SoCs SM6115 and  QRB2290 support BAM engine version
> v1.7.4.
> 
> Add the support for the same in driver. Since the reg info of
> this version is similar to version v1.7.0, so reuse the same.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 1e47d27e1f81..153d189de7d2 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1228,6 +1228,7 @@ static const struct of_device_id bam_of_match[] = {
>  	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
>  	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
>  	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
> +	{ .compatible = "qcom,bam-v1.7.4", .data = &bam_v1_7_reg_info },
The compatible is meaningless as of today (it uses the exact same driver
data as v1.7.0), so I'd say going with:

compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";

is what we want.

Konrad
>  	{}
>  };
>  
