Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDB6FD207
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbjEIWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjEIWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 18:04:42 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9F4229
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 15:04:41 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-61b6a4233a1so59121556d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683669880; x=1686261880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkMWCTTdqslF6xurqfmIDIK6nKUV3PvEA0Tj1gMf8ZY=;
        b=WGUF6FWv4A9G0XT3CunG7k7Cu0dK+BqpnDHRziwALPVoIzX2TDmFDseCaiIgNOWt0C
         dN/zK5WK1QZO5CY2vkgJxRMvfOBazOfyqN1D4oO411bdvCqkEcqJN3VQYIx8pIEVv0Lz
         Ix2TUcV1cmpSmiemZGoZhwLZj/YYpolky15yN44W/mXDQKAprIE2wWOfiX7CZ+kcA5To
         fLrS2QBtf/pqCDiS6wHP9lbkyEhZb26yYAgsQ7346v5NSOLaqOk2WHzU82dEQwAw/VaQ
         ks9OkWSHZEio+zHqcK6wpo+L/1Yv2A9mXHazh9SCs7X7d6co1rR4ORIvLaCuKuNfZCBL
         Tkeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683669880; x=1686261880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkMWCTTdqslF6xurqfmIDIK6nKUV3PvEA0Tj1gMf8ZY=;
        b=XWaeFjZUrDq3+idzHy6o+ptgKwH8/E+6xIzYhllLL6ek+yI+1+nrdE0qxslAAgmioh
         C82F9SG5DmeNTDyAv+HvF6VUZu1Mj2b9t3jPtgLRYJnXb2EbzFBY731F46Jxv1VudCGR
         rGAUpLUgt05Q/epR2xmZsGfNQDXbcmL/sOH6jsE7akgg6zsIhHOE8/SQzIg9FiiwFg6J
         6XQa3WlVYQKDXyNbpJ0R9XPB46yyt6lFY+DYNVFi7FrgHPULZhVMGmhqCDzDgQQZW+Gm
         OaRZ/tFCVEbGgYUf+5S+3ykuggZvu9SCQq8qQN3s8WzhUZZycwXQ9b9rrnkdWPmHkQ7p
         7IOw==
X-Gm-Message-State: AC+VfDym06ww3ozq+59O/SfNspiJ7zxYGWO3wWk6tIF0JO7Nl1T0mg9r
        yjz56qsGhJ/sCfsDpz49I/0P4Pd+llegHqt8jDk=
X-Google-Smtp-Source: ACHHUZ7p8eMJoVKrr8QGzh2aTEIq9zqFzqaog3OgUjE/YvaL3i2yUfyT5U+G1gpF8pk3DJqZi2pOTN+kvcjvvHOQp2Q=
X-Received: by 2002:ad4:5961:0:b0:621:4551:c6dc with SMTP id
 eq1-20020ad45961000000b006214551c6dcmr1407759qvb.39.1683669880257; Tue, 09
 May 2023 15:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230505185054.2417128-1-nphamcs@gmail.com> <20230506030140.GC3281499@google.com>
 <20230508140658.GA3421@cmpxchg.org> <CAKEwX=MtunOe6A--SG3ud-gUFg3bXFJgG4csgwHeZFAEqjCgHg@mail.gmail.com>
 <20230509030030.GD11511@google.com> <20230509174401.GA18828@cmpxchg.org>
 <ZFqO0i4mWL508P0S@google.com> <20230509192401.GC18828@cmpxchg.org>
In-Reply-To: <20230509192401.GC18828@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 9 May 2023 15:04:29 -0700
Message-ID: <CAKEwX=OOuGa808JHYamhRrg+zE8d=pRLCqPz-4T0B2aNvsMLSA@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: move LRU update from zs_map_object() to zs_malloc()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023 at 12:24=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, May 09, 2023 at 11:20:02AM -0700, Minchan Kim wrote:
> > Hi Folks,
> >
> > On Tue, May 09, 2023 at 01:44:01PM -0400, Johannes Weiner wrote:
> > > On Tue, May 09, 2023 at 12:00:30PM +0900, Sergey Senozhatsky wrote:
> > > > On (23/05/08 09:00), Nhat Pham wrote:
> > > > > > The deeper bug here is that zs_map_object() tries to add the pa=
ge to
> > > > > > the LRU list while the shrinker has it isolated for reclaim. Th=
is is
> > > > > > way too sutble and error prone. Even if it worked now, it'll ca=
use
> > > > > > corruption issues down the line.
> > > > > >
> > > > > > For example, Nhat is adding a secondary entry point to reclaim.
> > > > > > Reclaim expects that a page that's on the LRU is also on the fu=
llness
> > > > > > list, so this would lead to a double remove_zspage() and BUG_ON=
().
> > > > > >
> > > > > > This patch doesn't just fix the crash, it eliminates the deeper=
 LRU
> > > > > > isolation issue and makes the code more robust and simple.
> > > > >
> > > > > I agree. IMO, less unnecessary concurrent interaction is always a
> > > > > win for developers' and maintainers' cognitive load.
> > > >
> > > > Thanks for all the explanations.
> > > >
> > > > > As a side benefit - this also gets rid of the inelegant check
> > > > > (mm =3D=3D ZS_MM_WO). The fact that we had to include a
> > > > > a multi-paragraph explanation for a 3-line piece of code
> > > > > should have been a red flag.
> > > >
> > > > Minchan had some strong opinion on that, so we need to hear from hi=
m
> > > > before we decide how do we fix it.
> > >
> > > I'd be happy if he could validate the fix. But this fixes a crash, so
> > > the clock is ticking.
> > >
> > > I will also say, his was a design preference. One we agreed to only
> > > very reluctantly: https://lore.kernel.org/lkml/Y3f6habiVuV9LMcu@googl=
e.com/
> > >
> > > Now we have a crash that is a direct result of it, and which cost us
> > > (and apparently is still costing us) time and energy to resolve.
> > >
> > > Unless somebody surfaces a real technical problem with the fix, I'd
> > > say let's do it our way this time.
> > >
> >
> > Sorry for being too late to review. The reason I insisted on it was
> > I overlookeded the bug and thought it was trivial change but better
> > semantic since zsmalloc provides separate API between allocation and
> > access unlike other allocators. Now, Nhat and Johannes provided it's
> > more error prone, I am totally fine with this fix and will live it
> > until the LRU writeback will move out of allocator.
> >
> > Sorry for wasting your time to hunt this bug down and thank you for fix=
!
> >
> > Acked-by: Minchan Kim <minchan@kernel.org>
>
> Thanks Minchan!
>
> Domenico is working on the LRU refactor right now, and should have
> patches for review soon. This will indeed get rid of all the zsmalloc
> warts and make our lives much easier going forward!

That's the dream! I look forward to Domenico's patches.
And thanks for the ack, Minchan!
