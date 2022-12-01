Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D98563ECAF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:42:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiLAJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiLAJmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:42:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7FD54471;
        Thu,  1 Dec 2022 01:42:13 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA94D66025DF;
        Thu,  1 Dec 2022 09:42:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669887731;
        bh=VdGBaS0XWeFJmcCrunXO7sc+tv9eoriihu4qmG553GA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NSZBzHBUHkeY2OuO+h2pNjHg/Ubz8w5zyptGtmmW3HASRCOA42oynDVSQVo17MNCD
         q2iF4uFpLXRhPRW8FTQLVr5VkrdMzGnXuXswiZFFsnqcF+1SX2Ctiu9AsphaJJ7eDy
         QSR52YDp3Hvy55/9AAI/lIviHHxrFoX9xSGYbsyUbIvvJgIElR9E4A/xAhPem2w1Hn
         LGqEwhkb+AMaJmfEHXbwfvUTJe0rIC6At1+MSgkM5DrB0fYCKZKjxjMdshAAhVYJ7Q
         zLq1djNofBb3WKjH7DaUaBivb50xgjZg7lydi3X2SLo5jSYC9R0NMubNuiDlHyM6n6
         5foWAcXBfpV5A==
Message-ID: <6c8343c4-a8ed-1a4c-a518-1c49a9d6b056@collabora.com>
Date:   Thu, 1 Dec 2022 10:42:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 03/12] ASoC: mediatek: mt8188: support audsys clock
Content-Language: en-US
To:     =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-4-trevor.wu@mediatek.com>
 <de66f0e3-7694-7315-c896-9211259a1a17@collabora.com>
 <776557c0fda5a538549ee0d4f4b7f482b0d69934.camel@mediatek.com>
 <473d67ed-198f-82c6-9f32-5827c1f8c852@collabora.com>
 <500f80b1ac84101af482bdfcb46671d523d51068.camel@mediatek.com>
 <360a5f27-8abc-938c-04c7-13ea65b5a89f@collabora.com>
 <7dfdb4866ccf7356c2a8beb0359e5b62df4f245f.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7dfdb4866ccf7356c2a8beb0359e5b62df4f245f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 09:43, Trevor Wu (吳文良) ha scritto:
> On Wed, 2022-10-26 at 10:18 +0200, AngeloGioacchino Del Regno wrote:
>> Il 26/10/22 06:10, Trevor Wu (吳文良) ha scritto:
>>> On Tue, 2022-10-25 at 12:18 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> Il 21/10/22 11:58, Trevor Wu (吳文良) ha scritto:
>>>>> On Fri, 2022-10-21 at 10:41 +0200, AngeloGioacchino Del Regno
>>>>> wrote:
>>>>>> Il 21/10/22 10:27, Trevor Wu ha scritto:
>>>>>>> Add mt8188 audio cg clock control. Audio clock gates are
>>>>>>> registered
>>>>>>> to CCF
>>>>>>> for reference count and clock parent management.
>>>>>>>
>>>>>>> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
>>>>>>> ---
>>>>>>>      sound/soc/mediatek/mt8188/mt8188-audsys-clk.c | 206
>>>>>>> ++++++++++++++++++
>>>>>>>      sound/soc/mediatek/mt8188/mt8188-audsys-clk.h |  15 ++
>>>>>>>      .../soc/mediatek/mt8188/mt8188-audsys-clkid.h |  83
>>>>>>> +++++++
>>>>>>>      3 files changed, 304 insertions(+)
>>>>>>>      create mode 100644 sound/soc/mediatek/mt8188/mt8188-
>>>>>>> audsys-
>>>>>>> clk.c
>>>>>>>      create mode 100644 sound/soc/mediatek/mt8188/mt8188-
>>>>>>> audsys-
>>>>>>> clk.h
>>>>>>>      create mode 100644 sound/soc/mediatek/mt8188/mt8188-
>>>>>>> audsys-
>>>>>>> clkid.h
>>>>>>>
>>>>>>> diff --git a/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
>>>>>>> b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..1f294231d4c2
>>>>>>> --- /dev/null
>>>>>>> +++ b/sound/soc/mediatek/mt8188/mt8188-audsys-clk.c
>>>>>>> @@ -0,0 +1,206 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>> +/*
>>>>>>> + * mt8188-audsys-clk.c  --  MediaTek 8188 audsys clock
>>>>>>> control
>>>>>>> + *
>>>>>>> + * Copyright (c) 2022 MediaTek Inc.
>>>>>>> + * Author: Chun-Chia Chiu <chun-chia.chiu@mediatek.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <linux/clk.h>
>>>>>>> +#include <linux/clk-provider.h>
>>>>>>> +#include <linux/clkdev.h>
>>>>>>> +#include "mt8188-afe-common.h"
>>>>>>> +#include "mt8188-audsys-clk.h"
>>>>>>> +#include "mt8188-audsys-clkid.h"
>>>>>>> +#include "mt8188-reg.h"
>>>>>>> +
>>>>>>> +struct afe_gate {
>>>>>>> +	int id;
>>>>>>> +	const char *name;
>>>>>>> +	const char *parent_name;
>>>>>>> +	int reg;
>>>>>>> +	u8 bit;
>>>>>>> +	const struct clk_ops *ops;
>>>>>>> +	unsigned long flags;
>>>>>>> +	u8 cg_flags;
>>>>>>> +};
>>>>>>> +
>>>>>>> +#define GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit,
>>>>>>> _flags,
>>>>>>> _cgflags) {\
>>>>>>> +		.id = _id,					
>>>>>>> \
>>>>>>> +		.name = _name,					
>>>>>>> \
>>>>>>> +		.parent_name = _parent,				
>>>>>>> \
>>>>>>> +		.reg = _reg,					
>>>>>>> \
>>>>>>> +		.bit = _bit,					
>>>>>>> \
>>>>>>> +		.flags = _flags,				
>>>>>>> \
>>>>>>> +		.cg_flags = _cgflags,				
>>>>>>> \
>>>>>>> +	}
>>>>>>> +
>>>>>>> +#define GATE_AFE(_id, _name, _parent, _reg, _bit)		
>>>>>>> \
>>>>>>> +	GATE_AFE_FLAGS(_id, _name, _parent, _reg, _bit,		
>>>>>>> \
>>>>>>> +		       CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
>>>>>>> CLK_GATE_SET_TO_DISABLE)
>>>>>>
>>>>>> Can you please explain what's the reason for
>>>>>> CLK_IGNORE_UNUSED
>>>>>> here?
>>>>>> Maybe we can solve some issue that you're facing in a cleaner
>>>>>> way.
>>>>>>
>>>>>> Regards,
>>>>>> Angelo
>>>>>
>>>>> Hi Angelo,
>>>>>
>>>>> Because clk_disable_unused() calls clk_core_is_enabled(),
>>>>> register
>>>>> access happens in is_enabled() ops.
>>>>> At the moment, the power for register access is not enabled, so
>>>>> the
>>>>> register read results in CPU hang.
>>>>>
>>>>> That's why I added CLK_IGNORE_UNUSED here, but it can't resolve
>>>>> all
>>>>> issues. Actually, we met same problem when "cat
>>>>> /sys/kernel/debug/clk/clk_summary" is used. We are still
>>>>> suffering
>>>>> the
>>>>> problem.
>>>>>
>>>>> I'm not sure if I can implement clk ops by myself, and exclude
>>>>> the
>>>>> registration of is_enabled() ops.
>>>>>
>>>>
>>>> Is the power for register access enabled with a power domain?
>>>>
>>>> Check drivers/clk/clk.c, grep for core->rpm_enabled.
>>>>
>>>> If you enable runtime PM before registering the clocks, and you
>>>> register them
>>>> with the right struct device, the clock API will enable power for
>>>> you
>>>> before
>>>> trying to read the clock enable status.
>>>>
>>>> Regards,
>>>> Angelo
>>>>
>>>
>>> Hi Angelo,
>>>
>>> I tried the way in MT8195, but it caused circular lock problem.
>>>
>>> Because mtcmos depends on some clocks, clk_bulk_prepare_enable is
>>> also
>>> used in scpsys_power_on()[1].
>>> If the clock also depends on the power domain, this results in the
>>> circular lock problem.
>>> That's why I don't bind the power domain with these clocks.
>>>
>>
>> This is not supposed to happen... can you please give me a (MT8195)
>> patch to
>> reproduce the issue that you're seeing?
>>
>> I would like to investigate that to check if I can come up with a
>> good solution.
>>
>> Thanks,
>> Angelo
> 
> 
> Hi Angelo,
> 
> Sorry for replying late.
> The original implementation about clock depending on power domain was a
> cusotomized request, and it's not based on upstream code base. So I
> can't apply the implementation directly. I tried to implement the
> suggested solution in upstream code, but I can't reproduce the problem
> successfully.
> 
> At the same time, we reviewed the difference between MT8195 and MT8188.
> It's found that ADSP_INFRA should be kept ON to resolve the register
> r/w access limitation in MT8188, so we can match the hardware design in
> MT8195.
> 
> After discussing internally, we decided in favour of ADSP_INFRA
> soloution. Althought the lock problem can't be seen, the new lock
> relationship(prepare_lock -> genpd lock) is actually created.
> 
> In conclusion, ADSP_INFRA will be kept always on and I will remove
> CLK_IGNORE_UNUSED flag in V3.
> 

As far as the power consumption increase is ignorable (so, power consumption
is very little more), that's a good decision and I support that.

Regards,
Angelo

> Thanks,
> Trevor
> 
>>
>>> [1]
>>>
> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v6.1-rc2/source/drivers/soc/mediatek/mtk-pm-domains.c__;!!CTRNKA9wMg0ARbw!yVFCD-B4VZOxDXTGgDtpB0mJbVoY9tHODeICxthAC33lXMq6LRVTGS-4V-Dj129_cA$
>>>   
>>>
>>> Thanks,
>>> Trevor
>>>
>>>
>>
>>
>>


