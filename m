Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA846C8E59
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjCYND6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18294231;
        Sat, 25 Mar 2023 06:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB8860C4F;
        Sat, 25 Mar 2023 13:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021D7C433EF;
        Sat, 25 Mar 2023 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679749433;
        bh=SdU9kHEoxW2j7sZXsy+1t2VVON6O+/GheN3KRNLgs1E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lODoXwMzbTBrWzv4nDvHf9nn7KL/E7kjb22atsRTMAfthkBVqZOoHTNKCNBxvZGkY
         fNjc8eP5VZ8JDHfLEyYaReVfSYoJx9a4Spl4Ndw5K19r7uyZ0g+/njV0/T4vpymnL+
         Oq1uKEdQwEJi6UHPKTj58iCdB5sn9RiUNiUWSZlxFsf0JXIZJEWrAovXN95Hv7EZnd
         BzEyvLugFp6TihFwMV4fYlQbv1/npZYKtaDhVN6a3JdWLejC+9fKplxXl2IWXEFo1U
         Dtzy8gxUgrcqikmDA9Xq16aTjbXRAG25sJ+xU3hnDmJY/zwkv5GC5e2wjgUv7Hapzr
         n3A/hHaCfTSlQ==
Message-ID: <88c7d438-28ad-cc17-6abe-d8e1853260e9@kernel.org>
Date:   Sat, 25 Mar 2023 15:03:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-am625-sk: Enable Type-C port for
 USB0
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230324133150.43224-1-rogerq@kernel.org>
 <20230324133150.43224-3-rogerq@kernel.org>
 <20230324181542.luvmpvjx2uclic52@reemerge>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230324181542.luvmpvjx2uclic52@reemerge>
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



On 24/03/2023 20:15, Nishanth Menon wrote:
> On 15:31-20230324, Roger Quadros wrote:
>> USB0 is a Type-C port with dual data role and power sink.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 40 ++++++++++++++++++++++++--
>>  1 file changed, 38 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> index be027fad5f61..c80b12943881 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> @@ -315,6 +315,33 @@ &main_i2c0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&main_i2c0_pins_default>;
>>  	clock-frequency = <400000>;
>> +
>> +	tps6598x@3f {
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
>>  };
>>  
>>  &main_i2c1 {
>> @@ -336,7 +363,7 @@ exp1: gpio@22 {
>>  				   "UART1_FET_BUF_EN", "WL_LT_EN",
>>  				   "GPIO_HDMI_RSTn", "CSI_GPIO1",
>>  				   "CSI_GPIO2", "PRU_3V3_EN",
>> -				   "HDMI_INTn", "TEST_GPIO2",
>> +				   "HDMI_INTn", "PD_I2C_IRQ",
>>  				   "MCASP1_FET_EN", "MCASP1_BUF_BT_EN",
>>  				   "MCASP1_FET_SEL", "UART1_FET_SEL",
>>  				   "TSINT#", "IO_EXP_TEST_LED";
>> @@ -486,7 +513,16 @@ &usbss1 {
>>  };
>>  
>>  &usb0 {
>> -	dr_mode = "peripheral";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	usb-role-switch;
>> +
>> +	port@0 {
>> +		reg = <0>;
>> +		usb0_hs_ep: endpoint {
>> +			remote-endpoint = <&usb_con_hs>;
>> +		};
>> +	};
>>  };
>>  
>>  &usb1 {
>> -- 
>> 2.34.1
>>
> 
> Please see thread: 
> https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/
> you might need to rebase off that.
> 

OK.

cheers,
-roger
