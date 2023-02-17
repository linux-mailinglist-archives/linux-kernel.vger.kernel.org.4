Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2C169A390
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 02:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjBQBqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 20:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBQBqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 20:46:44 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111A3A85D;
        Thu, 16 Feb 2023 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676598403; x=1708134403;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5TNNmVjvaNwcoerx/S2br45zoxST70T0g51Qp0m7+xg=;
  b=k1/xVkZ93duNEZxnivJgDAXgrkaSI2xteTHmnXXYWrosHkDnyhbHrdFD
   GRViWhRuYR5t0gGtpMsiA5G7+A/bedBU1DN3q0hlsxzybDbFdSA6l8H0L
   XwY7T4AQVH3k4ulM4vyQumE4T9Bfks4vQdm6PD0H5drLFzICBqrsGUpMY
   5goBdnpd970spx2hCYG6ANl87xDgny754mn72LWuMwfKrVUxeOeeHSEXD
   rhDpl2veXddM087B/IrGKhV9+c8Fy/Gj/4iOGT2gPLFAkH6oHzL3MU+rB
   MY46QvIECGFO70CBoq/2XY33DzrtvwcfAM6tSZAUGP6prMLxvE1y0DOFf
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="334088042"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="334088042"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 17:46:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="999287254"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="999287254"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Feb 2023 17:46:41 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 17:46:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 17:46:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 17:46:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlZ/Xe9gMRauqdfIUQ5ar//4mOJfSi4/NbCLnwW7xAAyqnc7izQmSGJSD8cuuToMwdz55bWIEUZW1owuQBKAJAVrK0ikCr1F9GzdGzoMLTwXi6DiYMwdtnUfSuEEJqJbAgO3nM9SdlE/OWQSOZsIYQxSYj4ANDuW6vJEzDE/39OEIqUhV7GDty0qM0Y1IDydLJptrmzIovjjoYI3EXKOs8T/sQRzkA20JFEwYEzoMLQZ6NI0gkQhve8gy5dZXchEVO42VwzWfR929TSnmDmPF77X+XlgTqDDgic2C0mvDMKQFdO0iTZU+Oy6kbajmOh8Vkvhoo6DNGjnw5syAhpk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwGWCODTGJ2D4fn21JAkdfKDiIFBLdChMHukS/sEcus=;
 b=mFPntxQU1E0XrlsZotG2oiOgUc6h4LaTYQZJ1kMjMezzJjMo0t8mJG83mqAXIbE0lyW9T5QYYE4vJUjO6t2zWUjrZKSpfoN9clOOVttt2CpMUCJ6eK0ZMclmbQa2sTKQFvEA8qb04XhIW1SadqC/0FV66sSzbSV6AtclJWMgSrgWHKGrCEsq5S5AUfAItQ7l7lWLvogaGrxnOH+CK6OTmU1s6N9XfyfRiumcO71NEdz1t9tD0PftSeS+dV2AZVI7mEGn/dMhZ+svBOok2IsxygnwIjn/hCNGUBJbmCiwjyd+Xl9YUnGu7iG/L6TQyvyRCMtRx0Ieg1WskKWRw+kxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by BN9PR11MB5244.namprd11.prod.outlook.com (2603:10b6:408:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21; Fri, 17 Feb
 2023 01:46:36 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::16c0:1ae3:13ee:c40e%8]) with mapi id 15.20.5986.018; Fri, 17 Feb 2023
 01:46:36 +0000
Message-ID: <0b42ee96-32cf-b929-6033-7898821b54cb@intel.com>
Date:   Thu, 16 Feb 2023 17:46:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [RFC v2 PATCH 6/7] x86/resctrl: Display the RMID and COSID for
 resctrl groups
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, <reinette.chatre@intel.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>
References: <167537433143.647488.9641864719195184123.stgit@bmoger-ubuntu>
 <167537445137.647488.9039585071837467840.stgit@bmoger-ubuntu>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <167537445137.647488.9039585071837467840.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|BN9PR11MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: c81e47ab-82a2-46fe-edea-08db1088cdcf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyZ/guy+/1YEL3+6Y9asvXVelIa5h2a+CZHH82IQLkY0yGB3qLhN/Ex1VWxiJBXLt8Co1w/fw0xOoQH6HBSdIqQCngPBB9pfWu78CMYsxMcYnBOsx48zRNIfHVX6bUsEwYAsNz2ke5ri+3Wm445c9mvB+p42bDst8V5AHWAlKyC4c70S4xGUzmjtl4O1aR4VjUwA4q0rhrndYooKyfAmByW5w9LtYIzfT49NQ1fN2nhkdEPDK2SOujqjYb6AcgBgGAuYQ3wPPq8rIrZyXciOOb9Bz69fWzQC3hHQsDGyoMGaH2zoBpIFzvqi9ULQ4FdVl50YZOrTMSIm/WVz1E86kHeBOdX8/BE+NXXk118L8ipx0qVf9/nKOfRDVsTL8/y2xO+miIBeBm2Ul86HNmWEtnbJT0l4rvjTKQ4u+QdadopjA7kYSULL+oH638Ooht3XmkJzUJF+IFP8Pxo+GEHbz4MRiqySnFU+kuZGCjcV3ktvd/X0VDNOen60/eVZFNQnh82h1Ojlh0KT7Ha/Xl6txuAmtG0+KqA3Cy74pxph9j8vtEdd3ERsbe8tGk++a85zfepDxcuLoI/1bYALV3MV2YTD0QQz9rTvYCQhU1Eoo0yivH7/XGzuI7ZTSD+9FGufsTBy5G90OezRzZGSKpkSy0LtzatQRNXofzjfBU4i9HvgIJlYYXtIjDmCEGli/hbRL6tdiyEYklF+v3rMgHRkgBA2LcYkkdAyC2Zck7+/wMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(346002)(136003)(366004)(39860400002)(451199018)(6512007)(26005)(66476007)(31696002)(38100700002)(8936002)(86362001)(66556008)(8676002)(4326008)(186003)(7416002)(66946007)(36756003)(6506007)(41300700001)(6666004)(5660300002)(6486002)(6636002)(316002)(83380400001)(478600001)(44832011)(2616005)(82960400001)(53546011)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhhTm9SR3pFb3J5Vmp0dk1NVFFWNHMvVUFuMmdEVHNGYy9XM1N3c1dOUGlZ?=
 =?utf-8?B?SzNTMUs1QTNuUVgvemZvQm1rN2dDUmVzbUw0OUg4YXM5NU80ZTZGeU9LNzdX?=
 =?utf-8?B?WFdPTjJ6bXFVNStxRDBEWlhDc2swUUNuVnJYZWt6Y3FwcnZ5RjROMDhKQmJv?=
 =?utf-8?B?eWRJaWNtUkNhWG9ET2tCNFprUlkrVzZqWnE1cUlianhENUw0Znd0M0tDeUVn?=
 =?utf-8?B?T3E3RFZlSVdFK0crcEpYY3MyK2laN0xWbFJiV2ZVNnBqSjZkbUIvMk1RWGRX?=
 =?utf-8?B?MjgyWFdmTkczTld1NytOeXpLWXk1TytJTzBmQ0F3NitFdDJBODdxcE1zWDhx?=
 =?utf-8?B?SnpRb3Bza1pjcWhSdG1SQ1BncXNUeXU3QTlzRW5GZUpzeU9DbEtXbDdsNm1r?=
 =?utf-8?B?RjYyemNmVTRBTVlhZDljdjZaR0hIY3ArMHVVQVZ2cjZXOHB0c24wanQxVytx?=
 =?utf-8?B?ZlFGQlM5Q256R0xoOXkwY2toMGlXMGpVWFpGV21Vbk9HWWQyRk03Njl5UGdP?=
 =?utf-8?B?dnY5UWRoWnRVcDRZcEFUa0tzRHJJNTh2U010ODdHaHI0MllLSHRRR3QrbEQv?=
 =?utf-8?B?RWJtbDVjRFd0ZlNSMXFodEdvbVhMUkpGRXNRVDhINCtEOW9lQ2s4Z2R5c1hQ?=
 =?utf-8?B?U3ZGS3Q1Sm5iN21jaGoxckZzRm1LZDhvVlorMmdYdTBSbkliL2V6NTFHY0NE?=
 =?utf-8?B?VlY0bzBhNmhwdkMxM2hLY2kxcUdGUGtKdkJ1ZU1sMEhISUpFRjFBUlRGN1hE?=
 =?utf-8?B?aDVodzdwTjRtODRRV3FjSVBtdnMrNzEyTzR2b254YzR4UndpUnpLNlBJUVlH?=
 =?utf-8?B?bytoUVl0T1NGMkIxQXQrVVFtQ2tWd2VsU25JdEtwOWx3V3hUK3Y5bXpOUGNm?=
 =?utf-8?B?cjZhV1FpM0RQZkJyN0hqcE1rV2hMOGZSUWZjRjJFcXNZNUdmRTVQQTFKa0Fk?=
 =?utf-8?B?Y0JsMkxIcE5KSlF6SEFCVms5eGhDbEg2RVNYQmlrUWtGZHhMbnJ6R3p3YTdK?=
 =?utf-8?B?RFgvRTZQank0ZG1WNDB4Wm1aN3NCWnE3V1JiU2Q0UWgvUHFVWlJQUktiMGRC?=
 =?utf-8?B?cVYxME8wSDFReUFISHhLYzZCbHRqd01UZFNhMTkvWFZEVy9xSHVaQ0JLZklx?=
 =?utf-8?B?elJKSFRUbzYxV0ZKbFVWNUlsbTNBK004RkVOSWtoNzEyaXExbUYwdG53blVi?=
 =?utf-8?B?ZkRJZ2lIbUJyVEJRbXNjTmRHOTRXb3VBc25VOUUwNnZJKy9NNnhrV3NTNnRm?=
 =?utf-8?B?QTZVUHNOOHFFQjZHa0lsSngvKzZ5cDdtdHQ2Z3NuNEVSTDF3OEtOUkp3aFFj?=
 =?utf-8?B?WGZOVVlpa1FCUHZGZndZZ2h5UE9hUmdUbDE1cTZMSkJ5ODNwTkRPY0JXVW5p?=
 =?utf-8?B?VzhveDVaRXdwd1dESHVTKzBVRW9vZ1FrNUU3OUxtWlhLWWhYeVo4eW5SS1Bv?=
 =?utf-8?B?eW5kU0YxWFRqT0hPMDNTSStJUDlNRUMwcXBpQVhudGVaKzZ0WFBSUGlISUVM?=
 =?utf-8?B?VjdxUTZvb0hVZmFEeTkzd2dseGV5L2VhWUdtVEVkZlRDdWNVdkpzU1dsWEVW?=
 =?utf-8?B?ejZKbnN0OFJQQXY4RS9xL2NmSDRqOXVpRm9SWklsdmE0UmNKU1EvUklwb3Bk?=
 =?utf-8?B?dU5kRVpDSnRwdGlBdVB1QXBjRExJYTVPWmQwNjVxYm8xTC9HMkZZMzdIYndV?=
 =?utf-8?B?RHhQSE1xZ3o5THVYN0RQbjYyNmMwcEJsZU5rakltQm8xcTJjUEhTd2VyWU9P?=
 =?utf-8?B?d1NoclF4N0hrUVl2OUFLSURQckN0VHovb0MzMEF2Y2NLZ2d2OTFKVmtJZWM4?=
 =?utf-8?B?YUpLSWMyV2ZKVUZzL21haGxMYVhFUDh2TlhMWTVyUUhwNUFTMXFUQ1F5bzBH?=
 =?utf-8?B?WWFPWTc4ZCtVcXlmQXl3Y2JHUkN1c1lKMk5VWDhWTHdOb3R2SUNlaDltMG4x?=
 =?utf-8?B?VmpuOFRsWUp2R0syb01qUUlsdjFnems2b1RZR2tZNkJqS3BHYkVzalE0dVVy?=
 =?utf-8?B?RXF2eFJtMUdibG5jUE52eXpiQ2pSTG9xNmowTTVySmZ4blpBT3poNjh4RmRp?=
 =?utf-8?B?WUxmaUdVREszdTJCZnBkV2R3NWFLUkx5Q3NCdzBsYnh3ZytGRjh0Wk5iZnJo?=
 =?utf-8?Q?xxgNuWrjevy77egRo2q/hNXH4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c81e47ab-82a2-46fe-edea-08db1088cdcf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 01:46:35.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kCumGZhUPdHNQHhZxAAXb3Qr2gMNCOdtpceg8QhqHjzK+3zdBxB2OjGgSNA2G2o3QuKscfjbe5gBfHH5bN1ZqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5244
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Babu,

On 2/2/23 13:47, Babu Moger wrote:
> When a user creates a control or monitor group, the CLOSID or RMID
> are not visible to the user. These are architecturally defined entities.
> There is no harm in displaying these in resctrl groups. Sometimes it
> can help to debug the issues.
> 
> Add CLOSID and RMID to the control/monitor groups display in resctrl
> interface.
> 
> $cat /sys/fs/resctrl/clos1/closid
> 1
> $cat /sys/fs/resctrl/mon_groups/mon1/rmid
> 3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>   Documentation/x86/resctrl.rst          |   17 ++++++++++++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |   44 ++++++++++++++++++++++++++++++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/Documentation/x86/resctrl.rst b/Documentation/x86/resctrl.rst
> index 2c013c5d45fd..de332c242523 100644
> --- a/Documentation/x86/resctrl.rst
> +++ b/Documentation/x86/resctrl.rst
> @@ -321,6 +321,15 @@ All groups contain the following files:
>   	Just like "cpus", only using ranges of CPUs instead of bitmasks.
>   
>   
> +"rmid":
> +        Available only with debug option.Reading this file shows the
> +        resource monitoring id (RMID) for monitoring the resource

Capitals Resource Monitoring ID (RMID).

> +        utilization. Monitoring is performed by tagging each core(or
> +        thread) or process via a Resource Monitoring ID (RMID). Kernel

s/Resource Monitoring ID (RMID)/RMID/

> +        assigns a new RMID when a group is created depending on the
> +        available RMIDs. Multiple cores(or threads) or processes can
> +        share a same RMID in a resctrl domain.
> +
>   When control is enabled all CTRL_MON groups will also contain:
>   
>   "schemata":
> @@ -342,6 +351,14 @@ When control is enabled all CTRL_MON groups will also contain:
>   	file. On successful pseudo-locked region creation the mode will
>   	automatically change to "pseudo-locked".
>   
> +"closid":
> +        Available only with debug option. Reading this file shows the
> +        Class of Service (CLOS) id which acts as a resource control tag
> +        on which the resources can be throttled. Kernel assigns a new
> +        CLOSID a control group is created depending on the available
> +        CLOSIDs. Multiple cores(or threads) or processes can share a
> +        same CLOSID in a resctrl domain.
> +
>   When monitoring is enabled all MON groups will also contain:
>   
>   "mon_data":
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 9b7813aa6baf..c35d91b04de6 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -760,6 +760,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>   	return ret;
>   }
>   
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +				struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->closid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>   #ifdef CONFIG_PROC_CPU_RESCTRL
>   
>   /*
> @@ -1844,6 +1876,18 @@ static struct rftype res_common_files[] = {
>   		.seq_show	= rdtgroup_size_show,
>   		.fflags		= RFTYPE_BASE_CTRL,
>   	},
> +	{
> +		.name		= "closid",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,
> +	},
> +	{
> +		.name		= "rmid",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,
> +	},
>   
>   };
>   
> 
> 
Thanks.

-Fenghua
