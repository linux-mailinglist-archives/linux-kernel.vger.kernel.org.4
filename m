Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C5C64E896
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 10:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLPJ1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 04:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 04:27:03 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EC83F058;
        Fri, 16 Dec 2022 01:27:01 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 55FBE24E1AC;
        Fri, 16 Dec 2022 17:26:58 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Dec
 2022 17:26:58 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 16 Dec
 2022 17:26:57 +0800
Message-ID: <e704e829-e67c-5458-0808-bc652c1e5620@starfivetech.com>
Date:   Fri, 16 Dec 2022 17:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1 0/3] StarFive's SDIO/eMMC driver support
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        <linux-kernel@vger.kernel.org>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
 <420d067c-665b-b247-b0cd-8ac242c19924@starfivetech.com>
 <CAPDyKFoosrm9CSi4s=YSxdg4xqv118wOFUAc5QRcOgtMCiX=DA@mail.gmail.com>
Content-Language: en-US
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <CAPDyKFoosrm9CSi4s=YSxdg4xqv118wOFUAc5QRcOgtMCiX=DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/16 17:22, Ulf Hansson wrote:
> On Fri, 16 Dec 2022 at 03:02, William Qiu <william.qiu@starfivetech.com> wrote:
>>
>>
>>
>> On 2022/12/7 21:17, William Qiu wrote:
>> > Hi,
>> >
>> > This patchset adds initial rudimentary support for the StarFive
>> > designware mobile storage host controller driver. And this driver will
>> > be used in StarFive's visionfive-v2 board. The main purpose of adding
>> > this driver is to accommodate the ultra-high speed mode of eMMC.
>> >
>> > The patch series is based on v6.1-rc5.
>> >
>> > -- William
>> >
>> > William Qiu (3):
>> >   dt-bindings: mmc: Add bindings for StarFive
>> >   mmc: starfive: Add sdio/emmc driver support
>> >   riscv: dts: starfive: Add mmc node
>> >
>> >  .../bindings/mmc/starfive,jh7110-sdio.yaml    |  71 +++++++
>> >  MAINTAINERS                                   |   6 +
>> >  .../jh7110-starfive-visionfive-v2.dts         |  25 +++
>> >  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  38 ++++
>> >  drivers/mmc/host/Kconfig                      |  10 +
>> >  drivers/mmc/host/Makefile                     |   1 +
>> >  drivers/mmc/host/dw_mmc-starfive.c            | 197 ++++++++++++++++++
>> >  7 files changed, 348 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-sdio.yaml
>> >  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>> >
>> > --
>> > 2.34.1
>> >
>>
>> Hi Jaehoon/Ulf,
>>
>> Could you please help to review and provide comments on this patch series?
>> Thank you in advance.
> 
> Hi William,
> 
> Looks like you have received plenty of good comments already and there
> are a lot of things for you to update. That said, I think it makes
> better sense for me to look at the next version instead.
> 

Fine, I'll do that then.

Thanks
William Qiu

>>
>> Best regards,
>> William Qiu
> 
> Kind regards
> Uffe
