Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6E718EC1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjEaWr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjEaWr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:47:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C1A189
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:47:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 148961063;
        Wed, 31 May 2023 15:48:06 -0700 (PDT)
Received: from [10.57.22.124] (unknown [10.57.22.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E62523F7D8;
        Wed, 31 May 2023 15:47:19 -0700 (PDT)
Message-ID: <7fc93591-53a8-3c62-4dbe-c187adaa3b5d@arm.com>
Date:   Wed, 31 May 2023 23:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Coresight ML <coresight@lists.linaro.org>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
 <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
 <2023051530-immunize-pony-49ef@gregkh>
 <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
In-Reply-To: <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Links updated to the series.

On 31/05/2023 23:44, Suzuki K Poulose wrote:
> (Removed irrelevant recipients), +Cc: coresight ml
> 
> Hi Greg,
> 
> On 15/05/2023 12:55, Greg KH wrote:
>> On Mon, May 15, 2023 at 08:55:33AM +0100, James Clark wrote:
>>>
>>>
>>> On 13/05/2023 12:04, Greg KH wrote:
>>>> On Tue, May 09, 2023 at 10:49:38AM +0100, James Clark wrote:
>>>>> There is no krealloc_array equivalent in devres. Users would have to
>>>>> do their own multiplication overflow check so provide one.
>>>>>
>>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>>> ---
>>>>>   Documentation/driver-api/driver-model/devres.rst |  1 +
>>>>>   include/linux/device.h                           | 11 +++++++++++
>>>>>   2 files changed, 12 insertions(+)
> 
> ...
> 
>>> Maybe something could be done with some macro magic, but it would
>>> probably end up being worse than just copying them and would affect the
>>> real ones as well. So yeah I can't think of any easy gains either.
>>
>> Ok, that's good.  Given a lack of objections from others, I'll just take
>> this through my driver core tree in a few days.
> 
> Apologies for hijacking the thread. We have a series for CoreSight[1]
> that depends on this series, which I see that, is queued in your
> driver-core-next.
> 
> I would like to queue [1] for the next version (as there are other
> work that depend on this, e.g., [2]). Do you have any 
> recommendations/comments on the proposal ? Are you able to share a
> stable branch which can be merged to coresight/next and queue the
> series ontop ? (PS: I haven't queued anything for coresight/next yet).

[1] https://lkml.kernel.org/r/20230425143542.2305069-1-james.clark@arm.com
[2] 
https://lkml.kernel.org/r/1682586037-25973-1-git-send-email-quic_taozha@quicinc.com


Suzuki

