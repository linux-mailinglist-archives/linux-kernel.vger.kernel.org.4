Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07F695208
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBMUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBMUjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:39:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A227C1284B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:39:08 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id i137so6989760ybg.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 12:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4qT7huLWH3xBc9w2Lw0FZ7sN5ty5lO9E/+HZ4g6C48=;
        b=GZerrGPz9L5aS4y4DzeGl4KhI3k/zt1Goa2EkKqjrIPms5dn8Zlhs0PNZsTlDs80gp
         mXaBpXC3b8LBWQWH727JmeIk3fQXpOlx7xWHQ7tglWzjW8OjyixRN/ctLscj7juKOl7F
         Ty2xuVImuJh2xkyfRzgJ+bFKkcgh1KRbQTqdRwaNKvsJKAZi6mqlArAu5DNaEqCFqkDJ
         X2LjaHAAvk64rNzDv3I0zkg/EmV2G3QTRT7C/Y0Bt0IMKanqBy3izPr54IXOsVvtMJaZ
         CQZtBWKICEvUrOCOjs0RjEjd/+h+zh/BIPTqu+qv2Iu1Y6prB45Lv4a2NV3bHPb8hOFv
         3bBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4qT7huLWH3xBc9w2Lw0FZ7sN5ty5lO9E/+HZ4g6C48=;
        b=TCGguemrhCx6ksomvP7O+phPXXQApMrvxXVcEhLLwFaqoO2fpiYAbdHRfOed3Q+4rq
         Kk5AsrQNm5+YvsbJEbJXb+D9GG0sea1UeaVsjswlmbb7ilurN6le93Rim5jRkADANQ2Z
         ndqxlvb1pJIymnascRfwcpADczvS7MEkXNWkc1GmViP/Yv6o5HABc5V2TyUd7YuGdrWZ
         kcDteV/j+ugyd+QPdq74/CkOwAwhIXgTQjkhjZLMkrCeXoZlleG6el8OoczkLer17+jo
         8w9GRiK6Syf86473Pyss01XDh18y0Cvi0limcWq1CMRNLrhyvDD3KWlgp5e6hn+XNfWP
         fLfA==
X-Gm-Message-State: AO0yUKVawtn0Xikd9x+tnve2gT0NmMpc4KB8DIveVx+BtEYb8+cP7WHk
        IeTQ8IJh2VgadIEAOL5KGG6XgcKs/JZ2c8oLgBEbmvoa
X-Google-Smtp-Source: AK7set+HiF3QrlhAhYWDAHEXRfOGMJmUeHtnsUfqtGMNqqqrUZFtAiYCSZ7EfkUpoMkTpCHD5MmfJculEimHJ8iSQfg=
X-Received: by 2002:a25:e907:0:b0:80b:b818:e841 with SMTP id
 n7-20020a25e907000000b0080bb818e841mr26357ybd.94.1676320747833; Mon, 13 Feb
 2023 12:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20230114001556.43795-1-vishal.moola@gmail.com>
 <20230114001556.43795-2-vishal.moola@gmail.com> <CGME20230213085312eucas1p2252fe07e3eadea5e2a80dfdd3aa96507@eucas1p2.samsung.com>
 <ff300770-afe9-908d-23ed-d23e0796e899@samsung.com> <3a3457b1-60bc-a97b-0042-432790d3bbbe@ghiti.fr>
 <Y+pcK41bagzzhgj+@casper.infradead.org> <707cd2b6-4350-4171-1e0c-f63ea5db7ece@ghiti.fr>
In-Reply-To: <707cd2b6-4350-4171-1e0c-f63ea5db7ece@ghiti.fr>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Mon, 13 Feb 2023 12:38:56 -0800
Message-ID: <CAOzc2pxqTRRfopZuxmTvvMhvS33DLfs_Yijss0wb8idKUVyV_g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/khugepaged: Convert release_pte_pages() to use folios
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 7:55 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Matthew,
>
> On 2/13/23 16:50, Matthew Wilcox wrote:
> > On Mon, Feb 13, 2023 at 04:28:05PM +0100, Alexandre Ghiti wrote:
> >> The issue lies here: before using pteval in pfn_folio(), we should test it.
> >> The following patch fixes the issue for me:
> > Thanks for debugging it.  I'd rather see this written as ...
> >
> >               pte_t pteval = *_pte;
> > +             unsigned long pfn;
> >
> > +             if (pte_none(pteval))
> > +                     continue;
> > +             pfn = pte_pfn(pteval);
> > +             if (is_zero_pfn(pfn))
> > +                     continue;
> > +             folio = pfn_folio(pfn);
> > +             if (folio_test_large(folio))
> > +                     continue;
> >               release_pte_folio(folio);
> >
> > makes sense?
>
>
> Sure, that's fine by me, I can send that or I'll add my tested-by on
> what you send, whatever suits you.

Thanks for debugging this! I'll send a fix patch using Matthew's
approach later today.

> Alex
>
>
> >
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index eb38bd1b1b2f..fef3414b481b 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -514,10 +514,12 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
> >>          while (--_pte >= pte) {
> >>                  pte_t pteval = *_pte;
> >>
> >> -               folio = pfn_folio(pte_pfn(pteval));
> >> -               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> >> -                               !folio_test_large(folio))
> >> -                       release_pte_folio(folio);
> >> +               if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval))) {
> >> +                       folio = pfn_folio(pte_pfn(pteval));
> >> +
> >> +                       if (!folio_test_large(folio))
> >> +                               release_pte_folio(folio);
> >> +               }
> >>          }
> >>
> >>          list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> >>
> >>
> >> @Marek: could you give it a try?
> >>
> >> I can send a separate patch if needed, let me know.
> >>
> >> Thanks,
> >>
> >> Alex
> >>
> >>
> >>>>                    if (!pte_none(pteval) && !is_zero_pfn(pte_pfn(pteval)) &&
> >>>> -                          !PageCompound(page))
> >>>> -                  release_pte_page(page);
> >>>> +                          !folio_test_large(folio))
> >>>> +                  release_pte_folio(folio);
> >>>>            }
> >>>> -  list_for_each_entry_safe(page, tmp, compound_pagelist, lru) {
> >>>> -          list_del(&page->lru);
> >>>> -          release_pte_page(page);
> >>>> +  list_for_each_entry_safe(folio, tmp, compound_pagelist, lru) {
> >>>> +          list_del(&folio->lru);
> >>>> +          release_pte_folio(folio);
> >>>>            }
> >>>>     }
> >>> Best regards
