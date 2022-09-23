Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E175E7B05
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIWMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiIWMn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:43:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58F38132D76;
        Fri, 23 Sep 2022 05:43:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA5C5139F;
        Fri, 23 Sep 2022 05:43:30 -0700 (PDT)
Received: from [10.57.2.155] (unknown [10.57.2.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4905F3F73B;
        Fri, 23 Sep 2022 05:43:22 -0700 (PDT)
Message-ID: <c8f9d6d2-4397-3bbd-da97-865cca56d73a@arm.com>
Date:   Fri, 23 Sep 2022 13:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] perf: arm64: Kernel support for Dwarf unwinding
 through SVE functions
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, john.garry@huawei.com,
        Jonathan Corbet <corbet@lwn.net>, leo.yan@linaro.org,
        broonie@kernel.org, linux-doc@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20220901132658.1024635-1-james.clark@arm.com>
 <166385556279.1475166.2989569100449667346.b4-ty@kernel.org>
 <1dabe308-21f7-aa2e-ee8f-48807878f91b@arm.com>
 <20220923123633.GC13942@willie-the-truck>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220923123633.GC13942@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/09/2022 13:36, Will Deacon wrote:
> On Fri, Sep 23, 2022 at 10:32:15AM +0100, James Clark wrote:
>>
>>
>> On 22/09/2022 21:33, Will Deacon wrote:
>>> On Thu, 1 Sep 2022 14:26:56 +0100, James Clark wrote:
>>>> I'm resubmitting this with a few of the changes suggested by Will on V2.
>>>>
>>>> I haven't made any changes regarding the open questions about the
>>>> discoverability or saving the new reg and passing to output_sample()
>>>> because I think it's best to be consistent with the implementations on
>>>> other platforms first. I have explained in more detail on v2 [1].
>>>>
>>>> [...]
>>>
>>> Applied to will (for-next/perf), thanks!
>>>
>>> [1/2] perf: arm64: Add SVE vector granule register to user regs
>>>       https://git.kernel.org/will/c/cbb0c02caf4b
>>> [2/2] arm64/sve: Add Perf extensions documentation
>>>       https://git.kernel.org/will/c/1f2906d1e10a
>>>
>>> Cheers,
>>
>> Thanks Will. Sorry about the build, I will fix my config for next time.
> 
> No problem. For some reason, I was unable to repro the failure locally.
> Maybe it's a GCC thing?

For me I needed CONFIG_HEADERS_INSTALL and CONFIG_UAPI_HEADER_TEST to
reproduce it. I was already using gcc, so not sure if it's depends on
that or not.

> 
> Will
