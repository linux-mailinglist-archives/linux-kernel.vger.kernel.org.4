Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4F85E65A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiIVObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiIVObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:31:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AA10B5A40;
        Thu, 22 Sep 2022 07:31:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BF7B1595;
        Thu, 22 Sep 2022 07:31:30 -0700 (PDT)
Received: from [10.57.1.91] (unknown [10.57.1.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 469B83F73B;
        Thu, 22 Sep 2022 07:31:22 -0700 (PDT)
Message-ID: <d6eaa797-380b-e8ae-f928-54843dd596f2@arm.com>
Date:   Thu, 22 Sep 2022 15:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, broonie@kernel.org,
        acme@kernel.org, leo.yan@linaro.org, john.garry@huawei.com,
        catalin.marinas@arm.com, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org
References: <20220901132658.1024635-1-james.clark@arm.com>
 <20220922140406.GG12095@willie-the-truck>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220922140406.GG12095@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/09/2022 15:04, Will Deacon wrote:
> On Thu, Sep 01, 2022 at 02:26:56PM +0100, James Clark wrote:
>> I'm resubmitting this with a few of the changes suggested by Will on V2.
>>
>> I haven't made any changes regarding the open questions about the
>> discoverability or saving the new reg and passing to output_sample()
>> because I think it's best to be consistent with the implementations on
>> other platforms first. I have explained in more detail on v2 [1].
>>
>> [1]: https://lore.kernel.org/lkml/5fcf1a6f-c8fb-c296-992e-18aae8874095@arm.com/
> 
> Fair enough, I can't argue against being consistent.
> 
> Given that this exposes subtle new user ABI, do we have any coverage in
> the selftests? If not, please could you add something?
> 

Thanks, I will do that. I assume you mean the self tests in
tools/perf/tests and not some non Perf tests?

> Thanks,
> 
> Will
