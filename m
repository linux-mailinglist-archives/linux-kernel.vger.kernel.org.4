Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8731A64EDD8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiLPP0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiLPP0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:26:31 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA76A6034A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:26:27 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h10so2860062wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=As1qCdI89s9NSmClbVQa7XOiqHvyhjnR3C/4hX9iEVE=;
        b=HeExj6/SAWKcRdVCOu08SaVvuf2i25kLIy/BzbSr4gERCj+TCr2b9cKjrSq0hgsLsA
         1DMVSuXXRx/EVyNgxQL2UAzxYeh6iBBtehKx4snyT3jUnYzxdwvWB+yuRlaVESd9HUxV
         M9+qHgNhhpok2GR8yGSf70faq2ElTYqjC+r134vQc3m5wa50HeCegNAplpbo+Q0ZEsmg
         OiviHRu1cIzM9/fBeMfvAiTaFtWi0mQKPcAf9pQPTq1AsGHo4k3t1GNXW4QX2tqbGpc/
         D6x/aeXd3xeIIy3XqSIBbkDeceZ/COLxd/DUEKiou+Ocfi5ZWGQ9eKLd8LnfIzCQaY7P
         TgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=As1qCdI89s9NSmClbVQa7XOiqHvyhjnR3C/4hX9iEVE=;
        b=yF7LhZmvzd1QC94Ia3oR9ha/MRsmdnwud+/7/uyKyC9H4TuUC2vHp6SpXiE+aF6aF3
         Cv6/0niokG/QWRAwJiCdPSOprYPKCE6GubycdXO6DpcyxNWV0u4SEswPBofzYLN45HFU
         1gOiO2WESvtu7iD4EFWk5uu6m62rIJYAr5W2VgnS97sh4pTppYsyV3GuSah7JmR/OzHQ
         ApIukgFTFzMIwenyWjhrmtXxBixzW1a6ucL3sLoclxaIV+u2pSyYMIFqZ/0WQwTQyzoD
         pfpPKRJdxRfXSbSj9ZB6nNGxFIENDy4FCztDC3/VAYj4mkoqzOJE3tZeCYRCUCYHFh1G
         7t2w==
X-Gm-Message-State: ANoB5pkfiN794buNPhHSrPooC2e98kBPE/LGW1/UCGF3JasXATiGBsIk
        DKP8nDw/vYqPhXcEbJtkz+X0K8MphjSPaA==
X-Google-Smtp-Source: AA0mqf6lKWbGgNMPUFgN0v5CgfdekultbncpRAziPr9XZdW0R0boBmjRrKt5gIKdiMoFA1ZndlCnPQ==
X-Received: by 2002:a5d:6890:0:b0:242:661b:a20 with SMTP id h16-20020a5d6890000000b00242661b0a20mr26854542wru.20.1671204385535;
        Fri, 16 Dec 2022 07:26:25 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b0023657e1b980sm2580355wrw.53.2022.12.16.07.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:26:24 -0800 (PST)
Message-ID: <19d04ffd-a79d-06f6-cb0e-fe56bc18615f@gmail.com>
Date:   Fri, 16 Dec 2022 16:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        alyssa.rosenzweig@collabora.com, nfraprado@collabora.com,
        dmitry.osipenko@collabora.com
References: <20221006115816.66853-1-angelogioacchino.delregno@collabora.com>
 <e04d15ee-9570-c919-5218-91109a88c0cb@gmail.com>
 <fe236ad5-c4e0-1649-6521-ab7c14a1ff15@collabora.com>
 <732e4a1d-8008-072d-cedb-c6859cbfdf98@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [RESEND PATCH v3] soc: mediatek: Introduce
 mediatek-regulator-coupler driver
In-Reply-To: <732e4a1d-8008-072d-cedb-c6859cbfdf98@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On 16/12/2022 14:15, AngeloGioacchino Del Regno wrote:
> Il 21/11/22 13:01, AngeloGioacchino Del Regno ha scritto:
>> Il 21/11/22 12:44, Matthias Brugger ha scritto:
>>>
>>>
>>> On 06/10/2022 13:58, AngeloGioacchino Del Regno wrote:
>>>> This driver currently deals with GPU-SRAM regulator coupling, ensuring
>>>> that the SRAM voltage is always between a specific range of distance to
>>>> the GPU voltage, depending on the SoC, necessary in order to achieve
>>>> system stability across the full range of supported GPU frequencies.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>>> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>>> ---
>>>>
>>>> This driver was successfully tested for more than 3 months.
>>>> GPU DVFS works correctly with no stability issues.
>>>>
>>>> Changes in RESEND,v3:
>>>>   Rebased over next-20221005
>>>>
>>>> Changes in v3:
>>>>   - Added braces to else-if branch
>>>>
>>>> Changes in v2:
>>>>   - Added check for n_coupled
>>>>   - Added check for vgpu to enforce attaching to vgpu<->sram coupling only
>>>>
>>>> Context:
>>>> This driver is the last of the pieces of a bigger puzzle, aiming to finally
>>>> enable Dynamic Voltage/Frequency Scaling for Mali GPUs found on MediaTek
>>>> SoCs on the fully open source graphics stack (Panfrost driver).
>>>>
>>>> No devicetree bindings are provided because this does not require any
>>>> driver-specific binding at all.
>>>>
>>>> Last but not least: it was chosen to have this driver enabled for
>>>> ( ARCH_MEDIATEK && REGULATOR ) without really giving a free configuration
>>>> choice because, once the DVFS mechanism will be fully working, using one
>>>> of the listed MediaTek SoCs *without* this coupling mechanism *will* lead
>>>> to unstabilities and system crashes.
>>>> For COMPILE_TEST, choice is given for obvious reasons.
>>>>
>>>>   drivers/soc/mediatek/Kconfig                 |   5 +
>>>>   drivers/soc/mediatek/Makefile                |   1 +
>>>>   drivers/soc/mediatek/mtk-regulator-coupler.c | 159 +++++++++++++++++++
>>>>   3 files changed, 165 insertions(+)
>>>>   create mode 100644 drivers/soc/mediatek/mtk-regulator-coupler.c
>>>>
>>>> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
>>>> index 40d0cc600cae..30b5afc0e51d 100644
>>>> --- a/drivers/soc/mediatek/Kconfig
>>>> +++ b/drivers/soc/mediatek/Kconfig
>>>> @@ -44,6 +44,11 @@ config MTK_PMIC_WRAP
>>>>         on different MediaTek SoCs. The PMIC wrapper is a proprietary
>>>>         hardware to connect the PMIC.
>>>> +config MTK_REGULATOR_COUPLER
>>>> +    bool "MediaTek SoC Regulator Coupler" if COMPILE_TEST
>>>> +    default ARCH_MEDIATEK
>>>> +    depends on REGULATOR
>>>> +
>>>>   config MTK_SCPSYS
>>>>       bool "MediaTek SCPSYS Support"
>>>>       default ARCH_MEDIATEK
>>>> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
>>>> index 0e9e703c931a..8c0ddacbcde8 100644
>>>> --- a/drivers/soc/mediatek/Makefile
>>>> +++ b/drivers/soc/mediatek/Makefile
>>>> @@ -3,6 +3,7 @@ obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>>>>   obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
>>>>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>>>>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>>>> +obj-$(CONFIG_MTK_REGULATOR_COUPLER) += mtk-regulator-coupler.o
>>>>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>>>>   obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>>>>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>>>> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c 
>>>> b/drivers/soc/mediatek/mtk-regulator-coupler.c
>>>> new file mode 100644
>>>> index 000000000000..ad2ed42aa697
>>>> --- /dev/null
>>>> +++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
>>>> @@ -0,0 +1,159 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Voltage regulators coupler for MediaTek SoCs
>>>> + *
>>>> + * Copyright (C) 2022 Collabora, Ltd.
>>>> + * Author: AngeloGioacchino Del Regno 
>>>> <angelogioacchino.delregno@collabora.com>
>>>> + */
>>>> +
>>>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>>> +
>>>> +#include <linux/init.h>
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/of.h>
>>>> +#include <linux/regulator/coupler.h>
>>>> +#include <linux/regulator/driver.h>
>>>> +#include <linux/regulator/machine.h>
>>>> +#include <linux/suspend.h>
>>>> +
>>>> +#define to_mediatek_coupler(x)    container_of(x, struct 
>>>> mediatek_regulator_coupler, coupler)
>>>> +
>>>> +struct mediatek_regulator_coupler {
>>>> +    struct regulator_coupler coupler;
>>>> +    struct regulator_dev *vsram_rdev;
>>>> +};
>>>> +
>>>> +/*
>>>> + * We currently support only couples of not more than two vregs and
>>>> + * modify the vsram voltage only when changing voltage of vgpu.
>>>> + *
>>>> + * This function is limited to the GPU<->SRAM voltages relationships.
>>>> + */
>>>> +static int mediatek_regulator_balance_voltage(struct regulator_coupler 
>>>> *coupler,
>>>> +                          struct regulator_dev *rdev,
>>>> +                          suspend_state_t state)
>>>> +{
>>>> +    struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
>>>> +    int max_spread = rdev->constraints->max_spread[0];
>>>> +    int vsram_min_uV = mrc->vsram_rdev->constraints->min_uV;
>>>> +    int vsram_max_uV = mrc->vsram_rdev->constraints->max_uV;
>>>> +    int vsram_target_min_uV, vsram_target_max_uV;
>>>> +    int min_uV = 0;
>>>> +    int max_uV = INT_MAX;
>>>> +    int ret;
>>>> +
>>>> +    /*
>>>> +     * If the target device is on, setting the SRAM voltage directly
>>>> +     * is not supported as it scales through its coupled supply voltage.
>>>> +     *
>>>> +     * An exception is made in case the use_count is zero: this means
>>>> +     * that this is the first time we power up the SRAM regulator, which
>>>> +     * implies that the target device has yet to perform initialization
>>>> +     * and setting a voltage at that time is harmless.
>>>> +     */
>>>> +    if (rdev == mrc->vsram_rdev) {
>>>> +        if (rdev->use_count == 0)
>>>> +            return regulator_do_balance_voltage(rdev, state, true);
>>>> +
>>>> +        return -EPERM;
>>>> +    }
>>>> +
>>>> +    ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    if (min_uV == 0) {
>>>> +        ret = regulator_get_voltage_rdev(rdev);
>>>> +        if (ret < 0)
>>>> +            return ret;
>>>> +        min_uV = ret;
>>>> +    }
>>>> +
>>>> +    ret = regulator_check_voltage(rdev, &min_uV, &max_uV);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    /*
>>>> +     * If we're asked to set a voltage less than VSRAM min_uV, set
>>>> +     * the minimum allowed voltage on VSRAM, as in this case it is
>>>> +     * safe to ignore the max_spread parameter.
>>>> +     */
>>>> +    vsram_target_min_uV = max(vsram_min_uV, min_uV + max_spread);
>>>> +    vsram_target_max_uV = min(vsram_max_uV, vsram_target_min_uV + max_spread);
>>>> +
>>>> +    /* Make sure we're not out of range */
>>>> +    vsram_target_min_uV = min(vsram_target_min_uV, vsram_max_uV);
>>>> +
>>>> +    pr_debug("Setting voltage %d-%duV on %s (minuV %d)\n",
>>>> +         vsram_target_min_uV, vsram_target_max_uV,
>>>> +         rdev_get_name(mrc->vsram_rdev), min_uV);
>>>> +
>>>> +    ret = regulator_set_voltage_rdev(mrc->vsram_rdev, vsram_target_min_uV,
>>>> +                     vsram_target_max_uV, state);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    /* The sram voltage is now balanced: update the target vreg voltage */
>>>> +    return regulator_do_balance_voltage(rdev, state, true);
>>>> +}
>>>> +
>>>> +static int mediatek_regulator_attach(struct regulator_coupler *coupler,
>>>> +                     struct regulator_dev *rdev)
>>>> +{
>>>> +    struct mediatek_regulator_coupler *mrc = to_mediatek_coupler(coupler);
>>>> +    const char *rdev_name = rdev_get_name(rdev);
>>>> +
>>>> +    /*
>>>> +     * If we're getting a coupling of more than two regulators here and
>>>> +     * this means that this is surely not a GPU<->SRAM couple: in that
>>>> +     * case, we may want to use another coupler implementation, if any,
>>>> +     * or the generic one: the regulator core will keep walking through
>>>> +     * the list of couplers when any .attach_regulator() cb returns 1.
>>>> +     */
>>>> +    if (rdev->coupling_desc.n_coupled > 2)
>>>> +        return 1;
>>>> +
>>>> +    if (strstr(rdev_name, "sram")) {
>>>
>>> My understanding is, that we have to have either a DT node with 
>>> regulator-name = "sram" property to pollute rdev->constraints->name or some 
>>> regulator_desc->name populated in the drivers/regulator/mt*.c
>>>
>>
>> No, it's not trying to find a regulator named "sram", but any regulator that
>> *contains* the "sram" string in its name, but checks only regulators that are
>> coupled to others. This is the same for the "Vgpu" / "vgpu".
>>
>> Example:
>>
>> Regulator A, coupled to Regulator B.
>>
>> Regulator A name = "Vgpu" or "vgpu", or *vgpu*, or *Vgpu*
>>                     (name must contain either Vgpu or vgpu)
>>
>> Regulator B name = "vsram" or "sram_gpu" or *sram*
>>                     (name must contain "sram").
>>
>> mrc->vsram_rdev = rdev
>>
>> rdev == our Regulator B.
>>
>> We hence return 0 to the coupling API: this will produce the effect of making
>> it use this driver's .balance_voltage() callback instead of the generic one
>> on vgpu<->vsram.
>>
>>
>>> I wasn't able to find either of this, so I wonder how this is supposed to 
>>> work. Please provide pointers to a working and complete implementation of 
>>> this, so that I'm able to judge what is going on and if the approach is the 
>>> correct one.
>>>
>>> I tried to figure out using mt8195-tracking-master-rolling
>>
>> That's the right branch.
>>
>> Let's take MT8192 Asurada as an example of how this works....
>>
>> `mt6359_vsram_others_ldo_reg´ is the SRAM regulator for the GPU:
>> https://gitlab.collabora.com/google/chromeos-kernel/-/blob/mt8195-tracking-master-rolling/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi#L551
>>
>> `mt6359_vsram_others_ldo_reg` regulator-name = "vsram_others";
>>                                                   ^^^^
>> Contains "sram", and this regulator is also
>>
>>      regulator-coupled-with = <&mt6315_7_vbuck1>;
>>
>> `mt6315_7_vbuck1` regulator-name = "Vgpu";
>>                                      ^^^^
>> Contains "Vgpu", and this regulator is also
>>
>>      regulator-coupled-with = <&mt6359_vsram_others_ldo_reg>;
>>
>> That's how the coupling works in this case.
>>
>>
>> Now, looking at case exclusions:
>> In MT8192 Asurada (or, actually, mt6359.dtsi) we have other regulators that do
>> actually contain "sram" in their name, like "vsram_proc1" and 
>> "vsram_others_sshub".
>>
>> These regulators will be ignored, as they are *not* coupled with Vgpu.
>>
>>
>> What this driver currently does in this regard is:
>> 1. Regulator attach is called only on *coupled* regulators, not on the others
>> 2. If the regulator contains name "vgpu" or "Vgpu" or "sram" we're good,
>>     otherwise we don't attach the balance_voltage logic of this driver to
>>     the unmatched regulators.
>>
>>
>> Does this explanation clarify your doubts?
>>
>> Regards,
>> Angelo
>>
> 
> Matthias, please don't forget about this one :-)
> 

Unfortunately I have to leave now and didn't had time to look more into it. So 
I'll write just my suspicion. So please feel free to correct me if I'm totally 
wrong (I know you will do anyway ;)

1) When the regulator-coupler driver was introduced the driver was bound by a 
compatible, but we use arch_initcall(...) for it.
2) I really don't like the hardcoded search for a the regulator name in the 
mediatek_regulator_attach function. I haven't seen that in the Nvidia driver, 
also I had no time to understand how they decide which regulators need to be 
coupled. My instinct would tell me that this should be described in device-tree.

Have a nice weekend!
Matthias
