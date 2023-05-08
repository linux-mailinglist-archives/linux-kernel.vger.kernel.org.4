Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851A96FBA51
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 23:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjEHV4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 17:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjEHV4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 17:56:21 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859FB4C1A
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 14:56:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f389c519e5so11595711cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 14:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1683582977; x=1686174977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4mzgv/y3OfYfwIc0/6GlRmAjz7CSTG9XA2gBScB7hY=;
        b=lykGcBFs/LGISWRbS6e916zC4DSVZBoV7zF2VTNqZTeWEF1p/vL4i48U5jn4B9fuVp
         rECBef+jTeQV0mPTRcR3ZdRpv+HGBHRfDppl2QvCBeyWZyyNKUeyt4MCQV1ztO3GyNSl
         JObpMeAYvZ9aBKRZHlpT33ZFyK+Zz1gI2bThrGaaiULBklE4v/MeUJUyDBN6jc21U4p8
         iLrk2B4dQ5GUW1fAJjpPnool1DJwfnTAeJ/faVm1jJjkgHTYKNLkzwk3mx8YQ6sxIG7c
         wvEIek1+U5jBpUeY9ajQZCm8xm2nyRw09BAEHbiC6WKD5FrktfDIMKtoSsBt5l+hgjyf
         OddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683582977; x=1686174977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V4mzgv/y3OfYfwIc0/6GlRmAjz7CSTG9XA2gBScB7hY=;
        b=YsDYiHtymh8UjID79o910QGGSGBzc4Dal3vTEp04jGgqvwiWDsZoDcaXzxYTdg68Qb
         obMrY7OANCj3TRBsIHExW6TRZ54pYVAnmznih6llKb51nSoMZVoHnxzB5Xz+YA8CdSHu
         VAZcx3VPy2pTxLgsfjPBVp5+uHeYFHHfL0qgK1E+f/6Aa35hBGoMXlYrlUYydD3FsPo3
         UlEAAqHjauJB1kk/iVJRk8vyyFZW33dTZVi2xWJq88wnaqDQLYzvbSi+UpVJD7udcB5U
         ryxaVb7zonHSK3d90WE6TA+CA+/PXF+urApJdev0MdpJqgAtvCIEpPxgFlEcPYQzSmsL
         MCSA==
X-Gm-Message-State: AC+VfDwaABKJGNEGLuKqi+RNXxD41uuWUwdfTlMGRW7oBI4mY+K4nyxi
        +pCE0JuyBXqDAtvlUbmkNPLt3XWZUZs+ewDN9899zQ==
X-Google-Smtp-Source: ACHHUZ70Q7luqF/zFtkwQXaYjHI+kxk2SoxZ+/DCsZhIgUHBDYbrgX+T93wMBA0hNzTZ0RZLab29r3MH+gRk0ljphH4=
X-Received: by 2002:a05:622a:1756:b0:3f2:28fd:c64d with SMTP id
 l22-20020a05622a175600b003f228fdc64dmr18597188qtk.40.1683582977630; Mon, 08
 May 2023 14:56:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000258e5e05fae79fc1@google.com> <20230507135844.1231056-1-lrh2000@pku.edu.cn>
 <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
 <ZFlrbDft1QfMyIDc@casper.infradead.org> <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
 <ZFlvJEfs1ufh1UUD@casper.infradead.org>
In-Reply-To: <ZFlvJEfs1ufh1UUD@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 8 May 2023 14:55:41 -0700
Message-ID: <CA+CK2bDC-FVv1tZg9MDn-N735Ak3OAtdZPf+LEYM-JHsO90YcQ@mail.gmail.com>
Subject: Re: usbdev_mmap causes type confusion in page_table_check
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ruihan Li <lrh2000@pku.edu.cn>,
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

On Mon, May 8, 2023 at 2:52=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Mon, May 08, 2023 at 02:48:59PM -0700, Pasha Tatashin wrote:
> > On Mon, May 8, 2023 at 2:36=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Mon, May 08, 2023 at 05:27:10PM -0400, Pasha Tatashin wrote:
> > > > > static void page_table_check_set(struct mm_struct *mm, unsigned l=
ong addr,
> > > > >                                  unsigned long pfn, unsigned long=
 pgcnt,
> > > > >                                  bool rw)
> > > > > {
> > > > >         // ...
> > > > >         anon =3D PageAnon(page);
> > > > >         for (i =3D 0; i < pgcnt; i++) {
> > > > >                 // ...
> > > > >                 if (anon) {
> > > > >                         BUG_ON(atomic_read(&ptc->file_map_count))=
;
> > > > >                         BUG_ON(atomic_inc_return(&ptc->anon_map_c=
ount) > 1 && rw);
> > > > >                 } else {
> > > > >                         BUG_ON(atomic_read(&ptc->anon_map_count))=
;
> > > > >                         BUG_ON(atomic_inc_return(&ptc->file_map_c=
ount) < 0);
> > > > >                 }
> > > > >                 // ...
> > > > >         }
> > > > >         // ...
> > > > > }
> > > > >
> > > > > This call to PageAnon is invalid for slab pages because slab reus=
es the bits
> > > > > in struct page/folio to store its internal states, and the anonym=
ity bit only
> > > > > exists in struct page/folio. As a result, the counters are incorr=
ectly updated
> > > > > and checked in page_table_check_set and page_table_check_clear, l=
eading to the
> > > > > bug being raised.
> > > >
> > > > We should change anon boolean to be:
> > > >
> > > > anon =3D !PageSlab(page) && PageAnon(page);
> > >
> > > No.  Slab pages are not elegible for mapping into userspace.  That's
> >
> > Sure, I can add BUG_ON(PageSlab(page)); to page_table_check_set.
> >
> > > all.  There should be a BUG() for that.  And I do mean BUG(), not
> > > "return error to user".  Something has gone horribly wrong, and it's
> > > time to crash.
> >
> >  It is just too easy to make slab available via remap_pfn_range(), but
> > I do not think we want to add BUG() into the remap function, otherwise
> > we will break devices such as /dev/mem.
>
> Slab pages can't be mmaped.  Really, no matter what interface you're
> using.  page->_mapcount is necessarily incremented by mapping to
> userspace, and slab uses that space for its own purposes (and has
> for decades).  It's similar for page tables and other allocations that
> use PageType.

Mapping random memory in /dev/mem can cause mapping slab pages in to
userspace, the page->_mapcount is not incremented (and other fields
are not accessed) in that case, as we are using VM_PFNMAP type VMA,
which does not access "struct page".

Pasha
