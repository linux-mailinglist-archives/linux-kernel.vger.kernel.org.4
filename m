Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F16C7B78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCXJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCXJcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:32:23 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50A24BE5;
        Fri, 24 Mar 2023 02:32:17 -0700 (PDT)
Received: from dggpeml500019.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PjcNL6S5nz17P1v;
        Fri, 24 Mar 2023 17:29:06 +0800 (CST)
Received: from [10.67.101.98] (10.67.101.98) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 24 Mar
 2023 17:32:15 +0800
Message-ID: <2d366bef-a891-6ee7-28bf-2091e0b78dbc@hisilicon.com>
Date:   Fri, 24 Mar 2023 17:32:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [RFC PATCH v1 1/4] docs: perf: Add documentation for HiSilicon
 PMCU
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
 <20230206065146.645505-2-zhanjie9@hisilicon.com>
 <20230317133710.00007d48@Huawei.com>
From:   Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20230317133710.00007d48@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.101.98]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2023 21:37, Jonathan Cameron wrote:
> On Mon, 6 Feb 2023 14:51:43 +0800
> Jie Zhan <zhanjie9@hisilicon.com> wrote:
>
>> Document the overview and usage of HiSilicon PMCU.
>>
>> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
>> PMU accesses from CPUs, handling the configuration, event switching, and
>> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
>> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
>> scheme may lose events or drop sampling frequency. With PMCU, users can
>> reliably obtain the data of up to 240 PMU events with the sample interval
>> of events down to 1ms, while the software overhead of accessing PMUs, as
>> well as its impact on target workloads, is reduced.
>>
>> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> Nice documentation. I've read this a few times before, but on this read
> through wondered if we could say anything about the skew between capture
> of the counters.  Not that important though so I'm happy to add
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> though this may of course need updating significantly as the interface
> is refined (the RFC question you raised for example in the cover letter).
>
> Thanks
>
> Jonathan
>
>> ---
>>   Documentation/admin-guide/perf/hisi-pmcu.rst | 183 +++++++++++++++++++
>>   Documentation/admin-guide/perf/index.rst     |   1 +
>>   2 files changed, 184 insertions(+)
>>   create mode 100644 Documentation/admin-guide/perf/hisi-pmcu.rst
>>
>> diff --git a/Documentation/admin-guide/perf/hisi-pmcu.rst b/Documentation/admin-guide/perf/hisi-pmcu.rst
>> new file mode 100644
>> index 000000000000..50d17cbd0049
>> --- /dev/null
>> +++ b/Documentation/admin-guide/perf/hisi-pmcu.rst
>> @@ -0,0 +1,183 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +==========================================
>> +HiSilicon Performance Monitor Control Unit
>> +==========================================
>> +
>> +Introduction
>> +============
>> +
>> +HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
>> +PMU accesses from CPUs, handling the configuration, event switching, and
>> +counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
>> +and multi-PMU-event CPU profiling, in which scenario the current ``perf``
>> +scheme may lose events or drop sampling frequency. With PMCU, users can
>> +reliably obtain the data of up to 240 PMU events with the sample interval
>> +of events down to 1ms, while the software overhead of accessing PMUs, as
>> +well as its impact on target workloads, is reduced.
>> +
>> +Each CPU die is equipped with a PMCU device. The PMCU driver registers it as a
>> +PMU device, named as ``hisi_pmcu_sccl<N>``, where ``<N>`` is the corresponding
>> +CPU die ID. When triggered, PMCU reads event IDs and pass them to PMUs in all
>> +CPUs on the CPU die it is on. PMCU then starts the counters for counting
>> +events, waits for a time interval, and stops them. The PMU counter readings are
>> +dumped from hardware to memory, i.e. perf AUX buffers, and further copied to
>> +the ``perf.data`` file in the user space. PMCU automatically switches events
>> +(when there are more events than available PMU counters) and completes multiple
>> +rounds of PMU event counting in one trigger.
>> +
>> +Hardware overview
>> +=================
>> +
>> +On Kunpeng SoC, each CPU die is equipped with a PMCU device. PMCU acts like an
>> +assistant to access the core PMUs on its die and move the counter readings to
>> +memory. An overview of PMCU's hardware organization is shown below::
>> +
>> +                                +--------------------+
>> +                                |       Memory       |
>> +                                | +------+ +-------+ |
>> +                   +--------+   | |Events| |Samples| |
>> +                   |  PMCU  |   | +------+ +-------+ |
>> +                   +---|----+   +---------|----------+
>> +                       |                  |
>> +        =======================================================  Bus
>> +                   |                         |               |
>> +        +----------|----------+   +----------|----------+    |
>> +        | +------+ | +------+ |   | +------+ | +------+ |    |
>> +        | |Core 0| | |Core 1| |   | |Core 0| | |Core 1| |    |
>> +        | +--|---+ | +--|---+ |   | +--|---+ | +--|---+ |  (More
>> +        |    +-----+----+     |   |    +-----+----+     |  clusters
>> +        | +--|---+   +--|---+ |   | +--|---+   +--|---+ |  ...)
>> +        | |Core 2|   |Core 3| |   | |Core 2|   |Core 3| |
>> +        | +------+   +------+ |   | +------+   +------+ |
>> +        |    CPU Cluster 0    |   |    CPU Cluster 1    |
>> +        +---------------------+   +---------------------+
>> +
>> +On Kunpeng SoC, a CPU die is formed of several CPU clusters and several
>> +CPUs per cluster. PMCU is able to access the core PMUs in these CPUs.
>> +The main job of PMCU is to fetch PMU event IDs from memory, make PMUs count the
>> +events for a while, and move the counter readings back to memory.
>> +
>> +Once triggered, PMCU performs a number of loops and processes a number of
>> +events in each loop. It fetches ``nr_pmu`` events from memory at a time, where
>> +``nr_pmu`` denotes the number of PMU counters to be used in each CPU. The
>> +``nr_pmu`` events are passed to the PMU counters of all CPUs on the CPU die
>> +where PMCU resides. Then, PMCU starts all the counters, waits for a period,
>> +stops all the counters, and moves the counter readings to memory, before
>> +handling the next ``nr_pmu`` events if there are more events to process in this
>> +loop. The number of loops and ``nr_pmu`` are determined by the driver, whereas
>> +the number of events to process depends on user inputs. The counters are
>> +stopped when PMCU reads counters and switches events, so there is a tiny time
>> +window during which the events are not counted.
> I'm not clear from this description whether there is 'skew' between the counters
> (beyond the normal issues from uarch).  Does the PMCU stop all counters
> then read them all (minimizing skew) or does it stop each CPUs set of counters
> and read those, or stop each individual counter before reading?
>
> My impression is that this feature is meant to be left running over timescales
> much longer than the sampling period so it may not be necessary to align the
> different lines on the resulting graphs perfectly.  Hence maybe this doesn't matter.
>
Thanks for pointing this out.

The PMCU stops all the counters before reading any counters (i.e. the 
first case you said).

The basic procedure is:
     start counters -> wait -> stop counters -> read and reset counters 
-> switch events -> start counters -> ...
where each step applys to all CPUs and counters.

The counters don't count during the tiny stop-start window.
I guess a small improvement would be: reset -> read -> switch -> reset 
-> ..., while the counters keep running,
but we still lose some event counts between read and reset, and thus, no 
fundamental differrence.

Regards,
Jie
