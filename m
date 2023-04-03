Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B2A6D4F84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjDCRt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjDCRtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:49:10 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB242107;
        Mon,  3 Apr 2023 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680544107; x=1712080107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v25kyqtNN8d8QRdIbwVdDGXVyNuQYtW+0hay97cNYhQ=;
  b=h5b+QuOkGA51RwLHIDSBz9KN83UfhQdGo37sgq7fl2tV8QuhKSduVy5I
   bkzdNRXo0zzKGbrjRZxtyvgIDfr1+oNNwfwzXxtDrxxoTn74bTMy+sVv8
   QU+G41wCt9UID/3KHGPGmvE7cOzCAP5sPWn+rQ5fnhToOSthwyrsd2RP+
   XpYt6BsPU+BS2MYQ5f/+pm1nq2Re5AmMmKwdpJV/cI9O+FUJ0YrCcs/Kl
   HNM41rUlSp9xeETrJCciGhgtla7r5Un5LsH33zyw7FexME+vJ8ZCSYPcs
   BZMk8XZbXyBYz7l5lOEtEghA74aRMRYZtk3rVDNcl7vUihJdjBLRHPKX8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="339465232"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="339465232"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 10:45:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="1015804705"
X-IronPort-AV: E=Sophos;i="5.98,315,1673942400"; 
   d="scan'208";a="1015804705"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2023 10:45:55 -0700
Received: from [10.212.177.123] (kliang2-mobl1.ccr.corp.intel.com [10.212.177.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07CD45804D9;
        Mon,  3 Apr 2023 10:45:53 -0700 (PDT)
Message-ID: <bf9ef54d-65da-ce59-3b47-f3dc29a5e052@linux.intel.com>
Date:   Mon, 3 Apr 2023 13:45:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 5/5] docs: perf: Minimal introduction the the CXL PMU
 device and driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org, peterz@infradead.org
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        will@kernel.org, dan.j.williams@intel.com, linuxarm@huawei.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>
References: <20230330164556.31533-1-Jonathan.Cameron@huawei.com>
 <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230330164556.31533-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-30 12:45 p.m., Jonathan Cameron wrote:
> Very basic introduction to the device and the current driver support
> provided. I expect to expand on this in future versions of this patch
> set.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> --
> v4: No change
> ---
>  Documentation/admin-guide/perf/cxl.rst   | 65 ++++++++++++++++++++++++
>  Documentation/admin-guide/perf/index.rst |  1 +
>  2 files changed, 66 insertions(+)
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

The PMU only supports system-wide counting. That's the reason it doesn't
support per-task profiling. Not because of missing sampling.

Thanks,
Kan
> diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
> index 9de64a40adab..f60be04e4e33 100644
> --- a/Documentation/admin-guide/perf/index.rst
> +++ b/Documentation/admin-guide/perf/index.rst
> @@ -21,3 +21,4 @@ Performance monitor support
>     alibaba_pmu
>     nvidia-pmu
>     meson-ddr-pmu
> +   cxl
