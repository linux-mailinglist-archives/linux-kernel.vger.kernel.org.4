Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E298E6F4921
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjEBR2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEBR2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:28:45 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26910CA
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:28:44 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-559f1819c5dso47812027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683048523; x=1685640523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kqzz+/GxncWIao9Bock5vwwaZbkqqeGi4SiiZlGw4u0=;
        b=uk5HHqrF+3xUFhy6LGfdRt3HWRbHBpYFpPilBiiA6uhDESt/dztgdL+iVfum5GV5Su
         14Yx0eRcvuTMtT43xEy0DA/tAwpgy/J1QbiP4UaHKrGpnnCNEgi/7TWQxLQApTNsTd16
         YZBZlhmXiWGuTNoXeBL52n4/ASZT+G5osIUz29dnI0roDnThHAIj/Q5oO0VAru1zeaGP
         vfuLP7VoFoQGs6GYPGsSRp/L64sBlV6S0qHo1z5xVFiQcAT1GLwzJ8vVVbMIh2H4zLyY
         JniQhfTu4iu5aYxMHjurDSGbPfXE80hefAljZgoaO1fAS5NlG4YI6EqvyJl3tPLi8mzd
         6XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048523; x=1685640523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kqzz+/GxncWIao9Bock5vwwaZbkqqeGi4SiiZlGw4u0=;
        b=UjlxCG0+ukYrmkugLucy84hMIUmAr0qo3n4o5zT1UVNjfh/lzLMiESCVN89xxsvB2z
         3Xu0leVWiax9L8R1hEgkkCKY54OGL665gKZJI9fG/ep2FE3viAjiinjV1M3sefIvIHFR
         lCa9M/wbCEnMWfueGOAQgxh4Lr3/oMDShRWj+/0G8d82ILIPwQDkABEM6rf737kxbYlx
         xJ0fTGFJowDQN1W7GCGvudiNHD7osQL0hOx97OkdGhq3L2IA7zyqg2p+144wMUuCmd/R
         +i3EpGk/jszbPOnBZYR0BMdS2Npz7CW2V05lnhU7iG6oxSHyQntRWrdYawWKJbePsINp
         Xz/A==
X-Gm-Message-State: AC+VfDxOI6pfdWO8IvXzXPvvbslOQbaNMLv2PRSjBNm7oqGCy2qxck12
        L44tjKZEHEMilB+o3d4dueLHoYlLVwPJcCUo8AMGug==
X-Google-Smtp-Source: ACHHUZ48aqhkA7yp8BublhhXvo++PeeFv3AjVerN6+MzQrUQkQ/KZrYSuc2yp69yL6GdfcwE1ICQ/9YD4wngQl1dQuE=
X-Received: by 2002:a05:6902:1148:b0:b97:f46:a2b8 with SMTP id
 p8-20020a056902114800b00b970f46a2b8mr22686282ybu.17.1683048523065; Tue, 02
 May 2023 10:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230303011346.3342233-1-surenb@google.com> <CAJuCfpHcgu5Cti0t+U=S1C5-0ZgebhxzrOnhDiSu5qCyuq5_Wg@mail.gmail.com>
 <CAJuCfpE_aB6KQZj6A0NTCcv09bJ26L1hECDho3M2OyiNoMfFEA@mail.gmail.com> <20230502172404.GI1597538@hirez.programming.kicks-ass.net>
In-Reply-To: <20230502172404.GI1597538@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 10:28:32 -0700
Message-ID: <CAJuCfpHLJGD8U3D_-fpK0njPwLGAZEXuDA9q9DGjd0Q6TxGSjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: remove 500ms min window size limitation for triggers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
        johunt@akamai.com, mhocko@suse.com, keescook@chromium.org,
        quic_sudaraja@quicinc.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Tue, May 2, 2023 at 10:24=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Tue, May 02, 2023 at 10:20:34AM -0700, Suren Baghdasaryan wrote:
> > On Thu, Mar 2, 2023 at 5:16=E2=80=AFPM Suren Baghdasaryan <surenb@googl=
e.com> wrote:
> > >
> > > On Thu, Mar 2, 2023 at 5:13=E2=80=AFPM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > > >
> > > > Current 500ms min window size for psi triggers limits polling inter=
val
> > > > to 50ms to prevent polling threads from using too much cpu bandwidt=
h by
> > > > polling too frequently. However the number of cgroups with triggers=
 is
> > > > unlimited, so this protection can be defeated by creating multiple
> > > > cgroups with psi triggers (triggers in each cgroup are served by a =
single
> > > > "psimon" kernel thread).
> > > > Instead of limiting min polling period, which also limits the laten=
cy of
> > > > psi events, it's better to limit psi trigger creation to authorized=
 users
> > > > only, like we do for system-wide psi triggers (/proc/pressure/* fil=
es can
> > > > be written only by processes with CAP_SYS_RESOURCE capability). Thi=
s also
> > > > makes access rules for cgroup psi files consistent with system-wide=
 ones.
> > > > Add a CAP_SYS_RESOURCE capability check for cgroup psi file writers=
 and
> > > > remove the psi window min size limitation.
> > > >
> > > > Suggested-by: Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
> > > > Link: https://lore.kernel.org/all/cover.1676067791.git.quic_sudaraj=
a@quicinc.com/
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > Acked-by: Michal Hocko <mhocko@suse.com>
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Forgot to change the --to field from Tejun to PeterZ.
> > > Peter, just to clarify, this change is targeted for inclusion in your=
 tree.
> >
> > I think this patch slipped through the cracks. Peter, could you please
> > take it into your tree?
>
> Sorry, yes, got lost. I'll go queue it for post -rc1. No urgency with
> this right?

Yes, I'll be merging it into Android branches counting on it making
upstream later on :) Greg will hate me for that but I'll survive.
Thanks!
