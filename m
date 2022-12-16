Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357164E54D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 01:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiLPAlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 19:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPAlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 19:41:16 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076C732BAB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 16:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671151275; x=1702687275;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B5Mlyz5So1GfJF8uLPbAiBNGDBp04BMlx/wS1U8zEgo=;
  b=Dz25bh1LO+oELcHPnvkhjUdo/mUnPhBa2N5lh8MwPeJfdbcQNlrD2qo/
   6BQaSYe37DeIrdUHvLYXGQzD1OQgMlArkquGOwl4rIVBNtUvaSDJycUyt
   DHWHh3P9KM7afPeNaeQT+FS2oNNacRq6XNyEBC5guoWTxXSlMwvsFnRe0
   Qc+lTjcB6ZMLELDx3b5cXsFwHua3hHcNt9D6JaXeHbLWQOd3ZHgZiDOJW
   BUbYVQv2rrFh8a57E3sNiC38v4Y0J3b3c0+4wkwBSLayQb4A/pAZV/Brg
   LbDeCI75IX2o3ACkq+CEDEXO94G7idJG0tliXDV7MKuEaAFhuW+Neh671
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320016947"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320016947"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 16:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="791864840"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="791864840"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2022 16:41:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 16:41:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 16:41:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 16:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjkdZJUtZdMESIp+pRserpA1g3gCB3Ryc4xpNq+1M1A+gb5dmt/QRuUQRcPSqJT0zqC+GL/QdZAPugT8Lhkzsyrk8k8dMGdqry57sOYk8R5Re6VpPaZ6VLPSRES4INEFH97578c/Eh2v0zAn1CLnasrtf7e2LkPyZz6aGgTexc35KbvviV5ipJ07nXumwd+72hQ6HJcV90vWqkDGV1Aj6AMDytSDwR5AxoOSw2LYT8oA1nx914xTLyq/3+WdENgKODlCgVK6R6EN8BML5du/t3aZEMQyDStiTpH4/bErF0+vkBFwo9iJv8IJXuz7W6D+CYwLzaEBK+tRw1rDPuSImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q46stn9Ou+F8WuCEGmxSO2mFEqMOjK+YJvqxhHYiGrg=;
 b=B7xXJctl0NK7kh09UGRrAFFD40WspDOaqihiz2I1P/HNV4k+ZYaJan9VsPxZXKDWYl8QdjCodJNPMJc4KqLPlzqCXOdCv/5UvQl+Hwg1hPITIkjkEzgLGlRIpZxeqIUvasngBrRT4GZzTuuK/3qKP74MkPntydkuJ7D43DDMCtWAWd6kOnrynKGkwT0nbwRzLoH/q5LLymurJb4Q1BCR+6k+FMUkBuHbZbUukiAWMMyu7RYupOsxVcxaMtnPcwUJ3Kllq2fD2VoZvWDjt73LvxlD8nqQVJhw+UivZumA+dwIco6mfFW6JdaJ+nL/dWdXt+fy6RHpYqBhLvJglDhWRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6289.namprd11.prod.outlook.com (2603:10b6:208:3e7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 00:41:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 00:41:08 +0000
Date:   Thu, 15 Dec 2022 16:41:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Phil Chang =?utf-8?B?KOW8teS4luWLsyk=?= 
        <Phil.Chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Message-ID: <Y5u+oOLkJs6jehik@iweiny-desk3>
References: <20221002002326.946620-1-ira.weiny@intel.com>
 <20221002002326.946620-3-ira.weiny@intel.com>
 <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com>
 <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com>
 <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com>
 <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com>
 <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0130.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0984cd93-b207-4d7d-6fdd-08dadefe38bd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uX2STpAZrDkYVAzv/PScOxzOksm8tlqBavxW5iSlOZqH0Wdw39YcBXC1aRRxtdtzT/FruH91cBaMy0o7cw8zvvvh+KIGRaUYdxlSXgRAXjuYptVKHF1DOLcdDc0V3d1XQ9/chhCOqKx/ryh3iV1DDL9ZOkpcRtIkp/Qa3misM9k3OCVgm6k/C7Rdo55S5lwqmNTBSUjbxYFKXtzqXGtpTecF8xESv8h+T9oz4DEptmS2tbmNP19/RPNrcgfVJ4g1dGyW+bGynKqhyLb82hLnS0hemEV0jb338Ip9ZBvoNjtZsv2YGTZN+son5oDNo30q+Eo1kqvV7mN+gUbPX5K4X+k70j6MdoDEZ4JH9TjOiaGXibXyv43gG/xCUrvCED+z9NmDPKcbRRLoaLFyv65CIqNjrJMHTQPnD9Onb4wo6Ob24d8dv88NfS2Lj7oL3xs1RcnmI/Uaw9vUbxLj/gp8+Gkq8pG3pAFxgSh71S0P60Ntj3fR5H+4vIBHgDy5fCC1Zgn3RPK7Q+yDFYQhnVrKvyywU8qigXhsxcQ020LgDBxRvAts51uI+9iAxAWYGwIv2oDfP7usHUTWesO8+jN/kPVHxm20PdjNmEM1D0PGOgDiWvfF6I1UH+OH5w/d14NWMUyJSkcRx+R1ekA0kJM5fsyaIiKOrh2XO/HlOh/ato4r5jgsLplW2mPCvPdIfFTC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(7416002)(83380400001)(186003)(5660300002)(33716001)(6486002)(66946007)(8676002)(66556008)(38100700002)(8936002)(66476007)(478600001)(53546011)(9686003)(26005)(82960400001)(6916009)(6512007)(44832011)(6506007)(41300700001)(4326008)(54906003)(2906002)(316002)(6666004)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6NlZjiFlP+jOc/F5D6h+n4w1REZzMJSPv40LLs5KQXy/vxe4i6bs24WTZQcg?=
 =?us-ascii?Q?sdKijmhZn/tEKz9Jhx2nluhJnuOT1FXZtCrSBHp7nu1O0S9hM+AxkE4jR4QI?=
 =?us-ascii?Q?e0DqcPEgr3nQJKr+OWOP2bn0QrhSotmkTdvJAtkKPXwQfiHdnRQU75JjLlK5?=
 =?us-ascii?Q?IoDl0CJdhUSte1R1hpmJfqppQqf6AdML8x4DTU2ckViBx80+19FPf5M3O48W?=
 =?us-ascii?Q?oD4SNXwSttavVkm20nC1XPDanj7tFhetlUyFl9C4Q+fXeoNZHNFvI/kEpm7D?=
 =?us-ascii?Q?SCceQEzRll8cgONaxq/iXIW63gYYJkRdkzSDd/GgygrZ7WKuVJnCVgWhYcc6?=
 =?us-ascii?Q?CREPfFlunH9dg/bMNjwroyvXIq5nOMGiPUpUj6Mbavt774lF3sW3B4EkeCS+?=
 =?us-ascii?Q?UXa83sbCFZxDhl8qNGxFQEW9EBLML0xESGVJfU3SrbzwDmr81ze8/Gc6/sMG?=
 =?us-ascii?Q?xnz3fbAdmrKJ7LuaFG0KPSRRO3immtTmh6kMdpiaX3pkHKvkq28xhZ19yeHw?=
 =?us-ascii?Q?h6E+NFibvRl8TBlvA9mbIakriMAZ7G9jV2Kq1LOhme9oq2algEpdgOdBZtT0?=
 =?us-ascii?Q?RwtxMbGcFgwn5A23wdlYjXkgodCgQl457gqNnS+0SvZI4N6fFE6WEAsRxIRS?=
 =?us-ascii?Q?o3QaUekt7oDU8Ylz4bonItyKo4mYzG6n8EfqFF84aTx/EtvUeL2cSkvRhsUM?=
 =?us-ascii?Q?j7Cr1JidtjwhaswiYWNMBeacUzhac4sNfJULekxAAAqG1+Af1k5ZB7t/xko8?=
 =?us-ascii?Q?9Engr0QSM65NN/tiHe2Qs06Y0acAYg22U64G6OFPHcXE1o4lUY9RSwbumvPK?=
 =?us-ascii?Q?eaMEOBYTdaFumUGMGEqzVJW0OCGTkKbkBvQOYNyREO9UGcyHvLaYii48yjPV?=
 =?us-ascii?Q?KFRrcw0bjuvr1d/G3i1u6roTBREki7ZdtlrMoDhIecmChoWCddePEonpwL7I?=
 =?us-ascii?Q?6uISdKZ/8yBifCZ5CwbuLy0LLRrjISrY5lX8gs3mSptxnoStTXBKEH8LwfO+?=
 =?us-ascii?Q?ZUyR+cVppW6dxCKKCvm5zLPzroTyBca6gaFr2sFegs5nuwYK9mbW0yeI+uRA?=
 =?us-ascii?Q?ArXps2xH+PSStUKuv/oRRIPh38jqGTs857paF3NT3XJFOW04kwhvOWGGNr5Q?=
 =?us-ascii?Q?fnkWRubtdJHYxbM0b1JTKeXzg1m3PMt0UTTel4zTl7nl6CidS6VwSjrW3BIB?=
 =?us-ascii?Q?eVSCF7C0wujWuXou5vFeFX1kWQeSsn0fTxLZTkYs/zqZ6dQYtoNI2S8d7hST?=
 =?us-ascii?Q?fJpNiJ2VllrBoQevp+j1XhQhoZZJAAk5Li1SLSmeY7GybYRHtlrte3R1s8gb?=
 =?us-ascii?Q?IBxWLqxNB2k27wJR5JaS7HsP/sbw4eLzbSq2qNU4SCQETvB3MUjbvgHvDTWw?=
 =?us-ascii?Q?745ktT/qt0L12BqJD9NWXAFimhDXVs9bzUoRQuIADCfO7BFLCYi9DqdONXVE?=
 =?us-ascii?Q?r/0oME4R0uj4RJL4NaYZ4LD6e9dI9IpP0TNXaPUtoqZQ6++t8Mbn18d96w+h?=
 =?us-ascii?Q?jrbvC1WUr0/HWvZPYKgWnfYxT/k1ZWWo4E9YnMIBimebt7AjNlu22qv+NQwE?=
 =?us-ascii?Q?jFvqLbrYsKvjbjoBCaTy0Y159SiAC3YwpCX/iSZL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0984cd93-b207-4d7d-6fdd-08dadefe38bd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 00:41:08.2750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNJCxxGYx7uPXVRrzEUWA8iPAG96ZPvvyMryJxvUgI0JKx+nP/0F0qdPhjh4f+rPb4nR8LTtJ+ACkxLyYrY3Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6289
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:12:57AM +0200, Jens Wiklander wrote:
> On Thu, Oct 6, 2022 at 8:20 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, Oct 5, 2022 at 11:24 PM Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Sorry but you need to get your driver mainline in order to support
> > > vmalloc interface.
> >
> > Actually, I think even then we shouldn't support vmalloc - and
> > register_shm_helper() just needs to be changed to pass in an array of
> > actual page pointers instead.
> 
> register_shm_helper() is an internal function, I suppose it's what's
> passed to tee_shm_register_user_buf() and especially
> tee_shm_register_kernel_buf() in this case.
> 
> So the gain is that in the kernel it becomes the caller's
> responsibility to provide the array of page pointers and the TEE
> subsystem doesn't need to care about what kind of kernel memory it is
> any longer. Yes, that should avoid eventual complexities with
> vmalloc() etc.

I finally spent some time digging into this again.

Overall I'm not opposed to trying to clean up the code more but I feel like the
removal of TEE_SHM_USER_MAPPED is too complex for the main goal; to remove a
caller of kmap_to_page().

Not only is that flag used in release_registered_pages() but it is also used in
tee_shm_fop_mmap().  I'm not following exactly why.  I think this is to allow
mmap of the tee_shm's allocated by kernel users?  Which I _think_ is
orthogonal to the callers of tee_shm_register_kernel_buf()?

> 
> >
> > At that point TEE_SHM_USER_MAPPED should also go away, because then
> > it's the caller that should just do either the user space page
> > pinning, or pass in the kernel page pointer.
> >
> > JensW, is there some reason that wouldn't work?
> 
> We still need to know if it's kernel or user pages in
> release_registered_pages().

Yes.

As I dug into this it seemed ok to define a tee_shm_kernel_free().  Pull out
the allocation of the page array from register_shm_helper() such that it could
be handled by tee_shm_register_kernel_buf() and this new tee_shm_kernel_free().

This seems reasonable because the only callers of tee_shm_register_kernel_buf()
are in trusted_tee.c and they all call tee_shm_free() on the registered memory
prior to returning.

Other callers[*] of tee_shm_free() obtained tee_shm from
tee_shm_alloc_kernel_buf() which AFAICT avoids all this nonsense.

[*] such as .../drivers/firmware/broadcom/tee_bnxt_fw.c.

> 
> The struct tee_shm:s acquired with syscalls from user space are
> reference counted. As are the kernel tee_shm:s, but I believe we could
> separate them to avoid reference counting tee_shm:s used by kernel
> clients if needed. I'll need to look closer at this if we're going to
> use that approach.
> 
> Without reference counting the caller of tee_shm_free() can be certain
> that the secure world is done with the memory so we could delegate the
> kernel pages part of release_registered_pages() to the caller instead.
> 

I'm not sure I follow you here.  Would this be along the lines of creating a
tee_shm_free_kernel() to be used in trusted_tee.c for those specific kernel
data?

Overall I feel like submitting this series again with Christoph and Al's
comments addressed is the best way forward to get rid of kmap_to_page().  I
would really like to get moving on that to avoid any further issues with the
kmap conversions.

But if folks feel strongly enough about removing that flag I can certainly try
to do so.

Ira

> Cheers,
> Jens
> 
> >
> >                  Linus
