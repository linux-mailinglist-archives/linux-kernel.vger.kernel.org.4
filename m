Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CFB6ADA60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjCGJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjCGJaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:30:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765A3125A2;
        Tue,  7 Mar 2023 01:30:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EC8EB6602FE5;
        Tue,  7 Mar 2023 09:30:06 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678181407;
        bh=9SABq8iXVESIcH7tVR9rm9V3gZZHiNkHp84CGrGa3yw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kTiWBQcC1KNkom+7BnNGE14JbRpIEIei0qbqkSFZ72GTl5OX9nIC8dnmrWK4W6H4M
         MX6DRSWIeb/+Q44pGw6CPbzEmIp8a71X0IpiWrg4eV2d+dFFR/j4u42PnoGq6DYhMs
         iY9M7EU0KDQ6TLe7BWv2pOIr72vtvSb7WxC18w7+T8VxEbKi++TIVKl4YpjMXFefLv
         frb58kPCfJ1TSNVVGRi8i/r8iWwgJtgh3rpjg5KJXZZfvEUR0sonHwhJQf5hkJ1eIj
         i+9HTSUOZbSjPCruhMDgeBy+5zhhrU4DTcKV1f5yF0erZz1ZxQIkrQIa7/1mKZMsLz
         O5nFudCcv+1LQ==
Message-ID: <e1b9d901-421c-3509-c92a-c59d49ff2b0d@collabora.com>
Date:   Tue, 7 Mar 2023 10:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 12/19] arm64: dts: mediatek: mt8192-asurada: Couple
 VGPU and VSRAM_OTHER regulators
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230301095523.428461-1-angelogioacchino.delregno@collabora.com>
 <20230301095523.428461-13-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GHdtbheL6wxtDo-szk+=3BGk2z93SBowd4Z=E9XupZkw@mail.gmail.com>
 <5dba27e1-d480-ea24-c1ba-03bb7f77b1b1@collabora.com>
 <CAGXv+5FwNfZ7TwKVMM5_uAjYQ6ZmhZVFsWREb_da-jxC6EUVJw@mail.gmail.com>
 <CAGXv+5F8A4kLq3y8dE4mrcVb338-afDorWsS5MRBvWVPgiAhEA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5F8A4kLq3y8dE4mrcVb338-afDorWsS5MRBvWVPgiAhEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/03/23 10:24, Chen-Yu Tsai ha scritto:
> On Fri, Mar 3, 2023 at 12:09 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>>
>> On Thu, Mar 2, 2023 at 6:17 PM AngeloGioacchino Del Regno
>> <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Il 02/03/23 11:03, Chen-Yu Tsai ha scritto:
>>>> On Wed, Mar 1, 2023 at 5:55 PM AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>
>>>>> Add coupling for these regulators, as VSRAM_OTHER is used to power the
>>>>> GPU SRAM, and they have a strict voltage output relation to satisfy in
>>>>> order to ensure GPU stable operation.
>>>>> While at it, also add voltage constraint overrides for the GPU SRAM
>>>>> regulator "mt6359_vsram_others" so that we stay in a safe range of
>>>>> 0.75-0.80V.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>    arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 9 +++++++++
>>>>>    1 file changed, 9 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>>>> index 8570b78c04a4..f858eca219d7 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
>>>>> @@ -447,6 +447,13 @@ &mt6359_vrf12_ldo_reg {
>>>>>           regulator-always-on;
>>>>>    };
>>>>>
>>>>> +&mt6359_vsram_others_ldo_reg {
>>>>> +       regulator-min-microvolt = <750000>;
>>>>> +       regulator-max-microvolt = <800000>;
>>>>> +       regulator-coupled-with = <&mt6315_7_vbuck1>;
>>>>> +       regulator-coupled-max-spread = <10000>;
>>>>
>>>> Looking again at the downstream OPP table, it seems there's no voltage
>>>> difference requirement. It only needs V_SRAM >= V_GPU. Same applies to
>>>> MT8195. Looks like only MT8183 and MT8186 need V_SRAM - V_GPU >= 10000.
>>>
>>> On MT8195 we don't need any regulator coupling. There, the GPU-SRAM voltage
>>> is fixed at .. I don't remember, 0.7V? - anyway - MT8195 doesn't need to
>>> scale the vsram.
>>
>> Looks like it's fixed at 0.75V. I guess we're Ok on MT8195.
>>
>>>>
>>>> Would setting max-spread to 0 work? I ask because with both regulator's
>>>> maximum voltage set to 0.8V, there's no way we can reach the highest
>>>> OPP.
>>>>
>>>
>>> No that doesn't work. I can raise the Vgpu max voltage to 0.88V to solve the
>>> issue right here and right now, or we can leave it like that and revisit it
>>> later.
>>>
>>> I would at this point go for setting mt6315_7_vbuck1's max-microvolt to
>>> 880000, as this is the maximum recommended voltage for the GPU as per the
>>> MT8192 datasheet, it would also make sense as we would be still describing
>>> the hardware in a correct manner.
>>>
>>> What do you think?
>>
>> If it's just to accommodate the coupler stuff, I say just set the maximum
>> at the lowest possible setting that satisfies the coupler constraint and
>> granularity of the regulator. The regulator does 6250 uV steps, so I guess
>> we could set the maximum at 812500 uV, with a comment stating the nominal
>> voltage of 800000 uV and that the extra 12500 uV is to workaround coupler
>> limitations.
>>
>> Does that sound OK?
> 
> Even without changing anything, the coupler seems to work OK:
> 
>   vsram_others                     1    1      0  normal   800mV
> 0mA   750mV   800mV
>      10006000.syscon:power-controller-domain   1
>           0mA     0mV     0mV
>   Vgpu                             2    2      0  normal   800mV
> 0mA   606mV   800mV
>      13000000.gpu-mali             1
> 0mA   800mV   800mV
>      10006000.syscon:power-controller-domain   1
>           0mA     0mV     0mV
> 
> Am I missing something?
> 

I don't think you are... I may be getting confused by all of the changesets
that I'm pushing at once.

Hence, is this commit fine as it is?

Regards,
Angelo
