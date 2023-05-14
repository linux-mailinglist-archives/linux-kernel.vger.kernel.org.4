Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C7C701E3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 18:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjENQg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 12:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjENQg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 12:36:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80901FFE
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:36:55 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9dea9d0360so15557797276.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684082215; x=1686674215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBWcP1uPA3OIsbfU1KvktZzrMNra4U71Mvs8rlBQ/PU=;
        b=osQWDj6WtZHIk7QIInk/8M19Sj6Dp99HNoa66TTLnucIbcmNTREyxbrUtAqVIw1SUH
         rpPMVd17kdt7HW0CFK2u733H3qM1qZBYGWpOnOmrB3k0/+h06pwBxTgM+KKCiIMh0yp8
         2Oxf6/TTz6EzdthX8M7bRmoogRtnLB0Fz3BSsHGMGGIpPNl4wOaTckQJ8bJrKmhIN26N
         oqIRuGzTADUscL2FR9eXnezjjGZEKKJx9xT1YbBfkbskF61GUX/XJeewk0pxwnpM6igS
         /vDSLxOghMWPYkvjNix/5sNRkb9co4cg9+eTc4nk+oyHO6ocecZyFLwIgXUuNms3bpm2
         hG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684082215; x=1686674215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBWcP1uPA3OIsbfU1KvktZzrMNra4U71Mvs8rlBQ/PU=;
        b=ITglHIh4nI7cBClLG6nqlptRKh5566eM4A7VtqOA5WiJFOjUZsxpLZ/gaM7XDqC4UM
         hInPMig4+njCn6oJIpQSkHNHoitCSS8hURhNpIRsNWut9/UaW57a25FbtJK71YK97bgg
         7vAOG73RiNVLJjQ5eQgLAvQeZjBA5C3c36CFBRUIk6Naz3aU3iWsCIn2lzDR309fu9dr
         coOdQJ6W/TO0HpyiP8ifvVfk7O0382X6ZIPHMLIc6iZcVHnWRFEXrRvj26ie05EJQ/Gh
         6HLeUkLa1oVldmwfKpEW8XMIlRAhc/Dq1fRuhBKA4uvHhwdpBA3MWxG9Wz4PJxby59Lv
         u9JQ==
X-Gm-Message-State: AC+VfDzU4b+OBs2R8w+rH7qLJk2x6+h0kr9hzs+9rQesC5IUokRAqvfx
        oYJrG//N30qL97jux8Ni0JXrsbIxn8+fNXSSIZw3Iw==
X-Google-Smtp-Source: ACHHUZ7rqZP7o9VYMvl3Hi6MQfIdV8mVLALhb48EsCVuDSe6zT8UCAR3m4KGYY1WakPqUUCLtwvfp2jYtIB48J2EpVI=
X-Received: by 2002:a25:dc43:0:b0:b9e:6d83:7bcf with SMTP id
 y64-20020a25dc43000000b00b9e6d837bcfmr27130924ybe.27.1684082214884; Sun, 14
 May 2023 09:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <202305121642367753446@zte.com.cn> <CAJuCfpEC67SBGFSCOD9TykwE_BR2ax5+T4XUKhq_U=qBJttMgw@mail.gmail.com>
 <20230513094508.GC4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230513094508.GC4253@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Sun, 14 May 2023 09:36:43 -0700
Message-ID: <CAJuCfpGgUdFJfS_NXXDi=mzGJxa7qfNLV_UnV62nepbTzkszoQ@mail.gmail.com>
Subject: Re: [RESEND PATCH linux-next] sched/psi: avoid resetting the min
 update period when it is unnecessary
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     yang.yang29@zte.com.cn, mingo@redhat.com, axboe@kernel.dk,
        tj@kernel.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
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

On Sat, May 13, 2023 at 2:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Fri, May 12, 2023 at 10:56:02AM -0700, Suren Baghdasaryan wrote:
> > On Fri, May 12, 2023 at 1:42=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
> > >
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > >
> > > Psi_group's poll_min_period is determined by the minimum window size =
of
> > > psi_trigger when creating new triggers. While destroying a psi_trigge=
r, there
> > > is no need to reset poll_min_period if the psi_trigger being destroye=
d did not
> > > have the minimum window size, since in this condition poll_min_period=
 will
> > > remain the same as before.
> > >
> > > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > > Acked-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Hi Peter,
> > This is another psi-related patch that slipped through the cracks.
> > Could you please take it into your tree? The original one [1] had a
> > different title but the same code.
>
> It does not cleanly apply to tip/sched/core; could either of you rebase
> please?

Rebase is posted here:
https://lore.kernel.org/all/20230514163338.834345-1-surenb@google.com/
Thanks!

>
> Thanks!
