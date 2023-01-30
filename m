Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3554E68072F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbjA3IPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbjA3IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:15:02 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E3FE065;
        Mon, 30 Jan 2023 00:14:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 9C3FF24E3A2;
        Mon, 30 Jan 2023 16:13:19 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:13:19 +0800
Received: from [192.168.125.128] (183.27.97.127) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 30 Jan
 2023 16:13:18 +0800
Message-ID: <20969224-3212-be89-cefc-9c1d7bbf75f6@starfivetech.com>
Date:   Mon, 30 Jan 2023 16:09:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 06/11] clk: starfive: Add StarFive JH7110
 Image-Signal-Process clock driver
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
References: <20230120024445.244345-1-xingyu.wu@starfivetech.com>
 <20230120024445.244345-7-xingyu.wu@starfivetech.com>
 <eb37200702b27d239b2689daefc85ffa.sboyd@kernel.org>
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
In-Reply-To: <eb37200702b27d239b2689daefc85ffa.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.127]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/26 10:35, Stephen Boyd wrote:
> Quoting Xingyu Wu (2023-01-19 18:44:40)
>> diff --git a/drivers/clk/starfive/clk-starfive-jh7110-isp.c b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
>> new file mode 100644
>> index 000000000000..f9fc94b4c6f8
>> --- /dev/null
>> +++ b/drivers/clk/starfive/clk-starfive-jh7110-isp.c
>> @@ -0,0 +1,218 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * StarFive JH7110 Image-Signal-Process Clock Driver
>> + *
>> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Same include comment. This signals this is a clk consumer, which it
> isn't?

This driver need to use 'clk_bulk_data' struct and some functions like
'devm_clk_bulk_get()' and 'clk_bulk_prepare_enable()' from this include.

Best regards,
Xingyu Wu
