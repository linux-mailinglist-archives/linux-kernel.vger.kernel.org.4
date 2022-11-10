Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3D623CFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKJH6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKJH6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:58:00 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622AB240AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668067079; x=1699603079;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NSs08QfaD1ItXY2aVr8Z/pzHx6xyv99baeOvqkDBSLY=;
  b=nJgsNapXwN33TCXrwy3kH5L/3vAIsAgi9mx0IS8sqOhVar2noLz2MKRi
   Q066yeRLM5Wmj6AgyURzOh/8VfjUbNiiPUo0/gU8HMrffSG8GgKcj3N23
   NYqfXTZXB34ceevlExsleBP+idmHLSOGMy44NrULgn4t4ns3jDZUt6Om8
   wchYgvI965pm3tsXIWoqINaDMejqrWgkwpnIxecO2vaGYRGms6SfF9czl
   bnlUEdMKE8QO/s5+NGcPAedCPY6QCKeeR3YhhBbE4TRLEip5PUM5aiyx7
   zeGiOu9pD3GIBT17YXmLKIH/n3w8irdXikf2Pq8xaaoblGRqliX7L1xtK
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337996845"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="337996845"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 23:57:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="742755430"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; 
   d="scan'208";a="742755430"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2022 23:57:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 23:57:58 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 23:57:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 23:57:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDsyBbXERc8e3r255nuMND2YRridEg+FmkkoSn/ICop5ZC/Fq24yDcEXwa0n6FtcYUOavmx86AtA1bushdJJW93+OB0r/HQB00T1HvJBklDzTp1tJ96BtNZ29MzU/4DuxEh0EGhWPovBfE14MrxwCNjBzqsVkuKEUL1yzIFWmCz1Dds8Qw3V3h8wymqQSerUmJ/qipRMtN0KiJ3dT+xHGtPdHIzK25w334Mh5aXTdhCB1U6HJAhjmtR1B+8m5c6cdi5qny+WpHZQejdy4sfMLFYNv/ahUBPkwsl5cqLPir+4/uI8XjHk2j78bfz4P+t+wwAiUlfh2RBXRWjusBF5jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TROkUAWD9p0ZjmW8Nb1MSqXKfxLZTNlKAMYTOuAxObI=;
 b=kQEwC1+f8t8ahYNL5++Pt3G9YsK4XiHLLTp+nlb3B546S9lunkw67H5wCWJoevr9Vsh0PtsMkXjU5kxeiN78DvoLqxvYBg3hCtCAzSuJC71mRMHCAJx/TfsX+I23FTA4HrpOXs7ROWPvE19Kr6MEy/3VRYfXCxbW6p0cYzJNV0K2AaQDEJ6LZTQOHfMcaR/n/V3cn4puCyaQ4ZTAoZf7c6SkUqH5OzPRqyn71ZMpnKtYaoFboMt4UdFl4cnNHXlUJZlamEAypN9MKJ+6rYRpA8k+4UKNn6r8Fo+KqkuzGaqQ9J5/uy+x2Vczgqz+UlSKQIfVGGkDb7XPjekxTwgMyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW5PR11MB5787.namprd11.prod.outlook.com (2603:10b6:303:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Thu, 10 Nov
 2022 07:57:53 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::c00f:264f:c005:3a5b%3]) with mapi id 15.20.5791.027; Thu, 10 Nov 2022
 07:57:53 +0000
Date:   Thu, 10 Nov 2022 15:54:37 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "cl@linux.com" <cl@linux.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "rkovhaev@gmail.com" <rkovhaev@gmail.com>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "willy@infradead.org" <willy@infradead.org>
Subject: Re: Deprecating and removing SLOB
Message-ID: <Y2yuPUxruFuJN+qM@feng-clx>
References: <K5M3LR.3O50LSSSY5L3@crapouillou.net>
 <CAHk-=wjBqwJk9RgfoBuM00T49M7uQiLnOvLST7L6v5rhS7fkDA@mail.gmail.com>
 <20221109234832.GE307514@darkstar.musicnaut.iki.fi>
 <Y2yArTbOpKd6ASkd@mit.edu>
 <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e610b6fa-aa71-d612-0eb2-03ba6c4a6b46@suse.cz>
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 09c39f3a-d199-407d-db56-08dac2f14555
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B4KvjnL52i650StAlRjKb5XOEvNATi+h0PifM2r5glLr1wa0MLqWp6vRReHZQAKknQAznIxFiYAn9+2xKAbnpGTZGynMEoYVTLihElD3G5PSZ3xU0ON86JREIPEgUo4ciIr8tOeRgYJbBDqRQ6NXDGnWKSIzhOmLARUIZCQq3l0g5/YiSnx63NE6eysXgwQwkekwW69gUiz+u/vzC6Nc1o2YoECkw88sxpYdzyJbkLsw1MDhkLBieNA+zlzcoJ5tPsjWCkT3guNu9MYOUxxjgSAlhEA0HE1bPK+uArdfF1sbiQhC7gjwjbNicklwFQ3Rte43SQcDx88BEwaVbG2AvT5H4msObSnD0O4nDvRnD01DR4rTp9Uii/r8n/+aKFS+d6eMhFGz4fmR5QDDqCnSDSHeony3TItJWQSEQuJ2tTEBxWmlUuWOTlmL+cv2h0DdU7UufW1W3fi157okLs2Qj4ieWpqEY8Y5gs/OtBOWX8nnNp0ha7FjFvW/PpkUQcoq/LMXBwvLPZeZp7rskllRetOooJcyEv9zGtfTloJjfKHM8XIYPvX72rfHRcTdk5rY1X9DPeqQg7CvV2hW0DiWaBP/lrPDBN8IEMp8x0mQxggdTXhQHaTBQ63w0lEMwIaMgg2+cjgutu+4ycyyQUiGgCHVXMt+fbve3MWZDyb1xpSM3I4EiM051ug61kt4tvOme4xdAhEe9ZXxz0/oO2xHo0ZAeaihlBhTBOqQTN5RtxaSk26ot+0j7c4qItAePf1TMSTsYTXTMRDAA2qA2o+VcBuxmtpKYmoRYN2akgyq+s0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(86362001)(66556008)(8676002)(66946007)(66476007)(5660300002)(7416002)(54906003)(41300700001)(8936002)(26005)(6916009)(83380400001)(2906002)(33716001)(186003)(6486002)(966005)(478600001)(44832011)(53546011)(316002)(4326008)(6512007)(9686003)(6506007)(82960400001)(6666004)(38100700002)(3480700007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CgkQtbxNqE9tb3FSntt+/4ReAfyI8fArdHJBamG149TqDHNMKPGTmTK6CzAU?=
 =?us-ascii?Q?/ZRBjsS6En+l5KGjOr2JDkQbhQ9s7+Ij6avObZZKbwCOrIfFwUf7xdnZ8YRk?=
 =?us-ascii?Q?JvZbPAgy8IOXQ76Cdto4PYyWOr8+l5/6hG+jYxHAGYHgjqZUU+Yjxnr+3Sfz?=
 =?us-ascii?Q?6FAZCgkcEXu25yzccnuwpJn6OO1vSCvM2RMBX5g3ltAVYS+IRsHEfqWUHlns?=
 =?us-ascii?Q?dbsRtPb8QRiG+dH9TLusXmV0I8Qjyic5KnfYG+yvEaFENTx8KKXZgM+IgAwO?=
 =?us-ascii?Q?rApzkJVkt3kBmfH6mQWak8eoB5QDYuW+CtSLvSRvr8CB0NaX+zxuI0RGoBZV?=
 =?us-ascii?Q?YEexOt7164Zef5heqMJl55IeTsWTcCr5/2YoYaLAckLGVTog31k8B/r85n+r?=
 =?us-ascii?Q?PJoxwujomOMhvj3SJEUfKymq2FglrKjeUTeKIqoloKryyvPJ7yacRKbDcDe6?=
 =?us-ascii?Q?2RnBnd8k2htbSKJtWU026L7CHe8idGPzznWZXr/zUXn61+c61pFaI6ZuSgB6?=
 =?us-ascii?Q?NVfP6o5eiciWgdAtH+LNJTCvsb8r6CI1WE5zOGhzuusOL0J51LPTN2jcnUvH?=
 =?us-ascii?Q?53xK6zYNLv3uxBp1dgcVkrheqcEgM6mN5bBXB/FbQmy9NrvJVfXDUDO0Feer?=
 =?us-ascii?Q?mwv8iyLbTFsbvmrBsMl++8iVUTPpDRi2EGYTIkTcOYalBYt0Zf6XgBGFPFfB?=
 =?us-ascii?Q?KzacUa1IwGtI5K4/+5Vhv4qxen9qBjpG+SUPXAA7hTlaAJjUcTHK+vdW99DI?=
 =?us-ascii?Q?pFOU0V1hN3SEASkvs8rlaVZloPR+d7b5OVtC23U5deo0bTVqHuKO5PzGJ1Rg?=
 =?us-ascii?Q?QQIk3Y9BcG3k4VGK7PMYrTWB/jYpfB47VlAGjlKqHINQDesjojw7c8grTQi3?=
 =?us-ascii?Q?1ukDrATLlPfMlnxL0qsh8A0tVikwUSSZbjbaIgAweU8nHdCe4VV64XL3yGz/?=
 =?us-ascii?Q?6s7LeCecnM/sdJM0jnwymU3mcL0cLbKoIrJepUoSLva90ME815+XFrE578xv?=
 =?us-ascii?Q?bvvY+Ib3T3wELHoJSWhnm0XT1VX06DVWtRstV25OGk8VxHzL8R3yHr6kQQMi?=
 =?us-ascii?Q?QdlYfQSw3WRMjmTZ0ILbjYD/vvd0vwhAn7YMmT/ufeZaTLhqyk3I71sfBIeQ?=
 =?us-ascii?Q?vnR726v0j8djE43mMNhxg/DA+gzheQDIp/pnqaxIlGsPavZj1yR79A5gIBD3?=
 =?us-ascii?Q?kHKlULkzSbTqiaVfyWrtuNZVKrLNUqOptch2rlrVUpKInXd4Halp6HY0jFea?=
 =?us-ascii?Q?7ZzZDN+mhTkgWdR9Oz49d7mMniZri1B4EN1d3csIJGMnEQDCyadb/dhuWwTH?=
 =?us-ascii?Q?od3Nj9KWamCxo8DRCzFvxr0XZ5FWOqwvgw1SiD2y+cuCJ9pkGi8fA1N+XFlQ?=
 =?us-ascii?Q?FeNBF1mAzYwR2MQWy33ol1eIf6HQ4CNYyhcdv32dRQBokCYO4JTAL3NQ0RkM?=
 =?us-ascii?Q?kpAEu7N2R1FItPDZvioWEyJbx9EQU3Scoqp4tnehoJWTevhzBrhBsEuzpszY?=
 =?us-ascii?Q?P0nReYMGXYelxI2b1An2a/UOsH+2LMSftJm70eegm2VEakGCzlhW39jI9J8N?=
 =?us-ascii?Q?kCqmHNpXUofpqZtwWJaqABG4jjOVyTNAhmLr5YvG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c39f3a-d199-407d-db56-08dac2f14555
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 07:57:53.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UpR45n3p/L7Se1LvWY8/xS0PAq3bR/N6veO1od5SzGLGPLRDGG/U32ogrWdSR+EB4e/i7lw1msL9EpFoB+3QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 03:31:31PM +0800, Vlastimil Babka wrote:
> On 11/10/22 05:40, Theodore Ts'o wrote:
> > On Thu, Nov 10, 2022 at 01:48:32AM +0200, Aaro Koskinen wrote:
> >> 
> >> Some of the reported SLOB issues have been actually real driver bugs,
> >> that go unnoticed when SLUB/SLAB are used (unless perhaps debug stuff
> >> is enabled). I'm not saying kernel should keep SLOB, but it's good at
> >> failing early when there is a bug. See e.g. commit 120ee599b5bf ("staging:
> >> octeon-usb: prevent memory corruption")
> > 
> > Out of curiosity, are these bugs that would have been found using
> > KASAN or some of the other kernel sanitizers and/or other debugging
> > tools we have at our disposal?
> 
> Hopefully slub_debug redzoning would be able to trigger the bug described in
> commit 120ee599b5bf above, which is:
> 
> >     octeon-hcd will crash the kernel when SLOB is used. This usually happens
> >     after the 18-byte control transfer when a device descriptor is read.
> >     The DMA engine is always transfering full 32-bit words and if the
> >     transfer is shorter, some random garbage appears after the buffer.
> >     The problem is not visible with SLUB since it rounds up the allocations
> >     to word boundary, and the extra bytes will go undetected.
> 
> Ah, actually it wouldn't *now* as SLUB would make the allocation fall into
> kmalloc-32 cache and only add redzone beyond 32 bytes. But with upcoming
> changes by Feng Tang, this should work.
 
I wrote a simple case trying simulating this:

	static noinline void dma_align_test(void)
	{
		char *buf;

		buf = kmalloc(18, GFP_KERNEL);
		buf[18] = 0;
		buf[19] = 0;
		kfree(buf);
	}

And with slub_debug on and the slub_redzone patchset[1], it did
catch the out-of-bound access, as in the dmesg:

"
 =============================================================================
 BUG kmalloc-32 (Not tainted): kmalloc Redzone overwritten
 -----------------------------------------------------------------------------

 0xffff888005ebb032-0xffff888005ebb033 @offset=50. First byte 0x0 instead of 0xcc
 Allocated in dma_align_test+0x1b/0x29 age=6554 cpu=1 pid=1
  __kmem_cache_alloc_node+0x2a7/0x320
  kmalloc_trace+0x27/0xa0
  dma_align_test+0x1b/0x29
  late_slub_debug+0xa/0x11
  do_one_initcall+0x87/0x2a0
  ...

 Slab 0xffffea000017aec0 objects=21 used=19 fp=0xffff888005ebbf20 flags=0xfffffc0000200(slab|node=0|zone=1|lastcpupid=0x1fffff)
 Object 0xffff888005ebb020 @offset=32 fp=0x0000000000000000

 Redzone  ffff888005ebb000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
 Redzone  ffff888005ebb010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc  ................
 Object   ffff888005ebb020: 50 92 28 00 81 88 ff ff 01 00 00 00 11 00 b6 07  P.(.............
 Object   ffff888005ebb030: 6b a5 00 00 cc cc cc cc cc cc cc cc cc cc cc cc  k...............
 Redzone  ffff888005ebb040: cc cc cc cc cc cc cc cc                          ........
 Padding  ffff888005ebb0a4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a  ZZZZZZZZZZZZZZZZ
 Padding  ffff888005ebb0b4: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a              ZZZZZZZZZZZZ
"

[1]. https://lore.kernel.org/lkml/20221021032405.1825078-1-feng.tang@intel.com/ 

Thanks,
Feng

> slub_debug would also have a chance of catching buffer overflows by kernel
> code itself, not DMA, and tell you about it more sooner and gracefully than
> crashing. KASAN also, even with a higher chance and precision, if it's
> available for your arch and your device constraints can tolerate its larger
> overhead.
> 
> >        		      	    	      	    	 - Ted
> > 
> > 						 
> 
> 
