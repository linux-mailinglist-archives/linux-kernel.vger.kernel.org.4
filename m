Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2AE6EC6DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjDXHTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDXHTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:19:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC56A0;
        Mon, 24 Apr 2023 00:19:29 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C9B2A6603230;
        Mon, 24 Apr 2023 08:19:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682320768;
        bh=y2Zd2mcukyD5xgMKFFTPfcFPwvNeasLimenGu+uA/Bo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FbvwbiGw60azOUiU1kTbXJHXAXuV05mA6I3vJ7dRUYev2CdCIpTgKaYSjvOiyGvrq
         5DYVyhRCZUu2UvkC4imr198sHrFU81/DUXdXYW1P/x8r9UWEvdSNIlB5QK4KtTmZDv
         gDH6ib5uJZS+HVKRWfLCzMJvOHDSzkkgnc+Sh1pdxs0vLl7ikPYKjP2CRJRLlRHvif
         sYqOQ2+775SJOVbCTmeqWIiYgwv1lynzqZNfmeNg8VgoGrFqLS34EFh5dKkSei945H
         uQhDAUGJ+L5MW7gbxpddNxyhVSBWQgjLTuCUIIynjAuZJm2GR8aN6jE8d7N+UVLDeO
         wYAoK7oNTqX2A==
Message-ID: <8a3c0e35-b581-3405-ea2d-f8f8d9e432d9@collabora.com>
Date:   Mon, 24 Apr 2023 09:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] arm64: dts: mediatek: cherry: Assign dp-intf aliases
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-3-angelogioacchino.delregno@collabora.com>
 <CAGXv+5EtCdpXtq6q2Cv+QAZPUE6yJiSZhngSc0sftz-_uDrZXw@mail.gmail.com>
 <0a0917f9-756f-6926-8ede-2b087cb0b716@collabora.com>
 <CAGXv+5FMEphksTSLAy8=hDPGjC364dxD4_9qmw6aV4en-2d3ig@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5FMEphksTSLAy8=hDPGjC364dxD4_9qmw6aV4en-2d3ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/04/23 09:17, Chen-Yu Tsai ha scritto:
> On Mon, Apr 24, 2023 at 3:03 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 21/04/23 08:46, Chen-Yu Tsai ha scritto:
>>> On Thu, Apr 20, 2023 at 5:45 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> On Cherry boards, the IP at 0x1c015000 (dp_intf0) is used as primary
>>>> dp-intf, while the other at 0x1c113000 (dp_intf1) is used as secondary:
>>>> assign them to dp-intf{0,1} aliases respectively.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
>>>
>>> This should be applied at the SoC level. The display pipeline is fixed in
>>> MMSYS, so it applies to all MT8195 devices.
>>>
>>
>> It's fixed in the MMSYS configuration/driver but - as far as I remember (I can
>> recheck on the datasheets) - the dp_intfX function can be inverted meaning that
>> the MMSYS paths can be configured such that DP_INTF0 becomes secondary and the
>> other becomes primary: this is why I am putting that into mt8195-cherry and not
>> mt8195.dtsi.
> 
> Maybe that's possible, but the diagram in the datasheet suggests a fixed path.
> 
> Either way, it's not actually the problem. My original reply is probably
> inaccurate. AFAIK the aliases are used to identify the individual hardware
> blocks, which otherwise have the same compatible string. So the numbering
> should be the same regardless of the design and/or routing.

Ack. Will move to mt8195.dtsi!

> 
> Ideally this should be described with a proper graph though.
> 
> ChenYu
> 
>>
>> Regards,
>> Angelo
>>
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> index 0820e9ba3829..918380697a9a 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>> @@ -10,6 +10,8 @@
>>>>
>>>>    / {
>>>>           aliases {
>>>> +               dp-intf0 = &dp_intf0;
>>>> +               dp-intf1 = &dp_intf1;
>>>>                   i2c0 = &i2c0;
>>>>                   i2c1 = &i2c1;
>>>>                   i2c2 = &i2c2;
>>>> --
>>>> 2.40.0
>>>>
>>>>
>>>
>>


