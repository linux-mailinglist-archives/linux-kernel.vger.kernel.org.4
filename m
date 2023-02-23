Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE86A0691
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBWKto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBWKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:49:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435634AFD2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:49:41 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id r27so11154361lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yr0y3Qeq1u2rQWHyWs/rAaWs2NbdV1kuldEYjIeP4Nk=;
        b=A8zyKDVpRiutSwh+lkjQojMtaRp6Q9e/j5stfHXOpWPC+xGjlPEEMznGrj5xDGAxwp
         VnGEQUA0l5RZ3cuZW+LnnUA3iDBIyr2m3xV4R6aI0BPHXzPGkcI1UqcuxUGQgsZHSJIn
         /ec7mDoOKbk53lvUIVtm4Ko4kzF8MfwyR3B+XxdLZ9gYMwFbj6Em78zykdc3h5iHoP3A
         r0W7qnzo8wk3JllZ+BJYCUS/jsNNFE3hyWaQe3flkUpD0r0t/WSY2/o+Of9cFnYHVzYE
         wYIQZKmxzxTXAHlIxO2rlD9HuxJbU1jxY7Xoi6j3KFpJTnnhavKsdsSjlLx4tlY66joP
         Goow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yr0y3Qeq1u2rQWHyWs/rAaWs2NbdV1kuldEYjIeP4Nk=;
        b=rx/oQd8+bkLLDn2zjF3rwJsENCPVf9TeGMH4ahlThTPRDAJuxYeCIoTXhBpyujQOIA
         /4fEyDTjZ/57u9afQA0ji0JPwLiCk9kycIrQkHT3timZ31SWG2RPmH46FDlj/MUTB7be
         CAz9bjY62CV+Tq2BYDOYWxTp+TpjBCbCl/eRkq096uaVMmM7Y24l68czyyUD/EeyfmL9
         rYZ7t8q/jibX7+o1BKyJ9CIXbR0kdEMjl7lXQeDTsKlzzUeGT3JbD5CwS6zwyFEa5XOK
         zQdPQYYylg5oO1/MYO5lud6ePH9zlxlZFdedPd8JNO49sAlOGzzG1+ZhCwbLglpkyiVg
         kbpA==
X-Gm-Message-State: AO0yUKXqU9dt1Q9GS51cNuE09v6qDAkT1KriwndUsg4lWqvJu2JkDPRg
        KxXc8pLWdQ2nJYJA2H5o5C2HLw==
X-Google-Smtp-Source: AK7set/L2xUtI4IPyfWEyjYzgLb/b9TgU6bEJpxccera2h9ihdfNGwynEZlDdSYQkGFc+eduSJPTsw==
X-Received: by 2002:a19:ad0a:0:b0:4d5:978e:8bcf with SMTP id t10-20020a19ad0a000000b004d5978e8bcfmr3377845lfc.33.1677149379532;
        Thu, 23 Feb 2023 02:49:39 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id r28-20020ac25a5c000000b004db3890cb4bsm168085lfn.94.2023.02.23.02.49.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:49:39 -0800 (PST)
Message-ID: <a0a7df49-0cba-927e-8bcd-d42c040845d7@linaro.org>
Date:   Thu, 23 Feb 2023 11:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Content-Language: en-US
To:     Bin Meng <bmeng@tinylab.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Andy Gross <agross@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robert Elliott <elliott@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>, Zi Yan <ziy@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
References: <20230210093224.689990-1-bmeng@tinylab.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230210093224.689990-1-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10.02.2023 10:32, Bin Meng wrote:
> Drop CONFIG_MTD_M25P80 that was removed in
> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
>  arch/arm/configs/axm55xx_defconfig     | 2 +-
>  arch/arm/configs/davinci_all_defconfig | 1 -
>  arch/arm/configs/dove_defconfig        | 1 -
>  arch/arm/configs/keystone_defconfig    | 1 -
>  arch/arm/configs/mvebu_v5_defconfig    | 1 -
>  arch/arm/configs/mxs_defconfig         | 1 -
>  arch/arm/configs/pxa_defconfig         | 1 -
>  arch/arm/configs/qcom_defconfig        | 1 -
>  arch/arm/configs/socfpga_defconfig     | 1 -
>  9 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
> index bfbaa2df3be5..936aecbdc129 100644
> --- a/arch/arm/configs/axm55xx_defconfig
> +++ b/arch/arm/configs/axm55xx_defconfig
> @@ -85,7 +85,7 @@ CONFIG_MTD_CFI_AMDSTD=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PHYSMAP_OF=y
> -CONFIG_MTD_M25P80=y
> +CONFIG_MTD_SPI_NOR=y
>  CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index 821d966c95a5..cb7a03bce291 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -63,7 +63,6 @@ CONFIG_MTD_CFI=m
>  CONFIG_MTD_CFI_INTELEXT=m
>  CONFIG_MTD_CFI_AMDSTD=m
>  CONFIG_MTD_PHYSMAP=m
> -CONFIG_MTD_M25P80=m
>  CONFIG_MTD_RAW_NAND=m
>  CONFIG_MTD_NAND_DAVINCI=m
>  CONFIG_MTD_SPI_NOR=m
> diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
> index ff37f46c82fb..3f90b4b241a9 100644
> --- a/arch/arm/configs/dove_defconfig
> +++ b/arch/arm/configs/dove_defconfig
> @@ -43,7 +43,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index 4a5b9adbf2a1..36692143dd3d 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -118,7 +118,6 @@ CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_PLATRAM=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_DAVINCI=y
>  CONFIG_MTD_SPI_NOR=y
> diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
> index 2467afd32146..26c5724c409d 100644
> --- a/arch/arm/configs/mvebu_v5_defconfig
> +++ b/arch/arm/configs/mvebu_v5_defconfig
> @@ -63,7 +63,6 @@ CONFIG_MTD_CFI_GEOMETRY=y
>  CONFIG_MTD_CFI_INTELEXT=y
>  CONFIG_MTD_CFI_STAA=y
>  CONFIG_MTD_PHYSMAP=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_ORION=y
>  CONFIG_MTD_SPI_NOR=y
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index feb38a94c1a7..0eeef6402952 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -45,7 +45,6 @@ CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_DATAFLASH=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_SST25L=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_GPMI_NAND=y
> diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
> index 0a0f12df40b5..851a817b52c0 100644
> --- a/arch/arm/configs/pxa_defconfig
> +++ b/arch/arm/configs/pxa_defconfig
> @@ -130,7 +130,6 @@ CONFIG_MTD_ROM=m
>  CONFIG_MTD_COMPLEX_MAPPINGS=y
>  CONFIG_MTD_PHYSMAP=y
>  CONFIG_MTD_PXA2XX=m
> -CONFIG_MTD_M25P80=m
>  CONFIG_MTD_BLOCK2MTD=y
>  CONFIG_MTD_DOCG3=m
>  CONFIG_MTD_ONENAND=m
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index b41716c1ec64..fd5581edc310 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -63,7 +63,6 @@ CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_QCOMSMEM_PARTS=y
>  CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_QCOM=y
>  CONFIG_MTD_SPI_NOR=y
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 70739e09d0f4..9591af0441dd 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -41,7 +41,6 @@ CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_BLOCK=y
> -CONFIG_MTD_M25P80=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_DENALI_DT=y
>  CONFIG_MTD_SPI_NOR=y
