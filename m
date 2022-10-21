Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4197C6071D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiJUION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiJUIOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:14:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D224AAE4;
        Fri, 21 Oct 2022 01:14:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 15288660252D;
        Fri, 21 Oct 2022 09:14:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666340041;
        bh=C5fhU6Bgv3bCUz3Llyic5ABqZ5cYvuR764ThhvuGkiQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K/xUneU4RGgtP+eNwsviIlPLkiYs7DAZX7HoYSaBiqyLqlxfwxcSJ1fSBUU4SaYWd
         sxw4A3qpi17wjVv0k7VKK0Fa7r18A0qDU8sWFkg/IWhd3lBdW3RAYCM+/fY8tAxFLw
         b1O+wMZUKG2L/4cF5eby0idvdK1DLImAukrFXCZclFYedHyYWtLMjMpM9SG5b//iwu
         FfUDpKj3yVl2Taql1hPMcREnj8a3UxS/Mr0MpP/z8wejQGbkKBiQS/Nz0YEX7AB4Lv
         UXCcD6Qny5H6GmKvxVmISPDYSC5vLnpg6KohB9uHOsO9xo57WSFUT6d1h0EOVLJgDa
         zMelP1w+1snnw==
Message-ID: <185de97b-4cf5-3b3a-e7a4-2967dc54db1f@collabora.com>
Date:   Fri, 21 Oct 2022 10:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 6/8] arm64: dts: mt2712-evb: Fix usb vbus regulators unit
 names
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sam.shih@mediatek.com, hanks.chen@mediatek.com,
        weiyi.lu@mediatek.com, zhiyong.tao@mediatek.com,
        andrew-sh.cheng@mediatek.com, viresh.kumar@linaro.org,
        fparent@baylibre.com, mars.cheng@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221013152212.416661-1-angelogioacchino.delregno@collabora.com>
 <20221013152212.416661-7-angelogioacchino.delregno@collabora.com>
 <3b7fc7414f282ca044c24dae280f9bc9533a5b7b.camel@mediatek.com>
 <96ab6836-4650-ee53-a0c9-54b8328b8667@collabora.com>
 <616a128698656e71a4e28d59bbced17443c5cebc.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <616a128698656e71a4e28d59bbced17443c5cebc.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/10/22 08:25, Chunfeng Yun ha scritto:
> On Fri, 2022-10-14 at 09:35 +0200, AngeloGioacchino Del Regno wrote:
>> Il 14/10/22 04:43, Chunfeng Yun ha scritto:
>>> On Thu, 2022-10-13 at 17:22 +0200, AngeloGioacchino Del Regno
>>> wrote:
>>>> Update the names to regulator-usb-p{0-3}-vbus to fix
>>>> unit_address_vs_reg
>>>> warnings for those.
>>>>
>>>> Fixes: 1724f4cc5133 ("arm64: dts: Add USB3 related nodes for
>>>> MT2712")
>>>> Signed-off-by: AngeloGioacchino Del Regno <
>>>> angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt2712-evb.dts | 8 ++++----
>>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>>>> b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>>>> index 638908773706..d31a194124c9 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt2712-evb.dts
>>>> @@ -50,7 +50,7 @@ extcon_usb1: extcon_iddig1 {
>>>>    		id-gpio = <&pio 14 GPIO_ACTIVE_HIGH>;
>>>>    	};
>>>>    
>>>> -	usb_p0_vbus: regulator@2 {
>>>> +	usb_p0_vbus: regulator-usb-p0-vbus {
>>>
>>> Can we modify dt-binding of fixed regulator instead of changing the
>>> node name,
>>> since all nodes using fixed regulator may need be changed.
>>>
>>
>> These regulators have no MMIO, nor need any index, so it would be
>> simply
>> wrong to change the binding and leave them as they are here in the
>> devicetree.
> You are right, then many files need be modified?
> 

Yes Chunfeng, many files need to be modified due to mistakes made in the past.

No big deal though: as long as we're all aware of what needs to happen, it's fine!

Cheers,
Angelo

