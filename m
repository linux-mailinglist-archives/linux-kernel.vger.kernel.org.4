Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F976DC97D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjDJQrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjDJQrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:47:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B81BC0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:47:16 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50480ce88dbso1693216a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681145234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+gxGMIiSz5uZWgSiDLv5wb5ekq1gKmiqT8Bd8yz/ds=;
        b=GQ8L1696PKy/4oEanTiqpv5S049NPWjf9AapfHHOvaUOFomKL9hdA5inRia5cFnph1
         XeEiOh+fraVbenfuv7oTB2FnUInydzkOsg+Dx3W4KcwD+d/zN8bz56WwJiXMEPu6qKXD
         obB4rw03UABGtvIVsTcPSDXB6UiuIQJjJ3QNvMDqlaMEgz3OYDyMaBJgd1AcZWrpQyML
         ERb+AnBmEVJYIDHiyE9az4hd8bLf6zHGp05RbdJLcYJeBOWTSuA7vvt8IGn0IUAIvXBS
         dbAhIelo+DWXhLr3d5tb4SdgHOPQ0KADe6wwD+s3B7qdDD1U5JtSSAZVncqDYjgpQsdS
         N2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+gxGMIiSz5uZWgSiDLv5wb5ekq1gKmiqT8Bd8yz/ds=;
        b=NdDjxzV9mYzVL7URTrr5ra/uv6RLjxEZps00eYRNbD7ruH2paPOs2Xgw5sG/6UsjtL
         S0erutClMDBsYAm6FpeLXpH3IIteSpduHqx/PEiDsHAJ5hvk/LtqTfW/IseC8u21wtZ5
         C+ZvyqT9vGfj0/YrPyAn1H/lAKVFC1a9BvX2oPcoL2Z9X9WAzINBbYVEey0y1KhfQmra
         NAGtII0kYWH3geT0OIb5PuZGYsrhVOYw18Se+AqWznngYcKOl9q3KAy6Qk1Jd5YQgGod
         kfndm8gn0OyPrYfxJDO55zNSSyMpcSPuFE1hgEzZmvbZ5d9NR6+3i0JThWKPoEFBngpV
         1HKw==
X-Gm-Message-State: AAQBX9dY5WY4QCkxUTVi1PqeK1aAkY9R04ZOvu95Yq83tfRKECV8FVlP
        6d53jOmdBRQblunYWqYTJkrLMA==
X-Google-Smtp-Source: AKy350aF6ODPvsCZJZHKkPkWmgpgg3SFf2Yb1hUKMl+fKRqs3xDD5O9oVflnyKPtaL7Hn3xY4dCd4A==
X-Received: by 2002:a50:ed05:0:b0:504:9a52:ea52 with SMTP id j5-20020a50ed05000000b005049a52ea52mr5182455eds.35.1681145234446;
        Mon, 10 Apr 2023 09:47:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id v6-20020a50c406000000b0050432d2b443sm5026002edf.48.2023.04.10.09.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 09:47:13 -0700 (PDT)
Message-ID: <fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org>
Date:   Mon, 10 Apr 2023 18:47:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: exynos_defconfig: Enable zram as loadable modules
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Elliott <elliott@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230410124907.3293869-1-javierm@redhat.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230410124907.3293869-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 14:49, Javier Martinez Canillas wrote:
> Enable zram and dependencies as loadable modules. This allows to use the
> /dev/zramX virtual block devices as swap stored in system memory.
> 
> Options were taken from commit 5c824e8be64d ("ARM: omap2plus_defconfig:
> Enable zram as loadable modules") that does the same for OMAP2+ platforms.

Neither this commit msg nor above omap commit explain why do we want it.
I know what zram is, I know its purpose, but the commit should answer
why we want it in defconfig.

To me it is not a matching defconfig at all:
1. Not a feature related to Exynos hardware,
2. Not needed for basic boot (systemd) or debug.

> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  arch/arm/configs/exynos_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index b0f0baa3a6c4..2d5be864b4ca 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -37,6 +37,8 @@ CONFIG_MODULES=y
>  CONFIG_MODULE_UNLOAD=y
>  CONFIG_PARTITION_ADVANCED=y
>  CONFIG_CMA=y
> +CONFIG_ZSMALLOC=m
> +CONFIG_PGTABLE_MAPPING=y
>  CONFIG_NET=y
>  CONFIG_PACKET=y
>  CONFIG_UNIX=y
> @@ -84,6 +86,8 @@ CONFIG_NFC_SHDLC=y
>  CONFIG_NFC_S3FWRN5_I2C=y
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_ZRAM=m
> +CONFIG_ZRAM_WRITEBACK=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_CRYPTOLOOP=y
>  CONFIG_BLK_DEV_RAM=y
> 
> base-commit: e3adc46da349d4a4cda1c58d8186c5bce0b011fd

BTW, I think the base commit makes sense if it is "well-known commit". I
have latest master and next and commit is unknown.

Best regards,
Krzysztof

