Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD15063358B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 07:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiKVG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 01:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiKVG5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 01:57:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0F3218AF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 22:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669100225; x=1700636225;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1piYrZMFBDY5RRGYioMvsqZIyAeZKTsGK2+wMqdQe7I=;
  b=Vjos5IwFwiA/yq88Y2owahdoEt7mTtX6DXtlx5OBPRW219830k/sTjqR
   pz23CJvvaLM2HX4QIxvDvQlfBiqs7i+ExDs5CgL3PVS9Lza9oWmzlhwd2
   nc/7yc8/VO6JYSYlXBC8r4cvsmm9m8ZVWQ00uYMTN6Mnw57ZuCa8iYSKf
   XZGlJuoechtLEmKqPMPzInNdo1bUo2UOeY6lDFFwxzdpx2H23RmnxmKhc
   2EbS9hr7egQVOuMh6amiv2ljPDflGc3PdrvkiNN/FxSHmdQJ800/VWT6d
   vNa3VLCWJtvLwTXlVXgGT2h+zspYLtp2qnRdESrzg4PKCq23Ydnbd0WCm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="312451250"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="312451250"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2022 22:56:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10538"; a="643613392"
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="643613392"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 21 Nov 2022 22:56:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 22:56:48 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 21 Nov 2022 22:56:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 21 Nov 2022 22:56:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl6ejJR5OR7LTWxojtJMkcHiT2pCoNf6/+uyghX1SceUKT2hXXB9Vir8ZnQyHu6JCaYTdfD7cOr0124xU/MmOsFvlao2s5Ogc5WN+BusRfB7AZt47ySa6779vsUrUtMPNrW7YZ073e9gCrcfuImweFUTV+4kAWK12wGzajMf0fbXhQzZxnXijeDqFSYINMNwArrziWURcLk46qAGfwc0ILbrJDV2p0bvbsV61Oxmo38SYnCcuqcj/G1AUs4v3fldFNdH7T6HKY3EASzJOTvdztqrDkpgrTdmN8IJpDFeq+6LmOmUjwtvNhnBvFbzfpDAMNmh/mLbkvR5ocHXAZ8G+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOXNC7G9VxZQldbrtF3kM0EQqYy7yoUUv7QfojSeMYk=;
 b=ch8nM59tX9FthG4wYWI+1NAS6euRPexi7VgVfo6+loVBp/ib7Wv+ur2Y7VqtuUHZ54BSiIuJCzLl6mo5kIa4lzxJpnpKUSCokDiuXfUrV/ML5/YVJbsPzw+dk+LLq/pXm7HvgNkoLhc4rmbm4gjiKpWZQfK3jyc1tZNbKEcZ/YVvKlHLC9yfDFxzcckUgvJfjbYOfFD8tC1HpXekXsyOogkrt18mqArnVeUk2JxhPvmmFDvg5EKGF2Ry90Lg8tOFZRArvDBNO4Ji7zDOekPtz/HZItpyFyZUnabVkoShWzGTeHeX99wbvOKTfYu0cnUdX1I7+dDH6i/oDLpW6zniPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by IA1PR11MB7366.namprd11.prod.outlook.com (2603:10b6:208:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 06:56:46 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::1564:b428:df98:96eb%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 06:56:46 +0000
Date:   Tue, 22 Nov 2022 14:53:32 +0800
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
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        <linux-mm@kvack.org>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 2/2] mm/kasan: simplify is_kmalloc check
Message-ID: <Y3xx7JUaRfRXRriw@feng-clx>
References: <20221121135024.1655240-1-feng.tang@intel.com>
 <20221121135024.1655240-2-feng.tang@intel.com>
 <CA+fCnZenKqb9_a2e5b25-DQ3uAKPgm=+tTDOP+D9c6wbDSjMNA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+fCnZenKqb9_a2e5b25-DQ3uAKPgm=+tTDOP+D9c6wbDSjMNA@mail.gmail.com>
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|IA1PR11MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 531281ac-428b-4016-f828-08dacc56b8a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9NDnonjgd1eSXn6Mce/2AeFr/RI0bHmCDzBcwDmkWKifz/UP7dCY6rDtIj8ImJMiq+SEhXwcQwOEFBNZbdu7g5KYBwBk05Q+1OkmSKEMXcKRyq70ckUwoiEEUTspCujJUxxPxvHAZkukME6ki/Kp0ZAvOqR4KEjLM+y/N1fOzWuEtg6SmRROuFPjtikSVueRDjybh7WM2+KszNkUX+YdNIg6NqGIsNKZA+WQcKnhlsaVw6VpTzX99tXZ6PuJo019fDzUHECjwZ8mEoKouHTE44D/vn8f0Gh0JzSf3mryx8AkiHKMJeZBWQccRg+WZJmq0HW2qmEOpMKp0vMVZhnIv9wSIdZKc8ixuiWQW2eVkNQHqkbgbQEFZH8QVW3lngLIVGki3RXRtkvx/qEj99OEM8R9KknCoEij0TIjwJIOvPG4q5NL0/dat+GQuy98yRbbtwg759/XUJSa55BfjjF2vocoUdhEyBqEc5PVB8vx7rO6w++ZrA5tbeNtvO7UuJW5iuV+l79US5GMkgDN9xBG+JuryEFVtIbAGlz/GHE5RIAeBMBhzqxBoan8daib1LeVq/pN0RbhtyC+EYlk/EikEIYyViP9yc47a41D0FypyXjNT7dwWKITwin+lAdKXtS46f9u49QNEYcGObDtsqeEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(39860400002)(346002)(366004)(136003)(451199015)(82960400001)(54906003)(33716001)(41300700001)(2906002)(38100700002)(478600001)(6486002)(66946007)(4326008)(66556008)(66476007)(86362001)(8936002)(8676002)(7416002)(5660300002)(44832011)(316002)(6916009)(186003)(53546011)(83380400001)(26005)(9686003)(6512007)(6506007)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIxeKnFY2gxgO+p0c9raeW++/0CpT/W3JZRelGlJIO8BdiCIFRwic5bBlqLv?=
 =?us-ascii?Q?DcLR384e/bvaWNhh8IHx2wNY4Dao4dtGGQ1yB0ia15vZKeKTGku+Cbwf/uzq?=
 =?us-ascii?Q?s2gTSmKan1HIy4S8o+nEkmXTp69uKSgIa55Kb1tuim9jc/ZuPDG6Zuex4bW6?=
 =?us-ascii?Q?+J5Lm5F8Vip/nbmoFkDu0izm6gwa2NvV66y/akLbLpHW3jarafVmzyCrG0a8?=
 =?us-ascii?Q?Hi90QaaVSM+tQhWBD3vOCteyihvEtEPyWSWRU10cn7sIzZKLFDLx9elycE5a?=
 =?us-ascii?Q?Ry7xSd2l5VrUdRBMjxm+KlJVen0Bck+zdJ72CunewcwDfuYpS6SwBRk9zpwx?=
 =?us-ascii?Q?jYZ2Dk1Thei8TaGK8TDab6ur0mlLasBCKSLHaOByDHi1Z2VkWxFsPBymTxKT?=
 =?us-ascii?Q?mlAmeEx2WnwvRFNOdig34IIq/GN9H1WVJyazVg2snn2PQ6ZKmsgv4asEB/fH?=
 =?us-ascii?Q?362FxKWYBpkkgnz3K7cg/AjKbccoRk5trUVszhvxE/tOw9+8i9jB8NaZq/Kj?=
 =?us-ascii?Q?qouORsCXVktwTG3EMkYVsOgYPSxhhoeBHC/yY1ZaMGnrafS2KqreawvIfMy1?=
 =?us-ascii?Q?Jcw6z59BNcGquLGXh7Pc8nqWhLbt8HiHI41sLJpNbrDqQHqiwxQU7Wy0AoE2?=
 =?us-ascii?Q?xcO7C3YQWL6+kN1ZeamC6GpC+XQlWoR8jwStQMRXflHeM+k6EkcS1z8E9vCH?=
 =?us-ascii?Q?VyFADB0eJwCfI4mWMmu/UILzMSqWIOcp71M8BWfft+2MjKwVlAaQ6aiHpZW+?=
 =?us-ascii?Q?Tj72Hglhr0kSQe7hUl1Wx32smAFvxRsVQNHgrAc9oRKD8qliqUfnoVUOi5rv?=
 =?us-ascii?Q?2LuCr7Pzn4zC13NbeilpaKtdAaiUmMQdqewxRotSAE77vEpxClbO1+pe3ldl?=
 =?us-ascii?Q?fYjAY6fTRwNL2gGuIp9qstZnt01iKQ/QoUSYy6KQ8uqdiElWCKeZ5mcnIHI0?=
 =?us-ascii?Q?l53Ieq9U3jMGqaA6QhpG4DsR00NFMzZsod3r0ODTsRQWKqwScP+aTSjilYpm?=
 =?us-ascii?Q?Fq1NnR4Qa+KoU9qIQVQdqaQlUOLkfxlEe1qLRKNzNfKbJ3z0olrVEOKR2t9L?=
 =?us-ascii?Q?l8X9IMgHWWIIVA4uQ6VtlyT6Lte699uI19rzzyqyipC9Ahw6o56FeuNIQZgU?=
 =?us-ascii?Q?YhwAitKRNy6iqq5n/bLR6vFpyLWwu9NFlFbF5bGa6RAHc092EYlvf4j0OK4p?=
 =?us-ascii?Q?vEm62Hzbnu16eYnyvR8/Bb+L0sk7G9Lw+s4Ma+oPassSVjG+l6u50gDxdrlL?=
 =?us-ascii?Q?WyPPdn+CwcrlTQ82ShpaPVssofNxqS+DsQ0cafZT2FMNZINmJyh4PTrPmRpF?=
 =?us-ascii?Q?0+uthgP0WQp8NXWGMNnjF7wM4zZimoPwn6WZSDmG5irfcOQsaI1a+7pSWnOJ?=
 =?us-ascii?Q?TAQsnN10JW3LB/1ZJcANKIQz75DrCUi7vC42scdyYOSToDeRjX+aw22uwLdO?=
 =?us-ascii?Q?pRaGcedFwBVzgGRVaOjXs4pWTS9Gu2iLBLwAKVJaKi47vruF4SKn5RsFkHE2?=
 =?us-ascii?Q?RZc8OoPEqL6lHq+VPcAxF4UMtfYru610+Gg6r31EJtOtV06gfEDkrbkrIqEZ?=
 =?us-ascii?Q?W8+n+gokq9ZJm/+SDC6eMikU33EvhrowZSBiEAOP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 531281ac-428b-4016-f828-08dacc56b8a7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 06:56:46.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSavPj78hBtjSMiaE9iALkULkMUoDIxSKAbb2qa4GXNz+nb64rkFQ+deYLITeb9deh/LkUorNqZ3gmS544SMjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 04:15:32PM +0100, Andrey Konovalov wrote:
> On Mon, Nov 21, 2022 at 2:53 PM Feng Tang <feng.tang@intel.com> wrote:
> >
> > Use new is_kmalloc_cache() to simplify the code of checking whether
> > a kmem_cache is a kmalloc cache.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Hi Feng,
> 
> Nice simplification!
> 
> > ---
> >  include/linux/kasan.h | 9 ---------
> >  mm/kasan/common.c     | 9 ++-------
> >  mm/slab_common.c      | 1 -
> >  3 files changed, 2 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index dff604912687..fc46f5d6f404 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -102,7 +102,6 @@ struct kasan_cache {
> >         int alloc_meta_offset;
> >         int free_meta_offset;
> >  #endif
> > -       bool is_kmalloc;
> >  };
> 
> We can go even further here, and only define the kasan_cache struct
> and add the kasan_info field to kmem_cache when CONFIG_KASAN_GENERIC
> is enabled.

Good idea. thanks!

I mainly checked the kasan_cache related code, and make an add-on
patch below, please let me know if my understanding is wrong or I
missed anything.

Thanks,
Feng

---
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 0ac6505367ee..f2e41290094e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -96,14 +96,6 @@ static inline bool kasan_has_integrated_init(void)
 }
 
 #ifdef CONFIG_KASAN
-
-struct kasan_cache {
-#ifdef CONFIG_KASAN_GENERIC
-	int alloc_meta_offset;
-	int free_meta_offset;
-#endif
-};
-
 void __kasan_unpoison_range(const void *addr, size_t size);
 static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
 {
@@ -293,6 +285,11 @@ static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
 
 #ifdef CONFIG_KASAN_GENERIC
 
+struct kasan_cache {
+	int alloc_meta_offset;
+	int free_meta_offset;
+};
+
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object);
 slab_flags_t kasan_never_merge(void);
 void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index f0ffad6a3365..39f7f1f95de2 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -72,7 +72,7 @@ struct kmem_cache {
 	int obj_offset;
 #endif /* CONFIG_DEBUG_SLAB */
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 	struct kasan_cache kasan_info;
 #endif
 
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index f9c68a9dac04..4e7cdada4bbb 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -132,7 +132,7 @@ struct kmem_cache {
 	unsigned int *random_seq;
 #endif
 
-#ifdef CONFIG_KASAN
+#ifdef CONFIG_KASAN_GENERIC
 	struct kasan_cache kasan_info;
 #endif
 


