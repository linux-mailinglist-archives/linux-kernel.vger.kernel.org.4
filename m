Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F24670FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 02:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjARBRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjARBQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 20:16:28 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED41B3B3D5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 17:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674004239; x=1705540239;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aYL77OZpwXg+cgwTPtNR/wH0EaNDSKb2auj2Ip7d31k=;
  b=Q8zO27q0lraWob3HNHk3C4jMPvKyWUZlp0kktBKidgCnvvM+zt63HdrR
   FB2Xnhfaj2HdYz/6WnXj6nTA4mNlzc6hGYx0X4vW4/N+Hn0/MKynNDttL
   0vOVrWSWewCI1CsX9qfI0tJT05zy6RdTQMz1cORPOsvH+Rm9hv07zjl7O
   ItWB/n/QyZI7HoYRFiXigDDX16KwLn5plDwnhBw07uUXv7chsSF5xavn2
   R5OpXgX9qXSTfjR7lZIhmrg9Rnijy6Hr7fvfOl/VN1UnMSvBvyr440ppw
   vnRPEe50f26Dl4j63BBzArh50SG1oOjikwSHXj26+3bI04GTCio5Kcjd3
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="326140373"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="326140373"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 17:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="748247675"
X-IronPort-AV: E=Sophos;i="5.97,224,1669104000"; 
   d="scan'208";a="748247675"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jan 2023 17:10:38 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 17:10:38 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 17:10:38 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 17:10:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NsxbJ/3cl47wxrT4lwxZ78w8tqcM7YuBDGf5qc41iHcw3yFgehVVUONIsQQyM2Dunrhh8w19gxvvzQ2P54uRwJcfHKAem7gTDFBVs2wEVFW11F4Q+BajHf7cJR15kZ+DRsHVv23iLc2dp9HbQox1V3SJYOkcgJaUWrSc5qb15inlweIXR+FDgPUiLRdOwn5KFaOoaVFXIMLwt0RyhnOlb+Lyr05YbnwpP0LSHusAfvsSd5EpsWgR43H1OyP4h9WieUguaFfeOFncED06xMlKja8pz8kda+5Gzw+J6VwBFM85LhTp7Ciz1Kkq9L/sBLia/sAEDu72YMA2JZSymXM5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+0mvfH6XaBFfgNEMNsdL3J+JMc/pt+7o6surz8EAL8=;
 b=KI8EyKdBUeVM2Qqi+dYxnG286p1o4Wq8/hscFFqG1NBVbkjSmU5qgl0UpKsR9HkjlALOlSSRsxo59IA01Uc2xfsXfJbRmRS2Ulo/5eg19NfFJzlgoal8f+5NFgTs3wVRpeToPYE0aAMa5OSIDDvyy9gJZNpnKqET2jcHqkEAjcy4EmMNY+afohBg3XqUvmdjKeZ9x4NoXGqESDjTfxMiRRMwfQoi7HS/rme2jb6lkC4juFSrg8+7o7JHOYl4HBT1zaTH1ranLXRfjqLwjsF1zCbcNx/a73zK3+4KeL9M4H8dL5jYZ1f6tAOGoqM2ed5gcMTipzGqM9xuLcDX6A5/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by CY8PR11MB6913.namprd11.prod.outlook.com (2603:10b6:930:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 01:10:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 01:10:34 +0000
Date:   Wed, 18 Jan 2023 09:07:50 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Vlastimil Babka <vbabka@suse.cz>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <hongjiu.lu@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8dGZkhytk25iyr1@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx>
 <Y8aSc5xGO+rW2pyo@feng-clx>
 <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:3:18::26) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|CY8PR11MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cc8bc3-84ec-409e-5c9a-08daf8f0cce0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JKJqderzOVDEiG3IuWSAAZ75z3ctRsw9vxLyTBH5oJ5HkVvVdbL1Pv8rNdBgb1X4TS6CMdSPHZAZYlQJ4ixuJ+KL2I/lxQAJeG8OYT58nAtQ2IBLdgN7dXdK6QWqHbSocGl8r2j0ov2ziFD/md8XWPDILsAP/7ARL4fJgObqsHin15skVQFyJGGEO1bNtfuQwoESJUSI9jHv7PLijmGtT2ZQOK158uYdsLa6K6KzLqXmhI0u7MS3SD0VuUd+LBtWenBdJ0jTKPPBHmL5hCyRIveCacyq0A4p1ciUbVmJKFlyqT2qf4+4EnhuqMaAIUKIfVfScdpGj8DITCDGdi4JAZ6Usq2Bz4ZQqB68siECrptGAe3+ns3v+AyUt+ZvAzk2pUM+E8hF8KbJq2jcFU8/zgsCVaFZXezpQ3bpoIk8nmuLDdqqPlvlttGH6okKZhKbwjuahZ50wCSPyCByekvRUk25HCIjgYw14kZC2u3D8QkA1447ym+OMyPdgGhqcMhpOu4IAUlEEJhMKLMcaKPzwxehAh+K7IbAwrNhyyUKdQTOhn6w7b5TzIG1DICfs1eu5gobzNliYMl7Nh+jws//VeQiz42soAmRQ3SCJUTfAdb1gB8sncyZb3G+m1XizbjJdkXPnOLqrWd+fYnSp/Js0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199015)(478600001)(6486002)(107886003)(6666004)(53546011)(38100700002)(86362001)(6506007)(33716001)(186003)(9686003)(82960400001)(26005)(6512007)(83380400001)(66476007)(8676002)(8936002)(7416002)(4326008)(5660300002)(44832011)(66556008)(2906002)(54906003)(6916009)(41300700001)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?90Lr60P8X6WFWLwtpMCqhQrK7F2qCOYDHdDT+ysV1QaBNgUxigmtykUBCDv6?=
 =?us-ascii?Q?1qZpbaXU3l5OBP1MeLdev2lRBwwIcUCgObPJqQqOMcrSD1ox4NQwFMCVb3HM?=
 =?us-ascii?Q?/y28OLHYnqf/PAZoT6tZaRdwmF0W0tjip/a8k9dwKGK97njaWEcRDdaKQlRF?=
 =?us-ascii?Q?HHri8xHZparqfiF6bfwkUtTgXknSVz6T9fQlBRh1sRSUs052PIeat+0/qfwa?=
 =?us-ascii?Q?ynvTZylmDoDcu5lPwoRI3CgJlfuDAQ1AIJQk+zuH3B/TjiO7lOc6usZb8v4D?=
 =?us-ascii?Q?mDxfJ1avhG1Zo+ZlUijdfDoH4ASJKdpLHq5XDNOuGZhAi63gcnb3tZxiPP4C?=
 =?us-ascii?Q?jUdSr2Alrj9hssGv8cbcsEQCL7VZYdXqUZcUxEMJ9bWFN+SmIAaTX7GqNWxT?=
 =?us-ascii?Q?4Gwmd4TMExUq2VsIkT60xjQRVICgqy+uOkETaafi3i3/nvIel74tGdiz+p2t?=
 =?us-ascii?Q?0miT1bzR7gqTUq+lNQNm0uuvZ3Ow4TZQfPftPTlvR9X/i6PM6Wr4McbLyhG0?=
 =?us-ascii?Q?iR9ShmnZx5fQzoGa+gFL5nOa/F6ppRzID34x47T9pjpBZ3IQVW6nOqcu/X36?=
 =?us-ascii?Q?ubrl5KMe9nGl6buFVf9OT0htGv1h2FNBtYewFp/JCyV/HjVREI3rz2HT1Vay?=
 =?us-ascii?Q?ExK7dd9cWUwFNwwJJU99Hb9KEzQfnBTBXF24gOwO24oPu4fnfCb3puzGKykB?=
 =?us-ascii?Q?Z6Y7ph9TPmNK2hHkJQPHELKeW3o3ASfvpRcBnvq9yH4C0wPbLV6jeyqWs2BX?=
 =?us-ascii?Q?TyoSGPNEoUtyTGSLxu+NztlJ5ZKJWhgq9iZtx94jBPV2bLrnxE7QJ/BVC3Yt?=
 =?us-ascii?Q?vcCP6Oni1Rs8c8JTwtfZMNDcoIWBrxWupJGv4Ja/mBnqIw7hhzCYSYt3Vwgw?=
 =?us-ascii?Q?hHaMm/laNl0yL5Z80AEUFnC0y57oQuo/dlUjvcwWmrtQs5qrx0ID4qbPhE4h?=
 =?us-ascii?Q?U3wo/D936u+CqpJUBvoc2ltOOsr5nG5txX3zvS2GcbUUmsh/V6mI4vC7n8mp?=
 =?us-ascii?Q?i/sr/mctsLu1doCmvWEpfNQodQHXUA6EZ3x/ZDTHDv8ZOgTLuzWd1q+I1ojm?=
 =?us-ascii?Q?TfYj1ZswxXsjG1ZyMjPRtOrLWCEP4fi+SiV1+cZc1q/EwO9DF8ANUWGoXgfv?=
 =?us-ascii?Q?g5punRvnyc4gpqxP+ADffeeV46BzJg5R6oxkZ8PmJMnG1skFx6gMMbU+RJ5K?=
 =?us-ascii?Q?yz8Y9lM/rtE+TIMkAaZEZ83Anc49kVoxCHBAoB8uFKbZBwZmqfInv9ws6O5E?=
 =?us-ascii?Q?mlBmdJxbnHN0FwnwEohEXdTq/dX82QTbfO4/6PnfjmQClHsbaQB9RgZ+uma/?=
 =?us-ascii?Q?G1MQW61CVP8OLYyzmzoXbdvUPTWRjUewYx9V6nACc+RCIyFDgMcosnAfucr2?=
 =?us-ascii?Q?DULXIqaZmCnBvMRp/1eSyDsRzmeE6+gfyv49fflS3FoFn9MDsBSbkoR3Xkg/?=
 =?us-ascii?Q?fnm2YtU9d5mppOruHXyRHeMRmC2YXJZ9+bVreEW0zlXuHV8BJ/diDVh9RAMK?=
 =?us-ascii?Q?pBPrs0v1fdRJxNG/SoOXaoAc2qd+0dsH73nYBRxCqB6booBvKdJUmnwf3bfv?=
 =?us-ascii?Q?E7zuoe2WCdZejGNH6DabVniiDAUNtIt65T1QU9vp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc8bc3-84ec-409e-5c9a-08daf8f0cce0
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 01:10:34.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aOrSALsTCZZpT1Ns3CxZnIFNIpTyzP7Oeovky6EmwYWOZMkdbIZpkHRodOZQzzDdoceCW3QxXjeuR7GN5cIFUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6913
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 10:25:17AM -0800, Linus Torvalds wrote:
> On Tue, Jan 17, 2023 at 4:22 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > With the following patch to use 'O1' instead 'O2' gcc optoin for
> > page_alloc.c, the list corruption issue can't be reproduced for
> > commit 7118fc2906 in 1000 runs.
> 
> Ugh.
> 
> It would be lovely if you could just narrow it down with
> 
>   #pragma GCC optimize ("O1")
>  ...
>   #pragma GCC optimize ("O2")
> 
> around just that prep_compound_page(), but when I tried it myself I
> get some function attribute mismatch errors.
 
Good to know, thanks! will try this.

> 
> > As is can't be reproduced with X86_64 build, it could be i386
> > compiling related.
> 
> Your particular config causes a huge amount of nasty 64-bit arithmetic
> according to the objdump code, with sequences like
> 
>   c13b3cbb:       83 05 d0 28 6c c5 01    addl   $0x1,0xc56c28d0
>   c13b3cc2:       83 15 d4 28 6c c5 00    adcl   $0x0,0xc56c28d4
> 
> which seems to be just from some coverage profiling being on
> (CONFIG_GCOV?), or something. It makes it very hard to read the code.
> 
> You also have UBSAN enabled, which - again - makes for some really
> grotty asm that hides any actual logic.

Yes, you are right, CONFIG_GCOV_PROFILE_ALL and a bunch of UBSAN
configs are enabled.

AFAIK, this is a random generated config for sanity test, Oliver/Philip
can correct me on this.

> Finally, your objdump version also does some horrendous decoding, like
> 
>   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
> 
> which is just a 7-byte 'nop' instruction, but again, it makes it
> rather hard to actually read the code.
> 
> With the i386 defconfig, gcc generates a function that is just ~30
> instructions for me, so this makes a huge difference in the legibility
> of the code.
> 
> I wonder if you can recreate the issue with a much more
> straightforward config. By all means, leave DEBUG_PAGEALLOC and SLUB
> debugging on, but without the things like UBSAN and GCOV.

Oliver and I can try this, and will report back.

> > I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
> > its parent commit 48b8d744ea84, which have big difference than the
> > simple 'set_page_count()' change, but I can't tell which part is
> > abnormal, so attach them for further check.
> 
> Yeah, I can't make heads or tails of them either, see above on how
> illegible the objdump files are. And that's despite not even having
> all of prep_compound_page() in them (it's missing
> prep_compound_page.cold, which is probably just UBSAN fixup code, but
> who knows..)
> 
> That said, with the i386 defconfig, the only change from adding
> set_page_count() to the loop seems to be exactly that:
> 
>  .L589:
> -       movl    $1024, 12(%eax)
> +       movl    $0, 28(%eax)
>         addl    $32, %eax
> +       movl    $1024, -20(%eax)
>         movl    %esi, -28(%eax)
>         movl    $0, -12(%eax)
>         cmpl    %edx, %eax
> 
> (don't ask me why gcc does *one* access using the pre-incremented
> pointer, and then the rest to the post-incremented ones, but whatever
> - it means that it's not just "add a mov $0", it's also changing how
> the
> 
>         p->mapping = TAIL_MAPPING;
> 
> instruction is done, which is that
> 
> -       movl    $1024, 12(%eax)
> +       movl    $1024, -20(%eax)
> 
> part of the change)

This version of assembly diff looks more reasonable. One thing I
note is the sizeof(page) with this config is 32, while it's 40 for
the randconfig used in this report.

Thanks for the analyzing and debug suggestion!

- Feng

>              Linus
