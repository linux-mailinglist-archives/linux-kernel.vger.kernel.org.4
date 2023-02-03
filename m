Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30586890E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBCHdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBCHdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:33:33 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAC992C3D;
        Thu,  2 Feb 2023 23:33:28 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C0B0E24E1E4;
        Fri,  3 Feb 2023 15:33:26 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 15:33:26 +0800
Received: from [192.168.125.110] (113.72.144.84) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 15:33:25 +0800
Message-ID: <90091c73-70ee-8fb6-50c6-9631aedc8425@starfivetech.com>
Date:   Fri, 3 Feb 2023 15:33:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 0/5] Basic pinctrl support for StarFive JH7110 RISC-V
 SoC
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
 <CACRpkdbU=Y_LVBfSctQULzFuo4tB9KxgFbv=JGHPuuok6jC8FQ@mail.gmail.com>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <CACRpkdbU=Y_LVBfSctQULzFuo4tB9KxgFbv=JGHPuuok6jC8FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.144.84]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 14:13:44 +0100, Linus Walleij wrote:
> On Tue, Dec 20, 2022 at 1:55 AM Hal Feng <hal.feng@starfivetech.com> wrote:
> 
>> This patch series adds basic pinctrl support for StarFive JH7110 SoC.
>> You can simply get or review the patches at the link [1].
>>
>> [1]: https://github.com/hal-feng/linux/commits/visionfive2-minimal
>>
>> Changes since v2:
>> - Rebased on tag v6.1.
> 
> Overall this looks OK, the DT bindings does not have any review from
> the DT people but I think they had enough time to do that and were
> properly CC:ed so not your fault.
> 
> However when I try to apply this to the pinctrl tree it fails,
> for example it seems to depend on an entry in MAINTAINERS
> which isn't upstream.
> 
> Can you please rebase the patches that are supposed to be
> applied to the pinctrl tree (for example normally not patch 1, the DTS
> patch) on my "devel" branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=devel

I will drop the patch 1 and rebase the patches on your "devel" branch.
I will resend patch 1 after the device tree patches about StarFive JH7110 [1]
are merged.

[1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/

Thank you for spending time to review this series.

Best regards,
Hal

> 
> If you resend this quickly I can apply it pronto.

