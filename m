Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678BE746706
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 03:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGDB6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 21:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGDB6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 21:58:39 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06025E59;
        Mon,  3 Jul 2023 18:58:37 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 791BF24E271;
        Tue,  4 Jul 2023 09:58:35 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 09:58:35 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 4 Jul
 2023 09:58:34 +0800
Message-ID: <fd591491-b8aa-b3e0-82e0-7d19c841819e@starfivetech.com>
Date:   Tue, 4 Jul 2023 09:58:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        <linux-riscv@lists.infradead.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230313034645.5469-1-samin.guo@starfivetech.com>
 <20230313173330.797bf8e7@kernel.org>
 <51102144-1533-d2f7-5fde-e01160a6f49e@starfivetech.com>
 <ZKChUuUpCgh/jPSU@aurel32.net>
From:   Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <ZKChUuUpCgh/jPSU@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
From: Aurelien Jarno <aurelien@aurel32.net>
tro: Guo Samin <samin.guo@starfivetech.com>
data: 2023/7/2

> Hi,
> 
> On 2023-03-15 09:31, Guo Samin wrote:
>> Re: [PATCH v6 0/8] Add Ethernet driver for StarFive JH7110 SoC
>> From: Jakub Kicinski <kuba@kernel.org>
>> to: Samin Guo <samin.guo@starfivetech.com>
>> data: 2023/3/14
>>
>>> On Mon, 13 Mar 2023 11:46:37 +0800 Samin Guo wrote:
>>>> This series adds ethernet support for the StarFive JH7110 RISC-V SoC.
>>>> The series includes MAC driver. The MAC version is dwmac-5.20 (from
>>>> Synopsys DesignWare). For more information and support, you can visit
>>>> RVspace wiki[1].
>>>
>>> I'm guessing the first 6 patches need to go via networking and patches
>>> 7 and 8 via riscv trees? Please repost those separately, otherwise
>>> the series won't apply and relevant CIs can't run on it.
>>
>> Hi Jakub,
>>
>> 	Thanks a lot, I will repost those separately.
> 
> Unless I am mistaken, this patches haven't been reposted since them.
> Could you please do that?
> 
> Thanks
> Aurelien
> 

Hi Aurelien,

Sorry for not having an update in a while. I'm waiting for the configuration of PHY to be finalized and the SYSCON patch to finally be merged in.
1) There are some updates to visionfive 2's PHY Drive Strength[1], but the implementation has not yet been finalized. Of course this is not the most important thing, since it can be updated later.
2) DTS depends on SYSCON. If the patch about SYSCON[2] has not been merged into the main line, there will be compilation problems. SYSCON's patch is part of Xingyu's PLL patchsets, and if the parts of SYSCON could be merged first, there would be no problem.

[1]: https://patchwork.kernel.org/project/netdevbpf/cover/20230526090502.29835-1-samin.guo@starfivetech.com
[2]: https://patchwork.kernel.org/project/linux-riscv/patch/20230613125852.211636-7-xingyu.wu@starfivetech.com
 
Best regards,
Samin
