Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F4B610B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJ1HXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiJ1HXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:23:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F41DD1A9124;
        Fri, 28 Oct 2022 00:23:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BCBF1FB;
        Fri, 28 Oct 2022 00:23:51 -0700 (PDT)
Received: from [10.57.1.225] (unknown [10.57.1.225])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D0B63F445;
        Fri, 28 Oct 2022 00:23:43 -0700 (PDT)
Message-ID: <63a63f5e-846a-3235-56f9-3cc9b5c2dd4d@arm.com>
Date:   Fri, 28 Oct 2022 08:23:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
 <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
 <2e02056b-24ef-6262-03bd-63fd6f3a5754@arm.com>
 <ac249d3c-6907-daf5-1047-0b3823eef1aa@linexp.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ac249d3c-6907-daf5-1047-0b3823eef1aa@linexp.org>
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



On 10/28/22 08:11, Daniel Lezcano wrote:
> On 28/10/2022 09:08, Lukasz Luba wrote:
> 
> [ ... ]
> 
>>> [1] Dynamic workload characterization for power efficient scheduling 
>>> on CMP systems : https://cseweb.ucsd.edu//~tullsen/islped10.pdf
>>>
>>> [2] 
>>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=cpuidle/mobile-governor-v5.1&id=de1edb05e3c342f0738b414aa84263d6555b7462 
>>>
>>>
>>>
>>
>> Thanks Daniel! I forgot about your work in this area. As I have
>> responded in some other email in this thread, we might start
>> from a new small governor and than others can contribute.
>>
>> Even this small governor that Kajetan showed me performs really
>> good on pixel6.
> 
> Do you have others ARM64 platforms to compare with ?
> 

Yes we have, also some older platforms (~10years now, which
would be nice to check how they would perform).
We also have a big arm64 server to give it a try there. So those results
will be available with the new patch when we decide to go the new
governor.
