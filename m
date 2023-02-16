Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB426998DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjBPP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjBPP1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:27:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12CC4CC8B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676561264; x=1708097264;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0zg3rfpzFMTFZjlQ9LJICV85WspaeYRTdy6Kc5Ey514=;
  b=lQADDW8sLczNHOhnlN68xD5cMWEYP2eFVF0jcUCksXXISsPqlFhgUqFE
   V6RJwdeuvhnXbv9IBA3S+6DlsbjCQhO5fFwi9z2JrJQW4qA8VrkHVs5jT
   Jt6GyqgKtUcloVUq/WCYtenrKFNVEtzDhQvt1EGm/9zjDjM6cRzQdYXdB
   Ug+oUx3fB3/rRWtlKRweBEZknIdHE2uTs+yScW4ikkMlk0cN7K3AIYHnl
   +48EC+x57CY5MYVoGxA6wK1siz7K3gUSEvKK/izbJQ2jV6HXprjEvyjKG
   jQ4AU4gvDdfzHppzvz/PCMxWp5rYMbDm3MZ8pDY/yF7x/F5rrh1riI+Ld
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="331739817"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="331739817"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2023 07:25:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="702585255"
X-IronPort-AV: E=Sophos;i="5.97,302,1669104000"; 
   d="scan'208";a="702585255"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2023 07:25:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 07:25:14 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 07:25:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 16 Feb 2023 07:25:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqZB6/FDXe72A/qeIrA31/wdH0DjWbAAtLo/Hss58xOYHur6aBLlbQAk5r4hpQWklxxVXe2CDjKSZTvJifYp59LOvqK8w1cMJw8pcULUU4wuUABnsgL8a5S4dPx05LbcZmF4/g1yV1TkFqVve3dtf09JKxr3nCTaTm+SfJOSvTEtaMLtWMPQWviUAAb1oUPDSK/xRN/utoXaiekd51onp2teL7WAaVVNRFU1zXgG3wWsFdG8ltFRTOxDzrkXV/ptevZ9ZIJ2ARyrvQtc4xiSKyaGkJnJAq1Mb/hfKLQHIfuRUU0ItzlEtCoxHrutBc4Pkx99oHvIZq3aAd6tu7kVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEAhsR9oMsBYRhYubxLaiBxoK0LIVU/QqUzqcUxBfdc=;
 b=nl6LqAn417wznAAT8TfKaIzvkuO5MKujl9cM3ioXbvc2a8vxwFbjQiNCXFv5ybC7bs/lKlRQsb7Vnre7TaDQLoitFJ+f9+Bp2Zpwb6fzDuvE1rudcPVx0u0FId3Rm2/1GLlACVBqAd/pR+LmilTAgZEvnD+iyHRO27uutmag6/gC98EZ1XQ+b1S3c7gYi336cvtAqcNuXIrDlPXmqcTGpuvL+FVeKgEVtQjcV73GnSoKpSZcMpr53dk33go7Ld7qi4QXsTIiMGEgJg2SoElPs4whvN6YYyVNcdoNG1tdpn35gTLp98rzQijKwqRqMnSu92JWeezdH2RLQc8sUPB4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 15:25:12 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::cd83:248f:1c9b:c9d%8]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 15:25:11 +0000
Date:   Thu, 16 Feb 2023 23:24:51 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        "K Prateek Nayak" <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        "Joel Fernandes" <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>,
        "Hillf Danton" <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Message-ID: <Y+5Kwxnrj16xRklf@chenyu5-mobl1>
References: <cover.1675361144.git.yu.c.chen@intel.com>
 <1b8af8d99da99a20449288ab4fbba64dc05057ce.1675361144.git.yu.c.chen@intel.com>
 <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|IA0PR11MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3d82e0-1819-492e-b5d7-08db1031fe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z2kCP13CBXynrvh/yKCBBB2U7OQBvD70aoW6+Fs8OPx2HLXGx3FFG5oWP1CwVfbifbT4rFPzsiaKfRDqJd8vtVmLnAxANyxxsqXJOHhsnwjS677fezuiUfEJlS4tXcQmkiB1W2gmcX/iutgaqYypCwU54uGcupIp8ba7/qo+QvQO1WNw4bS7COdwMSbIceZIZCjIhYM0VrZbIoXkcZDxL5KVa0/7Ue9O1HyKz2zjzMrPNvCE6h6CdyqaWfCcsMFrwymtM2u3UL+9Y3hjkCNUhLJFwSDYCqeqOgwhZYEWBHQ26NoKlvSsq32dUbAMI6FQ33bpVedTsRjm0j1/9e1Uw+I6GW/hdPjYU+MhvR4ABpf9a7aM9wrHLVzTg8s02LS4kKmlAKe81WfiPTumfO+7ZckZbLw/T2caRh+HscbVP38lyXUcEM2Ntz3eOmxBlzTO0lQYq0TRVxTrmZsIXV8+QgC46sIAphu0MFWAfjhz0jRQIfdX1G4my0SS3kHaM51uv0ME7hVNiv3srHSkv9XDoV2mCwEJv9UgyHTu5VHpNd7/xaY1zGiuYQR6h/ZWI03b0BQsI7sdLpkAaqcd2v0MJE6LBLhnJEjqwXM70U5o00gBHep1n3V5KrCEg1qpYaec6LFcL3epsJ1KZ6nR8ldjKBC5jO8IoIF0VBj+nf1cVQEO7D/CfY4wgtXrrk/VpOe1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199018)(83380400001)(6486002)(86362001)(33716001)(107886003)(53546011)(9686003)(6506007)(186003)(26005)(6512007)(6666004)(478600001)(38100700002)(8936002)(7416002)(54906003)(316002)(2906002)(82960400001)(6916009)(41300700001)(8676002)(4326008)(5660300002)(66946007)(66476007)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bo2w7ffMq8bNBaQXN3GfUoAFhAsdWeO4aGQnhWlyUmT2YNgh3z6COaeBxjB5?=
 =?us-ascii?Q?h6z1qibiyGoc9itfDfZiXcHx3CAFi2xZSUx1QeiclhS/DG4yLbNe+X8UspFc?=
 =?us-ascii?Q?6sOfgSF2nx6s5as/IJFLRimVEWrIsr40hFGIxo0gvo1bEpHbZGh8YjTMixrJ?=
 =?us-ascii?Q?lx5sdTrSDYYPt/t++lz+G2hCDPco0iI60tzLp/o3dUu56mCh7l4aK2DrCuvL?=
 =?us-ascii?Q?nSUx5nF9Cnjz6IhedTOIr2FIRFnGUiR7PO2etAzHPdxs9RmQ5kz6y7wbVh8P?=
 =?us-ascii?Q?QOdbNF8G5W92o/CVMZa146IQa5HQIITg2M6f7JYghSRPUpGnMoohid20w7hK?=
 =?us-ascii?Q?Yq8TdvOWuudALgArWwCj0QGdu0Ko0HHjoDI5fWMYRPIxIpCQ1ecCyCIfA0ln?=
 =?us-ascii?Q?+mN6qnjIVmShBf10r9m7Y8CMxAh+WTneb7UlZHnaA/UjIQEUXSi7wSgFY7GP?=
 =?us-ascii?Q?ZrtXekd/xwqDuwqb7n50ayQY3UJuTj8pqmuORiHEE5JO4i4Zf+E4N9RfH7fF?=
 =?us-ascii?Q?TOSWjDVRAozEmCnQRRDS5VwdlS0ekTNfyL0xipgTx1BpRDP4XFjM8+xsZksL?=
 =?us-ascii?Q?AxdkxWEOV8JgMBpPwDPRCaqJ7PtjevByNFrZuJrGYQM1CsrcQjVboCl21WsU?=
 =?us-ascii?Q?hseCUjaHeFBIerBzrzggrcu9zFMT77Qtuk1ZFxo1608tSKPGrmSGFsKs1GAL?=
 =?us-ascii?Q?3Z/Q1lPco8YYG0CoXcMZ0eGMUhpV1JQ6WQeUHmqEkHKHRQNd9PFwBFMsks+W?=
 =?us-ascii?Q?bfLdyL2a3w29nYTtdfMkLcV1YFg8Dd+vqxUPv4f0TxvNq5/XFs5MBQ0gnyat?=
 =?us-ascii?Q?Y67ACuCohMYAXdFbUaK2SSIq+9At7KpHWsvwd8QERSd18dUpVR9nh/6ysVza?=
 =?us-ascii?Q?4lIY8/E1H/B3AlI5jjhX5asizmdboO4kODNUxWlZYFxvIV/kWKMPFys9iyXq?=
 =?us-ascii?Q?TiUFezHjDo3QsavCN8EiAwJBhiZaLwrem0MftrFFKSZ6Ta9DeGe3/gjctpG6?=
 =?us-ascii?Q?hN07onXoSMp93XeNFFhcfhQpovSerxmmLx0ZPfesIzKyfbtFGnm3y00x7gGu?=
 =?us-ascii?Q?Iv8lRcozWpxgQx7mpJv9QeVhwmbzfi8HXPF0BEqXVxM4ejHR9itMUB7kZhAm?=
 =?us-ascii?Q?JJpw9/EG1jIhwmot6maAqWPXnwBksjxmWm80BS1Xcq1XuF4txxCZloX8uGJR?=
 =?us-ascii?Q?r3xq/kcDZTWfhi/xkxNbXds3KW1J+Mk0GTXjMRKvGKB5cR6X78yyrM8sRSsn?=
 =?us-ascii?Q?lTBuH5BdtWybSBBfdEdBgMVBPJK3sS3FzZ9LXjZd8xM7LCAsi1j+DZjM+sD1?=
 =?us-ascii?Q?HHodq1Q7DRmt7+Zk9fue+Znlv1xroB1CdFdXrmigz3ht7D+nXC2Bdc4X2SGt?=
 =?us-ascii?Q?Zq2om+xIlII1NbXVPZv9pjuz3KakHDw0zSgW3vgWEgnel8q1f0CPUbGYbqKM?=
 =?us-ascii?Q?genFuGxZS16wkWXU7gqZNE8dj9urdo61iZNuoaXzulIwUxILKizoz+LPxyg5?=
 =?us-ascii?Q?fUdLv8HvJPIeMGDMaXllejrUBab9ic0cz3grsqZviOx312mFtv8tU+s4uGhm?=
 =?us-ascii?Q?e8+0OFRjxLinvGFUT9n+4ZiH1UPujofg09C+6gTj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3d82e0-1819-492e-b5d7-08db1031fe8b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 15:25:11.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR/miir/GxOk1uZoh3U6O498w8JyIYX0fJbBgAuYdLsfuiu3em8ZMCiL+z/LwTiLLCuTYh47YJWJkHhzYpn8vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,
On 2023-02-16 at 20:55:29 +0800, Abel Wu wrote:
> Hi Chen,
> 
> I've tested this patchset (with modification) on our Redis proxy
> servers, and the results seems promising.
> 
> On 2/3/23 1:18 PM, Chen Yu wrote:
> > ...
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index aa16611c7263..d50097e5fcc1 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6489,6 +6489,20 @@ static int wake_wide(struct task_struct *p)
> >   	return 1;
> >   }
> > +/*
> > + * If a task switches in and then voluntarily relinquishes the
> > + * CPU quickly, it is regarded as a short duration task.
> > + *
> > + * SIS_SHORT tries to wake up the short wakee on current CPU. This
> > + * aims to avoid race condition among CPUs due to frequent context
> > + * switch.
> > + */
> > +static inline int is_short_task(struct task_struct *p)
> > +{
> > +	return sched_feat(SIS_SHORT) && p->se.dur_avg &&
> > +	       ((p->se.dur_avg * 8) < sysctl_sched_min_granularity);
> > +}
> 
> I changed the factor to fit into the shape of tasks in question.
> 
> 	static inline int is_short_task(struct task_struct *p)
> 	{
> 		u64 dur = sysctl_sched_min_granularity / 8;
> 
> 		if (!sched_feat(SIS_SHORT) || !p->se.dur_avg)
> 			return false;
> 
> 		/*
> 		 * Bare tracepoint to allow dynamically changing
> 		 * the threshold.
> 		 */
> 		trace_sched_short_task_tp(p, &dur);
> 
> 		return p->se.dur_avg < dur;
> 	}
> 
> I'm not sure it is the right way to provide such flexibility, but
> definition of 'short' can be workload specific.
> 
I'm not sure neither.
> > +
> >   /*
> >    * The purpose of wake_affine() is to quickly determine on which CPU we can run
> >    * soonest. For the purpose of speed we only consider the waking and previous
> > @@ -6525,6 +6539,11 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >   	if (available_idle_cpu(prev_cpu))
> >   		return prev_cpu;
> > +	/* The only running task is a short duration one. */
> > +	if (cpu_rq(this_cpu)->nr_running == 1 &&
> > +	    is_short_task(rcu_dereference(cpu_curr(this_cpu))))
> > +		return this_cpu;
> 
> Since proxy server handles simple data delivery, the tasks are
> generally short running ones and hate task stacking which may
> introduce scheduling latency (even there are only 2 short tasks
> competing each other). So this part brings slight regression on
> the proxy case. But I still think this is good for most cases.
> 
> Speaking of task stacking, I found wake_affine_weight() can be
> much more dangerous. It chooses the less loaded one between the
> prev & this cpu as a candidate, so 'small' tasks can be easily
> stacked on this cpu when wake up several tasks at one time if
> this cpu is unloaded. This really hurts if the 'small' tasks are
> latency-sensitive, although wake_affine_weight() does the right
> thing from the point of view of 'load'.
> 
> The following change greatly reduced the p99lat of Redis service
> from 150ms to 0.9ms, at exactly the same throughput (QPS).
> 
> @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct
> task_struct *p,
> 	s64 this_eff_load, prev_eff_load;
> 	unsigned long task_load;
> 
> +	if (is_short_task(p))
> +		return nr_cpumask_bits;
> +
So above change wants to wake up the short task on its previous
CPU if I understand correctly.
> 	this_eff_load = cpu_load(cpu_rq(this_cpu));
> 
> 	if (sync) {
> 
> I know that 'short' tasks are not necessarily 'small' tasks, e.g.
> sleeping duration is small or have large weights, but this works
> really well for this case. This is partly because delivering data
> is memory bandwidth intensive hence prefer cache hot cpus. And I
> think this is also applicable to the general purposes: do NOT let
> the short running tasks suffering from cache misses caused by
> migration.
> 
I see. My original thought was to mitigate short task migration
as much as possible. Either waking up the task on current CPU or previous
CPU should both achieve the goal in theory. Could you please describe
a little more about how Redis proxy server was tested? Was it tested
locally or using multiple machines? I asked this because for network
benchmarks, it might be better to wake the task close to the waker(maybe
the NIC interrupt) due to hot network buffer. Anyway I will test
your change slightly changed to see the impact, and also Redis. But it
would be even better if you could provide some simple test steps I can
try locally : )

thanks,
Chenyu 
> Best regards,
> 	Abel
