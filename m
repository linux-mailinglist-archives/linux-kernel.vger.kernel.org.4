Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6172A6A0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjFIXN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 19:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjFIXN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 19:13:28 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9E2733
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:13:27 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc4651e3838so60475276.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 16:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686352406; x=1688944406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tNcpfuKwkWgK3IRRAlBYgLVqh/K/TL7K2asXg32HVwg=;
        b=BVvFdC6p8vxXeRH8ZFXVCbHgtvRrhfleqsquUfyLcJhRNXZFUS+msV4JPOF071/MbD
         rsTJfNyPdvssmkBfz8bMNfgYX8GDdHCnOCcvt9ZxBMu1X03h0vsuM1fT9deZJru4z+Ce
         yq29ysNYc0qu91HRckXgRt8bSEFg8nQTPLBAniErHWfHC6VwdBMp18JAYb+mjGKAwKEg
         MWbtpf7Ck4PlxuDl15sCuMfnDbh0zgzmrF49Fp1tOATz8EfHMIBwh2QHsONaS4JM50Zh
         5BD5XE8wLS9uGnxtRAZ8fHkKB7LATnva7EAkhSj0JugabycgaZ41IIqXFk6TofqXqxRn
         FGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686352406; x=1688944406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tNcpfuKwkWgK3IRRAlBYgLVqh/K/TL7K2asXg32HVwg=;
        b=jlHmsxECa5VEZYKDlmp1oB35zqToxHnQ5oJGKDJqBVP8/9OzUNdeWDtec7wpk5tfh9
         NrMKU0UyT4/xPFb+w0YjNPtfHM0LQy/bqli6SUU/t568DaZTOLnK9ZGeyPH9xAry8Cg4
         ngeIcS8suEmKmwx7FG17tmnG7/slpnO7b2o1DixHOLlxcwe6QSoKdmX2NbPhW/rZe0HD
         x2ryKFxMtbX9lTVY2rVPfgnj8Fof12LQyJ+I9+Q41EWZQ5Qnj7O+BEqx3t1OI2tzCu4Z
         30T4aGWTUYDaFPn3/YqVIJxWmTLNLZnR+XUXi1UVVxivCUMYoM4/FDtJfixOUKdgXwzy
         eMXw==
X-Gm-Message-State: AC+VfDx2S3s2GMBPpqB2uj0a+QNG2BtzkfDGGYvuD9y4qhcosOQa4l2m
        /p2fFiI/Md4AZEE41wQa9g8xpADhmvCKz338jWZ96w==
X-Google-Smtp-Source: ACHHUZ6Vqm4GjxxRug8nK9f0XXqMuqXKUc1gR5uhPb44ljDWuyyyVbqOqn+TE5wPgpyhH93fIv8CIt32lVuIs/gk+Mg=
X-Received: by 2002:a25:add3:0:b0:bb3:a945:96cd with SMTP id
 d19-20020a25add3000000b00bb3a94596cdmr2302585ybe.50.1686352406080; Fri, 09
 Jun 2023 16:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <1685531374-6091-1-git-send-email-quic_charante@quicinc.com>
 <20230531221955.GD102494@cmpxchg.org> <230e45e8-8cd8-3668-bbfa-a95212b4cb99@quicinc.com>
 <20230605180013.GD221380@cmpxchg.org> <f3f15b6a-8618-f755-f21c-4193c502e65c@quicinc.com>
 <CAJuCfpFB33GLbwvYspg966b6AGMopS3ca68hjL94kgpM7et7CQ@mail.gmail.com> <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
In-Reply-To: <4543c4e5-43f1-bae2-245e-951437e4bd07@quicinc.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 9 Jun 2023 16:13:14 -0700
Message-ID: <CAJuCfpE42OJZur-1u2hvvXmPkRdV1uOfK-Aqm2POmvrDpRwg0Q@mail.gmail.com>
Subject: Re: [PATCH] mm: madvise: fix uneven accounting of psi
To:     Charan Teja Kalla <quic_charante@quicinc.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        minchan@kernel.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org,
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

On Fri, Jun 9, 2023 at 5:42=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Suren & Johannes,
>
> On 6/7/2023 1:18 AM, Suren Baghdasaryan wrote:
> > Hi Folks. Sorry for being late to the party.
> > Yeah, userspace does not have a crystal ball to predict future user
> > behavior, so there will always be pathological cases when usual
> > assumptions and resulting madvise() would make things worse.
> >
> > I think this discussion can be split into several questions/issues:
> > 1. Inconsistency in how madvise(MADV_PAGEOUT) would affect PSI
> > calculation when the page is refaulted, based on the path it took
> > before being evicted by madvise(). In your initial description case
> > (a) is inconsistent with (b) and (c) and it's probably worth fixing.
> > IMHO (a) should be made consistent with others, not the other way
> > around. My reasoning is that page was expelled from the active list,
> > so it was part of the active workingset.
> >
> That means we should be setting Workingset on the page while it is on
> the active list and when it is being pageout through madvising. Right? I
> see, this makes it consistent.

This was my opinion but others might think otherwise, like I found out
in some recent conversations. So, it would be great to get some more
feedback before making the change.

>
> On the same note, discussing with Suren offline, Should the refaulted
> madvise pages start always at the inactive list? If they are really
> active, they get promoted anyway..
>
> > 2. Whether refaults caused by incorrect madvise(MADV_PAGEOUT) should
> > be counted as workingset refault and affect PSI.
> > This one I think is trickier. IMHO it should be counted as workingset
> > refault simply because it was refaulted and it was part of the
> > workingset. Whether it should affect PSI, which is supposed to be an
> > indicator of "pressure" is, I think, debatable. With madvise() in the
> > mix, refault might happen without any real memory pressure... So, the
> > answer is not obvious to me.
> >
> > 3. Should refaults caused by incorrect madvise(MADV_PAGEOUT) be
> > distinguished from the ones which were evicted by kernel reclaim
> > mechanisms.
> > I can see use for that from userspace to detect incorrect madvise()
> > and adjust its aggressiveness. I think the API might get a bit complex
> > because of the need to associate refaults with specific madvise()/VMAs
> > to understand which hint was incorrect and adjust the behavior.
> > Instead what is the opinion about giving an MADV_PAGEOUT_INACTIVE
> interface which does operate on a page only If it is on the inactive
> list and !PageWorkingset ?

IOW you want a less aggressive mechanism which can be used by the
userspace to tell the kernel "I think these pages won't be used but
I'm not 100% sure, so drop them only if they are inactive"?
 I don't know how much that will help when the madvise() ends up being
wrong but maybe you can quickly experiment and tell us if the
difference is substantial?

>
> > Hope my feedback is useful and if we can improve Android's userspace
> > behavior, I'm happy to help make that happen.
> Thanks...
