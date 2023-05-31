Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A377173AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjEaCZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjEaCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:25:10 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E97511C;
        Tue, 30 May 2023 19:25:00 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 2B8457FE2;
        Wed, 31 May 2023 10:24:53 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 10:24:53 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 31 May
 2023 10:24:52 +0800
Message-ID: <d9b4a420-14f9-4678-804c-9edbd848c01d@starfivetech.com>
Date:   Wed, 31 May 2023 10:24:51 +0800
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
 <a09cc0c9-ef4e-120f-e61a-94f628d67e38@starfivetech.com>
 <d417628d-7994-4b07-a670-ec14ad938764@sirena.org.uk>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <d417628d-7994-4b07-a670-ec14ad938764@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
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



On 2023/5/30 18:02, Mark Brown wrote:
> On Mon, May 29, 2023 at 02:44:13PM +0800, William Qiu wrote:
>> On 2023/5/26 23:33, Mark Brown wrote:
>> > On Fri, May 26, 2023 at 02:25:27PM +0800, William Qiu wrote:
> 
>> >> +        clock-names:
>> >> +          items:
>> >> +            - const: qspi-ref
>> >> +            - const: qspi-ahb
>> >> +            - const: qspi-apb
> 
>> 	I'm going to change the names of these three clocks to hclk, pclk,
>> and ref_clk, as defined in the data book. What do you think?
> 
> That looks fine.  ref, ahb and apb would also be fine, it's just the
> qspi- prefix that I was querying.

That's fine. I will fix it in next version.

Best regards,
William
