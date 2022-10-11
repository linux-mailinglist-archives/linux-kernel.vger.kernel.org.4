Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8FF5FAE4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJKIV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJKIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:21:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 320C02126F;
        Tue, 11 Oct 2022 01:21:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DD01ED1;
        Tue, 11 Oct 2022 01:22:02 -0700 (PDT)
Received: from [10.57.1.254] (unknown [10.57.1.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 762813F766;
        Tue, 11 Oct 2022 01:21:54 -0700 (PDT)
Message-ID: <d3ebd0c8-bea6-1c30-6c9e-52c459766b40@arm.com>
Date:   Tue, 11 Oct 2022 09:21:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Doug Smythies <dsmythies@telus.net>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Dietmar.Eggemann@arm.com, yu.chen.surf@gmail.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAAYoRsXgmwQXNzDPgVe=_cW=C8_7__GYHCyRKkfX=6dFY9dybw@mail.gmail.com>
 <Y0PvRz83+lklWeyb@e126311.manchester.arm.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Y0PvRz83+lklWeyb@e126311.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug, Kajetan,

On 10/10/22 11:09, Kajetan Puchalski wrote:
> On Thu, Oct 06, 2022 at 05:06:58PM -0700, Doug Smythies wrote:
>>
>> I would suggest a completely new governor for your
>> only 2 idle states, and of similar power use, scenario.
>> Incredibly simple:
>>
>> If CPU utilization >= threshold
>>    select idle state 0
>> Else
>>    Select idle state 1
>> Endif
> 
> That would be easy to implement at least but sadly just doesn't really
> work at all. It would just result in huge amounts of too deep C1 sleeps
> which are the main problem for us at the moment. For all intents and
> purposes, only ever selecting C0 gives better results than this approach
> on our hardware.
> 
>> As previously mentioned, you are overriding
>> everything that teo does anyhow.
> 
> To an extent yes, this just came from observations of how cpuidle
> behaves on arm. We tried an approach with only ever using C0 and it was
> all right on power usage, the device would just heat up too much and
> lose performance. That's why this approach of using TEO when the core is
> completely idle and moving to the lower state when it's not achieves the
> best of both worlds.
> 
>> Note to other readers: I also sent Kajetan an off-list email with more
>> tests descriptions and web links to results graphs and such.

Thanks Doug for testing this work, we really appreciate that.
Doug maybe you could post these into some public space, so wider
community would also see them. Kajetan has used github to put
a report with testing results containing some graphs/plots.

> 
> Looks like the email got lost in my inbox, could be some email filtering
> or something like that.. Could you possibly resend and cc my private
> email (kajetan.puchalski@tuta.io)?
> So far I've not directly received any of your emails, they show up on
> the mailing list archive but not in my inbox. Could be an IT issue on my
> end but might be worth checking your email setup regardless.

I also have some issues with the email inbox. Me apologies Doug, we will
sort it.

Regards,
Lukasz
