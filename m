Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F96A5CFD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjB1QVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1QVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:21:45 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DCB4697;
        Tue, 28 Feb 2023 08:21:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2FD0CE1B1F;
        Tue, 28 Feb 2023 16:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D35C433D2;
        Tue, 28 Feb 2023 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677601301;
        bh=3MXLfPbl7l4GIon8GwWZ9ZNyQPmPp10GCzDl4XlmdU0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFFxcElxeaM3xgqeWRN/17EtKKqmQP2BX2ftetS2DQkYc+TB0B/8nGW5YUOw3pXEp
         JbtVI0oTRMW/sqWAoZ/5ag3QmgxB56mjSY9Ae1AtlS7gZx9YSTePhVfM5NKxmkyIiW
         /MLdgVpRMYv8qUq+gEsunwGTXiUicDIyBUGu3IGIqcZrAxQXVewjD1iqThvOJ3SOAj
         NjXGLYvgxt6+sucX3ehgiq5X0uoouKS1MdUHlAfjQKBRs5N+3gz09YDFmky0j7rXkG
         ZnlBLGvbeOobnH0Wy4jv4SNYu37s2Hrr3MZ09T+51/JchKDw14eki3e9sR2I8lGLln
         zxIAgkMSOPQaA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17264e9b575so11407666fac.9;
        Tue, 28 Feb 2023 08:21:41 -0800 (PST)
X-Gm-Message-State: AO0yUKUP/VxSGzmMG2W6UXs/3u3uCCrUomdbJRZ2dbI0MDtO5Z91eALS
        XmBeBD6uH0iW1CUTSj7mxWOtUD7ov6Sfxuvr/YQ=
X-Google-Smtp-Source: AK7set8aNF7M8qXuN+WFN1iJS7hXDYTKShkvdcyngYgxmS2Co5pwFT0R6SFV53VslS78g21HiGykS6hMXUnBTJ6Yhro=
X-Received: by 2002:a05:6870:c7a6:b0:171:8f59:3437 with SMTP id
 dy38-20020a056870c7a600b001718f593437mr888700oab.8.1677601300439; Tue, 28 Feb
 2023 08:21:40 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
 <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
 <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com>
 <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com> <CAHk-=wgM-W6Fu==EoAVCabxyX8eYBz9kNC88-tm9ExRQwA79UQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgM-W6Fu==EoAVCabxyX8eYBz9kNC88-tm9ExRQwA79UQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Mar 2023 01:21:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqtcFVP-8bJhhPiW86v8DqaXvxMNgK8wnuGbC+0bUXww@mail.gmail.com>
Message-ID: <CAK7LNAQqtcFVP-8bJhhPiW86v8DqaXvxMNgK8wnuGbC+0bUXww@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.3-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 2:26=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 27, 2023 at 9:08=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > So here's the simple rule: if the packaging people can't be bothered
> > to use "gti archive" to make their packages, then they had better just
> > do a "make clean" first (or, better yet, do "git clean -dqfx" to
> > really clean up, because "make clean" isn't 100% reliable either).
> >
> > We don't add more broken infrastructure to deal with broken workflows.
> > Just do the right thing.
>
> Note: I'm perfectly happy to just revert this, but if I have to do it,
> then pretty much _all_ the packaging changes get reverted, because I'm
> not going to be able to figure out which parts don't rely on the new
> broken script.
>
> So I'd rather take a more directed revert from you. Or, better yet,
> just a rewrite to do the right thing (ie "git archive").
>
> Because really - any distro packager had better have the git tree.

OK, let's go this way.

Please give me a few days.





>
>                    Linus



--=20
Best Regards
Masahiro Yamada
