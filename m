Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4937682604
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAaICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:02:06 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A7441B6D;
        Tue, 31 Jan 2023 00:02:04 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BA501682646;
        Tue, 31 Jan 2023 16:02:01 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Jan
 2023 16:02:01 +0800
Received: from [192.168.120.55] (171.223.208.138) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 31 Jan
 2023 16:02:00 +0800
Message-ID: <fdad1eaf-bba5-0706-e3bf-9a4869ea4e92@starfivetech.com>
Date:   Tue, 31 Jan 2023 16:02:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-4-william.qiu@starfivetech.com>
 <Y8mPRQnGPpAhpu8C@spud>
From:   William Qiu <william.qiu@starfivetech.com>
In-Reply-To: <Y8mPRQnGPpAhpu8C@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/20 2:43, Conor Dooley wrote:
> Hey William,
> 
> On Tue, Dec 27, 2022 at 08:22:27PM +0800, William Qiu wrote:
>> This adds the mmc node for the StarFive JH7110 SoC.
>> Set sdioo node to emmc and set sdio1 node to sd.
>> 
>> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
>> ---
>>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
> 
> FYI, this file does not exist in the v3 Devicetree patchset sent by Hal
> Feng:
> https://lore.kernel.org/linux-riscv/20221220011247.35560-1-hal.feng@starfivetech.com
> 
> Would you make sure that future revisions take into account that there
> is now a jh7110-starfive-visionfive-2.dtsi file instead?
> 
> Thanks,
> Conor.
> 
Hi Conor,

I did it based on v2 and will rebase to v3 in the next version.

Best Regards
William Qiu
