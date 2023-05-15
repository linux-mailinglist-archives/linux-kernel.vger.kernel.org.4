Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B7702489
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjEOGY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjEOGY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:24:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24E4F12B;
        Sun, 14 May 2023 23:24:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9495B4B3;
        Sun, 14 May 2023 23:25:03 -0700 (PDT)
Received: from [10.163.71.10] (unknown [10.163.71.10])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B4DD3F7BD;
        Sun, 14 May 2023 23:24:10 -0700 (PDT)
Message-ID: <2dafd371-173e-1592-23d2-939b8a81dcbe@arm.com>
Date:   Mon, 15 May 2023 11:54:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V9 00/10] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230315051444.1683170-1-anshuman.khandual@arm.com>
 <20230411130326.GA22736@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230411130326.GA22736@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/23 18:33, Will Deacon wrote:
> Hi Anshuman
> 
> On Wed, Mar 15, 2023 at 10:44:34AM +0530, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on 6.3-rc1 after applying the following patch from Mark
>> which allows enums in SysregFields blocks in sysreg tools.
>>
>> https://lore.kernel.org/all/20230306114836.2575432-1-mark.rutland@arm.com/
> 
> As mentioned by Mark at:
> 
> https://lore.kernel.org/r/ZB2sGrsbr58ttoWI@FVFF77S0Q05N
> 
> this conflicts with supporting PMUv3 on AArch32. Please can you rebase onto
> for-next/perf, which will mean moving this driver back into drivers/perf/
> now?

Hi Will,

I am back from a long vacation, will go through the earlier discussions
on this and rework the series as required.

- Anshuman
