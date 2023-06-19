Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37561734C5C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjFSH2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjFSH2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:28:06 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C1121;
        Mon, 19 Jun 2023 00:27:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 0400624E28B;
        Mon, 19 Jun 2023 15:27:46 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 15:27:45 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 19 Jun
 2023 15:27:45 +0800
Message-ID: <8dba5075-3e30-3edd-e66b-199cffefe708@starfivetech.com>
Date:   Mon, 19 Jun 2023 15:27:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] dt-bindings: qspi: cdns,qspi-nor: Add clocks for
 StarFive JH7110 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ziv Xu <ziv.xu@starfivetech.com>
References: <20230602084925.215411-1-william.qiu@starfivetech.com>
 <20230602084925.215411-2-william.qiu@starfivetech.com>
 <e148c599-8521-3264-f994-529ffc18f836@linaro.org>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <e148c599-8521-3264-f994-529ffc18f836@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
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



On 2023/6/6 20:43, Krzysztof Kozlowski wrote:
> On 02/06/2023 10:49, William Qiu wrote:
>> The QSPI controller needs three clock items to work properly on StarFive
>> JH7110 SoC, so there is need to change the maxItems's value to 3. Other
>> platforms do not have this constraint.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> 
> 
> 
>>  
>> @@ -69,9 +81,6 @@ properties:
>>    interrupts:
>>      maxItems: 1
>>  
>> -  clocks:
>> -    maxItems: 1
> 
> Properties should be defined in top-level properties. Don't remove them
> from here.
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

Sorry for the late reply. I'll fix it in next version.

Best regards,
William
