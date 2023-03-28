Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AE6CCAE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 21:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjC1Tq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjC1Tqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 15:46:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA926B7;
        Tue, 28 Mar 2023 12:46:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ED6961902;
        Tue, 28 Mar 2023 19:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BA1C433D2;
        Tue, 28 Mar 2023 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680032813;
        bh=Lmu/Mq2nMz3/AF7qQFtIhYKDY1SCuBIjyGhCVC4C96g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sz4ARuzNm8dKti0tdjEdSeHll5ISYj6remDDdQ4Heml9kiLskkVRYbkhTq/bjSwhW
         R8hzgRlumr+NzSxuzHeRaxopEsJxIYhAJrDBiGByQdo2ZdVwu2GFnweD3VYQVIdHtc
         xkHbqxp1WPZh+nVQKAOWP6k2trSzSaN4tSgh9DWWjGhL3VEoDwVrk78JpGumcvKXLS
         AdvTTBFciEUM8pF/JZwRXb5EiUcsoGGzd0BiCGwUedkHSeMlRz4nTQ4XQCEwygmmEj
         P6wNkRds2hG4W2DSFU3ewcqXKCX9wMNigGBFLiXVFLRB6EFGzlM3dtRM3ZrfzO5BuH
         tTcB1gzjfocZw==
Message-ID: <39cb4f8c-d10f-f543-ddca-8a8507757f4c@kernel.org>
Date:   Tue, 28 Mar 2023 22:46:48 +0300
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
 <3bd6191c-caa4-15a8-92ad-17a07ec085e2@kernel.org>
 <20230328133024.ow6cvm22o2c5heem@untrimmed>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230328133024.ow6cvm22o2c5heem@untrimmed>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 16:30, Nishanth Menon wrote:
> On 16:20-20230328, Roger Quadros wrote:
>>
>>
>> On 28/03/2023 16:18, Nishanth Menon wrote:
>>> On 15:43-20230328, Roger Quadros wrote:
>>>> USB0 is a Type-C port with dual data role and power sink.
>>>>
>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts      |  4 ++
>>>>  arch/arm64/boot/dts/ti/k3-am625-sk.dts        | 44 ++++++++++++++++++-
>>>>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi |  4 --
>>>>  3 files changed, 47 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>>>> index b2ca19e3042e..a3c3609833fd 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
>>>> @@ -225,3 +225,7 @@ ldo4_reg: ldo4 {
>>>>  		};
>>>>  	};
>>>>  };
>>>> +
>>>> +&usb0 {
>>>> +	dr_mode = "peripheral";
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>>>> index cdc0858dd1b2..13fdaa9ce4e7 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>>>> @@ -136,6 +136,35 @@ AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
>>>>  	};
>>>>  };
>>>>  
>>>> +&main_i2c0 {
>>>> +	typec_pd: tps6598x@3f {
>>>> +		compatible = "ti,tps6598x";
>>>> +		reg = <0x3f>;
>>>> +		interrupt-parent = <&exp1>;
>>>> +		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
>>>> +		interrupt-names = "irq";
>>>> +
>>>> +		connector {
>>>> +			compatible = "usb-c-connector";
>>>> +			label = "USB-C";
>>>> +			self-powered;
>>>> +			data-role = "dual";
>>>> +			power-role = "sink";
>>>> +			ports {
>>>> +				#address-cells = <1>;
>>>> +				#size-cells = <0>;
>>>> +
>>>> +				port@0 {
>>>> +					reg = <0>;
>>>> +					usb_con_hs: endpoint {
>>>> +						remote-endpoint = <&usb0_hs_ep>;
>>>> +					};
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +};
>>>> +
>>>>  &main_i2c1 {
>>>>  	exp1: gpio@22 {
>>>>  		compatible = "ti,tca6424";
>>>> @@ -150,7 +179,7 @@ exp1: gpio@22 {
>>>>  				   "UART1_FET_BUF_EN", "WL_LT_EN",
>>>>  				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
>>>>  				   "CSI_GPIO2", "PRU_3V3_EN",
>>>> -				   "HDMI_INTn", "TEST_GPIO2",
>>>> +				   "HDMI_INTn", "PD_I2C_IRQ",
>>>>  				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
>>>>  				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>>>>  				   "TSINT#", "IO_EXP_TEST_LED";
>>>> @@ -256,3 +285,16 @@ partition@3fc0000 {
>>>>  		};
>>>>  	};
>>>>  };
>>>> +
>>>> +&usb0 {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +	usb-role-switch;
>>>> +
>>>> +	port@0 {
>>>> +		reg = <0>;
>>>> +		usb0_hs_ep: endpoint {
>>>> +		    remote-endpoint = <&usb_con_hs>;
>>>> +	       };
>>>> +	};
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> index 80e8b9b9a5f5..e3223088b90c 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
>>>> @@ -264,10 +264,6 @@ &usbss1 {
>>>>  	ti,vbus-divider;
>>>>  };
>>>>  
>>>> -&usb0 {
>>>> -	dr_mode = "peripheral";
>>>> -};
>>>> -
>>>
>>> 	How about sk-lp ?
>>
>> moved it to sk-lp. see above in this patch.
>>
> 
> A bit confused. Looking at [1] vs [2], it seems to indicate pd controller at
> 0x3f as well? Am I misreading the schematics?
> 
> [1] https://www.ti.com/tool/SK-AM62-LP#design-files
> [2] https://www.ti.com/tool/SK-AM62#design-files

Yes PD controller is at 0x3f for both boards but IRQ is not routed on AM62-LP.
I tried to explain this the cover letter. ;)

Pasting here for convenience.

> Although k3-am625-lp-sk USB is exactly the same as on k3-am625-sk,
> it is missing the IRQ line from Type-C chip which is currently
> required as per chip's DT binding. So we don't add Type-C support
> for k3-am625-lp-sk till h/w is fixed or polling mode support for
> Type-C chip is accepted [2]
> 
> [2] - https://lore.kernel.org/lkml/20230324133741.43408-1-rogerq@kernel.org/T/


cheers,
-roger
