Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECD07427F0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 16:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjF2OHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 10:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjF2OHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 10:07:41 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7E41B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688047659; x=1719583659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=509dTILuRRtZ+Nnd3p1E9NfULDTQ4xHaXaXCrDS1dUk=;
  b=ixFonEuuBDox19/6jLoo+kV6gdLahPSoCPlOUJ2Xpu6KzTgAKg5BiQHP
   H851oEbSfrMfcvU216pnv2IvEUm8tXOUpgpOei7ArqAGVv1yi7pholhov
   IACBTHLo638puA5p4QygnTNDQ++tg27uuI3xrRYumFGdUxvUiwhLqIXyf
   YwSI4ptsqdo2xYOAjguvUptCM1DppP1gE4txMYPLRZBAJZIGbKzSxNwib
   75QbMgk+70F0Sw5rT4IFRnBNuVhDZcHAPBi44woC2OtXWghmk7XiTSf66
   /PWLVQ8IYFSHyFnqhQN/1u5VviFCR/f5xaJnsXP95r4zWXfdYzsa2sbpp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="346889599"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="346889599"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 06:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="720555626"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="720555626"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jun 2023 06:35:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 06:35:19 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 06:35:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 06:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mx/pjVRp5+UWcpxgTTrH4ktXsI0QQAMdzSAlDRGGtLG2KZClr4HhKl81O0KO2sU9Z28fpTxX0jiE1nUEpF+xLBX2C3x84B7vfePYO1UWOhhChIMq51YKCN/I8QR4AWiw9bxxi1rqBcjt5quaaFV2EtdUkfqtiXuPZxuOUHO2r4gZGKmcHDcWl2A7YViYZOB9FI8VbcWjJEVeSJLP1wnY2xgwQjzE+ymCIOO5K9u3zTviZ5xEuq5qwHRyDFJVNmZD5Qh1/YpLGR0wBmJhH5eK9feLuLYGr8KgvwORFMOGI+vwPG2oVkyXvr/ADVdOd/bJvW9p29rCydLEx/czQ3FVdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWkl/KXKWoTx+xNH0vm0qbgthjyuyh3NFNF2yndALWE=;
 b=Aw+jnyeGrO1nH0QTTM2oPIv+rONStoZyBq4b8Fhqa9/Xe4zSWeKNd7o8L0wRG+hqVKbVOj5+EKOIWfr30/NmeAF9nh5cw3i3p4E1oAwe/hmLkWBp0l/RSaQHK0lhG2+UUV/7xqRwhPc2qI0vbWaSafoQQA086OkCTtdLD6/IGEI0Z0HpO0gIActyvduCEjKN/5E/gBBxkSCKFQ8Fkxrkg9vy535nH1V9lTdOe/J+vYYLPtl5HJygmUDtHz6qxJl1auT0IZ0jH/3jYuXmiEol0fGmTXIfMaV9vWeN2eztebD0zVOfS519KMQMxQ6gjizp1Ct5t+9HLqZ6af3R2ftebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BL1PR11MB5494.namprd11.prod.outlook.com (2603:10b6:208:31d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 13:35:17 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::b691:df38:dc96:30a7%4]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 13:35:17 +0000
Date:   Thu, 29 Jun 2023 21:27:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Paul E . McKenney" <paulmck@kernel.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <rui.zhang@intel.com>,
        <tim.c.chen@intel.com>
Subject: Re: [Patch v2 2/2] x86/tsc: use logical_packages as a better
 estimation of socket numbers
Message-ID: <ZJ2Grrn7sq9Jdxf6@feng-clx>
References: <20230613052523.1106821-1-feng.tang@intel.com>
 <20230613052523.1106821-2-feng.tang@intel.com>
 <20230615092021.GE1683497@hirez.programming.kicks-ass.net>
 <ZIwMstkB7CG3pDYu@feng-clx>
 <87h6qz7et0.ffs@tglx>
 <87edm36qqb.ffs@tglx>
 <ZJW0gi5oQQbxf8Df@feng-clx>
 <ZJhUiO+bdBoLU5WF@feng-clx>
 <87r0px40o5.ffs@tglx>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87r0px40o5.ffs@tglx>
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|BL1PR11MB5494:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac00203-6aec-4b55-58c3-08db78a5ad37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49Vz8GcoHonaHStdUkEGZNML/yy+xKpRQQGZKCIuJXq3oHpyqMxlmUAxaPLysKPPxEzh5M94Y67nDUDf6YFtsKLmrdxzNpfzbP971Ey7ILaTs8OJ4y0omtor9CsYLiszyGKLfTyFwZtg6Lf0MguUVAURoP4B1C+M8JiWEJwHkok/PT82vkh1hcDEH7n/srJj3hwfnRJaMs7XoFO+FfNxYdRVvz3zLrN5IRXdUDspdRQ/+VcAoohcCYFw4/fqgnnOC/q3FyOfQabB2aFBJudVk3Nb/l7J6HRYPLgPZNVODBYEHU63o8IdDYykKiSfMc4DM4RrEGHclsBSobqy2DYkEJjzoNqRULDFxJoiRiF0v+7gVhf+sPlhMEqM0OY47KyJS+WoKkfnV+gpvYg9UG9YKidpNkiK/2R1uclu9BmWrBmm1bc+20gcCJsVra1m2+G1niNaoKpdIX0Q/gZIWjshUwz+W3bdY04oWK8mN6XIlGl2hh6UsWb9Bkwmpc5LeqUjcrWXqqDYy9Sco5DDYNlxEKieJRxmjv5rXHF7win0BAFTiZcEr3E4YQpBQgHbIAUBYevmShq2c/Mgw3shC0pB4tmJg5bf5bbSX4TnUdQuprA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(6506007)(66556008)(6486002)(26005)(6666004)(54906003)(83380400001)(6512007)(186003)(2906002)(9686003)(478600001)(44832011)(86362001)(316002)(7416002)(5660300002)(66476007)(82960400001)(33716001)(66946007)(8676002)(4326008)(6916009)(41300700001)(8936002)(38100700002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u9TlL+pLK21hn23CMzeRTHT18fKdefVtZ3/T3Prd1g727N5EOxfiDyvTixaE?=
 =?us-ascii?Q?oGb6FMQUnzbito+wXKGBPX0tVfXEOd8ZqSAk2hySqlj982JVAsdfKXYn0veg?=
 =?us-ascii?Q?wHVdi2x/QRZ92DcJ5aYcoDdB1uvTw8LCzUlMSz+pOAlFCy9DMpt8VhpTtQnH?=
 =?us-ascii?Q?SaoVrjf+XBmT8EomZ2Fvbx/pjY6Wiolw5vgQTl5UId3QsEHaN3fs3GzdWkq5?=
 =?us-ascii?Q?nUlcNbN/FlM4mPvBb3p7fMYjhW06KXOwq5bC1gZ6e+viGJxaLRufxNO+mpAZ?=
 =?us-ascii?Q?agLmwQh7RnsMIJ7IlRHdu6o+XPO22NOdBg929Ktt7Gwz3Nc1jY0fzQjsmDcq?=
 =?us-ascii?Q?mwFTBX1BbN5s2huLC6S2ixsou2MulZSyqTMcfn2o7RbEd3DrRwVoIpqah1wh?=
 =?us-ascii?Q?5GoZ/K0RAshr3THJsOQLiNhB2xdtx+6+MkA/Jh+jzQKfgyAAzy165fzhZsFu?=
 =?us-ascii?Q?6u1DjsQ80hd+Nw6vIikxmJwnEyrkMazsTh+6tK97JzkPl9FNAOl+BaxYupgd?=
 =?us-ascii?Q?pX1pCGxoP+h2iKxBshA2kTytV3YjYjlZDtai9RltNzb1nV+/F6I0uJKdPRmz?=
 =?us-ascii?Q?ZIhIc5vzfzfmYW3JQhlGSe7ozw80qVhtqGj7YVDxWpbZ3t7iMgXAcm7oLwb1?=
 =?us-ascii?Q?YUu72APEanq5l5mykoP6YzQBvNJ8Zn1/peToYI3out4fULiRQh8XmAkfsAnY?=
 =?us-ascii?Q?pPNPihqXgWH3aHtiIJdwG3giaZKrrW/pSu6xUE87bMzSH1ci4hyRNpJEd32z?=
 =?us-ascii?Q?vMryzrSaMPorD6UIVdjbQRZjTyBCI34z0ITocc24ARR2ZBFZcVsUpFVdwuTv?=
 =?us-ascii?Q?L27dJBliKiJYvFnAUfgUDiu2/K22dL/zLp2wA+eJ/8Pen3exJZInmjn6NM44?=
 =?us-ascii?Q?OMXH8Bq+8AEU9y53BvFxrr9pNzH1gg4NFteg4gyxxOFmF5LvumWzSlEgiSsa?=
 =?us-ascii?Q?QN4VxLETvZ1LoGi2fei0xPzROUzWNhGQVhq7eO9+KxdKmOvOmUK0rT26ZnYg?=
 =?us-ascii?Q?kw5H5r/642dEiobGnNI/76sWzoPUJLJsOM/u99aELTTLDxiGoPjuIMR2oF4P?=
 =?us-ascii?Q?ZjbYKFuxEPMBniBHT+TvhkboW0Gi35rxn6DTNqFbmZug7KdgRAqI7qPZFOfA?=
 =?us-ascii?Q?8J7sTk4gDAeo4EiPRf5ahW8EJG66OYnLfdOE/WNLMmLSyEZnKCMlrJmFg8H0?=
 =?us-ascii?Q?Yebm9VDjysgKX83pDob6i7fCU7gqYd/iXjCQ9HfqZ1xVw+wCnZMrrm+aWJJG?=
 =?us-ascii?Q?yzRVvTFmp0zfEubHljZYgcTCVzr+B6piroXJb9nHgTRTwEfpXiJalp20/hlY?=
 =?us-ascii?Q?vPeIubyR33CX7NatdDUCJxvOmAZyVZkR/1KmG4FW/qPiawJGrofZC16imKH0?=
 =?us-ascii?Q?TesyoSanQ2iuiLrBDU06HM6ts0tE17LXKj3uEBSXn5J2FNQUT0h8ozw/yi65?=
 =?us-ascii?Q?xPz0Hqw0WLM8hK/tR5MCc4IOLkuwwAwXSTUwNN1PM2Rvx2q1EQoKqnTsP1dH?=
 =?us-ascii?Q?uy+Y4f4Xn9DsfRK/Ncd/o4xANkMowgWSAi8//FG+zJMMGRYkKrIHvl62zVLa?=
 =?us-ascii?Q?KeFqDOH6CR52KMgBhsr0pn0++fPGtqokDkjOebXM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac00203-6aec-4b55-58c3-08db78a5ad37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:35:17.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zrvh3Z6in33uBlhDYOKIXJSidB9S2ecgSgMOe2AGIiDW36nVF2tK8EsEwHmC2MA5uiSI3QXfzJSeBq/Jrm3Erg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 01:14:34PM +0200, Thomas Gleixner wrote:
> On Sun, Jun 25 2023 at 22:51, Feng Tang wrote:
> > From debug, the reason of the hung/stall is detect_extended_topology_early()
> > is called by cpu hotplug after boot, where there is "maxcpus=XXX" setting,
> > (#echo 1 > /sys/devices/system/cpu/cpuX/online).
> >
> > It could be fixed with below patch:
> > ----------------------------------------------------------------
> > diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> > index 828c1f7edac1..1ff73c8c4972 100644
> > --- a/arch/x86/kernel/cpu/topology.c
> > +++ b/arch/x86/kernel/cpu/topology.c
> > @@ -29,7 +29,7 @@ unsigned int __max_die_per_package __read_mostly = 1;
> >  EXPORT_SYMBOL(__max_die_per_package);
> >  
> >  #ifdef CONFIG_SMP
> > -unsigned int apic_to_pkg_shift __ro_after_init;
> > +unsigned int apic_to_pkg_shift;
> 
> Bah, yes. I missed the early_init() call from init_intel(). I hate that
> code with a passion.
   
I tested the patch on a 2S Icelake with Sub-NUMA-Cluster enabled, which
shows 4 NUMA nodes, and this patch gave the right package number: 2

On a hybrid system Alderlake with 8 P-core and 8 E-core,
'__max_logical_packages' is 1.

I also tried 'acpi=off' parameter. On a 2S Cascade Lake box, it only
brought up one CPU due to no MP table, while on another single socket
18C/36T Cascade Lake box which has MP table, it brought up 18 CPUs.
The '__max_logical_packages' is 1 for both of them.

The patch covers most of cases we have listed, so feel free to add:

Tested-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng
