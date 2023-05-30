Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2D4716FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjE3VcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjE3VcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:32:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6519310B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:32:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565cfe4ece7so47641417b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685482320; x=1688074320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUp9Fa1pjHqmOtpYsaGQqzSHj8q6VMat88zgfBHsgW8=;
        b=kHHoHsOf7lF6CDUvaNtAyCEgnCyP2bGwfuJMq9gXCZXWZqqx1WbUvB56MlrzA7Hotc
         uJO3M0szvLU4CuMhFXOAUKDIhYljnrgoC4AH+aoNOtV0K9wgQCsP7qMrhS8Ki1OcmqW0
         LS8gi4BJeroukpoORFTdpZPloWqNpbFpJNHalT3njf8z4LXUPD9K07U6lfqESESfQhky
         TqzINm2hEPMxC0rQXw6dFm24K0uDkjmu5Ot2mVR89Ji57WKBL23txYOb3F0BXfwOFbhi
         OtosBmxaF2CwDx6BZAXzdQJhktJCSZWEN7O2vQepDqhXKsiUvQAAM2sq6z+XvjBh8tpM
         C4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685482320; x=1688074320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUp9Fa1pjHqmOtpYsaGQqzSHj8q6VMat88zgfBHsgW8=;
        b=HF5LmkSpybtmNfyS2QunuoD0g33/kpCYCq4zS5XnJaiTXhHUAcYLFFu8E8uNfjOzMq
         Xn806SzrKdzu0sWiSLU+P3iBbvwmcuo9GcqApQYjiAfxhFGaIEk9XB1/vr0JsvLBcnO8
         yyTzGIGPIOAYu5ow+SzO+VmFgnJCmRnRe4mxeP08s+glzFPXRlZ9pb8ifcJRYJqliCd0
         bjc5g5qX2nIIBKcWeP4AoE2k7tXIkh8BX37+9ZVTe2Eh/cSZxniYZBy6BhQRfehKK0Xi
         b5SAr9INWAEP99AAjTuUbU+z2YBUx8tdV8I3jEVF3oM8lRvRURmtnwPoYEcbGLjxtgqz
         AQDg==
X-Gm-Message-State: AC+VfDz615QgBgPUUThv0lluJsiKAjFNFdKbLI89tp2mI+3jQDml+oj4
        PTxPW+V3i3VGvddKjtpNRtLKFO4AAEYGExGADHevIQ==
X-Google-Smtp-Source: ACHHUZ5kjfq40HDnWtqS+JslKUrd3YahK0/x0fqljpS9+q38/inMNSUkw8fIogeUcXU3oZyoJPDSFWihbMH+PxASMYg=
X-Received: by 2002:a81:4987:0:b0:565:ef60:3f2f with SMTP id
 w129-20020a814987000000b00565ef603f2fmr3643003ywa.44.1685482320210; Tue, 30
 May 2023 14:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230428004139.2899856-1-jiaqiyan@google.com> <20230428004139.2899856-5-jiaqiyan@google.com>
 <20230530022456.GA1434147@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20230530022456.GA1434147@hori.linux.bs1.fc.nec.co.jp>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Tue, 30 May 2023 14:31:49 -0700
Message-ID: <CACw3F51shtGh97t3A3qhyg3E16stSifkgpcAZOi9JZuFFywfxA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/7] mm/memory_failure: unmap raw HWPoison PTEs
 when possible
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
Cc:     "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 7:25=E2=80=AFPM HORIGUCHI NAOYA(=E5=A0=80=E5=8F=A3=
=E3=80=80=E7=9B=B4=E4=B9=9F)
<naoya.horiguchi@nec.com> wrote:
>
> On Fri, Apr 28, 2023 at 12:41:36AM +0000, Jiaqi Yan wrote:
> > When a folio's VMA is HGM eligible, try_to_unmap_one now only unmaps
> > the raw HWPOISON page (previously split and mapped at PTE size).
> > If HGM failed to be enabled on eligible VMA or splitting failed,
> > try_to_unmap_one fails.
> >
> > For VMS that is not HGM eligible, try_to_unmap_one still unmaps
> > the whole P*D.
> >
> > When only the raw HWPOISON subpage is unmapped but others keep mapped,
> > the old way in memory_failure to check if unmapping successful doesn't
> > work. So introduce is_unmapping_successful() to cover both existing and
> > new unmapping behavior.
> >
> > For the new unmapping behavior, store how many times a raw HWPOISON pag=
e
> > is expected to be unmapped, and how many times it is actually unmapped
> > in try_to_unmap_one(). A HWPOISON raw page is expected to be unmapped
> > from a VMA if splitting succeeded in try_to_split_huge_mapping(), so
> > unmap_success =3D (nr_expected_unamps =3D=3D nr_actual_unmaps).
> >
> > Old folio_set_hugetlb_hwpoison returns -EHWPOISON if a folio has any
> > raw HWPOISON subpage, and try_memory_failure_hugetlb won't attempt
> > recovery actions again because recovery used to be done on the entire
> > hugepage. With the new unmapping behavior, this doesn't hold. More
> > subpages in the hugepage can become corrupted, and needs to be recovere=
d
> > (i.e. unmapped) individually. New folio_set_hugetlb_hwpoison returns
> > 0 after adding a new raw subpage to raw_hwp_list.
> >
> > Unmapping raw HWPOISON page requires allocating raw_hwp_page
> > successfully in folio_set_hugetlb_hwpoison, so try_memory_failure_huget=
lb
> > now may fail due to OOM.
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> ...
>
> > @@ -1827,6 +1879,31 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
> >
> >  #ifdef CONFIG_HUGETLB_PAGE
> >
> > +/*
> > + * Given a HWPOISON @subpage as raw page, find its location in @folio'=
s
> > + * _hugetlb_hwpoison. Return NULL if @subpage is not in the list.
> > + */
> > +struct raw_hwp_page *find_in_raw_hwp_list(struct folio *folio,
> > +                                       struct page *subpage)
> > +{
> > +     struct llist_node *t, *tnode;
> > +     struct llist_head *raw_hwp_head =3D raw_hwp_list_head(folio);
> > +     struct raw_hwp_page *hwp_page =3D NULL;
> > +     struct raw_hwp_page *p;
> > +
> > +     VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage);
>
> I'm testing the series (on top of v6.2-rc4 + HGM v2 patchset) and found t=
he
> following error triggered by this VM_BUG_ON_PAGE().  The testcase is just=
 to
> inject hwpoison on an anonymous page (it's not hugetlb-related one).

Thanks for reporting this problem, Naoya!

My mistake, this assertion meant to be "if !PageHWPoison(subpage)", to
make sure the caller of find_in_raw_hwp_list is sure that subpage is
hw corrupted.

>
>   [  790.610985] =3D=3D=3D> testcase 'mm/hwpoison/base/backend-anonymous_=
error-hard-offline_access-avoid.auto3' start
>   [  793.304927] page:000000006743177b refcount:1 mapcount:0 mapping:0000=
000000000000 index:0x700000000 pfn:0x14d739
>   [  793.309322] memcg:ffff8a30c50b6000
>   [  793.310934] anon flags: 0x57ffffe08a001d(locked|uptodate|dirty|lru|m=
appedtodisk|swapbacked|hwpoison|node=3D1|zone=3D2|lastcpupid=3D0x1fffff)
>   [  793.316665] raw: 0057ffffe08a001d ffffe93cc5353c88 ffffe93cc5685fc8 =
ffff8a30c91878f1
>   [  793.320211] raw: 0000000700000000 0000000000000000 00000001ffffffff =
ffff8a30c50b6000
>   [  793.323665] page dumped because: VM_BUG_ON_PAGE(PageHWPoison(subpage=
))
>   [  793.326764] ------------[ cut here ]------------
>   [  793.329080] kernel BUG at mm/memory-failure.c:1894!
>   [  793.331895] invalid opcode: 0000 [#1] PREEMPT SMP PTI
>   [  793.334854] CPU: 4 PID: 2644 Comm: mceinj.sh Tainted: G            E=
    N 6.2.0-rc4-v6.2-rc2-230529-1404+ #63
>   [  793.340710] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.16.1-2.fc37 04/01/2014
>   [  793.345875] RIP: 0010:hwpoison_user_mappings+0x654/0x780
>   [  793.349066] Code: ef 89 de e8 6e bc f8 ff 48 8b 7c 24 20 48 83 c7 58=
 e8 10 bb d9 ff e9 5f fb ff ff 48 c7 c6 80 ce 4c b1 4c 89 ef e8 1c 38 f6 ff=
 <0f> 0b 48 c7 c6 7b c8 4c b1 4c 89 ef e8 0b 38 f6 ff 0f 0b 8b 45 58
>   [  793.359732] RSP: 0018:ffffa3ff85ed3d28 EFLAGS: 00010296
>   [  793.362367] RAX: 000000000000003a RBX: 0000000000000018 RCX: 0000000=
000000000
>   [  793.365763] RDX: 0000000000000001 RSI: ffffffffb14ac451 RDI: 0000000=
0ffffffff
>   [  793.368698] RBP: ffffe93cc535ce40 R08: 0000000000000000 R09: ffffa3f=
f85ed3ba0
>   [  793.370837] R10: 0000000000000003 R11: ffffffffb1d3ed28 R12: 0000000=
00014d739
>   [  793.372903] R13: ffffe93cc535ce40 R14: ffffe93cc535ce40 R15: ffffe93=
cc535ce40
>   [  793.374931] FS:  00007f6ccc42a740(0000) GS:ffff8a31bbc00000(0000) kn=
lGS:0000000000000000
>   [  793.377136] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  793.378656] CR2: 0000561aad6474b2 CR3: 00000001492d4005 CR4: 0000000=
000170ee0
>   [  793.380514] DR0: ffffffffb28ed7d0 DR1: ffffffffb28ed7d1 DR2: fffffff=
fb28ed7d2
>   [  793.382296] DR3: ffffffffb28ed7d3 DR6: 00000000ffff0ff0 DR7: 0000000=
000000600
>   [  793.384028] Call Trace:
>   [  793.384655]  <TASK>
>   [  793.385210]  ? __lru_add_drain_all+0x164/0x1f0
>   [  793.386316]  memory_failure+0x352/0xaa0
>   [  793.387249]  ? __pfx_bpf_lsm_capable+0x10/0x10
>   [  793.388323]  ? __pfx_security_capable+0x10/0x10
>   [  793.389350]  hard_offline_page_store+0x46/0x80
>   [  793.390397]  kernfs_fop_write_iter+0x11e/0x200
>   [  793.391441]  vfs_write+0x1e4/0x3a0
>   [  793.392221]  ksys_write+0x53/0xd0
>   [  793.392976]  do_syscall_64+0x3a/0x90
>   [  793.393790]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>
> I'm wondering how this code path is called, one possible path is like thi=
s:
>
>   hwpoison_user_mappings
>     if PageHuge(hpage) && !PageAnon(hpage)
>       try_to_split_huge_mapping()
>         find_in_raw_hwp_list
>           VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage)
>
> but this looks unlikely because the precheck "PageHuge(hpage) && !PageAno=
n(hpage)" is
> false for anonymous pages.
>
> Another possible code path is:
>
>   hwpoison_user_mappings
>     if PageHuge(hpage) && !PageAnon(hpage)
>       ...
>     else
>       try_to_unmap
>         rmap_walk
>           rmap_walk_anon
>             try_to_unmap_one
>               if folio_test_hugetlb
>                 if hgm_eligible
>                   find_in_raw_hwp_list
>                     VM_BUG_ON_PAGE(PageHWPoison(subpage), subpage)
>
> but this looks also unlikely because of checking folio_test_hugetlb and h=
gm_eligible
> (I think both are false in this testcase.)
> Maybe I miss something (and I'll dig this more), but let me share the iss=
ue.

I bet it is in "is_unmapping_successful". So another problem with this
patch is, "is_unmapping_successful" should only calls
find_in_raw_hwp_list after it handles non hugetlb and non shared
mapping, i.e.:

struct raw_hwp_page *hwp_page =3D NULL;

if (!folio_test_hugetlb(folio) ||
    folio_test_anon(folio) ||
    !IS_ENABLED(CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING)) {
        ...
}

hwp_page =3D find_in_raw_hwp_list(folio, poisoned_page);
VM_BUG_ON_PAGE(!hwp_page, poisoned_page);

I will make sure these two issues get fixed up in follow-up revisions.

>
> Thanks,
> Naoya Horiguchi
