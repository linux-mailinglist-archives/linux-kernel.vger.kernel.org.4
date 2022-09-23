Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63C05E77AE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiIWJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiIWJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:53:56 -0400
X-Greylist: delayed 45074 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 02:53:55 PDT
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B39B5159;
        Fri, 23 Sep 2022 02:53:55 -0700 (PDT)
Message-ID: <ad36710b-af7d-f9ca-fa04-cbb9acb5f123@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
        t=1663926833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gn6QZKyXCWPIw+IVFSiZn7BPyYuukt8qvGTzGCzdE74=;
        b=qGx+rQKBiZpQYiOOhw61gYJMEMTi5KCbHoaWhDkr8vvIBNKNPnxaoxwdnqIMz7BiK75/LB
        d/fIsv1MGiK821W8tNH1KTVnWTxvTLxoaOMxxciy1BcRQDgUZECRxdYcoPFnLhi6qgwAo5
        mzycAHBmVztNl0D/toxAwxgnrnkqFu7frIeULSHDFfRI0RTeAxrwo9QifB1Aj0Zx167u4Z
        3ai99uAdNtazNwCi+Mahi8vWwTGkiHfQ4UBgwI6x6TuXZZyGY0QGjii0B0vvFiNFyGvRu/
        WSkn35dqslVd7O+qL/0TUWL4teDlXBK5DC1glHcIgdCkni6YjiJdVYxDF+urHg==
Date:   Fri, 23 Sep 2022 11:53:52 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm64: dts: rockchip: Enable HDMI and GPU on quartz64-b
Content-Language: da-DK
To:     Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920143446.633956-1-frattaroli.nicolas@gmail.com>
 <659fc2fe-f820-04ad-8a4f-224b4d4bd97b@manjaro.org> <2198677.PYKUYFuaPT@phil>
From:   Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <2198677.PYKUYFuaPT@phil>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Den 23.09.2022 kl. 11.45 skrev Heiko Stuebner:
> Hi,
>
> Am Donnerstag, 22. September 2022, 23:22:37 CEST schrieb Dan Johansen:
>> This seems to be based against linux-next and not mainline. It fails to
>> apply on mainline for me.
> I would not expect things any other way though :-) .
> I.e. in the current cycle everything new is of course targetting
> v6.1 and the Quartz boards already saw some other changes.

Ah okay. I have misunderstood the submitting process then.

I was under the impression that a patch should always target the latest 
-rc1, in this case 6.0-rc1.

I did not know that when you are at rc6/rc7 it's okay to target 
linux-next without
mentioning it.

Sorry for my noise.

>
>
>> Den 20.09.2022 kl. 16.34 skrev Nicolas Frattaroli:
>>> This enables the GPU and HDMI output (including HDMI audio) on
>>> the PINE64 Quartz64 Model B single board computer.
>>>
>>> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
>>> ---
>>>    .../boot/dts/rockchip/rk3566-quartz64-b.dts   | 60 +++++++++++++++++++
>>>    1 file changed, 60 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> index 0f623198970f..77b179cd20e7 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-b.dts
>>> @@ -4,6 +4,7 @@
>>>    
>>>    #include <dt-bindings/gpio/gpio.h>
>>>    #include <dt-bindings/pinctrl/rockchip.h>
>>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>>    #include "rk3566.dtsi"
>>>    
>>>    / {
>>> @@ -28,6 +29,17 @@ gmac1_clkin: external-gmac1-clock {
>>>    		#clock-cells = <0>;
>>>    	};
>>>    
>>> +	hdmi-con {
>>> +		compatible = "hdmi-connector";
>>> +		type = "a";
>>> +
>>> +		port {
>>> +			hdmi_con_in: endpoint {
>>> +				remote-endpoint = <&hdmi_out_con>;
>>> +			};
>>> +		};
>>> +	};
>>> +
>>>    	leds {
>>>    		compatible = "gpio-leds";
>>>    
>>> @@ -183,6 +195,33 @@ &gmac1m1_clkinout
>>>    	status = "okay";
>>>    };
>>>    
>>> +&gpu {
>>> +	mali-supply = <&vdd_gpu>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&hdmi {
>>> +	avdd-0v9-supply = <&vdda0v9_image>;
>>> +	avdd-1v8-supply = <&vcca1v8_image>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&hdmi_in {
>>> +	hdmi_in_vp0: endpoint {
>>> +		remote-endpoint = <&vp0_out_hdmi>;
>>> +	};
>>> +};
>>> +
>>> +&hdmi_out {
>>> +	hdmi_out_con: endpoint {
>>> +		remote-endpoint = <&hdmi_con_in>;
>>> +	};
>>> +};
>>> +
>>> +&hdmi_sound {
>>> +	status = "okay";
>>> +};
>>> +
>>>    &i2c0 {
>>>    	status = "okay";
>>>    
>>> @@ -456,6 +495,10 @@ &i2c5 {
>>>    	status = "disabled";
>>>    };
>>>    
>>> +&i2s0_8ch {
>>> +	status = "okay";
>>> +};
>>> +
>>>    &i2s1_8ch {
>>>    	pinctrl-names = "default";
>>>    	pinctrl-0 = <&i2s1m0_sclktx
>> The above part does not seem to exist in the current mainline (rc6) git
>> repo.
> which is of course already in linux-next, so this
> patch just applied nicely.
>
>
> Heiko
>
>>> @@ -677,3 +720,20 @@ &usb_host0_ehci {
>>>    &usb_host0_ohci {
>>>    	status = "okay";
>>>    };
>>> +
>>> +&vop {
>>> +	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP1>;
>>> +	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
>>> +	status = "okay";
>>> +};
>>> +
>>> +&vop_mmu {
>>> +	status = "okay";
>>> +};
>>> +
>>> +&vp0 {
>>> +	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>>> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
>>> +		remote-endpoint = <&hdmi_in_vp0>;
>>> +	};
>>> +};
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
