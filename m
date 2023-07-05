Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD3747DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGEHGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjGEHGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:06:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7471729;
        Wed,  5 Jul 2023 00:06:02 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E258024DD82;
        Wed,  5 Jul 2023 15:06:00 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 15:06:00 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 5 Jul
 2023 15:05:59 +0800
Message-ID: <a4e8929d-f2a6-3429-fc12-78a29e2c8d3a@starfivetech.com>
Date:   Wed, 5 Jul 2023 15:05:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] riscv: dts: starfive: Add QSPI controller node for
 StarFive JH7110 SoC
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230704090453.83980-1-william.qiu@starfivetech.com>
 <20230704090453.83980-4-william.qiu@starfivetech.com>
 <552d39ee-0fa0-94c0-89b9-245e39e8586d@linaro.org>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <552d39ee-0fa0-94c0-89b9-245e39e8586d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
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



On 2023/7/4 17:43, Krzysztof Kozlowski wrote:
> On 04/07/2023 11:04, William Qiu wrote:
>> Add the quad spi controller node for the StarFive JH7110 SoC.
>> 
>> Co-developed-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: Ziv Xu <ziv.xu@starfivetech.com>
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> 
> ...
> 
>> +		qspi: spi@13010000 {
>> +			compatible = "starfive,jh7110-qspi", "cdns,qspi-nor";
>> +			reg = <0x0 0x13010000 0x0 0x10000>,
>> +			      <0x0 0x21000000 0x0 0x400000>;
>> +			interrupts = <25>;
>> +			clocks = <&syscrg JH7110_SYSCLK_QSPI_REF>,
>> +				 <&syscrg JH7110_SYSCLK_QSPI_AHB>,
>> +				 <&syscrg JH7110_SYSCLK_QSPI_APB>;
>> +			clock-names = "ref", "ahb", "apb";
>> +			resets = <&syscrg JH7110_SYSRST_QSPI_APB>,
>> +				 <&syscrg JH7110_SYSRST_QSPI_AHB>,
>> +				 <&syscrg JH7110_SYSRST_QSPI_REF>;
>> +			reset-names = "qspi", "qspi-ocp", "rstc_ref";
>> +			cdns,fifo-depth = <256>;
>> +			cdns,fifo-width = <4>;
>> +			cdns,trigger-address = <0x0>;
> 
> Bus nodes are usually disabled by default and enabled when needed for
> specific boards.
> 
Will add status.
Thanks for your comments.

Best regards,
William
> Best regards,
> Krzysztof
> 
