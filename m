Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C476BA5B7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjCODoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCODoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:44:11 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE0319F2E;
        Tue, 14 Mar 2023 20:44:06 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2F8E924E1A6;
        Wed, 15 Mar 2023 11:44:04 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 11:44:04 +0800
Received: from [192.168.125.128] (113.72.145.194) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 15 Mar
 2023 11:44:03 +0800
Message-ID: <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com>
Date:   Wed, 15 Mar 2023 11:44:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/11] Add new partial clock and reset drivers for
 StarFive JH7110
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
 <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.194]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/15 8:30, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-03-14 05:43:53)
>> This patch serises are to add new partial clock drivers and reset
>> supports about System-Top-Group(STG), Image-Signal-Process(ISP)
>> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.
> 
> What is your merge plan for this series? Did you intend for clk tree to
> take the majority of patches? We won't take the dts changes through the
> clk tree.
> 
> I think Philipp Zabel reviewed some earlier version of the patches and
> provided reviewed-by tags. Can you check if they can be added here? If
> so, please resend again, or get those merged through the reset tree.

These patches add new clock & reset providers based on the basic clock & reset
of the minimal system which Hal.feng had submitted[1], which are used in USB, DMA,
VIN and Display modules that are merging.
[1]: https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfivetech.com/

Oh I checked and had not received any comments from Philipp Zabel in earlier version
of these patches. Maybe it was confused with the patches of the minimal system.

Best regards,
Xingyu Wu
