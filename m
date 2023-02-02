Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBF6878AD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjBBJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjBBJX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:23:26 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D8B39B8F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:23:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x7so1368707edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P416tksoeHDPkWpCS/M1Q+zYFOilkGD7o2nwBtmZ5fw=;
        b=r8fGA5KY3CdAVkyb1hWGQMShGCmNPQ+4vbsIioc/NbPsYgvK8fHqxdGeBmihbk1+XU
         1xAns9vRGYUtiK6b7caRCbg/jM7yCnK0n+xXq2d55Qy5jLKyicccVGgojznDVQQQrWN3
         eKX2jW1F+PEHtGXa2cLK+QGAzfHSbKeDCtkAWYEgzCWog01clTquCPVmZc16R6N9s3E0
         WbUJ0PHeP3j+xXdik0U7fyUjKonH/gtGYyoiLZUfdROb60RveEab0XS2XBfaRCPMOy5d
         UPm5k5XpwzKf/bJrTq02LXP1idwPVQ/8y9Ip9RXu5V1sJ6ih3kPO1JwgoullH/6g0d04
         jk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P416tksoeHDPkWpCS/M1Q+zYFOilkGD7o2nwBtmZ5fw=;
        b=DNC3KcPtoMRjN3B5zyuWAvgbuTQ6ZI62ApM7sadaErUwrK8g8ymqw1k2HMZliIstIL
         V3zfMj1Oey065cBCa4cVvlQ6q0xs8pr0VpZy0uA4eoBkbBr0uohMtWw1CgdRMGAQHS4J
         ERGGjhRnh9kkYPFjPalBiVW1BA4uRjoh4YMaH8w7VX17wf45h+Qlcua0TY+KBeIYTzXd
         Jx6791y7fqXqNUfrvCpH21ptjGvn0s7dByam8LxBuFThvB7Mvd9pFYPkHKi9spu4Telq
         ep2/4xLKXJl8dkRu2tOe8rO36b/md2YF59RVX8oDJZ5wj2LB3Pui9jqtgYBvqmmSMhhM
         LNdA==
X-Gm-Message-State: AO0yUKVtFkWBbcrOV8cesLRVxFsaPK7yEbilEJBlQf+OJlXxi7B2YYmW
        aFgH/+ilonhS22L0M/hDl0HCYA==
X-Google-Smtp-Source: AK7set+25TuvV+te8V0hts0u1AdgPZFTx1SxQLVFh2hhpbApcNWEKcoARoxg5zqYd+U9M+0vMFBirA==
X-Received: by 2002:a05:6402:345a:b0:499:c343:30e5 with SMTP id l26-20020a056402345a00b00499c34330e5mr5967988edc.3.1675329803668;
        Thu, 02 Feb 2023 01:23:23 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b00869f2ca6a87sm11257469ejd.135.2023.02.02.01.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:23:23 -0800 (PST)
Message-ID: <a27ab5a2-ff8a-b5b7-dcd1-afffd3d78d8a@linaro.org>
Date:   Thu, 2 Feb 2023 11:23:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH] arm64: defconfig: enable drivers required by the
 Qualcomm SA8775P platform
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Shawn Guo <shawnguo@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230202085958.11055-1-brgl@bgdev.pl>
Content-Language: en-GB
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230202085958.11055-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 10:59, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable the pinctrl, GCC clock and interconnect drivers in order to allow
> booting SA8775P boards. The drivers need to be built-in for QUPv3 and
> subsequently UART console to work.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Note, you didn't include linux-arm-msm into the To/Cc, so this patch 
might miss Bjorn's patchwork.

> ---
> All drivers are now in next so let's enable them.
> 
>   arch/arm64/configs/defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 984553d55e17..998ca0e07689 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -560,6 +560,7 @@ CONFIG_PINCTRL_QCM2290=y
>   CONFIG_PINCTRL_QCS404=y
>   CONFIG_PINCTRL_QDF2XXX=y
>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
> +CONFIG_PINCTRL_SA8775P=y
>   CONFIG_PINCTRL_SC7180=y
>   CONFIG_PINCTRL_SC7280=y
>   CONFIG_PINCTRL_SC8180X=y
> @@ -1352,6 +1353,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
>   CONFIG_INTERCONNECT_QCOM_MSM8996=m
>   CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>   CONFIG_INTERCONNECT_QCOM_QCS404=m
> +CONFIG_INTERCONNECT_QCOM_SA8775P=y
>   CONFIG_INTERCONNECT_QCOM_SC7180=y
>   CONFIG_INTERCONNECT_QCOM_SC7280=y
>   CONFIG_INTERCONNECT_QCOM_SC8180X=y

-- 
With best wishes
Dmitry

