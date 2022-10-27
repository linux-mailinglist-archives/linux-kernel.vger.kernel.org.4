Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF76610258
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiJ0UFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbiJ0UE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:04:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76C7122BCA;
        Thu, 27 Oct 2022 13:04:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D6E423A;
        Thu, 27 Oct 2022 13:05:00 -0700 (PDT)
Received: from [10.57.7.15] (unknown [10.57.7.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6766E3F445;
        Thu, 27 Oct 2022 13:04:52 -0700 (PDT)
Message-ID: <f799f67c-c9e9-c702-8457-db8da78500c9@arm.com>
Date:   Thu, 27 Oct 2022 21:04:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, Dietmar.Eggemann@arm.com,
        dsmythies@telus.net, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kajetan Puchalski <kajetan.puchalski@arm.com>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
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

Hi Rafael,

On 10/13/22 12:12, Kajetan Puchalski wrote:
> On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
>> On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
>> <kajetan.puchalski@arm.com> wrote:
>>>
>>> Hi,
>>>
>>> At the moment, all the available idle governors operate mainly based on their own past performance
>>
>> Not true, at least for the menu and teo governors that use the
>> information on the distribution of CPU wakeups that is available to
>> them and try to predict the next idle duration with the help of it.
>> This has a little to do with their performance.
> 
> You're right of course, I should have written "their own past
> correctness" as that's what I was referring to. I just meant that for
> instance with TEO the initial timer-based choice is only adjusted using
> the governor's own metrics and not any information from anywhere else in
> the system.
> 

[snip]

Would it be possible to consider a new small and simple idle governor
which is better suited for those other workloads and platforms?
Kajetan has such one and can send to the LKML, so you could have a look.

I have sent some detailed explanation about this to Doug in this
thread (don't want to duplicate it).

It looks like it would be hard to meet both worlds' requirements.

Regards,
Lukasz
