Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C315D6081D1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiJUWtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUWtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:49:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFB6357F5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 15:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666392544; x=1697928544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=YSqEexusdk8avGNK7PF/wkBaDDeL44nqK/H4UP/R0Ak=;
  b=je/KTorRZ4T6v48UeZRQC1AeqtZ71KhQBS/o8k1cKWSNj7ipa6ZnmCGX
   fvpGdjkGVGnKZl25F135xxBAPD+mm0J30XByW+Z/3rroq+OgIRzw3vi7K
   cylCZqKpOMs79wVDRTYOOTOYdFqJcccXIG/VqIaFR9EBzcl7j97gNAbtG
   x03OY+9ouS/rlxFaMDcocIGow2Rwi1gdzv/nLoQTHViRK9yTeWxpKlwPu
   NWLg5ThZkyweD+MjCTL9q2MXadx8Z0oWrc9JStou4TqR2Fv+bvwbvYtdk
   Rn/7Os1BjohkregeKfrA7KOmmfw2PAzY40jSLu7eIlJ7Nhoip6xS8ba5b
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="307110562"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="307110562"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 15:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773227937"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773227937"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 15:49:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 15:49:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 15:49:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 15:49:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOI3jwsSAtGbq/ZOSkonpZXdCZ6GrP9u/XHaRpYTll9dK/leOTw9A7nQvSy7LVuf42lzfwzuDKFsYFYv+khyZzse9/Di78BOCbkbtd6kz7sUrQHxePSyoX864qas52C+rEGbAvVSnfk5Rp2LIisJOyfUmYByosO+MwMsr9KkppcemXaIgqnv3jrI0a8WLR7IsAk+vgTWdjhTJ8M/nRK+uZjYY3sVzsxHcLuJZBIRcumMS0GuZN6jIkCcOjBhvyG3ZE2vcVqTSji7hnVg9mZ6EKy5pJSrSH3nno6SOcTVsf2M2gNPyW1pNBrMykmArLn1pVi6c12N68K3PsVId5XA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF9hhxJE0zhSFqYiHBcEytz43XJTxQ/fW9KdUSsidRI=;
 b=K4Rr7KLqg9c0GyHzVvHo2ww9Hn++cBrQH+Sb7RYvZv4wfdKB+0/115IFqne0RUDtG4ZxuVwM+2PFDdHfi1i0i1D1smvnia10EX72ypN0oYB4rH9AGITerG+H7Gnef4u5tIEjg1bmXDgQUxcUdq1VXPi3+EyLJKGKiICnrBLyQcnUuTbuBKBlJpgc/AruZ1jDL1tvUoTCzxgY22zp/qxv1d6zBHJ7C2T3lvzA4NCnj037F2j6eF2eR2QCUbWe4JxZzGEyHhTIXpe/F53RSzgkx3xlPLwMlCtNCGD71J6G+yvSF38+87W1sQ518OtLlBWY2v7hr8cI15Xm3soVzDezjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6953.namprd11.prod.outlook.com (2603:10b6:510:204::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 22:49:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 22:49:01 +0000
Date:   Fri, 21 Oct 2022 15:48:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Message-ID: <Y1Mh2S7fUGQ/iKFR@iweiny-desk3>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
X-ClientProxiedBy: SJ0PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 44d33d1b-547e-44c9-7692-08dab3b6727b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt5+CRBXIMgikbdOpbjii7J63ZP2M/TYemiKlF5EaHcUWISer9jcocZGG03mRnODmn84bHA9CWv/GnWaPWbZlGCFKKV5o7YOjLow0aPqEWygcJSlQLZX0kGl4lBCttkqrgt4gshBCTt3B+xCwwmpdtiJ64z7GSGVmRdF0An5CioqL6QtmP1tX+3B4rE4HXQhN/9Pd2n8uUo9XdGvi/JEba03/iX0ADUKWImjK19Udi+xbdotfo6p5zqYD0zP3STAPTRgYXuNeuFKtEVc+7GYKcwuMXbJNNQIBsdzSS0gBet6jKvU4Hjrd4wdnTjrd82jLvnXZG/c207e7Y1w80O3bWx3aD+BOQS9J717EKPkFhT28BuaJ8+gyJPH4YfGmbpc/iqL15q7WZOE+6q/RsFFSDmyEz1QXyJHQ+HRsExgksPSv/eAg2bPvnInojav+cYt22a2lyKOA4N3andRhcUVWxig3OGPLwp9+9OX78LpyVUmX1NNMUSBsDQ/sCrID4Xs3/oEOKp19RaceO1u5ZPEYxeNHohcSLuTVf9gjt55hY2YXyw5pdyS93kgYJpurwtZvbOpAhsQ03eW9mOllUzJrM0BS6DLtKNkKSf8pe18qhelAJ1ouMom6B84rKDE1uMWgBxqe7y7lTFO1JVF0AGTmn9AKwiYjodEAVIUiFADF+cku1Ip8xy6jUxMTiR4DO7Dpr+HoZC9w8CAFEOqLchgKlMm46Geeef3lEj1dHw+whc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(366004)(39860400002)(376002)(451199015)(66476007)(5660300002)(44832011)(54906003)(6916009)(316002)(66556008)(478600001)(9686003)(8676002)(6486002)(4326008)(6512007)(26005)(41300700001)(66946007)(8936002)(966005)(6506007)(186003)(2906002)(83380400001)(33716001)(82960400001)(38100700002)(6666004)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daQDTUIYvImmOX6ziRDMgDEqwBdwbq4rMSN/wKapE7r46M5Nfko0PJ61g2v5?=
 =?us-ascii?Q?emYRvkrastovArp2opTxxnebwfbWAG6RJrdo3FRsBS25LT0U3e/rBVny5TI5?=
 =?us-ascii?Q?S0duDGo5Eeq1o5EZXeEqb44TQgEqqdLumfQQFkBGnW10goV/wmgIing0LveH?=
 =?us-ascii?Q?cdc6NYI/i7XvS77pApFN5u/+SUrfSrq/R8xY52Fm5DWy+sw/UXGg9j4kPppJ?=
 =?us-ascii?Q?aLcd8mK6grsYEo3DyRVbwBpMez5CYMbaJgs4seyaa0FVvVAr0/UNn8LNpyFL?=
 =?us-ascii?Q?SOOcsJefJlyf0lGksQaO44Su+oEoz18wthshWoA02FV35/74lMkwEyTNbXxs?=
 =?us-ascii?Q?aZwEdvJVutT9kDEADc4bmSWMBq4Ja0l0jrbkJaK0UEaf8bZTqZ9su9mxPiwd?=
 =?us-ascii?Q?578WWW6nXlKwAPdpJX9xoeVeHMSHETvsb8iRjLOhGkEcWF+S1YHbA2kV8Wzx?=
 =?us-ascii?Q?6UlhoC0nQAMdW2VBJMmZWuScq6DpP4kuYv4RwNGfujcHQkTHZiwKycmK24X6?=
 =?us-ascii?Q?g3v1adrpn+eZWCBnzIwPBPrltI3mjA1u+650RT7kJHo+RJ95d1xigivZrSqy?=
 =?us-ascii?Q?WRWBVmqh5gKgbEHK8bMQDb3mSPF9KdVvw8t77pYIuGYpWOtwK+kn+qaKt14t?=
 =?us-ascii?Q?3WJK76ESVelGFesAPBw7FfFuFG+kVuf6Z69pD8FaXw5edL5cGcVAiaHcUxbP?=
 =?us-ascii?Q?Hsg2YY40ETQCJU5JOFRXy0AkN2RGbubTjdIX6fYyuoB14c8OqIJulcijG5z/?=
 =?us-ascii?Q?fTJbL21Hbzu+eYwZd7upYu86S9vhvF7/lppFP60yAZS4LgJBtho2gLNpZfxX?=
 =?us-ascii?Q?MffQMDKs41axoWmF/oiXE0QPIP7tHjEMVqvraHPOYdosK2K4zLDnrWam/t2O?=
 =?us-ascii?Q?oMXkpii2YdmfCgOKQ0XHkr9bPVthi4pXKJBP1wucovG5a1kE1TfHwezDkcwc?=
 =?us-ascii?Q?X2sCUGcsa6I/aAyhwF+zmIe37BpAjEwhjQTtsRZvmdYGgbTdukHYZDImmUMs?=
 =?us-ascii?Q?oYWOtZd2d12UspC/oyabmi8V/ehy3WGGMnLtlW2SJctZhRjC4r3zWsF002oN?=
 =?us-ascii?Q?X+rkqrLCz1jwaf6vY52zSrwQVWK7ZzFFeuLD1m8XTGAuafwI4MGrDkKM6K2L?=
 =?us-ascii?Q?ath5+HOReEf1rxVGWWreBLBIo7eD4g/GQodAjSpuTY6YrmGOZXHF+oeAxQBR?=
 =?us-ascii?Q?fmgeVxtV0zaM8dzRMJOgAE5y4NFMiXIYNmAE4x1Apa60YhJwdG7eXcWJiueG?=
 =?us-ascii?Q?RealDI17XxRQNv+vcb3gTcyC0Bg/jaaOphA25TzeJkS8+8dr9zrym3XGRlcp?=
 =?us-ascii?Q?cpP0cKQIn3o/mdf6hTjRaJhd7kCniV94IHnwyL41Lo8egQ2pqa+6jpdV9BQL?=
 =?us-ascii?Q?OV6zL29s/KBczzm2BGxDdMBH/7DNi3w4r5nYyJ+lbc4+bVksb5GlNdoxelxL?=
 =?us-ascii?Q?ufDOlsWoxycQCG4YT/kdFz74tS6LkUMqLxJntye/Lr1BY8AWkohcxTv/DsLz?=
 =?us-ascii?Q?pHGwnvE4OPH6pFj+WDFNfByCv+hv46hFwgs6Vzx6Q4U4sMFA9nkprGYhkWhc?=
 =?us-ascii?Q?kMeT0j7PcROqA86fP8tSivJisgnNCgtpqgUrT1Yz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d33d1b-547e-44c9-7692-08dab3b6727b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 22:49:01.3721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGvUs5NGWkXFhVYa89rxJ8oW7G18r0pYqndKpkfmJMD6mo+ExLWgi442VkvXb+prvlJskvBF+I07eEQnqRmTUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6953
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 01:30:41PM -0700, Andrew Morton wrote:
> On Fri, 21 Oct 2022 14:09:16 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Fri, Oct 21, 2022 at 12:10:17PM +0800, kernel test robot wrote:
> > > FYI, we noticed WARNING:possible_recursive_locking_detected due to commit (built with gcc-11):
> > > 
> > > commit: 7a7256d5f512b6c17957df7f59cf5e281b3ddba3 ("shmem: convert shmem_mfill_atomic_pte() to use a folio")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > Ummm.  Looks to me like this now occurs because of this part of the
> > change:
> > 
> >                 if (!zeropage) {        /* COPY */
> > -                       page_kaddr = kmap_atomic(page);
> > +                       page_kaddr = kmap_local_folio(folio, 0);
> >                         ret = copy_from_user(page_kaddr,
> >                                              (const void __user *)src_addr,
> >                                              PAGE_SIZE);
> > -                       kunmap_atomic(page_kaddr);
> > +                       kunmap_local(page_kaddr);
> > 
> > Should I be using __copy_from_user_inatomic() here?

I would say not.  I'm curious why copy_from_user() was safe (at least did not
fail the checkers).  :-/

> 
> Caller __mcopy_atomic() is holding mmap_read_lock(dst_mm) and this
> copy_from_user() calls
> might_fault()->might_lock_read(current->mm->mmap_lock).
> 
> And I guess might_lock_read() gets upset because we're holding another
> mm's mmap_lock.  Which sounds OK to me, unless a concurrent
> mmap_write_lock() could jam things up.
> 
> But I cannot see why your patch would suddenly trigger this warning -
> kmap_local_folio() and kmap_atomic() are basically the same thing.

It is related to your patch but I think what you did made sense on the surface.

On the surface copy_from_user() should not require pagefaults to be disabled.
But that side affect of kmap_atomic() was being used here because it looks like
the code is designed to fallback if the fault was not allowed:[1]

mm/shmem.c
...
                        page_kaddr = kmap_local_folio(folio, 0);
                        ret = copy_from_user(page_kaddr,
                                             (const void __user *)src_addr,
                                             PAGE_SIZE);
                        kunmap_local(page_kaddr);

                        /* fallback to copy_from_user outside mmap_lock */
                      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                        if (unlikely(ret)) {
                                *pagep = &folio->page;
                                ret = -ENOENT;
                                /* don't free the page */
                                goto out_unacct_blocks;
                        }
...

So this is one of those rare places where the kmap_atomic() side effects were
being depended on...  :-(

[1] might_fault() does not actually mean the code completes the fault.

mm/memory.c
...
void __might_fault(const char *file, int line)
{
        if (pagefault_disabled())
                return;
...

> 
> I see that __mcopy_atomic() is using plain old kmap(), perhaps to work
> around this?  But that's 2015 code and I'm not sure we had such
> detailed lock checking in those days.

No kmap() can't work around this.  That works because the lock is released just
above that.

mm/userfaultfd.c
...
                        mmap_read_unlock(dst_mm);
                        BUG_ON(!page);

                        page_kaddr = kmap(page);
                        err = copy_from_user(page_kaddr,
                                             (const void __user *) src_addr,
                                             PAGE_SIZE);
                        kunmap(page);
...

So I think the correct solution is below because we want to prevent the page
fault.

Ira

diff --git a/mm/shmem.c b/mm/shmem.c
index 8280a5cb48df..6c8e99bf5983 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2424,9 +2424,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,

                if (!zeropage) {        /* COPY */
                        page_kaddr = kmap_local_folio(folio, 0);
+                       pagefault_disable()
                        ret = copy_from_user(page_kaddr,
                                             (const void __user *)src_addr,
                                             PAGE_SIZE);
+                       pagefault_enable()
                        kunmap_local(page_kaddr);

                        /* fallback to copy_from_user outside mmap_lock */

