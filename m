Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EF5BCC2B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiISMvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiISMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:51:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B11286F0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663591864; x=1695127864;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9VDmtG4gl/SlQyHP2BxOND6ywazmIK+q2kp8KXvacN0=;
  b=Mf8ngI72Yq6Kx4WQXaqJNC/NyeR4E7tKkFswU5FDVGmdMY7i1omNFWxE
   3b/1FWOXF82W/gg+y9nzKhPbBggwx4xHN93mbAVCgGQjcr6NjUQ4q6Tiq
   tAsw4r/PSXx84lE4c7kztnmgCrDCDK8v3bGk3ngBg3hmCJaAZpwHQTXtv
   oNnrsEv4uWxfRYudWkH0Fllf6oDDCJreDC01sr2XzUgqJCh/G5zziOh6Z
   9pQscVF9zABTj49ktXyh4OHxdlvva8CI/UwHa+TyshuHrvl82nk+cuveQ
   EplqbFvLQl9HmCBzaiqjfbluYRBj7U8Vjbw/uGh+WT2dagPpQ5RPOv3Wq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="279771436"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="279771436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 05:51:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="760854585"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 19 Sep 2022 05:51:04 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 19 Sep 2022 05:51:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 19 Sep 2022 05:51:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 19 Sep 2022 05:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ocmUDUP4TG7WbT4m0uSVhQAU5xsVibCaZDgIkZUWZjd30ONO2iL/JkCa7D3+2L/ITD01v9zrF9jrLLUen1OxpN74O4ZxTGY41/G63LEfLHZnXm4zCD5nG4JoFzDQS/bLAEvw32j6nf1E5f6hlLat2p63QxfS2f/WJG6icpyqhs0ei9izswgYMXPeO/RXgEUN6zrXJa17w5hp4S8ijI16fCRKfhWDnlBMiNgnFU5VW37x22kdhr7CL+UVv1SdJo4Rj8EZQJ6xtTSAmiLf01m+rClLppX+5JUkb9zp3DRNUaoFHZutGUiihmsUGacqQu0N250LGcAulKkUvpfIjkzzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/nJiy1I3KPQAJVdfF2BEllvqnKNY+TA+a0zvRsw7ao=;
 b=XNRE/n8wH0TVeXtqbVxGulfrtP+807O/FR854Hl7EDmnTPMpZA5tGktZVh//0THHghYxettPwXdkpPsREKn2R2lksfhrAf6vjwx8GHk58RdcVoj4MmyFDfbIeyOs3ws2IlgJJH8Mu0aQ12kp1/dKqv+epG+H+pj4fzoXe05kM/CBhflTS7cGZxaHbTfnVpN8nadUNjrE/3KrB3UEdmtrxvHsmd9+VB5xSYOCJR/KKGCnt4ZIgboxCcm0SnUvhdHvOiWf+3K1ol5CCodOAYGb65mdnhniDiIHJMzzQkpeC9oVac9qRhUdDSmH+xQcvVXlFSZqRTes2V9qWzQPLoELWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB6290.namprd11.prod.outlook.com (2603:10b6:208:3e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 12:51:01 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::ccec:43dc:464f:4100%5]) with mapi id 15.20.5632.018; Mon, 19 Sep 2022
 12:51:01 +0000
Date:   Mon, 19 Sep 2022 20:50:34 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] mm/slab_common: fix possiable double free of kmem_cache
Message-ID: <Yyhlmq8GA5FnNoxq@feng-clx>
References: <20220919031241.1358001-1-feng.tang@intel.com>
 <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e38cc728-f5e5-86d1-d6a1-c3e99cc02239@suse.cz>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe6c720-393e-401a-1813-08da9a3d9b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EGjLkKMWZ4YAn8VnUyN4QVzPwsT5rycYpatnkPWMpoxIIPb2j6mQIYdyeyXSTT6Tp8gmby6grRa/oGtbeWm9PlG8O0oQP5CMX3WVVkg2YbP+ILLB4F2JdOM7WW0zu26vKIvqqpqYayWMU98qPHhbHJmUzuwsKJUFpR9M+WTkk2ADLorSx8xvprSGopWR4shYRitlBD4Ta6tF7k5iRFQDuSoL2WDW9369BRB1k8c80HcCUadW0MMw+3juu6qZgZXTW+4PD+JA36T8/W38Fy/+O9kHjn9yddxFl00UbgSLZKfUphLUJ4Uqlf7RjcmKdRZ9sH8SAD6iBzfZkbEoWVkoSCqgSckL7BELIBjCJBH4toazPPR6M6KrYZ8h2R2GWKFXKYwg59NoTdd3aL/Gc5dmEEigxisbuICJsUstEQZAHUKMyqRHQTZqd8lJJOpaCcE7m0tZYqzCGpLMFH8YcOZwSawV9y4UZ0i32alGohhmJRCcVLMY5b/nVXiHeRNVh6Vwdknn1CZWUUCMg7kYFWxMETtnSPayaYEeQvJHqck0vt4eqrEmhRiMxM0w0RrHgml9ZKwGhS+0rHISTPjL1FQ9IoF2ECm2NytitXNhL3jiGyEkQU+jnQ2XucIlWUP4/n1SRpCrHkfdt/YV64xJW4bnQ5mWq4/uflvLVdo+Wjbml/Ovggw5vzlLHcFwHYytewntChtReA9vZGN2TnhjeumQ+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(82960400001)(9686003)(26005)(6486002)(6506007)(6666004)(6512007)(5660300002)(2906002)(83380400001)(316002)(478600001)(38100700002)(7416002)(6916009)(66556008)(8936002)(33716001)(86362001)(186003)(8676002)(66946007)(44832011)(53546011)(66476007)(41300700001)(4326008)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NpvSP7/8al9Q99C+A0ThbNddw5TQb4bZYNnK75JBhp14j7fOaiSPrl7rajb?=
 =?us-ascii?Q?jkARIBDR71oqk2tt5IM1C9Ix5fMXWhSW2xA64eWeB6rAbqwjXk534wDGztJ9?=
 =?us-ascii?Q?b8E6jNaiWdA1K5+CWq6pFuPCoEmGEg6NtMJIPfob0mbbDdbgUcYxjBtapbU6?=
 =?us-ascii?Q?q5iw+tunDFYi9TRGyNidmyF2U9WNQC6tuKx2hiXSq9EewY501p0ilhRFOk8e?=
 =?us-ascii?Q?bmhAFJFKJ83H4aARlwfmHb2DIxED7k7gvmSVojjMx9bfBpcU/KiKibmYv8Zz?=
 =?us-ascii?Q?5r/3i2uqIJieWttwimuHaeWT/ZIzuURVln63ZA+SAv/orFkT47uL2mkyK+co?=
 =?us-ascii?Q?HJAm6hWQgkZMuT+31kGdOjrPSqcwWIF1zqvBFnBJHn56WWpdZX1vx+DLyryb?=
 =?us-ascii?Q?qgjQbWns7VVXvZj4zE6iDADxcuCaQ2/6KWID2tWC573bf0HFBr51cF8HfhFY?=
 =?us-ascii?Q?JD+90E81zGhWdY7nnCNZ6j/po70M66HhGmN38SR1RuYsTiWytedke7gizmPd?=
 =?us-ascii?Q?WM8Zhzi1zQZ23cakrEQyKUvz7zWk3mACNJDcQGOZhXPb//4BiU6tC6PSS6q3?=
 =?us-ascii?Q?RKxDDLgssTVxoC42Nt9NMmgjTs4IJIoRWE2Zo0V4EFDbDPt+BXJbqHHpbYpZ?=
 =?us-ascii?Q?upC2X/SuNG5oGBbTExBxuAr3syc3RFxxXioapFkS9xzlCSwj4/991uwPKzVV?=
 =?us-ascii?Q?ERES5VIgtT7yh8KOdnzTr031NDOqraRISzgM3D0stFTdrEsjY1sEk+d0vHUl?=
 =?us-ascii?Q?WGFwaC02Og6H0V57TAvEn8r7QkmNtjv57zw4QgWlRM+nZnEPGTETNBUBUpAP?=
 =?us-ascii?Q?L5yYQL57PGJpBmIaFFWfPA3SIo7YtI7eCwB7EbfkRyXH2fFaz2Q96ZUjEPDG?=
 =?us-ascii?Q?oOpwBf7MHGiQ9F/q1H3KfpQhN6fmKZQ4Cjdybgif6fjeXZO+V10vQKdrBox8?=
 =?us-ascii?Q?hDXSLr5P1OKmYMPr8acMHr/DjDadChce+pSx6kacnzFf55k+EEE9OtZxLgPK?=
 =?us-ascii?Q?W0QETEVr4Mhlbz5Vj/u6DUFBEMpwReZaND79va03jrs7qk/VBqvSg42/e6g3?=
 =?us-ascii?Q?tCTqWA410fhLMKI2m9NDkOJWeLBPhgjSCcHBw3Kri1mQh+0Ck5he+Dp5KLOV?=
 =?us-ascii?Q?wCI6POvn0CuCxqXk6EyhE6KmhHMKGodiLKadB0SJfqtuO+7XzH9vNjJGsbRn?=
 =?us-ascii?Q?1bgG0oA6qgy0e8Px78KRdWUNe4JQpxgcQ6H/Ble8NcuJzNJO9e0dlGtj0JFd?=
 =?us-ascii?Q?k87eioCGTNPWFnY+9AcyAgNme3fSHD3ROrsUnn/TnsxAE8mafnZa1fJ8rOBV?=
 =?us-ascii?Q?kUUZc/PqICE1zLsP04S9drSXCSLOw1XavwMh/GU15xpIiaGBipH5ULoLaHf7?=
 =?us-ascii?Q?AiGZ0PAx8XjabSvVAhfhbz3vfCvvte/adSk+Doqh1TfdvzMkDh2U0nopURn7?=
 =?us-ascii?Q?7R9/WUTX974IodvOBv8VUSMRs0X1W4O8chZdd4BBUhZb4Lm9X+MFuDU3TvbY?=
 =?us-ascii?Q?+rAPaX8B/zE1913oWywpHOGVMMPEQLY3B/A9nVhS9SzVbNMdLeH0gqcu6bSE?=
 =?us-ascii?Q?4JFUT3HAnJW76cejQbNtjNqKs8hCQgoQOSaDscLU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe6c720-393e-401a-1813-08da9a3d9b59
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 12:51:01.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tebfLycAcnYf4HiBE0JyuVlOcQCzylK6sTALfghavpsTg7lq8z4FgUoKS51/AAa7F8FnatpGzBHXrA1SaDqf8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 05:12:38PM +0800, Vlastimil Babka wrote:
> On 9/19/22 05:12, Feng Tang wrote:
[...]
> > The cause is inside kmem_cache_destroy():
> > 
> > kmem_cache_destroy
> >     acquire lock/mutex
> >     shutdown_cache
> >         schedule_work(kmem_cache_release) (if RCU flag set)
> >     release lock/mutex
> >     kmem_cache_release (if RCU flag set)
> 
> 				      ^ not set
> 
> I've fixed that up.

Oops.. Thanks for catching it!

> > 
> > in some certain timing, the scheduled work could be run before
> > the next RCU flag checking which will get a wrong state.
> > 
> > Fix it by caching the RCU flag inside protected area, just like 'refcnt'
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Thanks!
> 
> > ---
> > 
> > note:
> > 
> > The error only happens on linux-next tree, and not in Linus' tree,
> > which already has Waiman's commit:
> > 0495e337b703 ("mm/slab_common: Deleting kobject in kmem_cache_destroy()
> > without holding slab_mutex/cpu_hotplug_lock")
> 
> Actually that commit is already in Linus' rc5 too, so I will send your fix
> this week too. Added a Fixes: 0495e337b703 (...) too.

Got it, thanks

- Feng
