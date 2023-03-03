Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52AA86A9EEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjCCSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjCCSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:35:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA1C14E;
        Fri,  3 Mar 2023 10:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677868498; x=1709404498;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YavG9SzN7R2V9f06OiIdyohGAgtDlBxsdq17qor+UyE=;
  b=joVYnowMZa4NdX4IUnLgCqm77L1bPaNazN4DZw2Q9UkbFS2M3XuZoyBX
   q9Gv66HA/9d3kY/EgH0XZpEGjlx4lsRYigZNNUFEQkyIWU1JZHK7dyNs9
   Bm1MI/Q0t17dDmxwoGZahFonoI7O02BAnsmGlR+qx43OViITauVSeudFQ
   5cuoGOsHXGkBii5RRewA9jCzqWERezNNEIseBk1HZmh6Dwi1lzFaiDUot
   pizgmdXm+PvRVKYuOwOa8eLTrio5HDedmM/T+mNfGGyqiXDZ2Ji89onzW
   lYKnuifsPXuwL5NCF0KSlUWpYf9piEqAuHnGtcSorE+rf3zHDhNi+NlTV
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399931576"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399931576"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 10:34:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675456279"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="675456279"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.209.141.249]) ([10.209.141.249])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 10:34:41 -0800
Message-ID: <4dabd301-32d7-968e-e048-8135b072a7b5@intel.com>
Date:   Fri, 3 Mar 2023 11:34:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 4/4] docs: perf: Minimal introduction the the CXL PMU
 device and driver.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, will@kernel.org, dan.j.williams@intel.com,
        bwidawsk@kernel.org, ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
 <20230303175022.10806-5-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230303175022.10806-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/23 10:50 AM, Jonathan Cameron wrote:
> Very basic introduction to the device and the current driver support
> provided. I expect to expand on this in future versions of this patch
> set.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> --
> v1:
> - Add docs for how to use a Vendor Defined Counter.
> RFC:
> - I'll post separately about this shortly, but it seems very odd
>    to me that there is no way to assign a parent to an event_sources
>    device.  As a result we get the messy approach of playing match
>    the name to figure out what the CPMU instance is connected to.

Would it be too awkward to encode the parent name into the cpmu name?

> ---
>   Documentation/admin-guide/perf/cxl.rst   | 65 ++++++++++++++++++++++++
>   Documentation/admin-guide/perf/index.rst |  1 +
>   2 files changed, 66 insertions(+)
> 
> diff --git a/Documentation/admin-guide/perf/cxl.rst b/Documentation/admin-guide/perf/cxl.rst
> new file mode 100644
> index 000000000000..46235dff4b21
> --- /dev/null
> +++ b/Documentation/admin-guide/perf/cxl.rst
> @@ -0,0 +1,65 @@
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
> +The CPMU driver register a perf PMU with the name cpmu<id> on the CXL bus.
> +
> +    /sys/bus/cxl/device/cpmu<id>
> +
> +The associated PMU is registered as
> +
> +   /sys/bus/event_sources/devices/cpmu<id>
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
> +  cpmu0/clock_ticks/                                 [Kernel PMU event]
> +  cpmu0/d2h_req_itomwr/                              [Kernel PMU event]
> +  cpmu0/d2h_req_rdany/                               [Kernel PMU event]
> +  cpmu0/d2h_req_rdcurr/                              [Kernel PMU event]
> +  -----------------------------------------------------------
> +
> +  $# perf stat -e cpmu0/clock_ticks/ -e cpmu0/d2h_req_itowrm/
> +
> +Vendor specific events may also be available and if so can be used via
> +
> +  $# perf stat -e cpmu0/vid=VID,gid=GID,mask=MASK/
> +
> +The driver does not support sampling. So "perf record" and attaching to
> +a task are unsupported.
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9de64a40adab..f60be04e4e33 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -21,3 +21,4 @@ Performance monitor support
>      alibaba_pmu
>      nvidia-pmu
>      meson-ddr-pmu
> +   cxl
