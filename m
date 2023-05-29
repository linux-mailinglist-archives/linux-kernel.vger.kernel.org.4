Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D271450F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjE2GoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 02:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjE2GoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 02:44:20 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C316C90;
        Sun, 28 May 2023 23:44:17 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E8A4780ED;
        Mon, 29 May 2023 14:44:14 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 14:44:14 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 29 May
 2023 14:44:14 +0800
Message-ID: <a09cc0c9-ef4e-120f-e61a-94f628d67e38@starfivetech.com>
Date:   Mon, 29 May 2023 14:44:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
To:     Mark Brown <broonie@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Emil Renner Berthing" <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230526062529.46747-1-william.qiu@starfivetech.com>
 <20230526062529.46747-2-william.qiu@starfivetech.com>
 <87e9ed95-ea57-44c8-85f8-34264b5c6dde@sirena.org.uk>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <87e9ed95-ea57-44c8-85f8-34264b5c6dde@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/26 23:33, Mark Brown wrote:
> On Fri, May 26, 2023 at 02:25:27PM +0800, William Qiu wrote:
> 
>>      then:
>>        properties:
>> +        clocks:
>> +          maxItems: 3
>> +
>> +        clock-names:
>> +          items:
>> +            - const: qspi-ref
>> +            - const: qspi-ahb
>> +            - const: qspi-apb
>> +
> 
> Are these really the names that the clocks have in the IP?  It seems
> weird that they'd include the IP name in there and not just be ref, ahb
> and apb.
Hi Mark,

	These three clocks are the internal clocks in the IP. The AHB
clock is the main system clock used to transfer data over the AHB bus
between an external master and the QSPI controller. The APB clock is used
to access the register map of the QSPI controller, perform controller and
device configuration.service interrupts and control certain run time modes.
The reference clock is used to serialize the data and drive the external
SPI interface.

	I'm going to change the names of these three clocks to hclk, pclk,
and ref_clk, as defined in the data book. What do you think?

	Thanks for taking time to review this patch series and give useful
suggestions.

Best regards,
William
