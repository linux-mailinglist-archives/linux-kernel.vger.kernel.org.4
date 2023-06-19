Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A54A734C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFSHdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjFSHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:33:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA8D1A8;
        Mon, 19 Jun 2023 00:33:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C2106606EAC;
        Mon, 19 Jun 2023 08:33:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687159984;
        bh=eVpKiXeHYQKoLrTacq8NzRF6J5Ey3z5Z9QQmflU6lvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RkmrBZwr8GGoopMBCawVh3pouCI1PbX2R9mC+E4NNL5VwfRRxYWA6QHaoGnPEXcdq
         TPMXKRbCoeUpoAKlpq1rbG0MplfrgA1rZIsWI3s4RWyv+G25yEvdEkhkCkxYi/7Y6z
         +fLP9PwzbW9MisqHZnMJmJnndxBU+5A+bqwur55CRuxViEhrBWspfGpuJopgjbCHx8
         HNn7C+iU0M8djR/ilnNtGt5+zAwESumFPEYI39n+BvOni28AqF8OQbHsnKstdniLg9
         xxB3rG7D2wLh7RQ1hn6x27WxMtSrNOHOdmg+7OGzrInnaBOmIuVC3kPWWdelBSViw9
         HsP4+75/wBbjA==
Message-ID: <967a333d-fddf-e819-1c3b-4bf04c9d6865@collabora.com>
Date:   Mon, 19 Jun 2023 09:33:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8192: Make sure MSDCPLL's
 rate is 400MHz
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>,
        =?UTF-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        =?UTF-8?B?Q2h1bi1KaWUgQ2hlbiAo6Zmz5rWa5qGAKQ==?= 
        <Chun-Jie.Chen@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?V2VpeWkgTHUgKOWRguWogeWEgCk=?= <Weiyi.Lu@mediatek.com>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
 <20230522093002.75137-2-angelogioacchino.delregno@collabora.com>
 <45cba46f9fb34acf393ec2743206403bc6a5e137.camel@mediatek.com>
 <519c6d38-bdea-3881-00e3-9bc3dee0f70d@gmail.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <519c6d38-bdea-3881-00e3-9bc3dee0f70d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/06/23 13:16, Matthias Brugger ha scritto:
> 
> 
> On 15/06/2023 11:51, TingHan Shen (沈廷翰) wrote:
>> Hi AngeloGioacchino,
>>
>> On Mon, 2023-05-22 at 11:30 +0200, AngeloGioacchino Del Regno wrote:
>>> External email : Please do not click links or open attachments until you have 
>>> verified the sender or the content.
>>>
>>>
>>> Some bootloaders will set MSDCPLL's rate lower than 400MHz: what I have
>>> seen is this clock being set at around 384MHz.
>>> This is a performance concern (and possibly a stability one, for picky
>>> eMMC/SD cards) as the MSDC controller's internal divier will choose a
>>> frequency that is lower than expected, in the end causing a difference
>>> in the expected mmc/sd device's timings.
>>>
>>> Make sure that the MSDCPLL frequency is always set to 400MHz to both
>>> improve performance and reliability of the sd/mmc storage.
>>>
>>> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi 
>>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 5c30caf74026..6fc14004f6fd 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -677,6 +677,8 @@ apmixedsys: syscon@1000c000 {
>>>                          compatible = "mediatek,mt8192-apmixedsys", "syscon";
>>>                          reg = <0 0x1000c000 0 0x1000>;
>>>                          #clock-cells = <1>;
>>> +                       assigned-clocks = <&apmixedsys CLK_APMIXED_MSDCPLL>;
>>> +                       assigned-clock-rates = <400000000>;
>>>                  };
>>>
>>>                  systimer: timer@10017000 {
>>> -- 
>>> 2.40.1
>>>
>>
>> Comment from mtk emmc owner,
>>
>> "As we all know, the clock has some jitter, when we set MSDCPLL to 400M,
>> but the actual measurement is not exactly 200M.
>> For eMMC, the spec stipulates that clock cannot exceed 200M.
>> If MSDCPLL is set to 400M, the actual measurement may exceed the spec.
>> So we set MSDCPLL to 384M in the bootloader stage to avoid exceeding the spec."
>>

Thanks for the comment,
I haven't seen any issue with this commit, if not a slight performance improvement,
on MT8192 and MT8195, but if there's risk to overclock the card, then it's not ok.

In any case, what is the expected jitter percentage?
eMMC/SD cards do expect jitter by spec anyway.

Thanks,
Angelo


> 
> Thanks for the feedback. Given that I'm not aware of any regressions that got fixed 
> by this commits I will drop this series for now. We can keep on the discussion and 
> if needed add them in a later stage.
> 
> Regards,
> Matthias
> 

