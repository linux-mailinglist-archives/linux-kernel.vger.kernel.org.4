Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F400D705CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 04:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjEQCOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 22:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjEQCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 22:14:23 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058F59CB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:13:52 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-33164ec77ccso61345ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 19:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684289631; x=1686881631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9H9xxY0IRCExY9H0nSI5ZkiuSsdqps+Roz6yPP7WfA=;
        b=rshD+IoTAeqt1ylgFUS6t+KhyG6Irx7kcgC3HeFkd7U21A71Qmq1wGP4Heqs1TyrUC
         RD58Q1x2mJ2EErmTXTA56YQmQJAYBDFoOLQgmt/E4R9VXFA8Br8/S/SvkbJOTbyYYz8b
         elnk0vUY5RroWJ5sW36rpHNpM99N3Z4GjcZ37ctYATRLVKC8ZSWkXQW8m++XxR7EV6No
         bMEoKVr+H1tTtWfxcmtj9rjIyiKXgBlyVd5G0H1F5BT85VVKdPQJY6ogi9hoYm9eQ/5Z
         YZA849oauL0LAwAoxKgEbZSwauNLnCppPcaiOCQeEnFOj3iAOd8Fn0ZIrtawBjcq6fg0
         eNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684289631; x=1686881631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J9H9xxY0IRCExY9H0nSI5ZkiuSsdqps+Roz6yPP7WfA=;
        b=dI08lv/AiJIXATgX3tmgZeCZxk5gQIAbss1xLQxrTEXqf5cJ3pcrr2871JK2KsyRe7
         awQUp5UDp4Znvsn2WrDLYWMLoZTklVn7JHk7e+FPpFHae8kA+Wyq5zHeksO2y1TUAvOm
         v7Ocmz1/GInPZ46io158p2cosxDwFzZVcHIiXjdYYk4toAmhk0SwMsl6jkyqL1jFmbXu
         fuu9R/ZKh84nC0zUK5y6834v9sVmcJScXaSZ80HI4KJRpDDsPS9p6CV7zKFLndovm9Md
         CEW8yEFZZjLgzkeJtg2ckb1s3A+67rNHjZ7F2T4HVcbNN2Si06Pt21Tc7HWRYEwdy1KN
         9PgA==
X-Gm-Message-State: AC+VfDzxhvgqAyVofJudim5ISDB3lYQprYonPZ4fOBrKeG8gR+dx6Ig0
        +gw8jyOEYu1axJnAXGMofwk4PurXgpNa+GU+/908nw==
X-Google-Smtp-Source: ACHHUZ6nP3vNUbS8Y+1y5SYoY+bj5/YtxVVRjlTpt6WH7z8whziPYI19nahZr4YBtm3V4uBd0oNOkf1nFEcsG+h7VUU=
X-Received: by 2002:a05:6e02:1523:b0:335:a48:f668 with SMTP id
 i3-20020a056e02152300b003350a48f668mr79515ilu.15.1684289631318; Tue, 16 May
 2023 19:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230512235755.1589034-1-pcc@google.com> <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGLLSYuedMsViDQG@google.com>
 <efd5fb89-4f60-bee1-c183-5a9f89209718@redhat.com>
In-Reply-To: <efd5fb89-4f60-bee1-c183-5a9f89209718@redhat.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 16 May 2023 19:13:40 -0700
Message-ID: <CAMn1gO55p_Vz0wrSqHxJ0nw_bncEyja8=mBedY29=8UdC3ejww@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before swap_free()
To:     David Hildenbrand <david@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 5:40=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 16.05.23 02:16, Peter Collingbourne wrote:
> > On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
> >> On 13.05.23 01:57, Peter Collingbourne wrote:
> >>> Commit c145e0b47c77 ("mm: streamline COW logic in do_swap_page()") mo=
ved
> >>> the call to swap_free() before the call to set_pte_at(), which meant =
that
> >>> the MTE tags could end up being freed before set_pte_at() had a chanc=
e
> >>> to restore them. One other possibility was to hook arch_do_swap_page(=
),
> >>> but this had a number of problems:
> >>>
> >>> - The call to the hook was also after swap_free().
> >>>
> >>> - The call to the hook was after the call to set_pte_at(), so there w=
as a
> >>>     racy window where uninitialized metadata may be exposed to usersp=
ace.
> >>>     This likely also affects SPARC ADI, which implements this hook to
> >>>     restore tags.
> >>>
> >>> - As a result of commit 1eba86c096e3 ("mm: change page type prior to
> >>>     adding page table entry"), we were also passing the new PTE as th=
e
> >>>     oldpte argument, preventing the hook from knowing the swap index.
> >>>
> >>> Fix all of these problems by moving the arch_do_swap_page() call befo=
re
> >>> the call to free_page(), and ensuring that we do not set orig_pte unt=
il
> >>> after the call.
> >>>
> >>> Signed-off-by: Peter Collingbourne <pcc@google.com>
> >>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> >>> Link: https://linux-review.googlesource.com/id/I6470efa669e8bd2f84104=
9b8c61020c510678965
> >>> Cc: <stable@vger.kernel.org> # 6.1
> >>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page me=
tadata on swap")
> >>> Fixes: 1eba86c096e3 ("mm: change page type prior to adding page table=
 entry")
> >>
> >> I'm confused. You say c145e0b47c77 changed something (which was after =
above
> >> commits), indicate that it fixes two other commits, and indicate "6.1"=
 as
> >> stable which does not apply to any of these commits.
> >
> > Sorry, the situation is indeed a bit confusing.
> >
> > - In order to make the arch_do_swap_page() hook suitable for fixing the
> >    bug introduced by c145e0b47c77, patch 1 addresses a number of issues=
,
> >    including fixing bugs introduced by ca827d55ebaa and 1eba86c096e3,
> >    but we haven't fixed the c145e0b47c77 bug yet, so there's no Fixes:
> >    tag for it yet.
> >
> > - Patch 2, relying on the fixes in patch 1, makes MTE install an
> >    arch_do_swap_page() hook (indirectly, by making arch_swap_restore()
> >    also hook arch_do_swap_page()), thereby fixing the c145e0b47c77 bug.
> >
>
> Oh. That's indeed confusing. Maybe that should all be squashed to have
> one logical fix for the overall problem. It's especially confusing
> because this patch here fixes the other two issues touches code moved by
> c145e0b47c77.

Maybe. It can sometimes be hard to reconcile "one logical change per
patch" with "bug requires more than one logical change to fix" though.
Fortunately in this case I think we have an approach that fixes the
bug in one logical change, with some followup patches to clean things
up.

> > - 6.1 is the first stable version in which all 3 commits in my Fixes: t=
ags
> >    are present, so that is the version that I've indicated in my stable
> >    tag for this series. In theory patch 1 could be applied to older ker=
nel
> >    versions, but it wouldn't fix any problems that we are facing with M=
TE
> >    (because it only fixes problems relating to the arch_do_swap_page()
> >    hook, which older kernel versions don't hook with MTE), and there ar=
e
> >    some merge conflicts if we go back further anyway. If the SPARC folk=
s
> >    (the previous only user of this hook) want to fix these issues with =
ADI,
> >    they can propose their own backport.
>
> Sometimes, it's a good idea to not specify a stable version and rather
> let the Fixes: tags imply that.

Yeah, but sometimes it's hard to say which way would be more
efficient. Either we spend time discussing why the version is
necessary or Greg spends time trying to apply patches to the wrong
trees because I wasn't more explicit...

Peter
