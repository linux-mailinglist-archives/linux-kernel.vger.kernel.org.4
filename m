Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D886D48E7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjDCOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjDCOcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:32:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6CE55;
        Mon,  3 Apr 2023 07:32:40 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBD9B6603105;
        Mon,  3 Apr 2023 15:32:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680532359;
        bh=1+OmtAU+X5ofND6+HKtIRQa4thdWvYXhzR1UpKwsmAw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=liYpJVhXmyjhlDv/Y1XYxp/UX64teQeHTO9Gd0cJEY9Nz4Tk6L3tqoH6NBrb1O+nf
         CYTgCZrj+BtbzkcMEYCzgQKnDQebi2aZH2FwJkQav9PxmpP8KqMU9ruKrY41pQHpIw
         M23vaSHAzGEMxkhSeDmMtIaKwua4OFctdCVQtP3gPoMhAOcymu3arJVDiCMCMfPmQZ
         nGCZO1E2v2TSQRFpGOSjucwF11JCKGaqoxmOKGu5m1VTi/eI55ySNpOdNNGlgLFt6p
         hoerbHx+M7r1x9WziipAcedknNvKxPOdiVvbM7yRyeM3plnQrBWQLzpU9jmZxFSRh4
         waWBQk8nFWUmA==
Message-ID: <dcd79e14-d9df-39c1-5465-4e9d71221659@collabora.com>
Date:   Mon, 3 Apr 2023 17:32:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: pwm-fan: Convert to DT schema
To:     Rob Herring <robh@kernel.org>
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
Content-Language: en-US
In-Reply-To: <168052514639.463695.9544022277060710805.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 16:10, Rob Herring wrote:
> 
> On Mon, 03 Apr 2023 13:50:51 +0300, Cristian Ciocaltea wrote:
>> Convert the PWM fan bindings to DT schema format.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   .../devicetree/bindings/hwmon/pwm-fan.txt     |  68 +----------
>>   .../devicetree/bindings/hwmon/pwm-fan.yaml    | 109 ++++++++++++++++++
>>   2 files changed, 110 insertions(+), 67 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/pwm-fan.yaml
>>
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230403105052.426135-2-cristian.ciocaltea@collabora.com
> 
> 
> pwm-fan: 'cooling-max-state', 'cooling-min-state' do not match any of the regexes: 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dtb
> 	arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dtb
> 

The only references to the offending cooling-{min|max}-state are located 
in a few DTS files. Assuming they are obsolete, may I simply drop them?

$ git grep "cooling-.*-state"

arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi: cooling-min-state = <0>;
arch/arm64/boot/dts/amlogic/meson-g12b-bananapi.dtsi: cooling-max-state = <3>;
arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts: cooling-min-state = <0>;
arch/arm64/boot/dts/amlogic/meson-sm1-odroid-hc4.dts: cooling-max-state = <3>;
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-min-state = <0>;
arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts:        cooling-max-state = <3>;
arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:        cooling-min-state = <0>;
arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi:        cooling-max-state = <9>;
