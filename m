Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9BF68C375
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjBFQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjBFQfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:35:51 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0425F24C81;
        Mon,  6 Feb 2023 08:35:50 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 9B8E324E01A;
        Tue,  7 Feb 2023 00:35:48 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 00:35:48 +0800
Received: from [172.16.16.234] (113.72.145.145) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 7 Feb
 2023 00:35:47 +0800
Message-ID: <a365f918-5a99-c9ed-d925-895de5969358@starfivetech.com>
Date:   Tue, 7 Feb 2023 00:35:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/4] dt-bindings: pinctrl: Add StarFive JH7110 aon
 pinctrl
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>, <linux-gpio@vger.kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Andreas Schwab <schwab@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-riscv@lists.infradead.org>,
        "Linus Walleij" <linus.walleij@linaro.org>
References: <20230203141801.59083-1-hal.feng@starfivetech.com>
 <20230203141801.59083-3-hal.feng@starfivetech.com>
 <167569988090.161822.12197118549919509895.robh@kernel.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <167569988090.161822.12197118549919509895.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.145]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 10:11:39 -0600, Rob Herring wrote:
> On Fri, 03 Feb 2023 22:17:59 +0800, Hal Feng wrote:
>> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>> 
>> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
>> 
>> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
>> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 123 ++++++++++++++++++
>>  .../pinctrl/starfive,jh7110-pinctrl.h         |  22 ++++
>>  2 files changed, 145 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
>> 
> 
> With the issue noted fixed:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Will fix accordingly. Thank you again for spending time to review.

Best regards,
Hal
