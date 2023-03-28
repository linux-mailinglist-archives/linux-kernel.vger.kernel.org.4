Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6196CC080
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjC1NUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1NUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:20:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B547285;
        Tue, 28 Mar 2023 06:20:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BAD4B81CE2;
        Tue, 28 Mar 2023 13:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAAFC433D2;
        Tue, 28 Mar 2023 13:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680009636;
        bh=5tnop86RGk/JEGzRsCtlS0MutYIKlSV6gY1wa0KEk80=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ViUnbjsq3ANM3YsefdBr8s2TS/dgXbeFSZNH9bjIjHsVH5UV0gUoqAy6UyBUzZsvU
         yaF/+SJB8sTBm5DXnv/ICBfyBKUhRz6UL2zqveMBM7bMLTKW800ghdAziw6HO4+W11
         n6tGxhh8ipgI8liZFGWCI3p/o34GL7rIa2tsSIXPtf489udAzqXtfaxJvRgzL0yEAH
         mXfWgUTvTrPofOLJ9YF4LY0sHnGy908FAwS95gQM5SQJx9C4pnz2eAry2ecP8MY1vW
         PIe8+bH60ttWPh+p8nGar0jzflvRFf6IoKPyJTp2sns5unZSMqUcMqlf1VH/CSikkP
         Em/U862GQny9A==
Message-ID: <3bd6191c-caa4-15a8-92ad-17a07ec085e2@kernel.org>
Date:   Tue, 28 Mar 2023 16:20:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port
 for USB0
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328124315.123778-1-rogerq@kernel.org>
 <20230328124315.123778-3-rogerq@kernel.org>
 <20230328131810.x2j6uvwzhniclvwf@evoke>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230328131810.x2j6uvwzhniclvwf@evoke>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 16:18, Nishanth Menon wrote:
> On 15:43-20230328, Roger Quadros wrote:
>> USB0 is a Type-C port with dual data role and power sink.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |  4 ++
>>  arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 44 ++++++++++++++++++-
>>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  4 --
>>  3 files changed, 47 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>> index b2ca19e3042e..a3c3609833fd 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>> @@ -225,3 +225,7 @@ ldo4_reg: ldo4 {
>>  		};
>>  	};
>>  };
>> +
>> +&usb0 {
>> +	dr_mode = "peripheral";
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> index cdc0858dd1b2..13fdaa9ce4e7 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> @@ -136,6 +136,35 @@ AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
>>  	};
>>  };
>>  
>> +&main_i2c0 {
>> +	typec_pd: tps6598x@3f {
>> +		compatible = "ti,tps6598x";
>> +		reg = <0x3f>;
>> +		interrupt-parent = <&exp1>;
>> +		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
>> +		interrupt-names = "irq";
>> +
>> +		connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			self-powered;
>> +			data-role = "dual";
>> +			power-role = "sink";
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {
>> +					reg = <0>;
>> +					usb_con_hs: endpoint {
>> +						remote-endpoint = <&usb0_hs_ep>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &main_i2c1 {
>>  	exp1: gpio@22 {
>>  		compatible = "ti,tca6424";
>> @@ -150,7 +179,7 @@ exp1: gpio@22 {
>>  				   "UART1_FET_BUF_EN", "WL_LT_EN",
>>  				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
>>  				   "CSI_GPIO2", "PRU_3V3_EN",
>> -				   "HDMI_INTn", "TEST_GPIO2",
>> +				   "HDMI_INTn", "PD_I2C_IRQ",
>>  				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
>>  				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>>  				   "TSINT#", "IO_EXP_TEST_LED";
>> @@ -256,3 +285,16 @@ partition@3fc0000 {
>>  		};
>>  	};
>>  };
>> +
>> +&usb0 {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	usb-role-switch;
>> +
>> +	port@0 {
>> +		reg = <0>;
>> +		usb0_hs_ep: endpoint {
>> +		    remote-endpoint = <&usb_con_hs>;
>> +	       };
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> index 80e8b9b9a5f5..e3223088b90c 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>> @@ -264,10 +264,6 @@ &usbss1 {
>>  	ti,vbus-divider;
>>  };
>>  
>> -&usb0 {
>> -	dr_mode = "peripheral";
>> -};
>> -
> 
> 	How about sk-lp ?

moved it to sk-lp. see above in this patch.

> 
>>  &usb1 {
>>  	dr_mode = "host";
>>  	pinctrl-names = "default";
>> -- 
>> 2.34.1
>>
> 

cheers,
-roger
