Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD226FBB5A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbjEHXS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjEHXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:18:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42AC5FD2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:18:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3ef2f81a96cso54588021cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1683587896; x=1686179896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/T/3Ju9SHl8z4dLQUIePgnInKHbkru1zT7Bm+NgMbgE=;
        b=YjCqBe4H69i+u3EZfBSFGDslkoVk6ESjXBUsfo3bBJcSijKdyGbUw2rlbiF4Q2kltk
         KYlkUZmDfdRgdBkm2/wANH/1CdBPWyMJLePwEwQFoDTAm1UG7q3rKk2ZC60QrK6k4BoU
         d2E8i133QbGfRKji4irFPihLHJxCeL2NjM9J8oS/4plNfSwcfO5N/T2fTfkPEcBRs8eL
         LcE1LKtZTG/XZC+HMRqgifG0sPiE7hg0M/qtLpTyXdf/5gNv72NwYnjnlw8pgRmj8Y+F
         D3Cwc0BfCR2L9/A7farDfLgxef2rt2KAjj7bHiQeBamifpkuK665mjRwFBAHat2RI1hM
         qcmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683587896; x=1686179896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/T/3Ju9SHl8z4dLQUIePgnInKHbkru1zT7Bm+NgMbgE=;
        b=WKvL8jbqa8avHycO6ZVE86ru5jIIitWNbUNAMKJHFSIgXPXneAdu5YCaPHTpExMl46
         1LlY9tICrsFLH5SdiugMpaS1GY+vfenvvuLKNAVSqGgsUEJDgj10FcSsrpRMN4MLCuDs
         Y76EvyzAXsf3ccNl6wJYbRc48ApsZHZlWHPE0X0XDoVDOwV2Hamms0E8n4ix3MpV9Dh3
         MOcFZ4/vYgUR8DLWGXLrD2xVMnLSSs7Zn/d3tI4W6UaMXhrOnpxqfx/TlQ4yX0Lw+eWd
         rYgVvHC1PVw9i6Gk/tkaxcm1HszEIIORhvd+8d4KjCFT8dJHRqthvRMX7RfngDDgxEIr
         cL9w==
X-Gm-Message-State: AC+VfDzNSAPEJKWha8vGhB9TUuY7elA9qjrt2li6y3mEmk0g2TpSRc6S
        cCzuIP8oipuYWxyqGOXiBZWFqHoGkHBpDe8Wqlga9w==
X-Google-Smtp-Source: ACHHUZ6JYT/f+xJv653TO3g1x1rKedNi30qh/tkDkBep9kUsaxwnKE66YY9XdCW3vRn6BmH3IcrOLBUwksfg+O2m7Bs=
X-Received: by 2002:ac8:7e84:0:b0:3f0:a336:afc4 with SMTP id
 w4-20020ac87e84000000b003f0a336afc4mr15610437qtj.48.1683587896414; Mon, 08
 May 2023 16:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000258e5e05fae79fc1@google.com> <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
 <ZFlrbDft1QfMyIDc@casper.infradead.org> <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
 <ZFlvJEfs1ufh1UUD@casper.infradead.org> <CA+CK2bDC-FVv1tZg9MDn-N735Ak3OAtdZPf+LEYM-JHsO90YcQ@mail.gmail.com>
 <fa1dac7a-406e-30ea-6aba-ded2e0e871fa@redhat.com>
In-Reply-To: <fa1dac7a-406e-30ea-6aba-ded2e0e871fa@redhat.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 8 May 2023 16:17:39 -0700
Message-ID: <CA+CK2bAHbHHwLUoGJkz8n6mrM5dy7oMojeNksdVOMYn+qFYngA@mail.gmail.com>
Subject: Re: usbdev_mmap causes type confusion in page_table_check
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Ruihan Li <lrh2000@pku.edu.cn>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 3:46=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
>
> On 08.05.23 23:55, Pasha Tatashin wrote:
> > On Mon, May 8, 2023 at 2:52=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> >>
> >> On Mon, May 08, 2023 at 02:48:59PM -0700, Pasha Tatashin wrote:
> >>> On Mon, May 8, 2023 at 2:36=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> >>>>
> >>>> On Mon, May 08, 2023 at 05:27:10PM -0400, Pasha Tatashin wrote:
> >>>>>> static void page_table_check_set(struct mm_struct *mm, unsigned lo=
ng addr,
> >>>>>>                                   unsigned long pfn, unsigned long=
 pgcnt,
> >>>>>>                                   bool rw)
> >>>>>> {
> >>>>>>          // ...
> >>>>>>          anon =3D PageAnon(page);
> >>>>>>          for (i =3D 0; i < pgcnt; i++) {
> >>>>>>                  // ...
> >>>>>>                  if (anon) {
> >>>>>>                          BUG_ON(atomic_read(&ptc->file_map_count))=
;
> >>>>>>                          BUG_ON(atomic_inc_return(&ptc->anon_map_c=
ount) > 1 && rw);
> >>>>>>                  } else {
> >>>>>>                          BUG_ON(atomic_read(&ptc->anon_map_count))=
;
> >>>>>>                          BUG_ON(atomic_inc_return(&ptc->file_map_c=
ount) < 0);
> >>>>>>                  }
> >>>>>>                  // ...
> >>>>>>          }
> >>>>>>          // ...
> >>>>>> }
> >>>>>>
> >>>>>> This call to PageAnon is invalid for slab pages because slab reuse=
s the bits
> >>>>>> in struct page/folio to store its internal states, and the anonymi=
ty bit only
> >>>>>> exists in struct page/folio. As a result, the counters are incorre=
ctly updated
> >>>>>> and checked in page_table_check_set and page_table_check_clear, le=
ading to the
> >>>>>> bug being raised.
> >>>>>
> >>>>> We should change anon boolean to be:
> >>>>>
> >>>>> anon =3D !PageSlab(page) && PageAnon(page);
> >>>>
> >>>> No.  Slab pages are not elegible for mapping into userspace.  That's
> >>>
> >>> Sure, I can add BUG_ON(PageSlab(page)); to page_table_check_set.
> >>>
> >>>> all.  There should be a BUG() for that.  And I do mean BUG(), not
> >>>> "return error to user".  Something has gone horribly wrong, and it's
> >>>> time to crash.
> >>>
> >>>   It is just too easy to make slab available via remap_pfn_range(), b=
ut
> >>> I do not think we want to add BUG() into the remap function, otherwis=
e
> >>> we will break devices such as /dev/mem.
> >>
> >> Slab pages can't be mmaped.  Really, no matter what interface you're
> >> using.  page->_mapcount is necessarily incremented by mapping to
> >> userspace, and slab uses that space for its own purposes (and has
> >> for decades).  It's similar for page tables and other allocations that
> >> use PageType.
> >
> > Mapping random memory in /dev/mem can cause mapping slab pages in to
> > userspace, the page->_mapcount is not incremented (and other fields
> > are not accessed) in that case, as we are using VM_PFNMAP type VMA,
> > which does not access "struct page".
>
> We should be using vm_normal_page() to identify if we should be looking
> at the struct page or not, no?

For normal Kernel-MM operations, vm_normal_page() should be used to
get "struct page" based on vma+addr+pte combination, but
page_table_check does not use vma for its operation in order to
strengthen the verification of no invalid page sharing. But, even
vm_normal_page() can cause access to the "struct page" for VM_PFNMAP
if pfn_valid(pfn) is true. So, vm_normal_page() can return a struct
page for a user mapped slab page.

Pasha

>
> --
> Thanks,
>
> David / dhildenb
>
