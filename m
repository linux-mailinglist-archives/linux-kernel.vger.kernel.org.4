Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787E460FD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 18:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235110AbiJ0QfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 12:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236634AbiJ0QfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 12:35:05 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39D22A72C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:35:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p184so2001172iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 09:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HLefOh5NhDg/V0DYiKtweHjPazNeNhqxETkEz3k4aRc=;
        b=D4wfObtwcTDKQhaF9LYH+eGIicqOyNnl0NWlgpRy9+4ZbDo66n+FLdS8cy/veQjYBx
         nGKAYthy0KHEqbYhZkD/+3nF9TW8sHGgQ6thNVYvT3IeP0z+728C3PtM6spXl3Rv4+2y
         +sX70BAFKXf4mCtDNzPeXIQi+hZP6a3QihL9vrcsoPFEghvQLbW/k8xLdIwpJoYMq5w2
         7a0RVmNtPhCl8DKJg6zvkjakpGC2g7WZcaeddQ1aOsdB2JFqzP49qXu1Wc71FAC6L+xQ
         tfWTxOOv9klc2HVy/EXfObowUDS4w7+cs7JuBSfYMLYmW3i43QJANRvQagukC76vuMVc
         iiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLefOh5NhDg/V0DYiKtweHjPazNeNhqxETkEz3k4aRc=;
        b=xGElMvo75mxksG+X0abo5m+HJ7lWx6M9Q4GJuAo6lGHDGeQAGbidwBz0f/jhAQngvK
         +qkHRNaC/cZ8ATGgeM9suxRL5q6JB7hgOLtyRsJfK2UCcdcdhSpY0tILARdWWwIypS6O
         xV95qtPoCApdAq80ZdcpSqnmCWQt0PRViQ0tAZrbz5qIq076I11Gi3UzgjH7ZDHtsz2Y
         j5g6p4aMIzVTkriDKrFzr1IbuhAdQqkXAxbTL0Pl+u4AVKYgNFGKvn9l/QvSAW7sFQe+
         kpo3qRQEmvW3QmJvqJtDPxq2Cw+62RAnvI+d4uT9Qtz0i8r7Pmh9Re2iVaLoZknlKTVn
         CJ5A==
X-Gm-Message-State: ACrzQf2J7tw8VEGcbRQHIwmz3rE1MU6s0ndopz33KUN6RQGi03V29k3F
        E8iIxjR/xb1Y/Eqc01lVwdhQVp827iN0BnnfLY7vig==
X-Google-Smtp-Source: AMsMyM5350GByy6hopE+SFdid2RVWv/INbnFXHQsYknru0Vzu23+0M3tWA6v+W4RtMtNbvkRJXuOVrWF3+8nd7Lsga0=
X-Received: by 2002:a05:6602:150c:b0:6bc:ae87:d6ae with SMTP id
 g12-20020a056602150c00b006bcae87d6aemr27824891iow.99.1666888500980; Thu, 27
 Oct 2022 09:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220925143908.10846-1-vincent.guittot@linaro.org>
 <cd48ebbb-9724-985f-28e3-e558dea07827@amd.com> <CAKfTPtC-yMUNfnGa8a4HrT-Onf4SZfRHDKyQcDZYnzhpPOk=Xw@mail.gmail.com>
 <89a5eeaa-4c5a-db6d-2c52-6dcb951d3a10@amd.com>
In-Reply-To: <89a5eeaa-4c5a-db6d-2c52-6dcb951d3a10@amd.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Oct 2022 18:34:47 +0200
Message-ID: <CAKfTPtCFxM8a+9XMCRMdBE0QLr2trHUN+im58Kz+74g9bQH0Lw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] Add latency priority for CFS class
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org,
        Gautham Shenoy <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,

On Tue, 25 Oct 2022 at 08:36, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> I've rerun some tests with a different configuration with more
> contention for CPU and I can see a linear behavior. Sharing the
> results below.
>
> On 10/13/2022 8:54 PM, Vincent Guittot wrote:
> >
> > [..snip..]
> >>
> >> o Hackbench and Cyclictest in NPS1 configuration
> >>
> >> perf bench sched messaging -p -t -l 100000 -g 16&
> >> cyclictest --policy other -D 5 -q -n -H 20000
> >>
> >> -----------------------------------------------------------------------------------------------------------------
> >> |Hackbench     |      Cyclictest LN = 19        |         Cyclictest LN = 0       |      Cyclictest LN = -20    |
> >> |LN            |--------------------------------|---------------------------------|-----------------------------|
> >> |v             |   Min  |   Avg   |  Max        |     Min  |   Avg   |  Max       |     Min  |   Avg   |  Max   |
> >> |--------------|--------|---------|-------------|----------|---------|------------|----------|---------|--------|
> >> |0             |  54.00 |  117.00 | 3021.67     |    53.67 |  65.33  | 133.00     |    53.67 |  65.00  | 201.33 |  ^
> >> |19            |  50.00 |  100.67 | 3099.33     |    41.00 |  64.33  | 1014.33    |    54.00 |  63.67  | 213.33 |
> >> |-20           |  53.00 |  169.00 | 11661.67    |    53.67 |  217.33 | 14313.67   |    46.00 |  61.33  | 236.00 |  ^
> >> -----------------------------------------------------------------------------------------------------------------
> >
> > The latency results look good with Cyclictest LN:0 and hackbench LN:0.
> > 133us max latency. This suggests that your system is not overloaded
> > and cyclictest doesn't really compete with others to run.
>
> Following is the result of running cyclictest alongside hackbench with 32 groups:
>
> perf bench sched messaging -p -l 100000 -g 32&
> cyclictest --policy other -D 5 -q -n -H 20000
>
> ----------------------------------------------------------------------------------------------------------
> | Hackbench   |      Cyclictest LN = 19      |      Cyclictest LN = 0        |    Cyclictest LN = -20    |
> | LN          |------------------------------|-------------------------------|---------------------------|
> |             |   Min  |   Avg   |  Max      |   Min  |   Avg   |   Max      |   Min  |  Avg  |   Max    |
> |-------------|--------|---------|-----------|--------|---------|------------|--------|-------|----------|
> | 0           |  54.00 |  165.00 | 6899.00   |  22.00 |  85.00  |  3294.00   |  23.00 | 64.00 |  276.00  |
> | 19          |  53.00 |  173.00 | 3275.00   |  40.00 |  60.00  |  2276.00   |  13.00 | 59.00 |  94.00   |
> | -20         |  52.00 |  293.00 | 19980.00  |  52.00 |  280.00 |  14305.00  |  53.00 | 95.00 |  5713.00 |
> ----------------------------------------------------------------------------------------------------------
>
> I see a spike for Max in (0, 0) configuration and the latency decreases
> monotonically with lower latency nice value.

Your results looks good

>
> >
> >>
> >> o Hackbench and schbench in NPS1 configuration
> >>
> >> perf bench sched messaging -p -t -l 1000000 -g 16&
> >> schebcnh -m 1 -t 64 -s 30s
> >>
> >> ------------------------------------------------------------------------------------------------------------
> >> |Hackbench     |   schbench LN = 19         |        schbench LN = 0         |       schbench LN = -20     |
> >> |LN            |----------------------------|--------------------------------|-----------------------------|
> >> |v             |  90th  |  95th  |  99th    |   90th  |  95th   |  99th      |   90th  |   95th   | 99th   |
> >> |--------------|--------|--------|----------|---------|---------|------------|---------|----------|--------|
> >> |0             |  4264  |  6744  |  15664   |   17952 |  32672  |  55488     |   15088 |   25312  | 50112  |
> >> |19            |  288   |  613   |  2332    |   274   |  1015   |  3628      |   374   |   1394   | 4424   |
> >> |-20           |  35904 |  47680 |  79744   |   87168 |  113536 |  176896    |   13008 |   21216  | 42560  |   ^
> >> ------------------------------------------------------------------------------------------------------------
> >
> > For the schbench, your test is 30 seconds long which is longer than
> > the duration of perf bench sched messaging -p -t -l 1000000 -g 16&
> >
> > The duration of the latter varies depending of latency nice value so
> > schbench is disturb more time in some cases
>
> I've rerun this with hackbench running 128 groups alongside schbench
> with 2 messenger and 1 worker each. With larger worker count, I still
> see non-monotonic behavior in 99th percentile latency of schbench.
> I also see number of latency samples collected by schbench to vary
> over the 30 second run for different latency nice values which could
> also pay a part in seeing the unexpected behavior. For lower worker
> count, I see the number of samples collected is similar. Following
> is the configuration and the latency reported by schbench:
>
> perf bench sched messaging -p -t -l 150000 -g 128&
> schbench -m 2 -t 1 -s 30s
>
> Note: In all cases, hackbench runs longer than schbench.
>
> -------------------------------------------------------------------------------------------------
> | Hackbench |     schbench LN = 19       |      schbench LN = 0      |     schbench LN = -20    |
> | LN        |----------------------------|---------------------------|--------------------------|
> |           |  90th  |  95th  |  99th    |  90th  |  95th  |  99th   |  90th  |  95th  |  99th  |
> |-----------|--------|--------|----------|--------|--------|---------|--------|--------|--------|
> | 0         |  42    |  92    |  2972    |  26    |  49    |  2356   |  9     |  11    |  20    |
> | 19        |  35    |  424   |  4984    |  13    |  390   |  5096   |  8     |  10    |  14    | ^
> | -19       |  144   |  3516  |  110208  |  61    |  807   |  34880  |  25    |  39    |  295   |
> -------------------------------------------------------------------------------------------------
>
> I see 90th and 95th percentile latency decrease monotonically with
> latency nice value of schbench (for a fixed latency nice value of
> hackbench) but there are cases where 99th percentile latency
> reported by schbench may not strictly decrease with lower latency
> nice value (Marked with ^)
>
> Note: Only a small number of bad samples can affect the 99th
> percentile latency for the above configuration. The monotonic
> behavior in 90th and 95th percentile latency is a good data point
> to show latency nice is indeed working as expected.

Yes, I think you are right that the 99th percentile is not stable
enough because it can be impacted by a small number of bad samples

>
> If there is any specific workload you would like me to run on the
> test system, or any additional data you would like for above
> workloads, please do let me know.

Thanks a lot for your tests.
I'm about to send v6

>
> --
> Thanks and Regards,
> Prateek
