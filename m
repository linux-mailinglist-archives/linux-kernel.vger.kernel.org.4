Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D66EC74A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjDXHks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbjDXHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:40:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595AE7D;
        Mon, 24 Apr 2023 00:40:40 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 762376602097;
        Mon, 24 Apr 2023 08:40:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682322039;
        bh=cIDw4bo9W+NAgm/8tIV6FQYtHcogF7cLjrNY/+Ashgw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D8MC/8sP905WNAn7bhbIwt6KyjAWrgo2x9YsbL7az82njzG/qtsobZjNCF5xglABp
         a+nQyw49M6WSnt5HIDxOlUKYe07CTLXfMjIYwbbChP4CPvfYLHnumLoLLNFUZgOI83
         ldsjmH82nfEUnVrYN6LJ3xsqwbepHq+Ab/YpfP0IOEcarSvkBvkTeG58uXbTReFCSm
         5su4HEaXF+mAt6ttMSRm1Gdf+5ufboXqJJKi230YGS/BgDsKr8UT6fE1wkyx0FyByf
         juwIMtwikknFy0Tr5b0+waEFwaScP7CZSOx7gcLFlGJ6XoibB4i7Y+wuIrOlLh0Wy/
         zoXJhUGLwUFPA==
Message-ID: <a052b2ba-e211-c997-7508-0d012663dedb@collabora.com>
Date:   Mon, 24 Apr 2023 09:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/5] arm64: dts: mediatek: cherry: Add platform thermal
 configuration
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230420094433.42794-1-angelogioacchino.delregno@collabora.com>
 <20230420094433.42794-2-angelogioacchino.delregno@collabora.com>
 <CAGXv+5GuEQMxYTKrnia1ipYHLt_B2h6By7EejE7MjCypfavnFg@mail.gmail.com>
 <5ede9421-54d6-4dda-91af-2acbf46c2d3e@notapiano>
 <097d60ba-5604-a2c9-c6d2-121db2d55e36@collabora.com>
 <CAGXv+5G9Qh2ftB0NG4Km3wHQCgyxHK+Ae17QWJrv8V9VJaBH4A@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5G9Qh2ftB0NG4Km3wHQCgyxHK+Ae17QWJrv8V9VJaBH4A@mail.gmail.com>
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

Il 24/04/23 09:38, Chen-Yu Tsai ha scritto:
> On Mon, Apr 24, 2023 at 2:31 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 21/04/23 22:53, Nícolas F. R. A. Prado ha scritto:
>>> On Fri, Apr 21, 2023 at 03:37:52PM +0800, Chen-Yu Tsai wrote:
>>>> On Thu, Apr 20, 2023 at 5:45 PM AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>>
>>>>> This platform has three auxiliary NTC thermistors, connected to the
>>>>> SoC's ADC pins. Enable the auxadc in order to be able to read the
>>>>> ADC values, add a generic-adc-thermal LUT for each and finally assign
>>>>> them to the SoC's thermal zones.
>>>>>
>>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> ---
>>>>>    .../boot/dts/mediatek/mt8195-cherry.dtsi      | 105 ++++++++++++++++++
>>>>>    1 file changed, 105 insertions(+)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>>> index 8ac80a136c37..0820e9ba3829 100644
>>>>> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>>> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
>>>>> @@ -114,6 +114,77 @@ ppvar_sys: regulator-ppvar-sys {
>>>>>                   regulator-boot-on;
>>>>>           };
>>>>>
>>>>> +       /* Murata NCP03WF104F05RL */
>>>>> +       tboard_thermistor1: thermal-sensor-t1 {
>>>>> +               compatible = "generic-adc-thermal";
>>>>> +               #thermal-sensor-cells = <0>;
>>>>> +               io-channels = <&auxadc 0>;
>>>>> +               io-channel-names = "sensor-channel";
>>>>> +               temperature-lookup-table = <    (-10000) 1553
>>>>> +                                               (-5000) 1485
>>>>> +                                               0 1406
>>>>> +                                               5000 1317
>>>>> +                                               10000 1219
>>>>> +                                               15000 1115
>>>>> +                                               20000 1007
>>>>> +                                               25000 900
>>>>> +                                               30000 796
>>>>> +                                               35000 697
>>>>> +                                               40000 605
>>>>> +                                               45000 523
>>>>> +                                               50000 449
>>>>> +                                               55000 384
>>>>> +                                               60000 327
>>>>> +                                               65000 279
>>>>> +                                               70000 237
>>>>> +                                               75000 202
>>>>> +                                               80000 172
>>>>> +                                               85000 147
>>>>> +                                               90000 125
>>>>> +                                               95000 107
>>>>> +                                               100000 92
>>>>> +                                               105000 79
>>>>> +                                               110000 68
>>>>> +                                               115000 59
>>>>> +                                               120000 51
>>>>> +                                               125000 44>;
>>>>> +       };
>>>>> +
>>>>> +       tboard_thermistor2: thermal-sensor-t2 {
>>>>> +               compatible = "generic-adc-thermal";
>>>>> +               #thermal-sensor-cells = <0>;
>>>>> +               io-channels = <&auxadc 1>;
>>>>> +               io-channel-names = "sensor-channel";
>>>>> +               temperature-lookup-table = <    (-10000) 1553
>>>>> +                                               (-5000) 1485
>>>>> +                                               0 1406
>>>>> +                                               5000 1317
>>>>> +                                               10000 1219
>>>>> +                                               15000 1115
>>>>> +                                               20000 1007
>>>>> +                                               25000 900
>>>>> +                                               30000 796
>>>>> +                                               35000 697
>>>>> +                                               40000 605
>>>>> +                                               45000 523
>>>>> +                                               50000 449
>>>>> +                                               55000 384
>>>>> +                                               60000 327
>>>>> +                                               65000 279
>>>>> +                                               70000 237
>>>>> +                                               75000 202
>>>>> +                                               80000 172
>>>>> +                                               85000 147
>>>>> +                                               90000 125
>>>>> +                                               95000 107
>>>>> +                                               100000 92
>>>>> +                                               105000 79
>>>>> +                                               110000 68
>>>>> +                                               115000 59
>>>>> +                                               120000 51
>>>>> +                                               125000 44>;
>>>>> +       };
>>>>> +
>>>>>           usb_vbus: regulator-5v0-usb-vbus {
>>>>>                   compatible = "regulator-fixed";
>>>>>                   regulator-name = "usb-vbus";
>>>>> @@ -260,6 +331,10 @@ &gpu {
>>>>>           mali-supply = <&mt6315_7_vbuck1>;
>>>>>    };
>>>>>
>>>>> +&auxadc {
>>>>> +       status = "okay";
>>>>> +};
>>>>> +
>>>>>    &i2c0 {
>>>>>           status = "okay";
>>>>>
>>>>> @@ -1098,6 +1173,36 @@ mt6315_7_vbuck1: vbuck1 {
>>>>>           };
>>>>>    };
>>>>>
>>>>> +&thermal_zones {
>>>>> +       soc_area_ntc {
>>>
>>> Not sure if that's what's causing the issue, but the thermal zone name should
>>> end with -thermal as per the binding. Also note that it needs to be under 20
>>> characters otherwise it will fail to be registered with -22 like below.
>>> (Also, node names shouldn't contain underscore)
>>>
>>> Thanks,
>>> Nícolas
>>>
>>>>> +               polling-delay = <1000>;
>>>>> +               polling-delay-passive = <250>;
>>>>> +               thermal-sensors = <&tboard_thermistor1>;
>>>>> +
>>>>> +               trips {
>>>>> +                       trip-crit {
>>>>> +                               temperature = <95000>;
>>>>> +                               hysteresis = <2000>;
>>>>> +                               type = "critical";
>>>>> +                       };
>>>>> +               };
>>>>> +       };
>>>>> +
>>>>> +       pmic_area_ntc {
>>>>> +               polling-delay = <1000>;
>>>>> +               polling-delay-passive = <0>;
>>>>> +               thermal-sensors = <&tboard_thermistor2>;
>>>>> +
>>>>> +               trips {
>>>>> +                       trip-crit {
>>>>> +                               temperature = <95000>;
>>>>> +                               hysteresis = <2000>;
>>>>> +                               type = "critical";
>>>>> +                       };
>>>>> +               };
>>>>> +       };
>>>>
>>>> I'm still getting:
>>>>
>>>> thermal_sys: Failed to find 'trips' node
>>>> thermal_sys: Failed to find trip points for thermal-sensor-t1 id=0
>>>> generic-adc-thermal thermal-sensor-t1: Thermal zone sensor register failed: -22
>>>> generic-adc-thermal: probe of thermal-sensor-t1 failed with error -22
>>>> thermal_sys: Failed to find 'trips' node
>>>> thermal_sys: Failed to find trip points for thermal-sensor-t2 id=0
>>>> generic-adc-thermal thermal-sensor-t2: Thermal zone sensor register failed: -22
>>>> generic-adc-thermal: probe of thermal-sensor-t2 failed with error -22
>>>> thermal_sys: Failed to find 'trips' node
>>>> thermal_sys: Failed to find trip points for thermal-sensor-t3 id=0
>>>> generic-adc-thermal thermal-sensor-t3: Thermal zone sensor register failed: -22
>>>> generic-adc-thermal: probe of thermal-sensor-t3 failed with error -22
>>>>
>>
>> I think you have something wrong locally - there's no thermal-sensor-t3 in this
>> devicetree...
> 
> I seem to have run a stale kernel image. Rebuilt the kernel and everything
> seems to work OK now.
> 
> BTW, I think the design went for a lower trip point. At least the hardware
> thermal protection IC on the Acer device trips at 85 degrees C, instead of
> 95 degrees C. Maybe that's accounting for the fact that these are external
> thermal sensors and have some latency and temperature difference. The PMIC
> specifies 85 degrees C maximum ambient air temperature. The SoC doesn't
> specify.
> 

Let's play safe then, I'll change that to 85 for the next version.

> Either way this is
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks!

