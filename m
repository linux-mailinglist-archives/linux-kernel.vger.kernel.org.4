Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CFB6D8D63
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 04:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbjDFCU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 22:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFCU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 22:20:57 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5784B6E88;
        Wed,  5 Apr 2023 19:20:55 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C69C124E25E;
        Thu,  6 Apr 2023 10:20:53 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 10:20:53 +0800
Received: from [192.168.120.57] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 6 Apr
 2023 10:20:53 +0800
Message-ID: <42bdb4e2-bb18-5e4d-f6fb-68564c89efee@starfivetech.com>
Date:   Thu, 6 Apr 2023 10:20:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
To:     Conor Dooley <conor@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
 <850bc37e-c6d1-2381-a851-965a4cbee8a0@linaro.org>
 <e38efd81-9c79-553b-7556-7aff30f6ec50@starfivetech.com>
 <f25cc55e-3405-4b17-fb45-5ae5eb36a404@linaro.org>
 <d0b1d44e-6d6e-536c-046e-be6a53f1d240@starfivetech.com>
 <20230405-bullseye-handsaw-5c2e4dab772f@spud>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <20230405-bullseye-handsaw-5c2e4dab772f@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.4 required=5.0 tests=NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/6 0:38, Conor Dooley wrote:
> On Mon, Mar 20, 2023 at 03:32:14PM +0800, William Qiu wrote:
> 
>> >>> Does not look like you tested the bindings. Please run `make
>> >>> dt_binding_check` (see
>> >>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>> >>>
>> >>> ... or your PLL clock controller was not tested.
>> >>>
>> >>> Best regards,
>> >>> Krzysztof
>> >>>
>> >> Hi Krzysztof,
>> >> 
>> >> I've already done`make dt_binding_check`, and get no error. So maybe PLL clock controller
>> >> was not tested which I didn't add in this patch series. And PLL clock controller belongs
>> >> to Xingyu Wu, I would tell him.
>> > 
>> > What's confusing you do not allow here clock controller.
> 
>> I'll add it then.
> 
> What's the plan here William?
> Can you sort something out with Xingyu Wu so that the dt-binding is
> added in a complete manner?
> In the meantime, gonna drop this series as "Changes Requested" from
> patchwork.
> 
> Cheers,
> Conor.

Hi Conor,

After discussing with Xingyu, I will sort all of it and send a complete
dt-binding today.

Best regards,
William
