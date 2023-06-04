Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98269721471
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 05:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFDDTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 23:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjFDDTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 23:19:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7BCF
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685848770; x=1717384770;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=92yWJZAr5okpXC1xQxlnnLvnurKOSsMeIsOpFYT63Os=;
  b=LGku/Fqff9LhggJ708EPITvRHX9p0az5/Q3auRR3vxyaMSGQ4ND7ACBc
   xEjazQCnUgrsu2Z1lkdRG5Tjcle767hugd8SzHhD2NFrNyvt31LRlDgtL
   b1yWY4mJihbzBP8rElqqiNX++01NsGgCDScnqU+MVdayO6y1hBLPkgzp7
   0M/AVp9W5X8IPIG4A+znZhQn8SaQsc3osenO8avLZDpjgHR2VOLj30vr1
   0C5f71a27M0lDOTW5ZsK8zwAD9BKZXJbtXCUfhGUSTkB1rYgerpR2PHH+
   Ml6kXSb1aLZfGd1QdpCahGsAGbWywANwAnsJCg5d+kfZU3UNEHcSk42RM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="335766224"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="335766224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2023 20:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10730"; a="737969515"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="737969515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 03 Jun 2023 20:19:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 3 Jun 2023 20:19:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 3 Jun 2023 20:19:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 3 Jun 2023 20:19:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUMh8GBevjS3//R8jWHmdxA3DCx8Vni0iHkgIjcXOY7i7MNCaTJNehg2PDWod/u7wfQwB1fD0omz0BRG/Jh6R9YcByXVTAylBv5UmGLkMFk7ueayTfiSydgTMj77R66WiyqT/zgzERI49oGollXks9Sub1tpJm3OI2NxQqTb6ZO/TJMwMSh0X3hCKcJQJoQkk5mIHIsdeyxJrqcr3DB0jdX0cNZ6jzYyx4YCuVrozdR0rQX9sD8Bl5MGzMsUTWuvblULDQcYE178gwD+L9ypkdzkUzFO/OdjCKlTb1XPuQ5ZK9OyhAzqoiG5Op0j4YspFHPQE34SsYgf0Bm4Z0knWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsCTjrAxnkM0SU/jbmdF/81euqd7ytfk3+ZmPxTUHjg=;
 b=Dnsu0Wm2uv1S28Wha/ZvU6DOAoK+JapDbWgxJjcK4igmyGt1356Nx3UVkUu9jls+8kSRpHhAvrp3cuKpGuuCUUbUGr1o8GMkFaxw/2BxlF2Su2Egj1qkkgwXfU4QlCtovtTbVX9Pa1lWHlqktcq5dmMrLHYgYYKFi8Vgm5aywA1xRJfwFbt99EXHGQb98Y3LaP25Yh7QksUJFumR9fBpt4RTBV5zXjjw7DxGivW4wsHwd/guBGWJivQMGvniDIqaRSWIkA3Vqel3f6w5S/JFllLGvJXtE6KmM0/LHSvHO88sRzPl/z1I+AMVUSYDACiVwZaByDcOFyJ621otVCkCfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 by CH3PR11MB8590.namprd11.prod.outlook.com (2603:10b6:610:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Sun, 4 Jun
 2023 03:19:27 +0000
Received: from SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75]) by SJ1PR11MB6201.namprd11.prod.outlook.com
 ([fe80::ba9:70d4:f203:ff75%4]) with mapi id 15.20.6455.027; Sun, 4 Jun 2023
 03:19:26 +0000
Date:   Sat, 3 Jun 2023 20:19:22 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Ashok Raj <ashok.raj@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch 4/6] x86/smp: Cure kexec() vs. mwait_play_dead() breakage
Message-ID: <ZHwCurlgWM+Q8wCC@a4bf019067fa.jf.intel.com>
References: <20230603193439.502645149@linutronix.de>
 <20230603200459.832650526@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230603200459.832650526@linutronix.de>
X-ClientProxiedBy: BYAPR01CA0025.prod.exchangelabs.com (2603:10b6:a02:80::38)
 To SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6201:EE_|CH3PR11MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e899610-3ccd-4c3a-6bbf-08db64aa800b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1qbDJXh13xYBq6ZtCeBMEWmH6U2Y0UkK7n0s16PSxt8AdZuGGMcy+4YKVZV+579hIu8bKcFMT6VyxHUya2Wt+K6sBdjm6TizS4uzLCrw6qo85WtIIMxZ8bzw6Y6NiGlQA0sGl5xF3RYua/kAuHhSVpuovZBhSmU5UE6FgVZLSvQQAoPD0kudxq2wAGNGmPZi9pb/hZF9KaEQbtP8WFvRjKYQnt28/OoPMY3a8830WAabt29Kqgo3eOhO1yz4C5z6dnmbtL9zGgh/WIbjaBlY8B+RLpqHC+YYoK351TYPhNj0bLgjCxdOdq8nwyqzCdtzP5k5MtbriV286rxODf2MV0FLRmRHqw4WdbNLgxGsFlQmA00wcpOL8d7m/j6yLjlUq6iTgkBW/8MRhxgPu6KNmI57oUVRqtzrgUkiIjitDZ56Wjb81jKVoMMROSqI810G3+23SWJeqfeW66gWK61aq013RxvFLCBDVKQt1tylpO95Rs08WFChBB+qyTT7eqSK8Ep9MLtpSUkFzf6eB7aK0CInOC276WNLI+RPeWfDiGNTRk5R24f77k2sRalPMsB6hRID63wC7yU0a7ALdK7r05QrPG34Bx611gQ5g0j6EA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6201.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(396003)(376002)(39860400002)(451199021)(4744005)(2906002)(54906003)(5660300002)(8676002)(8936002)(44832011)(6486002)(478600001)(6666004)(83380400001)(86362001)(38100700002)(82960400001)(41300700001)(6916009)(4326008)(6512007)(6506007)(26005)(186003)(316002)(66476007)(66946007)(66556008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PO6opGMXvWrY2CHairYGvmU9V8Z7lBeHc7R7L/bpMfBk6I65HTyvqHXWrwnz?=
 =?us-ascii?Q?PW+D0jRFK4c5ypXhjiY+82C0taIReO7dc7Uo0y9QaN6nuiG7L81b8Cgzt3oc?=
 =?us-ascii?Q?wCmHkxtOIXpA2x/VqhbH99l1PbX/tfis1ymW1TxHMq1/D5XhP3GOlrvVIBHT?=
 =?us-ascii?Q?8D300Xe5Rr/KUQNduR0vhyph2hNiZLWKCoHuvOg26roGWrZoPTMVdPxl6j/0?=
 =?us-ascii?Q?6byDd7BHvym1uQQgRXtYG/j7Beviodmeps34twv2EpPpNg+05ikYEITx38PM?=
 =?us-ascii?Q?18obdsPWdpWytKzscAg1DWkqtjzQ1dt2tO9DnqX7IpsaMyl9/C4g4GsvSWpy?=
 =?us-ascii?Q?BmO+s4ikhuKkQaizng4RlVgIrw60a96BxNFjg+RzWrUIJqdytejDsXC2v8Nm?=
 =?us-ascii?Q?eXSAiPPLyzOMj9ivHWdvEVlWy+OdRaymycWwNYcJIgqWpTGtO9PL6ugg0+rZ?=
 =?us-ascii?Q?xTRVljzxBCQlnVcsdLZJutCjc4Db/yBYI9/J5XRuOJM/OoaT0YSzQV8dYXhP?=
 =?us-ascii?Q?2MAL1KnHIvtfK+0IGZnj8fZMlT87TI1+4CrygtnXfLoBAsIyYi4OBluFcVbV?=
 =?us-ascii?Q?A1jm1JiM5JGeQIAS5nU2jfrYhAtQwjVMXX9268s6xWWdvYzsgwfVJmQHkFJ9?=
 =?us-ascii?Q?A2kgSjrhu8K67WI6FQ8b64vMc2XrISBu2n9PuaAvvUUkz6RYTU842uFwhjOV?=
 =?us-ascii?Q?TaTMcVPqrFM+FE8NZpYOOqNm1QxiMUL2nslCgADAFhVPyzQT8KgCc1haXauI?=
 =?us-ascii?Q?fkbxDuo6c1Y6aVRr6CM36luf9PqxhsyGd4rtjmktd4SredzCX2v7NLAXLP4H?=
 =?us-ascii?Q?UyIuRieIHampED3GUZr6RkimavXWcFb1X309jgKHa1vc8l29fw/rR/xQBJA1?=
 =?us-ascii?Q?nsqwHdct7VKMAyVPH1xf01tmSGYV3gVTrvjZ1pkBsrdwTiiiC8dvpL6J5g3U?=
 =?us-ascii?Q?BROQewApSc4Kyb+q8UFx6bNjETRNQRihbfH3OODsqn5rKvyMY8Bjvjuqqqa4?=
 =?us-ascii?Q?78gBFwMDyIj2aiPkGj+v4LRK46IT+OK1p6KHnV3mtrsJ4t5evcSY6s8FAbWP?=
 =?us-ascii?Q?aY4NCCD/1XUN0oXho5a9NOA38lEcz6WydLKuf5dKsFg7pogepN1OjS0XIDXm?=
 =?us-ascii?Q?0iJ5dGHX9oamz6Mx27AMIKFkj17qPYV4O3Mv3gHgTK9vf1/jJJs44Rivmz5d?=
 =?us-ascii?Q?5SoAj1p8IQ5VvYr9b1tRUmZT/GtMjgcHUGf8mQwLc/veivo9I5JIa1KlbJvD?=
 =?us-ascii?Q?PoP1J3OGvaTapMXg//PA7Pi8Wh0H08uGak/cG4ytm8plnqVDPwGOm+lpixFo?=
 =?us-ascii?Q?I2BcjTAWt4jvNr5elLuSC+3C70vSYTgzp1Gg5O5qKBcfYPKlqTjQ/5IlsAlJ?=
 =?us-ascii?Q?N2IBuqx2GRug+tCi+TrpxfsRrJyj5wp1Rx7RyB0hXGjg9angwdaV+GBH8lAb?=
 =?us-ascii?Q?IMapkuEIVQeNVXjkRJYn4AdTjh7LKjjQBN5gPLnyHaMWG7EVlAI7j9/tn5B6?=
 =?us-ascii?Q?9IsW5yHohSHIahL3zLlTfFHqvyMvsplEIgB3IHgHCnG/Dghyow7nCkQakQSZ?=
 =?us-ascii?Q?qXxHk2B4/nS0oLMDjrdofXl8U0ZLkNQTYrWaSJ2c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e899610-3ccd-4c3a-6bbf-08db64aa800b
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6201.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2023 03:19:26.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JnYwNrVf7hywk5R9Cowdyfp9xlPiDwrM3ZMxs2JQ0oYcJklovIwLsIhamCPPyoPvVhCE9fRYmC1Ereg+/vNJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8590
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 10:07:01PM +0200, Thomas Gleixner wrote:

[snip]

> Fixes: ea53069231f9 ("x86, hotplug: Use mwait to offline a processor, fix the legacy case")
> Reported-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/smp.h |    2 +
>  arch/x86/kernel/smp.c      |   21 +++++++---------
>  arch/x86/kernel/smpboot.c  |   59 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 11 deletions(-)
> 
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -132,6 +132,8 @@ void wbinvd_on_cpu(int cpu);
>  int wbinvd_on_all_cpus(void);
>  void cond_wakeup_cpu0(void);
>  
> +void smp_kick_mwait_play_dead(void);
> +

This seems like its missing prototype for #else for !CONFIG_SMP

 #else /* !CONFIG_SMP */
+#define smp_kick_mwait_play_dead(void) { }

Sorry I missed noticing this
