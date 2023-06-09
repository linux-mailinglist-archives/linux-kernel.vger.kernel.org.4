Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2D1729789
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbjFIKvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjFIKv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:51:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AD2B9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 03:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686307887; x=1717843887;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PL+9lCQtHb/INUgbNRON44FvMSKbQmZbjSVt+Ox9r0U=;
  b=P2AUco5MJUwhBWrOYoSDBUNNr6OffL98b7KkbfAfBrKS7kr9chbCJQCV
   DixQcIr/nL+CBexrEszt3hf0nbgt5l/8ZZey82SQRxQHegKmgMODbH3Av
   erVpnkUZGRXaGlXavQ9vP+SCDBgHPbajqsswUgLDyWZCo4LDk8HnLy9J0
   qh+sckOJSC4XKag0uzJBM9SSvcsnRyMyKDYkgQAu8AT/z5yWWxoolkd2k
   kgcTxTyQlcC+dvzbaCnteWePXR7sIUV23tQMNnFMn6CsDkzX/Scg+M42u
   mvKUwJ5lYabG8zMs8SGXR/JfXAT+EXcuBijlvpz5cYMjyyoEpeyN4Okfm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="356462343"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="356462343"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 03:51:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="800184694"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="800184694"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jun 2023 03:51:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 9 Jun 2023 03:51:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 9 Jun 2023 03:51:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 9 Jun 2023 03:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmFVCbybQWZ4f1+sANAaMEGBMO/8Lkf9Ob1yHn++6PpmUL0j3SVeWjwym9hua6br9moZHbM082qJYmC22XwK+1Yz58HszthN4Xm41yAq/haWx9eQ1JgshyK40fgfUQ2mpM3IcS8k20WeqsQgjVfB9Mgp9sAdUekzymkw2ra/+o3QVGYZ8lfStEtBfYEJKmgW4nkHxDCy+MTKsU7iUJ6gmMOp77T1uhzYQwLPF1CJe6oBleOx5dBrJ4kZL+64e7u6zUCgeToHW00zDsxGIC1/MTgysKLzbx160KMFl1+tpHyGEOm4LQZ+F3VfAOCSKXf/F9QxdErLCIC00+MuiMzrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3c1g5fFdHFWMB3QexB4k18rcIqBB6SA+/kmS23jlYo=;
 b=BbEIdsntd4J62mboeotCOToAmcuIOMP9lmJGmO7lXmHWm3w/jCLCv7Wd3S+A/ei8T9rZJzxR97/6bnAYyeCZMbsgD1zXJNMjNtF+z1IZOsQWBfLtX0syUDBYUn68wSTCGpA1too9f/AsJZP1JjvigwDd6p4wMu3DXDspl02J7xDGgo2hwOBYOpaV65urXLrTx5CkIB6vdjvlqn+2E0yYDwYX3QF/hGHJqzJkXPkEqWTfqQrYi8i8jdxoERuC8NBYINAT0j5paxbC6wcazQwRD8537rbJWTLvHvnk9y+KaHhyOoROwPOCEIEqVLPYQ/RpsJRSiFbQKEeSCXjooC7O3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 10:51:23 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::17da:2dd:f920:ef03%4]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:51:23 +0000
Date:   Fri, 9 Jun 2023 18:50:58 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, Peter Zijlstra <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>,
        Barry Song <baohua@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH v8 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <ZIMEEnozzC+Uyluv@chenyu5-mobl2.ccr.corp.intel.com>
References: <20230530070253.33306-1-yangyicong@huawei.com>
 <20230530070253.33306-3-yangyicong@huawei.com>
 <20230530115527.GC156198@hirez.programming.kicks-ass.net>
 <8fcba5d4-eea5-d7c4-2bf7-482321b333b7@huawei.com>
 <ce714341-af58-2522-69a8-321f02c82893@huawei.com>
 <ZIFKf2PkIkiRmUaK@chenyu5-mobl2.ccr.corp.intel.com>
 <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <85e29dd8-60f6-1e84-b3e4-061e5a2a0037@huawei.com>
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f20ec48-eca5-4b03-939f-08db68d776b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8RteuiMBAzXEh2T0XhsDiW/ZQaLA3eOJeOpjRvfupyI8bOPCxkSRkHwvOHwh6N+j2LdNh37CDGIGILZogncO86oiJpG6ZCvD6N/B0W8fb6Y+IDPmek+n4koZNjymTOSOm2b781v7nnoQxU8BRFTL4B54YuEX/rFQKQXRn2PWDdHTZr09cNJvRHptop3Vx4+22fp/9DXOS7aMO1A3zIJCYqAXheCfL3Te1PaRYLNtG/o3FOSr5g+DyE4J6HoRbqWcweuCtY0oFv8sglB28rkJRwytDKJP7i8a3Yb0rSlMBWiCGasT6icRwOdpiC/FX7TSFCnKK/wt4Po+EXCcAZoODoBaD4h6BDJXXp6YQ1OPXU0x+R32Dep0o8gxWKnRXrhb0Aj0VhZY1Yj//5bVx4p9BNKlXPWauGnOkhsYAkros4cFvr0Y6TozRVM6q33Cihi8eb0Pz3I7GecHAovyHnAuy+G32knKDFUWgTAMla7GLg/a0gZyOaNIVKsG97CAASgIr9cqfHNGrkxWE9+o13XC6ipQQE+jl3fU86w8QZVkZMKVaTvKgXf8JI5Tm8TQlow17zWxDY7G1PeRqz130wCDjMo5PcKNVVFx1BkQRekZYE2HiZECYL3XSOmeHmtJI8wMZRw3ROrDMcXvnBrkRiTNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(966005)(316002)(6486002)(41300700001)(83380400001)(86362001)(186003)(6506007)(26005)(53546011)(7416002)(6512007)(2906002)(82960400001)(38100700002)(5660300002)(8936002)(8676002)(66946007)(54906003)(478600001)(66556008)(6666004)(6916009)(4326008)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8Cu2TOhYP2o2FOAS+Ms5jOqJo0vZEgxBpxgH/p/VZfamx1O+DjjVSI+iOz/0?=
 =?us-ascii?Q?JNZv0r5vDHE4iDhxvV46OUVjMCpmKAoxdNPKgjheW5MFjioQ4deDbgy7GrLJ?=
 =?us-ascii?Q?I4ensxakmu+LKf98oXhvcrm3Yla2WOHzfpBZbyaFR04qrqpb4AQbaYFLNxSV?=
 =?us-ascii?Q?oiiAro/mcnkmtPFAwQHhW74oAljZ5/abkwuZ9SZzRYy1y3XdZQAGiL699qKx?=
 =?us-ascii?Q?bIa5BEnMEvCbgSOX2VJUfSrc12M05PJNqJ1QUvc5TA9sM7Q7FMY4nVhwfm3y?=
 =?us-ascii?Q?02Wmij0xe6KtoLbPHrUrs/TOkyFN1Qw8YctnOeBCuVfJ1iXNaWNuYTsK1Pxc?=
 =?us-ascii?Q?MEWj1pgOqItkmlGGSH7iLXtEmYnVHztozmhzbJp0B7/Igi2CWZZtUjMYa+5J?=
 =?us-ascii?Q?FtSV05+P1sRYplNM/5Orl3B0/6tFNpekENmnxoTUEbPnU+od8oldsIZFcIZE?=
 =?us-ascii?Q?fE4xjsz3aYEYoBQaEXaIczYU+tGcL7s+Sabd6cuFX48A5YVtAvgugz+hkm8s?=
 =?us-ascii?Q?PANHkRoHanP6DFixv9LrfnilJcpPR+oQtiNqNYHg6fsVlEJsjdkMPQKRJh2o?=
 =?us-ascii?Q?JGLEADgyP+8dECbRzhiUJvo2TRRLEOGbeV4JsBSpPUrCJPlKfSf6oj2XAwNJ?=
 =?us-ascii?Q?3XBksOgs3cqeu+EdoslOQLna6i4eiBmDFPsMU+HOW0D8l8YUXXG3uU/M/I1X?=
 =?us-ascii?Q?tUg8yEiWQDRzyYIsNmt/qYF/bZFojm4UU7FliwA2+sJzCzIn+iltbgN83Ccg?=
 =?us-ascii?Q?+D+02cg5UtTlhtGE2xBu2DjbMQRLSdZsOapga1QLrUjp+tNEEj1xpniB8C1W?=
 =?us-ascii?Q?CHe6xsKTfCq3ENTImBSHi2h2qtJRugSAvR93nxjWmjuTW61d9LSB8Ws2b8VA?=
 =?us-ascii?Q?UWqzJ6vQZSyPGX9XYi++Vpokt9aK01yiCtEw5PIcycBbIfa9bePSCFjeHOpI?=
 =?us-ascii?Q?lZGyThBSOc19mjmRzERtJvuOv4m4+27aECIgBrYgQw93A47wbYpfwpNdX1hi?=
 =?us-ascii?Q?xjRpQA0kqFZivj7ccMeD2RvAVLgDMjKQJ6DgxlnPV1SctPH1ZDttaFgoknyb?=
 =?us-ascii?Q?ubDHAlgIDdZ4QHwiZ7uVCSijNamZpocB7rrLP+7LvkRHHQm40SeF1qEqgLg4?=
 =?us-ascii?Q?xudu6G0c+QwWOTzaxrPBpUcwgRQhTfzoO8sKO28NfK6VNo29qbIpkk09szyG?=
 =?us-ascii?Q?gaR45WVRf0iBnFDctYRTrwaqQRmMuDNS1gDaPyaok3QLMSkKG/JjQi5mmFkV?=
 =?us-ascii?Q?+xox6yljSQsYWLjvHdohFRMLuYHSthlPCNc8yDExhEgRM/W9oxqg0fYvldeK?=
 =?us-ascii?Q?G6bguraYIBw2cKQBZjpZ2J2CUKgoBeRppfWH21B41shkTE2g4RVWbQwBE0Pm?=
 =?us-ascii?Q?Log85XQyMUn4Z4vdAp69olRRRIheq7gOakkmnHnFABY1yJWIkHtQtU06O+MP?=
 =?us-ascii?Q?ARJD0FMeD1wZ9g/uAzQMWbuI3+e/VZtAbueUUWUzcJdC9kCFX+WTyfAhN7GF?=
 =?us-ascii?Q?2eHhARSmlZEKT3nz7YClo6BCx530P2cZcZNOjtU2LA/CTHI/ueKcGVhTGwBu?=
 =?us-ascii?Q?bWRhCP4F/h6wkwJv47B79BTjiQSq0/Hh3qpLBG/a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f20ec48-eca5-4b03-939f-08db68d776b5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:51:22.5031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Au3tS5c40Voh8M1KJd8QK6EfUdt9gnn/UR3MjPI/uZG04tCYANzkXklB75TN1dNurwtOZeiSRa60a5Cy9etfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-08 at 14:45:54 +0800, Yicong Yang wrote:
> On 2023/6/8 11:26, Chen Yu wrote:
> > On 2023-05-31 at 16:21:00 +0800, Yicong Yang wrote:
> >> On 2023/5/30 22:39, Yicong Yang wrote:
> >>> On 2023/5/30 19:55, Peter Zijlstra wrote:
> >>>> On Tue, May 30, 2023 at 03:02:53PM +0800, Yicong Yang wrote:
> >>>>
> >>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>> index 373ff5f55884..b8c129ed8b47 100644
> >>>>> --- a/kernel/sched/fair.c
> >>>>> +++ b/kernel/sched/fair.c
> >>>>> @@ -6994,6 +6994,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>>>>  		}
> >>>>>  	}
> >>>>>  
> >>>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>>> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> >>>>> +
> >>>>> +		if (sdc) {
> >>>>> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> >>>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>>> +					continue;
> >>>>> +
> >>>>> +				if (has_idle_core) {
> >>>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>> +					if ((unsigned int)i < nr_cpumask_bits)
> >>>>> +						return i;
> >>>>> +				} else {
> >>>>> +					if (--nr <= 0)
> >>>>> +						return -1;
> >>>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>>> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >>>>> +						return idle_cpu;
> >>>>> +				}
> >>>>> +			}
> >>>>> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> >>>>> +		}
> >>>>> +	}
> >>>>
> >>>> Would not this:
> >>>>
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -6994,6 +6994,29 @@ static int select_idle_cpu(struct task_s
> >>>>  		}
> >>>>  	}
> >>>>  
> >>>> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >>>> +		struct sched_group *sg = sd->groups;
> >>>> +		if (sg->flags & SD_CLUSTER) {
> >>>> +			for_each_cpu_wrap(cpu, sched_group_span(sg), target+1) {
> >>>> +				if (!cpumask_test_cpu(cpu, cpus))
> >>>> +					continue;
> >>>> +
> >>>> +				if (has_idle_core) {
> >>>> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>> +					if ((unsigned)i < nr_cpumask_bits)
> >>>> +						return 1;
> >>>> +				} else {
> >>>> +					if (--nr <= 0)
> >>>> +						return -1;
> >>>> +					idle_cpu = __select_idle_cpu(cpu, p);
> >>>> +					if ((unsigned)idle_cpu < nr_cpumask_bits)
> >>>> +						return idle_cpu;
> >>>> +				}
> >>>> +			}
> >>>> +			cpumask_andnot(cpus, cpus, sched_group_span(sg));
> >>>> +		}
> >>>> +	}
> >>>> +
> >>>>  	for_each_cpu_wrap(cpu, cpus, target + 1) {
> >>>>  		if (has_idle_core) {
> >>>>  			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >>>>
> >>>> also work? Then we can avoid the extra sd_cluster per-cpu variable.
> >>>>
> >>>
> >>> I thought it will be fine since sg->flags is derived from the child domain. But practically it doesn't.
> >>> Tested on a 2P Skylake server with no clusters, add some debug messages to see how sg->flags appears:
> >>>
> >>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> >>> index 69968ed9ffb9..5c443b74abf5 100644
> >>> --- a/kernel/sched/topology.c
> >>> +++ b/kernel/sched/topology.c
> >>> @@ -90,8 +90,8 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
> >>>
> >>>                 cpumask_or(groupmask, groupmask, sched_group_span(group));
> >>>
> >>> -               printk(KERN_CONT " %d:{ span=%*pbl",
> >>> -                               group->sgc->id,
> >>> +               printk(KERN_CONT " %d:{ cluster: %s span=%*pbl",
> >>> +                               group->sgc->id, group->flags & SD_CLUSTER ? "true" : "false",
> >>>                                 cpumask_pr_args(sched_group_span(group)));
> >>>
> >>>                 if ((sd->flags & SD_OVERLAP) &&
> >>>
> >>> Unfortunately the result doesn't match what I expected, the MC domain's sg->flags still marked
> >>> as cluster:
> >>>
> >>> [    8.886099] CPU0 attaching sched-domain(s):
> >>> [    8.889539]  domain-0: span=0,40 level=SMT
> >>> [    8.893538]   groups: 0:{ cluster: false span=0 }, 40:{ cluster: false span=40 }
> >>> [    8.897538]   domain-1: span=0-19,40-59 level=MC
> >>> [    8.901538]    groups: 0:{ cluster: true span=0,40 cap=2048 }, 1:{ cluster: true span=1,41 cap=2048 }, 2:{ cluster: true span=2,42 cap=2048 }, 3:{ cluster: true span=3,43 cap=2048 }, 4:{ cluster: true span=4,44 cap=2048 }, 5:{ cluster: true span=5,45 cap=2048 }, 6:{ cluster: true span=6,46 cap=2048 }, 7:{ cluster: true span=7,47 cap=2048 }, 8:{ cluster: true span=8,48 cap=2048 }, 9:{ cluster: true span=9,49 cap=2048 }, 10:{ cluster: true span=10,50 cap=2048 }, 11:{ cluster: true span=11,51 cap=2048 }, 12:{ cluster: true span=12,52 cap=2048 }, 13:{ cluster: true span=13,53 cap=2048 }, 14:{ cluster: true span=14,54 cap=2048 }, 15:{ cluster: true span=15,55 cap=2048 }, 16:{ cluster: true span=16,56 cap=2048 }, 17:{ cluster: true span=17,57 cap=2048 }, 18:{ cluster: true span=18,58 cap=2048 }, 19:{ cluster: true span=19,59 cap=2048 }
> >>> [    8.905538]    domain-2: span=0-79 level=NUMA
> >>> [    8.909538]     groups: 0:{ cluster: false span=0-19,40-59 cap=40960 }, 20:{ cluster: false span=20-39,60-79 cap=40960 }
> >>>
> >>> I assume we didn't handle the sg->flags correctly on the domain degeneration. Simply checked the code seems
> >>> we've already make sg->flags = 0 on degeneration, maybe I need to check where's wrong.
> >>>
> >>
> >> Currently we only update the groups' flags to 0 for the final lowest domain in [1]. The upper
> >> domains' group won't be updated if degeneration happens. So we cannot use the suggested approach
> >> for cluster scanning and sd_cluster per-cpu variable is still needed.
> >>
> >> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/sched/topology.c?h=v6.4-rc4#n749
> >>
> >> Thanks.
> >>
> >>
> > Is this an issue? Suppose sched domain A's parent domain
> > is B, B's parent sched domain is C. When B degenerates, C's child domain
> > pointer is adjusted to A. However, currently the code does not adjust C's
> > sched groups' flags. Should we adjust C's sched groups flags to be the same
> > as A to keep consistency?
> 
> It depends on whether we're going to use it. currently only asym_smt_can_pull_tasks() uses
> it within the SMT so I think update the lowest domain's group flag works. For correctness
> all the domain group's flag should derives from its real child. I tried to solve this at group
> building but seems hard to do, at that time we don't know whether a domain is going to degenerate
> or not since the groups it not built.
> 
> > 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index 6198fa135176..fe3fd70f2313 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -713,14 +713,13 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >  
> >  	/* Remove the sched domains which do not contribute to scheduling. */
> >  	for (tmp = sd; tmp; ) {
> > -		struct sched_domain *parent = tmp->parent;
> > +		struct sched_domain *parent = tmp->parent, *pparent;
> >  		if (!parent)
> >  			break;
> >  
> >  		if (sd_parent_degenerate(tmp, parent)) {
> > -			tmp->parent = parent->parent;
> > -			if (parent->parent)
> > -				parent->parent->child = tmp;
> > +			pparent = parent->parent;
> > +			tmp->parent = pparent;
> >  			/*
> >  			 * Transfer SD_PREFER_SIBLING down in case of a
> >  			 * degenerate parent; the spans match for this
> > @@ -728,6 +727,18 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> >  			 */
> >  			if (parent->flags & SD_PREFER_SIBLING)
> >  				tmp->flags |= SD_PREFER_SIBLING;
> > +
> > +			if (pparent) {
> > +				struct sched_group *sg = pparent->groups;
> > +
> > +				do {
> > +					sg->flags = tmp->flags;
> 
> May need to test on some heterogeous platforms. Does it always stand that child domain of CPU from
> remote group have the same flags with @tmp?
>
Good question, for heterogenous platforms sched groups within the same domain might not always
have the same flags, because if group1 and group2 sit in big/small-core child domain, they could
have different balance flags in theory. Maybe only update the local group's flag is accurate.

I found Tim has proposed a fix for a similar scenario, and it is for SD_SHARE_CPUCAPACITY, and it
should be in tip:
https://lore.kernel.org/lkml/168372654916.404.6677242284447941021.tip-bot2@tip-bot2/
We could adjust it based on his change to remove SD_CLUSTER, or we can
replace groups->flag with tmp->flag directly, in case we have other flags to be
adjusted in the future.

thanks,
Chenyu
