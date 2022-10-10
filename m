Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD945F9BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 11:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiJJJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiJJJcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 05:32:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52304DF3A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:32:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r14so15758966lfm.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 02:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ea7flc1qLEOW/awjCpuTynDhYWRL7o5KfNiU6r1reMA=;
        b=ClbWTbOG/PieuNvLlE0G8V1p7Ssk1QTnuPT3P4vv7KzLmxqt2pAp3iSMIiT/71GCcV
         tm1QbaAI7VoXFvOB+nNIHzoBzALC5Pf/WXJR9BfDxUfwhmC+sd+Lkte5mb3z4QCJTwp0
         KsYEsQmDcQmXmK+qE6nE0Ffhu3SaVqECkyY+h65WMqfR/28Vs4jw6JIHmXBO5OzjyxXZ
         E5ximSQzUL1CDQFkkuSDEYslR6S5DxDTWpWulAGsL9K03tXEBxuvD7CkiwMzHqgbAuO0
         wLctj/4vmJNVJz61qieYj0zFLQUY3HX6Qw9OIgMifSKoYFILPMaFbD7TMWqjVVwhMG6H
         X04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ea7flc1qLEOW/awjCpuTynDhYWRL7o5KfNiU6r1reMA=;
        b=5kYs/tkp8t5fjDr6FMhsagEZQ0r921ONGy+9g/bog3OVOT9Qn3XRxdGDS0XbXTBRwb
         my+zfms0Cuu/j7MqFDBOQjQApkHqbM/t3T0b4CmZfwInxWVgXrQDrvK8PVT542zVGTyy
         i0oao9ibmTnPm0x8FrQuE4fQLH0GZ+toNILEFtsMWqDvvahRMduOgAlWR64roo8CzojY
         a02Aa4o6Xi2zFO+gnn7uftdHBjUbbAiuEGwlbPkFjHzFfsLEYdxZCibJdIdasWRRQtDZ
         /ZxXY+9WzsUlcV7VaI3q1Rg8kutu8dmNFMSWryQVIPcAX2xqO+GLbHPDdl48ced1NVDP
         5mLw==
X-Gm-Message-State: ACrzQf2Sl5h5poQnHSl5/W/uG7ibRVDPM19uhvOMjDDKUz+Yu38xpt7j
        CDnz0b1LEB0QX3Eh6eDqfJ2DGPbQM70UK5enOAxwWQ==
X-Google-Smtp-Source: AMsMyM6oWxS0Z90SLjeRT8QkS0866ZBDyiovsvw9wDUNT5vr76jcip2Ej3aEEkU2q7KCZdQvT/ba0+M3qZ4CXNHqstM=
X-Received: by 2002:a19:ad03:0:b0:4a0:56ab:7148 with SMTP id
 t3-20020a19ad03000000b004a056ab7148mr6735488lfc.430.1665394359975; Mon, 10
 Oct 2022 02:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220930094821.31665-1-lukasz.luba@arm.com> <20220930094821.31665-2-lukasz.luba@arm.com>
 <20221010053902.5rofnpzvyynumw3e@vireshk-i7> <3f9a4123-171b-5fa7-f506-341355f71483@arm.com>
 <CAKfTPtBPqcTm5_-M_Ka3y46yQ2322TmH8KS-QyDbAiKk5B6hEQ@mail.gmail.com> <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
In-Reply-To: <8a7968c2-dbf7-5316-ef36-6d45143e0605@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Oct 2022 11:32:28 +0200
Message-ID: <CAKfTPtB3Lk5bc9k634O+Yi8wwP=MVeKS5NPbpaqwhX1F4t5EbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpufreq: Update CPU capacity reduction in store_scaling_max_freq()
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, Dietmar.Eggemann@arm.com,
        peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 at 11:30, Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 10/10/22 10:15, Vincent Guittot wrote:
> > On Mon, 10 Oct 2022 at 11:02, Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >>
> >>
> >> On 10/10/22 06:39, Viresh Kumar wrote:
> >>> Would be good to always CC Scheduler maintainers for such a patch.
> >>
> >> Agree, I'll do that.
> >>
> >>>
> >>> On 30-09-22, 10:48, Lukasz Luba wrote:
> >>>> When the new max frequency value is stored, the task scheduler must
> >>>> know about it. The scheduler uses the CPUs capacity information in the
> >>>> task placement. Use the existing mechanism which provides information
> >>>> about reduced CPU capacity to the scheduler due to thermal capping.
> >>>>
> >>>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >>>> ---
> >>>>    drivers/cpufreq/cpufreq.c | 18 +++++++++++++++++-
> >>>>    1 file changed, 17 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >>>> index 1f8b93f42c76..205d9ea9c023 100644
> >>>> --- a/drivers/cpufreq/cpufreq.c
> >>>> +++ b/drivers/cpufreq/cpufreq.c
> >>>> @@ -27,6 +27,7 @@
> >>>>    #include <linux/slab.h>
> >>>>    #include <linux/suspend.h>
> >>>>    #include <linux/syscore_ops.h>
> >>>> +#include <linux/thermal.h>
> >>>>    #include <linux/tick.h>
> >>>>    #include <linux/units.h>
> >>>>    #include <trace/events/power.h>
> >>>> @@ -718,6 +719,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> >>>>    static ssize_t store_scaling_max_freq
> >>>>    (struct cpufreq_policy *policy, const char *buf, size_t count)
> >>>>    {
> >>>> +    unsigned int frequency;
> >>>> +    struct cpumask *cpus;
> >>>>       unsigned long val;
> >>>>       int ret;
> >>>>
> >>>> @@ -726,7 +729,20 @@ static ssize_t store_scaling_max_freq
> >>>>               return -EINVAL;
> >>>>
> >>>>       ret = freq_qos_update_request(policy->max_freq_req, val);
> >>>> -    return ret >= 0 ? count : ret;
> >>>> +    if (ret >= 0) {
> >>>> +            /*
> >>>> +             * Make sure that the task scheduler sees these CPUs
> >>>> +             * capacity reduction. Use the thermal pressure mechanism
> >>>> +             * to propagate this information to the scheduler.
> >>>> +             */
> >>>> +            cpus = policy->related_cpus;
> >>>
> >>> No need of this, just use related_cpus directly.
> >>>
> >>>> +            frequency = __resolve_freq(policy, val, CPUFREQ_RELATION_HE);
> >>>> +            arch_update_thermal_pressure(cpus, frequency);
> >>>
> >>> I wonder if using the thermal-pressure API here is the right thing to
> >>> do. It is a change coming from User, which may or may not be
> >>> thermal-related.
> >>
> >> Yes, I thought the same. Thermal-pressure name might be not the
> >> best for covering this use case. I have been thinking about this
> >> thermal pressure mechanism for a while, since there are other
> >> use cases like PowerCap DTPM which also reduces CPU capacity
> >> because of power policy from user-space. We don't notify
> >> the scheduler about it. There might be also an issue with virtual
> >> guest OS and how that kernel 'sees' the capacity of CPUs.
> >> We might try to use this 'thermal-pressure' in the guest kernel
> >> to notify about available CPU capacity (just a proposal, not
> >> even an RFC, since we are missing requirements, but issues where
> >> discussed on LPC 2022 on ChromeOS+Android_guest)
> >
> > The User space setting scaling_max_freq is a long scale event and it
> > should be considered as a new running environnement instead of a
> > transient event. I would suggest updating the EM is and capacity orig
> > of the system in this case. Similarly, we rebuild sched_domain with a
> > cpu hotplug. scaling_max_freq interface should not be used to do any
> > kind of dynamic scaling.
>
> I tend to agree, but the EM capacity would be only used in part of EAS
> code. The whole fair.c view to the capacity_of() (RT + DL + irq +
> thermal_pressure) would be still wrong in other parts, e.g.
> select_idle_sibling() and load balance.
>
> When we get this powerhint we might be already in overutilied state
> so EAS is disabled. IMO other mechanisms in the task scheduler
> should be also aware of that capacity reduction.

That's why I also mentioned the capacity_orig
