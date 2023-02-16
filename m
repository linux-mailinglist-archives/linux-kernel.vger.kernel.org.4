Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAB699367
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjBPLm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjBPLmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:42:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9B77EFE;
        Thu, 16 Feb 2023 03:42:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so1557198wrd.6;
        Thu, 16 Feb 2023 03:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKI2TnFH1VivBlI9Zu+f4DLD1Oxh3uwKhDHr4Ttuqi4=;
        b=gZrP2qlYh/6CWJTLqXysnOcvuh52GIC3d9yfVG0MJpITqyjaFvdpUPeyAbqMkcM3Fa
         zXUSjvUfnTXjRU7JDXzCXkJPfg6imR/g6SaSUTLojExscX49w9mtfsR46pXfNAxLJ+SD
         N4MbZhH7U5Ch1QWp0RK+7HQaoLs7hNEkBRUrc98Go21KPDvJYo9k5Jxcwg60I34kBiO+
         jzOdiyIcNvEffCQDJ+R+4oiEbHiYpWCC7SztqVRM0a5mkaA2h1vc8A30s9hJVYxiQTtx
         Ib/y5W17q02KtYLuNS7y2CNKXljk01bV4+sm4WZKuiGzO7rasB8rgb2OEWJAWVzLw/kI
         0D+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKI2TnFH1VivBlI9Zu+f4DLD1Oxh3uwKhDHr4Ttuqi4=;
        b=w4Bqb3NmkmIH15iXQJRYguHwIXXT4MeeO5EWlOGTnuctijPipv0WSxGhL1Xt+kJblX
         ob7KK8njsuXRNyAaGhFOtTXtaxG8oWEMu03dIl6J55NqLYepaZCeUFiHiuuDdVCUO1sK
         M39z/LW90p5822zQ1qp7VmYd8VcA/V6Yywi4SkoHbFAJgbLazm5ajk2i9RXxdxqAtQ3P
         +Qxn6+DliA77sk4hCIMTrRvjKukBWidyzg1EABAx3Wv4EUR6oQy4W+0apdeBvP8tzSWz
         z4CpQTxlciq5q/nfE1KVssz2CPSEmxKPmNX/XnfacHoNkqvByvGnW0kn9h2/JdYEjrdi
         EdCQ==
X-Gm-Message-State: AO0yUKV90d1j88EhOR09ZPYVUOfwdWqYY9QViticrKtToDr+T4Zlrh3u
        vxaHw3eznnDOp7ny8A9rpuE=
X-Google-Smtp-Source: AK7set+dKyKPNF2+oXsuE4x1TqOXOhwS+x+LUr+rCYzBOGgJDag9Cq+SNQNNO/rL9nq18lzBFFSx1w==
X-Received: by 2002:a5d:4486:0:b0:2c3:da8a:192 with SMTP id j6-20020a5d4486000000b002c3da8a0192mr4607178wrq.15.1676547769878;
        Thu, 16 Feb 2023 03:42:49 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d46c1000000b002c55306f6edsm1309313wrs.54.2023.02.16.03.42.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:42:49 -0800 (PST)
Message-ID: <a08cb6a6-2453-34fe-f6f3-9ff81585d65d@gmail.com>
Date:   Thu, 16 Feb 2023 12:42:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230215041257.14548-1-tinghan.shen@mediatek.com>
 <20230215041257.14548-5-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v7 04/12] remoteproc: mediatek: Add SCP core 1 register
 definitions
In-Reply-To: <20230215041257.14548-5-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2023 05:12, Tinghan Shen wrote:
> Add MT8195 SCP core 1 related register definitions.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

In general I would say this patch should be squashed into 5/12, but please see 
comments below.

> ---
>   drivers/remoteproc/mtk_common.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
> index ea6fa1100a00..3778894c96f3 100644
> --- a/drivers/remoteproc/mtk_common.h
> +++ b/drivers/remoteproc/mtk_common.h
> @@ -47,6 +47,7 @@
>   #define MT8192_SCP2SPM_IPC_CLR		0x4094
>   #define MT8192_GIPC_IN_SET		0x4098
>   #define MT8192_HOST_IPC_INT_BIT		BIT(0)
> +#define MT8195_CORE1_HOST_IPC_INT_BIT	BIT(4)
>   
>   #define MT8192_CORE0_SW_RSTN_CLR	0x10000
>   #define MT8192_CORE0_SW_RSTN_SET	0x10004
> @@ -56,6 +57,26 @@
>   
>   #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
>   
> +#define MT8195_CPU1_SRAM_PD			0x1084
> +#define MT8195_SSHUB2APMCU_IPC_SET		0x4088
> +#define MT8195_SSHUB2APMCU_IPC_CLR		0x408C
> +#define MT8195_CORE1_SW_RSTN_CLR		0x20000
> +#define MT8195_CORE1_SW_RSTN_SET		0x20004
> +#define MT8195_CORE1_MEM_ATT_PREDEF		0x20008
> +#define MT8195_CORE1_WDT_IRQ			0x20030

Should be part of 10/12 maybe?

> +#define MT8195_CORE1_WDT_CFG			0x20034
> +
> +#define MT8195_SEC_CTRL				0x85000
> +#define MT8195_CORE_OFFSET_ENABLE_D		BIT(13)
> +#define MT8195_CORE_OFFSET_ENABLE_I		BIT(12)
> +#define MT8195_L2TCM_OFFSET_RANGE_0_LOW		0x850b0
> +#define MT8195_L2TCM_OFFSET_RANGE_0_HIGH	0x850b4
> +#define MT8195_L2TCM_OFFSET			0x850d0

Should be part of 9/12 maybe

> +#define SCP_SRAM_REMAP_LOW			0
> +#define SCP_SRAM_REMAP_HIGH			1
> +#define SCP_SRAM_REMAP_OFFSET			2
> +#define SCP_SRAM_REMAP_SIZE			3

Never used.

> +
>   #define SCP_FW_VER_LEN			32
>   #define SCP_SHARE_BUFFER_SIZE		288
>   
