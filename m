Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B94652330
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiLTOzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiLTOzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:55:08 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE0EBE3;
        Tue, 20 Dec 2022 06:55:06 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja17so8925243wmb.3;
        Tue, 20 Dec 2022 06:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FABScePfHhtiT4W0R9UQycfClI9Dz9MSmeYtGfbseBY=;
        b=A5vuOF5V/5Y5313VZLFZnPM/9kPv8AvbfZs33LTYh1aEn8HNVJZLC7Kv2jtataUO63
         7OSEcSsJ/j21j7se1crAeyWbw5zb+ZYAH/VsVtF5fVIZiscOb3bD6XNAv1AX3AbQLIHX
         cjlZL/0DmP0nPNtBec2uo2QjLVxl8R7tlmeBoic1iRdBLB2KsYN9oL2ocZ3evxTi660J
         FlJZiLt46cS0OijxzyiHzb8RQCTKEqBZwE0Ey/c4ezP3uvxW/D01IBZyhxZj+ZLkF0DP
         Jc+BJ2Khnw26NWBRqGrf+9bXLViU4qW2OVRRmhu4uU3hwfJ2tiWKB85dezYEvR0C67Iz
         Mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FABScePfHhtiT4W0R9UQycfClI9Dz9MSmeYtGfbseBY=;
        b=iyNCvZimVidQTWn6OHIYiaym8AOB0tbr4XpDG201Dpcp/9vX+Z16a3mxDW9E2L0rW6
         bSE/SHgqJPpdZ1FBthruV0IQWagf6nIrHzeOWvENvKMa5eFBPK6bkS61FMKRi4vsHXiZ
         bAASf3mzUYWeZUtSF4NJ9ZTUwyJVc67H5yfyXODoa8/HaiNqNs892dYNKBzuykX5mXKg
         yJmVM+FV8wZ4nrgsLMW/sLq7Z6W7RV8kXf4HdoR/Ov+1+T7QYzrI4GWbC0ELHnAO6KM9
         TVGbwxrflh1bLVkXVT9LCsf2YZbprOxK33XN5pv++jmzXZVq0iKMNEngCqB4qnbwhwcG
         fnQg==
X-Gm-Message-State: AFqh2kr9XjbjnBGrXFXg3MU4yZiZusX8eEGdHeX8m3ADqYSGtyMxsWGy
        TNvFPHu3BKD9EsxF5kPuFLjboHkV/7s=
X-Google-Smtp-Source: AMrXdXvJI+XNtdN6GZhX4ynZ9rh+zGZxWZNvuHqH1H12zhUjAcFAfqF01kB/5dOEDsNxwNVResOqQw==
X-Received: by 2002:a05:600c:1f11:b0:3d3:5063:cfe5 with SMTP id bd17-20020a05600c1f1100b003d35063cfe5mr7853231wmb.2.1671548105192;
        Tue, 20 Dec 2022 06:55:05 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c350f00b003c71358a42dsm32054980wmq.18.2022.12.20.06.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:55:04 -0800 (PST)
Message-ID: <0cf869ae-bbb5-7cb5-eadc-ceaf2f7015dc@gmail.com>
Date:   Tue, 20 Dec 2022 15:55:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 0/8] add support MDP3 on MT8195 platform
Content-Language: en-US
To:     =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20221207094921.15450-1-moudy.ho@mediatek.com>
 <5692faa0-6d7e-774f-9d6a-a495b44bdb3e@gmail.com>
 <dba479ea-968f-89eb-fc59-8235cbb2783a@gmail.com>
 <abfa4b935938a0b00bcccbc10e1a748f49f3497c.camel@mediatek.com>
 <212871d92b8062250c83c9db006c1c628b798280.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <212871d92b8062250c83c9db006c1c628b798280.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moudy,

On 20/12/2022 04:40, Moudy Ho (何宗原) wrote:
> On Tue, 2022-12-20 at 10:14 +0800, moudy ho wrote:
>> On Mon, 2022-12-19 at 16:17 +0100, Matthias Brugger wrote:
>>>
>>> On 16/12/2022 13:33, Matthias Brugger wrote:
>>>>
>>>> Whole series applied, thanks!
>>>>
>>>
>>> And now, whole series reverted, please see comment in 1/8.
>>>
>>> Regards,
>>> Matthias
>>>
>>
>> Hi Matthias,
>>
>> May I send a new series without a fallback compatible like the mt8188
>> VDOSYS does?
>>
>>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20221206020046.11333-3-nathan.lu@mediatek.com/
>>
>> Regards,
>> Moudy
> 
> Hi Matthias,
> 
> Sorry for the inaccurate information, the warning mentioned in [1/8] is
> because vppsys 0/1 has already been defined in "mediatek,mt8195-
> clock.yaml" as follows:
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20210914021633.26377-2-chun-jie.chen@mediatek.com/
> 
> Is it possible to fix it by just removing [1/8], or should I send a new
> series?
> 

You will need to remove it from the clock binding and of course from the clock 
drivers. One example is this one:
https://patchwork.kernel.org/project/linux-mediatek/patch/20210914021633.26377-21-chun-jie.chen@mediatek.com/

In the end the mmsys will probe by the compatible and will then probe the clock 
driver as a platform driver.

Best regards,
Matthias


> Regards,
> Moudy
> 
>>>> On 07/12/2022 10:49, Moudy Ho wrote:
>>>>> From: mtk18742 <moudy.ho@mediatek.com>
>>>>>
>>>>> Changes since v3:
>>>>> - Rebase on linux-next
>>>>>
>>>>> Changes since v2:
>>>>> - Depend on :
>>>>>     [1]
>>>>>
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097__;!!CTRNKA9wMg0ARbw!giZVy8TiFNylgWKOjI75fSmleN6UlckPuiXzFf5jbdVgFbHdIxG3d3Jvkqp7Eka73I2TmataD_d5QjzBnk6-sYY$
>>>>>   
>>>>>   
>>>>> - Split dts settings into two patches based on belonging to
>>>>> MMSYS
>>>>> or MUTEX.
>>>>>
>>>>> Changes since v1:
>>>>> - Depend on :
>>>>>     [1]
>>>>>
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097__;!!CTRNKA9wMg0ARbw!giZVy8TiFNylgWKOjI75fSmleN6UlckPuiXzFf5jbdVgFbHdIxG3d3Jvkqp7Eka73I2TmataD_d5QjzBnk6-sYY$
>>>>>   
>>>>>   
>>>>> - Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding
>>>>> file.
>>>>> - Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
>>>>> - Rename mtk_mmsys_merge_config() and
>>>>> mtk_mmsys_rsz_dcm_config()
>>>>> to
>>>>>     mtk_mmsys_vpp_rsz_merge_config() and
>>>>> mtk_mmsys_vpp_rsz_dcm_config().
>>>>> - Clean up mtk_mmsys_vpp_rsz_dcm_config().
>>>>> - Add a comment to mtk_mutex_write_mod() and clean it up for
>>>>> use
>>>>> in more
>>>>>     than 32 mods.
>>>>>
>>>>> Hi,
>>>>>
>>>>> This series add support for MT8195's two VPPSYS(Video Processor
>>>>> Pipe Subsystem),
>>>>> under which there will be corresponding MMSYS and MUTEX
>>>>> settings
>>>>> that
>>>>> need to be configured.
>>>>>
>>>>> Moudy Ho (2):
>>>>>     dt-bindings: arm: mediatek: mmsys: Add support for MT8195
>>>>> VPPSYS
>>>>>     arm64: dts: mediatek: mt8195: add MUTEX configuration for
>>>>> VPPSYS
>>>>>
>>>>> Roy-CW.Yeh (6):
>>>>>     dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
>>>>>     arm64: dts: mediatek: mt8195: add MMSYS configuration for
>>>>> VPPSYS
>>>>>     soc: mediatek: mmsys: add support for MT8195 VPPSYS
>>>>>     soc: mediatek: mmsys: add config api for RSZ switching and
>>>>> DCM
>>>>>     soc: mediatek: mutex: Add mtk_mutex_set_mod support to set
>>>>> MOD1
>>>>>     soc: mediatek: mutex: support MT8195 VPPSYS
>>>>>
>>>>>    .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +-
>>>>>    .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>>>>>    arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  28 +++-
>>>>>    drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
>>>>>    drivers/soc/mediatek/mtk-mmsys.c              |  64 +++++++++
>>>>>    drivers/soc/mediatek/mtk-mmsys.h              |   1 +
>>>>>    drivers/soc/mediatek/mtk-mutex.c              | 135
>>>>> +++++++++++++++++-
>>>>>    include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
>>>>>    include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>>>>>    9 files changed, 274 insertions(+), 12 deletions(-)
>>>>>
