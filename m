Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FB1603859
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiJSDB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJSDBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:01:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B437E6F6C;
        Tue, 18 Oct 2022 20:01:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A1CD1042;
        Tue, 18 Oct 2022 20:01:27 -0700 (PDT)
Received: from [10.162.40.19] (unknown [10.162.40.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1CF3F67D;
        Tue, 18 Oct 2022 20:01:16 -0700 (PDT)
Message-ID: <561e9e28-8459-b422-4989-176db9a2bd4b@arm.com>
Date:   Wed, 19 Oct 2022 08:31:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 1/7] arm64/perf: Add BRBE registers and fields
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221017055713.451092-1-anshuman.khandual@arm.com>
 <20221017055713.451092-2-anshuman.khandual@arm.com>
 <Y06wiI2hgsz5QPTh@sirena.org.uk>
Content-Language: en-US
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Y06wiI2hgsz5QPTh@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/22 19:26, Mark Brown wrote:
> On Mon, Oct 17, 2022 at 11:27:07AM +0530, Anshuman Khandual wrote:
> 
> I spotted one typo below but otherwise this looks good!
> 
>> +# This is just a dummy register declaration to get all common field masks and
>> +# shifts for accessing given BRBINF contents.
>> +Sysreg	BRBINF_EL1	2	1	8	0	0
> 
> This seems reasonable to me, others may disagree.
> 
>> +Sysreg	BRBCR_EL1	2	1	9	0	0
>> +Res0	63:24
>> +Field	23 	EXCEPTION
>> +Field	22 	ERTN
>> +Res0	21:9
>> +Field	8 	FZP
>> +Res0	7
>> +Enum	6:5	TS
>> +	0b1	VIRTUAL
> 
> I'd have expected this to be written as 0b01.  Doesn't make any
> practical difference though.

Sure, will change.

> 
>> +Sysreg	BRBFCR_EL1	2	1	9	0	1
> 
>> +Field	16	EnL
> 
> This is "EnI" in DDI0487I.a.

Okay, will replace "EnL" with "EnI" instead.
