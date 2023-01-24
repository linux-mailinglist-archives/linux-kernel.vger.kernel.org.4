Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4A9678FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 06:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjAXFUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 00:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 00:20:38 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7D844AA;
        Mon, 23 Jan 2023 21:20:36 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DA62C24E24D;
        Tue, 24 Jan 2023 13:20:33 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 24 Jan
 2023 13:20:33 +0800
Received: from [192.168.125.95] (183.27.96.38) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 24 Jan
 2023 13:20:32 +0800
Message-ID: <820be512-c7f8-1af1-12fa-53c557532c7a@starfivetech.com>
Date:   Tue, 24 Jan 2023 13:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/2] JH7110 PMU Support
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230119094447.21939-1-walker.chen@starfivetech.com>
 <167425300253.196995.6414153954346182622.b4-ty@microchip.com>
Content-Language: en-US
From:   Walker Chen <walker.chen@starfivetech.com>
In-Reply-To: <167425300253.196995.6414153954346182622.b4-ty@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.96.38]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/21 6:21, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On Thu, 19 Jan 2023 17:44:45 +0800, Walker Chen wrote:
>> This patchset adds PMU (Power Management Unit) controller driver for the
>> StarFive JH7110 SoC. In order to meet low power requirements, PMU is
>> designed for including multiple PM domains that can be used for power
>> gating of selected IP blocks for power saving by reduced leakage
>> current. The first patch adds device tree binding for PM domain provider
>> and consumer. The second patch adds pmu driver and support JH7110 SoC.
>> 
>> [...]
> 
> Applied to riscv-soc-for-next, thanks!
> 
> [1/2] dt-bindings: power: Add starfive,jh7110-pmu
>       https://git.kernel.org/conor/c/1fc7606d5083f79a20eb9cfd77c0dbd9299421c1
> [2/2] soc: starfive: Add StarFive JH71XX pmu driver
>       https://git.kernel.org/conor/c/08b9a94e8654d402bfd1f5496b077503d69aa2cf
> 
> I modified the MAINTAINERS entry to remove the include directory that
> was deleted along the way.

Thank you so much for your support, Conor, Krzysztof, Emil, Heiko, Rob Herring, etc.
Hopefully more and more drivers & modules of StarFive SoC will upstream to the open source community.

