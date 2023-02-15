Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0E16979A0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjBOKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBOKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:16:42 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CE12364E;
        Wed, 15 Feb 2023 02:16:38 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C927724DFED;
        Wed, 15 Feb 2023 18:16:36 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 18:16:37 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 18:16:36 +0800
Message-ID: <3ee9b726-10db-5d05-b24a-010c8bf5b59d@starfivetech.com>
Date:   Wed, 15 Feb 2023 18:16:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
 <CAJM55Z8gpBDu9818GPLRYJ9DBa+NfXW0uo76_bkwWm6RS1S9wg@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAJM55Z8gpBDu9818GPLRYJ9DBa+NfXW0uo76_bkwWm6RS1S9wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/15 18:00, Emil Renner Berthing wrote:
> On Tue, 14 Feb 2023 at 13:21, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com> wrote:
>> >
>> > Hi,
>> >
>> > This patchset adds initial rudimentary support for the StarFive
>> > designware mobile storage host controller driver. And this driver will
>> > be used in StarFive's VisionFive 2 board. The main purpose of adding
>> > this driver is to accommodate the ultra-high speed mode of eMMC.
>> >
>> > The last patch should be applied after the patchset [1]:
>> > [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
>> >
>> > Changes since v2:
>> > - Wraped commit message according to Linux coding style.
>> > - Rephrased the description of the patches.
>> > - Changed the description of syscon regsiter.
>> > - Dropped redundant properties.
>> >
>> > The patch series is based on v6.1.
>> >
>> > William Qiu (3):
>> >   dt-bindings: mmc: Add StarFive MMC module
>> >   mmc: starfive: Add sdio/emmc driver support
>> >   riscv: dts: starfive: Add mmc node
>> >
>> >  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
>> >  MAINTAINERS                                   |   6 +
>> >  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
>> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
>> >  drivers/mmc/host/Kconfig                      |  10 +
>> >  drivers/mmc/host/Makefile                     |   1 +
>> >  drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
>> >  7 files changed, 339 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>> >
>>
>> Patch 1 and patch 2 applied for next, thanks!
>>
>> Note that I fixed some checkpatch errors/warnings. Next time, please
>> run ./scripts/checkpatch.pl before you submit your patches.
> 
> Hi,
> 
> Something here is not right. The bindings document "starfive,sysreg",
> but the code is looking for "starfive,syscon".
> William, did you test this and run dtbs_check before sending this series?
> 
> /Emil

Hi Emil,

Sorry about that, it's my negligence that I did dtbs_check without 
checking the configuration of CONFIG_SOC_STARFIVE. I made a modification 
in the next version and add binding for all the syscon at the same time. Next
time I'll make sure the check is correct.I'm sorry again for this oversight.
I'll send v4 patch series today.

Best Regards
William
> 
>> Kind regards
>> Uffe
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
