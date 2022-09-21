Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B65BF74C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiIUHM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUHMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:12:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A9076966
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:12:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id l65so5024271pfl.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nZqkMhL7H0w3lFVKEgrXPAK7vRYev/PZ9pSEQRhmDNg=;
        b=uApkX5k0fdL7KC7QJLCNSFkYnpqNra4nuBg0V5/Lv2ak78uSIwkClMLqI3QiCrzQC7
         hIxjWjMMNxDffxnutfWHVp8FmV1S4U8zLcwQTmIooroPrxU+5IkFDPHvSAYetoFeR4Td
         fQ02xexY7pFX+t7+mC8+i7DIXHxnL43t2ecwgjy7YDR7eK8InEGMhLSstV0Ko5FsUPhW
         XaAKe9s+ae0iNxtyD7+aExtZEElIHFxZZo1E0rtpcc3FhOspWW/sqdRxhFpVE/s23bas
         CRKe+/peUm/Wko7UUxP5u5wgbDW9ERXR9/G6cPIqSMmwondkIIlL2U7YSzXuRvCiWKR6
         +GOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nZqkMhL7H0w3lFVKEgrXPAK7vRYev/PZ9pSEQRhmDNg=;
        b=izFLtY4gGmgmGnmMR/WdaS0XvS6zexlh7RQl4LuFzIhH/HRn5EbI1HmUSUB5TAQ7a/
         hwCOYqDpgIzeo1IewroHHqMVsBLyybFetSWc1AVi1QMEViEbtfvbCqNZ6dk/zAiOkPYW
         FYwPW/I1Ha7nI5tDu3ta1ZFwc+c1gzrE9MosqDVQW2e2+IWzZvbWRmR6fVJRco4VdrGz
         DgC3RcO0UlvOjZ2S720HChdXBogB7Jznula7G5syHUFXu8Psbb1gHVMMtI5IFoiM6dhu
         PQkp52UmvPpMxve48UN4PblDTXeYecnYzzqK0GJys+dOGfeuESG41bvdtOKU4Wghm+jJ
         EDeA==
X-Gm-Message-State: ACrzQf1vLJZahbK+3KjQRpY28WKAUaOh1fCWJLzmmV6H2a4P5WTXSIyF
        Hs5fImhdhD66aY3TTcltQvq4Xg==
X-Google-Smtp-Source: AMsMyM60EewpH9nGkkPLiSTs/Ao1oQHtT1wpNyBLsBczWGSY8FFJoVwqzxqD6gbeKrXM+Rif6vB1vA==
X-Received: by 2002:a63:2cd2:0:b0:41c:5901:67d8 with SMTP id s201-20020a632cd2000000b0041c590167d8mr23322684pgs.365.1663744367947;
        Wed, 21 Sep 2022 00:12:47 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5? ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id 13-20020a63134d000000b0042fe1914e26sm1168960pgt.37.2022.09.21.00.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:12:47 -0700 (PDT)
Message-ID: <cc120f10-ef65-264e-f251-b63ff0fc81ca@linaro.org>
Date:   Wed, 21 Sep 2022 12:42:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] arm64: defconfig: Enabled SC8180x configs
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220916124214.3881948-1-vkoul@kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20220916124214.3881948-1-vkoul@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/22 6:12 PM, Vinod Koul wrote:
> Enable sc8180x global clock controller, tlmm, interconnect and edp phy
> drivers which are required for sc8180x like Lenovo Flex 5G laptop to
> boot.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   arch/arm64/configs/defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0816b7f6926e..e772d01536cf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -534,6 +534,7 @@ CONFIG_PINCTRL_QDF2XXX=y
>   CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>   CONFIG_PINCTRL_SC7180=y
>   CONFIG_PINCTRL_SC7280=y
> +CONFIG_PINCTRL_SC8180X=y
>   CONFIG_PINCTRL_SC8280XP=y
>   CONFIG_PINCTRL_SDM845=y
>   CONFIG_PINCTRL_SM8150=y
> @@ -1060,6 +1061,7 @@ CONFIG_MSM_GCC_8998=y
>   CONFIG_QCS_GCC_404=y
>   CONFIG_SC_GCC_7180=y
>   CONFIG_SC_GCC_7280=y
> +CONFIG_SC_GCC_8180X=y
>   CONFIG_SC_GCC_8280XP=y
>   CONFIG_SDM_CAMCC_845=m
>   CONFIG_SDM_GPUCC_845=y
> @@ -1213,6 +1215,7 @@ CONFIG_PHY_HISTB_COMBPHY=y
>   CONFIG_PHY_HISI_INNO_USB2=y
>   CONFIG_PHY_MVEBU_CP110_COMPHY=y
>   CONFIG_PHY_MTK_TPHY=y
> +CONFIG_PHY_QCOM_EDP=m
>   CONFIG_PHY_QCOM_PCIE2=m
>   CONFIG_PHY_QCOM_QMP=m
>   CONFIG_PHY_QCOM_QUSB2=m
> @@ -1275,6 +1278,7 @@ CONFIG_INTERCONNECT_QCOM_OSM_L3=m
>   CONFIG_INTERCONNECT_QCOM_QCS404=m
>   CONFIG_INTERCONNECT_QCOM_SC7180=m
>   CONFIG_INTERCONNECT_QCOM_SC7280=y
> +CONFIG_INTERCONNECT_QCOM_SC8180X=y
>   CONFIG_INTERCONNECT_QCOM_SC8280XP=y
>   CONFIG_INTERCONNECT_QCOM_SDM845=y
>   CONFIG_INTERCONNECT_QCOM_SM8150=m

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
