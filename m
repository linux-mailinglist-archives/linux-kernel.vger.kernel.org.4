Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91F6424D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiLEIk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiLEIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:40:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74CFD3D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:40:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 125-20020a1c0283000000b003d076ee89d6so8542204wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OcD3CaGFzs1PLkrODWghhljl7q5gdf6UquBrIlu96c8=;
        b=fomgni0P+Kvz4zbYfBoYDXmTuwlwU0ixPV9zc2axslY/d3jzwxQh+dMWD/1qEnnnDL
         GOnQOnW9csawE/QeXDaXZdgQsfHVgXYS9ZrhrNS0q9U6NJEV+H4EGJ9ve3hhMDD7sFmL
         7Wl3U5Ccme74YPkR2qPy7wlOmEy4EJacZd3RBFPwvpyZWERlOiMX3vqIBPoTallXMSak
         qbOJsU3adQBBtGRBwSmY2FBbyClZ3xEMzQzQ89FRj+icQaZ/umrCRzU+vrExLVPG/7YD
         3NdH0e+qfQ8CcOMyDwFFqt8PcKe8ms8ct1puaClTg6rXPCFwNBalHAailEbC38Eb4KI2
         EA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcD3CaGFzs1PLkrODWghhljl7q5gdf6UquBrIlu96c8=;
        b=RSoms4oljNN7eUCHeOqibM557WFxk5Hac2Xy0NrckH14pzoj3gO2XKl4B+jwLf89cc
         opmlxGAyn0D+jy6Q9/y0hmg8tthC4NEFw5wh4dyIIpblSeBqk0v2a91QYQN8cfwM7oGG
         tppN5kWm6sYMeHf0rkeGL79AOZFr/hvGLA0c1jJiJVZeBwKsg8zle2aGLRW/rvCgAplw
         NJleArVt9SZCE2vsZouv5ugFtKaxZ4Lzxg+1S2CF/jYdlTtv3WFEUt6+DmlfbTt/OtnD
         P/gYY/DM40ozRA0mYgrn7uf8etEuuDPk6TPcw/eeb9ZM5hFKSx8Id6YK7D9uJjEgqSOL
         8fug==
X-Gm-Message-State: ANoB5pn/ULCXfekh4CcwvigWjoRRyZYl5dlCVBUkoekACi7h1o9Gp4S8
        VdXdg3cdyLuZKzg3lLlQILxkDA==
X-Google-Smtp-Source: AA0mqf6by0jvDO+tidzDyqYI7lQOw3jHImDUmuwrlf9PDMqGT6N+VCFo+1Uc7Sj1Kqj8tGslwUYr9g==
X-Received: by 2002:a05:600c:511b:b0:3d0:128a:6d1e with SMTP id o27-20020a05600c511b00b003d0128a6d1emr14608390wms.108.1670229617859;
        Mon, 05 Dec 2022 00:40:17 -0800 (PST)
Received: from [192.168.7.93] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id v6-20020adfe286000000b00241f467f888sm13601383wri.74.2022.12.05.00.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 00:40:17 -0800 (PST)
Message-ID: <6e0dcfa8-6855-cc80-5e23-443d44cae07b@linaro.org>
Date:   Mon, 5 Dec 2022 09:40:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: defconfig: Add Meson DDR PMU as module
Content-Language: en-US
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        Chris Healy <healych@amazon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>
References: <20221204043530.1673752-1-jiucheng.xu@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20221204043530.1673752-1-jiucheng.xu@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC linux-amlogic@lists.infradead.org

On 04/12/2022 05:35, Jiucheng Xu wrote:
> Add Meson DDR PMU to defconfig so that build errors are caught.
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 0b6af3348e79..f2324b54a6ba 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1265,6 +1265,7 @@ CONFIG_ARM_DMC620_PMU=m
>   CONFIG_QCOM_L2_PMU=y
>   CONFIG_QCOM_L3_PMU=y
>   CONFIG_HISI_PMU=y
> +CONFIG_MESON_DDR_PMU=m
>   CONFIG_NVMEM_IMX_OCOTP=y
>   CONFIG_NVMEM_IMX_OCOTP_SCU=y
>   CONFIG_NVMEM_MTK_EFUSE=y

