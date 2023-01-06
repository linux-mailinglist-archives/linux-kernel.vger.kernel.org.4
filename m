Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A360265FF63
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjAFLOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjAFLOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:14:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD49A7149A;
        Fri,  6 Jan 2023 03:13:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2367511FB;
        Fri,  6 Jan 2023 03:14:41 -0800 (PST)
Received: from [10.163.46.147] (unknown [10.163.46.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C51FF3F23F;
        Fri,  6 Jan 2023 03:13:54 -0800 (PST)
Message-ID: <be0e73c4-31aa-e742-03fe-5b4a266f4e0b@arm.com>
Date:   Fri, 6 Jan 2023 16:43:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V7 0/6] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
References: <20230105031039.207972-1-anshuman.khandual@arm.com>
 <8362ba75-db80-e427-b610-988f92c961a8@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8362ba75-db80-e427-b610-988f92c961a8@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/6/23 15:53, James Clark wrote:
> 
> On 05/01/2023 03:10, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
> Hi Anshuman,
> 
> The missing cc for linux-perf-users@vger.kernel.org on the other patches
> means that this looks incomplete on the lore page for linux-perf-users.
> b4 still picks up the full set, so it's probably fine. But it might be
> worth adding the same cc for all patches next time.

Right, actually forgot to add cc-cover option while sending via git.
