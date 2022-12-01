Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F21363EBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLAJEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiLAJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:03:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93308EE53;
        Thu,  1 Dec 2022 01:02:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A32E66602B85;
        Thu,  1 Dec 2022 09:02:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669885348;
        bh=mvonW1qN8XFIYuXJMysma7tvGyJZY/ErMeX5eIO4Yjk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KoOZkEuQXXCVAp2U/25BNWa/s6K0Sv+P7ue/c1Aw1iGf5gmW6GPqzDqfZqHP0ZJg7
         7Dml60hXarzwl7gxf9pV2CJ4gcRxFwYvjSN9j5Lf1jzH1uE2O+otoSoOLE85Oc/eVv
         bfSFCannshPRGdDb4XTxDwP4lJwwuOZ83w7hQ2SQ1d+JVUDRZupcKcfbSvENLnA8Ec
         9VsCmeX7vI6//1QWynmLyjucICKBz9S5Yt1hPs7wg2O38+Z4mgVLsomih4OBZ631zW
         4vZPIclid4PxJz/5NHhAcFIEvaoVSv5alElCJbEEBGbKHeHVm9cAKqa0dzyvFccd3J
         zy0b01URv6X9Q==
Message-ID: <8806f4cf-2141-acb8-1f9d-cd6ade64756e@collabora.com>
Date:   Thu, 1 Dec 2022 10:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH resend] arm64: dts: mediatek: mt8192: Mark scp_adsp clock
 as broken
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
References: <20221130031741.3176853-1-wenst@chromium.org>
 <2ec80bd8-dfef-d2e6-eb41-6e6088043e33@collabora.com>
 <CAGXv+5E=X_hwg76=B_jqWrpieo8bR-=r8NLbNz2=JzE=kBwMWQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5E=X_hwg76=B_jqWrpieo8bR-=r8NLbNz2=JzE=kBwMWQ@mail.gmail.com>
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

Il 01/12/22 09:56, Chen-Yu Tsai ha scritto:
> On Wed, Nov 30, 2022 at 7:10 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 30/11/22 04:17, Chen-Yu Tsai ha scritto:
>>> The scp_adsp clock controller is under the SCP_ADSP power domain. This
>>> power domain is currently not supported nor defined.
>>>
>>> Mark the clock controller as broken for now, to avoid the system from
>>> trying to access it, and causing the CPU or bus to stall.
>>>
>>> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>
>> ....or we can add the ADSP power domain to actually fix this properly, which looks
>> like being a generally good idea :-)
> 
> Sure, but that and any driver changes have to be backported, or anything
> touching the clocks will still break the system.
> 

I agree.

> There's no reason we can't have both. I think having this one merged and
> backported to stable first, then adding the SCP_ADSP power domain, and tying
> it to the clock controller as a follow up addition works best.
> 
> What do you think?
> 

I think that one reason to not have both is that we'd have to revert this commit
after the SCP_ADSP power domain is added (with the appropriate Fixes tags and/or
Cc stable)...

I'd expect that entire addition to be no more than 3 commits, including the dtsi
one... and if it comes out as I expect, we'd be solving that issue on all of the
affected older versions of the kernel - the right way.

Can we wait for... let's say, a day or two to check how that works, before taking
a final decision on this commit?

Cheers,
Angelo

> ChenYu
> 
>> Allen, can you please take care of that?
>>
>> Thank you,
>> Angelo
>>
>>> ---
>>>    arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> index 6b20376191a7..ef91941848ae 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>>> @@ -575,6 +575,8 @@ scp_adsp: clock-controller@10720000 {
>>>                        compatible = "mediatek,mt8192-scp_adsp";
>>>                        reg = <0 0x10720000 0 0x1000>;
>>>                        #clock-cells = <1>;
>>> +                     /* power domain dependency not upstreamed */
>>> +                     status = "broken";
>>>                };
>>>
>>>                uart0: serial@11002000 {
>>>
>>

