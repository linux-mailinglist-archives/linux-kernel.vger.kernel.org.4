Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1D6EA65B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjDUI4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjDUI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:56:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E17A6B751
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:55:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7B21480;
        Fri, 21 Apr 2023 01:56:13 -0700 (PDT)
Received: from [10.57.82.85] (unknown [10.57.82.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 326C13F5A1;
        Fri, 21 Apr 2023 01:55:28 -0700 (PDT)
Message-ID: <113e5355-76d4-f6d2-f11b-c2e57475639a@arm.com>
Date:   Fri, 21 Apr 2023 09:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] perf cs-etm: Add support for coresight trace for any
 range of CPUs
To:     James Clark <james.clark@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     mathieu.poirier@linaro.org, acme@kernel.org,
        darren@os.amperecomputing.com, scott@os.amperecomputing.com,
        scclevenger@os.amperecomputing.com, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org
References: <20230419172101.78638-1-gankulkarni@os.amperecomputing.com>
 <d758c5e2-aa32-d829-35ee-a685bdb56f75@arm.com>
 <84eb3363-2ef8-d3f1-4613-805959dbf334@os.amperecomputing.com>
 <91ba66e7-737f-6526-a703-a755e114f9d4@arm.com>
 <dea08376-e66b-bacc-7673-c79fe2a8f889@os.amperecomputing.com>
 <902dea0e-456b-d763-fdb5-a520ea3d7536@arm.com>
 <53132776-c998-a24f-a811-d8fb2e5e6535@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <53132776-c998-a24f-a811-d8fb2e5e6535@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2023 16:44, James Clark wrote:
> 
> 
> On 20/04/2023 14:03, Suzuki K Poulose wrote:
>> On 20/04/2023 13:37, Ganapatrao Kulkarni wrote:
>>>
>>>
>>> On 20-04-2023 06:00 pm, James Clark wrote:
>>>>
>>>>
>>>> On 20/04/2023 12:47, Ganapatrao Kulkarni wrote:
>>>>>
>>
>> ...
>>
>>>>> My patch is rebased on 6.3-RC7 codebase with Mike's 3 perf patches
>>>>> related to dynamic id [1] support(queued for 6.4).
>>>>>
>>>>> "perf report -D" works for me.
>>>>
>>>> I was referring to sparse CPU lists, which I think you mentioned above
>>>> doesn't work even with this patch.
>>>>
>>>>>
>>>>> [1] https://www.spinics.net/lists/linux-perf-users/msg27452.html
>>>>>
>>>>
>>>> It should be based on the next branch here:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git
>>>
>>> OK.
>>
>> It need not be. Since this patch is purely perf tools patch and has
>> nothing to do with the kernel drivers, it should be beased on whatever
>> the tip of the perf tool tree is. Otherwise we risk rebasing to that
>> eventually.
>>
>> Cheers
>> Suzuki
>>
> 
> Good point, sorry for the confusion!
> 
> I wonder if we could have some kind of new staging branch that has both
> up to date perf and coresight changes at the same time? Either that
> would make things like this easier, or more complicated. I'm not sure.

I agree that it is complicated. :-(

We could do something about this if a situation arises in the future,
where the kernel and perf patches are out of sync w.r.t merging.
As, such the dependency on Anshuman's series is for ACPI support
which Ampere system needs. I would let this one pass, given the merge
window is too close.


Thanks
Suzuki

