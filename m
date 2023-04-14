Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40F6E22F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjDNMQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNMQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:16:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EBE69;
        Fri, 14 Apr 2023 05:16:43 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBC42660320A;
        Fri, 14 Apr 2023 13:16:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681474602;
        bh=NFn62VCgE8BtyPDm9f+d9wnOFXohEUmpjn3vfRhx9Kw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ue+FlKa43xQKFE6Ep+0r4kzO4Dao/BeMiC1sFqP3xR/2faTH3qyhQItplHAUj9Eeq
         7mum4EEEp7Ow14y2ZNsKduNirTcWaOOprVTqBCENSCf2TICWZQ4wDZKcMmc4Zp8pAP
         CECy9sRtquIr/MCREKf7Fr0hXcQbNVr82r5Oxohns+n1lH3H/ny/yVKUhSICr5oAu7
         O+KIxdEkuTmVMNovvdDV/qUhewdxDUuEvoEZp68qZSmunRM3YGgSjWSHVTIkrLASx+
         Ay28BbYuYB1FChKZE+WXi8XAtRX975U0tNdQXOMT9eLPVTTr/ahDz4MhjrCZsgYSo3
         1kdQ7KQdeegHA==
Message-ID: <33865587-5b5c-c9cd-8085-3578f4325474@collabora.com>
Date:   Fri, 14 Apr 2023 15:16:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add vdd_cpu_big regulators to
 rk3588-rock-5b
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230414093411.113787-1-cristian.ciocaltea@collabora.com>
 <20230414093411.113787-4-cristian.ciocaltea@collabora.com>
 <0cbafc31-9b46-54df-f569-810a8781743c@linaro.org>
 <36d8050b-0636-2b30-f3fc-7f7d96bec253@collabora.com>
 <b75a846c-63be-9f30-e786-f34292cfeaf4@linaro.org>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <b75a846c-63be-9f30-e786-f34292cfeaf4@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 14:29, Krzysztof Kozlowski wrote:
> On 14/04/2023 12:40, Cristian Ciocaltea wrote:
>> On 4/14/23 13:27, Krzysztof Kozlowski wrote:
>>> On 14/04/2023 11:34, Cristian Ciocaltea wrote:
>>>> The RK8602 and RK8603 voltage regulators on the Rock 5B board provide
>>>> the power lines vdd_cpu_big0 and vdd_cpu_big1, respectively.
>>>>
>>>> Add the necessary device tree nodes and bind them to the corresponding
>>>> CPU big core nodes.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  .../boot/dts/rockchip/rk3588-rock-5b.dts      | 56 +++++++++++++++++++
>>>>  1 file changed, 56 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> index 8cc97d146a73..3e4aee8f70c1 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
>>>> @@ -53,6 +53,62 @@ vcc5v0_sys: vcc5v0-sys-regulator {
>>>>  	};
>>>>  };
>>>>  
>>>> +&cpu_b0 {
>>>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b1 {
>>>> +	cpu-supply = <&vdd_cpu_big0_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b2 {
>>>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>>>> +};
>>>> +
>>>> +&cpu_b3 {
>>>> +	cpu-supply = <&vdd_cpu_big1_s0>;
>>>> +};
>>>> +
>>>> +&i2c0 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&i2c0m2_xfer>;
>>>> +	status = "okay";
>>>> +
>>>> +	vdd_cpu_big0_s0: regulator@42 {
>>>> +		compatible = "rockchip,rk8602";
>>>
>>> Looking at your next node, this is surprising... Double check if you
>>> have correct compatibles everywhere.
>>>
>>>> +		reg = <0x42>;
>>>> +		fcs,suspend-voltage-selector = <1>;
>>>
>>> Does not look like you tested the DTS against bindings. Please run `make
>>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>>> for instructions).
>>>
>>>> +		regulator-name = "vdd_cpu_big0_s0";
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +		regulator-min-microvolt = <550000>;
>>>> +		regulator-max-microvolt = <1050000>;
>>>> +		regulator-ramp-delay = <2300>;
>>>> +		vin-supply = <&vcc5v0_sys>;
>>>> +
>>>> +		regulator-state-mem {
>>>> +			regulator-off-in-suspend;
>>>> +		};
>>>> +	};
>>>> +
>>>> +	vdd_cpu_big1_s0: regulator@43 {
>>>> +		compatible = "rockchip,rk8603", "rockchip,rk8602";
>>>> +		reg = <0x43>;
>>>> +		fcs,suspend-voltage-selector = <1>;
>>>
>>> Does not look like you tested the DTS against bindings. Please run `make
>>> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
>>> for instructions).
>>
>> I mentioned in the cover letter that the support for the RK860X 
>> regulators has been recently merged via [1]. The patches in this 
>> series have been verified on next-20230413.
> 
> OK. The question about compatibles still stays - but maybe you have
> indeed 8603 and 8602 in the same time.

Yes, according to [1], initially discussed in [2].

[1] https://lore.kernel.org/lkml/20230406194158.963352-2-cristian.ciocaltea@collabora.com/
[2] https://lore.kernel.org/lkml/ea1dfe0f-4ed3-9bfb-dc6b-6d87b0267a99@linaro.org/

Regards,
Cristian
