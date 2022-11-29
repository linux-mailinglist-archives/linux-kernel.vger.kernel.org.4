Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190D63C058
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbiK2Mxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiK2Mxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:53:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABECE35
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669726409; x=1701262409;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mpDODRajRdu0f1cvaVzJ6GfyiqDv3JL3xAwRJi64/fw=;
  b=QQf97xEKXmWDdKrkjyl8wpm2NRQ69C9TuQQ2gZolZq+Uz98DhkkeZDBG
   bvbrFgoe1TrnCdZ6da+mWCbFRtQ+YjVnIlIJ6ULmgk95jvzk/JXxSO082
   MWZp0O8pz1nkrfXXKDqVlF8EWU1F0LkTBk2zekTsrFLNbEc4Ur6NH7lTV
   4g5DjLQsQrVVAkzqv6pgl2vfPPBAjJEZv1ZEFL5GJ9aqULgHOe/TYOa6T
   HD5BeMpr18p74STCO1UZ5YRLNHUuF2RJsBD8b/Ok70o6UI2JSWI0JGAxJ
   KE5Wzz2epDInRfY9MMAxmbNIgNqghzBnoMRgy7jL5Aau2d8X9GpD3mC57
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="316934223"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="316934223"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 04:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="888833616"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="888833616"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2022 04:53:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 29 Nov 2022 04:53:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 29 Nov 2022 04:53:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 29 Nov 2022 04:53:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFEFLYR8Bd3Lauu/euNCfHXOfCf5CIqKzoNJx2CrdFRXcrI3KrpYDOWzPbTDwZsO15A0mTg8ELGK2PXB2UtPwt3WerV2DuNp6NT3q2KEnXKX/SfFFzX42fpd/dnZWEmZrZPZtBGMjaIB7p6t2eDC2S0/27ZDNLjIvtc+jklMY+nJsH7ofWcxOWpq03a9InrVJyhw4DNW7DxC6rVfeewdplrXrs4/oibkOoVvUivUpQhu8WwO2tVt4JU32/ylCrQdKmbIVP9rLQ6FmYCpGQbwOMHO55Nsje30aSTobC2pQU1uDYJxvzG6wv+nl/zxx6pXU6DlCzzlT9Rv2YP0SOA6+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHPIfI1E1Iw9SqdV0m2O+Zg0sE5r+ppt733yRyEkBtI=;
 b=hwtQi4LakM4qX7gnKImgcmpwCRbntET+JmKp6K/mS+qw+HpxdXxBjGPpM11X+T1Y44jLhDfRvbZqFAxRjv9BSK2YPmS3P0tK5ScXIVAbEl3VA3uFadSZfPJtzDuwLO3J1R8Z3Nmm9uPmVjfNevy2wgvXSr3KarrhA9q8TZkmW1yr/mCelZl1pM/i8n89geMad2RTkXUuxUjjhFesvQHHkbRW7XlclM9UHFioGFBaVN/5fn17bW/3WdfX0nnXn1BzN9umNNAr1kKFAUyAmO/7+kxDCNtmYUd3V+rItoIXEPCYHTZHbZOu96kKtKO5dTaIsWyXQIM52Rm231d8xxMZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DS7PR11MB6151.namprd11.prod.outlook.com (2603:10b6:8:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 12:53:25 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%6]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 12:53:25 +0000
Date:   Tue, 29 Nov 2022 20:50:19 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        "Pekka Enberg" <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        "Joonsoo Kim" <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
Message-ID: <Y4YAC9UTxQLg4Y5q@feng-clx>
References: <20221129063358.3012362-1-feng.tang@intel.com>
 <20221129063358.3012362-2-feng.tang@intel.com>
 <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
 <67e6ebce-f8cc-7d28-5e85-8a3909c2d180@suse.cz>
 <CANpmjNNZhXX830jqPn9eaQZHwKhBb4b_PEuUdH6O69ELqW470w@mail.gmail.com>
 <d6c614fe-cc80-7a19-1fa6-2ed6cc75b705@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d6c614fe-cc80-7a19-1fa6-2ed6cc75b705@suse.cz>
X-ClientProxiedBy: SG2PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::32) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DS7PR11MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0df8372b-3995-4cc0-ddc9-08dad208b436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlgNwhkFeb2BGCcolY3fU1XKoNQhPeU2wMyDX1w2jGqVScOXyV9I4O47F4nivwhKMg8QFmsMSmbD/5GYkMYjWlj+t4d5rXQ+lQJPQ4eF2Wkp1YnIPYXWuXGeto0xpJf0k4J9olJkWdSBZ4GlFuBLnrOTazK5KAx+g07BO5TIKIH1/Gs0BRT8aBAfjUDtLzhL4KuHnEbqmpn8E5qN5GBc/mphqPDpcC9qDr0LNapSqG/7i2lIigLQkxHpDyDQiM3aZEq60hEGmhktPsu9yqFrvEW7fRA1h8nDAR3ETz6HeKAC6W9u4OC79LvVXASm1y1gHBMRPgLSeYIHcjxQ9Pe5T2XhKnhAvfYgFqBnImTjOlQuu/eYw/G3aJdSPA2CtxTtksfzrb2r62PYrjcfAGTHgvORxVZcFU/BZNHUpyLgnsYL6XEy3DlwXJ4AoXadDs/9RTf7SotTfK8YVD4fpdXmIcpGmIbw2SLBTmiSl5KA6v0DXWoC6GJNh8Om+5gagwjKYO+TudbX1LY6zAmLtj34mYJvuCb69npQMvRMZ1wPZN2RSpqxdkzJZbAP6p9DQtrFl6snBe2tvntimPht4Tp2+LwiaIMnQcsj8QZzL4Wq6TLVRtbXrQMdovt83zabXD1FBZgl0qQOT7uD1hTHl+akFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(186003)(6512007)(86362001)(9686003)(53546011)(6486002)(54906003)(6506007)(6666004)(5660300002)(26005)(8936002)(6916009)(7416002)(44832011)(478600001)(8676002)(33716001)(4326008)(316002)(2906002)(66476007)(66946007)(66556008)(41300700001)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BHbuWu4HuGDFFaprBKda3t2Gwd9TZHgITwISsX5G3RpPSwL2eGc6Nj1ccqqe?=
 =?us-ascii?Q?yLTw0CF61dbyH1p8BH5p+SG8iPuqkKNitGAt+qo3wf+9+U5GD8KukO/NZx5e?=
 =?us-ascii?Q?GTC2rx7AcpT5q7E8v1J1sd2vm0iMtjgLGRSG2pCQL1HG6PmRycFiS5WGlfKS?=
 =?us-ascii?Q?krmTdE3I8b53ESeowblcJbnT5nj68gciYzPezzTUzy0/NTnI13YGLA9P8xj8?=
 =?us-ascii?Q?C6U7WC4N1OZa11E86ZM1Tw0OJ+91IMnDWfu8bTofxrg1KcJXEhoejV+H94/d?=
 =?us-ascii?Q?wS99c2WAQ7tTR69cVhgXgfPvhdzPS7H3aKs5jc6L2udSNleMbT7B7xZWqRiY?=
 =?us-ascii?Q?tZ3yOTvz+J2zSw5V0CKUTggXi0AxjaJPFxee5IrkipKNYa415AdYdpU+mees?=
 =?us-ascii?Q?aAH9K4yXYvgKYCpZx3E7yI8XwCUWfHWYsmZb2jRHC2ijoJsZjn03wF+6v4+d?=
 =?us-ascii?Q?zYMpV/HdEbNKvXM5Z173FIJ2XS6g37cKHhajnKGB6KbmhNyGJ3x4I8TNkS0H?=
 =?us-ascii?Q?8a+9ismWpxuAJbHOLoQwxvsyzReXcIP2yBgqwXfseBXzeHxt8F+sMAko2qaT?=
 =?us-ascii?Q?y7xh2FdkZChcd5vpRibqVj69izh9+RuR3+Qrp023sUgIzOpzbZ70qlD6mBNw?=
 =?us-ascii?Q?TWFkyIGqHiQz98HUAlQIKJgqSiGG/HvNTsOjtbQtWcjJ2y+Jxyj4/VHCmddw?=
 =?us-ascii?Q?FjaW1KpBYUdWUYXzIeveXSO/UzkcUxOvIa77PjJKjmi0EIJXTnYIjkVuGir9?=
 =?us-ascii?Q?9elK9xyYuWaym0oKePFTBXguuNROiKx0PsbyRE0x1GOtd3jS5VTiqZYSkSHn?=
 =?us-ascii?Q?HONm/YWslyM7bZQeK/BBiNMOg/mJksqsCuwqZ5fEKGR+0jtrygozY5PrCN1e?=
 =?us-ascii?Q?lTYnYcnP56XaAvvRKS0HxswNhwqP+nBs5dpbqgBBID1fbVBbjgbzqgVosaFu?=
 =?us-ascii?Q?SEq4nxWI3QtoFat+E+GFHjX6tqO1XLawc2kw4r9ub9/nYfRK+pU0oLPb8B4y?=
 =?us-ascii?Q?vIJqUhPafgVYTgirdSKgbztRUB4UBKUYKxN0/p/+/TSUBBYgGu4RrHgzlCsv?=
 =?us-ascii?Q?mFjTOsz87M1JkdHgnftDuUb74hN0w3kmkaymRvw5/wYDyjG/gA/UE12FtPEx?=
 =?us-ascii?Q?1wAeGfYavyYCYWHByPStbgUJb+EatUA5g4xePCKBks0v/3Wsc+21wM6+GZPw?=
 =?us-ascii?Q?XDBuNYoDMcad7M95RJqL43+M4W5UXjbZ6TWPQhWWcV7ROnCE1nqMo3b8Mcgw?=
 =?us-ascii?Q?6w2K5uulOg8QLHIZYHkuSeTyyrxurgQ+AV0zHFag6ih383p+OFogt2zvgad5?=
 =?us-ascii?Q?eqB+wwTpbKc38UO9ynYIqn9Dq4BNhgbHQTfeAfj3Zhr55XLxpz1WFe/HDLS/?=
 =?us-ascii?Q?Ggr2aHKZaMfWwZr/dowhLlX1yxnz10wf1Hu1uvY1rK7FxeIJlnbLCWCiRsuK?=
 =?us-ascii?Q?laz+zkU6DrIByV1+Mx1mQrzWvRoWC/YtK/BOhDcxGjV1mpAJoYp6pjyGItNl?=
 =?us-ascii?Q?9/W60dULMssTQxyLpJUycAUI27BksVWfDMIXafX/Mj+qaJKwyL16kd3r2bQQ?=
 =?us-ascii?Q?c8BlHs0pQsWjCsC8NCpdIhfxwmK9s4aaH9DjD8lU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df8372b-3995-4cc0-ddc9-08dad208b436
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 12:53:25.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmDlurGSzaLK1XMKbhL38OOu7OtplDDIJfbrP0TUVqmwWLYDjT7QjG64vn1sKgnkac6N1vFi9B8Vzj4+CzRXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6151
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 08:02:51PM +0800, Vlastimil Babka wrote:
> On 11/29/22 12:48, Marco Elver wrote:
> > On Tue, 29 Nov 2022 at 12:01, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 11/29/22 10:31, Marco Elver wrote:
> >> > On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:
> > 
> >> For SLAB_SKIP_KFENCE, we could also add the flag after creation to avoid
> >> this trouble? After all there is a sysfs file to control it at runtime
> >> anyway (via skip_kfence_store()).
> >> In that case patch 1 would have to wrap kmem_cache_create() and the flag
> >> addition with a new function to avoid repeating. That function could also be
> >> adding SLAB_NO_USER_FLAGS to kmem_cache_create(), instead of the #define
> >> DEFAULT_FLAGS.
> > 
> > I wouldn't overcomplicate it, all we need is a way to say "this flag
> > should not be used directly" - and only have it available via an
> > indirect step. Availability via sysfs is one such step.
> > 
> > And for tests, there are 2 options:
> > 
> > 1. we could provide a function "kmem_cache_set_test_flags(cache,
> > gfp_flags)" and define SLAB_TEST_FLAGS (which would include
> > SLAB_SKIP_KFENCE). This still allows to set it generally, but should
> > make abuse less likely due to the "test" in the name of that function.
> > 
> > 2. just set it directly, s->flags |= SLAB_SKIP_KFENCE.
> > 
> > If you're fine with #2, that seems simplest and would be my preference.
> 
> Yeah, that's what I meant. But slub_kunit.c could still have own internal
> cache creation function so the "|SLAB_NO_USER_FLAGS" and "s->flags |=
> SLAB_SKIP_KFENCE" is not repeated X times.

I just quickly tried adding a new wrapper, like 

  struct kmem_cache *debug_kmem_cache_create(const char *name, unsigned int size,
			unsigned int align, slab_flags_t flags,
			void (*ctor)(void *), slab_flags_t debug_flags);

and found that, IIUC, both SLAB_KMALLOC and SLAB_NO_USER are creation
time flag, while SLAB_SKIP_KFENCE is an allocation runtime flag which
could be set after creation. 

So how about use the initial suggestion from Vlastimil to set the
SKIP_KFENCE flag through an internal wrapper in slub_kunit.c?

	/* Only for debug and test use, to skip kfence allocation */
	static inline void kmem_cache_skip_kfence(struct kmem_cache *s)
	{
		s->flags |= SLAB_SKIP_KFENCE; 
	}

Thanks,
Feng

> > 
> >> For SLAB_KMALLOC there's probably no such way unless we abuse the internal
> >> APIs even more and call e.g. create_boot_cache() instead of
> >> kmem_cache_create(). But that one is __init, so probably not. If we do
> >> instead allow the flag, I wouldn't add it to SLAB_CORE_FLAGS but rather
> >> SLAB_CACHE_FLAGS and SLAB_FLAGS_PERMITTED.
> > 
> > I'd probably go with the simplest solution here.
> 
> Agreed.
