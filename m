Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B665A6973F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjBOB4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBOB4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:56:49 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7B17DB9;
        Tue, 14 Feb 2023 17:56:47 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CE48E24E249;
        Wed, 15 Feb 2023 09:56:45 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:56:45 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Feb
 2023 09:56:45 +0800
Message-ID: <c8e1e030-59a5-107b-d1a3-0ad7e289a419@starfivetech.com>
Date:   Wed, 15 Feb 2023 09:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
 <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
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



On 2023/2/14 20:18, Ulf Hansson wrote:
> On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>> Hi,
>>
>> This patchset adds initial rudimentary support for the StarFive
>> designware mobile storage host controller driver. And this driver will
>> be used in StarFive's VisionFive 2 board. The main purpose of adding
>> this driver is to accommodate the ultra-high speed mode of eMMC.
>>
>> The last patch should be applied after the patchset [1]:
>> [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
>>
>> Changes since v2:
>> - Wraped commit message according to Linux coding style.
>> - Rephrased the description of the patches.
>> - Changed the description of syscon regsiter.
>> - Dropped redundant properties.
>>
>> The patch series is based on v6.1.
>>
>> William Qiu (3):
>>   dt-bindings: mmc: Add StarFive MMC module
>>   mmc: starfive: Add sdio/emmc driver support
>>   riscv: dts: starfive: Add mmc node
>>
>>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
>>  MAINTAINERS                                   |   6 +
>>  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
>>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
>>  drivers/mmc/host/Kconfig                      |  10 +
>>  drivers/mmc/host/Makefile                     |   1 +
>>  drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
>>  7 files changed, 339 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>>
> 
> Patch 1 and patch 2 applied for next, thanks!
> 
> Note that I fixed some checkpatch errors/warnings. Next time, please
> run ./scripts/checkpatch.pl before you submit your patches.
> 
> Kind regards
> Uffe
z
Hi Uffe,

Sorry about that, I'll check the patches before submit next time.
Thanks for taking time reviewing this patch series.

Best Regards
William
