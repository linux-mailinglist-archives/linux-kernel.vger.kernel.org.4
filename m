Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2F66C7DCC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjCXMOj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCXMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:14:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090236A40;
        Fri, 24 Mar 2023 05:14:35 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PjgzF1z9Pz67MCd;
        Fri, 24 Mar 2023 20:11:05 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 24 Mar
 2023 12:14:32 +0000
Date:   Fri, 24 Mar 2023 12:14:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jie Zhan <zhanjie9@hisilicon.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <john.g.garry@oracle.com>, <james.clark@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <corbet@lwn.net>, <zhangshaokun@hisilicon.com>,
        <shenyang39@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <prime.zeng@huawei.com>,
        <suntao25@huawei.com>, <jiazhao4@hisilicon.com>,
        <linuxarm@huawei.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
Subject: Re: [RFC PATCH v1 1/4] docs: perf: Add documentation for HiSilicon
 PMCU
Message-ID: <20230324121431.000034c4@Huawei.com>
In-Reply-To: <2d366bef-a891-6ee7-28bf-2091e0b78dbc@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
        <20230206065146.645505-2-zhanjie9@hisilicon.com>
        <20230317133710.00007d48@Huawei.com>
        <2d366bef-a891-6ee7-28bf-2091e0b78dbc@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 17:32:15 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> On 17/03/2023 21:37, Jonathan Cameron wrote:
> > On Mon, 6 Feb 2023 14:51:43 +0800
> > Jie Zhan <zhanjie9@hisilicon.com> wrote:
> >  
> >> Document the overview and usage of HiSilicon PMCU.
> >>
> >> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
> >> PMU accesses from CPUs, handling the configuration, event switching, and
> >> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
> >> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
> >> scheme may lose events or drop sampling frequency. With PMCU, users can
> >> reliably obtain the data of up to 240 PMU events with the sample interval
> >> of events down to 1ms, while the software overhead of accessing PMUs, as
> >> well as its impact on target workloads, is reduced.
> >>
> >> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>  
> > Nice documentation. I've read this a few times before, but on this read
> > through wondered if we could say anything about the skew between capture
> > of the counters.  Not that important though so I'm happy to add
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > though this may of course need updating significantly as the interface
> > is refined (the RFC question you raised for example in the cover letter).
> >
> > Thanks
> >
> > Jonathan
> >  
> >> ---
> >>   Documentation/admin-guide/perf/hisi-pmcu.rst | 183 +++++++++++++++++++
> >>   Documentation/admin-guide/perf/index.rst     |   1 +
> >>   2 files changed, 184 insertions(+)
> >>   create mode 100644 Documentation/admin-guide/perf/hisi-pmcu.rst
> >>
> >> diff --git a/Documentation/admin-guide/perf/hisi-pmcu.rst b/Documentation/admin-guide/perf/hisi-pmcu.rst
> >> new file mode 100644
> >> index 000000000000..50d17cbd0049
> >> --- /dev/null
> >> +++ b/Documentation/admin-guide/perf/hisi-pmcu.rst
> >> @@ -0,0 +1,183 @@
> >> +.. SPDX-License-Identifier: GPL-2.0
> >> +
> >> +==========================================
> >> +HiSilicon Performance Monitor Control Unit
> >> +==========================================
> >> +
> >> +Introduction
> >> +============
> >> +
> >> +HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
> >> +PMU accesses from CPUs, handling the configuration, event switching, and
> >> +counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
> >> +and multi-PMU-event CPU profiling, in which scenario the current ``perf``
> >> +scheme may lose events or drop sampling frequency. With PMCU, users can
> >> +reliably obtain the data of up to 240 PMU events with the sample interval
> >> +of events down to 1ms, while the software overhead of accessing PMUs, as
> >> +well as its impact on target workloads, is reduced.
> >> +
> >> +Each CPU die is equipped with a PMCU device. The PMCU driver registers it as a
> >> +PMU device, named as ``hisi_pmcu_sccl<N>``, where ``<N>`` is the corresponding
> >> +CPU die ID. When triggered, PMCU reads event IDs and pass them to PMUs in all
> >> +CPUs on the CPU die it is on. PMCU then starts the counters for counting
> >> +events, waits for a time interval, and stops them. The PMU counter readings are
> >> +dumped from hardware to memory, i.e. perf AUX buffers, and further copied to
> >> +the ``perf.data`` file in the user space. PMCU automatically switches events
> >> +(when there are more events than available PMU counters) and completes multiple
> >> +rounds of PMU event counting in one trigger.
> >> +
> >> +Hardware overview
> >> +=================
> >> +
> >> +On Kunpeng SoC, each CPU die is equipped with a PMCU device. PMCU acts like an
> >> +assistant to access the core PMUs on its die and move the counter readings to
> >> +memory. An overview of PMCU's hardware organization is shown below::
> >> +
> >> +                                +--------------------+
> >> +                                |       Memory       |
> >> +                                | +------+ +-------+ |
> >> +                   +--------+   | |Events| |Samples| |
> >> +                   |  PMCU  |   | +------+ +-------+ |
> >> +                   +---|----+   +---------|----------+
> >> +                       |                  |
> >> +        =======================================================  Bus
> >> +                   |                         |               |
> >> +        +----------|----------+   +----------|----------+    |
> >> +        | +------+ | +------+ |   | +------+ | +------+ |    |
> >> +        | |Core 0| | |Core 1| |   | |Core 0| | |Core 1| |    |
> >> +        | +--|---+ | +--|---+ |   | +--|---+ | +--|---+ |  (More
> >> +        |    +-----+----+     |   |    +-----+----+     |  clusters
> >> +        | +--|---+   +--|---+ |   | +--|---+   +--|---+ |  ...)
> >> +        | |Core 2|   |Core 3| |   | |Core 2|   |Core 3| |
> >> +        | +------+   +------+ |   | +------+   +------+ |
> >> +        |    CPU Cluster 0    |   |    CPU Cluster 1    |
> >> +        +---------------------+   +---------------------+
> >> +
> >> +On Kunpeng SoC, a CPU die is formed of several CPU clusters and several
> >> +CPUs per cluster. PMCU is able to access the core PMUs in these CPUs.
> >> +The main job of PMCU is to fetch PMU event IDs from memory, make PMUs count the
> >> +events for a while, and move the counter readings back to memory.
> >> +
> >> +Once triggered, PMCU performs a number of loops and processes a number of
> >> +events in each loop. It fetches ``nr_pmu`` events from memory at a time, where
> >> +``nr_pmu`` denotes the number of PMU counters to be used in each CPU. The
> >> +``nr_pmu`` events are passed to the PMU counters of all CPUs on the CPU die
> >> +where PMCU resides. Then, PMCU starts all the counters, waits for a period,
> >> +stops all the counters, and moves the counter readings to memory, before
> >> +handling the next ``nr_pmu`` events if there are more events to process in this
> >> +loop. The number of loops and ``nr_pmu`` are determined by the driver, whereas
> >> +the number of events to process depends on user inputs. The counters are
> >> +stopped when PMCU reads counters and switches events, so there is a tiny time
> >> +window during which the events are not counted.  
> > I'm not clear from this description whether there is 'skew' between the counters
> > (beyond the normal issues from uarch).  Does the PMCU stop all counters
> > then read them all (minimizing skew) or does it stop each CPUs set of counters
> > and read those, or stop each individual counter before reading?
> >
> > My impression is that this feature is meant to be left running over timescales
> > much longer than the sampling period so it may not be necessary to align the
> > different lines on the resulting graphs perfectly.  Hence maybe this doesn't matter.
> >  
> Thanks for pointing this out.
> 
> The PMCU stops all the counters before reading any counters (i.e. the 
> first case you said).
> 
> The basic procedure is:
>      start counters -> wait -> stop counters -> read and reset counters 
> -> switch events -> start counters -> ...  
> where each step applys to all CPUs and counters.

Great. So this is across all cores on a die so skew should be minimized
(at a cost of missing more events than a skew heavy approach).

> 
> The counters don't count during the tiny stop-start window.
> I guess a small improvement would be: reset -> read -> switch -> reset 
> -> ..., while the counters keep running,  
> but we still lose some event counts between read and reset, and thus, no 
> fundamental differrence.

Lots of ways to reduce both skew and missed counts, but I think you are
right in that none of them matter for the intended long term monitoring
usecase.

Jonathan

> 
> Regards,
> Jie

