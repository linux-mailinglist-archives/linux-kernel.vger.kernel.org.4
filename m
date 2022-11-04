Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8E6191CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 08:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKDHYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiKDHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 03:24:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A227B2A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667546686; x=1699082686;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BJq1A/EKLEHT0tTJlDFbql0dNf03hV7BuO0BifLUBx4=;
  b=EDlNuCRYeeJYIiPUmCGAeWF/NLXYP8zJ7n/p/+34yn4+FjG+fLyLZ67b
   Ckl1rAmTSmY9XxJarab35o+QuyG7kJVsHd5xuxtQk8pO7NFxFY/rX8TwJ
   ZGgbuHGnGnEzqeKLSXsePP65xMtRHd+4SM2oCejh73qOTedWT01Ds3bq8
   KOzOa+2JTcsO01qWXdhZ/XUR9XoSPQPxMEvC7akyXnj/IWzqza/IZ8LfT
   T8n0/ZWSg4oE9nJ6SMrJW4Ll874kPvbeW3+F5zdwrhavIsK+fx4qRvsZi
   O2B9J6duIq9sf028QFmP8pWPKr7g0tH6GqsE2qd+PZn1VkRInnpLJDyhQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="336602070"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="336602070"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 00:24:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="634996021"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="634996021"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 04 Nov 2022 00:24:44 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 00:24:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 00:24:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 00:24:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npNUYaL+rrNWqUU4+UYWQvE8AQj5WOIALmJW659P8Ac5YCWJXYXMw9NAafR68ShXqejXkZm3Q/C2+RPGNlpc7sZBFlWbl/tdug6YLUH9L/CJ3ytEkIupV+dR5FNtQ1KxPvLt9++G12UwVBGJz+49LcdzPDL53xvhZBTKxSc8ieP0s7fJCnw073uFdLJ33YieOLYZ1jCqbIX6b6UX0cA9oecOAv8kx0ASiuE2ppltOu4LmHtrkVdf35s6nLwKKbWFpwVIvEEnQHz94UqXNSIHtCIwjUgmBKke0WrzVVR/9GGiojcLAuqBDVX0QNCmF0u7/vmsg1tBqypURd0Zn+WKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhoaJC9xKD6P42G3WKCpvFkCpjxLG0AqIPGOvEOyN+4=;
 b=dY2PgBEZA156WEn8kY2dsLPt8ktir4Ejr2NgvJQlY/e2gcMCpKqpFO6Lkvc/jGjhzSECXJIgXlZR1qvzWYhg0/HBCWX+X+0na9v+a0FQC+P1mGh/ctbvfBI1YQfeX/Y/U2elG4iGWBBq0YPrJnFXs/sBVbQqrH9YM/+uogz7qPdsyoDT9HlgfECvo+OIJ5AXRzbsQN+VFG97z7l/4G0Yb4wCh8sennAPldiZzhmtIYpKUCpy62YwHcztlofc94ujmYXdlJcFhJncdh7sXnvOFpFLtTVC/VKgSl+0CUGPHhc6g9Ikxpl1iAIPHFNPdMBTA5Hswj8M6aElAQO0y/P5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA3PR11MB7536.namprd11.prod.outlook.com (2603:10b6:806:320::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 07:24:41 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5769.021; Fri, 4 Nov 2022
 07:24:41 +0000
Date:   Fri, 4 Nov 2022 15:21:29 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tim.c.chen@intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <liaoyu15@huawei.com>, <oliver.sang@intel.com>,
        <ying.huang@intel.com>
Subject: Re: [PATCH v1 1/2] x86/tsc: use logical_package as a better
 estimation of socket numbers
Message-ID: <Y2S9eTeOch+TYmks@feng-clx>
References: <20221021062131.1826810-1-feng.tang@intel.com>
 <f27e4b3f858890c657df9a7d6f34dc2d60b89757.camel@intel.com>
 <63dca468-c94d-844a-5b19-09c03cf84911@intel.com>
 <Y1ZArguS/rVEjXOb@feng-clx>
 <397f513f-9273-76d1-a0ba-9d1d403020c5@intel.com>
 <Y1eW2L5y7jx69v0g@feng-clx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y1eW2L5y7jx69v0g@feng-clx>
X-ClientProxiedBy: SG2PR02CA0105.apcprd02.prod.outlook.com
 (2603:1096:4:92::21) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA3PR11MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5639dbda-32e3-4bf1-cca8-08dabe35a391
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hda3yZtb2WKlmRMS4/Atju3vlQwyxNzxA5g3G1etK1k3/z8Np+6QLGtc93ANFcHQAuHKDvurdUewB7yxIIK+MYNioiTYw3uVm5CClKKzFcUPRqTeEvX0JkUgvlTTJet6oMi8rC/uFk6tiwOoLbJSjsybM0YgTO4C1vOVKWSN/PG6UjQ4g8/9PSfFYHlG/CYP1ODBNN69KbhKANWvkZpFvbUPJBUQBOrhRCL4l2Ft+ti+VzTZYNj4DkSXZvfz7OpiNytM8QVRewWyT7WW9L/LdZcRD1/2Y4COwnPiRLz5TmqRIoa5b/SEoaMRcMDTWjBjpaMZCfxaW7bYQm1AjbbIoBFA7aQNDhNU1UvUpQi7PopmIfJN1gI7bpvffXy6+kY1gdZIHtR1gfGPVJnc0MpVILu+ZshFYxGZfObYhx26qkEdjIoUJjLG9HqJCwlGPJ2Xn1am99NGEWzU3sIhCj5wtGsC2v0Y1g4vp++KdEj8v8Z2ogICE/HMvGazbI64ma0pNttwGk7WMpYHtOwWp91nzEw3KSrpwHxrCesfniPAD2DmonnkVPRVfURwxS7W9sUlwqFtTkPz03v7mUmYGMxRqYkLJn6jbLUxgDepLLpxzX1TjWpNm/gYhHBNaNxThjuD2EbjA6EgxuGo8C7utospYrVonSel39qZkQVNDyNzp+Liby8GXWvtV44VIGB2dK2AF7E6FT2YzTkXLrNIY/8QFDDsfWaTnMW6eoS/q/hpEH1PugZ48BQeaZoxik6I037y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199015)(6666004)(107886003)(44832011)(316002)(6512007)(26005)(83380400001)(6506007)(9686003)(8676002)(8936002)(66946007)(478600001)(33716001)(66556008)(66476007)(110136005)(41300700001)(4326008)(186003)(6486002)(86362001)(2906002)(66899015)(82960400001)(38100700002)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yS3OKCsAD4eZnMMKnwBbY3o60n8XFEkh0Kg5oimuX+vEnq2wDrXQkxWnZUly?=
 =?us-ascii?Q?hggKe5lsXGha8aU7R/D/oZXFv4B0uTG13zmzkBUbQgEBPI3+jmtql/FNwL/m?=
 =?us-ascii?Q?KYLNlWdf8kXhLx4HI0mCMEwhFIhJmI6QkHy5xT7hP7CB22HtS3aUd8TvtabF?=
 =?us-ascii?Q?5+WY+TvuUKt6QCQ4BW6z6lMExqGuSGBow1h6+qRqyCEDnCctepoNp4CgEGW4?=
 =?us-ascii?Q?9brj7tZuOWRQ3ZVDhLEJeDmDfucjMn/9dfZmTQfTHLTknxzk8h4YbdIk8rOb?=
 =?us-ascii?Q?gLmi6eS/1GG8+wmrB7GScSs5us8szWQ/+LpRs51oWITUR7L5fqH9M00lSgHE?=
 =?us-ascii?Q?CyB9Mh7aT8Pvx7QbEJkQDmCoJ0stfmct6FfSyEHSeIy8KuZ932/rR262znsf?=
 =?us-ascii?Q?/KbRFq/ijZS5EwxBIKT7nN8J06O8T5tjZQg6fEO1SxZbkgwNvlQoeOTu/oLu?=
 =?us-ascii?Q?qqIWhnggPN+DR3vNswJA2oG14USDnfskwth1+OeXf37h3ATCUvU//KTJ0W6Z?=
 =?us-ascii?Q?rnM5joiNWqNg+pfEiUc6K/LnYQUMC13Z/NSNKVvV9aqWVnKQxDtZhfP55NPI?=
 =?us-ascii?Q?lcIGCnGuYz04tO1Iltu934rN3HgKleZErOsm6EJAqDaW138FVlAeyoqEh3jF?=
 =?us-ascii?Q?K+hDdF8RLysQ3xYRBdYRtLf4aOr3NKcdfIMg0JV/egjEiKf+DHIAev5OKuCR?=
 =?us-ascii?Q?Jy+Ndpl5G43F7rKKVrcPsPtrEXSF+FhDQU0kwHsMmvZfqXaXy4qim+BV3UGp?=
 =?us-ascii?Q?Bf0rEJt1BQVwWnIo3I8mrrSG/sKvv1GIH4vSSIJHdYPgyD1IiISuR1c4vB7B?=
 =?us-ascii?Q?r7NQH11af/KYuFv6xAYTbWjs/j2kN/66Ksn/BTUzSD6PsVsazyewWDskcgUt?=
 =?us-ascii?Q?Fy7wM4+TEAnZil0eb0NOquE7TEgJFIPCYVEkzEvOVF+uJLtqMFf2zrEawtHT?=
 =?us-ascii?Q?RtzQf/9Pf5LuMfKRf5SwLQhuy31mUvpf3+bmOiJ58eVJbTUcr0bClUEn59yC?=
 =?us-ascii?Q?5yT3F4F+y5MdBtg+K/DcqodDKIWqUcmzW5a1Cvj4C6Amh6YbCqODal9gj0d2?=
 =?us-ascii?Q?frT55PWGb/5CqIfld1aeupuXaY27AJtwr/Lqur8L+r2ig2dRtrooPEEq8cIM?=
 =?us-ascii?Q?HHIYv8mChpzUZw4ZVCX9Ww/upjzUuLaAx8ONpl+P6kMSrTcQpjn7hyrWptzS?=
 =?us-ascii?Q?uUDntDuYEQ+ipId0kwwLPQz0DjcKQugLO1dSmD13TvBS5flGQupJBeNZsdVT?=
 =?us-ascii?Q?BaUmynwgXbVFFV+0HWcVF6s2a/wuzpJCZxHX8NHUXKGctsz7kdjX/npygETa?=
 =?us-ascii?Q?NY7bmXl0xQUQvAqYaeNzNN0LDavX/EmJMTIZnP/plp+di0HBaL544eNiz2ym?=
 =?us-ascii?Q?x1oUV9+Np1PXdmYT/IMWd4JjlKgLUmAbQjCmUNTiYfnMOXCLhk8h9vH8NpNe?=
 =?us-ascii?Q?QUEPBRxwLDyG1ip1qL8WBhxAEE+vEkQExJWWp2yXBElgwlra5pcRu0V7VMlm?=
 =?us-ascii?Q?cKIZFmq963W63cTZT3WYZWz4KawePJDjNHO03ZskmWODclEGqdCY/ffH11C1?=
 =?us-ascii?Q?Qx4HzFcif7tkhYcKjDcwYTDWkH6pWc6VWhTgcKxB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5639dbda-32e3-4bf1-cca8-08dabe35a391
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 07:24:41.5475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jgLJ7HGEN7rrZxXQfbIpg5dCmQCGzLyUpTuaCPZASrFN7xqWZzrVMeVVkbBWuMXRoZBwr1ElQtsLIFd07rFHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7536
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 03:57:12PM +0800, Feng Tang wrote:
> On Mon, Oct 24, 2022 at 08:43:33AM -0700, Dave Hansen wrote:
> > That's too wishy-washy.  Also, I *KNOW* Intel has built systems with
> > wonky, opaque numbers of "sockets".  Cascade Lake was a single physical
> > "socket", but in all other respects (including enumeration to software)
> > it acted like two logical sockets.
> > 
> > So, what was the "real" socket number for Cascade Lake?  If you looked
> > in a chassis, you'd see one socket.  But, there were two dies in that
> > socket talking to each other over UPI, so it had a system topology which
> > was indistinguishable from a 2-socket system.
>  
> Good to know and thanks for the info.
> 
> I have to admit I haven't checked a server's internals before, and
> thanks to Oliver for helping checking some Cascade Lake boxes of 0Day.
> 
> In one box where 'lscpu' shows 4 sockets (96 cores in total), it does
> only have 2 physical processors in the chassis, just like you
> mentioned, it has 2 dies for each processor. And in another box,
> 'lscpu' shows 2 sockets (44 cores in total), it also has 2 physical
> processors but with much smaller size.
> 
> And fortunately the 'logical_packages' for these 2 boxes are both
> the correct value: 2.
> 
> > Let's just state the facts:
> > 
> > 	pr_info("Disabling TSC watchdog on %d-package system.", ...)
> > 
> > Then, we can have a flag elsewhere to say how reliable that number is.
> > A taint flag or CPU bug is probably going to far, but something like this:
> > 
> > bool logical_package_count_unreliable = false;
> > 
> > void mark_bad_package_count(char *reason)
> > {
> > 	if (logical_package_count_unreliable)
> > 		return true;
> > 
> > 	pr_warn("processor package count is unreliable");
> > }
> > 
> > Might be OK.  Then you can call mark_bad_package_count() from multiple
> > sites, like the maxcpus= code.
> 
> This should work! we can just add one more check:
> 
> 	boot_cpu_has(X86_FEATURE_TSC_ADJUST) &&
> 	!logical_package_count_unreliable &&
> 	logical_packages <= 2 
> 
> And when some new case leading to a imprecise 'logical_packages' is
> found in future, we could just apply to this to it.

Hi Thomas, Peter and reviewers,

For estimating socket numbers, there are quite some BIOS/kernel
settings that can affect its accuracy, like:

* numa emulation (numa=fake=4 etc.)
* numa=off
* platforms with CPU+DRAM nodes, CPU-less HBM nodes, CPU-less
  persistent memory nodes.
* SNC (sub-numa cluster) mode is enabled
* 'maxcpus=' cmdline limiting onlined CPU numbers

Ideally, BIOS could provide that info in some MSR or through
CPUID, as it knows most of the information before transfering
to OS, but that's just my wishful thinking for now. 

And we checked several ways for estimating socket number:
* nr_online_nodes
* SRAT table init(parsing node with CPUs)
* 'logical_packages'

And 'logical_packages' is a better option after comparison,
as it works for mostof the cases above except 'maxcpus='
one, where the 'logical_package' could be smaller than the
real number. Dave suggested to explicitly skip the check
and warn.

We plan to use 'logical_packages' to replace current
'nr_online_nodes' for estimation of socket number, any thoughts
on this, or some suggestions? thanks!

- Feng



