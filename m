Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CB7654BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 05:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiLWER6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 23:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWERy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 23:17:54 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185ED5591
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 20:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671769073; x=1703305073;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1rtQMSEbKOlyFDFmbTrjH8ErIPcA5/tCoAmsSTamvus=;
  b=nStuBpcLZhMc8cnFh7jo1/VaZX6I8UMQqf13PDuZC/tiX3ZpznOhYUpf
   jDHazTW2RPJY5D4UtSo/ZxaPt7zNhTQ7k2q/Gg7HYCCnMh32emdS3ZqPo
   GsZqZLKnPsujlmeKYp6/IPAPUWY8Qj9MtkBM+REIQDns/VQvM7ERohadU
   SqgatCTOa9RZAPWh2pwBMK6FpTNBikR/9SroaHpRuw1VqSdLWHXEQ12cv
   h7ksiXoIbbnwovSmIRpXT2B95nyOCCkaZa2YAsf6NkWAUA6qMDs7x35FV
   6gPRzasgg1xuQMmR1zzFPNuIKdkZChexcdCDr+2udqu5It5K0SUxW0Pv2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="321477498"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="321477498"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2022 20:17:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10569"; a="654099578"
X-IronPort-AV: E=Sophos;i="5.96,267,1665471600"; 
   d="scan'208";a="654099578"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 22 Dec 2022 20:17:51 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 22 Dec 2022 20:17:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 22 Dec 2022 20:17:51 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 22 Dec 2022 20:17:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJcmVQo7wm0wmaL6g8Z3XRabFTqnIQIvqVhzch8VhIztkexwhN1g6g6uiInLN5+D8LFY+IhfLHg1G2+SWRK8IgfLKDa7PcjBJ6plNJOdSUwK7YJszhmsEQrSXGNx5HSDMgQBTcyd4NaL5EjGhB+ajG3D4tDvA6KL9FVUo12qScSp1dVPhR+JP4/dUBj5MPJp8wwHl/AxZrmXSI6IcEdxJm/jpCHFXHf5vUBlnH3ajNFtFVKJ2pCDFFBebgGGsAYOvK3zYCGaMcqKWQQa6U8IqmLl0UriydX6JZk42UnErLOCQlisZpeXEAspwjqQFh5AijqEXrp8foJERfC5nIMJKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEQlJqcIfmCUPPXw0LEWKftRTJzHxbXeArDNvw+bftg=;
 b=a4QoH8FztFQzZHLCEzvvDVkzTZnNuVm48ZDLoO2pH5E8LXM7gp4XwJh56/a6qxiJAx/v4cc6bBwkdGkoAc94Loh3la064PBrxn5MK+G6L/M8vN47c8tExHAmzBKHb8jSxqv2F5rlsv9+z8UZa9l2AFGnE3TJaqIi0bJBbVgR94yprBgiCe1SO5fAvYgMIlXyiy7IMLzRzQTSQGF/ZuMmevYOXgx7B9SGePmbKCgBwpVary/yK56te1fJNycsIj57KvQoX60Ky/F8Xxmj6kGc9tfaI5SE15ZC2rCQ2/bI/ckB8MtGOIPhWOBAa3LTbZwIyThrlNsKE8zg0elEfzvTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW3PR11MB4521.namprd11.prod.outlook.com (2603:10b6:303:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Fri, 23 Dec
 2022 04:17:49 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5924.016; Fri, 23 Dec 2022
 04:17:49 +0000
Date:   Fri, 23 Dec 2022 12:14:57 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Waiman Long <longman@redhat.com>
CC:     <paulmck@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, "Tim Chen" <tim.c.chen@intel.com>
Subject: Re: [RFC PATCH] clocksource: Suspend the watchdog temporarily when
 high read lantency detected
Message-ID: <Y6UrQd2VIyakhV/U@feng-clx>
References: <a82092f5-abc8-584f-b2ba-f06c82ffbe7d@redhat.com>
 <20221222055515.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6PyisHYYtde/6Xk@feng-clx>
 <20221222061429.GL4001@paulmck-ThinkPad-P17-Gen-1>
 <Y6P7JPHf9wDse0XK@feng-clx>
 <20221222182446.GQ4001@paulmck-ThinkPad-P17-Gen-1>
 <20221222214219.GA1875767@paulmck-ThinkPad-P17-Gen-1>
 <Y6UNwAOQIGWyDfsX@feng-clx>
 <20221223033729.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <ad71008d-4acc-d211-dc19-c33bb25ff42c@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad71008d-4acc-d211-dc19-c33bb25ff42c@redhat.com>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW3PR11MB4521:EE_
X-MS-Office365-Filtering-Correlation-Id: c2bdfe9a-48f4-4796-e089-08dae49ca6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOiqPfQ1wS4cW2qde2ov7a2W1AKgOX2dI4PjqRges8KaqK8GUARkfQ8iPTZHg0XhHqUYvnXIFTZ5m+RbxsYt3bWtDCsWapOOIzlmRSy++nkn3cWe5890JsSd0m3FGysm/7/jW0Gg0N4koQIFBNpLASzzj1HXHK+l0litf5XUnCvMyjfVbKHRYxvPY4Nn2H7QLDoUdc+d4MPQhtuHD6AdyJORLHudOUxGmMem+XR7/q06zKhxj+H19LGkv0hPCRGD9nD6ptiR6wVARor8yTryD3IbZRN1U2VlLv3Bxc7GF+LVqCbDRRd01gu0BCr5/KHhqddY2a1xJWMbrfxV2xO23WZqBnF0xpMWMG9sxxJre7vmj+UFGoMGvI635HilpsUxv7/gbURrsqUpW+LHxIyiWdjZF0gCOgNqEVE2BVQP80JFOAAGwjaWxJp/0RuUQVdZydbK25sbrLrxEVEvxdRYq2CDUQHYWxwjN+hDk/OOWfimqefS5+4ysF5GSckayOD0C7gNN4NxaSXmuYDx6ebuCWYZ69uoOJp13FCjX9eHd6DxQr15fixuVplVi5I8HI1UDIQhm4nDro4IwS0mhhIunHL56+DwF6RNWqhCYmtVRu4A1kZQKAhcQMD6yurKorIivpA8vwGFGK2fegiM5ES2KePczqrbJ9TeN+Ugus0ujv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(346002)(39860400002)(376002)(366004)(396003)(451199015)(41300700001)(107886003)(86362001)(83380400001)(5660300002)(8936002)(44832011)(54906003)(8676002)(15650500001)(53546011)(6916009)(82960400001)(38100700002)(6486002)(478600001)(316002)(66556008)(186003)(66476007)(33716001)(4326008)(66946007)(6506007)(2906002)(6666004)(26005)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pP1JeNwcTkpjUVBKlE/4wGZWnJAkw0NOoSxeVmMv1xJFByERZ9wsWsmariCu?=
 =?us-ascii?Q?kNJVIJMSrPVsYkiyxF7yPVSD71I1aAIZ5ILow/uqEcVkpF4j9dc0dumfpn8H?=
 =?us-ascii?Q?K9nhXM+gigp0Xp8NgDCZ5vR0ZfhJiKn5QLdNO2PPCdnSeaOxcEOeM35nJmfd?=
 =?us-ascii?Q?AgCJe+HgTc6/eGxMx2oCOETj6DcM7gki8Fvxr2cn7W78YwPNLyELEiWVnqhP?=
 =?us-ascii?Q?GzukUHpwYuBdTDIRUBl0Tnl1oLb81bU1SkXveUmb2m87leMUudg3c80msFNr?=
 =?us-ascii?Q?cx3tdle06LxY/WLGllaLAX1kQGa9KGYVBbZ4b4lTlPmylyCKuSqJLfXTDnoW?=
 =?us-ascii?Q?Ki416vebxNzSD3yoF/lO5A5nTCUUF7MGV9Kfl1PvcYZC4Dxl+QhPWogPsAGP?=
 =?us-ascii?Q?qO5qrKhUwQ//5FJgxe6nK4QQd6KIWBe3MHq94EVPos4L7ekQ3oYvCzmlMGt6?=
 =?us-ascii?Q?3ao+2LO/S7mWWTGmK+yrGfJhtm1BOhlQjO1JYmZlvzdil4VN9lpUTvSiQTyt?=
 =?us-ascii?Q?BkVslPpdUKj1ZsemEMOzJRMFrwLtM5esOH0FimJV0eRw3NDBug4dPKkDVJtx?=
 =?us-ascii?Q?vGSkLtH9sogZC4A3dsjRQXoh2z5KTZIJRBiceddOr/QL5ROX70zEdpyMyG9y?=
 =?us-ascii?Q?pxhSu530/o8IWsKqEu+MPY44I6dOYXzg3uNewAPpwsETfm9tygL4SSPP2eNT?=
 =?us-ascii?Q?d9KaKoIx/shlWgMEd1HRGnau77ZnVZe4aDHjvtEAzG/BJw5+zNUXeo1OK9uR?=
 =?us-ascii?Q?AlQ6SmB6vLzy+ci3fgGhpvQ1PnMMWGQd9p0aRJX0HuCCnSoj7YbSg19Bvmj3?=
 =?us-ascii?Q?d28B9ZfWMnFomDPG/jYu/FVOM2SgwW/DK+2T9tiNkmE+SwZK6kj2sbjt2whL?=
 =?us-ascii?Q?IVyDY36E/3n1Jdt0XziQEcRue1R0UhDI9BbYfZvKdAL++TwpoDRz45Ww+lz9?=
 =?us-ascii?Q?sltL0SlR5xggoOr7P6j4yVbeNxtWbs7DwXAPVjboysz4QACqdBgI6+dfq4PG?=
 =?us-ascii?Q?HdF29UXeDoucPuukamsr9hnQJpTbLLkXgLmCHmqPcCTsAEkY72KijI38NkLn?=
 =?us-ascii?Q?6f3tzAmkU4MjsF4Sxt5f5L+OZkOLL+IeHB73mDelC60JenDwD/JWT9Brw0zi?=
 =?us-ascii?Q?0a+3VfMYdLmgdI9Hr23WEgmX/6HRaYTG2Itsun1HQp/9dWuqsHzDaH+W2OWi?=
 =?us-ascii?Q?9IK3WQnCB+2JIMnpksmO4A3jY6+fK3lOpEPy8UeoC2QmlKQamtziYCYJ4MJu?=
 =?us-ascii?Q?TGLGbgFIvBiIMlEDC08mgvUeDm8SilfRJG/CC6ulSlS53oMOgIhmiMG5vB0t?=
 =?us-ascii?Q?HwzEeYHWLYaihlkc60M4WboZ0SO2rh1ZoiSxiCto1bCFcE7Vs92yywR+d/Zr?=
 =?us-ascii?Q?smOtDCCp3OGsG5tTfAiyXwChi/+MyCRscAfgG/SrD+U0f/paTfTlrLCa2uZH?=
 =?us-ascii?Q?0sU2KWptlWzTq3I9APL+GdO6Eq8RqdI6L9aVUXPdmizDDH4ip6/fL79p+akO?=
 =?us-ascii?Q?l+J68eSCH5TxmTw9943uUxuEl79xOr0eQFfyKH20HrPz/fXvPl4wTO2FrEfK?=
 =?us-ascii?Q?oHkOGOdwj41GCdTGpf7Mhdvee3FHrVat8s9tjM5q?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bdfe9a-48f4-4796-e089-08dae49ca6d5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2022 04:17:49.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2vmOBBB4G1ouXtgxRNgzZKl4UVV3lEAUFWR4+gmj7oLSVFFWu/l1yH1+b3gTmbbByAatumHOAOb97B1iFF3Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4521
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:49:23PM -0500, Waiman Long wrote:
> On 12/22/22 22:37, Paul E. McKenney wrote:
> > > > commit dfbf67806c4c7f2bdd79cdefe86a2bea6e7afcab
> > > > Author: Paul E. McKenney<paulmck@kernel.org>
> > > > Date:   Thu Dec 22 13:21:47 2022 -0800
> > > > 
> > > >      clocksource: Permit limited-duration clocksource watchdogging
> > > >      Some systems want regular clocksource checking, but their workloads
> > > >      cannot tolerate the overhead of full-time clocksource checking.
> > > >      Therefore, add a CLOCKSOURCE_WATCHDOG_DURATION Kconfig option and a
> > > >      clocksource.watchdog_duration kernel-boot parameter that limits the
> > > >      clocksource watchdog to the specified number of minutes past boot.
> > > >      Values of zero disable checking, and a value of -1 restores the
> > > >      traditional behavior of always checking.
> > > >      This does change behavior compared to older kernels, but recent kernels
> > > >      disable the clocksource watchdog completely in the common case where the
> > > >      TSC is judged to be trustworthy.  This change in behavior is therefore
> > > >      not a real issue.
> > > Yes, this changes the general semantics. Last year, I've posted a
> > > patch to limit the watchdog to run for 10 minutes, and at that time
> > > Thomas mentioned one of his machine may show tsc issue after running
> > > for one day depending on work load [1].
> > > 
> > > As the intention is to validate HPET/PMTIMER, which are not as
> > > delicate as TSC, maybe we can add a per-clocksource verify-period
> > > field, and only set it for HPET/PMTIMER?
> > > 
> > > [1].https://lore.kernel.org/lkml/875z286xtk.fsf@nanos.tec.linutronix.de/
> > Got it.
> > 
> > The workloads I am closest to are OK with the clocksource watchdog
> > running indefinitely, but thus far the skew is visible very early.
> > But broken hardware can do whatever it wants whenever it wants.  I could
> > meet Thomas's request by making the default be indefinite, and allowing
> > whoever cares to make it finite.  Or maybe the fact that the TSC is not
> > marked unstable makes a difference.
> > 
> > Thoughts?
> 
> Sorry for the late reply.
> 
> Maybe the default should be an auto mode where if TSC is marked stable and
> don't need to verify, we can run watchdog for HPET and PMTMR for 10 mins.
> Otherwise, run it indefinitely to not change existing behavior.

Yes, sounds reasonable to me. 

btw, what I suggested in last mail is some code (untested) like this:

---
diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
index c8eb1ac5125a..db20aac5d14d 100644
--- a/arch/x86/kernel/hpet.c
+++ b/arch/x86/kernel/hpet.c
@@ -862,6 +862,7 @@ static struct clocksource clocksource_hpet = {
 	.mask		= HPET_MASK,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.resume		= hpet_resume_counter,
+	.wd_limited	= true,
 };
 
 /*
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..2b6278f69516 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -125,6 +125,8 @@ struct clocksource {
 	struct list_head	wd_list;
 	u64			cs_last;
 	u64			wd_last;
+	bool			wd_limited;
+	u64			wd_iters;
 #endif
 	struct module		*owner;
 };
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 777a5eba68fd..eb2d9adf06b0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -425,6 +425,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			cs->flags |= CLOCK_SOURCE_WATCHDOG;
 			cs->wd_last = wdnow;
 			cs->cs_last = csnow;
+			if (cs->wd_limited)
+				cs->wd_iters = 1200;
 			continue;
 		}
 
@@ -492,6 +494,9 @@ static void clocksource_watchdog(struct timer_list *unused)
 				tick_clock_notify();
 			}
 		}
+
+		if (cs->wd_limited && !(cs->wd_iters--))
+			list_del_init(&cs->wd_list);
 	}
 
 	/*


Thanks,
Feng

> Given such a default, I don't think we need your second patch to determine
> if both HPET and PMTMR needs to be checked.
> 
> Cheers,
> Longman
