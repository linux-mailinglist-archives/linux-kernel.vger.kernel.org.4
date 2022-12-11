Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5099649425
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiLKMPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiLKMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:15:17 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB41C101D2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:15:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id p8so14101321lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 04:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOhALRV4kIXQtDuec85LwjS+txHnrUdN4lz3sSZ1Kow=;
        b=pFgEVlKrn38h185ryrDFIHm5vLdnfGxbSer3Ad9rFv8+1LjEBxqHRrXwLX0HljIQvD
         2itoAYfxbsH/di3hvDqoKlAQk83H1Wz19qwRjCwHT3lSRX7IkeorbuLx6cA7yPOqIGve
         3M3W3AwP70wV96U9/Us7hykA2txPuwzWlaoc47ha3eQ/NzeRrOh5DrfMZ72aFgecj3B8
         znPMXE+NTyphmmttIjecMvHak2rHiqLq34g9xnghpm7x4c3fRT+T/Tid2e5h8ER80SOW
         esD3eLmk8XV1gZ6XqKEJafd7FGg4KXzl6nQr7XdUpxZMUqIhrE+5FPE0ppQJ4wwN/Kxt
         B8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOhALRV4kIXQtDuec85LwjS+txHnrUdN4lz3sSZ1Kow=;
        b=ybklRi2CwM56QF44VtHmhFn3VMdd95vO9QRX/xhXp8TmYRCP+k5sWHTkGyZZRMPUfE
         Gkxsm686HHjgwDsSc+nnMLrBSmP69GH5TyXT1iKH90qV88vugTiijEi9ayLSPGgRaLWr
         EeCBwPW13EkjUhxkgyZhS+ZOEJqfDt+ohu2zyCGVdxw5E3z+SJF5O83nEd4gRAIO6BRK
         J4ZViydSyVj9mbxtc3lROy6BzPZIBOEbJf3xfIFNgs494qwXvufZ0pYBU5F3IrxIPq9b
         WNb/doGtPi1MfCcQQ1K7dTehMMJbuitZ1/duYrKKujcYuPmJCWA9tK/pLbZZqHolmI2v
         GEpg==
X-Gm-Message-State: ANoB5pkB+mdWROMeg2tVwmeYpYwMjqWrI5FhjCh3raDL8KBJky+dIKNK
        nHIu5AWe/boB2pgDLG6kvl79j3Ngj+0hufFpPJ8=
X-Google-Smtp-Source: AA0mqf5jPAFnPr2un53wnN+aLvpEv6xqjnphA9/FSw5xqMFs7A5mXyjJQc1aFBHzjE9WbxIblU1wS0qm9z1eMTrF1+k=
X-Received: by 2002:a05:6512:1285:b0:4b6:e35b:3622 with SMTP id
 u5-20020a056512128500b004b6e35b3622mr312434lfs.325.1670760914797; Sun, 11 Dec
 2022 04:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221208180209.50845-1-ryncsn@gmail.com> <20221208180209.50845-6-ryncsn@gmail.com>
 <Y5I3lSfsTmZ6tlJk@casper.infradead.org> <CAMgjq7AuY_oi9Rw2r8rnA_tr7NeEXAd0OgZ4sNz4CiVV+2i9Rg@mail.gmail.com>
 <87edt6qhay.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edt6qhay.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Kairui Song <ryncsn@gmail.com>
Date:   Sun, 11 Dec 2022 20:15:02 +0800
Message-ID: <CAMgjq7Dk9gT_+SBo_ibQcuVryCfg0+pq2_B000ccnzocvdr89A@mail.gmail.com>
Subject: Re: [PATCH 5/5] swap: avoid ra statistic lost when swapin races
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang, Ying <ying.huang@intel.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8811=E6=
=97=A5=E5=91=A8=E6=97=A5 20:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > Matthew Wilcox <willy@infradead.org> =E4=BA=8E2022=E5=B9=B412=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 03:14=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >
> > Hi, thanks for the review.
> >
> >> On Fri, Dec 09, 2022 at 02:02:09AM +0800, Kairui Song wrote:
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > __read_swap_cache_async should just call swap_cache_get_folio for tr=
ying
> >> > to look up the swap cache. Because swap_cache_get_folio handles the
> >> > readahead statistic, and clears the RA flag, looking up the cache
> >> > directly will skip these parts.
> >> >
> >> > And the comment no longer applies after commit 442701e7058b
> >> > ("mm/swap: remove swap_cache_info statistics"), just remove them.
> >>
> >> But what about the readahead stats?
> >>
> >
> > Shouldn't readahead stats be accounted here? __read_swap_cache_async
> > is called by swap read in path, if it hits the swap cache, and the
> > page have readahead page flag set, then accounting that readahead
> > should be just the right thing todo. And the readahead flag is checked
> > with folio_test_clear_readahead, so there should be no issue about
> > repeated accounting.
> >
> > Only the addr info of the swap_readahead_info could be updated for
> > multiple times by racing readers, but I think that seems fine, since
> > we don't know which swap read comes later in case of race, just let
> > the last reader that hits the swap cache update the address info of
> > readahead makes sense to me.
> >
> > Or do you mean I should update the comment about the readahead stat
> > instead of just drop the commnet?
>
> __read_swap_cache_async() is called by readahead too
> (swap_vma_readahead/__read_swap_cache_async).  I don't think that it's a
> good idea to do swap readahead operation in this function.

Ah, I got it.
Thanks for pointing out the issue, I'll drop this patch.

>
> Best Regards,
> Huang, Ying
