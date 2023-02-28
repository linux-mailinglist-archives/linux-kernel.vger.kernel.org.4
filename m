Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B99F6A50C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjB1Bki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:40:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjB1Bkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:40:37 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1B01E1FE;
        Mon, 27 Feb 2023 17:40:35 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 169A824E392;
        Tue, 28 Feb 2023 09:40:34 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 09:40:33 +0800
Received: from [192.168.125.128] (113.72.145.171) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 28 Feb
 2023 09:40:32 +0800
Message-ID: <f943857c-f3ee-c521-ca84-51942e463d05@starfivetech.com>
Date:   Tue, 28 Feb 2023 09:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 10/11] riscv: dts: starfive: jh7110: Add DVP and HDMI
 TX pixel external clocks
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230221083323.302471-1-xingyu.wu@starfivetech.com>
 <20230221083323.302471-11-xingyu.wu@starfivetech.com> <Y/0KyeK3DU8xtL2V@spud>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <Y/0KyeK3DU8xtL2V@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.171]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/28 3:55, Conor Dooley wrote:
> On Tue, Feb 21, 2023 at 04:33:22PM +0800, Xingyu Wu wrote:
>> Add DVP and HDMI TX pixel external fixed clocks and the rates are
>> 74.25MHz and 297MHz.
>> 
>> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> ---
>>  .../dts/starfive/jh7110-starfive-visionfive-2.dtsi   |  8 ++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi             | 12 ++++++++++++
>>  2 files changed, 20 insertions(+)
>> 
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> index c2aa8946a0f1..27af817a55aa 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -86,6 +86,14 @@ &mclk_ext {
>>  	clock-frequency = <12288000>;
>>  };
>>  
>> +&dvp_clk {
>> +	clock-frequency = <74250000>;
>> +};
>> +
>> +&hdmitx0_pixelclk {
>> +	clock-frequency = <297000000>;
>> +};
>> +
>>  &uart0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&uart0_pins>;
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index 005ead2624d4..a5e6fb3ad188 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -245,6 +245,18 @@ mclk_ext: mclk-ext-clock {
>>  		#clock-cells = <0>;
>>  	};
>>  
>> +	dvp_clk: dvp-clk-clock {
>> +		compatible = "fixed-clock";
>> +		clock-output-names = "dvp_clk";
>> +		#clock-cells = <0>;
>> +	};
>> +
>> +	hdmitx0_pixelclk: hdmitx0-pixelclk-clock {
>> +		compatible = "fixed-clock";
>> +		clock-output-names = "hdmitx0_pixelclk";
>> +		#clock-cells = <0>;
>> +	};
>> +
> 
> Hmm, would you mind adding these entries with no unit addresses in
> alphanumerical order? Both in the soc & board dtsi files.
> 

Oh, It was my negligence. I will adjust it. Thanks.

Best regards,
Xingyu Wu

