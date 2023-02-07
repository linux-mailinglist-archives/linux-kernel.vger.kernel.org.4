Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B3068DCB8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBGPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjBGPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:17:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046E335B5;
        Tue,  7 Feb 2023 07:17:06 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0854F6602077;
        Tue,  7 Feb 2023 15:17:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675783025;
        bh=TEDT9pnGFqcTJVk9HH31+nHZjvOvS2XRc3rMOWGCeTs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P7g1fXAmAgcVOMTYHowBNYIBsKGNnW6sSVRvf903qzu2Bfvlwt1ZMZRXpzC1PJOHF
         egWwoe/kzISIu4u9RpLEKEOQLn5173w4sRElcibvzq+JOcYeCUOgMYWRE5/wtwDY/w
         4mTonBQQXY3dkUZpffuySaClGfUlg01Ki3WMIqehYCVrBY6+4CaNt9jhF3/0WmmvwV
         w6XIGcKI6xErOUgwoseeD1y1lanoqGmvVAuHh/YZiDcxWRxn9YzgUPW3a3Dm8yl41T
         tXJQsfiJNH9naWSz7MJlyTktCYYf+1s0gc1FjyVU5JSTlib90IVh6KvmyEpmVa+TJM
         l1fPDXu2rnuNQ==
Message-ID: <3a43ce55-ff6a-0cd2-b020-d5fefe8aca0a@collabora.com>
Date:   Tue, 7 Feb 2023 16:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mt7986: set Wifi Leds low-active for BPI-R3
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230205174833.107050-1-linux@fw-web.de>
 <8f04f2b5-320e-50d4-9517-6dac989f63b3@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <8f04f2b5-320e-50d4-9517-6dac989f63b3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/02/23 21:20, Matthias Brugger ha scritto:
> 
> 
> On 05/02/2023 18:48, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files.de>
>>
>> Leds for Wifi are low-active, so add property to devicetree.
>>
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>> ---
>>   arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts 
>> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>> index 33bd6febc160..2b028141f1f7 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>> @@ -446,5 +446,9 @@ &wifi {
>>       pinctrl-names = "default", "dbdc";
>>       pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
>>       pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
>> +
>> +    led {
>> +        led-active-low;
>> +    };
> 
> The binding is missing this property also the driver implements it. Could you 
> please update the bindind description properly?
> Thanks
> Matthias


After and only after [1] is picked,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

[1]: 
https://patchwork.kernel.org/project/linux-mediatek/patch/20230207133504.21826-1-linux@fw-web.de/
