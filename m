Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979F166501D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbjAJX5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235063AbjAJX5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:57:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D03E6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:57:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m6so20941339lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkTOuzrzX6KwlgMjt2sPQWSPFLHsLIuRAugm3KiZhdQ=;
        b=fbvbaRwRXvgjXAdD5bkv43z4u2CyFCahI0+D+LKLgT1AFAefgLUmTfDtYQeokf0uuP
         vmnk/5X1k53hpZxhquMQiPrDnNUQfQEE8iBZ14YmIX3JH6WoSyvBkvlep+KFawq4TcUH
         0KKcMt+ZyO8P/f6/AFUreLVc24oJBm9aHSSXBAEB+BzMmVn9iKrZWFu+iIxz7McbFALo
         dzURtRh6eIwOBgoscLEtlE6jlWhDD4iLqepokoYmwgxJKMJu4Bi9xoougJ7rilhWaW2M
         ubbN5VZL/HnnGo2sm3eIDEhPkUpWLQy/yPYHCMW1Gzc2GYm/0tu89ZukiHHsClOjoLVM
         4OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkTOuzrzX6KwlgMjt2sPQWSPFLHsLIuRAugm3KiZhdQ=;
        b=fRxk2fOMgSYJXFzhXfS/U79a40qs9Mr1SZJsITUup5rN3Cdti/v5wkvIY3Wd8fGdpD
         uNb+D1vqS3BA/nugYg2LPuMW5ycCmNJLcYs9au/jIME7b0WxsLROyygiMij936eS9GHU
         z2vYe49m1SmFteWLCkT3/7uET2OTtOa9BcCn3edBuRSzQQ2WVvbWVaFotOnR1SIV7kHF
         ihUT9MYwUHeswDNu98jE5jGSn4FF3h/JS2ED/xOc5OjGPqirhp69Xie0/9nd9khkfaNk
         oYpAQ7m4aYbBiru4AogzUk8872cVorj67HD6/60gruz9I/jU/yLy0d3EzYNjHsU1hMjX
         ZPKA==
X-Gm-Message-State: AFqh2kovdP+UNOB7u5os8bD7Mhozs8lZAEbt1m8AoX1FZZrBEmZgLMyr
        1/zMy3iyUUXZnjpQdk6liwVUxQ==
X-Google-Smtp-Source: AMrXdXsIeaG8B3rt97xF1l+QuLOENzWEnJCNuiCDWrac82PSXsBwU2ZebqJazF8pM/gK3dyRPOYx1A==
X-Received: by 2002:ac2:5edc:0:b0:4cc:74ac:9b6d with SMTP id d28-20020ac25edc000000b004cc74ac9b6dmr3544306lfq.12.1673395028389;
        Tue, 10 Jan 2023 15:57:08 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id n27-20020a05651203fb00b004cb21eaf6e6sm2430361lfq.0.2023.01.10.15.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:57:07 -0800 (PST)
Message-ID: <d90fe8dd-fc9d-fe2c-4b5e-cd7f32d747c9@linaro.org>
Date:   Wed, 11 Jan 2023 00:57:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] arm64: defconfig: enable SM8550 DISPCC clock driver
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230110-topic-sm8550-upstream-display-defconfig-v1-0-9941c8083f10@linaro.org>
 <20230110-topic-sm8550-upstream-display-defconfig-v1-1-9941c8083f10@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230110-topic-sm8550-upstream-display-defconfig-v1-1-9941c8083f10@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.01.2023 20:34, Neil Armstrong wrote:
> Build the Qualcomm SM8550 Display Clock Controller driver
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 851e8f9be06d..004c379eced7 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1107,6 +1107,7 @@ CONFIG_SDM_GPUCC_845=y
>  CONFIG_SDM_VIDEOCC_845=y
>  CONFIG_SDM_DISPCC_845=y
>  CONFIG_SM_DISPCC_8250=y
> +CONFIG_SM_DISPCC_8550=y
>  CONFIG_SM_GCC_6115=y
>  CONFIG_SM_GCC_8350=y
>  CONFIG_SM_GCC_8450=y
> 
