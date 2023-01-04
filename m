Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD365CCC5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 07:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbjADGIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 01:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjADGIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 01:08:38 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BBA12777;
        Tue,  3 Jan 2023 22:08:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E235724E1F3;
        Wed,  4 Jan 2023 14:08:32 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 4 Jan
 2023 14:08:32 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 4 Jan
 2023 14:08:32 +0800
Message-ID: <14433b44-8359-b9e8-446c-bb49e86bf48f@starfivetech.com>
Date:   Wed, 4 Jan 2023 14:08:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-4-william.qiu@starfivetech.com>
 <CAPDyKFqziA+PB__v8nJzgkTuM9ZszW8X2U-akvRFv0_qwZ22OA@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAPDyKFqziA+PB__v8nJzgkTuM9ZszW8X2U-akvRFv0_qwZ22OA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS063.cuchost.com (172.16.6.23) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/2 22:03, Ulf Hansson wrote:
> On Tue, 27 Dec 2022 at 13:22, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> This adds the mmc node for the StarFive JH7110 SoC.
>> Set sdioo node to emmc and set sdio1 node to sd.
>>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> index c8946cf3a268..d8244fd1f5a0 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
>> @@ -47,6 +47,31 @@ &clk_rtc {
>>         clock-frequency = <32768>;
>>  };
>>
>> +&mmc0 {
>> +       max-frequency = <100000000>;
>> +       card-detect-delay = <300>;
> 
> Nitpick:  This seems redundant for a non-removable card!?
> 

Will drop

>> +       bus-width = <8>;
>> +       cap-mmc-highspeed;
>> +       mmc-ddr-1_8v;
>> +       mmc-hs200-1_8v;
>> +       non-removable;
>> +       cap-mmc-hw-reset;
>> +       post-power-on-delay-ms = <200>;
>> +       status = "okay";
>> +};
>> +
>> +&mmc1 {
>> +       max-frequency = <100000000>;
>> +       card-detect-delay = <300>;
> 
> Nitpick: This looks redundant for polling based card detection
> (broken-cd is set a few lines below).
> 

Will drop

>> +       bus-width = <4>;
>> +       no-sdio;
>> +       no-mmc;
>> +       broken-cd;
>> +       cap-sd-highspeed;
>> +       post-power-on-delay-ms = <200>;
>> +       status = "okay";
>> +};
>> +
>>  &gmac0_rmii_refin {
>>         clock-frequency = <50000000>;
>>  };
>> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> index c22e8f1d2640..08a780d2c0f4 100644
>> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
>>                         #reset-cells = <1>;
>>                 };
>>
>> +               syscon: syscon@13030000 {
>> +                       compatible = "starfive,syscon", "syscon";
>> +                       reg = <0x0 0x13030000 0x0 0x1000>;
>> +               };
>> +
>>                 gpio: gpio@13040000 {
>>                         compatible = "starfive,jh7110-sys-pinctrl";
>>                         reg = <0x0 0x13040000 0x0 0x10000>;
>> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
>>                         reg-shift = <2>;
>>                         status = "disabled";
>>                 };
>> +
>> +               /* unremovable emmc as mmcblk0 */
> 
> Don't confuse the mmc0 node name with mmcblk0. There is no guarantee
> that this is true, unless you also specify an alias.
> 

Hi Ulf,

Thank you for taking time to review and provide helpful comments for this patch.
Actually we define mmc0 as eMMC, which is mmcblk0 in the kernel, and define mmc1 as SDIO,
which is mmcblk1 in the kernel, so it's not confuse.

Best Regards
William Qiu
>> +               mmc0: mmc@16010000 {
>> +                       compatible = "starfive,jh7110-mmc";
>> +                       reg = <0x0 0x16010000 0x0 0x10000>;
>> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO0_AHB>,
>> +                                <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
>> +                       clock-names = "biu","ciu";
>> +                       resets = <&syscrg JH7110_SYSRST_SDIO0_AHB>;
>> +                       reset-names = "reset";
>> +                       interrupts = <74>;
>> +                       fifo-depth = <32>;
>> +                       fifo-watermark-aligned;
>> +                       data-addr = <0>;
>> +                       starfive,syscon = <&syscon 0x14 0x1a 0x7c000000>;
>> +                       status = "disabled";
>> +               };
>> +
>> +               mmc1: mmc@16020000 {
>> +                       compatible = "starfive,jh7110-mmc";
>> +                       reg = <0x0 0x16020000 0x0 0x10000>;
>> +                       clocks = <&syscrg JH7110_SYSCLK_SDIO1_AHB>,
>> +                                <&syscrg JH7110_SYSCLK_SDIO1_SDCARD>;
>> +                       clock-names = "biu","ciu";
>> +                       resets = <&syscrg JH7110_SYSRST_SDIO1_AHB>;
>> +                       reset-names = "reset";
>> +                       interrupts = <75>;
>> +                       fifo-depth = <32>;
>> +                       fifo-watermark-aligned;
>> +                       data-addr = <0>;
>> +                       starfive,syscon = <&syscon 0x9c 0x1 0x3e>;
>> +                       status = "disabled";
>> +               };
>>         };
>>  };
> 
> Kind regards
> Uffe
