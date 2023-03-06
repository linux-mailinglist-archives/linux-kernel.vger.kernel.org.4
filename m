Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E912F6ABA36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCFJnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjCFJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:43:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8E2821A29;
        Mon,  6 Mar 2023 01:43:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D22611FB;
        Mon,  6 Mar 2023 01:43:53 -0800 (PST)
Received: from [10.57.52.218] (unknown [10.57.52.218])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A8A63F885;
        Mon,  6 Mar 2023 01:43:06 -0800 (PST)
Message-ID: <650bebf8-3988-05bb-2620-d714a2ec4631@arm.com>
Date:   Mon, 6 Mar 2023 10:43:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched/topology: Remove EM_MAX_COMPLEXITY limit
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ionela.Voinescu@arm.com, qperret@google.com,
        Lukasz Luba <lukasz.luba@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20221121094336.3250917-1-pierre.gondois@arm.com>
 <81d99fba-ce38-a9a4-4b80-aa3e2cc6f3c6@arm.com>
 <66cfa719-6055-a521-6146-f629b7d0e446@arm.com>
Content-Language: en-US
In-Reply-To: <66cfa719-6055-a521-6146-f629b7d0e446@arm.com>
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

Hello Peter,
Just a remainder in case this was forgotten,
Regards,
Pierre

On 2/1/23 17:16, Pierre Gondois wrote:
> Hello Peter,
> Please let me know if there are additional modifications required,
> Regards,
> Pierre
> 
> On 11/30/22 18:11, Dietmar Eggemann wrote:
>> On 21/11/2022 10:43, Pierre Gondois wrote:
>>> From: Pierre Gondois <Pierre.Gondois@arm.com>
>>
>> [...]
>>
>>> Signed-off-by: Pierre Gondois <Pierre.Gondois@arm.com>
>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>> ---
>>>
>>> Notes:
>>>       v2:
>>>        - Fix complexity computation in the commit message. [Dietmar]
>>>        - Use correct/latest function names. [Ionela]
>>>        - Added Rb from Lukasz.
>>>       v3:
>>>        - Keep paragraph 6.3 in sched-energy.rst with just a reference to
>>>          EM_MAX_NUM_CPUS, reference EM_MAX_NUM_CPUS in the commit message.
>>>          [Dietmar]
>>
>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
