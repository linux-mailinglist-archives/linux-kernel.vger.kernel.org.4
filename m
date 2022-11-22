Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F395633460
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 05:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKVERp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 23:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiKVERg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 23:17:36 -0500
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024772CE3F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 20:16:38 -0800 (PST)
Received: from [10.88.19.158] (10.88.19.158) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2507.13; Tue, 22 Nov 2022
 12:16:35 +0800
Message-ID: <e12a12a4-ab6c-ff4a-5cb8-10e498e696a5@amlogic.com>
Date:   Tue, 22 Nov 2022 12:17:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: linux-next: build failure after merge of the arm64 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Chris Healy <healych@amazon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221122104136.601ba45e@canb.auug.org.au>
From:   Jiucheng Xu <jiucheng.xu@amlogic.com>
In-Reply-To: <20221122104136.601ba45e@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.88.19.158]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Could you please share your compiler information, commit id and other

environments info for me to reproduce the building error?

Thanks,

Jiucheng

On 2022/11/22 7:41, Stephen Rothwell wrote:
> Hi all,
>
> After merging the arm64 tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/perf/amlogic/meson_g12_ddr_pmu.c: In function 'dmc_g12_get_freq_quick':
> drivers/perf/amlogic/meson_g12_ddr_pmu.c:135:15: error: implicit declaration of function 'readl' [-Werror=implicit-function-declaration]
>    135 |         val = readl(info->pll_reg);
>        |               ^~~~~
> drivers/perf/amlogic/meson_g12_ddr_pmu.c: In function 'dmc_g12_counter_enable':
> drivers/perf/amlogic/meson_g12_ddr_pmu.c:204:9: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
>    204 |         writel(clock_count, info->ddr_reg[0] + DMC_MON_G12_TIMER);
>        |         ^~~~~~
>
> Caused by commit
>
>    2016e2113d35 ("perf/amlogic: Add support for Amlogic meson G12 SoC DDR PMU driver")
>
> I have used the arm64 tree from next-20221121 for today.
>
-- 
Thanks,
Jiucheng

