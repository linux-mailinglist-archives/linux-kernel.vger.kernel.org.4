Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61B6E2DD2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDOALk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 20:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 20:11:38 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B8B30F1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:11:37 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54fe82d8bf5so56448267b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 17:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681517496; x=1684109496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkqxULQtn4DIJOtRxa3hlJU5+U6gyzkzztKjrzetxVg=;
        b=zdoB0mdUNyfPlFSNxAx/BADkB/3lor90AD9J36jsD506YnwDQWWxHmVMDjws2daMHm
         xXN42LbjEO3t8Y0mdMJLK0+W50JgJ06UG6ouln0nlkugLeWkGLowddhz45VWNTv2sv2u
         2bdafVDN5DFrD7sX6TfV1hVvhd0q0agKiuoPn5000fFv96HM+Jo1IG3XgJsA0uc00IwF
         5Te/cZRyGJLej0wx8ytcXdLA6WpQl1mUVbbwXWW1eNCXRkFB279QcpvBDwZFicpKFLBq
         mrWDDLaeWD8T+qEnXDzDhoeJJucJ5hoyjuAWixt+UAYuExU2N9udfHYtZO7T1Q+TNSvs
         3vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681517496; x=1684109496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkqxULQtn4DIJOtRxa3hlJU5+U6gyzkzztKjrzetxVg=;
        b=jX+lMII+/mTZ4+7ZOZvgEeSPGmiZmZrH3WUozOrlmEmzyJPEzlfQKM1bn5l11j5PbL
         uewcZ0CL4R/0EswepzyG7yUfgLykOM2UXt87vVqcsVCheocy7WOU/L34N6BnpuWzpJj8
         Y3qg+MapY/6pHQjhYOODK9T/aGNalatPt2T4Gnv4Ci2D9pWUlAYb2P4/DKo1wupIlPxO
         YxYP9herV6b+slKn7oZH1Cl0tRaSZopH64t7vp1Eew9MqY+NGPSIN2bU/iIxo5JoUwE4
         xYcM3NY0GbH76Ok68nodUA11JMPU+lDh5uMCWk6KILoRwh8aKPCC8Dt6YyMIzRJjuRns
         ItiQ==
X-Gm-Message-State: AAQBX9dbTTIU/S5ygf0sVmsi1rZh72gnQ0eMHu3R5xTRuCK9erLW5P7H
        1x+jd3jfxtHi/VbNhkdG2zzo3LNNoDvtWJBzJYx9NQ==
X-Google-Smtp-Source: AKy350bXqXiGeg20GRVRaHp2m6a8mhdFkoYmH1mDor76YCRhrh44NmwQi4o+xPPJ0nIgpV3b9dvxqvWA6P+uaDqiNVs=
X-Received: by 2002:a81:d441:0:b0:54f:a60c:12eb with SMTP id
 g1-20020a81d441000000b0054fa60c12ebmr4685300ywl.1.1681517496387; Fri, 14 Apr
 2023 17:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230414175444.1837474-1-surenb@google.com> <ZDnJ1dOU2tpK6l68@x1n>
 <CAJuCfpFc2SohkkJnEFqZD-uCpSS9sUzToPcQXOR6dHTTE0Ty5w@mail.gmail.com>
 <ZDnVETTFus3BFLxH@x1n> <CAJuCfpH278ozvhz=z4W0d6TxY6HhrORbsBPFM5d4x1M=EM23WQ@mail.gmail.com>
In-Reply-To: <CAJuCfpH278ozvhz=z4W0d6TxY6HhrORbsBPFM5d4x1M=EM23WQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 14 Apr 2023 17:11:25 -0700
Message-ID: <CAJuCfpExSdUgB6YV=k7UECnfgFJwQi-CHK6sRmJyc3OGx3GFwQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: do not increment pgfault stats when page fault
 handler retries
To:     Peter Xu <peterx@redhat.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, hannes@cmpxchg.org,
        mhocko@suse.com, josef@toxicpanda.com, jack@suse.cz,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        michel@lespinasse.org, liam.howlett@oracle.com, jglisse@google.com,
        vbabka@suse.cz, minchan@google.com, dave@stgolabs.net,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
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

On Fri, Apr 14, 2023 at 4:49=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Fri, Apr 14, 2023 at 3:35=E2=80=AFPM Peter Xu <peterx@redhat.com> wrot=
e:
> >
> > Hi, Suren,
> >
> > On Fri, Apr 14, 2023 at 03:14:23PM -0700, Suren Baghdasaryan wrote:
> > > > It also already ignores invalid faults:
> > > >
> > > >         if (ret & (VM_FAULT_ERROR | VM_FAULT_RETRY))
> > > >                 return;
> > >
> > > Can there be a case of (!VM_FAULT_ERROR && VM_FAULT_RETRY) - basicall=
y
> > > we need to retry but no errors happened? If so then this condition
> > > would double-count pagefaults in such cases.
> >
> > If ret=3D=3DVM_FAULT_RETRY it should return here already, so I assume
> > mm_account_fault() itself is fine regarding fault retries?
> >
> > Note that I think "ret & (VM_FAULT_ERROR | VM_FAULT_RETRY)" above means
> > "either ERROR or RETRY we'll skip the accounting".
> >
> > IMHO we should have 3 cases here:
> >
> >   - ERROR && !RETRY
> >     error triggered of any kind
> >
> >   - RETRY && !ERROR
> >     we need to try one more time
> >
> >   - !RETRY && !ERROR
> >     we finished the fault
>
> After looking some more into mm_account_fault(), I think it would be
> fine to count the faults which produced errors. IIUC these counters
> represent the total number of faults, not the number of valid and
> successful faults. If so then I think simply using VM_FAULT_RETRY
> should be ok without considering all possible combinations. WDYT?

I posted v2 at https://lore.kernel.org/all/20230415000818.1955007-1-surenb@=
google.com/
Hopefully it's closer to what we want it to be.

>
> >
> > I don't think ERROR & RETRY can even be set at the same time so I assum=
e
> > there's no option 4) - a RETRY should imply no ERROR already, even thou=
gh
> > it's still incomplete so need another attempt.
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
