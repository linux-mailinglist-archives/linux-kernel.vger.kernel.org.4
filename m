Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561E56E6070
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjDRLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDRLxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:53:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BEE78;
        Tue, 18 Apr 2023 04:53:29 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EAE96602338;
        Tue, 18 Apr 2023 12:53:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681818807;
        bh=F5bJnkMDohUh9rvK2TZXfUylvPcAO2pWW9e3hN5M+kk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YUXB4mlxVMv26uwQoJfBYvXdX77LTIslHy9CnC5wqb8CG8myJhTIkm6RVp5YmcgxL
         ge0idkj7yJrWuACks2Xkogd89V1gPN6lT4cu4zf9RQYEeKmxXy7UdsSb+OSaOIXseu
         D7mPLcyA9SATfml8FhdqfFc0nOO2u255937/Nucn1hcn6vu1sH/zO5x3M8UUaSRNVW
         B/K2EIy1nKFL1y2dU6/0x5/MqO/3n/ZH7gh8YOS6DvmX6OSeCHvv2q68j+xygd7xBG
         M1lr1afoplg/nviV3FCBg5ijeVfbjq2QntsfyHEDDs1c+xFU58+JMCc5V+aDCPRpyG
         BVLwQ58BhymwQ==
Message-ID: <e2e59d5d-89cb-ba82-f0fc-ecddb9bdfc2a@collabora.com>
Date:   Tue, 18 Apr 2023 14:53:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: Add rk3588 timer
Content-Language: en-US
To:     Johan Jonker <jbx6244@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20230418095344.274025-1-cristian.ciocaltea@collabora.com>
 <20230418095344.274025-4-cristian.ciocaltea@collabora.com>
 <a8a9e82b-996e-2b0d-4e3b-9ceda0ab81e4@gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <a8a9e82b-996e-2b0d-4e3b-9ceda0ab81e4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/23 14:29, Johan Jonker wrote:
> 
> 
> On 4/18/23 11:53, Cristian Ciocaltea wrote:
>> Add DT node for Rockchip RK3588/RK3588S SoC timer.
>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> index 657c019d27fa..acd89a55374a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s.dtsi
>> @@ -1400,6 +1400,14 @@ i2c5: i2c@fead0000 {
>>  		status = "disabled";
>>  	};
>>  
> 
>> +	rktimer: timer@feae0000 {
> 
> There are multiple timers.
> Use a label in line with the TRM.
> Maybe change your label to "timer0" in that trend?

Sure, will use "timer0".

>> +		compatible = "rockchip,rk3588-timer", "rockchip,rk3288-timer";
>> +		reg = <0x0 0xfeae0000 0x0 0x20>;
> 
>> +		clocks = <&cru PCLK_BUSTIMER0>, <&cru CLK_BUSTIMER0>;
>> +		clock-names = "pclk", "timer";
>> +		interrupts = <GIC_SPI 289 IRQ_TYPE_LEVEL_HIGH 0>;
> 
> Heiko's sort rules:
> 
> compatible
> reg
> interrupts
> [alphabetical]
> status [if needed]

Thanks for pointing this out! The sort rule was not obvious as there are
many other nodes that don't conform.
