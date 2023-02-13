Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1420694EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjBMSM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjBMSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:12:54 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599881EFE7;
        Mon, 13 Feb 2023 10:12:28 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A0EEF8564B;
        Mon, 13 Feb 2023 19:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676311944;
        bh=/yPHjrWLL3NXz1sw5YGJZHaZLQK8RuSfKRlUWsWgS+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vE8SkwKaVrMo5eOQY11TLrkpTuau7g2zVErD5wrAbqzb7JtSBtswTy0eF6/JBoky+
         vLTUzSycoNzbrVx1dXplSf1Sa5b9Gt4hi7T/sc7DhQx3hTz7KPr/Os9kttUedw620V
         zDIgHA2Orvm2QPtg8ulYnUaWXw6vOa8/9Os+ITfFXCDk5HDzzcPWyH7zvsxW07keRP
         QEg5rhMCAU6DyMjnb7O1S8dzyb9+NlqBfBli1qSEzCKnDH9ZGMqChE8pmmqWN4oTll
         0i3I+adj+81OCnnbhMAw+mX9GnUGx0YQyvkdrgvu/qlCwcOQ798jiPeplZgcubpyKD
         yQp0E69vWBaww==
Message-ID: <eef49a1c-4dc3-7517-c760-ecc20704f943@denx.de>
Date:   Mon, 13 Feb 2023 19:12:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
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
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
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

On 2/13/23 17:15, Marco Felsch wrote:

[...]

>> @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>>   			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>>   			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>>   			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
> 
> The VSELECT pin should be driven by the (u)sdhc core...
> 
>>   		>;
>>   	};
>>   };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> index 5172883717d1..90daaf54e704 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
>>   				regulator-name = "NVCC_SD (LDO5)";
>>   				regulator-min-microvolt = <1800000>;
>>   				regulator-max-microvolt = <3300000>;
>> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> 
> and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
> muxed as GPIO, which is not the case. So I think that u-boot have a bug
> within the (u)sdhc core.

The trick here is that the VSELECT is operated by the usdhc block as a 
function pin, but the PMIC driver can read the current state of the 
VSELECT pin by reading out the GPIO block SR register. Since the IOMUX 
SION bit is set on the VSELECT pin, the state of the pin is reflected in 
the GPIO block SR register even if the pin is muxed as function pin.
