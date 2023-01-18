Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9996720DA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjARPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjARPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:12:34 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767C3FF0F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674054637; x=1705590637;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u/vU1KEVYoSTTI/L9kmS5CRChQgj6DfFGqPh+MdHKqI=;
  b=gPFdaAY1IaG1Z7vA9W+Lb4rKlw7l2d1r2LQRRgu7TMFIaB5U4CK0f9na
   lta3ZtX6Ikig1eKp0G4el8V+eURXSg52zZjsBvh9j6M89xAFdF9RrXlRg
   3LO3aRvZJgew9aQ46I2lnE4YcBWxX7xl0G7kz4MJ9AS6eW7zjKSxGKhMr
   1AVSODAiMUzFIzx/BcyYscEK3JhnI0YyBolGvNzwovXwHcqe0/uuN/JLf
   z+Av5DY0iNSkKa2QBOznMnT69rkSIrDga/JTMWxCARPTDbTRwCJb6yLqv
   l4szI4Jk3qq3ibmoR4C0qs1yjDrCkvL/8KCdjRfZlvk46vnilA/TySOOp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="387350587"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387350587"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10593"; a="723109640"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723109640"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jan 2023 07:09:59 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 07:09:59 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 07:09:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 07:09:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJsrvscPCRlvibnZmZ1bp9Qmgo8pKgkpWIcYGkAC+WyTvQcaBAy4GX91yc/EP3i4s47S158fc+1uFo2sskRAGoGLdbBOYD/OBkJlV18U2Q085ldgqO5uidVwUYd0CPbBXlo0JZ2GiAemJn5uQ+IkaqPDgUK7H1n2nHRSm06132sxWuUiNjLtRldxQEnb22JVIj+TQ4CglxX6VSy7LkiwFagmHmo5Sgjap/yrW+TPqmEyujmhWsPWZoccf4YuSDh4zVLb8h2Wdawefr5M4D0YxmwAyfAFFhgcaJvcnBT4MNNKFUwKr7hhso9bzWo/HrAmnB/+hf2nlM6UbTXBRz0cmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVODhzrbpVIWEcGw0AEME01qAtxsisROj4KLMqXGDCY=;
 b=HO6rHR86Ir9Kqm6C1LKirLAFZ09/Wm6wKQj2TxmJZF5p3YgFqNZZ80r2bL2MWgc9gQTcbcjtjtkLkDvE1F1yDX31b24hkuq6CYIk+RXtn9Eb96saeP/ROulEUmZINI5diDT8gc+a3M3b4pI+hc+OcdmmYmNqj0L08NgjuRzwjYjUJVvQHKDDNfDFOeUT90F231TmoK4Lc4egQWbM/uBkBZuDj6JNz+EcBlogqeDKxRkhQ0sTM3zDnRKugPjTsQOxgooabISxg/g//57nmOdVa44vdiHAI8o2kuTTrTHJAMYX1oE9jMvwsQv72KaAX7Ehm+oGeLYBaFbI5/+GCOwyeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 15:09:56 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Wed, 18 Jan 2023
 15:09:56 +0000
Date:   Wed, 18 Jan 2023 23:07:10 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        "Song, Youquan" <youquan.song@intel.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Matthew Wilcox" <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>, <hongjiu.lu@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8gLHnUwnu5DkH0B@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
 <Y8ZVxJSZdtEk8Nco@feng-clx>
 <Y8aSc5xGO+rW2pyo@feng-clx>
 <CAHk-=wiS84nS9apjs_Vt=jjZ_+j+F8HQ3B+ABSvbzcqtW9x5Kg@mail.gmail.com>
 <2b857e20-5e3a-13ec-a0b0-1f69d2d047a5@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2b857e20-5e3a-13ec-a0b0-1f69d2d047a5@suse.cz>
X-ClientProxiedBy: SG2PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:4:91::15) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edcac20-8886-41c1-147a-08daf9660ea8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0HJgukLk3hKs/2GQRglsl71C+qNYd1qZ+SrMFGfjxoRKjVH8TpV2z7d9Kw74E11tn5ZD0lF9twOy5fDMY/uIU5UJjuetU0+5/UPOso23FYNqGtGAyTXiraH0Iu8SfjmbS8bp9eIPGrR+f1ZiVd5Ki1alPLsCxdy7Yw3SfiKI6dkP1KacpvaWOf2zOX+Bt1vGlkFDhy5JoTCZFV8jyhuAkRtoBlkf7nFHMUMg6saCbtkzKLr8c3cPGFz3v4eJzf2qSUoQhPqmcgqWAQ50+2Ng0IUPhuThChzw4dDnyXFdCfHmtokOrNQjR0bvjp9aQQgNxaP6B1T8MPUdC+4n86lywv1o1htbE5R6sm/78zTdm/AfXZP2hhovyiAFPN/dybtZjIh3JW+mXRGlCBKq1x5t+ouagjkrS7e2Z77NbwPL8I7yTajYqtyj01Bpx9UtCF9UmdK/r/Bk+W5wugG963OVUhiZ/ltEGwz51SHh9dH0eC3igYVpne8uxXzkaSLSspf9jEd9wrEmY3oFcx5aP5EbcWuweW2Qjv3pb6xnoby5yPozYx//pYAt/C60vZ09zFHg6bUJOAPQcvnH8rXR+FkxeRjQDEZFWYfh0VB/3+02y9vGQnbJHnGUQCGygzmfiduU0bIrNu0hEaTZ/AC9m880Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(66946007)(82960400001)(38100700002)(2906002)(8936002)(5660300002)(44832011)(66556008)(7416002)(30864003)(66476007)(8676002)(6916009)(4326008)(33716001)(41300700001)(9686003)(6512007)(186003)(26005)(83380400001)(53546011)(316002)(54906003)(107886003)(6666004)(6486002)(478600001)(6506007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IIH1bfy0S05PzUlEgesbqJpopSXGN8fww2cDIEY54tzmFeoOJxEuHfj+8+yS?=
 =?us-ascii?Q?uHn7nip3eirj0PklzlLZInGDH5YrI9L9q0dh+435xLsCOfQBfsRG6Rso4fDv?=
 =?us-ascii?Q?6g9LM92tEAADOwWw2WzRRGWiSrukyNMrdy+sA8WtOA+vnMmIZcDUlmJbeROh?=
 =?us-ascii?Q?AbY8hmP9MTBsjNI4hUk9whNgFGpbVYgsAQ/i0l7Gy06TGLHNq3nWG/sAM9Ig?=
 =?us-ascii?Q?uYi4ftQOrxv00R6AjBjSwexi4jjzI93eBJYu//Z4YMobdDWorulLJAFEUVnV?=
 =?us-ascii?Q?e+S64pKvGpUvCgpLfE0xALjTtj5VooOsiY7GMV+10+JBsl4SgIK/3a9SblAI?=
 =?us-ascii?Q?AUtCdZ2/gOYO2HI0cGeQqrAKdwAz2aok9k9E0G+8zS6ONHcl3p/+ao9Dog/F?=
 =?us-ascii?Q?CEBT5C2FiR5lirqhc7V8VpoC6VUvacrp42SDK7s9DsGSi3PMYLDfg+wMKa/T?=
 =?us-ascii?Q?m5/vTEEF2aKG5IU1K9xbZwPEoxTcpA8I+QTDSxII4ynygyFAxHYMtbrRhIRb?=
 =?us-ascii?Q?AKJRPpTg7p4jt6iH78SfVeNL3UVkYlBtHTSQ21vx52QWIs3fKHFn33UoRZQG?=
 =?us-ascii?Q?B7c1/7D4RYP2eAdHh4nYhJkc4nSAekzyCXLuwCWxxazMuK3I8DX+eaMn8GXJ?=
 =?us-ascii?Q?tc1YUMWfIhI33Cw3N3W8t3icY4BOOkqjoz8oHrZsKoInFEhTxxHqoRYiahSy?=
 =?us-ascii?Q?EyFqMfM/UICQ0dYVrLpKEWse4buMkPws4WmAlMv0HLYpj3AVHtH77ye4/es1?=
 =?us-ascii?Q?T1jAzmsDjYKMzx7zFVxYBzrfI+ZuZ1EcdXirJ99XM0+bqSFSKLtUGj3Bzdli?=
 =?us-ascii?Q?T5HkXX7g8p1rSuaT7/dmUMz1ypo17zbM+JfvG6GQBYYaIPoNnFVp04mKnsVz?=
 =?us-ascii?Q?qpzTYFEu2+FGGePq94sqUe6RxMue8139TSWw1G7HCIzx8+otjFLnRRQRoyOs?=
 =?us-ascii?Q?hXxLyyuzMmbt825YurkTTh3TpqQcjs0DaCBfsdWu6fmQ7KAtYhaFDdolXU5o?=
 =?us-ascii?Q?9MFvBf14kENQFZu1NK7wXHrAwsvT5u1oF4WgcQRVzrSMflRNzRFnleN51kxq?=
 =?us-ascii?Q?TaFbEyULyKsOa7ZW+5ak60YZLW1dd2Uf5uvLNv82idqxpJkT6yOazNd4gqS8?=
 =?us-ascii?Q?VcH7BsQh8KWV+yKXE5opQw/j2gY//CUKZYBAee8k1IQg3ffIbWr21IaqR70a?=
 =?us-ascii?Q?btHy3fRm0iZe14VILvpdQC5S4M8VMBryqTf3KQAUGnqUuIfnmYVstBiVvsfK?=
 =?us-ascii?Q?7ktBM4AD5MIvRsCM7mUSE/sBAF1YeT7ErgJAgh/700+1GuZ8dXLSMeL0VkK+?=
 =?us-ascii?Q?ws3ss4VwFgWltl6NfhUbGZB2KVAJbG1OR29RJe7Fwr0Dc0Hb9/RCnZVZ+BPD?=
 =?us-ascii?Q?62WZPw7XlxzHhkbydr81cBZ/zoG3E+Ywq314m2sGEM0hdQkKSYK2OyFxUxZ1?=
 =?us-ascii?Q?eiL0V830ro3th8VLxZZyYnPfS6mh2+siX+/snQElwhXgcynSVB2xPfV40gSJ?=
 =?us-ascii?Q?adsJa7blGVScegqcKOj34PD6hMUQf+VhRmr5zipKPG1cuCsUlYA4ZNR91Qef?=
 =?us-ascii?Q?UUYNQ5G146RNZlk51yA7yKZEa/tkXqhOH3ofglsz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edcac20-8886-41c1-147a-08daf9660ea8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 15:09:55.6878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wp6Vb2alPsYSjYW0q5WBkbX2DasXSQKoWva7W8NOyTjTYgESKFgTq1QToWFIr2JK5+yu3Os9RKA6GDAA9EjOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:35:17PM +0100, Vlastimil Babka wrote:
> On 1/17/23 19:25, Linus Torvalds wrote:
> > On Tue, Jan 17, 2023 at 4:22 AM Feng Tang <feng.tang@intel.com> wrote:
> >>
> >> With the following patch to use 'O1' instead 'O2' gcc optoin for
> >> page_alloc.c, the list corruption issue can't be reproduced for
> >> commit 7118fc2906 in 1000 runs.
> > 
> > Ugh.
> > 
> > It would be lovely if you could just narrow it down with
> > 
> >   #pragma GCC optimize ("O1")
> >  ...
> >   #pragma GCC optimize ("O2")
> > 
> > around just that prep_compound_page(), but when I tried it myself I
> > get some function attribute mismatch errors.
> > 
> > 
> >> As is can't be reproduced with X86_64 build, it could be i386
> >> compiling related.
> > 
> > Your particular config causes a huge amount of nasty 64-bit arithmetic
> > according to the objdump code, with sequences like
> > 
> >   c13b3cbb:       83 05 d0 28 6c c5 01    addl   $0x1,0xc56c28d0
> >   c13b3cc2:       83 15 d4 28 6c c5 00    adcl   $0x0,0xc56c28d4
> > 
> > which seems to be just from some coverage profiling being on
> > (CONFIG_GCOV?), or something. It makes it very hard to read the code.
> 
> I think whatever this is, it's also responsible for the bug.
> Now from all the dumps I've seen so far, the struct page corruptions looked
> like prep_compound_page() is called more times than it should. Which didn't
> make sense as the code is very simple, a loop of 1 << order - 1 iterations.
> 
> If I look at Feng's disassembly of 48b8d744ea84 (the "good" parent commit),
> I can work out that edi holds the 1 << order, ebx is initialized as 1, and
> there's a nice clear "inc ebx, cmp ebx, edi, jne <loop>".
> 
> Now the disassembly of the "bad" commit is much harder to follow when it
> comes to the iteration control. There are xors and or's involved so I didn't
> even try to work out the meaning. Clearly it can't be deterministically
> wrong or it would crash always and fast. But crucially I think it uses
> memory addresses 0xc56c28f8 and 0xc56c28fc in a racy way and that could
> explain the bug.
> 
> Before the loop iteration itself, it initializes several registers from
> these addreses, and the values end up modifying also registers used for the
> loop iteration control (ebx/esi) And crucially in the loop iteration it also
> writes some values to the same addresses, and there seems to be no
> synchronization whatsoever. So it seems to me, even if these addresses are
> supposed to be "private" to prep_compound_page(), running two
> prep_compound_page() in parallel, or even due to interrupt (Hyeonggon did
> reproduce this with -smp 1 as well) can result in a race ultimately
> affecting the number of iterations taken.

Thanks for the decoding!

For the strange memory address 0xc56c28xx in the assembly, they are
GCOV related  memory for prep_compound_page(), as from the System.map:

	c56c28a0 b __gcov0.free_compound_page
	c56c28c0 b __gcov0.prep_compound_page
	c56c2918 b __gcov0.early_debug_pagealloc

And your analysis of racing of these region makes sense, that some
pointer could be changed when a race happens. From the memory dump
in previous thread, it was always one off issue, that page[2] for
order 1 and page[8] for order 3 were wrongly written.

Thanks,
Feng

> Attaching the disasm I annotated for more details. Everything register whose
> value is coming from 0xc56c28f8/0xc56c28fc in some way is annotated as
> "crap" there (sorry).
> 
> > You also have UBSAN enabled, which - again - makes for some really
> > grotty asm that hides any actual logic.
> > 
> > Finally, your objdump version also does some horrendous decoding, like
> > 
> >   c13b3e29:       8d b4 26 00 00 00 00    lea    0x0(%esi,%eiz,1),%esi
> > 
> > which is just a 7-byte 'nop' instruction, but again, it makes it
> > rather hard to actually read the code.
> > 
> > With the i386 defconfig, gcc generates a function that is just ~30
> > instructions for me, so this makes a huge difference in the legibility
> > of the code.
> > 
> > I wonder if you can recreate the issue with a much more
> > straightforward config. By all means, leave DEBUG_PAGEALLOC and SLUB
> > debugging on, but without the things like UBSAN and GCOV.
> > 
> >> I also objdumped 'prep_compound_page' for vmlinux of 7118fc2906 and
> >> its parent commit 48b8d744ea84, which have big difference than the
> >> simple 'set_page_count()' change, but I can't tell which part is
> >> abnormal, so attach them for further check.
> > 
> > Yeah, I can't make heads or tails of them either, see above on how
> > illegible the objdump files are. And that's despite not even having
> > all of prep_compound_page() in them (it's missing
> > prep_compound_page.cold, which is probably just UBSAN fixup code, but
> > who knows..)
> > 
> > That said, with the i386 defconfig, the only change from adding
> > set_page_count() to the loop seems to be exactly that:
> > 
> >  .L589:
> > -       movl    $1024, 12(%eax)
> > +       movl    $0, 28(%eax)
> >         addl    $32, %eax
> > +       movl    $1024, -20(%eax)
> >         movl    %esi, -28(%eax)
> >         movl    $0, -12(%eax)
> >         cmpl    %edx, %eax
> > 
> > (don't ask me why gcc does *one* access using the pre-incremented
> > pointer, and then the rest to the post-incremented ones, but whatever
> > - it means that it's not just "add a mov $0", it's also changing how
> > the
> > 
> >         p->mapping = TAIL_MAPPING;
> > 
> > instruction is done, which is that
> > 
> > -       movl    $1024, 12(%eax)
> > +       movl    $1024, -20(%eax)
> > 
> > part of the change)
> > 
> >              Linus

> inputs:
> eax: page
> edx: order
> 
> stack below ebp
> -0x04 saved edi
> -0x08 saved esi
> -0x0c saved ebp
> (sub    $0x14,%esp)
> -0x10  crap
> -0x14  crap
> -0x18  page|1 (compound_head value)
> -0x1c  copy of order
> -0x20  page
> -0x24
> esp
> 
> eax = page|1 (compound_head value) / crap
> edx = page / crap
> edi = page / crap
> ebx = 1 << order (=2) / 1 << order -2 (=0) / crap!
> ecx = page + 1 (first tail page)
> esi = 0 / crap
> 
> c13b3b90 <prep_compound_page>:
> c13b3b90:	55                   	push   %ebp
> c13b3b91:	89 e5                	mov    %esp,%ebp
> c13b3b93:	57                   	push   %edi
> c13b3b94:	89 c7                	mov    %eax,%edi                            edi = page
> c13b3b96:	56                   	push   %esi
> c13b3b97:	53                   	push   %ebx
> c13b3b98:	83 ec 14             	sub    $0x14,%esp
> c13b3b9b:	83 fa 1f             	cmp    $0x1f,%edx                           
> c13b3b9e:	89 55 e4             	mov    %edx,-0x1c(%ebp)                    
> c13b3ba1:	0f 87 33 31 ed 01    	ja     c3286cda <prep_compound_page.cold>   only when order > 31 (?) 
> c13b3ba7:	0f b6 4d e4          	movzbl -0x1c(%ebp),%ecx                     ecx = order
> c13b3bab:	bb 01 00 00 00       	mov    $0x1,%ebx                            ebx = 1
> c13b3bb0:	d3 e3                	shl    %cl,%ebx                             ebx = 1 << order  (=2)
> c13b3bb2:	83 3f ff             	cmpl   $0xffffffff,(%edi)
> c13b3bb5:	0f 84 65 02 00 00    	je     c13b3e20 <prep_compound_page+0x290>  only when page flags == 0xffffffff (?)
> c13b3bbb:	83 05 d0 28 6c c5 01 	addl   $0x1,0xc56c28d0
> c13b3bc2:	83 15 d4 28 6c c5 00 	adcl   $0x0,0xc56c28d4
> c13b3bc9:	0f ba 2f 10          	btsl   $0x10,(%edi)                         sets bit 0x10 (PG_head) in page flags
> c13b3bcd:	83 05 f0 28 6c c5 01 	addl   $0x1,0xc56c28f0
> c13b3bd4:	83 15 f4 28 6c c5 00 	adcl   $0x0,0xc56c28f4
> c13b3bdb:	83 fb 01             	cmp    $0x1,%ebx
> c13b3bde:	0f 8e 80 00 00 00    	jle    c13b3c64 <prep_compound_page+0xd4>   nr_pages <= 1 -> skip over the whole loop
> c13b3be4:	8d 47 01             	lea    0x1(%edi),%eax                       eax = page|1 (compound_head value)
> c13b3be7:	8b 15 fc 28 6c c5    	mov    0xc56c28fc,%edx                      edx now some crap, we don't know how this was initialized                                          !!!
> c13b3bed:	89 45 e8             	mov    %eax,-0x18(%ebp)                     saves the page|1                                                                                   
> c13b3bf0:	a1 f8 28 6c c5       	mov    0xc56c28f8,%eax                      eax now some crap, again we don't know how this was initialized                                    !!!
> c13b3bf5:	8d 4f 28             	lea    0x28(%edi),%ecx                      ecx = edi + 0x28 - first tail page
> c13b3bf8:	89 7d e0             	mov    %edi,-0x20(%ebp)                     saves page pointer
> c13b3bfb:	83 c0 01             	add    $0x1,%eax                            crap + 1 
> c13b3bfe:	89 45 ec             	mov    %eax,-0x14(%ebp)                     saves the crap
> c13b3c01:	83 d2 00             	adc    $0x0,%edx                            crap in crap out
> c13b3c04:	a1 f8 28 6c c5       	mov    0xc56c28f8,%eax                      reset as crap
> c13b3c09:	89 55 f0             	mov    %edx,-0x10(%ebp)                     save more crap
> c13b3c0c:	8b 15 fc 28 6c c5    	mov    0xc56c28fc,%edx                      reset as crap
> c13b3c12:	83 eb 02             	sub    $0x2,%ebx                            ebx is nr_pages - 2 (for order-1 was 2, now 0) - remaining tail pages after first iteration?
> c13b3c15:	31 f6                	xor    %esi,%esi                            esi is 0
> c13b3c17:	83 c0 02             	add    $0x2,%eax                            crap + 2
> c13b3c1a:	83 d2 00             	adc    $0x0,%edx                            crap
> c13b3c1d:	01 c3                	add    %eax,%ebx                            ebx is now modified by crap !!!                                                                    !!!
> c13b3c1f:	8b 45 ec             	mov    -0x14(%ebp),%eax                     reset as crap
> c13b3c22:	11 d6                	adc    %edx,%esi                            esi now also crap
> c13b3c24:	8b 55 f0             	mov    -0x10(%ebp),%edx                     reset as crap
> c13b3c27:	89 f7                	mov    %esi,%edi                            edi now also crap, oh my
> c13b3c29:	89 de                	mov    %ebx,%esi                            supposed to be the remaining tail pages, byt modified by crap
> c13b3c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi                elaborate nop
> c13b3c2f:	90                   	nop                                         nop
> 
> // this should be the loop for prep_compound_tail
> c13b3c30:	a3 f8 28 6c c5       	mov    %eax,0xc56c28f8                      uh now we saved some value to the memory we read previously assuming some known good value?        !!!
> c13b3c35:	8b 5d e8             	mov    -0x18(%ebp),%ebx                     ebx = page|1 (compound_head value)
> c13b3c38:	83 c0 01             	add    $0x1,%eax                            still crap
> c13b3c3b:	89 15 fc 28 6c c5    	mov    %edx,0xc56c28fc                      and now we wrote to the other address as well?                                                     !!!
> c13b3c41:	83 d2 00             	adc    $0x0,%edx                            still crap
> c13b3c44:	83 c1 28             	add    $0x28,%ecx                           ecx pointed to first tail pages, now points to second tail page
> c13b3c47:	c7 41 e4 00 04 00 00 	movl   $0x400,-0x1c(%ecx)                   (first tail page)->mapping = TAIL_MAPPING;
> c13b3c4e:	89 59 dc             	mov    %ebx,-0x24(%ecx)                     (first tail page)->compound_head is now set
> c13b3c51:	89 fb                	mov    %edi,%ebx                            ebx now crap
> c13b3c53:	31 d3                	xor    %edx,%ebx                            ebx xored with more crap
> c13b3c55:	89 5d ec             	mov    %ebx,-0x14(%ebp)                     we might need that crap later
> c13b3c58:	89 f3                	mov    %esi,%ebx                            supposed to be the remaining tail pages, byt modified by crap
> c13b3c5a:	31 c3                	xor    %eax,%ebx                            yeah why not xor it with more crap
> c13b3c5c:	0b 5d ec             	or     -0x14(%ebp),%ebx                     and "or" it with the previously saved crap
> c13b3c5f:	75 cf                	jne    c13b3c30 <prep_compound_page+0xa0>   and that's how we decided if we should do another iteration :(
> 
> c13b3c61:	8b 7d e0             	mov    -0x20(%ebp),%edi                     restore edi = page
> 
> // here we land if we skip everything at c13b3bde
> c13b3c64:	c6 47 30 01          	movb   $0x1,0x30(%edi)
> // the rest shouldn't be important

