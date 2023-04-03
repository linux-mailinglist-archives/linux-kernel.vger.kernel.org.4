Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC626D4D77
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjDCQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:22:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9772137;
        Mon,  3 Apr 2023 09:22:50 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0CCED66030F1;
        Mon,  3 Apr 2023 17:22:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680538968;
        bh=KZFxkxlJwNymS68Q84h+uC4PbGDB/VlWh4Zh9RnB1Mk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aVWszbJnKMu1vphEXT7Y+ZUFkCAEfH4uCwtlsHcGw7FoGzU49BlqzoL+v+dHCIA2+
         zHM9S/TnBX900XiTtNOAWEp16glpjZNb2V99cfxjYQfgmwe5CTYRPBlNrw6q14OlQ4
         4YukySR3AR+WUwzEOUGniclING2u0kIsnfEL9R7vGxbGx4CFML/eIlzJD6PkBlC2B+
         c1652NuqCZ0FHZZ1u7vuYPcIpJdacmMWvVxz2Npzpxt41nP1YYQzTzyQ7EVDt+rots
         BlyaHNTtrRYKy0zZ6QJGpGFDhitfQG4RnpGK/GB4i1J0O/sNB0j8tkPQWkhcqI0efq
         bElzJAvst3PaQ==
Message-ID: <49c226ff-08a3-a7ca-59bd-f0b9cea865e3@collabora.com>
Date:   Mon, 3 Apr 2023 19:22:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20230403105052.426135-1-cristian.ciocaltea@collabora.com>
 <20230403105052.426135-2-cristian.ciocaltea@collabora.com>
 <168052514639.463695.9544022277060710805.robh@kernel.org>
 <dcd79e14-d9df-39c1-5465-4e9d71221659@collabora.com>
 <79396eed-18ab-bcee-5c7e-c3e5e61f32c3@collabora.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <79396eed-18ab-bcee-5c7e-c3e5e61f32c3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 17:43, AngeloGioacchino Del Regno wrote:
> Il 03/04/23 16:32, Cristian Ciocaltea ha scritto:
>> On 4/3/23 16:10, Rob Herring wrote:
>>>
>>> On Mon, 03 Apr 2023 13:50:51 +0300, Cristian Ciocaltea wrote:
>>>> Convert the PWM fan bindings to DT schema format.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>    .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>>>>    .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109
>>>> ++++++++++++++++++
>>>>    2 files changed, 110 insertions(+), 67 deletions(-)
>>>>    create mode 100644
>>>> Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>>>>
>>>
>>> Running 'make dtbs_check' with the schema in this patch gives the
>>> following warnings. Consider if they are expected or the schema is
>>> incorrect. These may not be new warnings.
>>>
>>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>>> This will change in the future.
>>>
>>> Full log is available here:
>>> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403105052.426135-2-cristian.ciocaltea@collabora.com
>>>
>>>
>>> pwm-fan: 'cooling-max-state', 'cooling-min-state' do not match any of
>>> the regexes: 'pinctrl-[0-9]+'
>>>     arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
>>>     arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
>>>
>>
>> The only references to the offending cooling-{min|max}-state are located
>> in a few DTS files. Assuming they are obsolete, may I simply drop them?
>>
> 
> If they're obsolete, you can mark them as `deprecated: true` in the
> binding, but
> dropping them entirely would be an ABI breakage, so no, you can't.

From the pwm-fan driver point of view, the properties are not supported
and I couldn't find any indication that they could have been used in the
past.

Hence I'm not sure adding them to the binding is the proper way to
handle this issue.

Thanks,
Cristian

> Regards,
> Angelo
> 
>> $ git grep "cooling-.*-state"
>>
>> arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi:
>> cooling-min-state = <0>;
>> arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi:
>> cooling-max-state = <3>;
>> arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts:
>> cooling-min-state = <0>;
>> arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts:
>> cooling-max-state = <3>;
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-min-state = <0>;
>> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-max-state = <3>;
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:       
>> cooling-min-state = <0>;
>> arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:       
>> cooling-max-state = <9>;
>>
> 
> 
> 
