Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284FB63ED4C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiLAKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiLAKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:10:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777A01B1C5;
        Thu,  1 Dec 2022 02:10:34 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 792856602AC1;
        Thu,  1 Dec 2022 10:10:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669889433;
        bh=T8Mv1kLojBuRdbHzbub+mx4q2+A4SuXT+pni77g+sfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kAynYHE5O4jVBHrd3yKzNM+aWXpDQfzOZO55Qdq2Ca1rrXt56jMmq/Vz4A+/Nw/nj
         tn6H8N8e3wkAY27aSAS85AUa4IXr4rhxBjbahsl2fmz9fWJJ4jnECB10TbHEkq5yMg
         GzzxqlxTUBEUSkBmW71YPu5ncOzzfMO+12oMQKu9ZKq0+RC/ULt+xgU5ursrPGlz2I
         GZmBgpFyKNryvSMAwpUXb/wz7LvT73kf6iezQ7UiYz7t57F2y198JhdUdgo539gKNb
         Nj4wImy6gmZ+eknVMNJapnmfybq2lrgbm7+3cUHW8nYJfF79Yvkoskw7teIwCKHCAC
         8itwbZJs3JX2Q==
Message-ID: <28d94df0-6e87-3019-dc10-a587f84488fb@collabora.com>
Date:   Thu, 1 Dec 2022 11:10:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] arm64: dts: mt8192: Add adsp power domain controller
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221201073328.1559-1-allen-kh.cheng@mediatek.com>
 <ba14a46f-477f-70af-761d-696fe8a4f41c@collabora.com>
 <CAGXv+5Gg6ozYQcp_NPrAiH1kF-ZkfjVZhQZVhLnbSmjQBwsFwQ@mail.gmail.com>
 <8ae2a510-abf6-6e1b-9893-293db7d930e7@collabora.com>
 <CAGXv+5H+msQ1ct5CUzYnT_BmYPnS72HbivvyO39uOfMfXbo5qg@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H+msQ1ct5CUzYnT_BmYPnS72HbivvyO39uOfMfXbo5qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/12/22 11:05, Chen-Yu Tsai ha scritto:
> On Thu, Dec 1, 2022 at 5:39 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 01/12/22 10:10, Chen-Yu Tsai ha scritto:
>>> On Thu, Dec 1, 2022 at 5:07 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 01/12/22 08:33, Allen-KH Cheng ha scritto:
>>>>> Add adsp power domain controller node for mt8192 SoC.
>>>>>
>>>>> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
>>>>> ---
>>>>> Ref: https://lore.kernel.org/all/2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com/
>>>>>        [Allen-KH Cheng <allen-kh.cheng@mediatek.com>]
>>>>> ---
>>>>> ---
>>>>>     arch/arm64/boot/dts/mediatek/mt8192.dtsi | 8 ++++++++
>>>>>     include/dt-bindings/power/mt8192-power.h | 1 +
>>>>>     2 files changed, 9 insertions(+)
>>>>>
>>>>
>>>> Allen, thanks for this one, but it's incomplete...
>>>>
>>>> First of all, you must add the power domain on the driver itself, specifically,
>>>> in drivers/soc/mediatek/mt8192-pm-domains.h - otherwise this change will have no
>>>> effect!
>>>
>>> Actually it's worse. The driver doesn't know about the new power domain,
>>> and so it will fail to probe. We might need to make the power domain driver
>>> fail gracefully and skip unknown power domains.
>>>
>>
>> Right. It's worse. I don't know, though, if gracefully skipping unknown power
>> domains in the driver would be a good decision... as sometimes error messages
>> go unnoticed.
>>
>> When the platform "explodes" instead, you're forced to read that log carefully
>> and get it working again... Anyway, I'm only thinking out loud, nothing less and
>> nothing more than that :-)
> 
> Me too. :)
> 
>> By the way, we can probably expand on that topic a bit later, as it's outside of
>> the scope of this specific change.
>>
>> Back to topic, if we get one series containing both changes (devicetree, bindings
>> and driver) with the right Fixes tags and/or Cc stable, we shouldn't have such
>> issue on backports so we can probably ignore that potential issue, I think? :-)
> 
> Everything goes through the soc tree, so they should appear in Linus's tree
> and get picked by stable at more or less the same time. I think we would
> want the driver change to appear before the dts change, for bisectability's
> sake (because of header dependencies and driver errors).
> 
> So we probably want:
> 1. driver + binding header changes
> 2. dtsi changes
> 
> And have these merged through fixes so that the history between them is linear.
> 

Perfect, I fully agree.

> 
> ChenYu
> 
>> Cheers,
>> Angelo
>>
>>> ChenYu
>>>
>>>> ...Then, as Chen-Yu said, you should also add the power domain to the scp_adsp
>>>> clock node as that's solving the lockup issue...
>>>>
>>>> .......and last, but not least: we need a Fixes tag to backport this fix, here
>>>> and on the commit that adds the missing power domain in the driver.
>>>>
>>>> Thanks,
>>>> Angelo
>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>>>> index 424fc89cc6f7..e71afba871fc 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>>>> @@ -514,6 +514,14 @@
>>>>>                                                 };
>>>>>                                         };
>>>>>                                 };
>>>>> +
>>>>> +                             power-domain@MT8192_POWER_DOMAIN_ADSP {
>>>>> +                                     reg = <MT8192_POWER_DOMAIN_ADSP>;
>>>>> +                                     clocks = <&topckgen CLK_TOP_ADSP_SEL>;
>>>>> +                                     clock-names = "adsp";
>>>>> +                                     mediatek,infracfg = <&infracfg>;
>>>>> +                                     #power-domain-cells = <0>;
>>>>> +                             };
>>>>>                         };
>>>>>                 };
>>>>>
>>>>> diff --git a/include/dt-bindings/power/mt8192-power.h b/include/dt-bindings/power/mt8192-power.h
>>>>> index 4eaa53d7270a..63e81cd0d06d 100644
>>>>> --- a/include/dt-bindings/power/mt8192-power.h
>>>>> +++ b/include/dt-bindings/power/mt8192-power.h
>>>>> @@ -28,5 +28,6 @@
>>>>>     #define MT8192_POWER_DOMAIN_CAM_RAWA        18
>>>>>     #define MT8192_POWER_DOMAIN_CAM_RAWB        19
>>>>>     #define MT8192_POWER_DOMAIN_CAM_RAWC        20
>>>>> +#define MT8192_POWER_DOMAIN_ADSP     21
>>>>>
>>>>>     #endif /* _DT_BINDINGS_POWER_MT8192_POWER_H */
>>>>>
>>>>
>>
>>

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

