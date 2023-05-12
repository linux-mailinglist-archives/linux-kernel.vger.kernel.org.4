Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EC3700473
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240635AbjELJ6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbjELJ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:58:19 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E01911B6D;
        Fri, 12 May 2023 02:58:01 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CFD3E24E16F;
        Fri, 12 May 2023 17:56:41 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 17:57:53 +0800
Received: from [192.168.125.131] (113.72.146.187) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 12 May
 2023 17:57:52 +0800
Message-ID: <be85aa2a-c72c-5272-ee40-f1265768e7b3@starfivetech.com>
Date:   Fri, 12 May 2023 17:56:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/7] dt-bindings: clock: jh7110-syscrg: Add PLL clock
 inputs
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230512022036.97987-1-xingyu.wu@starfivetech.com>
 <20230512022036.97987-4-xingyu.wu@starfivetech.com>
 <20230512-uproar-external-49a9e793fbc4@wendy>
 <91e4fd3c-20cb-724b-c9a8-e038600aabb7@starfivetech.com>
 <20230512-backlit-radiated-ded0b38b4a94@wendy>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <20230512-backlit-radiated-ded0b38b4a94@wendy>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.187]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/12 17:35, Conor Dooley wrote:
> On Fri, May 12, 2023 at 04:07:47PM +0800, Xingyu Wu wrote:
>> On 2023/5/12 14:47, Conor Dooley wrote:
>> > On Fri, May 12, 2023 at 10:20:32AM +0800, Xingyu Wu wrote:
>> >> Add PLL clock inputs from PLL clock generator.
>> >> 
>> >> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> >> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
>> >> ---
>> >>  .../clock/starfive,jh7110-syscrg.yaml         | 20 +++++++++++++++++--
>> >>  1 file changed, 18 insertions(+), 2 deletions(-)
>> > 
>> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: clock-controller@13020000: clocks: 'oneOf' conditional failed, one must be fixed:
>> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
>> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dtb: clock-controller@13020000: clock-names: 'oneOf' conditional failed, one must be fixed:
>> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', 'i2stx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext'] is too short
>> > 	'i2stx_bclk_ext' was expected
>> > 	'i2stx_lrck_ext' was expected
>> > 	'i2srx_bclk_ext' was expected
>> > 	'i2srx_lrck_ext' was expected
>> > 	'tdm_ext' was expected
>> > 	'mclk_ext' was expected
>> > 	'pll0_out' was expected
>> > 	From schema: /Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: clock-controller@13020000: clocks: 'oneOf' conditional failed, one must be fixed:
>> > 	[[19], [20], [21], [22], [23], [24], [25], [26], [27]] is too short
>> > 	From schema: Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> > /tmp/tmp.KDlzwQM5ma/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.2a.dtb: clock-controller@13020000: clock-names: 'oneOf' conditional failed, one must be fixed:
>> > 	['osc', 'gmac1_rmii_refin', 'gmac1_rgmii_rxin', 'i2stx_bclk_ext', 'i2stx_lrck_ext', 'i2srx_bclk_ext', 'i2srx_lrck_ext', 'tdm_ext', 'mclk_ext'] is too short
>> > 	'i2stx_bclk_ext' was expected
>> > 	'i2stx_lrck_ext' was expected
>> > 	'i2srx_bclk_ext' was expected
>> > 	'i2srx_lrck_ext' was expected
>> > 	'tdm_ext' was expected
>> > 	'mclk_ext' was expected
>> > 	'pll0_out' was expected
>> > 	Documentation/devicetree/bindings/clock/starfive,jh7110-syscrg.yaml
>> > 
>> > This binding change is incompatible with the existing devicetrees for
>> > the visionfive 2.
>> 
>> This looks like less clocks about PLL in SYSCRG node. And I add this in patch 7.
> 
> The existing devicetree is a valid, albeit limited, description of the
> hardware.
> After your changes to the clock driver in this series, but *without* the
> changes to the devicetrees, does the system still function?
> From a quick check of 4/7, it looks like it will not?

I just tested it on the board and the system still worked without the changes
about devicetree. But these clocks' rate were 0 because these could not get
the PLL clocks from devicetree.

Best regards,
Xingyu Wu
