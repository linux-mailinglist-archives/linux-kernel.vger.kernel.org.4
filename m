Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C417077DB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjERCLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjERCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:11:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA39630F5;
        Wed, 17 May 2023 19:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26FFB64A49;
        Thu, 18 May 2023 02:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A693C4339B;
        Thu, 18 May 2023 02:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684375863;
        bh=E52TVkteomz/h6pUEBvlWgEUbOD2I9Bt/bs3FHGid+s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VdbOK9dZbsGcZ8+H5Jkf6/zdKQOX8dhO8VnlbEquipFI08HW9uiK4J8N2s/LEqMAd
         wu1FHBx+SAkq/09gTMKFhWGecYgNVIlxN9F35PxqL7k6vCNMLsvgFDj7+b5Jwe3BsH
         BkOrQSsMvmHjN2pdArq3pAZePD9kmdgLAOKIZIQhiU4muhwVebz2mX5MIrkXj4o42M
         sPc0xjBD/Gb8V450hiapssA1IH4rJ1KhlTI7eJQwxnh7EFgUu5Ulo2eRpsnArT21XR
         /yCIQAxNYTgXgRR4xLwr80H6l+IodIYC8624PHmFrLqJT2cKvfUueX2LZUQyXJo2/3
         5E5vlHrG/Dlcg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-510b4e488e4so2659002a12.3;
        Wed, 17 May 2023 19:11:03 -0700 (PDT)
X-Gm-Message-State: AC+VfDzkoSOz8QQMhL3PPb1Zdt5g1vXRv5BEfN31pHvz1ig8GhuaaEKW
        VsljrcRboUk5IAHw+zIcGRawclqJfrQCeIa9Frg=
X-Google-Smtp-Source: ACHHUZ4zGhL9FkpGlEvE/gBigliwX11Sx4WQab0+w6J0eH0UHxPZsndFA14XQdGdGpi5cbxysP3tT65Cfsr1rd0CS7Q=
X-Received: by 2002:a17:907:6d15:b0:96a:bfc:7335 with SMTP id
 sa21-20020a1709076d1500b0096a0bfc7335mr27608366ejc.53.1684375861787; Wed, 17
 May 2023 19:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <1683614971-10744-1-git-send-email-yangtiezhu@loongson.cn>
 <68984bbb-4ccc-51f8-7d4b-b1ae08a43c52@loongson.cn> <d1256c93-1c70-c3ff-de71-42405d336cac@loongson.cn>
In-Reply-To: <d1256c93-1c70-c3ff-de71-42405d336cac@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 18 May 2023 10:10:50 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5epE4yqT3RveoZSUxUy2AQMYn7xr554rXJNqrGWf3vuA@mail.gmail.com>
Message-ID: <CAAhV-H5epE4yqT3RveoZSUxUy2AQMYn7xr554rXJNqrGWf3vuA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Select HAVE_DEBUG_KMEMLEAK to support kmemleak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Youling Tang <tangyouling@loongson.cn>,
        Catalin Marinas <catalin.marinas@arm.com>,
        WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Huacai

On Tue, May 9, 2023 at 3:43=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> Cc: Jonathan Corbet <corbet@lwn.net>
>      linux-doc@vger.kernel.org
>
> On 05/09/2023 03:13 PM, Youling Tang wrote:
> > Hi, Tiezhu
> >
> > On 05/09/2023 02:49 PM, Tiezhu Yang wrote:
> >> We can see that DEBUG_KMEMLEAK depends on HAVE_DEBUG_KMEMLEAK after
> >> commit b69ec42b1b19 ("Kconfig: clean up the long arch list for the
> >> DEBUG_KMEMLEAK config option"), just select HAVE_DEBUG_KMEMLEAK to
> >> support kmemleak on LoongArch.
> >>
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>
> >> This is based on 6.4-rc1
> >>
> >>  arch/loongarch/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> >> index d38b066..1e64edd 100644
> >> --- a/arch/loongarch/Kconfig
> >> +++ b/arch/loongarch/Kconfig
> >> @@ -90,6 +90,7 @@ config LOONGARCH
> >>      select HAVE_ASM_MODVERSIONS
> >>      select HAVE_CONTEXT_TRACKING_USER
> >>      select HAVE_C_RECORDMCOUNT
> >> +    select HAVE_DEBUG_KMEMLEAK
> >>      select HAVE_DEBUG_STACKOVERFLOW
> >>      select HAVE_DMA_CONTIGUOUS
> >>      select HAVE_DYNAMIC_FTRACE
> >>
> >
> > At the same time, you need to modify the loongarch in arch-support.txt
> > to ok.
> >
> > BTW, we can submit a separate patch to modify the features already
> > supported by LoongArch.
> >
> > The following features are already supported in LoongArch.
> >
> > diff --git
> > a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> > b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> ...
> > diff --git a/Documentation/features/debug/kprobes/arch-support.txt
> > b/Documentation/features/debug/kprobes/arch-support.txt
> > index 8a77d62a42c5..aad83b57587a 100644
> > --- a/Documentation/features/debug/kprobes/arch-support.txt
> > +++ b/Documentation/features/debug/kprobes/arch-support.txt
> ...
> > diff --git a/Documentation/features/debug/kretprobes/arch-support.txt
> > b/Documentation/features/debug/kretprobes/arch-support.txt
> > index cf4723c5ac55..61380010a4a7 100644
> > --- a/Documentation/features/debug/kretprobes/arch-support.txt
> > +++ b/Documentation/features/debug/kretprobes/arch-support.txt
> ...
> > diff --git
> > a/Documentation/features/debug/stackprotector/arch-support.txt
> > b/Documentation/features/debug/stackprotector/arch-support.txt
> > index 71cd4ba18f7d..4c64c5d596f7 100644
> > --- a/Documentation/features/debug/stackprotector/arch-support.txt
> > +++ b/Documentation/features/debug/stackprotector/arch-support.txt
>
> Thank you, I have already prepared a patch to update the docs,
> but some more features will be added on LoongArch in the following
> merge window, I am not sure what is the proper time to send the
> following patch, maybe two months later, or right away, maybe
> Jonathan can give some suggestions.
>
> Documentation/features: Refresh LoongArch support files
>
> Run the refresh script [1] to document the recent feature additions
> on LoongArch.
>
> [1] Documentation/features/scripts/features-refresh.sh
>
> Thanks,
> Tiezhu
>
>
