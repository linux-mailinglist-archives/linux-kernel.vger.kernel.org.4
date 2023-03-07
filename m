Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DBC6AE65F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjCGQXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCGQXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:23:14 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33A9AA01;
        Tue,  7 Mar 2023 08:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678206131; x=1709742131;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qEjxqCSJ8PPyCUX8TqtU7LzyV+Hxlz+cYXbal7Q9vmk=;
  b=cI1iGs5U6/xiNhFs7iW8IPyw0K17pO/kL4sMevx1PyMjGSOGggn3KCn3
   Jx+FffrAflrc9NRqHPAiUYRVBIJY2gtMQV3xcdFk26qikEeKjrWYrqhyy
   PhyIQYSI9bRTbrDUsz3Xkw43ueamTquo7fy3PwhzI5DhYkd/DoUqBQcDC
   brrypRAEorW8ssr4gi9fTjhegwRxHQxYHUYUkwrScDvHGxsT9b1wH3H4/
   e3i0sXVgA2X81+A+ju8DlaX5KYVMg0SXIlBy1DnQPfIHZkFOMFheoEqWP
   nBuy3/CBNaJrZpZTxPxxg/Z8X1EZHUGidd3c6DC+zFnwUsfLE/x/MX6UY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="400717428"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="400717428"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:22:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="626593990"
X-IronPort-AV: E=Sophos;i="5.98,241,1673942400"; 
   d="scan'208";a="626593990"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 07 Mar 2023 08:22:06 -0800
Received: from [10.209.30.169] (kliang2-mobl1.ccr.corp.intel.com [10.209.30.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 8D416580377;
        Tue,  7 Mar 2023 08:21:58 -0800 (PST)
Message-ID: <70691ba4-f2ea-3d82-6c15-2f8e01151b90@linux.intel.com>
Date:   Tue, 7 Mar 2023 11:21:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/4] cxl: CXL Performance Monitoring Unit driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        dan.j.williams@intel.com, bwidawsk@kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        linuxarm@huawei.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230303175022.10806-1-Jonathan.Cameron@huawei.com>
 <20230303175022.10806-4-Jonathan.Cameron@huawei.com>
 <b766b4ca-1255-3b33-864c-0e7f9ab00e15@linux.intel.com>
 <20230306144124.00006b94@Huawei.com>
 <52abbd9a-3a63-3dde-c20f-99787225200e@linux.intel.com>
 <20230307091936.000055be@Huawei.com>
Content-Language: en-US
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230307091936.000055be@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-03-07 4:19 a.m., Jonathan Cameron wrote:
>>> A hybrid approach of exposing the VID / GID / Mask sets to userspace that
>>> then deals with pretty naming etc would work though.
>>>
>>> For summed events we also don't have enough information without similar
>>> exports of VID / GID / Mask.
>>>
>>> We can't use the fact that events are exposed which 'might' be summable in
>>> hardware because we may have only subsets supported by the hardware.
>>>
>>> E.g.
>>>
>>> VID / GID / Mask
>>>
>>> 19e5 / 1 / 0x1
>>> 19e5 / 1 / 0xe
>>>
>>> etc 
>>>
>>> There are going to be a lot of CXL device implementations so I think we need
>>> to find a sensible interface to pass this information to perf tool.
>>>
>>> Currently I'm thinking a new sysfs ABI that has
>>>
>>> event_groupX_vid, event_groupX_gid, event_groupX_msk, event_groupX_fixed 
>>> with one set of entries for every event group.
>>>
>>> Using that, perf tool can apply various rules to figure out sensible subsets
>>> to advertise.
>>>  
>> Usually, we only hardcode the generic/architectural or some widely used
>> events in the kernel. The perf tool should be the place for the vender
>> specific/device specific events.
>>
>> We may not want to expose the counter constraints information to the
>> user space. It's better to keep the information in the kernel. We can
>> use it to check whether the user input is valid in the event_init.
>>
>> For a specific device, the constraint information should be fixed. We
>> may create a dedicate event list file in perf tool for each device.
>>
>> For example, with your example, you can define the below events in the
>> event list file. (just demonstrate the idea. It should be in JSON format
>> in the file.)
>> Event Name / VID / GID / Mask
>> A          / 19e5 / 1 / 0x1
>> B          / 19e5 / 1 / 0x2
>> C          / 19e5 / 1 / 0x4
>> D          / 19e5 / 1 / 0x8
>> BC         / 19e5 / 1 / 0x6
>> BD         / 19e5 / 1 / 0xa
>> CD         / 19e5 / 1 / 0xc
>> BCD        / 19e5 / 1 / 0xe
>>
>> perf stat -e BD will give you the summed event B + D.
> To me, that seems to be a non starter.  We will have 100s to 1000s of
> device variants, each of which may have several instances of CPMU with
> different events. The available events on some devices will be
> firmware version dependent.
> 
> The explosion in json files will rapidly become unmanageable.

OK. I agree.

> Given PMU capabilities are fully discoverable we should use that.
> 
> We'd then need json to describe what groups make sense, but not which
> ones the particular hardware supports.  Thus we'd need one set of
> data for a particular VID/GID pair, instead of one for every device
> with it's own mix of multiple masks for each VID/GID pair.
> 
> In a similar fashion to metrics, not all combinations are likely to be
> useful things to measure so we can describe just the ones that seem
> reasonable.
> 

It sounds reasonable. There will be a JSON file which includes all the
reasonable combinations of VID/GID/mask. We can decide the available one
at runtime, e.g., perf list will only list the available events/metrics.

Thanks,
Kan
