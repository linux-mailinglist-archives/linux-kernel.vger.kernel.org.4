Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB8268987A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjBCMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjBCMWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:22:51 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA59E9C0;
        Fri,  3 Feb 2023 04:22:41 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id p26so14745346ejx.13;
        Fri, 03 Feb 2023 04:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLaxgQn4PDQR/BBQv1tOCk5Bm8wuAo+A0Cee8gtPIcQ=;
        b=VijK74znB3lxm3Wv08hx0cuv+NIYaGn3TPvhVevaFEV2UQtYVSYb9HSYSvskP3KfCI
         El2d9U9ULRqBD3Mh5XzSU3q33qWmd21R4kLh9MA2WyXcK8k1gmP5+P2mAqbAOOCEfD3K
         UEa/LSXYKATqL8mZnTpfErUegR6HW+/DRgHkQFKmzBLe2sdBordDLbd4JxQSwk2CWuyL
         xGE539G9hlhKENCMYDxAo4Oc8nUsHErN5WKyqb8O/ymi6ifUHfFb64E8ad2lKC/hFwCt
         9fz6ELcOM2CZog2+7k3ZBVlr3Vk8VBmM47v4cmZUoQtu4kxBq5Lhh9iBEylpW7aT8HdO
         7vcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZLaxgQn4PDQR/BBQv1tOCk5Bm8wuAo+A0Cee8gtPIcQ=;
        b=WIaffJU6gBoDHfZKxbcExtfQNL+ECDPeLypy0K2Dsr3gv15m4Ql6Y6K13bZx0KFy4Q
         zY5awjMBs2XG3219fJNKcxG30kTl5DMLwu95al2AIL82r+t/JzTdjZ0CCfkJix39LmWK
         Lex56Y2SMiJNPhofnkcHNCK00cjfJIJ/1w+g501RVTqQoRSF7F2RBWEDhchmF0CHkVVm
         zNMCFjtieBil4tLA7ZdEnofcxRjSa6RobBDPmiekK8iIomKDEPyN6nNrHZc6kSi92IhK
         X2IGGFx9/weQn7NAw2/9cuvs4Yt8o/3mQZi7chtY52eOCz1wkjsF6GeXANmAuTPnGOeW
         pTWQ==
X-Gm-Message-State: AO0yUKX+6TabRbqyLnPwAkk1i0VJBo4rnDK38mT+ZdnxfP6JwHbu6nc/
        +wDXmH5Qth6sN9Zd9YfC2t0=
X-Google-Smtp-Source: AK7set+sDJHmNk3XugDdse9cEEkhtdXQabV8pJSIDsS2BdE79nt9eyvROC5qWXu1RZ+JtWpv29jNdw==
X-Received: by 2002:a17:906:88a:b0:86f:1227:7a48 with SMTP id n10-20020a170906088a00b0086f12277a48mr9768860eje.17.1675426960400;
        Fri, 03 Feb 2023 04:22:40 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id ca10-20020a170906a3ca00b0084d34eec68esm1289828ejb.213.2023.02.03.04.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 04:22:39 -0800 (PST)
Message-ID: <07a16be1-3f96-374c-3a9b-e3920bb4b437@gmail.com>
Date:   Fri, 3 Feb 2023 13:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-9-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 8/8] soc: mediatek: pm-domains: Add support for MT8365
In-Reply-To: <20230105170735.1637416-9-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add the needed board data to support MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mt8365-pm-domains.h | 147 +++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
>   2 files changed, 152 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mt8365-pm-domains.h
> 
> diff --git a/drivers/soc/mediatek/mt8365-pm-domains.h b/drivers/soc/mediatek/mt8365-pm-domains.h
> new file mode 100644
> index 000000000000..8735e833b15b
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8365-pm-domains.h
> @@ -0,0 +1,147 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
> +#define __SOC_MEDIATEK_MT8365_PM_DOMAINS_H
> +
> +#include "mtk-pm-domains.h"
> +#include <dt-bindings/power/mediatek,mt8365-power.h>
> +
> +/*
> + * MT8365 power domain support
> + */
> +
> +static const struct scpsys_domain_data scpsys_domain_data_mt8365[] = {
> +	[MT8365_POWER_DOMAIN_MM] = {
> +		.name = "mm",
> +		.sta_mask = PWR_STATUS_DISP,
> +		.ctl_offs = 0x30c,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.caps = MTK_SCPD_STRICT_BUS_PROTECTION | MTK_SCPD_HAS_WAY_EN,
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(16) | BIT(17), 0x2a8, 0x2ac, 0x258),
> +			BUS_PROT_WR(BIT(1) | BIT(2) | BIT(10) | BIT(11), 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WAY_EN(BIT(6), 0x200, BIT(24), 0x0),
> +			BUS_PROT_WAY_EN(BIT(5), 0x234, BIT(14), 0x28),
> +			BUS_PROT_WR(BIT(6), 0x2a0, 0x2a4, 0x228),


BUS_PROT_WR(BIT(6), 0x2a0, 0x2a4, 0x228) repeates several times in the 
definition. Would it make sense to create a new define like we did with 
BUS_PROT_UPDATE_TOPAXI()? Are this offests are used in other SoCs.

In any case instead of magic numbers the values should be defined in 
include/linux/soc/mediatek/infracfg.h or appropiate header files.

Regards,
Matthias

> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_VENC] = {
> +		.name = "venc",
> +		.sta_mask = PWR_STATUS_VENC,
> +		.ctl_offs = 0x0304,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_smi = {
> +			BUS_PROT_WR(BIT(1), 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_AUDIO] = {
> +		.name = "audio",
> +		.sta_mask = PWR_STATUS_AUDIO,
> +		.ctl_offs = 0x0314,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(12, 8),
> +		.sram_pdn_ack_bits = GENMASK(17, 13),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(27) | BIT(28), 0x2a8, 0x2ac, 0x258),
> +		},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +	[MT8365_POWER_DOMAIN_CONN] = {
> +		.name = "conn",
> +		.sta_mask = PWR_STATUS_CONN,
> +		.ctl_offs = 0x032c,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(13), 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WR(BIT(18), 0x2a8, 0x2ac, 0x258),
> +			BUS_PROT_WR(BIT(14), 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WR(BIT(21), 0x2a8, 0x2ac, 0x258),
> +		},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_KEEP_DEFAULT_OFF,
> +	},
> +	[MT8365_POWER_DOMAIN_MFG] = {
> +		.name = "mfg",
> +		.sta_mask = PWR_STATUS_MFG,
> +		.ctl_offs = 0x0338,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(25), 0x2a0, 0x2a4, 0x228),
> +			BUS_PROT_WR(BIT(21) | BIT(22), 0x2a0, 0x2a4, 0x228),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_CAM] = {
> +		.name = "cam",
> +		.sta_mask = BIT(25),
> +		.ctl_offs = 0x0344,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(9, 8),
> +		.sram_pdn_ack_bits = GENMASK(13, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(19), 0x2a8, 0x2ac, 0x258),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(BIT(2), 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_VDEC] = {
> +		.name = "vdec",
> +		.sta_mask = BIT(31),
> +		.ctl_offs = 0x0370,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(8, 8),
> +		.sram_pdn_ack_bits = GENMASK(12, 12),
> +		.bp_smi = {
> +			BUS_PROT_WR(BIT(3), 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_APU] = {
> +		.name = "apu",
> +		.sta_mask = BIT(16),
> +		.ctl_offs = 0x0378,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(14, 8),
> +		.sram_pdn_ack_bits = GENMASK(21, 15),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(2) | BIT(20), 0x2a8, 0x2ac, 0x258),
> +		},
> +		.bp_smi = {
> +			BUS_PROT_WR(BIT(4), 0x3c4, 0x3c8, 0x3c0),
> +		},
> +	},
> +	[MT8365_POWER_DOMAIN_DSP] = {
> +		.name = "dsp",
> +		.sta_mask = BIT(17),
> +		.ctl_offs = 0x037C,
> +		.pwr_sta_offs = 0x0180,
> +		.pwr_sta2nd_offs = 0x0184,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.bp_infracfg = {
> +			BUS_PROT_WR(BIT(24) | BIT(30) | BIT(31), 0x2a8, 0x2ac, 0x258),
> +		},
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +	},
> +};
> +
> +static const struct scpsys_soc_data mt8365_scpsys_data = {
> +	.domains_data = scpsys_domain_data_mt8365,
> +	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8365),
> +};
> +
> +#endif /* __SOC_MEDIATEK_MT8365_PM_DOMAINS_H */
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 29a9028dd9b3..adb7716df0a8 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -23,6 +23,7 @@
>   #include "mt8186-pm-domains.h"
>   #include "mt8192-pm-domains.h"
>   #include "mt8195-pm-domains.h"
> +#include "mt8365-pm-domains.h"
>   
>   #define MTK_POLL_DELAY_US		10
>   #define MTK_POLL_TIMEOUT		USEC_PER_SEC
> @@ -647,6 +648,10 @@ static const struct of_device_id scpsys_of_match[] = {
>   		.compatible = "mediatek,mt8195-power-controller",
>   		.data = &mt8195_scpsys_data,
>   	},
> +	{
> +		.compatible = "mediatek,mt8365-power-controller",
> +		.data = &mt8365_scpsys_data,
> +	},
>   	{ }
>   };
>   
