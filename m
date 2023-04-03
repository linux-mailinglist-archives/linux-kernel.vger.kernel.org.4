Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250B26D4BA0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjDCPRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjDCPRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:17:44 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C346B9
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680535062; x=1712071062;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kFDl6obvXAJR49U1KBshsgt80p1GLmExO9N97Gfn+Ik=;
  b=fW++ydDSZgM1Kzt7z+NPqVXXKGkq1bh4XfunZOVK1xwzdaOyjVk1wIyU
   unoo4XnitLKKBAuudNJQ2StPP+baF2uZ84fatywV9JwDZBzt3t+4BOw97
   rdjmkqdrW0jWKY4Ez0LcOhGmdekyBm6sI5UcHdLT+yR5FTiWr3Pcud6Rm
   J+jgWgZn8KcTfk3sDMRYoesDh4LXulHac1KamOAM5xCXaAbizvTuWY1n/
   uAtcSVsXmIconm3G1etz3pyDwC2KnRdhvxZpS84Cx3qzTnUGgny4/jas8
   CkQzhWn0ZW3COR6SarzaQP6ziA/5138Zpwy3CGQ1bgaVPMPE/RFlnuPr+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="341951768"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="341951768"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 08:17:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="860241123"
X-IronPort-AV: E=Sophos;i="5.98,314,1673942400"; 
   d="scan'208";a="860241123"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 03 Apr 2023 08:17:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 08:17:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 08:17:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 08:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noTIHWhZ0FrnQp4p4XIUqafZJJe3SvMxKcmul4glwRveRLfuJfl8vnLy2L8SAeffkU8aL8pYnMztDpjQBB25f90oidxp/1GfHK/RUUJAV675Qo3T7FN7mvMOGMfTvismGOk9Tdl8HoI8RTNCTefekjPLByKtfeRtVMOk5CiHRogMdsBwo60AfE2igbRuBnf5Zpu6g0AabCmn73V6kAInqEx7Oz2CrzttbEUjxbd0QOuR7cGTfCvofL52pWkEf5D5nnMslTticIaIOkJ/KbFQEYKm/Ed6kaKAQpgHsRzUjyxaHOgBd6WcJLDox+rYT8dStuJriD69J7km3mP4owgobg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O2T+FBimlO4pkd+zeXkjt0AYoVFUIw9uCcBlUftRss=;
 b=S7qI//SLDnpmR7vH6ItA+PUx12u3Q9riKz7aSKDe11blhO/oBC3tnpYXKKVYGb2hiA7+SJ2sTTrD+C1jrI4JIZ8S1jq+dEohADsCaJjaM3naM2Qa+J1h+mDDm29cWJogADX5TYgKOSbOeuJn5r4ekFEhcdvcNgSMgSvhXgGvlgtmyc2Auu/B0waoqk8SoLClylluOyXXCkXWlpuNRD5GdDgY3iR52GPQFSK40rn7Pd6OGvJdHkcxyO6liQWpHMgTIHi/yc9UUFL0MqJubfVEw4yQvXkSL4J37bncskU1DLreV16dmoRepU8zXtCOhuEJMGV4UA40PZGdlEiV4IyYHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 15:17:39 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::a100:94c4:fab4:f14d%8]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 15:17:39 +0000
Date:   Mon, 3 Apr 2023 23:11:40 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Waiman Long <longman@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: A couple of TSC questions
Message-ID: <ZCrsrGLg53clGN9n@feng-clx>
References: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
 <ZBqOyLByOgvdAve3@feng-clx>
 <acda3fb5-373a-48b1-b78e-eea18da4ccb0@paulmck-laptop>
 <ZCD9SnZSUCkE9Ss+@feng-clx>
 <aaf391d9-98e6-47d8-b402-c90b4a81ae9c@paulmck-laptop>
 <3daa086c-b4a0-47a9-8bfc-aac4139013c4@paulmck-laptop>
 <293db107-a572-592f-cc27-e59ab81a4e60@redhat.com>
 <ef61060d-9f40-4b44-9a51-026041fe75e1@paulmck-laptop>
 <d0be6b59-11ee-f899-19e5-b84eba003ac8@redhat.com>
 <b2436d38-771b-499d-b6a6-2c42a98df659@paulmck-laptop>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b2436d38-771b-499d-b6a6-2c42a98df659@paulmck-laptop>
X-ClientProxiedBy: SG2PR04CA0193.apcprd04.prod.outlook.com
 (2603:1096:4:14::31) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|PH7PR11MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8fbf43-e727-4110-7d35-08db34568faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQLWsRolM++x2iaUzDPXC6vph26KN3YFQP/KiN7okh2XJOn9+S8MszgnFVIGLQTzHSPRE2rLZsOP/K+611nkMutylFxMEPvnWp7CUZA3WOW7RQUdkmCSDe67gs2qeBJyrROlkGFUVVIYdd2ENmOHjt06Yam3iLGkpVymXhEcVsxlWLbcWttKz/5muJJOJjkDfbVVemd0YGqta+K5gF/nlvjItkze4//JnD9/6bKDpmJIt6PnotuQOtjfXB7xAV6qQ3OFXXefO95P9RA64HFFJ5+CwTOfW4ZX6dytJntY0OpZNZa68XXpW4hVmIMFmgS7AvB8JlL8pcxvblv+lBdGDuYO1MGdtaDn2T/4Av/qekZ9LWpA/x2stBhBLfqWQOaA4BaAVQaapHDYJqHSvtmaFQT4IrYuPGjgnVuTBHfUeRC9mXRuIls68EEjai+KJRUYQzG92/dzc635OnITDXNthxvmmgJ+fw75WpmRYwA2JqrvFjVny/vTXLtfOebhORYtzVasH6kCenrzG1j9wTGhmEm1DUacwg4Ppd6YzM6xE5A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(86362001)(66556008)(66946007)(66476007)(9686003)(53546011)(6506007)(26005)(6512007)(8676002)(6916009)(4326008)(186003)(6666004)(966005)(6486002)(54906003)(33716001)(316002)(478600001)(8936002)(5660300002)(38100700002)(41300700001)(2906002)(83380400001)(44832011)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sv753gfWyDRRrSlMWe+u7T9xLilJMwF0LW6IyBcQcwP2JXqlOJWCGZiBsbQf?=
 =?us-ascii?Q?GPmzNw8J3jTnPobkxu4R67z6GKDS3E1Y+B+FRsh1nNav2W/iTkqEUGRQW58o?=
 =?us-ascii?Q?XxIVcfaC3qey6MORvRTcQI3INP05ivG+YA+pdQ3WRyTxnqk6l5DWOLl00g/8?=
 =?us-ascii?Q?WuTIFgNF1lo4XtK1Jy/jye3q60UFvt/9Z93CVI3EU1tuF7v0aFuE2AFhsQd8?=
 =?us-ascii?Q?5JU1YfydHviXqiqL+c8m2sTkEyaIq1HyqUFJjFS2RVaHCcyMhG6+adu46aqf?=
 =?us-ascii?Q?co/GhZaXxsxemSv8bLEPcUH59T/i/gl25+DGo0HJMHxWiBIzNrlFL6T1y56C?=
 =?us-ascii?Q?y18GZEUVCIm9HUoOLjvisza18S9PKe2WEFUHOyBssbBOeKYbXmY45ZdKR9Dm?=
 =?us-ascii?Q?ki+06d4xuwb5GlMG8/hXfoufUVrkci681CrhiNTn8jqcursIBrENwFld2O3f?=
 =?us-ascii?Q?MLljDmNsgLIUD7zcWGu+ms9zI1jZjy6vRGaLp0sCs3cBwzLH+oyTxUR+83R+?=
 =?us-ascii?Q?kcJklPED8WSkU45LUovnZHyHbC73Rqg1Jf8Oz6ZQig/5sEJcBPTtyeYMK62s?=
 =?us-ascii?Q?qD9OiXrp0SxUthaqnB4v8ZzGEg5ubwfQbpTxOyAn7kitY5eISLcI7HRqd9aN?=
 =?us-ascii?Q?ZoHh+a19HzYZ/90f7oPTvY7v3R7kCWbjjkjKl8klrsdS5e60ZoBVaLk81O8C?=
 =?us-ascii?Q?nlWgpfdgpeRNPinu6iWEuxc3WduXHr9pmfx+FdHHx14OyVtOrxtpu2On/YCh?=
 =?us-ascii?Q?+m0zZrMDCepj2fLobnomFppv83I5wM7ywQo4AgG74inCu5jmZRMm9YnBxTv0?=
 =?us-ascii?Q?wtcXRxMOymIhtCWddPPBpPecs0hmQ4g1uqNZi1Qj4mmhtht+15ARzXOwaFQT?=
 =?us-ascii?Q?Gf9tfj4mtbImXhC+or3ytB1q18af9Rgo9NwPCM6916SYwdFukJFAd84PRDvU?=
 =?us-ascii?Q?1IxDVJ1dGgUMvUxRoHC0aJMXUgfcpXS0+rakkIqOyyb6A5puD1C7ket+4mRV?=
 =?us-ascii?Q?P8fyrlrqAiW3YCe+I7o6gRppC5mztu+78jY0uEPFQ/ecxhDHD4mYUEGRvhs7?=
 =?us-ascii?Q?/T3EyBsudUR6oPt6s+ohP/geCD8lPl+VXnKhsFhcYPu+RHxPWZuazp2qq3T1?=
 =?us-ascii?Q?vY3536hh/ZdL3s4HvfiidbcFhg1/eiTd4Cjmp6WMC8m5HrBN/mmq2KV81XGe?=
 =?us-ascii?Q?UFu7ot9IE8Vl77fOFEu5Kk2YelNzHdYhLXJy6uWITSgh7w5/xCEZOQ+QUjXv?=
 =?us-ascii?Q?i1yGwJp6Q/xkwABMgRJg1RVN9m7qdr6rx4mJsy2+N+AjPCsdwrE8/RTPHA37?=
 =?us-ascii?Q?J2qMybXozMGhhjJ6jW0I+0fthSzaqQXuuIM21iogCKtG3e+ci6yarwF+oQbk?=
 =?us-ascii?Q?9TppMPAeabOyc9x0qqk1pZ8PG8mITKXpUyTbfZ9r6ZPAQUi1GVzKPgui5qM6?=
 =?us-ascii?Q?UjTLTb4BJeklEVjNbxua/dj/vGldwKq2VYGjadw/XYKUBD4w14a9a2dJCqJJ?=
 =?us-ascii?Q?pamiKExSg18wxZpN9kADiQpMZLLAWvilZwYKfZrrsyAa/kQlyFqndrkd2r9Q?=
 =?us-ascii?Q?25KUqO19MQhHGHBeuzDlVnCwkAg4+zUM6ZNh2f7n?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8fbf43-e727-4110-7d35-08db34568faa
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 15:17:38.7112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/FbQjeNZqNTD7PfR7qtqSpE5eVSi53mU1s8ayPgrxqntf1fTER59Es0SexjjGxY9uX6lbe4/uoVy/3EWK0dRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 02, 2023 at 08:38:37PM -0700, Paul E. McKenney wrote:
> On Sun, Apr 02, 2023 at 10:05:51PM -0400, Waiman Long wrote:
> > On 4/2/23 22:00, Paul E. McKenney wrote:
> > > On Sun, Apr 02, 2023 at 09:04:04PM -0400, Waiman Long wrote:
> > > > On 3/31/23 13:16, Paul E. McKenney wrote:
> > > > > On Tue, Mar 28, 2023 at 02:58:54PM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Mar 27, 2023 at 10:19:54AM +0800, Feng Tang wrote:
> > > > > > > On Fri, Mar 24, 2023 at 05:47:33PM -0700, Paul E. McKenney wrote:
> > > > > > > > On Wed, Mar 22, 2023 at 01:14:48PM +0800, Feng Tang wrote:
> > > > > [ . . . ]
> > > > > 
> > > > > > > > > > Second, we are very occasionally running into console messages like this:
> > > > > > > > > > 
> > > > > > > > > > Measured 2 cycles TSC warp between CPUs, turning off TSC clock.
> > > > > > > > > > 
> > > > > > > > > > This comes from check_tsc_sync_source() and indicates that one CPU's
> > > > > > > > > > TSC read produced a later time than a later read from some other CPU.
> > > > > > > > > > I am beginning to suspect that these can be caused by unscheduled delays
> > > > > > > > > > in the TSC synchronization code, but figured I should ask you if you have
> > > > > > > > > > ever seen these.  And of course, if so, what the usual causes might be.
> > > > > > > > > I haven't seen this error myself or got similar reports. Usually it
> > > > > > > > > should be easy to detect once happened, as falling back to HPET
> > > > > > > > > will trigger obvious performance degradation.
> > > > > > > > And that is exactly what happened.  ;-)
> > > > > > > > 
> > > > > > > > > Could you give more detail about when and how it happens, and the
> > > > > > > > > HW info like how many sockets the platform has.
> > > > > > > > We are in early days, so I am checking for other experiences.
> > > > > > > > 
> > > > > > > > > CC Thomas, Waiman, as they discussed simliar case here:
> > > > > > > > > https://lore.kernel.org/lkml/87h76ew3sb.ffs@tglx/T/#md4d0a88fb708391654e78312ffa75b481690699f
> > > > > > > > Fun!  ;-)
> > > > > > Waiman, do you recall what fraction of the benefit was provided by the
> > > > > > first patch, that is, the one that grouped the sync_lock, last_tsc,
> > > > > > max_warp, nr_warps, and random_warps global variables into a single
> > > > > > struct?
> > > > The purpose of the first patch is just to avoid false cacheline sharing
> > > > between the watchdog cpu and another cpu that happens to access a nearby
> > > > data in the same cacheline.
> > > > 
> > > > Now I realize that I should have followed up with this patch series. The
> > > > problem reported in that patch series happen on one system only, I believe.
> > > Thus far I am seeing eight systems, but out of a large number.  So this
> > > is very much preliminary.
> > > 
> > > > > And what we are seeing is unlikely to be due to cache-latency-induced
> > > > > delays.  We see a very precise warp, for example, one system always
> > > > > has 182 cycles of TSC warp, another 273 cycles, and a third 469 cycles.
> > > > > Another is at the insanely large value of about 2^64/10, and shows some
> > > > > variation, but that variation is only about 0.1%.
> > > > > 
> > > > > But any given system only sees warp on about half of its reboots.
> > > > > Perhaps due to the automation sometimes power cycling?
> > > > > 
> > > > > There are few enough affected systems that investigation will take
> > > > > some time.
> > > > Maybe the difference in wrap is due to NUMA distance of the running cpu from
> > > > the node where the data reside. It will be interesting to see if my patch
> > > > helps.
> > > Almost all of them are single-socket systems.

Interesting to know. I thought most of the TSC sync problems happen
in multiple socket system. IIRC, Waiman mentioned his platform is a
Cooper Lake which is for 4S or 8S platform, also Thomas and Peter
mentioned tsc sync issue on 8S platforms in other threads.

And your consistent warp of 182 (91 * 2) and 273 (91 * 3) cycles sound
like 'artificial' :), maybe the TSC_ADJUST MSR was programmed by BIOS
or other firmware?

Thanks,
Feng

> > > 
> > > If the problem sticks with a few systems, I should be able to test
> > > patches no problem.  If it is randomly distributed across the fleet, a
> > > bit more prework analysis will be called for.  But what is life without
> > > a challenge?  ;-)
> > 
> > If it is happening on a single socket system, maybe it is caused by false
> > cacheline sharing. It is hard to tell unless we find a way to reproduce it.
> 
> But multiple times on a given system with exactly the same number of
> clock cycles of warp each time?  It should be entertaining tracking this
> one down.  ;-)
> 
> I will take a few scans of the fleet over the coming week and see if
> there is any consistency.  Here is hoping...
> 
> 							Thanx, Paul
