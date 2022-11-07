Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584C861EFCF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiKGJ7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiKGJ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:59:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69FBC12D00
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:59:28 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 51EDA1FB;
        Mon,  7 Nov 2022 01:59:34 -0800 (PST)
Received: from [10.57.67.115] (unknown [10.57.67.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 659E53F534;
        Mon,  7 Nov 2022 01:59:26 -0800 (PST)
Message-ID: <99b25aab-ba87-b875-9f5f-c7dd9444b8c8@arm.com>
Date:   Mon, 7 Nov 2022 09:59:24 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 5.10] coresight: cti: Fix hang in cti_disable_hw()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Clark <james.clark@arm.com>, stable@kernel.org,
        Aishwarya TCV <Aishwarya.TCV@arm.com>,
        Cristian Marussi <Cristian.Marussi@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221102112003.2318583-1-james.clark@arm.com>
 <Y2jLvmF0GZ6yHY0m@kroah.com> <4d44d2c8-a8ec-1729-d3cc-9ae8beb48045@arm.com>
 <Y2jVXdX1Mx5eXAiB@kroah.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Y2jVXdX1Mx5eXAiB@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 09:52, Greg Kroah-Hartman wrote:
> On Mon, Nov 07, 2022 at 09:23:26AM +0000, Suzuki K Poulose wrote:
>> On 07/11/2022 09:11, Greg Kroah-Hartman wrote:
>>> On Wed, Nov 02, 2022 at 11:20:03AM +0000, James Clark wrote:
>>>> commit 6746eae4bbaddcc16b40efb33dab79210828b3ce upstream.
>>>
>>> Isn't this commit 665c157e0204176023860b51a46528ba0ba62c33 instead?
>>
>> This was reverted in commit d76308f03ee1 and pushed in later
>> with fixups as 6746eae4bbadd.
> 
> So which should be applied?

Sorry, this particular post is a backport for v5.10 stable branch.

> 
> confused,

Now I am too. What is expected here ? My understanding is, we
should stick the "upstream" commit that is getting backported
at the beginning of the commit description. In that sense,
the commit id in this patch looks correct to me. Please let
me know if this is not the case.

As such, this is only for 5.10.x branch. The rest are taken
care of.

Please let us know if we are something missing.

Suzuki


> 
> greg k-h

