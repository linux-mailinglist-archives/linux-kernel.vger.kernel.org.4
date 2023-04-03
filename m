Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFAE6D4A1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjDCOoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjDCOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:43:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE68D18277;
        Mon,  3 Apr 2023 07:43:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 276986600013;
        Mon,  3 Apr 2023 15:43:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680533019;
        bh=FMW2V0QhNr9KmmQQvwTNbvMyfuMlgFqGmHE5d/N4Q98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gvZ0iH18UpaYkWDUm3rMoLDTk6C2iseTXbrfMpzuDazu1l5+y/6Aj+lK9K3BxosNo
         hkBYhgAhz1vDI+UTMblPVB4QvsKwc7+jqAC0s7aAnXk6gLxl5ckVlvnZh8XwzQCqEQ
         joqaus5x7tph+fe2sVIQLZRzhwe773G8LHxyDCWm6MYtO53H53dl9WZpKDtSxHjPJz
         u1Cq+0V8EGIYkpiM9T8lXSstdmVOf8wiqhgzbYk4ooPYtQzYRjxEmOldei/q0DvSUR
         RHXLJYgjEt/aYA0dVW48GsmJmWNyIPpmhzu5cBF/WyduOD1MaEg+M/rbjhc6R4hb8s
         vRZzYwx85LhsA==
Message-ID: <79396eed-18ab-bcee-5c7e-c3e5e61f32c3@collabora.com>
Date:   Mon, 3 Apr 2023 16:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
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
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <dcd79e14-d9df-39c1-5465-4e9d71221659@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 16:32, Cristian Ciocaltea ha scritto:
> On 4/3/23 16:10, Rob Herring wrote:
>>
>> On Mon, 03 Apr 2023 13:50:51 +0300, Cristian Ciocaltea wrote:
>>> Convert the PWM fan bindings to DT schema format.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>    .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>>>    .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>>>    2 files changed, 110 insertions(+), 67 deletions(-)
>>>    create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403105052.426135-2-cristian.ciocaltea@collabora.com
>>
>>
>> pwm-fan: 'cooling-max-state', 'cooling-min-state' do not match any of the regexes: 'pinctrl-[0-9]+'
>> 	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
>> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
>>
> 
> The only references to the offending cooling-{min|max}-state are located
> in a few DTS files. Assuming they are obsolete, may I simply drop them?
> 

If they're obsolete, you can mark them as `deprecated: true` in the binding, but
dropping them entirely would be an ABI breakage, so no, you can't.

Regards,
Angelo

> $ git grep "cooling-.*-state"
> 
> arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi: cooling-min-state = <0>;
> arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi: cooling-max-state = <3>;
> arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts: cooling-min-state = <0>;
> arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts: cooling-max-state = <3>;
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-min-state = <0>;
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-max-state = <3>;
> arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:        cooling-min-state = <0>;
> arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:        cooling-max-state = <9>;
> 


