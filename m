Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962B669527B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBMU7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjBMU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:59:32 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5718D2056F;
        Mon, 13 Feb 2023 12:59:31 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E8A7285232;
        Mon, 13 Feb 2023 21:59:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676321969;
        bh=vhmjBfKJllb1DaeaYosk4z9xVm2EbQAiMrbMD8erdZU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mz4a6xO+w7Pb2kWwOHddX8HWj3zie/VaPszErG058fPUWD4d7gXv5SQCVuyundDma
         fEdvnHUaaq/jYCxnDvkuRIP/uJ9OBie5lVmr/RLC9WBDN4+cSroZbj6s/sNRFJu38F
         SCF3EDH4ibLdWvZgkYqHiSMxPMAJx+gl04Dk3/yPxmJSDhZLZoJUboUnS175kHVCBh
         QVI0VKajK3S58Buu5wCl3t+fUAYYs0cowytKR73kxG48BWq6SQCaVEUkVzqwlbaspe
         RFw3CGRvLx0a7XbkgTZyD/lQ/GWY1nBTQj+RtQ4Lp1P2wgiay0lGYB26gWSh+RGHV3
         xcMrIPr6ExaRA==
Message-ID: <b900238d-b06a-a9d7-6892-6a726603b63b@denx.de>
Date:   Mon, 13 Feb 2023 21:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Frieder Schrempf <frieder@fris.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
 <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
 <eef49a1c-4dc3-7517-c760-ecc20704f943@denx.de>
 <20230213195617.xndagbarc3k5kegr@pengutronix.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230213195617.xndagbarc3k5kegr@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 20:56, Marco Felsch wrote:
> Hi Marek, Frieder,

Hi,

> On 23-02-13, Marek Vasut wrote:
>> On 2/13/23 17:15, Marco Felsch wrote:
>>
>> [...]
>>
>>>> @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>>>>    			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>>>>    			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>>>>    			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>>>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>>>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>>
>>> The VSELECT pin should be driven by the (u)sdhc core...
>>>
>>>>    		>;
>>>>    	};
>>>>    };
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>> index 5172883717d1..90daaf54e704 100644
>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>>>> @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
>>>>    				regulator-name = "NVCC_SD (LDO5)";
>>>>    				regulator-min-microvolt = <1800000>;
>>>>    				regulator-max-microvolt = <3300000>;
>>>> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>>>
>>> and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
>>> muxed as GPIO, which is not the case. So I think that u-boot have a bug
>>> within the (u)sdhc core.
>>
>> The trick here is that the VSELECT is operated by the usdhc block as a
>> function pin, but the PMIC driver can read the current state of the VSELECT
>> pin by reading out the GPIO block SR register. Since the IOMUX SION bit is
>> set on the VSELECT pin, the state of the pin is reflected in the GPIO block
>> SR register even if the pin is muxed as function pin.
>>
> 
> Thanks for this explanation :) Why does the regulator driver need to
> know the current state of this pin?

Because that regulator has an input pin which selects between two states 
of that regulator, L and H, and whatever L or H is depends on what is 
configured into the regulator via I2C. To correctly report the state of 
the regulator, you have to know the state of that input (selector) pin.

> Since the voltage switching requires
> some cmd's before the actual voltage level switch. So this must be
> handled within the core.
> 
> Also after checking the driver, adding the sd-vsel-gpios will request
> the specified gpio as output-high.

The GPIO would have to be requested as input, obviously.

> Out of curiosity, what's the bug you
> triggering within U-Boot?

AFAICT the readback of the initial state of the regulator (see paragraph 
above), which affects Linux all the same.
