Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933FF632105
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiKULpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiKULou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:44:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63BFCEB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:44:47 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v7so8289367wmn.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cJNFpgX+WPgKtF2uKtRz218Ghby59uXyddoumWPaKU=;
        b=OaEuUKyfoAaMdgYQNKRmoDkhwSAE7/QuMoSzftzYufK7FWPHhkdJM6w2YSC4dnw+yq
         k2igenvromNW1CPaKH9zofthP0JkTaIENP/TdasLCiACMGbcV7nDt8mxx6KOLXtGi5OM
         MbIooZj/KO5J6gLBCWK3zp/wiYi1Fp26lSaWlYaT/XcLm0zAGSwzvOXvieWBBS41mE+z
         FOlSwoM62yiSSGD9fC4xVn7PkSuD287izy/yfygUkkLqQ+Ix7YbTCYY+r6yshpD0yf+Y
         1Qr2+3OAxRnO1dF7FFsmwwx6yG+luAkB/7K6KAVN4wj1TTwQdTDIt7ko21VDQaqoZkN2
         Qfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cJNFpgX+WPgKtF2uKtRz218Ghby59uXyddoumWPaKU=;
        b=KH1Dq/5Xb//gWLtSGL6CGVzgFQq2MnCoGj7tXs+uCXU/rIjya/PFQlCBxkY2q39Rfb
         A2bM/hLYk01qhwIHShUr+OYtAuhj+mxQbZkk/mTNgLtzEFPTEDtY+Tck0YlX67m5byQ8
         WF1edi2c8rio90TooFSIAeNZDXwc/3PU/R8ILyeslzqiCORJTCaOyj6TYBBvn6x0MNCY
         FOM5k4rVg1nmaYfxZnoQr83cvLTNlyBPhwTyFJo2qnaL/CsStix6vqXLw5ljLWTVmNtS
         7LwFn3kL2Gx/GggOLiqiha7JP8+/5DjqUrphZHJuYWwNG3hWSLBSxUppTnr0VzenTlO4
         zzsg==
X-Gm-Message-State: ANoB5pnXN+EhRIssyevYYGpTw55jlWypOaBRDnyZh+2F+NrfYqROX78I
        rFQa5kZU5GestEBAvPk+bo8=
X-Google-Smtp-Source: AA0mqf4IlsGiJBNapasCkSsZHk2LZYzeWXyxCUrHNCkbynrN76CSm13L3kk/6i7If8rIVKzhdK8HGA==
X-Received: by 2002:a05:600c:5014:b0:3cf:72d9:10b0 with SMTP id n20-20020a05600c501400b003cf72d910b0mr15836099wmr.26.1669031085933;
        Mon, 21 Nov 2022 03:44:45 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003cfd0bd8c0asm14806911wms.30.2022.11.21.03.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:44:43 -0800 (PST)
Message-ID: <e04d15ee-9570-c919-5218-91109a88c0cb@gmail.com>
Date:   Mon, 21 Nov 2022 12:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com
References: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RESEND PATCH v3] soc: mediatek: Introduce
 mediatek-regulator-coupler driver
In-Reply-To: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/10/2022 13:58, AngeloGioacchino Del Regno wrote:
> This driver currently deals with GPU-SRAM regulator coupling, ensuring
> that the SRAM voltage is always between a specific range of distance to
> the GPU voltage, depending on the SoC, necessary in order to achieve
> system stability across the full range of supported GPU frequencies.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
> 
> This driver was successfully tested for more than 3 months.
> GPU DVFS works correctly with no stability issues.
> 
> Changes in RESEND,v3:
>   Rebased over next-20221005
> 
> Changes in v3:
>   - Added braces to else-if branch
> 
> Changes in v2:
>   - Added check for n_coupled
>   - Added check for vgpu to enforce attaching to vgpu<->sram coupling only
> 
> Context:
> This driver is the last of the pieces of a bigger puzzle, aiming to finally
> enable Dynamic Voltage/Frequency Scaling for Mali GPUs found on MediaTek
> SoCs on the fully open source graphics stack (Panfrost driver).
> 
> No devicetree bindings are provided because this does not require any
> driver-specific binding at all.
> 
> Last but not least: it was chosen to have this driver enabled for
> ( ARCH_MEDIATEK && REGULATOR ) without really giving a free configuration
> choice because, once the DVFS mechanism will be fully working, using one
> of the listed MediaTek SoCs *without* this coupling mechanism *will* lead
> to unstabilities and system crashes.
> For COMPILE_TEST, choice is given for obvious reasons.
> 
>   drivers/soc/mediatek/Kconfig                 |   5 +
>   drivers/soc/mediatek/Makefile                |   1 +
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 159 +++++++++++++++++++
>   3 files changed, 165 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-regulator-coupler.c
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 40d0cc600cae..30b5afc0e51d 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -44,6 +44,11 @@ config MTK_PMIC_WRAP
>   	  on different MediaTek SoCs. The PMIC wrapper is a proprietary
>   	  hardware to connect the PMIC.
>   
> +config MTK_REGULATOR_COUPLER
> +	bool "MediaTek SoC Regulator Coupler" if COMPILE_TEST
> +	default ARCH_MEDIATEK
> +	depends on REGULATOR
> +
>   config MTK_SCPSYS
>   	bool "MediaTek SCPSYS Support"
>   	default ARCH_MEDIATEK
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 0e9e703c931a..8c0ddacbcde8 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>   obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> +obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>   obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
> new file mode 100644
> index 000000000000..ad2ed42aa697
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Voltage regulators coupler for MediaTek SoCs
> + *
> + * Copyright (C) 2022 Collabora, Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/regulator/coupler.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/suspend.h>
> +
> +#define to_mediatek_coupler(x)	container_of(x, struct mediatek_regulator_coupler, coupler)
> +
> +struct mediatek_regulator_coupler {
> +	struct regulator_coupler coupler;
> +	struct regulator_dev *vsram_rdev;
> +};
> +
> +/*
> + * We currently support only couples of not more than two vregs and
> + * modify the vsram voltage only when changing voltage of vgpu.
> + *
> + * This function is limited to the GPU<->SRAM voltages relationships.
> + */
> +static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
> +					      struct regulator_dev *rdev,
> +					      suspend_state_t state)
> +{
> +	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
> +	int max_spread = rdev->constraints->max_spread[0];
> +	int vsram_min_uV = mrc->vsram_rdev->constraints->min_uV;
> +	int vsram_max_uV = mrc->vsram_rdev->constraints->max_uV;
> +	int vsram_target_min_uV, vsram_target_max_uV;
> +	int min_uV = 0;
> +	int max_uV = INT_MAX;
> +	int ret;
> +
> +	/*
> +	 * If the target device is on, setting the SRAM voltage directly
> +	 * is not supported as it scales through its coupled supply voltage.
> +	 *
> +	 * An exception is made in case the use_count is zero: this means
> +	 * that this is the first time we power up the SRAM regulator, which
> +	 * implies that the target device has yet to perform initialization
> +	 * and setting a voltage at that time is harmless.
> +	 */
> +	if (rdev == mrc->vsram_rdev) {
> +		if (rdev->use_count == 0)
> +			return regulator_do_balance_voltage(rdev, state, true);
> +
> +		return -EPERM;
> +	}
> +
> +	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (min_uV == 0) {
> +		ret = regulator_get_voltage_rdev(rdev);
> +		if (ret < 0)
> +			return ret;
> +		min_uV = ret;
> +	}
> +
> +	ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * If we're asked to set a voltage less than VSRAM min_uV, set
> +	 * the minimum allowed voltage on VSRAM, as in this case it is
> +	 * safe to ignore the max_spread parameter.
> +	 */
> +	vsram_target_min_uV = max(vsram_min_uV, min_uV + max_spread);
> +	vsram_target_max_uV = min(vsram_max_uV, vsram_target_min_uV + max_spread);
> +
> +	/* Make sure we're not out of range */
> +	vsram_target_min_uV = min(vsram_target_min_uV, vsram_max_uV);
> +
> +	pr_debug("Setting voltage %d-%duV on %s (minuV %d)\n",
> +		 vsram_target_min_uV, vsram_target_max_uV,
> +		 rdev_get_name(mrc->vsram_rdev), min_uV);
> +
> +	ret = regulator_set_voltage_rdev(mrc->vsram_rdev, vsram_target_min_uV,
> +					 vsram_target_max_uV, state);
> +	if (ret)
> +		return ret;
> +
> +	/* The sram voltage is now balanced: update the target vreg voltage */
> +	return regulator_do_balance_voltage(rdev, state, true);
> +}
> +
> +static int mediatek_regulator_attach(struct regulator_coupler *coupler,
> +				     struct regulator_dev *rdev)
> +{
> +	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
> +	const char *rdev_name = rdev_get_name(rdev);
> +
> +	/*
> +	 * If we're getting a coupling of more than two regulators here and
> +	 * this means that this is surely not a GPU<->SRAM couple: in that
> +	 * case, we may want to use another coupler implementation, if any,
> +	 * or the generic one: the regulator core will keep walking through
> +	 * the list of couplers when any .attach_regulator() cb returns 1.
> +	 */
> +	if (rdev->coupling_desc.n_coupled > 2)
> +		return 1;
> +
> +	if (strstr(rdev_name, "sram")) {

My understanding is, that we have to have either a DT node with regulator-name = 
"sram" property to pollute rdev->constraints->name or some regulator_desc->name 
populated in the drivers/regulator/mt*.c

I wasn't able to find either of this, so I wonder how this is supposed to work. 
Please provide pointers to a working and complete implementation of this, so 
that I'm able to judge what is going on and if the approach is the correct one.

I tried to figure out using mt8195-tracking-master-rolling

Regards,
Matthias

> +		if (mrc->vsram_rdev)
> +			return -EINVAL;
> +		mrc->vsram_rdev = rdev;
> +	} else if (!strstr(rdev_name, "vgpu") && !strstr(rdev_name, "Vgpu")) {
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mediatek_regulator_detach(struct regulator_coupler *coupler,
> +				     struct regulator_dev *rdev)
> +{
> +	struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
> +
> +	if (rdev == mrc->vsram_rdev)
> +		mrc->vsram_rdev = NULL;
> +
> +	return 0;
> +}
> +
> +static struct mediatek_regulator_coupler mediatek_coupler = {
> +	.coupler = {
> +		.attach_regulator = mediatek_regulator_attach,
> +		.detach_regulator = mediatek_regulator_detach,
> +		.balance_voltage = mediatek_regulator_balance_voltage,
> +	},
> +};
> +
> +static int mediatek_regulator_coupler_init(void)
> +{
> +	if (!of_machine_is_compatible("mediatek,mt8183") &&
> +	    !of_machine_is_compatible("mediatek,mt8186") &&
> +	    !of_machine_is_compatible("mediatek,mt8192"))
> +		return 0;
> +
> +	return regulator_coupler_register(&mediatek_coupler.coupler);
> +}
> +arch_initcall(mediatek_regulator_coupler_init);
> +
> +MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
> +MODULE_DESCRIPTION("MediaTek Regulator Coupler driver");
> +MODULE_LICENSE("GPL");
