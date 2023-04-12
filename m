Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52A6DF7CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDLN40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDLN4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:56:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2B5B93;
        Wed, 12 Apr 2023 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681307766; x=1712843766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wOYRX2P1Olxt8OSP51vtIY2ZC08UBZ8S9H4/Jy+MtSc=;
  b=AFwsQQwNGVGV8GWcOftDx9eSXGuGQeOHu4CwdWEwyiyy41mQJ4KEnY90
   tULfm4NEi5l+XI1gAw63KyGw+W6mv84N6YggKMi0GQEj7QJHWB2QVP0/L
   QVptECSFv+8tR700Uv46yaR3MYvxDRY6NXP+2jaYfCv1a+PtklAXL5Bc1
   HBgZ/XfhxxGBOg/Day3bdsiYKoHuDOFQDIfHYcxpVfnkfvRC0NyEdyDtN
   IyIUD0bFPgrjo4SXCD3h4x5NuFrYnFZQv0S82n/houNU9xQ2VJ6zwyysH
   qnOdp1GlT2EnkU6UfaRnHC0dmG7I1fDIScfi57tK7NA1NmJKPqZLok0bw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="346578112"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="346578112"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="812994213"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="812994213"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 12 Apr 2023 06:56:05 -0700
Received: from [10.251.4.46] (kliang2-mobl1.ccr.corp.intel.com [10.251.4.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 602AB580871;
        Wed, 12 Apr 2023 06:56:04 -0700 (PDT)
Message-ID: <199d58e5-2776-3fbb-9a8b-6d909401bb65@linux.intel.com>
Date:   Wed, 12 Apr 2023 09:56:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v5 5/5] docs: perf: Minimal introduction the the CXL PMU
 device and driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, will@kernel.org
Cc:     mingo@redhat.com, acme@kernel.org, dan.j.williams@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230411185452.23387-1-Jonathan.Cameron@huawei.com>
 <20230411185452.23387-6-Jonathan.Cameron@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230411185452.23387-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-04-11 2:54 p.m., Jonathan Cameron wrote:
> Very basic introduction to the device and the current driver support
> provided. I expect to expand on this in future versions of this patch
> set.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 


Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> --
> v5:
> - Correct final statemnt about sampling support. (Kan)
> - Update CXL PMU MAINTAINERS entry to include this documentation
> - Update device naming to cxl_pmu_memX.Y etc
> ---
>  Documentation/admin-guide/perf/cxl.rst   | 68 ++++++++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst |  1 +
>  MAINTAINERS                              |  1 +
>  3 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
> new file mode 100644
> index 000000000000..2a1c684603bb
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/cxl.rst
> @@ -0,0 +1,68 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +CXL Performance Monitoring Unit (CPMU)
> +======================================
> +
> +The CXL rev 3.0 specification provides a definition of CXL Performance
> +Monitoring Unit in section 13.2: Performance Monitoring.
> +
> +CXL components (e.g. Root Port, Switch Upstream Port, End Point) may have
> +any number of CPMU instances. CPMU capabilities are fully discoverable from
> +the devices. The specification provides event definitions for all CXL protocol
> +message types and a set of additional events for things commonly counted on
> +CXL devices (e.g. DRAM events).
> +
> +CPMU driver
> +===========
> +
> +The CPMU driver registers a perf PMU with the name pmu_mem<X>.<Y> on the CXL bus
> +representing the Yth CPMU for memX.
> +
> +    /sys/bus/cxl/device/pmu_mem<X>.<Y>
> +
> +The associated PMU is registered as
> +
> +   /sys/bus/event_sources/devices/cxl_pmu_mem<X>.<Y>
> +
> +In common with other CXL bus devices, the id has no specific meaning and the
> +relationship to specific CXL device should be established via the device parent
> +of the device on the CXL bus.
> +
> +PMU driver provides description of available events and filter options in sysfs.
> +
> +The "format" directory describes all formats of the config (event vendor id,
> +group id and mask) config1 (threshold, filter enables) and config2 (filter
> +parameters) fields of the perf_event_attr structure.  The "events" directory
> +describes all documented events show in perf list.
> +
> +The events shown in perf list are the most fine grained events with a single
> +bit of the event mask set. More general events may be enable by setting
> +multiple mask bits in config. For example, all Device to Host Read Requests
> +may be captured on a single counter by setting the bits for all of
> +
> +* d2h_req_rdcurr
> +* d2h_req_rdown
> +* d2h_req_rdshared
> +* d2h_req_rdany
> +* d2h_req_rdownnodata
> +
> +Example of usage::
> +
> +  $#perf list
> +  cxl_pmu_mem0.0/clock_ticks/                        [Kernel PMU event]
> +  cxl_pmu_mem0.0/d2h_req_rdshared/                   [Kernel PMU event]
> +  cxl_pmu_mem0.0/h2d_req_snpcur/                     [Kernel PMU event]
> +  cxl_pmu_mem0.0/h2d_req_snpdata/                    [Kernel PMU event]
> +  cxl_pmu_mem0.0/h2d_req_snpinv/                     [Kernel PMU event]
> +  -----------------------------------------------------------
> +
> +  $# perf stat -e cxl_pmu_mem0.0/clock_ticks/ -e cxl_pmu_mem0.0/d2h_req_rdshared/
> +
> +Vendor specific events may also be available and if so can be used via
> +
> +  $# perf stat -e cxl_pmu_mem0.0/vid=VID,gid=GID,mask=MASK/
> +
> +The driver does not support sampling so "perf record" is unsupported.
> +It only supports system-wide counting so attaching to a task is
> +unsupported.
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9de64a40adab..f60be04e4e33 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -21,3 +21,4 @@ Performance monitor support
>     alibaba_pmu
>     nvidia-pmu
>     meson-ddr-pmu
> +   cxl
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 51234eb7858e..29a108afa065 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5178,6 +5178,7 @@ COMPUTE EXPRESS LINK PMU (CPMU)
>  M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/admin-guide/perf/cxl.rst
>  F:	drivers/perf/cxl_pmu.c
>  
>  CONEXANT ACCESSRUNNER USB DRIVER
