Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D2663CF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbjAJJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbjAJJdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:33:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7359514094;
        Tue, 10 Jan 2023 01:33:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3443E2F4;
        Tue, 10 Jan 2023 01:34:23 -0800 (PST)
Received: from [10.57.37.155] (unknown [10.57.37.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C73D3F587;
        Tue, 10 Jan 2023 01:33:39 -0800 (PST)
Message-ID: <12288ed4-b4c4-cd53-ab0e-8b235e0852c0@arm.com>
Date:   Tue, 10 Jan 2023 09:33:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] perf kmem: Support legacy tracepoints
Content-Language: en-US
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230108062400.250690-1-leo.yan@linaro.org>
 <14dd06c2-39f8-ccb5-ce59-f3a1e45c94d0@arm.com> <Y7w03A7f2zUWwihm@kernel.org>
 <Y7zC5imskN9tvtBn@leoy-yangtze.lan>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <Y7zC5imskN9tvtBn@leoy-yangtze.lan>
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



On 10/01/2023 01:45, Leo Yan wrote:
> On Mon, Jan 09, 2023 at 12:38:04PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> [...]
> 
>>>> +	const char * const slab_legacy_events[] = {
>>>> +	"-e", "kmem:kmalloc_node",
>>>> +	"-e", "kmem:kmem_cache_alloc_node",
>>>> +	};
>>>
>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>
>>> This fixes the error with mem:kmalloc_node for me.
> 
> Thanks for reviewing and testing!
> 
>>> I was thinking that it might be best to add all events to the list
>>> conditionally instead of just the legacy ones. That way, the same error
>>> won't happen in the future. But maybe it's best to have an explicit
>>> error again in case the breaking change was unintentional so it's fine
>>> as it is I think.
> 
> Yeah, this is a good idea for refactoring.
> 
> James, do you mind to send patches for this?

Do you not think there is any value in keeping it as showing an error
for the next time one is removed? I was assuming that was your intention
with this change, and I'm ok with keeping it that way for now. It's
probably quite rare anyway so the refactor could be more effort than the
gain.

James


> 
>> Just applied this, the changes you brains stormed may come as later
>> patches, thanks,
> 
> Thanks, Arnaldo.
> 
> Leo
