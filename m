Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC54D706EE1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEQQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQQ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:57:41 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8659E211C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684342659; x=1715878659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Plv7taGiopctFTWyVFYxRYE4TTYEOviznJF9AVGjjy8=;
  b=Lq203nMFHPI+7Epip+8TDBYivr8Gxl+Ig6kyrHD1kDsqKR2Xeq9vgQJ9
   12D/Mr9O5M4Kt9gGGlcPk5C834Li3hpk0RelMpfS6EVJqcCkVOpg6IZHN
   Y3iijF1dQRSs207sHwOR6Auq1xmkApUny+bJEMKgIZT1R3qHK85CIV2RJ
   jLrclnbfk7GeTsNkUd8UpAGhHqFzi/0B6jZKWN+ZYkdG8jeXhX5GQQPlb
   VZsHMeKsz8wwWdinfmOdWODdX+nnAzru8US/St0SL0OOz/0xzOLR/nW+2
   jF3Yz1I7LsmyFDI78TVJs4RJ7PHzxylMHrGZHkgGhoLi/h9mvNXpqzNtm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415233975"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="415233975"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 09:57:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="846157919"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="846157919"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2023 09:57:38 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 17 May 2023 09:57:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 17 May 2023 09:57:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 17 May 2023 09:57:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O04xL0O/RpDJrpkbGobOg4gYS+Ph80CtZahK5GIzW/fnM4EgXO4ZwWJrFwR5clJNDc4XgmQXplvLjtwlv8Nt3PGkWkHvDad8xlcWfQZxRxSS8ucPejYg7YM6/WXM3UYx9+sjP5Pgo54mdBS96iw7uNKqRJG0TcUFfKmTn3dQmXYAVWZpls1bE5QXaNTz4bNhEbjsyjEJBHWb65K2sFurlGTifqH0eg7Xw74JRfLHFvQxO2P1jEdDfUOFZ/Ydi8C6irE3IyWBxY8tnOXj95d0v+U6u3a345KW8ELg6rYSBfpHIwlIyuJLiWSlV65uXuta5R56Utyd1A/aKVKHQOISpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MC26nSLgBJ5OKb2WxgYsWd1OxabNU770d9kdJS1CIk=;
 b=DSjecbMbGdkvhrqxLc3qpPMmBTSOcpsAqu/7YVYTUqVfjlKkuj5+FuohfVEDbXO6pPHBlFwyxKMXQ73TVkfUSwZ7zchCIBbbICpHDm3ppLoOIYvyLc5Ix65lHZ/kDDXXio/4ZW7+s72AGGzU7H1T5u8cI0FJxatxIlDv87qh7YyUCFsLIwxw9ZiXxjn1KkwoVtmzCrdqxdEoO9RRxioLURW5nhdgVh8OLfXkAJLcT1J5TkxyWtSMwN5OJl3qFwh5Rr+LWg0T2TqNPXuEGb5HbclLeOCrWczos/durKSxvDpROCs5pPLvi35dzJgPwo+LQwEQDWKXQYvgEJ2MAbeOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SJ0PR11MB6767.namprd11.prod.outlook.com (2603:10b6:a03:47e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 16:57:35 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::c219:56e8:1243:2a5d%3]) with mapi id 15.20.6387.032; Wed, 17 May 2023
 16:57:34 +0000
Date:   Thu, 18 May 2023 00:57:15 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Abel Wu" <wuyun.abel@bytedance.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Aaron Lu <aaron.lu@intel.com>, Barry Song <baohua@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] sched/fair: Introduce SIS_PAIR to wakeup task on
 local idle core first
Message-ID: <ZGUHa+Si4dJbdsZN@chenyu5-mobl1>
References: <20230516011159.4552-1-yu.c.chen@intel.com>
 <19664c68f77f5b23a86e5636a17ad2cbfa073f78.camel@gmx.de>
 <ZGNBt7vWJ3fDs5Sc@chenyu5-mobl1>
 <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <795a6d9475ecb444d219a9d36dc93b48a69e960e.camel@gmx.de>
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SJ0PR11MB6767:EE_
X-MS-Office365-Filtering-Correlation-Id: 944fd64f-87f2-4162-6d7f-08db56f7cf84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Oj1mPb75hrmORwySuKQm3YrPkCA0uYgYNzdiooxcIWXsDhAr8wf+ULVmIhMnXR1e7dEhgot9RHI3wZSiXr5JMNaVgikVjrnaurETQe+5Aij3P5rf1HjlAE0M9wYCPuTK0prf/LgxTULGn4ef1YUQLWVeX0muMIVk35c5H5B9Tt3ZQsuWfn70/YKUC5wZDIJ/F8oY2cxdDfDfryepnpXYH4vBYaoyY8hhtfK4YPAvI/1RLfaF3ue01nVye8yNXqBTZzFmvCDXaHUblzqKXX+ejNlyI6NpOZGyP/oP0ad/4NKCV42hKaZls22hzPJUtl3l97jGiIJFBLnUUoS6PVo+dAeleZMppcKMhZ2CM3bEljA1E7aWmkvblOhnpr82MFh+IBVh39uYZTaXQDva/HiAdUriUh3oXylRTYhaDqqTarEX3tbLiX1eUxyqvq4ljD3mG++zO0rOBvSSwdqWzoA907VdpmiuNexyV1EFO8VUiba+fGjhhSwon9IYkBFv0eRfQDWZ/td3MNXefx9R76MYY5aW2GNTMG99T7BwghuYiHkppwi4ku75SJ5j0VGguJDkqvC5Zk9Rcjmq6q8qb534JrgFUucIPA3b2KRCLCS9BA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(366004)(39860400002)(376002)(451199021)(5660300002)(41300700001)(2906002)(83380400001)(33716001)(86362001)(38100700002)(82960400001)(186003)(6506007)(9686003)(6512007)(26005)(7416002)(8676002)(8936002)(53546011)(66946007)(66556008)(66476007)(478600001)(6666004)(6486002)(54906003)(6916009)(4326008)(316002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5YankKwOHhKFqA2Q2wYzvebU8EjH+kuJv1x7SjT6ygbcJwEd0vSVVRE1bq8/?=
 =?us-ascii?Q?FsT3zLX4MBZG2NsDSCuu4DMmzL24lVQzrZB375Go/oOTRs8fHZ0mdCPXAXBM?=
 =?us-ascii?Q?FOLcd0nthlYobJ9kLTHuIqeqFfGts1iPw/Rn04I5nqNZlYqvNwJKgo3fjQS2?=
 =?us-ascii?Q?DSZkYPgC5RRsQ4bGtFY2gIOoHhByWj0Tc+8h3PBoseSJrAehkmWkWWP8vsQN?=
 =?us-ascii?Q?E1dMNZ7/rEaG5a0Q3n0Z0rxkn+rnH7m+m2QUfDkADPTq6ZI97FyiQri81WDS?=
 =?us-ascii?Q?ORlgePRmPQBp7wTxpAVNguI4UQa33LjxcVJuVyL79Sojck7qO4dK0wZwPyQS?=
 =?us-ascii?Q?fcrioM462kW671jZ6waaOCrr+fIFocj4X/F+GlqXQb4J7g8EK69usDuCuzuf?=
 =?us-ascii?Q?FLNRhPQr/GwkupXnxFgyo/CQE4E40mXEskyzEr8gtI+9WLDoQ7rZmiCUpyYI?=
 =?us-ascii?Q?5nBPzlYC99kUyMOdmwPqhXKHTTbHxUU2wpZYhQbUZUkpxOJH+xZGVdajA8U7?=
 =?us-ascii?Q?HJFGOuMIrAE1+SdAP5vAR+ASxAqrsFkeAAZI690QqmC50twY9y3EpIkjhj1a?=
 =?us-ascii?Q?fmfxOE1PsFmVS+6lwoOmOguZYtVt9hO65PDF0OElMS0lA8bOkRazDXFL0x6b?=
 =?us-ascii?Q?q33mBrKN/I7+loeItzqlykiSnE+yJqIH+5KD08encSQKzUWSI/08ANR1QmA6?=
 =?us-ascii?Q?z9YT0pqVpgsogUK1UKKCiTBJneWEI9chppfqVDB8CAMcHZSHerXz7dFsQ/0B?=
 =?us-ascii?Q?caKbCkLsSg0I5djEfS2ofWwb2mFGzWUOMcIXRe3UTX3T5GgK7HFSNaRjtLsF?=
 =?us-ascii?Q?vT5OLIFqs/s4gPPR+H+piuhxSEOt65e1Sfm1MW17oDWWIE2DrATlSFmolLIk?=
 =?us-ascii?Q?Zztrb5jlLnl7wq0teujfYKC8TcpvfoBTc0P0fDc0onylRGNeI2hy95ExPYyY?=
 =?us-ascii?Q?vUQusILOPqOfhhgaCH4U87sbUbok6TiZ/bWVWxLb5WbqMkbuN8JHwpqfyIoj?=
 =?us-ascii?Q?G0QDpKvvr6NaktLHvi8xUXF1ANT5P4U+KSRjpYwMFwn52WDUc6w7SttsZ1Fs?=
 =?us-ascii?Q?Ib/LsPgxYjvPliYPNFFtvCv0JpDG4aZG7zNQPy8hX4ft6ppYXcsxLDcrccQZ?=
 =?us-ascii?Q?RZEzfeK+9IySTrNCmACojx9M4SbqrAlmmxSZGBXnUWMPRyIfwhK6QfyHRy6D?=
 =?us-ascii?Q?ugBOiOCGiN2psNHAIeMHQvsoda2RUzVq7DPCPb8J3ZzPmhIqX182y+1vWVB3?=
 =?us-ascii?Q?n6+dQ49HlhalChP1nIG1pRfeq2qtTVcYyTj9/R6M9zUJJQpRCy0YvCveu3uR?=
 =?us-ascii?Q?OzqmIdt6CDzADMHutf6JUytXnJEM6SYqUHsBxKMm2jEALB9RC3Ho6dZaZ676?=
 =?us-ascii?Q?ZxIbjQcGRyZ7GXeZ4ZFKZ1IiUg2DeO4sKPHqyj6y0nbUCC8LE7o4ZlMJ9Kzn?=
 =?us-ascii?Q?Kc193nq7RJqProaIFR2mspu89lC/DmPKXR+Jt+VEm23PgKWUL/i7vgj4mEau?=
 =?us-ascii?Q?0Mdr+R8k23d6QwS0RW5KJYPqlBfGB4gKiAmVDNrmT9X3D+jL5hixtiHkKqAZ?=
 =?us-ascii?Q?8XlDBTQIPoUV62HUT+pyocYTlZ43/7kuUD1pQ5Pg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 944fd64f-87f2-4162-6d7f-08db56f7cf84
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:57:34.6424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcobMbX4/qH7kTtq8wHGtxLNIi/e2TrL0E8whZwbSozXd2/7v0v7CvUK+U1lF1//NflU9oJsHTYwMuVQo05H1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6767
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

On 2023-05-16 at 13:51:26 +0200, Mike Galbraith wrote:
> On Tue, 2023-05-16 at 16:41 +0800, Chen Yu wrote:
> > >
> > IMO this issue could be generic, the cost of C2C is O(sqrt (n)), in theory on
> > a system with a large number of LLC and with SMT enabled, the issue is easy to
> > be detected.
> >
> > As an example, I did not choose a super big system,
> > but a desktop i9-10980XE, launches 2 pairs of ping-ping tasks.
> >
> > Each pair of tasks are bound to 1 dedicated core:
> > ./context_switch1_processes -s 30 -t 2
> > average:956883
> >
> > No CPU affinity for the tasks:
> > ./context_switch1_processes -s 30 -t 2 -n
> > average:849209
> >
> > We can see that, waking up the wakee on local core brings benefits on this platform.
> 
> Sure, tiny ping-pong balls fly really fast in a shared L2 siblings. The
> players being truly synchronous, there's not a whole lot of room for
> resource competition, and they do about as close to nothing but
> schedule as you can get.
> 
> That's not a workload, much less one worthy of special consideration.
> It is a useful tool though, exposed a big socket issue, good job tool.
> Changing task placement strategy in response to that issue makes zero
> sense to me.  There are many ways to schedule and wake other tasks at
> high frequency, all use the same paths.  Reduce the pain that big box
> sees when playing high speed ping-pong, and real workloads will profit
> in boxen large and small.  More in large than small, but nobody loses,
> everybody wins.
>
I'm thinking of two directions based on current patch:

1. Check the task duration, if it is a high speed ping-pong pair, let the
   wakee search for an idle SMT sibling on current core.

   This strategy give the best overall performance improvement, but
   the short task duration tweak based on online CPU number would be
   an obstacle.
 
Or

2. Honors the idle core.
   That is to say, if there is an idle core in the system, choose that
   idle core first. Otherwise, fall back to searching for an idle smt
   sibling rather than choosing a idle CPU in a random half-busy core.

   This strategy could partially mitigate the C2C overhead, and not
   breaking the idle-core-first strategy. So I had a try on it, with
   above change, I did see some improvement when the system is around
   half busy(afterall, the idle_has_core has to be false):


Core(TM) i9-10980XE Cascade Lake, 18C/36T
netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  9-threads        1.00 (  0.50)   +0.48 (  0.39)
TCP_RR                  18-threads       1.00 (  0.39)  +10.95 (  0.31)
TCP_RR                  27-threads       1.00 (  0.31)   +8.82 (  0.17)
TCP_RR                  36-threads       1.00 (  0.86)   +0.02 (  0.28)
TCP_RR                  45-threads       1.00 (  4.17)   +0.22 (  4.02)
TCP_RR                  54-threads       1.00 (  1.28)   -0.32 (  1.66)
TCP_RR                  63-threads       1.00 (  3.21)   +0.28 (  2.76)
TCP_RR                  72-threads       1.00 (  0.36)   -0.38 (  0.61)
UDP_RR                  9-threads        1.00 (  0.47)   -0.19 (  0.61)
UDP_RR                  18-threads       1.00 (  0.12)   +8.30 (  0.12)
UDP_RR                  27-threads       1.00 (  3.70)   +9.62 (  0.21)
UDP_RR                  36-threads       1.00 (  0.37)   +0.02 (  0.19)
UDP_RR                  45-threads       1.00 ( 13.52)   -0.76 ( 17.59)
UDP_RR                  54-threads       1.00 ( 11.44)   +0.41 (  1.43)
UDP_RR                  63-threads       1.00 ( 17.26)   +0.42 (  3.00)
UDP_RR                  72-threads       1.00 (  0.36)   -0.29 (  7.90)

TCP_MAERTS              9-threads        1.00 (  0.11)   +0.04 (  0.06)
TCP_MAERTS              18-threads       1.00 (  0.26)   +1.60 (  0.07)
TCP_MAERTS              27-threads       1.00 (  0.03)   -0.02 (  0.01)
TCP_MAERTS              36-threads       1.00 (  0.01)   -0.01 (  0.01)
TCP_MAERTS              45-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_MAERTS              54-threads       1.00 (  0.00)   +0.00 (  0.01)
TCP_MAERTS              63-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_MAERTS              72-threads       1.00 (  0.01)   +0.00 (  0.00)
TCP_SENDFILE            9-threads        1.00 (  0.10)   +0.34 (  0.25)
TCP_SENDFILE            18-threads       1.00 (  0.01)   -0.02 (  0.03)
TCP_SENDFILE            27-threads       1.00 (  0.02)   -0.01 (  0.01)
TCP_SENDFILE            36-threads       1.00 (  0.00)   -0.00 (  0.00)
TCP_SENDFILE            45-threads       1.00 (  0.00)   +0.00 (  0.00)
TCP_SENDFILE            54-threads       1.00 (  0.00)   +0.00 (  0.00)
TCP_SENDFILE            63-threads       1.00 (  0.00)   +0.00 (  0.00)
TCP_SENDFILE            72-threads       1.00 (  0.00)   -0.00 (  0.00)
TCP_STREAM              9-threads        1.00 (  0.01)   -0.12 (  0.01)
TCP_STREAM              18-threads       1.00 (  0.37)   +1.46 (  0.10)
TCP_STREAM              27-threads       1.00 (  0.01)   -0.01 (  0.02)
TCP_STREAM              36-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_STREAM              45-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_STREAM              54-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_STREAM              63-threads       1.00 (  0.01)   +0.00 (  0.01)
TCP_STREAM              72-threads       1.00 (  0.01)   -0.00 (  0.01)


UDP_STREAM              9-threads        1.00 ( 99.99)   +1.40 ( 99.99)
UDP_STREAM              18-threads       1.00 (101.21)   +7.33 (100.51)
UDP_STREAM              27-threads       1.00 ( 99.98)   +0.03 ( 99.98)
UDP_STREAM              36-threads       1.00 ( 99.97)   +0.16 ( 99.97)
UDP_STREAM              45-threads       1.00 (100.06)   -0.00 (100.06)
UDP_STREAM              54-threads       1.00 (100.02)   +0.10 (100.02)
UDP_STREAM              63-threads       1.00 (100.25)   +0.05 (100.25)
UDP_STREAM              72-threads       1.00 ( 99.89)   -0.03 ( 99.87)

The UDP_STREAM seems to be quite unstable, ignore it for now...

Xeon(R) Platinum 8480+ Sapphire Rapids, 56C/112T, 1 socket online
netperf
=======
case                    load            baseline(std%)  compare%( std%)
TCP_RR                  28-threads       1.00 (  2.19)   -0.32 (  2.26)
TCP_RR                  56-threads       1.00 (  4.09)   -0.22 (  3.85)
TCP_RR                  84-threads       1.00 (  0.23)  +10.11 (  0.27)
TCP_RR                  112-threads      1.00 (  0.16)   +5.12 (  0.19)
TCP_RR                  140-threads      1.00 (  9.58)   -0.08 ( 10.26)
TCP_RR                  168-threads      1.00 ( 10.96)   -0.61 ( 11.98)
TCP_RR                  196-threads      1.00 ( 14.20)   -1.31 ( 14.34)
TCP_RR                  224-threads      1.00 (  9.70)   -0.84 (  9.80)
UDP_RR                  28-threads       1.00 (  0.99)   -0.29 (  1.06)
UDP_RR                  56-threads       1.00 (  6.68)   +0.96 (  7.26)
UDP_RR                  84-threads       1.00 ( 15.05)  +10.37 ( 24.45)
UDP_RR                  112-threads      1.00 (  8.55)   +3.98 ( 12.17)
UDP_RR                  140-threads      1.00 ( 14.55)   +0.25 ( 12.53)
UDP_RR                  168-threads      1.00 ( 12.87)   -0.81 ( 18.60)
UDP_RR                  196-threads      1.00 ( 16.61)   +0.10 ( 17.12)
UDP_RR                  224-threads      1.00 ( 15.81)   +0.00 ( 14.11)

Similarly there are improvements when system is above half-busy.

[Limitations]
Per the test, this patch only brings benefits when there is an idle sibling
in the SMT domain and no idle core available. This is a trade-off to not
break the latency of low end platform but mitigate the C2C on high end ones.



diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7d2613ab392c..572d663065e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7126,6 +7126,23 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    asym_fits_cpu(task_util, util_min, util_max, target))
 		return target;
 
+	/*
+	 * If the waker and the wakee are good friends to each other,
+	 * putting them within the same SMT domain could reduce C2C
+	 * overhead. But this only applies when there is no idle core
+	 * available. SMT idle sibling should be prefered to wakee's
+	 * previous CPU, because the latter could still have the risk of C2C
+	 * overhead.
+	 *
+	 */
+	if (sched_feat(SIS_PAIR) && sched_smt_active() && !has_idle_core &&
+	    current->last_wakee == p && p->last_wakee == current) {
+		i = select_idle_smt(p, smp_processor_id());
+
+		if ((unsigned int)i < nr_cpumask_bits)
+			return i;
+	}
+
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index ee7f23c76bd3..86b5c4f16199 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
  */
 SCHED_FEAT(SIS_PROP, false)
 SCHED_FEAT(SIS_UTIL, true)
+SCHED_FEAT(SIS_PAIR, true)
 
 /*
  * Issue a WARN when we do multiple update_rq_clock() calls
-- 
2.25.1

