Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0C0681A34
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjA3TUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234744AbjA3TUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:20:37 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8438655
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:20:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 36so8371558pgp.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmO/JY9AimPZ9b7nQ0Peh1d3LQuWaqLK8tajlSI2VK4=;
        b=gDkyBx+UtOY40DFc4SrV+c4ScAaEt1lzPGLSBFrXGOYeM2/PF/vuhD/H+eBidJE3lP
         6rhudVbxvpE5rpdS5LY9SY2uzbanVIL+/pSajS/7CSYcNtntJWNVQ+79qm80/shFhylM
         55wdpy56H2xL54nz56Hfr54Tw6ZXbghpG0pBS8Hv0OshpU2xX45NFbqYaCoH0Fb+2B3q
         cDci7lK6Kaz2eXhOrPC86DcmaaflkyCxhAqgPBrXvsrNOXEB4kYA2gGhIiw2AtksjDgt
         r3rm4Ihw2K42TX3ughkQjPDUR5ltoz34Uegy3yu07KAsnuPlIEhfzY65F+TOSdgqOSMm
         b1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmO/JY9AimPZ9b7nQ0Peh1d3LQuWaqLK8tajlSI2VK4=;
        b=UfunGMcweMzbkJIuGjVgVf5ufdp7rsvdzTZyFWgOuFkPV+PmidSPNKITIRTRV4ldx8
         RDpYOITUN/zN1RrXVEbJ4n00t9jNnl04bxos4A30eUjGlafV9wHDbnVgBv4hcfwD9Tw7
         zBJPnQgYcI0rtHpTMZMHqxh20eG8IHLULcraZpEymKmb9upDKjIheqp5YqEcIQLs6/iX
         SdiZAOUNgW9SxW5DCXmEI0ZVkLpIssQ3mQrpacnRWAbh6hwZoAnCsUJxjvBFe+iZYU5q
         JQ7oUoEXh4myXeYZ+jX+pNELlUv+jAnUftwxVjngsvhBbISiLVl+IOvKPvUouYtJxkTu
         39uw==
X-Gm-Message-State: AFqh2kr9u/2lLHnTxxOVog6hO0bR2M16NMohmaYJj+eC4pNOeDS2IAWF
        pIoUGMNeei8uE7GRXtxk4j89qEnNpWgr/DN6lN4=
X-Google-Smtp-Source: AMrXdXuzOns0YXnoZ0SM5MBVUIMLJg2fIbDXjwDzC9WQRe3PO0RJX+q+x6+tdmKew0LFFHoKj5wDnYuOY8U2s2EKR0I=
X-Received: by 2002:aa7:8249:0:b0:58b:c29a:87a6 with SMTP id
 e9-20020aa78249000000b0058bc29a87a6mr6880236pfn.13.1675106435188; Mon, 30 Jan
 2023 11:20:35 -0800 (PST)
MIME-Version: 1.0
References: <IA1PR07MB983017D2FBA174D2FF78CEB6ABCE9@IA1PR07MB9830.namprd07.prod.outlook.com>
 <Y9LNCouUvsUFCYkT@casper.infradead.org> <adc9152e-c547-12ec-3538-006500619896@redhat.com>
 <713c6242-be65-c212-b790-2b908627c1b4@google.com> <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
In-Reply-To: <9d8fb9c-1b81-67cd-e55b-34517388e1ab@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 30 Jan 2023 11:20:23 -0800
Message-ID: <CAHbLzkpctht-CJkczcZv7svN1UUbLVa0xsMPFdoo3obc74ugrA@mail.gmail.com>
Subject: Re: kernel BUG in page_add_anon_rmap
To:     Hugh Dickins <hughd@google.com>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "contact@pgazz.com" <contact@pgazz.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        Huang Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 10:49 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Fri, 27 Jan 2023, Hugh Dickins wrote:
> > On Fri, 27 Jan 2023, David Hildenbrand wrote:
> > > On 26.01.23 19:57, Matthew Wilcox wrote:
> > > > On Wed, Jan 25, 2023 at 11:59:16PM +0000, Sanan Hasanov wrote:
> > > >> Good day, dear maintainers,
> > > >>
> > > >> We found a bug using a modified kernel configuration file used by syzbot.
> > > >>
> > > >> We enhanced the coverage of the configuration file using our tool,
> > > >> klocalizer.
> > > >>
> > > >> Kernel Branch: 6.2.0-rc5-next-20230124
> > > >> Kernel
> > > >> config: https://drive.google.com/file/d/1MZSgIF4R9QfikEuF5siUIZVPce-GiJQK/view?usp=sharing
> > > >> Reproducer: https://drive.google.com/file/d/1H5KWkT9VVMWTUVVgIaZi6J-fmukRx-BM/view?usp=sharing
> > > >>
> > > >> Thank you!
> > > >>
> > > >> Best regards,
> > > >> Sanan Hasanov
>
> This is a very interesting find: the thanks go to you.
>
> > > >>
> > > >> head: 0000000000020000 0000000000000000 00000004ffffffff ffff8881002b8000
> > > >> page dumped because: VM_BUG_ON_PAGE(!first && (flags & (( rmap_t)((((1UL)))
> > > >> << (0)))))
> > > >> ------------[ cut here ]------------
> > > >
> > > > I know it says "cut here" and you did that, but including just a few
> > > > lines above that would be so much more helpful.  I can infer that this
> > > > is a multi-page folio, but more than that is hard to tell.
> > > >
> > > >> kernel BUG at mm/rmap.c:1248!
> > > >
> > > > That tracks with VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
> > > >
> > > >> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > > >> CPU: 7 PID: 14932 Comm: syz-executor.1 Not tainted 6.2.0-rc5-next-20230124
> > > >> #1
> > > >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> > > >> 04/01/2014
> > > >> RIP: 0010:page_add_anon_rmap+0xddd/0x11c0 mm/rmap.c:1248
> > > >> Code: c0 ff 48 8b 34 24 48 89 df e8 1f ff 07 00 49 89 c6 e9 85 f6 ff ff e8
> > > >> 52 73 c0 ff 48 c7 c6 c0 3c d8 89 48 89 ef e8 b3 23 f8 ff <0f> 0b e8 3c 73
> > > >> c0 ff 48 c7 c6 00 3b d8 89 48 89 ef e8 9d 23 f8 ff
> > > >> RSP: 0018:ffffc9000c56f7b0 EFLAGS: 00010293
> > > >> RAX: 0000000000000000 RBX: ffff88807efc6f30 RCX: 0000000000000000
> > > >> RDX: ffff8880464fd7c0 RSI: ffffffff81be733d RDI: fffff520018adedb
> > > >> RBP: ffffea0000c68080 R08: 0000000000000056 R09: 0000000000000000
> > > >> R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0000c68000
> > > >> R13: 0000000000000001 R14: ffffea0000c68088 R15: 0000000000000000
> > > >> FS:  00007f717898a700(0000) GS:ffff888119f80000(0000)
> > > >> knlGS:0000000000000000
> > > >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > >> CR2: 00007f7178947d78 CR3: 000000004a9e6000 CR4: 0000000000350ee0
> > > >> Call Trace:
> > > >>   <TASK>
> > > >>   remove_migration_pte+0xaa6/0x1390 mm/migrate.c:261
> > > >
> > > >                          if (folio_test_anon(folio))
> > > >                                  page_add_anon_rmap(new, vma, pvmw.address,
> > > >                                                     rmap_flags);
> > > >
> > > > Earlier in that function, we had:
> > > >                  if (folio_test_anon(folio) &&
> > > >                  !is_readable_migration_entry(entry))
> > > >                          rmap_flags |= RMAP_EXCLUSIVE;
> > > >
> > > > so that also makes sense.  We can also infer that RMAP_COMPOUND wasn't
> > > > set, so we're trying to do just one page from the folio.
> > > >
> > > > All right, back to rmap.c:
> > > >
> > > >                  first = atomic_inc_and_test(&page->_mapcount);
> > > >
> > > > So first is clearly false (ie _mapcount was not -1), implying somebody
> > > > else already mapped this page.  Not really sure what's going on at
> > > > this point.  Seems unlikely that the folio changes in
> > > > remove_migration_pte() are responsible since they're from last January.
> > > > Huang has some more changes to migrate.c that I don't feel qualified
> > > > to judge.
> > > >
> > > > Nothing's jumping out at me as obviously wrong.  Is it possible to
> > > > do a bisect?
> > >
> > > I reproduced on next-20230127 (did not try upstream yet).
>
> Upstream's fine; on next-20230127 (with David's repro) it bisects to
> 5ddaec50023e ("mm/mmap: remove __vma_adjust()").  I think I'd better
> hand on to Liam, rather than delay you by puzzling over it further myself.
>
> > >
> > > I think two key things are that a) THP are set to "always" and b) we have a
> > > NUMA setup [I assume].
> > >
> > > The relevant bits:
> > >
> > > [  439.886738] page:00000000c4de9000 refcount:513 mapcount:2
> > > mapping:0000000000000000 index:0x20003 pfn:0x14ee03
> > > [  439.893758] head:000000003d5b75a4 order:9 entire_mapcount:0
> > > nr_pages_mapped:511 pincount:0
> > > [  439.899611] memcg:ffff986dc4689000
> > > [  439.902207] anon flags:
> > > 0x17ffffc009003f(locked|referenced|uptodate|dirty|lru|active|head|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
> > > [  439.910737] raw: 0017ffffc0020000 ffffe952c53b8001 ffffe952c53b80c8
> > > dead000000000400
> > > [  439.916268] raw: 0000000000000000 0000000000000000 0000000000000001
> > > 0000000000000000
> > > [  439.921773] head: 0017ffffc009003f ffffe952c538b108 ffff986de35a0010
> > > ffff98714338a001
> > > [  439.927360] head: 0000000000020000 0000000000000000 00000201ffffffff
> > > ffff986dc4689000
> > > [  439.932341] page dumped because: VM_BUG_ON_PAGE(!first && (flags & ((
> > > rmap_t)((((1UL))) << (0)))))
> > >
> > >
> > > Indeed, the mapcount of the subpage is 2 instead of 1. The subpage is only
> > > mapped into a single
> > > page table (no fork() or similar).
>
> Yes, that mapcount:2 is weird; and what's also weird is the index:0x20003:
> what is remove_migration_pte(), in an mbind(0x20002000,...), doing with
> index:0x20003?
>
> My guess is that the remove-__vma_adjust() commit is not properly updating
> vm_pgoff into non_vma in some case: so that when remove_migration_pte()
> looks for where to insert the new pte, it's off by one page.
>
> > >
> > > I created this reduced reproducer that triggers 100%:
>
> Very helpful, thank you.
>
> > >
> > >
> > > #include <stdint.h>
> > > #include <unistd.h>
> > > #include <sys/mman.h>
> > > #include <numaif.h>
> > >
> > > int main(void)
> > > {
> > >     mmap((void*)0x20000000ul, 0x1000000ul, PROT_READ|PROT_WRITE|PROT_EXEC,
> > >          MAP_ANONYMOUS|MAP_FIXED|MAP_PRIVATE, -1, 0ul);
> > >     madvise((void*)0x20000000ul, 0x1000000ul, MADV_HUGEPAGE);
> > >
> > >     *(uint32_t*)0x20000080 = 0x80000;
> > >     mlock((void*)0x20001000ul, 0x2000ul);
> > >     mlock((void*)0x20000000ul, 0x3000ul);
>
> It's not an mlock() issue in particular: quickly established by
> substituting madvise(,, MADV_NOHUGEPAGE) for those mlock() calls.
> Looks like a vma splitting issue now.
>
> > >     mbind((void*)0x20002000ul, 0x1000ul, MPOL_LOCAL, NULL, 0x7fful,
> > >     MPOL_MF_MOVE);
>
> I guess it will turn out not to be relevant to this particular syzbug,
> but what do we expect an mbind() of just 0x1000 of a THP to do?
>
> It's a subject I've wrestled with unsuccessfully in the past: I found
> myself arriving at one conclusion (split THP) in one place, and a contrary
> conclusion (widen range) in another place, and never had time to work out
> one unified answer.
>
> So I do wonder what pte replaces the migration entry when the bug here
> is fixed: is it a pte pointing into the THP as before, in which case
> what was the point of "migration"? is it a Copy-On-Bind page?
> or has the whole THP been migrated?

IIRC, mbind() for partial THP would migrate the whole THP as long as
there is enough memory on the target node. mbind() doesn't split THP,
but only split PMD, and PMD split is after the THP is queued for
migration. So the migration actually migrates PTE-mapped THP.

>
> I ought to read through those "estimated mapcount" threads more
> carefully: might be relevant, but I've not paid enough attention.
>
> Hugh
>
> > >     return 0;
> > > }
> > >
> > > We map a large-enough are for a THP and then populate a fresh anon THP (PMD
> > > mapped)
> > > to write to it.
> > >
> > > The first mlock() will trigger PTE-mapping the THP and mlocking that subpage.
> > > The second mlock() seems to cause the issue. The final mbind() triggers page
> > > migration.
> > >
> > > Removing one of the mlock() makes it work. Note that we do a double
> > > mlock() of the same page -- the one we are then trying to migrate.
> > >
> > > Somehow, the double mlock() of the same page seems to affect our mapcount.
> > >
> > > CCing Hugh.
> >
> > Thanks David - most especially for the reproducer, not tried here yet.
> > I'll assume this is my bug, and get into it later in the day.
> >
> > Hugh
