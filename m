Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6491B6FBB34
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjEHW5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjEHW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:57:06 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E70F46AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 15:57:02 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-4501ca552a3so2317866e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683586621; x=1686178621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipgEDNSiIrU4E+zQEfGy/IQUiiO8wdZohcZP4ZGsl7Q=;
        b=tfoyqd6LzK3XOxfVyAByFwnQJGUhrZ48aRQaDe5HQ+EXrJXDZyxN3kA41B/u43LFGV
         xp0cVKCAFXeZPsIDo6hz6NimEfHMIbSZravt1a+nsSPnIShBdDGmWwolo9TwVBFVcamH
         PDgfpC5cfcBAJArHGTORwSyZ570ul8pdzxVDRIbqX22PnnGKLyBNgmOWOnk0dEyo+hRl
         /JgSmUA8E7uc+uBym7QCxkyrKgKAC/yXSuRf7ijOk9HZtIyFiO8f707yUyOqzfHouCu2
         nMmbs2Cg1yDyrxb+SPkoMOwhenLy1Q34mTRsM3wLjhBbyj0glLqOG3DOM0mm7QOE84qz
         ftPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683586621; x=1686178621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipgEDNSiIrU4E+zQEfGy/IQUiiO8wdZohcZP4ZGsl7Q=;
        b=GQJF9aA1KJW8816UbjYNPTuQzUk7cS3IPNxQhAoO5OQiMQ32fjNIsLDF93OrFtP+ep
         twUJCYvcu+z08tlwyEQFOlzer3yclyQYOsvWZKYbUPSCKK44KXiU25ZLO3ytRjpVsCu6
         QlbKjVqjsqC334YBVcaHsgWfFsLnM5HLLk57iDFnrS6lMnFfhqxOYGfwgHKXvkkJtiue
         IxOKczfpSounn0QNptMG2wNZmyAT9Jc7WqimKMMFZu10PkkK+oK5oXkyc15itLvzVt42
         uOWMk3y/TxeqXzwRIcjtAvSomFXn661CKpUjk47wq9Go2+87jtaJfs+3vRZ3G+u5168S
         6KTw==
X-Gm-Message-State: AC+VfDw0IrCS+gtABQS3TO9hyZ/HLFXOAOjr0n8P4dvANe3Ox+YXx8sM
        nzc5loXF5tEBHtPDv52sosDwKxc//5kbV5V7+g75kA==
X-Google-Smtp-Source: ACHHUZ5dkU+hmB3zVyYEKZSdj+d0ovaPx8VRY8nzOzeVAqEW2HGdyNGoIdExnGM8QAfCYTGXhqIslndrtjrjgL0wAsY=
X-Received: by 2002:a1f:bf8d:0:b0:43f:fc32:15f0 with SMTP id
 p135-20020a1fbf8d000000b0043ffc3215f0mr4213226vkf.14.1683586621393; Mon, 08
 May 2023 15:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <CA+EESO4xfBsywi3TmMd+tu9shaSYypy9n9a5s+dAg08csh1r3Q@mail.gmail.com>
 <ZDV5RzSXairuyqRj@x1n>
In-Reply-To: <ZDV5RzSXairuyqRj@x1n>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 8 May 2023 15:56:50 -0700
Message-ID: <CA+EESO6uGQRtcf=OEYEAuVFvo6WwfyU9qCB1jfKGuxVUkKeWrw@mail.gmail.com>
Subject: Re: RFC for new feature to move pages from one vma to another without split
To:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 8:14=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 10, 2023 at 12:41:31AM -0700, Lokesh Gidra wrote:
> > On Thu, Apr 6, 2023 at 10:29=E2=80=AFAM Peter Xu <peterx@redhat.com> wr=
ote:
> > >
> > > Hi, Lokesh,
> > >
> > > Sorry for a late reply.  Copy Blake Caldwell and Mike too.
> >
> > Thanks for the reply. It's extremely helpful.
> > >
> > > On Thu, Feb 16, 2023 at 02:27:11PM -0800, Lokesh Gidra wrote:
> > > > I) SUMMARY:
> > > > Requesting comments on a new feature which remaps pages from one
> > > > private anonymous mapping to another, without altering the vmas
> > > > involved. Two alternatives exist but both have drawbacks:
> > > > 1. userfaultfd ioctls allocate new pages, copy data and free the ol=
d
> > > > ones even when updates could be done in-place;
> > > > 2. mremap results in vma splitting in most of the cases due to 'pgo=
ff' mismatch.
> > >
> > > Personally it was always a mistery to me on how vm_pgoff works with
> > > anonymous vmas and why it needs to be setup with vm_start >> PAGE_SHI=
FT.
> > >
> > > Just now I tried to apply below oneliner change:
> > >
> > > @@ -1369,7 +1369,7 @@ unsigned long do_mmap(struct file *file, unsign=
ed long addr,
> > >                         /*
> > >                          * Set pgoff according to addr for anon_vma.
> > >                          */
> > > -                       pgoff =3D addr >> PAGE_SHIFT;
> > > +                       pgoff =3D 0;
> > >                         break;
> > >                 default:
> > >                         return -EINVAL;
> > >
> > > The kernel even boots without a major problem so far..
> > >
> > > I had a feeling that I miss something else here, it'll be great if an=
yone
> > > knows.
> > >
> > > Anyway, I agree mremap() is definitely not the best way to do page le=
vel
> > > operations like this, no matter whether vm_pgoff can match or not.
> > >
> > > >
> > > > Proposing a new mremap flag or userfaultfd ioctl which enables
> > > > remapping pages without these drawbacks. Such a feature, as describ=
ed
> > > > below, would be very helpful in efficient implementation of concurr=
ent
> > > > compaction algorithms.
> > >
> > > After I read the proposal, I had a feeling that you're not aware that=
 we
> > > have similar proposals adding UFFDIO_REMAP.
> >
> > Yes, I wasn't aware of this. Thanks a lot for sharing the details.
> > >
> > > I think it started with Andrea's initial proposal on the whole uffd:
> > >
> > > https://lore.kernel.org/linux-mm/1425575884-2574-1-git-send-email-aar=
cange@redhat.com/
> > >
> > > Then for some reason it's not merged in initial version, but at least=
 it's
> > > been proposed again here (even though it seems the goal is slightly
> > > different; that may want to move page out instead of moving in):
> > >
> > > https://lore.kernel.org/linux-mm/cover.1547251023.git.blake.caldwell@=
colorado.edu/
> >
> > Yeah, this seems to be the opposite of what I'm looking for. IIUC,
> > page out REMAP can't
> > satisfy any MISSING userfault. In fact, it enables MISSING faults in
> > future. Maybe a flag
> > can be added to uffdio_remap struct to accommodate this case, if it is
> > still being pursued.
>
> Yes, I don't think that's a major problem if the use cases share mostly t=
he
> same fundation.
>
> > >
> > > Also worth checking with the latest commit that Andrea maintains hims=
elf (I
> > > doubt whether there's major changes, but still just to make it comple=
te):
> > >
> > > https://gitlab.com/aarcange/aa/-/commit/2aec7aea56b10438a3881a20a411a=
a4b1fc19e92
> > >
> > > So far I think that's what you're looking for. I'm not sure whether t=
he
> > > limitations will be a problem, though, at least mentioned in the old
> > > proposals of UFFDIO_REMAP.  For example, it required not only anonymo=
us but
> > > also mapcount=3D=3D1 on all src pages.  But maybe that's not a proble=
m here
> > > too.
> >
> > Yes, this is exactly what I am looking for. The mapcount=3D=3D1 is not =
a
> > problem either. Any idea why the patch isn't merged?
>
> The initial verion of discussion mentioned some of the reason of lacking
> use cases:
>
> https://lore.kernel.org/linux-mm/20150305185112.GL4280@redhat.com/
>
Thanks for sharing the link. I assume the 20% performance gap in
UFFDIO_COPY vs UFFDIO_REMAP is
just for ioctl calls. But (at least) in case of compaction (our use
case), COPY increases other overheads.
It leads to more page allocations, mem-copies, and madvises than
required. OTOH, with REMAP:

1) Page allocations can be mostly avoided by recycling the pages as
they are freed during compaction
2) Memcpy (for compacting objects) into the page (from (1)) is needed
only once (as compared to COPY wherein it does another memcpy).
Furthermore, as described in the RFC, sometimes even 1 memcpy isn't
required (with REMAP)
3) As pages are being recycled in userspace, there would be far fewer
pages to madvise at the end of compaction.

Also, as described in the RFC, REMAP allows moving pages within heap
for page-level coarse-grained compaction, which helps by avoiding
swapping in the page. This wouldn't be possible with COPY.

> But I am not sure of the latter one.  Maybe Mike will know.
>
> >
> > >
> > > >
> > > > II) MOTIVATION:
> > > > Garbage collectors (like the ones used in managed languages) perfor=
m
> > > > defragmentation of the managed heap by moving objects (of varying
> > > > sizes) within the heap. Usually these algorithms have to be concurr=
ent
> > > > to avoid response time concerns. These are concurrent in the sense
> > > > that while the GC threads are compacting the heap, application thre=
ads
> > > > continue to make progress, which means enabling access to the heap
> > > > while objects are being simultaneously moved.
> > > >
> > > > Given the high overhead of heap compaction, such algorithms typical=
ly
> > > > segregate the heap into two types of regions (set of contiguous
> > > > pages): those that have enough fragmentation to compact, and those
> > > > that are densely populated. While only =E2=80=98fragmented=E2=80=99=
 regions are
> > > > compacted by sliding objects, both types of regions are traversed t=
o
> > > > update references in them to the moved objects.
> > > >
> > > > A) PROT_NONE+SIGSEGV approach:
> > > > One of the widely used techniques to ensure data integrity during
> > > > concurrent compaction is to use page-level access interception.
> > > > Traditionally, this is implemented by mprotecting (PROT_NONE) the h=
eap
> > > > before starting compaction and installing a SIGSEGV handler. When G=
C
> > > > threads are compacting the heap, if some application threads fault =
on
> > > > the heap, then they compact the faulted page in the SIGSEGV handler
> > > > and then enable access to it before returning. To do this atomicall=
y,
> > > > the heap must use shmem (MAP_SHARED) so that an alias mapping (with
> > > > read-write permission) can be used for moving objects into and
> > > > updating references.
> > > >
> > > > Limitation: due to different access rights, the heap can end up wit=
h
> > > > one vma per page in the worst case, hitting the =E2=80=98max_map_co=
unt=E2=80=99 limit.
> > > >
> > > > B) Userfaultfd approach:
> > > > Userfaultfd avoids the vma split issue by intercepting page-faults
> > > > when the page is missing and gives control to user-space to map the
> > > > desired content. It doesn=E2=80=99t affect the vma properties. The =
compaction
> > > > algorithm in this case works by first remapping the heap pages (usi=
ng
> > > > mremap) to a secondary mapping and then registering the heap with
> > > > userfaultfd for MISSING faults. When an application thread accesses=
 a
> > > > page that has not yet been mapped (by other GC/application threads)=
, a
> > > > userfault occurs, and as a consequence the corresponding page is
> > > > generated and mapped using one of the following two ioctls.
> > > > 1) COPY ioctl: Typically the heap would be private anonymous in thi=
s
> > > > case. For every page on the heap, compact the objects into a
> > > > page-sized buffer, which COPY ioctl takes as input. The ioctl
> > > > allocates a new page, copies the input buffer to it, and then maps =
it.
> > > > This means that even for updating references in the densely populat=
ed
> > > > regions (where compaction is not done), in-place updation is
> > > > impossible. This results in unnecessary page-clear, memcpy and
> > > > freeing.
> > > > 2) CONTINUE ioctl: the two mappings (heap and secondary) are
> > > > MAP_SHARED to the same shmem file. Userfaults in the =E2=80=98fragm=
ented=E2=80=99
> > > > regions are MISSING, in which case objects are compacted into the
> > > > corresponding secondary mapping page (which triggers a regular page
> > > > fault to get a page mapped) and then CONTINUE ioctl is invoked, whi=
ch
> > > > maps the same page on the heap mapping. On the other hand, userfaul=
ts
> > > > in the =E2=80=98densely populated=E2=80=99 regions are MINOR (as th=
e page already
> > > > exists in the secondary mapping), in which case we update the
> > > > references in the already existing page on the secondary mapping an=
d
> > > > then invoke CONTINUE ioctl.
> > > >
> > > > Limitation: we observed in our implementation that
> > > > page-faults/page-allocation, memcpy, and madvise took (with either =
of
> > > > the two ioctls) ~50% of the time spent in compaction.
> > >
> > > I assume "page-faults" applies to CONTINUE, while "page-allocation" a=
pplies
> > > to COPY here.  UFFDIO_REMAP can definitely avoid memcpy, but I don't =
know
> > > how much it'll remove in total, e.g., I don't think page faults can b=
e
> > > avoided anyway?  Also, madvise(), depending on what it is.  If it's o=
nly
> > > MADV_DONTNEED, maybe it'll be helpful too so the library can reuse wa=
sted
> > > pages directly hence reducing DONTNEEDs.
> > >
> > That's right. page-faults -> CONTINUE and page-allocation -> COPY. The
> > GC algorithm
> > I'm describing here is mostly page-fault free as the heap pages are rec=
ycled.
> >
> > Basically, the heap is mremapped to a secondary mapping so that we can
> > start receiving MISSING faults
> > on the heap after userfaultfd registration. Consequently, on every
> > MISSING userfault, the pages from the
> > secondary mapping are prepared in-place before acting as 'src' for
> > UFFDIO_REMAP ioctl call.
> >
> > Also, as you said, MADV_DONTNEED will be mostly eliminated as most of
> > the pages are recycled in userspace.
> >
> > There are other things too that UFFDIO_REMAP enables us to do. It
> > allows coarse-grained page-by-page compaction
> > of the heap without swapping-in the pages. This isn't possible today.
> >
> > > > III) USE CASE (of the proposed feature):
> > > > The proposed feature of moving pages from one vma to another will
> > > > enable us to:
> > > > A) Recycle pages entirely in the userspace as they are freed (pages
> > > > whose objects are already consumed as part of the current compactio=
n
> > > > cycle) in the =E2=80=98fragmented=E2=80=99 regions. This way we avo=
id page-clearing
> > > > (during page allocation) and memcpy (in the kernel). When the page =
is
> > > > handed over to the kernel for remapping, there is nothing else need=
ed
> > > > to be done. Furthermore, since the page is being reused, it doesn=
=E2=80=99t
> > > > have to be freed either.
> > > > B) Implement a coarse-grained page-level compaction algorithm where=
in
> > > > pages containing live objects are slid next to each other without
> > > > touching them, while reclaiming in-between pages which contain only
> > > > garbage. Such an algorithm is very useful for compacting objects wh=
ich
> > > > are seldom accessed by application and hence are likely to be swapp=
ed
> > > > out. Without this feature, this would require copying the pages
> > > > containing live objects, for which the src pages have to be
> > > > swapped-in, only to be soon swapped-out afterwards.
> > > >
> > > > AFAIK, none of the above features can be implemented using mremap
> > > > (with current flags), irrespective of whether the heap is a shmem o=
r
> > > > private anonymous mapping, because:
> > > > 1) When moving a page it=E2=80=99s likely that its index will need =
to change
> > > > and mremapping such a page would result in VMA splitting.
> > > > 2) Using mremap for moving pages would result in the heap=E2=80=99s=
 range
> > > > being covered by several vmas. The mremap in the next compaction cy=
cle
> > > > (required prior to starting compaction as described above), will fa=
il
> > > > with EFAULT. This is because the src range in mremap is not allowed=
 to
> > > > span multiple vmas. On the other hand, calling it for each src vma =
is
> > > > not feasible because:
> > > >   a) It=E2=80=99s not trivial to identify various vmas covering the=
 heap range
> > > > in userspace, and
> > > >   b) This operation is supposed to happen with application threads
> > > > paused. Invoking numerous mremap syscalls in a pause risks causing
> > > > janks.
> > > > 3) Mremap has scalability concerns due to the need to acquire mmap_=
sem
> > > > exclusively for splitting/merging VMAs. This would impact paralleli=
sm
> > > > of application threads, particularly during the beginning of the
> > > > compaction process when they are expected to cause a spurt of
> > > > userfaults.
> > > >
> > > >
> > > > IV) PROPOSAL:
> > > > Initially, maybe the feature can be implemented only for private
> > > > anonymous mappings. There are two ways this can be implemented:
> > > > A) A new userfaultfd ioctl, =E2=80=98MOVE=E2=80=99, which takes the=
 same inputs as the
> > > > =E2=80=98COPY=E2=80=99 ioctl. After sanity check, the ioctl would d=
etach the pte
> > > > entries from the src vma, and move them to dst vma while updating
> > > > their =E2=80=98mapping=E2=80=99 and =E2=80=98index=E2=80=99 fields,=
 if required.
> > > >
> > > > B) Add a new flag to mremap, =E2=80=98MREMAP_ONLYPAGES=E2=80=99, wh=
ich works similar
> > > > to the MOVE ioctl above.
> > > >
> > > > Assuming (A) is implemented, here is broadly how the compaction wou=
ld work:
> > > > * For a MISSING userfault in the =E2=80=98densely populated=E2=80=
=99 regions, update
> > > > pointers in-place in the secondary mapping page corresponding to th=
e
> > > > fault address (on the heap) and then use the MOVE ioctl to map it o=
n
> > > > the heap. In this case the =E2=80=98index=E2=80=99 field would rema=
in the same.
> > > > * For a MISSING userfault in =E2=80=98fragmented=E2=80=99 regions, =
pick any freed page
> > > > in the secondary map, compact the objects corresponding to the faul=
t
> > > > address in this page and then use MOVE ioctl to map it on the fault
> > > > address in the heap. This would require updating the =E2=80=98index=
=E2=80=99 field.
> > > > After compaction is completed, use madvise(MADV_DONTNEED) on the
> > > > secondary mapping to free any remaining pages.
> > > >
> > > >
> > > > Thanks,
> > > > Lokesh
> > > >
> > >
> > > --
> > > Peter Xu
>
> Thanks,
>
> --
> Peter Xu
>
