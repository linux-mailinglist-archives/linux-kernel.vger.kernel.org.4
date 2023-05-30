Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B82715B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjE3KHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjE3KGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:06:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B8AFC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:06:32 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6a6b9bebdso118775e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685441191; x=1688033191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeYQzy8I8pwOViOP/HJ+F7u2H1xbPr3lN5quU+4f7GI=;
        b=PgqzK/hDW97iHLuc12AnnGitFwZr9hSLSjrvf5dZrUtXqAUaJ6NBwun4VRCu4wjqxe
         x3Y5N5Nr/ki6Epm5adFpLENYX0/JuMy4YCdWhwU7I36XtDMQ6xDyqBaIVUUT9FIoqpbH
         TmBAZlSmRMWSpG1FkvwQ9GfuEuDLoQ29TkvSRyQZoa5oYQkCsq0nU3xPJqzjnm3DJAhk
         Fb8f7pg2FwiJdshufIpGD90dCMZEV7LaR8heyS+OwijLOEhWBF4NdvyGx8OY7/7b4M4s
         3MlBuQZDzMjsd6MY6L0F29A7PUAAoDzyVeuDL6h+aQB4uUuR4EpyBdHDjyB7xSpqgf+v
         ANLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685441191; x=1688033191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeYQzy8I8pwOViOP/HJ+F7u2H1xbPr3lN5quU+4f7GI=;
        b=GBCSWCOQWtZ1KAlTCo7mNUVCR+oVwx6It8P39BgZ7Jk3V5qjqZYsStl7XfS3XXS+OO
         74ithAUVWQUDYZH6AfGGmExCfSjXH33a2yEXXV1sLJ3kT+T4BHb0riH7y2o0IETaJw/C
         Fpo8SQsktjOlH/cLFCM+IPbvUTBEucRqYtzPLGMIaWlRYiQt72aaKYeBnZ9axo4Cc0uY
         uGrTxmY8SJOgX0cU9dh6IQ7f9yid2C1hpMFiXCIYgzle3ogvSpOx4eMaFTXquKVIT51h
         r0xgWOJ8AS8gTu2j8vbSExqYlQUvgR0kvBBir796X+foHNACRp7KBcOeviYGkx2JWyMj
         2biw==
X-Gm-Message-State: AC+VfDwJFiL8ZnxCW1ROfWZKrDSQKzCIDKogxEYxF2s5hG6M8teCf2B2
        jC6AjiGl/EJIiIfE7Xl1At9AcfYKA184EF1GO1iT4w==
X-Google-Smtp-Source: ACHHUZ7NrV4pTB41UQ3WcvwomdjUyc+xeV0U1MJWAY9A7nChiS5hLJNywDrIE7pO6g6O3L4ROeVzVY91r6QPreXdNQM=
X-Received: by 2002:a05:600c:1906:b0:3f1:9a3d:4f7f with SMTP id
 j6-20020a05600c190600b003f19a3d4f7fmr94999wmq.1.1685441190893; Tue, 30 May
 2023 03:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <5fa8dfeb-8eb6-0de0-a335-e0b4336c29e0@I-love.SAKURA.ne.jp>
 <20230529190526.65d13658@kernel.org> <CANn89iLpeeJN=QA80c1wZZ0TB+ptzKN_Hq4Cf27C-URvKKbd2Q@mail.gmail.com>
 <c17ff3ff-b3af-fea2-f75e-68cefbc90636@I-love.SAKURA.ne.jp>
In-Reply-To: <c17ff3ff-b3af-fea2-f75e-68cefbc90636@I-love.SAKURA.ne.jp>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 30 May 2023 12:06:19 +0200
Message-ID: <CANn89iJbQ8rO8Mr-OaUcfXpcKiWEupuaT931NOsphQ-8BuPs5w@mail.gmail.com>
Subject: Re: [PATCH] ref_tracker: add stack_depot_save() failure handling to ref_tracker_alloc()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
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

On Tue, May 30, 2023 at 11:52=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2023/05/30 16:22, Eric Dumazet wrote:
> >>> Therefore, assume that stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) fr=
om
> >>> ref_tracker_alloc() can silently fail, and emit "unreliable refcount
> >>> tracker." message.
> >
> > Note: I never assumed stack_depot_save() would enforce/use NOFAIL.
>
> Hmm, I misread this function.
>
>         if (gfp & __GFP_DIRECT_RECLAIM)
>                 gfp_mask |=3D __GFP_NOFAIL; // Or'ing to "gfp_mask" than =
"gfp".
>         *trackerp =3D tracker =3D kzalloc(sizeof(*tracker), gfp_mask); //=
 <=3D This is "gfp_mask".
>         tracker->alloc_stack_handle =3D stack_depot_save(entries, nr_entr=
ies, gfp); // <=3D This is "gfp".
>
> So, stack_depot_save(GFP_KERNEL | __GFP_NOFAIL) is not happening.

Yes.1

>
> Then, question becomes whether we want tracker->alloc_stack_handle !=3D N=
ULL or not.
> If tracker->alloc_stack_handle =3D=3D NULL is still useful, this patch wi=
ll be useless...
>

I think it is useful to have the tracker (as Jakub hinted).
It is better than nothing.
We even might be able to allocate memory later for the
free_stack_handle which could give us
developers enough clues for bug hunting.

Thanks.
