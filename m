Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3CC7078DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 06:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjERERa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjERER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 00:17:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16E35B6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684383447; x=1715919447;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pb/4X4FWMestMqjvgbrjResCGUIW229KtEhIG48aoVE=;
  b=f8ptoDQZX2oP19EZ7Lyoicvgfadz62SvxTmBn5U2/FGuTU/2/rzn5k/e
   Gea/BXoK1gPNbV/iLuKmwx8Tnp2wAc9moC9DClt5LwyZNzCiXaCfxdu8R
   SrfbxwAUOcLt4/vuqdthqvDp+ctDB8FMbm7C3I4O/FAsZw7Llnzmkq18F
   hLBtBP8y82v8i4g+xr7VTvHFUBQ8L539EuMbIzbaoEBJKmAzz5upJWw2B
   5/KpunPW70qgiOCGUDkM4/th3fuXsnz6PwqJtRJjmrdCNwOW0flz/nzPk
   ijnySAYIi314e4iHxZ02M68GVmSgA7qLAC6VlV0583Au4oEBI2kHbaBqX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="351976459"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="351976459"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 21:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="814163671"
X-IronPort-AV: E=Sophos;i="5.99,284,1677571200"; 
   d="scan'208";a="814163671"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 17 May 2023 21:17:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 21:17:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 21:17:26 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 21:17:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2z++FJqNuW8RqrlsL37ODPZa58oJKJqVmBv4m9+EuCuoq9RVaAAfwkFa0xzlhtaNRhthzzI3AzNUem4ojQdQMVwEcUk81Sqerc8KiGkH1IUdPr9lFPTArjaTtVKlieSqTARSnLIPOUI3Drzy3nBaCpOdMldc3ag7eWvSnnS7XFXBZTTe0u4QBTt/wsds2hx5blBA+AYvlxUBgZs5qf/oDD+lrTtHkU/T/8XePWrCLCJYJp8XypW9ZiYZ6V/vDRPEvWW7TXy2tGnVEar1GxZih0O5jK4Kozc9eqG6d4mjXadEWnAqwlPF0HWQvMdIpaWR5vfEb3Q0okyPmlUrivmYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaJYqOmTBsIwd6PKWBI0h4zVmZeo2w0xHNl5je8V4AY=;
 b=DnK+0gqIjDaY6GbiviGZeF0EBBvEtf5YPtMfJEtE92Tx8QicXZiZ4oBDC+NhzTeXug7cmkSpwcsTVoOvl8bm+QI3MPEuDOZedA5oEOgDMnCxiora9Bqv1sO4/+1ugSgfCy2fFvH8DqbDFZ0ajBJIEvIyZDH6rSM+lsN6POan0oQT5pSbhZ0h2ayRBK75xC3sW9ys7+0oy2iMyXEuFHnOHDEK1PF/4NPtrVVTAMWqvVGjKGdIG0rEGlJz/SzHeClY+tZYjBZXMOh1Qc44/8kVYoAR5RHf6DEHcaVNRznrXvVa0yNJ5tskgPPSvI4fTz++T7ouzL8lYorahvw50Tyc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by CH3PR11MB8239.namprd11.prod.outlook.com (2603:10b6:610:156::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Thu, 18 May
 2023 04:17:23 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6387.032; Thu, 18 May 2023
 04:17:23 +0000
Date:   Thu, 18 May 2023 12:17:01 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
CC:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Message-ID: <ZGWmveL2YTiXp2XR@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
 <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
 <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0ac968e3-cd80-6339-970d-37005876b145@amd.com>
X-ClientProxiedBy: SG2PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:4:7c::35) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|CH3PR11MB8239:EE_
X-MS-Office365-Filtering-Correlation-Id: cfb74f2f-0c82-46c7-fdf1-08db5756c7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wElLBwXViKixAn9h7pBfAxDof5jWnqE6Dxf+u/926VpyJy0gt/tgvOYe8bJeapVFYHUyvev4RJ2B6T4O8HFLawvgGHjc/gYqHMxawzpWEAUMmKw6ahLZRrepoZosOzXLkHcbPw+Q7RIYMdirLTVO0biaDwmgGLanIXej0t18Gk1Rojh9ovkCrTfvJ33a9c58gxrUw65CeNn8ecrC3PmKQ42dM7aM/veabP35VrXUf96C8sNK4Te4oHbLB0UtHuzvxRwGSd404hR1QiT73KgnQLHXiYeGg1eRoUgcWLH3AZiF8gjLQeXU3ryqU7vsZKf8qmLyC9rSdqRIke07gN/REirUebU8at/eK4XdX+eGp7Rr9o/cYx4mr4iX4VCbQn3EikZCoCXCotokxFHtaQU2qO8g2NrHNrgB1l0XZkFi4moeDCzRf6MB7m7yNLglw1WriQ8NYgZZc56vZZPh0Ha5rKeKhuX8L/U57NolqwYo9i4ml7lU/IvUgEselz48+iKGs86AT14C9oPcJKlWmc0QqVA6pVgMV9iSKK7QKPYs9GvW4gMrJDCO16VyzfuNksk2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(33716001)(83380400001)(4326008)(6506007)(53546011)(82960400001)(6916009)(41300700001)(66946007)(38100700002)(478600001)(6486002)(66556008)(54906003)(66476007)(9686003)(26005)(8936002)(316002)(8676002)(7416002)(6512007)(2906002)(5660300002)(86362001)(186003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AycOTBc5E6a9l/CDoLvJqgXdbtzwlJxNlXEyYLEE5IfSXJkL5alINSZFAAGX?=
 =?us-ascii?Q?Od6FM02+wbbvgbB1PAnBHgqS0BF04q1NlunKGuGRKppdmuUHkN8vTWA6Nkcg?=
 =?us-ascii?Q?Skctml1r7ndaXRcmjZhZIQzRVEYM5V7XJ8Sh1bNnSYs2Gzh62Jz/2ZNOMf37?=
 =?us-ascii?Q?Q9IWiSeyT/Q4lMPmzZUJYKTXyAiTRn/rPFcM2uq0lshiYo2YnZlR5MM04QIg?=
 =?us-ascii?Q?1rHAVTGdFVIpiAYMczTCgFG/rF3w8E8H3K4YqeJ07jJR3D6E28+dl+ymrcya?=
 =?us-ascii?Q?AMH7Ylw7DACU+kThXKXsPvhPDoWalNeTqvRXnnfFEjxrWWNQiXF3gxA1sIxV?=
 =?us-ascii?Q?qk9O6FDfDXkzpIcnG+tcGOsnW2220Tkxqg9KOMrNXth107LeitL8FKgrpKa+?=
 =?us-ascii?Q?VBwi4m+iGShuHd+ol7WWjvI/QNhKU67n3KTFotPjFaKwra92V5zLXwjdfrtz?=
 =?us-ascii?Q?k/AqLMxzg0RH5ue6gB76+WYhuMDTMhEiWLUadupQT+NQlm07VziRkJDN3xaw?=
 =?us-ascii?Q?P3DVs9+eGktZRNzL1zmAn4iCPC1UoAItvkMO37UlcK5SPvL5omdPuxKqghpF?=
 =?us-ascii?Q?ihkvt7fHqMrWbST/H/kCQ0LP6EePeVa+U9CnY+FyepOcIDza6MteAdJF1jsY?=
 =?us-ascii?Q?3xWl4FAgvdSqJHsqCs3ajVRCLxB0o4a863CSFcNUcOsEhmUyzpfw6ilpt7ra?=
 =?us-ascii?Q?bTIoP4m/BojfFHZDdTtuEvab7ib7YHc3wr3wSKB6GmbAqJLhDVAxMghV5hjn?=
 =?us-ascii?Q?YNMs5m8eMhw5b09DiTDVf74/lRjzycvVDvENt9Eesf/Eeb3AxNEfz6Qwy8TE?=
 =?us-ascii?Q?MYzurqxFHLsEQGE8P5Eajgi65CZfiL4Osw35NYOsWsvqu+8q9grjAjQkwgtp?=
 =?us-ascii?Q?sNEVpo4zLdjSxhMc53+MYI8Jq4saRN3dUgjs+SavFtx9qg7MB4AMu8CB5Kt+?=
 =?us-ascii?Q?XSB6xybBXjgvz44NI2rqjQHpOdm+Lwx19qGIXs3yebev7Yxx7AaQT9GE86x8?=
 =?us-ascii?Q?B31+xrOlyFwxI+13kwU1MtaGn+LbMG7GWkenbB/1yUlf+pclKMhfIXE7lHaU?=
 =?us-ascii?Q?VnJ4Jr39Agctqs3ujw4ZBO+xPeOERgj5Hcm3loQX2PRFlHvrIydz6Rtlp+aA?=
 =?us-ascii?Q?ssm42xFmGnJYFgJwPSSx8SEvxyvYn50Ti/lesx2htU2OR4DDegpklk5pbD0w?=
 =?us-ascii?Q?HYDl5U5tkTekQSyQ4s3CbdOyK69x7oLHkRNbzofWziZSdjFJFehqPKmkRRC+?=
 =?us-ascii?Q?0LdrKEKhbyvgqOW/962CWABELXI1aS6NQO5sxt9GMmqwiLxjVHw5zIRFTENP?=
 =?us-ascii?Q?dzXNcBvYodM2ErEzBocrLAkCGal8KcmMK24b3wmJHKsPS1ECpYyFvTWUI4ob?=
 =?us-ascii?Q?N1XqYZ0/m/VMYEGpPN6Gmdbj47ffCpWEJ47I3rC0c7rBpm4jR6sRDjKErQYa?=
 =?us-ascii?Q?fRGHb2bJuyAzTVgcYScsJ/rhw6oQUh3+BPrBRJddjRSaWHL7A7od3IN3b5Cn?=
 =?us-ascii?Q?Rtsb5EyrazDZ+Fug4iMyPUA9yoUR1e9GEPA6AIWOa6GnDgNpL0CLFu8FLHMo?=
 =?us-ascii?Q?MEQaJiZRVuRqiSH/Tc5ZkYB8j6vrW+7WEWW/GZJe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb74f2f-0c82-46c7-fdf1-08db5756c7cd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 04:17:23.6568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7yMxlnxuWcIjj+m9ERD3yWcK/SzNH9vXkrWjdpkyVsfEoOW/xVnhCZsmTDJ30dzStGn3KLXNjfC1lOTI0b0vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,
On 2023-05-18 at 09:00:38 +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> I'll do some light testing with some benchmarks and share results on the
> thread but meanwhile I have a few observations with the implementation.
>
Thanks for reviewing this change.
> On 5/17/2023 10:27 PM, Chen Yu wrote:
> > On 2023-05-16 at 13:51:26 +0200, Mike Galbraith wrote:
> >> On Tue, 2023-05-16 at 16:41 +0800, Chen Yu wrote:
> >> [..snip..]
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 7d2613ab392c..572d663065e3 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7126,6 +7126,23 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >  	    asym_fits_cpu(task_util, util_min, util_max, target))
> >  		return target;
> >  
> > +	/*
> > +	 * If the waker and the wakee are good friends to each other,
> > +	 * putting them within the same SMT domain could reduce C2C
> > +	 * overhead. But this only applies when there is no idle core
> > +	 * available. SMT idle sibling should be prefered to wakee's
> > +	 * previous CPU, because the latter could still have the risk of C2C
> > +	 * overhead.
> > +	 *
> > +	 */
> > +	if (sched_feat(SIS_PAIR) && sched_smt_active() && !has_idle_core &&
> 
> "has_idle_core" is not populated at this point and will always be false
> from the initialization. Should there be a:
> 
> 	has_idle_core = test_idle_cores(? /* Which CPU? */);
Yes you are right, I have 2 patches, the first one is to check has_idle_core
in the beginning but I forgot to send it out but only the second one.
> 	if (sched_feat(SIS_PAIR) ...) {
> 		...
> 	}
> 	has_idle_core = false;
> 
> ?: "has_idle_core" is currently used in select_idle_sibling() from the
> perspective of the target MC. Does switching target to current core
> (which may not be on the same MC) if target MC does not have an idle core
> make sense in all scenarios?
Right, we should check whether target equals to current CPU. Since I tested
with 1 socket online, this issue did not expose
> 
> > +	    current->last_wakee == p && p->last_wakee == current) {
> > +		i = select_idle_smt(p, smp_processor_id());
> 
> Also wondering if asym_fits_cpu() check is needed in some way here.
> Consider a case where waker is on a weaker capacity CPU but wakee
> previously ran on a stronger capacity CPU. It might be worthwhile
> to wake the wakee on previous CPU if the current CPU does not fit
> the task's utilization and move the pair to the CPU with larger
> capacity during the next wakeup. wake_affine_weight() would select
> a target based on load and capacity consideration but here we
> switch the wakeup target to a thread on the current core.
> 
> Wondering if the capacity details already considered in the path?
> 
Good point, I guess what you mean is that, target could be other CPU rather than
the current one, there should be a check if the target equals to current CPU.
Let me refine the patch and have a test.

thanks,
Chenyu
> > +
> > +		if ((unsigned int)i < nr_cpumask_bits)
> > +			return i;
> > +	}
> > +
> >  	/*
> >  	 * If the previous CPU is cache affine and idle, don't be stupid:
> >  	 */
> > diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> > index ee7f23c76bd3..86b5c4f16199 100644
> > --- a/kernel/sched/features.h
> > +++ b/kernel/sched/features.h
> > @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> >   */
> >  SCHED_FEAT(SIS_PROP, false)
> >  SCHED_FEAT(SIS_UTIL, true)
> > +SCHED_FEAT(SIS_PAIR, true)
> >  
> >  /*
> >   * Issue a WARN when we do multiple update_rq_clock() calls
> 
> --
> Thanks and Regards,
> Prateek
