Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380174566F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjGCHwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGCHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:52:22 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF573A6;
        Mon,  3 Jul 2023 00:52:19 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 46C3B24E268;
        Mon,  3 Jul 2023 15:52:17 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Jul
 2023 15:52:17 +0800
Received: from [192.168.155.85] (202.188.176.82) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 3 Jul
 2023 15:52:12 +0800
Message-ID: <017dd7a1-302b-b4be-6b3d-3da0021a9b32@starfivetech.com>
Date:   Mon, 3 Jul 2023 15:52:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 3/3] riscv: dts: starfive: Add TRNG node for VisionFive
 2
Content-Language: en-US
To:     Aurelien Jarno <aurelien@aurel32.net>,
        Palmer Dabbelt <palmer@rivosinc.com>, <olivia@selenic.com>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20230117015445.32500-4-jiajie.ho@starfivetech.com>
 <mhng-348475f1-5880-4951-9692-78210a17acd3@palmer-ri-x1c9a>
 <ZKCgXvcbWBGWZnsU@aurel32.net>
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZKCgXvcbWBGWZnsU@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/2023 5:53 am, Aurelien Jarno wrote:
> On 2023-03-14 18:45, Palmer Dabbelt wrote:
>> On Mon, 16 Jan 2023 17:54:45 PST (-0800), jiajie.ho@starfivetech.com wrote:
>> > Adding StarFive TRNG controller node to VisionFive 2 SoC.
>> > 
>> > Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
>> > Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
>> > Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
>> > ---
>> >  arch/riscv/boot/dts/starfive/jh7110.dtsi | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> > 
>> > diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> > index 4ac159d79d66..3c29e0bc6246 100644
>> > --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> > +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
>> > @@ -455,5 +455,15 @@ uart5: serial@12020000 {
>> >  			reg-shift = <2>;
>> >  			status = "disabled";
>> >  		};
>> > +
>> > +		rng: rng@1600c000 {
>> > +			compatible = "starfive,jh7110-trng";
>> > +			reg = <0x0 0x1600C000 0x0 0x4000>;
>> > +			clocks = <&stgcrg JH7110_STGCLK_SEC_HCLK>,
>> > +				 <&stgcrg JH7110_STGCLK_SEC_MISCAHB>;
>> > +			clock-names = "hclk", "ahb";
>> > +			resets = <&stgcrg JH7110_STGRST_SEC_TOP_HRESETN>;
>> > +			interrupts = <30>;
>> > +		};
>> >  	};
>> >  };
>> 
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> It appears that this patch has never been applied, although the rest of
> the series has already been merged. Unfortunately it doesn't apply
> anymore due to other changes to that file.
> 
> Could you please rebase and resend it?
> 

Hi Aurelien,

This patch is dependent on
https://patchwork.kernel.org/project/linux-riscv/patch/20230518101234.143748-2-xingyu.wu@starfivetech.com/

I'll send a new patch for this dts node after all dependencies have been merged.

Thanks,
Jia Jie
