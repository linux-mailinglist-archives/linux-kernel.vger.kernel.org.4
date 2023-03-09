Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00F46B1E6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjCIIkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCIIjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:39:33 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAD520072;
        Thu,  9 Mar 2023 00:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678351094; x=1709887094;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=dlGlMy640JD1Y7x742ADAbcu0VK+hnDBh/IIP7/8FeA=;
  b=CIE3nrEuGhxZR7ozDPCC3svME7eaciXi+Kr5dswol5nz9aVoSPR0n1J4
   t23m2va8xU5kkC62WkdgCWQkDCTqmQS5gT+ex7y5mQESk87sMmRUgKn3o
   YyJb2hiN0hcB9LHbw+dVbjDlzRWXZKmf9yUVGpH3ivciR+1j8F+1g9sNv
   I3qYiyn4g3TFMVEk5qni25pBJVFzmotixSUjvX5VmIif/BtVTRMaF3l/C
   S30Bt9MeYrVUYNmrnCcntcWTMdZHJNsGO/hmFaAjlnayRyUpSmhFgcKhz
   DH51nfdOm6i8W0BuBmaezXkTvP9eYYsNSKpYoYvGKPEMRHC347UsE6+X+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="398968363"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="398968363"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:38:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="707520420"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="707520420"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:38:11 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
        <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com>
        <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
        <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
        <87jzzu7jt9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <43f35191-9147-0aec-cb57-0bc14d041039@suse.cz>
Date:   Thu, 09 Mar 2023 16:37:07 +0800
In-Reply-To: <43f35191-9147-0aec-cb57-0bc14d041039@suse.cz> (Vlastimil Babka's
        message of "Wed, 8 Mar 2023 11:39:28 +0100")
Message-ID: <877cvq8gng.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka <vbabka@suse.cz> writes:

> On 3/6/23 02:25, Huang, Ying wrote:
>> Hi, Linus,
>>=20
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>=20
>>> On Sat, Mar 4, 2023 at 3:21=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
>>>>
>>>> Ah. Ying did it this way:
>>>
>>> Yeah, I saw that patch flying past, but I actually think that it only
>>> silences the warning almost by mistake. There's nothing fundamental in
>>> there that a compiler wouldn't just follow across two assignments, and
>>> it just happens to now not trigger any more.
>>>
>>> Assigning to a union entry is a more fundamental operation in that
>>> respect. Not that the compiler still doesn't see that it's assigning a
>>> value that in the end is not really type compatible, so a different
>>> version of gcc could still warn, but at that point I feel like it's
>>> more of an actual compiler bug than just "oh, the compiler didn't
>>> happen to follow the cast through a temporary".
>>=20
>> Yes.  Your fix is much better.  This can be used for
>> __page_set_anon_rmap() family too to make the code look better?
>
> Those are trickier due to the PAGE_MAPPING_ANON tagging bit which your
> code doesn't need to handle because you can simply store an untagged
> anon_vma pointer. Otherwise we could have the union at the struct page
> level already (but probably not at this point as IIRC Matthew is
> planning to have completely separate types for anon and file folios).
>
> So right now we have e.g. folio_get_anon_vma() using unsigned long as
> the intermediate variable, page_move_anon_rmap() using a void *
> variable, __page_set_anon_rmap() casting through a (void *) ... Is there
> a single recommended way for "tagged pointers" that we could unify that t=
o?

Ah, you are right.  We need to deal with tagging bit and maybe struct
movable_operations *.  I tried to write the below debug patch (only
build test it).  The code adds 1 or 2 lines for each function.  But to
be honest, the original force casting method appears more natural to me.

Best Regards,
Huang, Ying

---------------------------8<------------------------------------
From 68a0f54921beca8aeaa8fe78867e62b5a66658b8 Mon Sep 17 00:00:00 2001
From: Huang Ying <ying.huang@intel.com>
Date: Thu, 9 Mar 2023 15:29:58 +0800
Subject: [PATCH] dbg mapping_ptr

---
 mm/rmap.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 8632e02661ac..50ee208baff9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -466,6 +466,13 @@ void __init anon_vma_init(void)
 			SLAB_PANIC|SLAB_ACCOUNT);
 }
=20
+union mapping_ptr {
+	struct address_space *mapping;
+	unsigned long tag;
+	struct anon_vma *anon_vma;
+	struct movable_operations *mops;
+};
+
 /*
  * Getting a lock on a stable anon_vma from a page off the LRU is tricky!
  *
@@ -493,16 +500,17 @@ void __init anon_vma_init(void)
 struct anon_vma *folio_get_anon_vma(struct folio *folio)
 {
 	struct anon_vma *anon_vma =3D NULL;
-	unsigned long anon_mapping;
+	union mapping_ptr mptr;
=20
 	rcu_read_lock();
-	anon_mapping =3D (unsigned long)READ_ONCE(folio->mapping);
-	if ((anon_mapping & PAGE_MAPPING_FLAGS) !=3D PAGE_MAPPING_ANON)
+	mptr.mapping =3D READ_ONCE(folio->mapping);
+	if ((mptr.tag & PAGE_MAPPING_FLAGS) !=3D PAGE_MAPPING_ANON)
 		goto out;
 	if (!folio_mapped(folio))
 		goto out;
=20
-	anon_vma =3D (struct anon_vma *) (anon_mapping - PAGE_MAPPING_ANON);
+	mptr.tag &=3D ~PAGE_MAPPING_FLAGS;
+	anon_vma =3D mptr.anon_vma;
 	if (!atomic_inc_not_zero(&anon_vma->refcount)) {
 		anon_vma =3D NULL;
 		goto out;
@@ -1115,18 +1123,20 @@ int folio_total_mapcount(struct folio *folio)
 void page_move_anon_rmap(struct page *page, struct vm_area_struct *vma)
 {
 	void *anon_vma =3D vma->anon_vma;
+	union mapping_ptr mptr;
 	struct folio *folio =3D page_folio(page);
=20
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_VMA(!anon_vma, vma);
=20
-	anon_vma +=3D PAGE_MAPPING_ANON;
+	mptr.anon_vma =3D anon_vma;
+	mptr.tag |=3D PAGE_MAPPING_ANON;
 	/*
 	 * Ensure that anon_vma and the PAGE_MAPPING_ANON bit are written
 	 * simultaneously, so a concurrent reader (eg folio_referenced()'s
 	 * folio_test_anon()) will not see one without the other.
 	 */
-	WRITE_ONCE(folio->mapping, anon_vma);
+	WRITE_ONCE(folio->mapping, mptr.mapping);
 	SetPageAnonExclusive(page);
 }
=20
@@ -1142,6 +1152,7 @@ static void __page_set_anon_rmap(struct folio *folio,=
 struct page *page,
 	struct vm_area_struct *vma, unsigned long address, int exclusive)
 {
 	struct anon_vma *anon_vma =3D vma->anon_vma;
+	union mapping_ptr mptr;
=20
 	BUG_ON(!anon_vma);
=20
@@ -1162,8 +1173,9 @@ static void __page_set_anon_rmap(struct folio *folio,=
 struct page *page,
 	 * the PAGE_MAPPING_ANON type identifier, otherwise the rmap code
 	 * could mistake the mapping for a struct address_space and crash.
 	 */
-	anon_vma =3D (void *) anon_vma + PAGE_MAPPING_ANON;
-	WRITE_ONCE(folio->mapping, (struct address_space *) anon_vma);
+	mptr.anon_vma =3D anon_vma;
+	mptr.tag |=3D PAGE_MAPPING_ANON;
+	WRITE_ONCE(folio->mapping, mptr.mapping);
 	folio->index =3D linear_page_index(vma, address);
 out:
 	if (exclusive)
--=20
2.39.2

