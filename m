Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F09F69FB18
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjBVSjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbjBVSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:39:37 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AEA3E634;
        Wed, 22 Feb 2023 10:39:35 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 86D2380BA3;
        Wed, 22 Feb 2023 19:39:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1677091173;
        bh=ZUvpfxONC+skiqBf9Viy1W40fjIvV4a6eK4VerO+wEw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i65BGifxuos5G94EIx/GSuwWFq8WX1FjuYEffwHKLxJMCfAJ2soUfxaHEdaVDZI0A
         o3HblrhlfKtk3Iyf88E66j7emwt4vAHyosAO8AdXTUi6RN1tBV2YcRkxydrUv5yuT0
         Vu6z89KgDwpCwimmxlE3EV5gBUJHVlYPSCpuRi3rY+oIANNPAPDrc5UVOhTQkqHqxg
         hhSiZhXvurGFeWSEi4S2/MtKP69BnZgIJ62uIoHhJrMUZNDTrstv6PyHs8+Q7QDHtx
         mraBp378cfDibCTxBard75eVhBgmSTOCX6yhepS/dcoJKVuFtK97mDwN/gKiC4e74C
         KLYYU8NRq+eiw==
Message-ID: <10394cf6-70f0-638a-15d3-5a14615dad44@denx.de>
Date:   Wed, 22 Feb 2023 19:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martyn Welch <martyn.welch@collabora.com>,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, Jacky Bai <ping.bai@nxp.com>
References: <20230222182252.2ad6d82b@booty>
 <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
 <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230222175941.7pdi7yg5am3ws4gp@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 18:59, Marco Felsch wrote:
> Hi Luca,
> 
> On 23-02-22, Luca Ceresoli wrote:
>> The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
>> NXPP SGTL5000 audio codec connected to I2S-0 (sai2).
>>
>> This requires to:
>>
>>   * add the power supplies (always on)
>>   * enable sai2 with pinmuxes
>>   * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
>>     IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
>>
>> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
>> ---
>>   .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
>>   1 file changed, 60 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>> index 470ff8e31e32..894d9809f76d 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
>> @@ -14,6 +14,57 @@ / {
>>   	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
>>   		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
>>   		     "fsl,imx8mp";
> 
> ...
> 
>> +/* I2S-0 = sai2 */
>> +&sai2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_sai2>;
>> +
>> +	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
>> +	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
>> +	assigned-clock-rates = <12288000>;
>> +
>> +	fsl,sai-mclk-direction-output;
>> +	status = "okay";
>>   };
> 
> Do you have some downstream patches for the sai interfaces? AFAIR Marek
> worked on this but the patches are not mainlien yet.

I guess it is time to resubmit these.
