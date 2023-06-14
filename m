Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250B72F2DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjFNC7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjFNC7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:59:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABCA3CE;
        Tue, 13 Jun 2023 19:59:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE9871FB;
        Tue, 13 Jun 2023 20:00:01 -0700 (PDT)
Received: from [10.163.46.15] (unknown [10.163.46.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9DB3F663;
        Tue, 13 Jun 2023 19:59:12 -0700 (PDT)
Message-ID: <36489061-d646-ab9c-6365-d5f7e8ed5bd5@arm.com>
Date:   Wed, 14 Jun 2023 08:29:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 02/10] arm64/perf: Add BRBE registers and fields
Content-Language: en-US
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-3-anshuman.khandual@arm.com>
 <ZIiZA+4G6n/mUZeL@FVFF77S0Q05N.cambridge.arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZIiZA+4G6n/mUZeL@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 21:57, Mark Rutland wrote:
> On Wed, May 31, 2023 at 09:34:20AM +0530, Anshuman Khandual wrote:
>> This adds BRBE related register definitions and various other related field
>> macros there in. These will be used subsequently in a BRBE driver which is
>> being added later on.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Reviewed-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>>  arch/arm64/tools/sysreg         | 159 ++++++++++++++++++++++++++++++++
>>  2 files changed, 262 insertions(+)
> 
>> +SysregFields BRBINFx_EL1
> 
>> +Enum	1:0	VALID
>> +	0b00	NONE
>> +	0b01	TARGET
>> +	0b10	SOURCE
>> +	0b11	FULL
>> +EndEnum
> 
> This looks correct...
> 
> [...]
> 
>> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0
> 
>> +Enum	1:0	VALID
>> +	0b00	NONE
>> +	0b01	TARGET
>> +	0b10	SOURCE
>> +	0b00	FULL
>> +EndEnum
> 
> ... but this clearly isn't.

Fixed VALID_FULL as 0b11.
