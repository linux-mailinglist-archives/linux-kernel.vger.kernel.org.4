Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908396F7AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjEEBip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEEBin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:38:43 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574C711DB2;
        Thu,  4 May 2023 18:38:42 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E355824E2B1;
        Fri,  5 May 2023 09:38:39 +0800 (CST)
Received: from EXMBX067.cuchost.com (172.16.6.67) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 5 May
 2023 09:38:39 +0800
Received: from [192.168.125.89] (183.27.99.121) by EXMBX067.cuchost.com
 (172.16.6.67) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 5 May
 2023 09:38:38 +0800
Message-ID: <457c35b5-aec4-1147-673f-947052b5f944@starfivetech.com>
Date:   Fri, 5 May 2023 09:38:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] Add JH7110 cpufreq support
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Shengyu Qu <wiagn233@outlook.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
References: <20230421031431.23010-1-mason.huo@starfivetech.com>
Content-Language: en-US
From:   Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230421031431.23010-1-mason.huo@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.99.121]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX067.cuchost.com
 (172.16.6.67)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor & Shengyu,

Thanks for your review, and is there any comments about these v3 patches?

Thanks
Mason

On 2023/4/21 11:14, Mason Huo wrote:
> The StarFive JH7110 SoC has four RISC-V cores,
> and it supports up to 4 cpu frequency loads.
> 
> This patchset adds the compatible strings into the allowlist
> for supporting the generic cpufreq driver on JH7110 SoC.
> Also, it enables the axp15060 pmic for the cpu power source.
> 
> The series has been tested on the VisionFive 2 boards which
> are equipped with JH7110 SoC and axp15060 pmic.
> 
> 
> This patchset is based on v6.3-rc4 with these patches applied:
> [1] ("Basic clock, reset & device tree support for StarFive JH7110 RISC-V SoC")
>     https://lore.kernel.org/all/20230401111934.130844-1-hal.feng@starfivetech.com/
> [2] ("Add X-Powers AXP15060 PMIC support")
>     https://lore.kernel.org/all/TY3P286MB2611A814E580C96DC6F187B798969@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
> 
> Changes since v2:
> - Fix the new blank line at EOF issue in dtsi.
> 
> Changes since v1:
> - Fix dts node naming issues.
> - Move clock properties of cpu node from <board>.dtsi to <soc>.dtsi.
> - Follow the alphabetical order to place the cpufreq dt allowlist.
> 
> ---
> v1: https://lore.kernel.org/all/20230411083257.16155-1-mason.huo@starfivetech.com/
> v2: https://lore.kernel.org/lkml/20230417063942.3141-1-mason.huo@starfivetech.com/
> 
> Mason Huo (3):
>   riscv: dts: starfive: Enable axp15060 pmic for cpufreq
>   cpufreq: dt-platdev: Add JH7110 SOC to the allowlist
>   riscv: dts: starfive: Add cpu scaling for JH7110 SoC
> 
>  .../jh7110-starfive-visionfive-2.dtsi         | 30 +++++++++++++++++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 33 +++++++++++++++++++
>  drivers/cpufreq/cpufreq-dt-platdev.c          |  2 ++
>  3 files changed, 65 insertions(+)
> 
> base-commit: 197b6b60ae7bc51dd0814953c562833143b292aa
