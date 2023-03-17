Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A046BEA35
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 14:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCQNh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 09:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjCQNhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 09:37:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A82CC307;
        Fri, 17 Mar 2023 06:37:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PdQ8D1Y2tz6JB4q;
        Fri, 17 Mar 2023 21:34:04 +0800 (CST)
Received: from localhost (10.48.148.142) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 17 Mar
 2023 13:37:11 +0000
Date:   Fri, 17 Mar 2023 13:37:10 +0000
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
Message-ID: <20230317133710.00007d48@Huawei.com>
In-Reply-To: <20230206065146.645505-2-zhanjie9@hisilicon.com>
References: <20230206065146.645505-1-zhanjie9@hisilicon.com>
        <20230206065146.645505-2-zhanjie9@hisilicon.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.148.142]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2023 14:51:43 +0800
Jie Zhan <zhanjie9@hisilicon.com> wrote:

> Document the overview and usage of HiSilicon PMCU.
> 
> HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
> PMU accesses from CPUs, handling the configuration, event switching, and
> counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
> and multi-PMU-event CPU profiling, in which scenario the current 'perf'
> scheme may lose events or drop sampling frequency. With PMCU, users can
> reliably obtain the data of up to 240 PMU events with the sample interval
> of events down to 1ms, while the software overhead of accessing PMUs, as
> well as its impact on target workloads, is reduced.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>

Nice documentation. I've read this a few times before, but on this read
through wondered if we could say anything about the skew between capture
of the counters.  Not that important though so I'm happy to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

though this may of course need updating significantly as the interface
is refined (the RFC question you raised for example in the cover letter).

Thanks

Jonathan

> ---
>  Documentation/admin-guide/perf/hisi-pmcu.rst | 183 +++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst     |   1 +
>  2 files changed, 184 insertions(+)
>  create mode 100644 Documentation/admin-guide/perf/hisi-pmcu.rst
> 
> diff --git a/Documentation/admin-guide/perf/hisi-pmcu.rst b/Documentation/admin-guide/perf/hisi-pmcu.rst
> new file mode 100644
> index 000000000000..50d17cbd0049
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/hisi-pmcu.rst
> @@ -0,0 +1,183 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================================
> +HiSilicon Performance Monitor Control Unit
> +==========================================
> +
> +Introduction
> +============
> +
> +HiSilicon Performance Monitor Control Unit (PMCU) is a device that offloads
> +PMU accesses from CPUs, handling the configuration, event switching, and
> +counter reading of core PMUs on Kunpeng SoC. It facilitates fine-grained
> +and multi-PMU-event CPU profiling, in which scenario the current ``perf``
> +scheme may lose events or drop sampling frequency. With PMCU, users can
> +reliably obtain the data of up to 240 PMU events with the sample interval
> +of events down to 1ms, while the software overhead of accessing PMUs, as
> +well as its impact on target workloads, is reduced.
> +
> +Each CPU die is equipped with a PMCU device. The PMCU driver registers it as a
> +PMU device, named as ``hisi_pmcu_sccl<N>``, where ``<N>`` is the corresponding
> +CPU die ID. When triggered, PMCU reads event IDs and pass them to PMUs in all
> +CPUs on the CPU die it is on. PMCU then starts the counters for counting
> +events, waits for a time interval, and stops them. The PMU counter readings are
> +dumped from hardware to memory, i.e. perf AUX buffers, and further copied to
> +the ``perf.data`` file in the user space. PMCU automatically switches events
> +(when there are more events than available PMU counters) and completes multiple
> +rounds of PMU event counting in one trigger.
> +
> +Hardware overview
> +=================
> +
> +On Kunpeng SoC, each CPU die is equipped with a PMCU device. PMCU acts like an
> +assistant to access the core PMUs on its die and move the counter readings to
> +memory. An overview of PMCU's hardware organization is shown below::
> +
> +                                +--------------------+
> +                                |       Memory       |
> +                                | +------+ +-------+ |
> +                   +--------+   | |Events| |Samples| |
> +                   |  PMCU  |   | +------+ +-------+ |
> +                   +---|----+   +---------|----------+
> +                       |                  |
> +        =======================================================  Bus
> +                   |                         |               |
> +        +----------|----------+   +----------|----------+    |
> +        | +------+ | +------+ |   | +------+ | +------+ |    |
> +        | |Core 0| | |Core 1| |   | |Core 0| | |Core 1| |    |
> +        | +--|---+ | +--|---+ |   | +--|---+ | +--|---+ |  (More
> +        |    +-----+----+     |   |    +-----+----+     |  clusters
> +        | +--|---+   +--|---+ |   | +--|---+   +--|---+ |  ...)
> +        | |Core 2|   |Core 3| |   | |Core 2|   |Core 3| |
> +        | +------+   +------+ |   | +------+   +------+ |
> +        |    CPU Cluster 0    |   |    CPU Cluster 1    |
> +        +---------------------+   +---------------------+
> +
> +On Kunpeng SoC, a CPU die is formed of several CPU clusters and several
> +CPUs per cluster. PMCU is able to access the core PMUs in these CPUs.
> +The main job of PMCU is to fetch PMU event IDs from memory, make PMUs count the
> +events for a while, and move the counter readings back to memory.
> +
> +Once triggered, PMCU performs a number of loops and processes a number of
> +events in each loop. It fetches ``nr_pmu`` events from memory at a time, where
> +``nr_pmu`` denotes the number of PMU counters to be used in each CPU. The
> +``nr_pmu`` events are passed to the PMU counters of all CPUs on the CPU die
> +where PMCU resides. Then, PMCU starts all the counters, waits for a period,
> +stops all the counters, and moves the counter readings to memory, before
> +handling the next ``nr_pmu`` events if there are more events to process in this
> +loop. The number of loops and ``nr_pmu`` are determined by the driver, whereas
> +the number of events to process depends on user inputs. The counters are
> +stopped when PMCU reads counters and switches events, so there is a tiny time
> +window during which the events are not counted.

I'm not clear from this description whether there is 'skew' between the counters
(beyond the normal issues from uarch).  Does the PMCU stop all counters
then read them all (minimizing skew) or does it stop each CPUs set of counters
and read those, or stop each individual counter before reading?

My impression is that this feature is meant to be left running over timescales
much longer than the sampling period so it may not be necessary to align the
different lines on the resulting graphs perfectly.  Hence maybe this doesn't matter.

> +
> +Usage
> +=====
> +
> +The PMCU driver is designed to operate with the kernel perf_event framework,
> +specifically with perf AUX trace buffer to dump sample data faster. User space
> +usage of PMCU is supported through the 'perf' tool and root access is required.
> +
> +Steps:
> +
> +1. Write PMU event IDs to PMCU's ``sysfs`` event interface. The event IDs should
> +   be hexadecimal and separated by whitespaces.
> +
> +   An example command can be::
> +
> +        echo "0x10 0x11" > /sys/devices/hisi_pmcu_sccl3/user_events
> +
> +   Alternatively, users can directly write the ``user_events`` file with a text
> +   editor.
> +
> +   Please note that:
> +
> +   - As PMCU passes event IDs to core PMUs, any event IDs supported by the core
> +     PMU are acceptible.
> +   - Users can enter up to 240 events; any events beyond that are ignored.
> +   - The event IDs remain unchanged until the next update of the file, such that
> +     users do not have to enter the event IDs every time before issuing a
> +     ``perf-record`` command for the same events.
> +
> +2. Profiling with ``perf-record``.
> +
> +   The command to start the sampling is::
> +
> +        perf record -e hisi_pmcu_sccl3/<configs>/
> +
> +   Users can pass the following optional parameters to ``<configs>``:
> +
> +   - nr_sample: number of samples to take. This defaults to 128.
> +   - sample_period_ms: time interval in microseconds for PMU counters to keep
> +     counting for each event. This defaults to 3, i.e. 3ms, and its max
> +     value is 85,899, i.e. 85 seconds.
> +   - pmccfiltr: bits 31-24 of the sysreg PMCCFILTR_EL0, which controls how the
> +     cycle counter increments. This defaults to 0x00. Please refer to the
> +     "Performance Monitors external register descriptions" of *Arm Architecture
> +     Reference Manual for A-profile architecture* on how to configure
> +     PMCCFILTR_EL0.
> +
> +   An example command can be::
> +
> +        perf record -e hisi_pmcu_sccl3/nr_sample=1000,sample_period_ms=1000/
> +
> +3. Obtain the sample data
> +
> +   When the ``perf-record`` command finishes, data will be stored in the AUX
> +   area of ``perf.data``. The data can be viewed with ``perf-report`` or
> +   ``perf-script`` with the ``-D`` dump trace option, e.g.::
> +
> +        perf report -D
> +
> +   Users may search the keyword ``HISI PMCU`` to navigate to the PMCU data
> +   section.
> +
> +   PMCU samples are arranged in the following format::
> +
> +        +------------+  +- +--------+  +- +-----------+  +- +------------+
> +        |AUX buffer 0|->|  |Sample 1|->|  |Subsample 1|->|  |CID1SR      |--+
> +        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
> +        |AUX buffer 1|  |  |Sample 2|  |  |Subsample 2|  |  |CID2SR      |  |
> +        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
> +        |...         |  |  |...     |  |  |...        |  |  |Event 0     |  |
> +        +------------+  |  +--------+  |  +-----------+  |  +------------+  |
> +                        |  |  Gap   |  |  |Subsample N|  |  |Event 1     |  |
> +                        +- +--------+  +- +-----------+  |  +------------+  |
> +                                                         |  |...         |  |
> +                                                         |  +------------+  |
> +                                                         |  |Event nr_pmu|  |
> +                                                         |  +------------+  |
> +                                                         |  |Cycle count |  |
> +                                                         +- +------------+  |
> +        +-------------------------------------------------------------------+
> +        |  +- +------------------+  +- +---------+
> +        +->|  |CPU 0 in a cluster|->|  |Cluster 0|
> +           |  +------------------+  |  +---------+
> +           |  |CPU 1 in a cluster|  |  |Cluster 1|
> +           |  +------------------+  |  +---------+
> +           |  |CPU 2 in a cluster|  |  |Cluster 2|
> +           |  +------------------+  |  +---------+
> +           |  |...               |  |  |...      |
> +           +- +------------------+  +- +---------+
> +
> +   The data may contain one or more AUX buffers. An AUX buffer contains many
> +   samples, and may probably leave a gap at the buffer tail where there is no
> +   space for a complete sample. The number of samples in all AUX buffers sums
> +   up to the 'nr_sample' parameter passed from the 'perf-record' command.
> +
> +   A sample contains the events entered in the ``users_events`` sysfs file. A
> +   sample may consist of multiple subsamples if the number of events is more
> +   than the number of PMU counters used, i.e. ``nr_pmu``. The number of
> +   subsamples in a sample, ``N``, equals to a round up of the number of event
> +   divided by ``nr_pmu``.
> +
> +   A subsample consists of data fields of CID1SR, CID2SR, ``nr_pmu`` event
> +   counter readings, and a cycle counter reading. CID1SR and CID2SR are a copy
> +   of PMCID1SR and PMCID2SR on capture of the event counters, which reflects
> +   the process ID, provided that the kernel compiling configuration
> +   ``CONFIG_PID_IN_CONTEXTIDR`` is enabled. The size of CID1SR or CID2SR is 4
> +   bytes, whereas the size of an event or cycle count is 8 bytes. A data field
> +   has the data from all CPUs. The order of CPUs in a data field is 'CPU ID in
> +   a cluster' -> 'cluster ID'. For example, a CPU die with 32 CPUs in 4
> +   clusters (8 CPUs per cluster) has the data field ordered in::
> +
> +       CPU [0,8,16,24],[1,9,17,25],[2,10,18,26],...,[7,15,23,31]
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 793e1970bc05..f132838145f9 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -8,6 +8,7 @@ Performance monitor support
>     :maxdepth: 1
>  
>     hisi-pmu
> +   hisi-pmcu
>     hisi-pcie-pmu
>     hns3-pmu
>     imx-ddr

