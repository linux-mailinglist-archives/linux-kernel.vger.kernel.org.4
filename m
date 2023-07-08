Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F8074BBCD
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 06:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjGHEgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 00:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjGHEgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 00:36:22 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E601FE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 21:36:21 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-40371070eb7so75551cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 21:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688790980; x=1691382980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bMoIuIpswGrRuq9dBxbRgEGX82Nkz8Bwpi7t8SdLYA=;
        b=ADHRhJhT/5vEK4kj7EBAm2pdLgCCQJt9RXfUPplyGkER7We1CEm7aPlvzskKXFgHxF
         ys12yXkliKti5QLx1icUyYoh6jD8GBpxUXqRsfFVCKX53r5TUgmxDTzPltBh1KC33/y1
         Wv9I0YBvPB5QFmsQD7TuqY2Qg9YYg1O1QS5eW/x4me32FMaKdo6oIh6MGxBFEnd1gqj3
         ZnpBMMW3LmE0NTjfJRtVgP43ZRCve7J1QfuWej3v8xr3Odv7an5NHlanlYoVS4LSTuy1
         UFXqEDhVJQCBXkmfzBUrLnWv5zY8AKoAoMrgEOMF0GWUhB0DnvQIfVyNaLsVJt528BA3
         ClSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688790980; x=1691382980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bMoIuIpswGrRuq9dBxbRgEGX82Nkz8Bwpi7t8SdLYA=;
        b=aYKtmJQsKDU6+HJqUdPdef7/yrvZKpvYtCLH3yYP+3vOARoo+JnoRGEOJHaUqzHUUP
         RrhabxqA5w9I8kZLYtGEXtywZG8+9BI/DpXsfi8nvSYpx3CI+iMy9QE5wdmSF8LIRvdl
         4flfij0X73gblTd5rZaxJJkvCwzX4qF0/gFVoTJqgnvDe05fHnLCyXGGCvWlaXDqVEeU
         Au3vHXh75fhP2xJq/MPF3IlDDdE6dNqyvSMx8TYQy73F+eslsKqSdkobulJcCONUWLv/
         yXHnH89l/2hr6u5FLjd+eUBlNZAouIHOFA9jFLpGh6Nsj3ZSj3Vq9lMalQH18L7sKvi0
         /kTQ==
X-Gm-Message-State: ABy/qLY8J8zFGuFFsK7/wSyU8d0k2ffwkaykSfmYVKgBNUO1P1SMKLKV
        pAEmfzfXmbXSVVYTYFKVyOkeaOPN6ZklgCIuRPhUA+P59Qr47Jq96t2lx69F
X-Google-Smtp-Source: APBJJlFkxZr40QQ5uWEwLfm7Ew7kGZtfa9dIG55On+zG+yntGsOn1b2pvZB2Q2EBC8R9g0ygHo4sxW/kA6b2No9M8c8=
X-Received: by 2002:ac8:5dcf:0:b0:3f0:af20:1a37 with SMTP id
 e15-20020ac85dcf000000b003f0af201a37mr43542qtx.15.1688790980296; Fri, 07 Jul
 2023 21:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
 <ZKhK1Ic1KCdOLRYm@casper.infradead.org> <4bb39d6e-a324-0d85-7d44-8e8a37a1cfec@redhat.com>
 <ZKhiGLpIWi5Z2WnY@casper.infradead.org> <436cd29f-44a6-7636-5015-377051942137@intel.com>
 <ZKjfwYWh/n/LbTZv@casper.infradead.org>
In-Reply-To: <ZKjfwYWh/n/LbTZv@casper.infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Jul 2023 22:35:43 -0600
Message-ID: <CAOUHufbjiW00jd_DWanfW0ps1o8KstZYbvkbYcJia1L=jVojMw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ryan.roberts@arm.com,
        shy828301@gmail.com, akpm@linux-foundation.org
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

On Fri, Jul 7, 2023 at 10:02=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Jul 08, 2023 at 11:52:23AM +0800, Yin, Fengwei wrote:
> > > Oh, I agree, there are always going to be circumstances where we real=
ise
> > > we've made a bad decision and can't (easily) undo it.  Unless we have=
 a
> > > per-page pincount, and I Would Rather Not Do That.  But we should _tr=
y_
> > > to do that because it's the right model -- that's what I meant by "Te=
ll
> > > me why I'm wrong"; what scenarios do we have where a user temporarill=
y
> > > mlocks (or mprotects or ...) a range of memory, but wants that memory
> > > to be aged in the LRU exactly the same way as the adjacent memory tha=
t
> > > wasn't mprotected?
> > for manpage of mlock():
> >        mlock(),  mlock2(), and mlockall() lock part or all of the calli=
ng process's virtual address space into RAM, preventing that memory
> >        from being paged to the swap area.
> >
> > So my understanding is it's OK to let the memory mlocked to be aged wit=
h
> > the adjacent memory which is not mlocked. Just make sure they are not
> > paged out to swap.
>
> Right, it doesn't break anything; it's just a similar problem to
> internal fragmentation.  The pages of the folio which aren't mlocked
> will also be locked in RAM and never paged out.

I don't think this is the case: since partially locking a
non-pmd-mappable large folio is a nop, it remains on one of the
evictable LRUs. The rmap walk by folio_referenced() should already be
able to find the VMA and the PTEs mapping the unlocked portion. So the
page reclaim should be able to correctly age the unlocked portion even
though the folio contains a locked portion too. And when it tries to
reclaim the entire folio, it first tries to split it into a list of
base folios in shrink_folio_list(), and if that succeeds, it walks the
rmap of each base folio on that list to unmap (not age). Unmapping
doesn't have TTU_IGNORE_MLOCK, so it should correctly call
mlock_vma_folio() on the locked base folios and bail out. And finally
those locked base folios are put back to the unevictable list.

> > One question for implementation detail:
> >   If the large folio cross VMA boundary can not be split, how do we
> >   deal with this case? Retry in syscall till it's split successfully?
> >   Or return error (and what ERRORS should we choose) to user space?
>
> I would be tempted to allocate memory & copy to the new mlocked VMA.
> The old folio will go on the deferred_list and be split later, or its
> valid parts will be written to swap and then it can be freed.
