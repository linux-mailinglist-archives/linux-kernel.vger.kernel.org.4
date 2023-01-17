Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F766D77A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAQIFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjAQIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:05:20 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2060B2004D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673942719; x=1705478719;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HEpJt8OGDfk2OyumH+lWTjDYKyfKqmZ1zkVehKsl3Hs=;
  b=W2QbV9IkJ4i3/kEddu7obTHtT04HxcYyRDGU5tTAPbTZoiLPYZAbEKcK
   1LjxuTToiyBKO1/GwUfH1nfmkiUNURT+K4ffoaZdzJkJx/WdginOcg5I6
   i0QmML0+Rx3XszspSJYHbvqH+UGfXmS6+mP5zxOeL448XnZQLx2HkckH+
   QRAFK/Hc5vgMyuNCDmUEtqJF86vn2DMTnSB7KuVXwr0KujSt1VQvAVe2o
   SCqfzk67CeK/PPppvBJ6AXHJ2Z4M391X4C47UJQ3aHjstqh9n71f2vudr
   Xace4EV2GcNzrrIcF09r2W/UXk2eZm7dfUz045Yc7X+w6c2Gjhu+p7hUr
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="389136285"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="389136285"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 00:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="801651119"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="801651119"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jan 2023 00:03:58 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 17 Jan 2023 00:03:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 17 Jan 2023 00:03:57 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 17 Jan 2023 00:03:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QOdupPQXsDbXIEw8BL459xOYw44IOG6Q2SeuIs5SEDhzQN7o8mbyNk0twFytgbDpMv4rQfWWCkAitAtzigpAYvw4DTQ5MRWtJ8c+5KUGtj8vsH4qe+AP1tYX76etj2hT23LD9+A9qs7hwRRafCvSzYOlCRntmft9WgqVN7hS9USXbNogZ9QMEgkkDYMwfPsz/vbDNJDcZ6aSb/GKRonZSTOtnDolzrbA+3nDfmA2VRHyR+1apsNyZhsjILavG+KwPBiejTr1D6GzzQue1PLGEYxK/44PZs3LlHJXOG5KbPeLECfz8gxmcM6LYwIy+xgBRoYWe8vJC2IGOFbZNziQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGmKrlhRtv3R2x0STABL/FzxaTu1aSOICsWrGxCLVjU=;
 b=c22SyDDYzPufgyjtZtV8RD5yStM5p6mhBedDdZuyfe8pcfsDE15OQmuYqdJBkRUPMmiI2Z7JB4+El+EL3SitDUnKBrI+nqt2SdHHt5157+HglivQVLGXulNPu6+1jLCislZFDPTZeyFt9UM86Ynn7FxhqZqsjlKdbuh4ZloYemgwSORdDEA8mU8N2U1C56/kpYhmABp+1ht+/9jBY2DRO/cPt+seCCwr0jmDQkKcoOD4jfrpg5yKuQtc2hw/Gc3Kpk19Qpp5UYXmBP2EJ2w1Miq8vP1WO7Ygb1LJvNY8ACxh+Fvj4s5/JiQphuPVKhtWzxflgI/6d0nartdV5qCPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by DM4PR11MB6264.namprd11.prod.outlook.com (2603:10b6:8:a5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Tue, 17 Jan 2023 08:03:53 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::868b:ff1f:d827:188d%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 08:03:52 +0000
Date:   Tue, 17 Jan 2023 16:01:08 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
CC:     "Sang, Oliver" <oliver.sang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        lkp <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
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
        "Yin, Fengwei" <fengwei.yin@intel.com>
Subject: Re: [linus:master] [hugetlb] 7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8ZVxJSZdtEk8Nco@feng-clx>
References: <202301170941.49728982-oliver.sang@intel.com>
 <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2f483247-da76-9ec9-3e51-f690939f4585@suse.cz>
X-ClientProxiedBy: SG2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:4:188::12) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|DM4PR11MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: f35dc963-eabc-4bfb-7723-08daf8615f35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X6+MPDtlf2PnIhwJuVsWOxHf+eGS5MZknwlxj0CsAYBlKKktvOC0NDSqcIhBzfPO/4xYZwDIWPR1YUB7h82xp+O8kMarWGuaFkOpXLz8c3jdVWpzGeWeswTtIMwTmePJII+TS9F1AYn/0oCC3CvKMKKxGE3Vl8gQg0ZinjWRYPKFAjN1Kx2PrgugUNWps/PBv8u7BV0kZtphE7Swov9wNm9jW06/Q+y1uNQqPBY5HcgQE9uhkY/g/cAp4nWps8w7ECtv9pynV2g1zPod53CSQLTrHHZJtmZYI82kwY3wizkaxaB+lJ8SyqiE2tnrhee+BXWlgr6znmLTH2I5Ln3nBZ2H5Yh73arlS8s/CtMkrCvoOPU85gfZdmZn8/h3XjxvWQULjJpiqjKl0sFacVoynOaQUeJPpne8xnRdjDMxpzgRkHkQ4AA9YeC1JPEwpJWYvCyuzPs+r93SFVIh+4lynfuIHZbBOqAJ32FIVH3cs1B6nmn+q+zSYsgB23ygJ8MCIy4HXGwxI7Zf51jBEVA4I9XdzqqbXP1zc34a3/I+y3oqqlvNo+mCCPmAAeVeEdkVyW9N0BRa7eDA3amJ+yo0TzAGJh/ovN114znTCA+kBicEdupWM2KTp0xMvmPKAD99bEU9rOLwUka5EqwBX5bjlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199015)(33716001)(83380400001)(53546011)(66946007)(66556008)(66476007)(9686003)(186003)(26005)(8676002)(6512007)(6916009)(41300700001)(4326008)(86362001)(5660300002)(82960400001)(8936002)(6486002)(107886003)(54906003)(478600001)(316002)(6666004)(6506007)(2906002)(38100700002)(7416002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0kgUnPOAn2aIUnTpb2RhEl/IVJqy/XZafFzaZhDpCzs1WxlWXat5AB2FgxjR?=
 =?us-ascii?Q?Kg9S8ytRaCyvcTnIVR/tflw88FipMyyEhpj0XewwzqIWNgFKVgxb7MJkT9n3?=
 =?us-ascii?Q?jptKYClKLgBPcZCW/qqIhxPfAQsvhkHNEq/gGOJ6Q8ZADjuia9PO3xaCGUCJ?=
 =?us-ascii?Q?WEAPj9fuJv+d63q627A56efj0IoHHZY8TUgNZcSDUAR5c7zZlPTFFuVQuzWV?=
 =?us-ascii?Q?o0rcEg1Bs+yMoitazACuIB+z3N3OBzNk1CgE3HbTOWqdS2cKZf+Lss7e3XC3?=
 =?us-ascii?Q?JIqJzGEnaB+tCoXMQDI+CfdeG2yN1P8UdJai0KNWY5QJZnGmvlI6AVeF7b+E?=
 =?us-ascii?Q?t8yx+XE7g4RoaIMYOVHootbaGC1rJGFy9OY5arB5cp4K3e4Ii7nvb3Gl40rG?=
 =?us-ascii?Q?ooi5CJETK/xHcZ5gg2Ts4Upk7tZbbUbFHWPih0div3rbQ407oB8pKjxymXcY?=
 =?us-ascii?Q?1h3lF23Q1oyv5sbkA5+8XXzuFwu6wK9EWEM7qOWjmFAeEMSLlNkjoIcr6M57?=
 =?us-ascii?Q?wO9yZH5bhL8rQ+e/EtFfji23j7qzXPffZ62+Oqqw0UfeJBxt4mHMBVZ7DdX/?=
 =?us-ascii?Q?ncitu6M5GwMWB/BC3s4esqMDQl02tmKcHZxpN2cdb6oUHuBzSA7/AdOjOiuR?=
 =?us-ascii?Q?Pff8yPYP3ORmKk16klUyy3JFioOUqKIHC+s+uI69v3UT4ksGCTozitYM6Tv6?=
 =?us-ascii?Q?Ds96UkGjTgEmzmz68qY2XyK+VJ5xq3gQK4X/Swyqf+/p738CnvutNTZBCXIr?=
 =?us-ascii?Q?iWCcUVD9GuvtunPUeHMozKhSOIjDSv1fqTbmeDslFy6cbez98N2zknWqBfAa?=
 =?us-ascii?Q?QAhsJwUrBKBpnw+JJTRuOK6CMA+Qpyws/gDcz6o6dt32CVZcXozakcUDBqbz?=
 =?us-ascii?Q?JswpNr0W/d1mRsgCXW16xA645n+kuQwve9/J9p8SWqTDqFzxOsV8nf4TL6ms?=
 =?us-ascii?Q?R2JXQj0cHvekRVC41TlnCgq0dnOBqO5SKQpzQT+VHRz+zLQxafxjv5AAy9Mr?=
 =?us-ascii?Q?NDo77tNYaixgyngom/xX0tgeO/CuXHybTdaVWep9P2RLXrNNlNTvPmvFXgpR?=
 =?us-ascii?Q?KJKLfA4BUKQZOsqq+nozYi/15hni/gfUQmww9BSRNDbwpk6TSwm6bM3HZSA0?=
 =?us-ascii?Q?w45a0Dg8lgIMHo1fCjDPzxMZtCAlOAi/S4HeWWF7QDa9/jWFSM/0EiNLl8Lp?=
 =?us-ascii?Q?WmQE7H0/FxRGDDQz8oY6fRQCc54/tcQ/AIJAYVywxFCOvKHDa0GZto6RaOE/?=
 =?us-ascii?Q?PolsJoZxgQsLab24a1MChfyVDFOFZG0ukviIK2JFQ/ZeR+UdeFmQUU3n15xF?=
 =?us-ascii?Q?kFkw0fK5lOK+1h1BDzpcqwUF8jiCtIYJnc+9T7R+DZfujljc4J0t/+fgDYUC?=
 =?us-ascii?Q?X+2PGbClhzq9i6qsrvAhMMTZ2nTmrr2xJzAJLP/Lp9dDFwCuT8YqmoE1m1w1?=
 =?us-ascii?Q?sIayzcF6TKrHXCLzGx0pX/XtVPTRuZ7aXNal2w8Dlz0GnyB7oZCnXSws1gCS?=
 =?us-ascii?Q?SQ/9K1jnN8uPwzVfa1t0llclZi1JFeP6TrpZp2+6pItPVss6trZmrO5+vRnG?=
 =?us-ascii?Q?jESa9hQuWawFKLezmE+pazclrKzxL4hRbnxfp2gV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f35dc963-eabc-4bfb-7723-08daf8615f35
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 08:03:52.1076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWyQzgUKdMfpEvyw55ubk8sPbT7qiFq+ghSEwt3hjIi4+HVXLq6HIaknBPV3GC7lamM7AC7DVZsnOSWysSFGLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6264
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 03:39:15PM +0800, Vlastimil Babka wrote:
> On 1/17/23 08:10, kernel test robot wrote:
> > 
> > +Vlastimil Babka, Hyeonggon Yoo, Feng Tang and Fengwei Yin
> > 
> > Hi, Mike Kravetz,
> > 
> > we reported
> > "[linus:master] [mm, slub] 0af8489b02: kernel_BUG_at_include/linux/mm.h" [1]
> > 
> > Vlastimil, Hyeonggon, Feng and Fengwei gave us a lot of great guidances based on
> > it, and, perticularly, after enabling below config per Vlastimil's suggestion
> >   CONFIG_DEBUG_PAGEALLOC
> >   CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
> >   CONFIG_SLUB_DEBUG
> >   CONFIG_SLUB_DEBUG_ON
> > by more tests, we realized the "0af8489b02" is not the real culprit.
> > 
> > the new bisection was triggered and finally it pointed to this "7118fc2906".
> > 
> > though reporting for different issues
> > ("kernel_BUG_at_include/linux/mm.h" for 0af8489b02 vs.
> > "kernel_BUG_at_lib/list_debug.c" for this commit),
> > Feng and Fengwei helped further to confirm they are similar.
> > They will supply more technical wise analysis later.
> > 
> > please be noted the issues are not always happening
> > (~10% on this commit or 0af8489b02)
> 
> Great find! Looking at the commit, I'd bet the only part relevant to our bug
> is the "by the way we remove setting refcount to zero on tail pages which
> should already be zero":
> 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index db00ee8d79d2..eeff64843718 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -754,7 +754,6 @@ void prep_compound_page(struct page *page, unsigned int order)
> >         __SetPageHead(page);
> >         for (i = 1; i < nr_pages; i++) {
> >                 struct page *p = page + i;
> > -               set_page_count(p, 0);
> >                 p->mapping = TAIL_MAPPING;
> >                 set_compound_head(p, page);
> >         }
> 
> So either the assumption of refcount being already 0 is wrong (shouldn't be,
> AFAIK?), or this atomic operation effectively prevents some very subtle race
> (although IIRC atomic_set() has no barrier semantics defined, it could still
> affect a specific CPU?
 
Yes, "set_page_count(p, 0);" seems to be what matters here. Restoring
it make the list corruption issue not reproducable for 300+ runs.

And back in debugging 0af8489b02, the thing was similar that if we
added some code inside prep_compound_page(), the issue also can't
be reproduced.

So this 7118fc2906 seems just 'expose' the problem on i386, and is
not the root cause.

I suspect it is related with i386 compiling, based on the debug and
memory dump. I'm doing some compiler option and adding memory
barrier in prep_compound_page(), and will update when the test run
is done.

Thanks,
Feng

> I guess we could
> - try to restore that set_page_count(p, 0); on current kernel to see if it
> kills the bug
> - instead of restoring it, add (only locally for purposes of the test) a
> BUG_ON() if refcount is not zero already, and find out why if it triggers
> (unfortunately might also appear to fix the bug even if it doesn't trigger).
