Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E0A5FE881
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 07:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiJNF70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJNF7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 01:59:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A60F15CB19
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 22:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665727162; x=1697263162;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rbn3MrKqjTWtR6G5ppABRDVpkzE06JDc0bFpuz2Lc+g=;
  b=DLVhU/QesCkx0ApxNyh/QQQLHiwqFyJ4TVFO5HCmNe9eJv3uOCdsgLrQ
   yWx6kO3EjYsy1AlJzro488ZWMPPEiwiuRKWg9GsacChpBhtfbqUGFSwnn
   FSGOKLjTWpV703VdtA0gpmaB2pz7ap4g777idKwYQsjbpB4cVXWYXdeNF
   jgR+k6bDGf0GeK4IE3O/6gLrcTqKZnbyfiswZA4IRgkj6hG6wO4z8Jya4
   1d7VlpSVc0Tt0xMaS2jyKpgFaXEKDDrlBoU1z/3Jc6gymqlYcZ0VcY8qu
   cv+AvpkpETeA0YgqRvuhO5JxEKuA+/drRXFUwGsk5LQYb6RgVLzV/z4jX
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="306370100"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="306370100"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 22:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="658470119"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="658470119"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 13 Oct 2022 22:59:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 22:59:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 22:59:21 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 22:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nndG1+gaQReMWg3msol5CrEML5REvj+kQAzI0CwG0gf8hxl7mqxGiSWTurg1PmovwIyQVL04NkVHzTmwJMdfJ4XMvJXCQ3RMJDhEKgkFs3W3lfpLcNxuOXfvvsjO8fIZW3WWIUVRTgpXrGoZQw0wcL/p9iO2UIVK+mtJf8iBtrlutIi6LVFpeZtC+JpUJVqR3OxgSjPiU4DAfQOphbkbR8ivNXY1gVWlKvKm1XmcfY1OYUcJcCF+Cc7ZW8h0nJ3BpSTNxHfP/w6fyYna6AxSaJC8TJ+Hf3N6ktfwGAyh685y9yyPSe+4FOgFf3QxVclQou1zAjh6pz4PaWDaRTtl/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zA/9xWelJqryFKdUVCR5aCI3rZH6huCyHGC0HL6K9pA=;
 b=G8RH/t/E1HamyOf6C6zrUF5PjxyR2l+UvmqKoAhb7oIuNisitfx07BaZWn3jaBeCCbMRt1b9PSNn1kXO0/LIlbqvHBRgCtWMCKvG7qsy62P2JhP6DfsoRj2v0PN6I7ETGCqSE788x3TZ42q1Y++lJvjvg7YSNppVDUboctUt0iuj1PABAwelemBoQBuleg42Ep7P3QUzLiyjmKnk7L9WV8iYVSUy4ZYNRR8HfsI5L0X4H3AIEr7AwiuKRHtas6QL2D/CLRPZ32DtaTj+CCH+YAA77husHUDI23dd8vQid0knfo34pE4iY0QmUQTzbHgOGMpXKStmLFwU2fH8pvVjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by LV2PR11MB6072.namprd11.prod.outlook.com (2603:10b6:408:176::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.22; Fri, 14 Oct
 2022 05:59:19 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::3f8d:1406:50e2:7bcc%3]) with mapi id 15.20.5723.022; Fri, 14 Oct 2022
 05:59:19 +0000
Date:   Fri, 14 Oct 2022 13:59:03 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH v6 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
Message-ID: <Y0j6p1TSaLo18qQP@feng-clx>
References: <20220913065423.520159-1-feng.tang@intel.com>
 <20220913065423.520159-3-feng.tang@intel.com>
 <CA+fCnZfSv98uvxop7YN_L-F=WNVkb5rcwa6Nmf5yN-59p8Sr4Q@mail.gmail.com>
 <YzJi/NmT3jW1jw4C@feng-clx>
 <CA+fCnZdvqZzCU_LO178ZsPDvs-Unkh2iZ4Rq5Amb=zS31aWFpA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+fCnZdvqZzCU_LO178ZsPDvs-Unkh2iZ4Rq5Amb=zS31aWFpA@mail.gmail.com>
X-ClientProxiedBy: SG2PR06CA0252.apcprd06.prod.outlook.com
 (2603:1096:4:ac::36) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|LV2PR11MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe646c1-ce29-4ec4-5606-08daada93b84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VlZCsYnWVaxYbdtopn/rj7URkO+3LE/NYAtPgsWaIlZJtxQr5zY2o63bDN1SX2eWtlKjjbHS0Zg9d/6dlm3Ul1ymL7FvlvQuy53oDJ9CRg7W89h1BiDHYI7wSRBGwAGxKquyX/65MSypYg6kXSCoVv25XWaQ38+E55m4tdj2Nf3LjHz9FlDi2F1MULmZhm+1hK9svJD1Reg9GpA7c9wFZCiX0S+uV6p7BWsya3+t68jw/2nd0OaBWZKiLz70d7TwqOe5zW9+JrfqTQc8UBd5tcTzffhWaZw/i3qGUmrUSBOCWQbkq3yVdNRl69pfQe3KNxqjy5s0DIhoyYiu/CSJOyU2dEtlHI2EwU+QnjO+v8fO/INPPd7+QmbbJud6TIOKmmWqR+g0pv6WLnLWIqkLOocVghKitQOjWC8T852AQXVLlp7CX4RWlRZYFZgONGQczzlJ5gMSLYN9ZQOJhYQRVQoSJrTpc4s4fBW7Q5Tjc1wqYNCaoN9sfqEoywlzHgghlgt3LpdcpCn0V1kXajT99fC+vRfXlZB1M2ws4aq3V5gmKCUoDNXKJB1MvCJGXAUmTqnbrOg2Tm1f98A/gOeT+Cl6zsRK2fZ7XNPYl72JUo+EeTUWNRwtmuX4UkF0pLp7CMtHRLhSt9CAdBfiHuCg+G2iXffY+2WnCqj30c9sbEFUlFmIUxtXVY+ajiHoN8TMFj4xZDomWQpS1DK5/IU7wQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(86362001)(2906002)(7416002)(6506007)(6666004)(5660300002)(44832011)(186003)(33716001)(478600001)(6916009)(54906003)(6486002)(4326008)(8936002)(26005)(8676002)(53546011)(66556008)(66476007)(41300700001)(82960400001)(38100700002)(66946007)(316002)(9686003)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uA82IrKNArHYl+N4bhxmcCdxMvo4aZkSyisI8LJiustWboxWfkVT6n/gGdv2?=
 =?us-ascii?Q?gxEYgcwe8X1b86Zxo+VPZmQq4H9u0t7+i8SB5WdDZU8OZB7jFcY+CdJO04uS?=
 =?us-ascii?Q?ux5fZqXdNr1YFwlVAhRvuffeWZElbzz+ofoMOO5xBy05qiCGImL3T7jU5Opa?=
 =?us-ascii?Q?ZI/aNWJ+b4CUaDQY550VGw2R96QULlQ9+dXrXLT+p3gfkssrpv8Pk9Nwo7s3?=
 =?us-ascii?Q?Jf8Z3Ae1dyWlJvoozZG+YaVmimRB8HeXrDQtJCj4VRohcIVDeaHQE1v8XQBD?=
 =?us-ascii?Q?AMQ704Otc63knbdgab0qtNs/YTn7b43Xh+xAcQH5ZUA6aucROJcHoOJCEHug?=
 =?us-ascii?Q?9EMz4JXcIsMrtHDy6Ow9DBmQm8TrxnAOjtYd0qJKRIe3MS5xEA3gRpJ4sl55?=
 =?us-ascii?Q?QgXEssL+++VstbmWBqtL+FSHu2hRTnwBTYeIrjzirllsGPx8MbZXWKj93buZ?=
 =?us-ascii?Q?4vNGovjZrnQNjogmDuhIrGWP7OvcXUq++YVAoJXi+I5aE1C0gXlaUvD3cSEl?=
 =?us-ascii?Q?Pn5CadntAwN2IshuBMm5Os5N12Oq0iSmvNvzoWt+Qjw1m5d0wOZQlJSkp9U0?=
 =?us-ascii?Q?/Mw2HXy+g5PgUYZgbhuUZqxIawmMDgXaOU/UTrp+oGJbLoAEbDMGUvITAI8B?=
 =?us-ascii?Q?oqzHprEa/KcxTJAfuz5ERV9F26LU4cU1/CHhH6u2PQv7TgNydSc2mv4CQTfr?=
 =?us-ascii?Q?g9Ge5bOwAIv6RJjQDwTtrjZH2YUa+tGzL2kgvXA2lQ7I6TMRls6lnc22L+cQ?=
 =?us-ascii?Q?awFAZ2LzhvLCyLP8RmFrSLW7t+gqu2FBlQwvnbJmT5zyqcJudHUQNMNIseV2?=
 =?us-ascii?Q?6dO+74Nt2aCCJXqcHU5BUtSG4cctqtX7RNfi7vLi7hh9nhshkL0uaFSYdUM0?=
 =?us-ascii?Q?nCENOYOk/tPIfD78So6E56Cw26YLxYYcQzKfkzWF89JuGtepZdGm3redZQMA?=
 =?us-ascii?Q?UGR3bti5eYVRYpH0c4s+8OYQyLnMDmYVcEvxvGFQlV0ccZwX9v+mt6WoKl5a?=
 =?us-ascii?Q?lXDEw3tXRN0PxzvdEmLikbHEBHbLjZWHLvz5Zra/1d/2QNoAcmqSe888iR6O?=
 =?us-ascii?Q?rgXlhFPdgxnj+yPARn2Gyi2d32VWojdL/f1tkE5poC+N+cLbbVj+o6YfLTaU?=
 =?us-ascii?Q?vXHmOwgG6KOQ6cUbiAUXFCPm+OZCCRfHrUgD5d0vjJV26uNkIiTwhoaYTgRO?=
 =?us-ascii?Q?Yf90bNE9svPMuvP1e++IM5b2oPhRo5fp6Uczrzv2HN/0PBja0jgjU9tHncpW?=
 =?us-ascii?Q?XYJxoWxb35gJBsNedFY11Z9Y5sg83ExBJiIbPNUaaYT3z3WvnNvnrOkIi3ZG?=
 =?us-ascii?Q?fmOhRGbJfT8rLQcp0QXhPYc2ZJf6sGP2jce/BdPupxL7qsvWhRZmw8PHYD6J?=
 =?us-ascii?Q?ijGWO4Y9QfZs1gA2NrdU+MFznhnZGmYbelZ7Y1In0lnkN7OtF6HRK5NSAWMI?=
 =?us-ascii?Q?AjeRJ6kuLvvR6SOCeqnRSqlVQtHtyHuJulHqTise1zaD6K6h/92lzbvGmVrS?=
 =?us-ascii?Q?Ph5Drmdzo2e6ZtYEuWoBV9bZySDpBn+lS5atzqh16HTqtA//rL5DVis9+XUJ?=
 =?us-ascii?Q?C5+84BTn7LUEV8I/18bSZULo9P+Fsw9u1xUncdnQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe646c1-ce29-4ec4-5606-08daada93b84
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 05:59:19.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZrpLUh4rQsByi6UH60w6o4kgnCH0ZD7uYuLFwAuctFaNZXTUe/PjU8PaSwmyEVl6fcowsmuc+Jf/cRTQMuYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6072
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

On Thu, Oct 13, 2022 at 10:00:57PM +0800, Andrey Konovalov wrote:
> On Tue, Sep 27, 2022 at 4:42 AM Feng Tang <feng.tang@intel.com> wrote:
> >
> > > > @@ -746,7 +747,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s,
> > > >         for (i = 0; i < size; i++) {
> > > >                 p[i] = kasan_slab_alloc(s, p[i], flags, init);
> > > >                 if (p[i] && init && !kasan_has_integrated_init())
> > > > -                       memset(p[i], 0, s->object_size);
> > > > +                       memset(p[i], 0, orig_size);
> > >
> > > Note that when KASAN is enabled and has integrated init, it will
> > > initialize the whole object, which leads to an inconsistency with this
> > > change.
> >
> > Do you mean for kzalloc() only? or there is some kasan check newly added?
> 
> Hi Feng,
> 
> I mean that when init is true and kasan_has_integrated_init() is true
> (with HW_TAGS mode), kasan_slab_alloc() initializes the whole object.
> Which is inconsistent with the memset() of only orig_size when
> !kasan_has_integrated_init(). But I think this is fine assuming SLAB
> poisoning happens later. But please add a comment.
 
I see now. Will add some comment. thanks!

- Feng

> Thanks!
