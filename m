Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE706E2C3B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 00:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjDNWCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjDNWCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 18:02:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC02D6D
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:02:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gc14so3963763ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681509749; x=1684101749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQuB9JCPITcGs+8HPntMmVSm61Ab+fnUpiW2TFHYHeE=;
        b=uQpTlspPi0frg0JzINki3uCSt7EQ5x2lIGx/Jr1wFzNrfNsbCmIQRvQ1hrsoNNfS/v
         XrYRntGvOyQ0xNt9Np4/jI341PIvSXRPeG0vSEapvvFhriZgmhSwv88FI1+oembfKq1V
         8qZMRetKAwhF+WHdW3t2T0O3P1dGMgypsnyxbx3nz3t8GnkY9Xt4AxTu3E1bYp8rwjZE
         HDnoXxe0Jl6cYzHLfNqBL7DxH1kGYLuoB5lfvGdYbj2Ea2gqsV7bGivkTM9nA5MmvR8U
         rV4iz/8fIzWcOJ1V5EkV/Phy+fwSK3o8vZ4Lb1yHWH1IUrHvpWHcHmNJ19h0jA7BokWT
         eCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681509749; x=1684101749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQuB9JCPITcGs+8HPntMmVSm61Ab+fnUpiW2TFHYHeE=;
        b=Nbzo+eCRycOI66PjdWRwWBsZ/xtxOsELUb9a5r3HU0Nm1U+drYd/KwuXnggXVSlujl
         qdJD9vE3MLb2w6k4JScD/FWFUBDoy+6rZj73OsufW7HC5P1eFC4wRXvnq+icsO/9HvUT
         Eri4J85e7B7jb2+MkXYSdxzb5ksgUOwPjVwplkosVlJBErVerfH/TJTxD7r5Ha1Xi49a
         kIUCYvXZPkg/r0yUPfJwl0C6GtS/ngbf1YUb/ZO/JrLfbV5oxiqdMvC7tN08Hf+g0O7P
         +FHdyrXr0pTLUaCM/fj+NJGQqFG+w5PvBQipAEtlI+5X/ebDSvNJLWuflZNPcD2HcKmP
         TADg==
X-Gm-Message-State: AAQBX9eQTMhMytg/1f48GRVd8+7E0mJLN14gBvCiH+42QCavJwmy/xXf
        HfOo+s4LMhLZBGFn9eRJ6RIOvA6H7zPNTZzJ94p5oA==
X-Google-Smtp-Source: AKy350Z2qGZgN2hDoy1aETuvpCsfxE3LE+VGFXIFcMKe6mqaUWE+80tTq89vHOsbH/LgewxQIexF0XRH53ySfc/n9e8=
X-Received: by 2002:a17:906:584e:b0:94e:e7cb:2cd5 with SMTP id
 h14-20020a170906584e00b0094ee7cb2cd5mr266468ejs.15.1681509748576; Fri, 14 Apr
 2023 15:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <CAPTztWYgRORXKp83Spm3DX8qJsi1rw5s=WbPcjUYfOxFXxRAwg@mail.gmail.com>
 <CAPTztWadceJtPUrSab1Tj2WV=uAhLo+CrxqyeSQ8rLn0FtM_zA@mail.gmail.com> <0853b4b0-770f-f742-95bc-eb74a1859138@quicinc.com>
In-Reply-To: <0853b4b0-770f-f742-95bc-eb74a1859138@quicinc.com>
From:   Frank van der Linden <fvdl@google.com>
Date:   Fri, 14 Apr 2023 15:02:17 -0700
Message-ID: <CAPTztWZ-PTmF=AazhCuC3u-Ca_mY+QsJGgMdu4W0DC05zk3-iA@mail.gmail.com>
Subject: Re: [PATCH V7 0/2] mm: shmem: support POSIX_FADV_[WILL|DONT]NEED for
 shmem files
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, willy@infradead.org,
        markhemm@googlemail.com, rientjes@google.com, surenb@google.com,
        shakeelb@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Fri, Apr 14, 2023 at 12:10=E2=80=AFPM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Frank!!
>
> On 4/14/2023 11:14 PM, Frank van der Linden wrote:
> >> I didn't see this patch before, so I looked a bit at the history. At
> >> some point, in v3, dealing with mapped pages for DONTNEED was left
> >> out, they are now skipped. Unfortunately, that makes this patch no
> >> longer usable for a case that we have: restoring the (approximate)
> >> swap state of a tmpfs file. This involves walking a potentially large
> >> number of regions, and explicitly pushing them out to swap. This can
> >> be used to e.g. restore the state VM memory that is backed by a tmpfs
> >> file, avoiding memory usage by cold VM pages after resume.
> >>
>
> This is an interesting use case and I feel this really supports this
> patchset. IIUC, supporting the reclaim of mapped file pages through
> fadvise() helps this usecase where you can avoid traversing the large
> number of vma regions as you can directly issue the fadvise() on the
> shmem file 'fd' and it takes care. Am I correct?

Right, that's correct. The only snag here is that fadvise, with your
patch set, will skip mapped pages, which might be an issue for this
case.

>
> > Hmm, actually, looking at it a bit more, there are several issues
> > here. One is that with fadvise, you can't be sure if you are the only
> > one dealing with the page in a mapped way(with madvise, if mapcount =3D=
=3D
> > 1, that mean's it's just you, but you don't know that for fadvise, so
> > that makes correctly dealing with mapped pages harder).
> >
> Sorry, Why not for fadvise()? I can still attempt only if the page is
> mapped and its mapcount =3D=3D 1, but then we already have madvise() for
> such pages and why not we simply use it.

Yes, you could use madvise (as I was thinking). One issue with that
is, though, that madvise(PAGEOUT) is based on a page table walk of
present PTEs. So you actually need to map and touch the page before
madvise will work, which is suboptimal. A direct fadvise solution
would be nicer, since that does a file mapping walk. However, that can
be addressed later, my comments weren't intended to raise an objection
- merely that there is a chance here to address this usecase. But that
shouldn't block anything. It's something to keep in mind, though.

I'll do some experiments to see what the best solution is here. But,
any follow-ups would be on top of your patch, so I'm not raising
objections, merely hoping that this, and possible extra work, could
solve this case.


- Frank
