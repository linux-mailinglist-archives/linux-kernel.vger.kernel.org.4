Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C196EC6BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjDXHD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjDXHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:03:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644B83A97;
        Mon, 24 Apr 2023 00:03:40 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 77DC8660328C;
        Mon, 24 Apr 2023 08:03:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682319819;
        bh=BcRGcHyOxApaTa63eksxruQB/FnnfseF/8/KFtyoPuk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lc8JE8CfgEckcQWb3q+06AfgNeh+wD7PqhlF225cKHtBjj3q6+JEjIvq18eeuTgZ4
         Ox/fOnivwwITFtzRXmxCv5EQxSsAZelTGEREfiOrfzmM8b3edaSwjRXRgFKnlf2OvR
         MoWT+Ro+8j3kfGHw+8anbz+TZY4O2F0bbdG0QI38cOR5YMocC7X45crXNqByTjnVdl
         IJZVtUcHfS436enWDK8cx+ktt3VP3OS2nOHNL4czNn3I3fowWBrRNy6Dj1Sn0cr9Nw
         iHy4mQbPJsr4FEIvvQvkMj2HKv82QUTur4zRBK/T7za1CgUsJ8LIVV1sxSyKAC9A0z
         FfD8PlVjSJB0Q==
Message-ID: <0a0917f9-756f-6926-8ede-2b087cb0b716@collabora.com>
Date:   Mon, 24 Apr 2023 09:03:35 +0200
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5EtCdpXtq6q2Cv+QAZPUE6yJiSZhngSc0sftz-_uDrZXw@mail.gmail.com>
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

Il 21/04/23 08:46, Chen-Yu Tsai ha scritto:
> On Thu, Apr 20, 2023 at 5:45 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> On Cherry boards, the IP at 0x1c015000 (dp_intf0) is used as primary
>> dp-intf, while the other at 0x1c113000 (dp_intf1) is used as secondary:
>> assign them to dp-intf{0,1} aliases respectively.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi | 2 ++
> 
> This should be applied at the SoC level. The display pipeline is fixed in
> MMSYS, so it applies to all MT8195 devices.
> 

It's fixed in the MMSYS configuration/driver but - as far as I remember (I can
recheck on the datasheets) - the dp_intfX function can be inverted meaning that
the MMSYS paths can be configured such that DP_INTF0 becomes secondary and the
other becomes primary: this is why I am putting that into mt8195-cherry and not
mt8195.dtsi.

Regards,
Angelo

>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> index 0820e9ba3829..918380697a9a 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>> @@ -10,6 +10,8 @@
>>
>>   / {
>>          aliases {
>> +               dp-intf0 = &dp_intf0;
>> +               dp-intf1 = &dp_intf1;
>>                  i2c0 = &i2c0;
>>                  i2c1 = &i2c1;
>>                  i2c2 = &i2c2;
>> --
>> 2.40.0
>>
>>
> 

