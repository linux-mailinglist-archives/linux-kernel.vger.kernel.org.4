Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928C8740A32
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjF1H7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:59:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:19995 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232059AbjF1H5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687939043; x=1719475043;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+A3t/O80XmkceP/xFs5en3bj+zGJ/OIJe1Q3Wf3K4bk=;
  b=AQDFUYh4pc7+/dwhF8fdE0b3o8NPbWXxk6Wkq+b8JhOACjC3lqOgY2jb
   5G9Izi+FiF66UKpp3dsRU5BLY+A8KM4FCK+CupyXsz9nc+Zb8gnq7zJoV
   Viy/ZnRc9yyYHqeZbDsi7qV0HfvmZqKryj3ImUJ4ySGrAwndY9KfKihlP
   qQpmdbMKyt8BGvCdGji7oErDS+1UjwflW8Qjj+hfwxVPdZpb2ZkFXEhiR
   zYGlyvmuQfVpZNX6nzS7gDQARE3NWpZ8fjGLsahvKpnFJeioD1E/y9Zws
   ZZVtd1gTcBostQhJo5p3lWRg7+cIik156uIKSmjjR2Oyn5C6qYNg871JD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="341338534"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="341338534"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 22:18:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="694144707"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="694144707"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2023 22:18:56 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 22:18:56 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 27 Jun 2023 22:18:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 27 Jun 2023 22:18:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 27 Jun 2023 22:18:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJHemB+HDe9tchaUnzESC6QlQzyCEVgFICVVuO5aORQOGDHgeO/FoOzvv60b3opNbqm7dON8bAknf8c3kUzSsWTXfjiKi5MqyOVatRe/KS8JaaYKjXFZk7L3pxfmvq5TfN2fH/SdaPgGeXnbW9dQC4Ta2M+FGYXKUK6j8bsJ2A7g9iSfQaAmmY/1u8Zba+Fk30tlzw39kk25TSo4NCgD2m/oiRE7xW7vPYlQDl0g10/qfiI6ARdQ7xqZ+sjNNTl6GQV0+1OR4tu4ROqWlTvNj2bGJRQD4APj/grmKzYmjkXhndAMs59mvrEUpaVk1g24hojvRq+d6JEH2IhqmQGImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SSu1cVRKmTgn3FAWkNaa4f5UkYwG366WeCUTQVEcrks=;
 b=d+YXKw7io6sPn9qv1ZfCIZFdW4LE2u74KbTFycmOqHjLUCB0ufzYq7g/FGVTsF7rrBzQHwVoO80lZue95lGoz0tKSf24+hJB74bGTRZU3GKi7xGTem/bsH0JA8VHI97Zx7mA4DDYVQ60l++j8iqx0f4BI8ZpJrcaRMFoaQ2GQefFPdqwROpN6Wzi5w37P5TPIPpfJybf+TZwML8vUfAqegbf6MbTMCqqUVXU74T6+Mc/LHhURlkOaiCHJ7MhPu/9gXELZEC1ZxS1C2dJeVItlXIiTpJ39WHgf0M97MyZL7uEdEWgsUH4JhXQNvsBNmQdimPes4Mn9hV98zTB0/GASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 05:18:47 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::4103:d2e0:996d:cf1a%5]) with mapi id 15.20.6521.024; Wed, 28 Jun 2023
 05:18:47 +0000
Date:   Wed, 28 Jun 2023 13:18:34 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Deng Pan <pan.deng@intel.com>, <tim.c.chen@intel.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <tianyou.li@intel.com>, <yu.ma@intel.com>, <lipeng.zhu@intel.com>,
        <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v2] sched/task_group: Re-layout structure to reduce false
 sharing
Message-ID: <20230628051419.GA565419@ziqianlu-dell>
References: <20230621081425.420607-1-pan.deng@intel.com>
 <20230626054756.GA435374@ziqianlu-dell>
 <20230627101437.GY4253@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230627101437.GY4253@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3062:EE_|BL3PR11MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 38b6f095-7c10-4d75-4f0f-08db77972622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stzPJBdoSfUkp4MNxE2PgQd2YGBB+mtGgaXn+yzdKz/jzA3/FGN3iGXu+5iyJ43QIl3l4POs3cu4j0AfDMxI8JEZt+V7jnnMc4oh7/dBy0c6ur76WT16wttx4cxmlDMjyycUq6nKABM86afwMUQ1aMGVjswCQPo1OHo/qSVLQ8tvQ92A8UOnm6QZuwIdOQFHKejGo5R2z5kJe8XVXYIHHwHYRUcEXbdqTDoQNYS/7Ti4D02kqxNsH1mEUJrGw2Efz+fgONsYbLoSEiOxNX9ZRn33ym3v1dQ1W2l8Evd7Ue1kt9+BQIHnDx5VPoW74DzywRqZ0wEfsXk5lNCVkVKdyeAimVPo/824nL8NpJFCLFH4LScMG8S9bRSjzpTNrRiOPC7HAFHfimyAvoClIpg79ezNLt3gem++jgHv5QMZJVfMycVZ5SqsI+rBlaqs+QwLf3pqTyQD6ODjAX+VZU2TwpgXrFyLSljjLRnqH/hx7ih0ZOmYYiLUPGf1Xi182igd7BDurfxXYkl7m4GHKSTgKie7PUpJOwExqsL+NK5FVQoG46cflo4Hc+YXByTYUOB7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(8676002)(8936002)(83380400001)(316002)(66946007)(41300700001)(66556008)(6512007)(6506007)(6916009)(4326008)(66476007)(186003)(26005)(1076003)(9686003)(54906003)(6666004)(33716001)(6486002)(2906002)(5660300002)(44832011)(478600001)(82960400001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCgG031hpcxeaiJe1thTSJsEd1MXvL5Sl8f2s5uR5w07tgGDKxeoxqwa1m/j?=
 =?us-ascii?Q?PR63uTkAdgHvyRd3+vcrS4Zx5werWopqzIqiv91AsbbXXdDrvF+f+t1mtjY9?=
 =?us-ascii?Q?4o5O4LwJHxomaeC22f61IkVVNsNHGS5gsRwG4BUccdIDgKoblWga6A4mwbvP?=
 =?us-ascii?Q?UeYZrgDEPtQ5iOIzlLXHTFkge8DOJDqpItfzGp0ddeD3fZ4QGLA2gTlPlQs9?=
 =?us-ascii?Q?XyERJrAhIc3Li+In71FtNJZjSJ8t0pyDWxBmrYAQBZQ2UXAx9CEosABSD/jh?=
 =?us-ascii?Q?ZjJt/NvPSwcNC/gzOUQHwGnXtia9jTUZqMpcH8VGBahyrmzS1cmYHnGEIvb0?=
 =?us-ascii?Q?VUW2RT1EQH5mqU57+MHqKCRf1U/cyhxGsITmd+L/VEpZ8febV0S0zMkE1QuA?=
 =?us-ascii?Q?FF5aEu1zvvxiS+aJjBTCWbyVv4lvilXMoECjDYSpDiMZommBx5OVS/h/dh2m?=
 =?us-ascii?Q?DmtlC8gBfii9lVM2M/15mPPREDupcvAY3lThopXVvRo6Sdw01XimSiv6aGpG?=
 =?us-ascii?Q?Vd7eKbl8qEDQHOeR85YS8QwgNJZF5r+WWJfWuamUBKg/RxWEVgCdN1tcyMuP?=
 =?us-ascii?Q?fSy3w4/+PLK098wOFlphgwYppq9s1kP1uAtP67UKdAKWGepkcvYxUiIPZo5y?=
 =?us-ascii?Q?+8EXBz6BL6aM2w5ewRH+jZIuNOIGlHvfx7U8tRPf6XpBkEiLYJq1r2sFDKI7?=
 =?us-ascii?Q?HWlsfG6y12iWKouqzAdJ3a4wX2mgRVp3n17LYFsWYZ9w3SNTnUTn6Q8/I72d?=
 =?us-ascii?Q?M9hI1qx7+ahp6kNH7N6btguW9ne7r1SgDM4q7YHeesKhYOz5NVg4LAwXMm/V?=
 =?us-ascii?Q?0+obzvGSifVhNl6uHaEfwJLawAwz+jTBvm+7I2Wfd+mRdq7ibi9zuzRqTm72?=
 =?us-ascii?Q?H93XbDLluG67MsUjeIZYlK+JYrVANcYFPzoqF/r3DajT6gJsxk+t1YRexfAU?=
 =?us-ascii?Q?Y95u/68iBZpYZsph+6vNW/8jKc5OeyvW1eJw8vVzoYkYqfFJKx+0oQSX/dc8?=
 =?us-ascii?Q?KCjMBrNy6MoVmvz3+XR2bNRCIPYP6PKdFMhJMrO6HCWbizIwSaoNU1Ocuob6?=
 =?us-ascii?Q?xHjzMg4cG8V/xdVLA/vJEK79XZi4IvhzxAUdmqndOhMAYulMJIPKXD+tZgBN?=
 =?us-ascii?Q?0U52DJMBoSu/hjL2LAM3U5zotpubKIdr9XAxWOjZtBTdgClorGssQ7rPWybz?=
 =?us-ascii?Q?fXaC3O6NOm53EviqY9eorT2qTvy/tzynyZnqqgVxrc6dBffWiOfrPMtozWVy?=
 =?us-ascii?Q?TaWaOpvazL509CGQCO1JKcGU1gPoZXZp7I/pbp/f14qfKe8mOCCTp136zj6z?=
 =?us-ascii?Q?L5FpEUCpsP9Usd6Sw8e/rc0BK/QvSMFCwOFr8/Gf8iMwV42EN9V08PfVBU2J?=
 =?us-ascii?Q?QiQS+vkcqv3hNflgq5DWabOka01+6g4I70+jrPwZR/HxuWUUCRW6K7oCiDpq?=
 =?us-ascii?Q?UlrB1l+JfzjP6U6+y4PqkaSzr6YdI5ZK80L1fFiISB51uKQb7FK+jLvahfCh?=
 =?us-ascii?Q?QQ0ddtPVgYJZ63fcmHLi8CGd3t4gJxSRyzHlOuaCTW8yc47I/q5UHrx1BhYM?=
 =?us-ascii?Q?P+9mvPb7b8trsO5NVDjwV5pKNcC96WMpCApiAJie?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b6f095-7c10-4d75-4f0f-08db77972622
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:18:47.0141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c/42PWlFmDisBEGc4Hg3jY1pm9wAC4xCOOr4TIOijEst+eklxYfgHMcSFzITOafN/M1kjsigQ/8kylhZxGOcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 12:14:37PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 26, 2023 at 01:47:56PM +0800, Aaron Lu wrote:
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index ec7b3e0a2b20..31b73e8d9568 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -385,7 +385,9 @@ struct task_group {
> >  	 * it in its own cacheline separated from the fields above which
> >  	 * will also be accessed at each tick.
> >  	 */
> > -	atomic_long_t		load_avg ____cacheline_aligned;
> > +	struct {
> > +		atomic_long_t		load_avg;
> > +	} ____cacheline_aligned_in_smp;
> >  #endif
> >  #endif
> > 
> > This way it can make sure there is no false sharing with load_avg no
> > matter how the layout of this structure changes in the future.
> 
> This. Also, ISTR there was a series to split this atomic across nodes;

Yes.

> whatever happend to that, 

After collecting more data, the test summary is:
- on SPR, hackbench time reduced ~8% and netperf(UDP_RR/nr_thread=100%)                                                
  performance increased ~50%;                                                                                          
- on Icelake, performance regressed about 1%-2% for postgres_sysbench                                                  
  and hackbench, netperf has no performance change;                                                                    
- on Cascade Lake, netperf/UDP_RR/nr_thread=50% sees performance
  drop ~3%; others have no performance change.

So it is a win for SPR and has small regressions for Icelake and Cascade
Lake. Daniel tested on AMD machines and he also saw some minor
regressions. The win for SPR is most likely due to the per-node
tg->load_avg patch made all CPUs contending on the same cacheline to
contending on two cachelines and that helped SPR because when many CPUs
contending on the same cacheline, SPR is likely to enter the "Ingress
Queue Overflow" state and that is bad for performance. I also did some
experiments on a 2 sockets SPR to place the two per-node tg->load_avg on
the same node and I also saw similar performance improvement.

Based on the test results and the reason why SPR sees improvement, I
didn't continue to push it.

Another thing: after making tg->load_avg per node, update_tg_load_avg()
is strictly local, that's good but update_cfs_group() needs to read all
counters on each node and that means it will still cause the per-node
tg->load_avg bounce across nodes and update_cfs_group() is called very
frequently. I suppose it's where those small regressions come from but
the solution is not obvious.

> and can we still measure an improvement over this with that approach?

Let me re-run those tests and see how things change.

In my previous tests I didn't turn on CONFIG_RT_GROUP_SCHED. To test
this, I suppose I'll turn CONFIG_RT_GROUP_SCHED on and apply this change
here that made tg->load_avg in a dedicated cacheline, then see how
performances change with the "Make tg->load_avg per node" patch. Will
report back once done.

Thanks,
Aaron
