Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4590653F14
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbiLVLd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiLVLdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:33:55 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C13AFCE8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:33:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id y25so2289281lfa.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRLrmmaSjc0gUZ4zcoUnv7yUNb7QxgbkEvv8clHFo1s=;
        b=RPfRJDdpICisbEUMR3vE18ktoqUosi2dnSq0NDPpAO5jtIxhl+pILJsjLr5qeX20ek
         ZFBM4lmCR8ScTv28LHAVxesf3AH2zO0W8R1UlCD6fvCmVkWDYoV3Kha86nbS7Uq9bAeG
         DoQezEpPodnkEst8iO2QMxuxTio2/C/WvH0h4t81EB7B1bwAhxtJTxRjjhziNVBfiou1
         K7Q5cKA+7eXsVDzuDzS7gZCgWJ+U3/RezWhqSvqadRsqOwGyBQPkBXSfyyNTZgpgp2xY
         x7ozy6AmZe42iRf2j+fv4FrscqTL2F5p47XBWaaVxY+LdhnQ/Ee/Ft1O8u8IkeEW+n+Y
         l+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRLrmmaSjc0gUZ4zcoUnv7yUNb7QxgbkEvv8clHFo1s=;
        b=HRASdUeiLvndINI3uIaMamRzewv/HrsIJZ2yAMQEBTkib9inBW+Ag3Q1Y3Z0oN8HTF
         YrMzme07Y00YexSgblS202yoTslgRlx0kLHnciP87s9wSLRFr6HUq9Rdknx0tw+02Jyw
         pNiuCqADsUBj59flg3S1lmg7jr/i36VA/gsYyrZtwmXYzmk5DBUPIljBYhrsQ/WipBcd
         9NZBa08fWakfsrGh9BV8Ss6hbaR6Slu6T5ZAI1qSM/a6GhHVL87jxU6771nSLW5g8/0R
         GPOrvY2LCuQrhdCKTeJqi75c7xrE/LyielILpxeHWd9026iT4I8DNmhbWIzfyYTCFl9W
         eJyg==
X-Gm-Message-State: AFqh2kqplQ86MjQ2Dkf9tYTR0EWnmlwGIFrf9e4gnktbKgOEwBEsdnN0
        Tie9yVgqjVojTw3k4gXs3GivJg==
X-Google-Smtp-Source: AMrXdXsDql8gTOufUZcnxE6Uixrr4IGG/Dy/csTkiUjaTJcPKDGoDrJV9ra41TEqNdEybkHeX/jkBg==
X-Received: by 2002:a05:6512:108f:b0:4a4:68b8:c2e4 with SMTP id j15-20020a056512108f00b004a468b8c2e4mr1571197lfg.59.1671708832844;
        Thu, 22 Dec 2022 03:33:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m12-20020a19710c000000b004b700ba3cf3sm40627lfc.203.2022.12.22.03.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 03:33:52 -0800 (PST)
Message-ID: <e7324811-070d-999d-89a8-8e291caa92f1@linaro.org>
Date:   Thu, 22 Dec 2022 12:33:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [Patch v1 03/10] memory: tegra: add pcie mc clients for Tegra234
Content-Language: en-US
To:     Sumit Gupta <sumitg@nvidia.com>, treding@nvidia.com,
        dmitry.osipenko@collabora.com, viresh.kumar@linaro.org,
        rafael@kernel.org, jonathanh@nvidia.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     sanjayc@nvidia.com, ksitaraman@nvidia.com, ishah@nvidia.com,
        bbasu@nvidia.com
References: <20221220160240.27494-1-sumitg@nvidia.com>
 <20221220160240.27494-4-sumitg@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221220160240.27494-4-sumitg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 17:02, Sumit Gupta wrote:
> Adding PCIE clients representing each controller to the
> mc_clients table for Tegra234.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra234.c | 314 +++++++++++++++++++++++++++++++-
>  1 file changed, 313 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/memory/tegra/tegra234.c b/drivers/memory/tegra/tegra234.c
> index 2e37b37da9be..420546270c8b 100644
> --- a/drivers/memory/tegra/tegra234.c
> +++ b/drivers/memory/tegra/tegra234.c
> @@ -465,7 +465,319 @@ static const struct tegra_mc_client tegra234_mc_clients[] = {
>  				.security = 0x37c,
>  			},
>  		},
> -	},
> +	}, {

Didn't you change the same structure in previous patch?

Best regards,
Krzysztof

