Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42A6082C3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 02:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJVAKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 20:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJVAKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 20:10:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7704E43B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 17:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666397389; x=1697933389;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e4k6E9trSrF4ZRNb2TjYRRQeuEcidn6kiOxZAer3tn4=;
  b=ca8EsFCtJ1SifvrvNdERqWj74Rf34sG1WCaWjezhsjZLphVlw271ZNqt
   O9MrfWAV21kN88TzG+mFrHr0zCvYakFbLajj/3IGkXG6NQnP50d/auKM+
   JwuGShvluxzH8WHaS9KjqawE2LaGE5lsc53ifZfD+uHmyUWZgPtH9mdE6
   CUenG0ayfrJX5nSk/Doe/xWjqd1QLo8vk0M2R934FIUUVdoiJmTFSGbVL
   TwpEG5PhO7vR/m6Cri2NswQMhyzUVC0DRstTnpXXuFIfPh5dJU6Q98FEw
   Z9jZeaUhcbw0fnyrpLrJODPQWZxBdMv1SB4fADVMLZ0f8o3IoPdX634LN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="369198644"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="369198644"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="699547888"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="699547888"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2022 17:08:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 17:08:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 17:08:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 17:08:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYnS0oyLnzf+aQqtwoC+swGDJsITP+ld40nSCkk4cBqq4MBvF1103DhFRwJXGLofKEId0Qbhy3lnjxjT+1/tKTyZ9fi85oZR3V/+4t84GAJbGYIrDNsSZTq8hO3h7kDVvq1YFLaTxI1SLKEHva4VcQFVV8fcnteF0C6It88Xr+BwQJx6VOYFASozsH1okEVTe86RAJOt/AucmGWOeJTeKap62ykvxxqDjwVp/JUV3hvm6rCNVBqZDAnYHfLOnsrG6ue/SwuKOQBAakZxWoBaF/W7Y/1Er2hHZqsVWVQHI6WW0l6PNIkAukE3AaWDMFu35t8XgN6rI7cCY/VIs6N7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uhlKzqrxDI215tlSM7sZsZVwetJYQor1O2knCiGvzg=;
 b=Ygw/9KrffxuJfPRYOymdg36PeSusF1uPxDxIxS9wYZKBCMfCoQII2mybooQaHuNapoAEMGdlfEkQ/HySANZHUeOP3k7+yaWyE2U6MsR/pFvrq/cBd3NvNsjPgvVx8z5FADAGIW/32FKCjUem8mWEoQkoJ/P5waFO4K9Yxo0NBnL2f2kxxMye5nZKaCLGWyy9XocJfCK8l0Ga0DfXA6PZoD7eA/k47exiXhoWPVxqpjZEGJVen1oiJmvoAS0LV3U03cAoTMUd9Gr5gDS0NusXHYT+CvnQ14904NBETrKKt98xCJ3fryyEFqANMMwWdO/4zhw9kc53Xp6YrhcDcCFfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BN9PR11MB5290.namprd11.prod.outlook.com (2603:10b6:408:137::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Sat, 22 Oct
 2022 00:08:34 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.033; Sat, 22 Oct 2022
 00:08:34 +0000
Date:   Fri, 21 Oct 2022 17:08:30 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        kernel test robot <yujie.liu@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [shmem] 7a7256d5f5: WARNING:possible_recursive_locking_detected
Message-ID: <Y1M0fgbedbjP6h7e@iweiny-desk3>
References: <202210211215.9dc6efb5-yujie.liu@intel.com>
 <Y1KZ/NF5bNG1wykf@casper.infradead.org>
 <20221021133041.5811e1fb291eb6aaf122a59c@linux-foundation.org>
 <Y1Mh2S7fUGQ/iKFR@iweiny-desk3>
 <Y1MymJ/INb45AdaY@iweiny-desk3>
 <a0e2af81-39de-8c25-e7bd-f2234a0d7f8b@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a0e2af81-39de-8c25-e7bd-f2234a0d7f8b@infradead.org>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BN9PR11MB5290:EE_
X-MS-Office365-Filtering-Correlation-Id: e74f65f1-75d9-4456-fc1b-08dab3c18f5d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sMgxtAWtU8UWWqbb1x2oECUWz1eqUADD6St5f5mR+KRMedOP/cf2tKa21/bRSGkGWioUU4eIQ9milG4C6x9MwmzjQAKWIqMb75tqqYuVgou2GgQZ2DDhsDNq4yW3bSlflv9p5tCSQmwIJN3KxL/i1hApF29GqRc9lnJGHxDqSNLRfmEatLzt+J3BFTbiLipqjwe8yEDEg0WZwVZkB28jo32WyP9HUhVloo3YyMIfZskkB3VSYLcWODelXmCtkd4buA57qJPOPGOh5KcgLKGcahTaBCd4JfttaKqROGaGrg24rRkzzUUFpHFtBa8RSQIawYstbmKIUnSYxvauRdZy2aF51igNhJYD+gc4683wAne+x6j1t8vCE704BiMpJ1peDEA+t3yr40xBE2JKBag1fIaHViggGdn0XnL4RxksiyHToqBMvmd+dYt2QJXn38co7rIJEMugunCCe1MoLVWGcUds27bKSBThl2IKiFoEH2cPKyU5Lz28LG/yzqvDAbANzHg/MlQHcpyg/W9J1o5iT5Zu4v+yQ/OO/HAeJjV7ks6xUWpA3KpIdYmU/+h1D/xRbQDkhQWHj3+tWB6i9pHQ/joVqpANV4z5sNUrmzpBHS5wLnlL9gx72M/9VRuL6MCjOtFrcQnENgu+ZtEV08heVxN6YblyC648Ye7NE9NTEz1XGU5dmXMT5r6tPrtX9cRJD7BgUv5GletWuv7gciA3rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199015)(8676002)(33716001)(53546011)(66946007)(66556008)(4326008)(6506007)(66476007)(316002)(6916009)(6512007)(26005)(186003)(9686003)(86362001)(38100700002)(8936002)(2906002)(41300700001)(82960400001)(6666004)(44832011)(54906003)(83380400001)(5660300002)(6486002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uTriFAtQKu9Z5np6G8ZyClqlf7X4GXAUVyClCmzvgSmGIP1ShO8nni44IWHb?=
 =?us-ascii?Q?z6+N3i+vJq3ccUaC4vGiSGCYDCZw15cYToXA3zTXbCZ4VOS1USS9nXzhK3Uu?=
 =?us-ascii?Q?VUgPsS2AoiA7N/OeOgrEwRRIV5JripOypRg1mng0Q/E9qyEVMVhFEh41gloU?=
 =?us-ascii?Q?az4xu2sez/HhrOfYZ+PXH77HDM7Y+3YFU6friFUR1AfOYTQijI+92+6L3Mm7?=
 =?us-ascii?Q?n7WKQE6mNtRVlnY74m3Y4QUK8pdqULielUWSg3rmdhIHmeqHYspL4XXRPdda?=
 =?us-ascii?Q?ijw9MOV9fKnGXxMfWugN2QYDSZIqxTat6isq+RpNqCx3UyAOxZKJGSnGdUy8?=
 =?us-ascii?Q?hj/36UVltQ5+UvtMlmVY2Tn5/S/2PRDlDrNX8VTZN16/DYfBAI8+toLdQbWZ?=
 =?us-ascii?Q?IcHn6SS0uDVwrrcH+JjAQxE+xkH6/7V1rQtj7n4MWwzuMbhEn2nHpLyezi4P?=
 =?us-ascii?Q?nYAuCmWMy0LjvWNAV5oypNoOfOAsz8VyNsChhfFrC5vAr2uuPi3NtzQiN1z8?=
 =?us-ascii?Q?9s/22QlLsckJB3LKcW12E28yjs5Egtf1zVe2nqNAUJFA83HRmTuC+rXJ9/01?=
 =?us-ascii?Q?xs2sMxO6GaSChu4hWILUScCutUK03wdJwlUZvwJA8jxTuUdF6R5Mvji16n+F?=
 =?us-ascii?Q?yJFBRUSWOdbyEajjw0dCbvSU2BOm42HuuQ8VuQXF5THtgQdEW+ZYTWNwTjEv?=
 =?us-ascii?Q?jFibfA3z1KJpqx7N79vRC8kQ8bzUBZit/64ZpmOe0hlC2dX1YEj20byM1rSD?=
 =?us-ascii?Q?qn9Z3T6wkGkgpsb8JfCqRkul/csTvgoXoa7cKyOkg3xzEHGQ0uGoIYHgiCYX?=
 =?us-ascii?Q?9rGZj9pCezNPpjNkxZN5j3xlltHPHUPSPkgprEmKuzEyq1B6eJ812Lz1/0wh?=
 =?us-ascii?Q?C2uZJmuisDF6L3uwu1kPXsoK0PcE1lU+JQK4vxVngjwlgmLCmA2b+R+OD2eB?=
 =?us-ascii?Q?fEpX9t1e6XJodFjYtVYxfAb2Rc8Ue439pRPb3kCwRtgp7OjGZf+E2CLcwo9S?=
 =?us-ascii?Q?Uo3WCFNxR7NqXh+RU4oDnJCX4xZc7i0w51/r2E79r9IiKepDXmnZWZfUaUCu?=
 =?us-ascii?Q?4c6yXt2IeRSgy4dftyfA4G7srdIXAoTfBwk6XXqWG+Szl1MouMZMLTnO2Cpj?=
 =?us-ascii?Q?ruK2OVW4h28GckTCcsqAiq89RQ0u6cKIOe/cqabluhkaucDCZfP1QnO/JFic?=
 =?us-ascii?Q?GExhDQfJvT3s1KjKi4rG3Oc2cPCpKrddpaWunBfpJCp/+1Bn9l78ppyXQMun?=
 =?us-ascii?Q?kfn007lzwqDYDat+wzuue8OghNEqHRirKaJ+DOrCa/kKQJQq8goQDkbnzrpj?=
 =?us-ascii?Q?Oi58dzz4qvFWs5WJic1nRxKMoz8HuYHGZPLVGLdZUTAuIcpwu7R5C+pixCq6?=
 =?us-ascii?Q?cdYpHGfwrOoogPaqxRpHFM73pT24WoTCg0k5W0WoSXS3cCD4fzhl6ulNPOkG?=
 =?us-ascii?Q?r52yfLFvOgPKxpFmkNu+EGwz4YhIqqWzyvHyUD+rRQRZERwWprSoCER0Csgh?=
 =?us-ascii?Q?gRYlo+UaJLibVADudpRSaR+R52k4FqijxQL7MfWFEwHyMw31PBV5g0bCmJbl?=
 =?us-ascii?Q?5wkmPCBHxOFVkCxbKzVPzyhcJAS3eK070n3lUYiG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e74f65f1-75d9-4456-fc1b-08dab3c18f5d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2022 00:08:34.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ET9KXgFeyPVNcWfDy7ZIzBhs6VI7OWnSfK7sc3s65I38OMt0WBRWRRi+UcLiZetgt8pQ4yZziQzulZLUmuFfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5290
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:02:57PM -0700, Randy Dunlap wrote:
> 
> 
> On 10/21/22 17:00, Ira Weiny wrote:
> 
> > 
> > I was about to get this patch ready to send when I found this:
> > 
> > commit b6ebaedb4cb1a18220ae626c3a9e184ee39dd248
> > Author: Andrea Arcangeli <aarcange@redhat.com>
> > Date:   Fri Sep 4 15:47:08 2015 -0700
> > 
> >     userfaultfd: avoid mmap_sem read recursion in mcopy_atomic
> > 
> >     If the rwsem starves writers it wasn't strictly a bug but lockdep
> >     doesn't like it and this avoids depending on lowlevel implementation  
> >     details of the lock.
> >     
> >     [akpm@linux-foundation.org: delete weird BUILD_BUG_ON()]
> >     Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> >     Acked-by: Pavel Emelyanov <xemul@parallels.com>
> > ...
> > 
> > So I wonder if the true fix is something to lockdep?
> > 
> > Regardless I'll send the below patch because it will restore things to a
> > working order.
> 
> 
> with ; added to each + line.

Indeed!  I will actually compile it prior to sending an actual patch.  I guess
I should have done that below.  :-/  Sorry.

Thanks!
Ira

> 
> > But I'm CC'ing Andrea for comments.
> > 
> > Ira
> > 
> >>
> >> Ira
> >>
> >> diff --git a/mm/shmem.c b/mm/shmem.c
> >> index 8280a5cb48df..6c8e99bf5983 100644
> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -2424,9 +2424,11 @@ int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
> >>
> >>                 if (!zeropage) {        /* COPY */
> >>                         page_kaddr = kmap_local_folio(folio, 0);
> >> +                       pagefault_disable()
> >>                         ret = copy_from_user(page_kaddr,
> >>                                              (const void __user *)src_addr,
> >>                                              PAGE_SIZE);
> >> +                       pagefault_enable()
> >>                         kunmap_local(page_kaddr);
> >>
> >>                         /* fallback to copy_from_user outside mmap_lock */
> >>
> >>
> 
> -- 
> ~Randy
> 
