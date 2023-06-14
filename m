Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA83972F68B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbjFNHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243449AbjFNHjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:39:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023131FD7;
        Wed, 14 Jun 2023 00:39:09 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B4D9B6606F41;
        Wed, 14 Jun 2023 08:39:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686728348;
        bh=XhHDQPM3gH4f/0+6CW+IBuwrm5ghoknkZKJMq0fr8qI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ODufwc/1QflaTsd+A/fLrmQMepg7AY/ri9tK7Hp3+/MxHeO0izqpzV51AvgRl1O8v
         DeuF/FGKQtW0MKCOV627U2CEUBSmLgY6WzNdNB/cxTaLFKCB9PH0UBvVlE6DpCFBFv
         BOU8gcHPuw5vPgaSn3eRL9S/Y2baHeKsQ6V/moyVKj+mCJJLoxJx4630Jh3GfUYnqL
         hTl1IYL+M2lYe5W/Ed830cQjnG1UJJIjJ0paJXP9XNAHkSQBmnYVxYTDprqAJNCcW3
         esmONNGDn/9RtmBNHvCF6fhhC2WnOsqsXZG1OnQuX8UK9HI4ma034/olWDfMb4lF82
         vvsoWZvbHfsdQ==
Message-ID: <1d4ac52a-4cc8-a346-b005-f5cebc8d9eb8@collabora.com>
Date:   Wed, 14 Jun 2023 09:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/9] regulator: mt6358: Drop *_SSHUB regulators
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230609083009.2822259-1-wenst@chromium.org>
 <20230609083009.2822259-5-wenst@chromium.org>
 <a7b7476d-3bbd-5503-db3d-5d57356764f8@collabora.com>
 <CAGXv+5FskpxjATk5aJA4CG0GyarO55XXYSYkvxWd-40d4ML8RQ@mail.gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FskpxjATk5aJA4CG0GyarO55XXYSYkvxWd-40d4ML8RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/06/23 06:45, Chen-Yu Tsai ha scritto:
> On Fri, Jun 9, 2023 at 5:03 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 09/06/23 10:30, Chen-Yu Tsai ha scritto:
>>> The *_SSHUB regulators are actually alternate configuration interfaces
>>> for their non *_SSHUB counterparts. They are not separate regulator
>>> outputs. These registers are intended for the companion processor to
>>> use to configure the power rails while the main processor is sleeping.
>>> They are not intended for the main operating system to use.
>>>
>>> Since they are not real outputs they shouldn't be modeled separately.
>>> Remove them. Luckily no device tree actually uses them.
>>>
>>
>> I'm not sure that MT6358/6366 are used only on Chromebook SoCs, and that this SSHUB
>> mechanism (companion processor) is the same across all firmwares.
> 
> AFAICT from Internet sources there's also the MT6771 and MT6781, which
> are used on some phones.
> 
> But what part are you concerned about? The upstream regulator driver does
> not actually have any code to switch to/from normal operation and SSHUB
> mode.
> 
> In a downstream kernel I found that the SSHUB mode is only used if SCP is
> doing DVFS [1]. In that same kernel, the regulator driver [2] doesn't even
> list the *_SSHUB versions. So if SCP DVFS is used, the regulator driver
> has no idea what's going on, and can't interfere either, which I think is
> actually a good thing. Only one side should have complete control of one
> output.
> 

Ok, I'm sold! :-P

Jokes apart, thanks for clarifying. At this point, I agree with you in that this
is safe to do, so:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


P.S.: Sorry for the late reply and thank you for the links to that old
downstream kernel.

Cheers,
Angelo

> ChenYu
> 
> [1] https://github.com/nokia-dev/android_kernel_nokia_mt6771/blob/android-9.0/drivers/misc/mediatek/scp/mt6771/scp_dvfs.c
> [2] https://github.com/nokia-dev/android_kernel_nokia_mt6771/blob/android-9.0/drivers/misc/mediatek/pmic/mt6358/v1/regulator_codegen.c
> 
>> I'd like someone from MediaTek to confirm that this is valid for both Chromebook
>> and Smartphone firmwares.
>>
>> Regards,
>> Angelo
>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>    drivers/regulator/mt6358-regulator.c       | 14 --------------
>>>    include/linux/regulator/mt6358-regulator.h |  4 ----
>>>    2 files changed, 18 deletions(-)
>>>
>>> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
>>> index faf6b0757019..946a251a8b3a 100644
>>> --- a/drivers/regulator/mt6358-regulator.c
>>> +++ b/drivers/regulator/mt6358-regulator.c
>>> @@ -505,9 +505,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>>>        MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>>>                    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>>>                    MT6358_VCORE_VGPU_ANA_CON0, 1),
>>> -     MT6358_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
>>> -                 buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
>>> -                 MT6358_VCORE_VGPU_ANA_CON0, 1),
>>>        MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>>>                    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>>>                    MT6358_VPA_ANA_CON0, 3),
>>> @@ -583,10 +580,6 @@ static struct mt6358_regulator_info mt6358_regulators[] = {
>>>        MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>>>                    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>>>                    MT6358_LDO_VSRAM_CON2, 0x7f),
>>> -     MT6358_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
>>> -                 1293750, 6250, buck_volt_range1,
>>> -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
>>> -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>>>        MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>>>                    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>>>                    MT6358_LDO_VSRAM_CON3, 0x7f),
>>> @@ -603,9 +596,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>>>        MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
>>>                    buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f,
>>>                    MT6358_VCORE_VGPU_ANA_CON0, 1),
>>> -     MT6366_BUCK("buck_vcore_sshub", VCORE_SSHUB, 500000, 1293750, 6250,
>>> -                 buck_volt_range1, 0x7f, MT6358_BUCK_VCORE_SSHUB_ELR0, 0x7f,
>>> -                 MT6358_VCORE_VGPU_ANA_CON0, 1),
>>>        MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
>>>                    buck_volt_range3, 0x3f, MT6358_BUCK_VPA_DBG0, 0x3f,
>>>                    MT6358_VPA_ANA_CON0, 3),
>>> @@ -670,10 +660,6 @@ static struct mt6358_regulator_info mt6366_regulators[] = {
>>>        MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
>>>                    buck_volt_range1, MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00,
>>>                    MT6358_LDO_VSRAM_CON2, 0x7f),
>>> -     MT6366_LDO1("ldo_vsram_others_sshub", VSRAM_OTHERS_SSHUB, 500000,
>>> -                 1293750, 6250, buck_volt_range1,
>>> -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f,
>>> -                 MT6358_LDO_VSRAM_OTHERS_SSHUB_CON1, 0x7f),
>>>        MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
>>>                    buck_volt_range1, MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00,
>>>                    MT6358_LDO_VSRAM_CON3, 0x7f),
>>> diff --git a/include/linux/regulator/mt6358-regulator.h b/include/linux/regulator/mt6358-regulator.h
>>> index a4307cd9edd6..c71a6a9fce7a 100644
>>> --- a/include/linux/regulator/mt6358-regulator.h
>>> +++ b/include/linux/regulator/mt6358-regulator.h
>>> @@ -47,8 +47,6 @@ enum {
>>>        MT6358_ID_VLDO28,
>>>        MT6358_ID_VAUD28,
>>>        MT6358_ID_VSIM2,
>>> -     MT6358_ID_VCORE_SSHUB,
>>> -     MT6358_ID_VSRAM_OTHERS_SSHUB,
>>>        MT6358_ID_RG_MAX,
>>>    };
>>>
>>> @@ -88,8 +86,6 @@ enum {
>>>        MT6366_ID_VMC,
>>>        MT6366_ID_VAUD28,
>>>        MT6366_ID_VSIM2,
>>> -     MT6366_ID_VCORE_SSHUB,
>>> -     MT6366_ID_VSRAM_OTHERS_SSHUB,
>>>        MT6366_ID_RG_MAX,
>>>    };
>>>
>>
