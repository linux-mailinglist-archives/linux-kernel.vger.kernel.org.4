Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D776C7624
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 04:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCXDJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCXDJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 23:09:07 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B728E63;
        Thu, 23 Mar 2023 20:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679627345; x=1711163345;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Qg4S205v0cKGGU+wV4IcsHgmLuZThQ6k5S65yyd5DFg=;
  b=bd6T6nruV5SlPZiOHsGnwP4ssM7KsEaUf8mxlMXRk6U4D3jdnFBF9k5a
   H57kT1nRbMIzZBLzPlF72dIhnt/vdq286PJHQuXkXOQUyVIbrxSGEkOiM
   4RWq694i1I7S3aqv3b7luJFUA/w9YV6WAnwmJRsgcHnZaPgzpSWnn3ydA
   RNNKbPWWGBZxz1B1ZmpxeRuyrtQsBaWkYQ4KhW0Aij3YV231Y0684CQYp
   uwz1XXHIpmzo7kTlys/h0o85wLOTqvYJ91mJPYWPOYkEhkN66Ss80Mui3
   GEJryuIAOdaj7BMEDSAuTK0DRJl0FoMxq3WiRbP8rxt/c3/2EwiaSTMdJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337191220"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="337191220"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 20:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="712921133"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="712921133"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 23 Mar 2023 20:09:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 20:09:04 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 20:09:04 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 20:09:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tuybc7znUaTkjbo1NfXmT/LOG2rSc8Kd4w9mKTuPnuvSjIBvcMaOTTcTQrdiryhCmadGuXNfCobCiwYYLToysxbhxeAcIiVE7D3fTP6EZiQ2GCsRuzp/rKVGluxwCUzIcISy6ox3IYFD+jhr7s+WEo6KinJQ9aUIqiRulnM9bUYZspFZETVNxa/lC3tCaT1SbVCclW4FSzXcCJf9ZS1OrvoM5wpE2kbXFv4CwI+3dAyEQjbDfUrgsMS8izkbvwhHMw4FhiyAF0klfA6mQsNCG245Xd+EWlBQiuZToL4NUM00xRVrwgNVshDbGfTNsXhV4D8ThPwBv4xzsajOremW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PpkK+vZAbbvDsiS9W3hAwJI3DhklgmcNCvA8tuknSyc=;
 b=XagFRLGfPj1pXgjB92u0mq3Sr11QndBIM40KoE6pRGOOnjipPiY1/ACs8c6ztGp76jb+KJQzPZVsPZc14MCFEeQScJFnevk/ndobjbF9GoP23XR1wx05K4budGbQiE0o8yaOGgzof5ao1MQo+1VaJCrOOGnE6Om1ieXMJ/dfBFUOQwut8w/PvmAmR2pGjHboALxHz8dkbAlXb5C2BCom6gGvY8C0B/yvl3qTGWZtJa0ouxtOqGULiXe7dmqudVw37oiiTmWjw7HIMEo0BXmI8yWuP+8GPR6toTiiAMYnXQSXNAqz8RqgkNhaeR5BbTLUzQN8iPccnrlvlIWH50HLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SJ1PR11MB6084.namprd11.prod.outlook.com (2603:10b6:a03:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 03:09:00 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::cb54:c0ca:5914:4242%9]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 03:09:00 +0000
Date:   Fri, 24 Mar 2023 11:03:26 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, <dave.hansen@intel.com>,
        <ying.huang@intel.com>, <tim.c.chen@intel.com>,
        <andi.kleen@intel.com>
Subject: Re: [PATCH RFC] Documentation: Add document for false sharing
Message-ID: <ZB0S/gfCLGP44HME@feng-clx>
References: <20230323082626.100718-1-feng.tang@intel.com>
 <dcb0c139-e40e-f448-ad99-245020025862@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dcb0c139-e40e-f448-ad99-245020025862@infradead.org>
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SJ1PR11MB6084:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b49b31e-cf63-44cf-2ac5-08db2c151d0f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XOOuMqGKuYElIseStxGybRZjGpe5avlYYxEegxuYKTPZEddwtE3yEjSkNxrfkyvqyBoenSTtipgEeudtnZEiC4OU180ZfX2ifYgU3RejiF5gObpPNIJNn8lyJWsfmfkL0jO9yXshTSX7TxrAieReKU8qyu8Ufc7mDDD2UZhz/Domhx7YT1nVDup994uNeiQG44UQo0EG1ba6fEKD2DinK2b3zT1AreVgPsDB2H0bZi/GnefdpqjFqWsa+8XpDjDmHWpfGAh9CD0duBjA+JwcJkaOogLkTcY7/xEjYOOURtU9/u2XeudP1ZR4NNfIf0MXR9uzzJKdPAekWeMOvFJjxDnbBRIn0kFH9WZS7ktxPHR+XY1/yiJA7XVbHP6/rsySmCdqMzNNhNUuHN1bAOFl+KHDOPRI4N/Rv2rCB0It5BzAffs7/sJ6ldWschOnagQTJ0dPZv3HQ2EZ/o2ntGF6YpC2GRPIkF0ZAjfz3X7TWqarpV0ub+FKMdSb5R0O5pyinjXDboGvD3q2ujdLr6rBBdot+nE5SrGvPMxWG1EjR0dhHAGlthqP+t08JJWUdhiqTkJE+iDtrykFbz+E9OspwXpHwuQGTjtRiAw5IEY4WUiyeL6V+5WSdz6f84vQ0G1/greeObVUYmGM1KxLeNMI7/umiPUto9UzUmGXHMIEiP+YKUbE30BGZqfg2jsbcFONr+Yw/s1GVKbmWyHxBs2qVIYgI2jI59Dw19CGVirqHeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199018)(6512007)(6506007)(26005)(53546011)(9686003)(107886003)(6666004)(83380400001)(40140700001)(86362001)(38100700002)(33716001)(82960400001)(186003)(478600001)(54906003)(8936002)(66556008)(66476007)(66946007)(44832011)(30864003)(7416002)(5660300002)(8676002)(316002)(4326008)(41300700001)(6916009)(66899018)(966005)(6486002)(2906002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?19RymalaUOqe4z30YiW9fGjORO0eZorDYpWMYXbgVH91anutePtqOGvV8T7J?=
 =?us-ascii?Q?WD8VMB1IDYL2jKra7HkyLQRIdAzhEWR94t68kBKBXqwTplDAzpstxuMQ4Oca?=
 =?us-ascii?Q?1hmHmwX9KjpAMto62OCRxk+fBDmxJwE0PmpvVooVglCB5BrkMdCz5A+SY93w?=
 =?us-ascii?Q?UIEirPF2ZAUKtfo9iKq9Lct25FkQl2CmjgFj8Z7aIkPpOff6wfQDeelB3l9T?=
 =?us-ascii?Q?J+FCoAhV4Ys6METEerT7qDlO8JV9mg9vlOU2TMLaJjEoSpYYBYMB8b1y8mFi?=
 =?us-ascii?Q?tsQnBecOijOz+Tne8w0aBx/6vhxy1S0nwmdsZkd86UOoy7kSMJ3FleyFeU7Q?=
 =?us-ascii?Q?+66BSRG51uIuYzNol+2GGYvBtfkJcPTv1lnCEGpQQzQ8tq+95juTsk54lbnW?=
 =?us-ascii?Q?bNVfX58a1tQPDZBbFcK7mmssx459BB/9t/Kj9EMSHzm5Ftoe836OQCGFiPg2?=
 =?us-ascii?Q?XIPoPIt9bvUm9UyBwrWFOxrP4fjb5APowh89BiS7697w2oUWwWxBgha/fhfd?=
 =?us-ascii?Q?s6xeh1LkPN1QBVkNSYOyHFGTkH7M7QRTbqDPRrJkIzWlTQzTpeJxHsOhT/VG?=
 =?us-ascii?Q?IXrisVttaYCdA5x5ZLLAWo+/F1w/hEDZAfd+AbBdHTKkVPRy4geJ7SfN6l5K?=
 =?us-ascii?Q?oeDsrbNq9sVXeWly9pdJzBMvzOqD1vK0v78UpoIAxRh2g817iuFcqD2m1dgl?=
 =?us-ascii?Q?VowBqIRcvtO4iKQNux1FGpM3GWsPZAMePfuOYveQm6dTJUUJB2vGPrMBWGOf?=
 =?us-ascii?Q?X84ExWeNlyae0pTjKy8vZXgqHonYZBmIpkAsPvDxcY1qSIN5HF74xMtWe3/R?=
 =?us-ascii?Q?I7kiNmNiqup6n+YbLuyG9OjTvkSNXwUYXQm43s29ae4ghE1+DznvB+v6fI3B?=
 =?us-ascii?Q?LK+htCaxEToPgt6ZwgPae/wiYvRG2Z7cY4W0DAY/gmZVlxABPQY0v6bWbP9l?=
 =?us-ascii?Q?IN6M/5BRWzN8cBRvtJScW3YZQTiYaaJHsnwr2mJciXrEJZsKP1cWbCAQhXo9?=
 =?us-ascii?Q?aiCxRF/z3Baxz4K4EF3ofWWYh84Ro0UsFoEGVua0nRBKxLlkoZ4tUM0w6iKr?=
 =?us-ascii?Q?MEzbfXOo+1QJ+CCXRXdjwCQauZOYsI7xen0V8gBm1BgPqyYp1w2ueR881D6T?=
 =?us-ascii?Q?KYgcraAqGHKBJGeHY1gAFqhT0qCEKo6kg+mY3yjSPYYnWwz7ro5lXQQW1ALh?=
 =?us-ascii?Q?mMWd+q5+AF/Dt7+TqPgRMcQifgaO1WZqAJDVntrCIAw+/GozUe5V/MA42yqp?=
 =?us-ascii?Q?x0D+SwmZn4ElYR0bGzHVTnFHZ2vJWg3JQ8ydTqo7RNfw8pvxuJlpVPGs/M/H?=
 =?us-ascii?Q?L6QLaGzWWdg9HSdWkr6Lol8oDxYfqgl8aA2Y8ABPYFcqilaCNC+pfP6REGqj?=
 =?us-ascii?Q?lvRYOCQfhaamQu565IoNok7PQGpMG0OgLKNKjkVgkG+SiCPom5zqFA08t3ot?=
 =?us-ascii?Q?hBjy0wnWrDCtqy2S2HkHbyBJi5H+SOv7x5KgxOAta+boHMTxMdpcbQ2LEGK/?=
 =?us-ascii?Q?nbpYvqqUuQb9LkYN65TYsxnfEeEFEB4+KMm5eQ1DB8gaSjYB9PWzWJ+db5+v?=
 =?us-ascii?Q?XLlPe7TlVQ6pmY6eSkbxvnuLI2RgsuEx0T2XcIuY?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b49b31e-cf63-44cf-2ac5-08db2c151d0f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 03:08:59.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1eNDMAv2d4d4X1ul6DVGmgFGS/yDaSmp/9fkcXmqOFODrvniDaLvg0DKO82LpAN+zjFmyljIcDYHLzflq40a6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thank you for the thorough reviews!

On Thu, Mar 23, 2023 at 09:49:02AM -0700, Randy Dunlap wrote:
> Hi,
> 
> Lots of good/interesting info here.
> 
> On 3/23/23 01:26, Feng Tang wrote:
> > From: "Tang, Feng" <feng.tang@intel.com>
> > 
> > When doing performance tuning or debugging performance regressions,
> > more and more cases are found to be related to false sharing [1][2],
> > and the situation can be worse for newer platforms with hundreds of
> > CPUs. There are already many commits in current kernel specially
> > for mitigating the performance downgradation due to false sharing.
> 
> maybe                            degradation

This is better, will use.

> > 
> > False sharing could harm the performance silently without being
> > noticed, due to reasons like:
> > * data members of a big data structure randomly sitting together
> >   in one cache line
> > * global data of small size are linked compactly together
> > 
> > So it's better to make a simple document about the normal pattern
> > of false sharing, basic ways to mitigate it and call out to
> > developers to pay attention during code-writing.
> > 
> > [ Many thanks to Dave Hansen, Ying Huang, Tim Chen, Julie Du and
> >   Yu Chen for their contributions ]
> > 
> > [1]. https://lore.kernel.org/lkml/20220619150456.GB34471@xsang-OptiPlex-9020/
> > [2]. https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  .../kernel-hacking/false-sharing.rst          | 199 ++++++++++++++++++
> >  Documentation/kernel-hacking/index.rst        |   1 +
> >  2 files changed, 200 insertions(+)
> >  create mode 100644 Documentation/kernel-hacking/false-sharing.rst
> > 
> > diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation/kernel-hacking/false-sharing.rst
> > new file mode 100644
> > index 000000000000..325de2be2c49
> > --- /dev/null
> > +++ b/Documentation/kernel-hacking/false-sharing.rst
> > @@ -0,0 +1,199 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=============
> > +False Sharing
> > +=============
> > +
> > +What is False Sharing
> > +=====================
> > +False sharing is related with cache mechanism of maintaining the data
> > +coherence of one cache line stored in multiple CPU's caches, the
> 
>                                                         caches; then

Will change.

> 
> > +academic definition for it is in [1]_. Consider a struct with a
> > +refcount and a string::
> > +
> > +	struct foo {
> > +		refcount_t refcount;
> > +		...
> > +		char name[16];
> > +	} ____cacheline_internodealigned_in_smp;
> > +
> > +Member 'refcount'(A) and 'name'(B) _share_ one cache line like below::
> > +
> > +                +-----------+                     +-----------+
> > +                |   CPU 0   |                     |   CPU 1   |
> > +                +-----------+                     +-----------+
> > +               /                                        |
> > +              /                                         |
> > +             V                                          V
> > +         +----------------------+             +----------------------+
> > +         | A      B             | Cache 0     | A       B            | Cache 1
> > +         +----------------------+             +----------------------+
> > +                             |                  |
> > +  ---------------------------+------------------+-----------------------------
> > +                             |                  |
> > +                           +----------------------+
> > +                           |                      |
> > +                           +----------------------+
> > +              Main Memory  | A       B            |
> > +                           +----------------------+
> > +
> > +'refcount' is modified frequently, but 'name' is set once at object
> > +creation time and is never modified.  When many CPUs access 'foo' at
> > +the same time, and 'refcount' is only bumped by one CPU frequently,
> > +while 'name' is read by all other CPUs, which have to reload the whole
> > +cache line over and over, even though the 'name' is never changed.
> 
> That last "sentence" is not a sentence.

How about:

"
When many CPUs access 'foo' at the same time, with 'refcount' being only
bumped by one CPU frequently and 'name' being read by other CPUs, all
those reading CPUs have to reload the whole cache line over and over
due to the 'sharing', even though 'name' is never changed.
"
?

> > +
> > +There are many real-world cases of performance regressions caused by
> > +false sharing, and one is a rw_semaphore 'mmap_lock' inside struct
> > +mm_struct, whose cache line layout change triggered a regression
> > +and Linus analyzed in [2]_.
> > +
> > +There are two key factors for a harmful false sharing:
> > +
> > +* A global data accessed(shared) by many CPUs
> 
>               datum accessed (shared)

OK.

> > +* In the concurrent accesses to the data, there is at least one write
> > +  operation: write/write or write/read cases.
> > +
> > +The sharing could be from totally unrelated kernel components, or
> > +different code paths of the same kernel component.
> > +
> > +
> > +False Sharing Pitfalls
> > +======================
> > +Back in time when one platform has only one or a few CPUs, hot data
> 
>                                   had

Will change.

> > +members could be purposely put in the same cache line to make them
> > +cache hot and save cacheline/TLB, like a lock and the data protected
> > +by it.  But for recent large system with hundreds of CPUs, this may
> > +not work when the lock is heavily contended, as the lock owner CPU
> > +could write to the data, while other CPUs are busy spinning the lock.
> > +
> > +Looking at past cases, there are several frequently occurring patterns
> > +for false sharing:
> > +
> > +* lock(spinlock/mutex/semaphore) and data protected by it are
> 
>    * lock (spinlock/mutex/semaphore)
 
OK

> > +  purposely put in one cache line.
> > +* global data being put together in one cache line. Some kernel
> > +  subsystem has many global parameters of small size (4 bytes),
> 
>      subsystems have

Will change.

> > +  which can easily be grouped together and put into one cache line.
> > +* data members of a big data structure randomly sitting together
> > +  without being noticed (cache line is usually 64 bytes or more),
> > +  like struct 'mem_cgroup'.
> > +
> > +Following 'mitigation' section provides real-world examples.
> > +
> > +False sharing could easily happen unless they are intentionally
> > +checked, and it is valuable to run specific tools for performance
> > +critical workload to detect false sharing affecting performance case
> 
>             workloads
 
Will change.

> > +and optimize accordingly.
> > +
> > +
> > +How to detect and analysis False Sharing
> > +========================================
> > +perf record/report/stat are widely used for performance tuning, and
> > +once hotspots are detected, tools like 'perf-c2c' and 'pahole' can
> > +be further used to detect and pinpoint the possible false sharing
> > +data structures.  'addr2line' is also good at decoding instruction
> > +pointer when there are multiple layers of inline functions.
> > +
> > +perf-c2c can capture the cache lines with most false sharing hits,
> > +decoded functions (line number of file) accessing that cache line,
> > +and in-line offset of the data. Simple commands are::
> > +
> > +  #perf c2c record -ag sleep 3
> > +  #perf c2c report --call-graph none -k vmlinux
> > +
> > +Run it when testing will-it-scale's tlb_flush1 case, and the report
> > +has pieces like::
> > +
> > +  Total records                     :    1658231
> > +  Locked Load/Store Operations      :      89439
> > +  Load Operations                   :     623219
> > +  Load Local HITM                   :      92117
> > +  Load Remote HITM                  :        139
> > +
> > +  #----------------------------------------------------------------------
> > +      4        0     2374        0        0        0  0xff1100088366d880
> > +  #----------------------------------------------------------------------
> > +    0.00%   42.29%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81373b7b         0       231       129     5312        64  [k] __mod_lruvec_page_state    [kernel.vmlinux]  memcontrol.h:752   1
> > +    0.00%   13.10%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff81374718         0       226        97     3551        64  [k] folio_lruvec_lock_irqsave  [kernel.vmlinux]  memcontrol.h:752   1
> > +    0.00%   11.20%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c29bf         0       170       136      555        64  [k] lru_add_fn                 [kernel.vmlinux]  mm_inline.h:41     1
> > +    0.00%    7.62%    0.00%    0.00%    0.00%    0x8     1       1  0xffffffff812c3ec5         0       175       108      632        64  [k] release_pages              [kernel.vmlinux]  mm_inline.h:41     1
> > +    0.00%   23.29%    0.00%    0.00%    0.00%   0x10     1       1  0xffffffff81372d0a         0       234       279     1051        64  [k] __mod_memcg_lruvec_state   [kernel.vmlinux]  memcontrol.c:736   1
> > +
> > +A nice introduction for perf-c2c is [3]_
> 
> Add a period at the end above?
 
OK.

> > +
> > +'pahole' decodes data structure layouts delimited in cache line
> > +granularity.  User can match the offset in perf-c2c output with
> 
>                  The user
> or               A user
> or               Users

Will use 'Users'

> 
> > +pahole's decoding to locate the exact data members.  For global
> > +data, user can search the data address in system.map.
> 
>                                              System.map.

Yes.

> > +
> > +
> > +Possible Mitigations
> > +====================
> > +False sharing does not always need to be mitigated.  False sharing
> > +mitigations need to balance performance gains with complexity and
> > +space consumption.  Sometimes, lower performance is OK, and it's
> > +unnecessary to hyper-optimize every rarely used data structure or
> > +a cold data path.
> > +
> > +False sharing hurting performance cases are seen more frequently with
> > +core count increasing, and there have been many patches merged to
> > +solve it, like in networking and memory management subsystems.  Some
> > +common mitigations(with examples) are:
> 
>           mitigations (with examples) are:

Yes.

> > +
> > +* Separate hot global data in its own dedicated cache line, even if it
> > +  is just a 'short' type. The downside is more consumption of memory,
> > +  cache line and TLB entries.
> > +
> > +  Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_allocated")
> > +
> > +* Reorganize the data structure, separate the interfering members to
> > +  different cache lines.  One downside is it may introduce new false
> > +  sharing of other members.
> > +
> > +  Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce false sharing")
> > +
> > +* Replace 'write' with 'read' when possible, especially in loops.
> > +  Like for some global variable, use compare(read)-then-write instead
> > +  of unconditional write. Like Use:
> 
>                              For example, use:

Will change.

> > +
> > +	if (!test_bit(XXX))
> > +		set_bit(XXX);
> > +
> > +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
> > +
> > +  Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing")
> > +  Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> > +
> > +* Turn hot global data to 'per-cpu data + global data' when possible,
> > +  or reasonably increase the threshold for syncing per-cpu data to
> > +  global data, to reduce or postpone the 'write' to that global data.
> > +
> > +  Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cache hits/misses")
> > +  Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overcommit policy")
> > +
> > +Surely, all mitigations should be carefully verified to not cause side
> > +effects.  And to avoid false sharing in advance during coding, it's
> > +better to:
> > +
> > +* Be aware of cache line boundaries
> > +* Group mostly read-only fields together
> > +* Group things that are written at the same time together
> > +* Separate known read-mostly and written-mostly fields
> > +
> > +and better add a comment stating the false sharing consideration.
> > +
> > +One note is, sometimes even after a severe false sharing is detected
> > +and solved, the performance may still has no obvious improvement as
> > +the hotspot switches to a new place.
> > +
> > +
> > +Misc
> > +=====
> 
>   Miscellaneous
>   =============
> 
> > +One open is kernel has data structure randomization mechanism, which
> 
>    One open issue is that the kernel has an optional data structure
>    randomization mechanism, which

This is much better, thanks

> 
> > +also randomizes the situation of cache line sharing of data members.
> > +
> > +
> > +.. [1] https://en.wikipedia.org/wiki/False_sharing
> > +.. [2] https://lore.kernel.org/lkml/CAHk-=whoqV=cX5VC80mmR9rr+Z+yQ6fiQZm36Fb-izsanHg23w@mail.gmail.com/
> > +.. [3] https://joemario.github.io/blog/2016/09/01/c2c-blog/
> > diff --git a/Documentation/kernel-hacking/index.rst b/Documentation/kernel-hacking/index.rst
> > index f53027652290..79c03bac99a2 100644
> > --- a/Documentation/kernel-hacking/index.rst
> > +++ b/Documentation/kernel-hacking/index.rst
> > @@ -9,3 +9,4 @@ Kernel Hacking Guides
> >  
> >     hacking
> >     locking
> > +   false-sharing
> 
> Thanks for the documentation.

Thank you for the suggestions and good catches!

- Feng

> -- 
> ~Randy
