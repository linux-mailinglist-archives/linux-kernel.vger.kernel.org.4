Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85905FEE19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJNMqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJNMqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 08:46:46 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B07171CF7;
        Fri, 14 Oct 2022 05:46:44 -0700 (PDT)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 29ECkQ7r016211;
        Fri, 14 Oct 2022 21:46:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29ECkQ7r016211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665751587;
        bh=zN/AXWNeagYYAtE2G3TViIkElDs6lMpDbqwareSf9lI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lWIQTsg0qRv696NJuWKA/1cYTbs9JnJsKk8BDzXey8b4xqscjmSVtJ5d6veugSPT6
         PdcMZUxFrYGV8PtgnL/vnXR2xLM+opA1yN5yB01cBdxtXclmlX69yIH2qgRSVddzfA
         aKJ1iw5d2qLsAniny9/sykjY/5C7U5lIarJoJ4IpODBvEO3WYUka8xvnDQB3+qSkCk
         BRs5PC4uUF74bellDGIQQcN3AaP6soLXm60bK8D64adkNgehD7LqOfrX+RxtKo92mo
         5pboD8f1aZ5JZ7/dp2ITqaoBUfzJnPdpROypmUsWpa3c/JEgKBvZIG3yDu7h2yf4+0
         raFGMXbVlRAPA==
X-Nifty-SrcIP: [209.85.167.169]
Received: by mail-oi1-f169.google.com with SMTP id p127so4242182oih.9;
        Fri, 14 Oct 2022 05:46:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf3THTFvDB5GgCdltDQ8TnzaKvODtzrlfihH9xdANf8lOV1XybrR
        51H43o67es0+BL8WM0mTSvWVz1H/ARyJGi0ML90=
X-Google-Smtp-Source: AMsMyM5P09MKYDRIgIUb0NTw/+Rg+bQDof5ANyR2X3+uJoOAFAp9fYzuOV//XoFxGuTWnRzIgh877YFqFsRfryhUHmY=
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id
 cj5-20020a0568081b8500b0034d8ce1d5b0mr7119723oib.194.1665751585616; Fri, 14
 Oct 2022 05:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASzGEiQfPTaLmhG4k7VAwB5yznd-VqWdJHEF2YjgSQTcA@mail.gmail.com>
 <20221014094930.GB13389@twin.jikos.cz> <20221014100617.GC13389@suse.cz>
In-Reply-To: <20221014100617.GC13389@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 14 Oct 2022 21:45:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASC05gBaQFqmYgXFQQfQBTfBDdZruedq9oY=9D5sSHnKg@mail.gmail.com>
Message-ID: <CAK7LNASC05gBaQFqmYgXFQQfQBTfBDdZruedq9oY=9D5sSHnKg@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.1-rc1
To:     dsterba@suse.cz
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 7:06 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Fri, Oct 14, 2022 at 11:49:30AM +0200, David Sterba wrote:
> > On Thu, Oct 06, 2022 at 11:29:44PM +0900, Masahiro Yamada wrote:
> > > Masahiro Yamada (35):
> > >       kbuild: remove the target in signal traps when interrupted
> > >       kbuild: add phony targets to ./Kbuild
> > >       kbuild: hard-code KBUILD_ALLDIRS in scripts/Makefile.package
> > >       kbuild: check sha1sum just once for each atomic header
> > >       kbuild: do not deduplicate modules.order
> > >       nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
> > >       kbuild: remove duplicated dependency between modules and modules_check
> >
> > This patch merged as f75a03340c2c2eea772e4d59412135021afea493 breaks
> > build of modules when it's specified by path like 'make fs/btrfs/'. The
> > 'make M=fs/btrfs' works but I don't see any reason why the former should
> > stop working. Also the patch does not mention anything like that so it's
> > most likely a bug.
>
> Sorry, it must be a different commit, the build works on that one.
> Here's the full bisect log:
>
> # bad: [9c9155a3509a2ebdb06d77c7a621e9685c802eac] Merge tag 'drm-next-2022-10-14' of git://anongit.freedesktop.org/drm/drm
> # good: [4fe89d07dcc2804c8b562f6c7896a45643d34b2f] Linux 6.0
> git bisect start 'master' 'v6.0'
> # good: [7171a8da00035e7913c3013ca5fb5beb5b8b22f0] Merge tag 'arm-dt-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> git bisect good 7171a8da00035e7913c3013ca5fb5beb5b8b22f0
> # good: [bdc753c7fcb4eb009ae246a188ea7ac6dac98ce1] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect good bdc753c7fcb4eb009ae246a188ea7ac6dac98ce1
> # bad: [27bc50fc90647bbf7b734c3fc306a5e61350da53] Merge tag 'mm-stable-2022-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> git bisect bad 27bc50fc90647bbf7b734c3fc306a5e61350da53
> # bad: [d4013bc4d49f6da8178a340348369bb9920225c9] Merge tag 'bitmap-6.1-rc1' of https://github.com/norov/linux
> git bisect bad d4013bc4d49f6da8178a340348369bb9920225c9
> # good: [e572410e47a4e9647d5d7a49ca699a1497378707] Merge tag 'signal-for-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace
> git bisect good e572410e47a4e9647d5d7a49ca699a1497378707
> # good: [52abb27abfff8c5ddf44eef4d759f3d1e9f166c5] Merge tag 'slab-for-6.1-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
> git bisect good 52abb27abfff8c5ddf44eef4d759f3d1e9f166c5
> # bad: [8afc66e8d43be8edcf442165b70d50dd33091e68] Merge tag 'kbuild-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
> git bisect bad 8afc66e8d43be8edcf442165b70d50dd33091e68
> # good: [b520410654103086ccc0d339c0ff645d4c4dd697] Merge tag 'printk-for-6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux
> git bisect good b520410654103086ccc0d339c0ff645d4c4dd697
> # bad: [26ef40de5cbb24728a34a319e8d42cdec99f186c] kbuild: move .vmlinux.objs rule to Makefile.modpost
> git bisect bad 26ef40de5cbb24728a34a319e8d42cdec99f186c
> # bad: [a55f283e8b473a3124705934a17d0ad61e34e6c1] kbuild: generate include/generated/compile.h in top Makefile
> git bisect bad a55f283e8b473a3124705934a17d0ad61e34e6c1
> # good: [e30d448754284d6c7580b8f330e257e9801bec76] nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
> git bisect good e30d448754284d6c7580b8f330e257e9801bec76
> # bad: [7f37181393a9aaa695187701bb38f356df1f1cf8] kbuild: move 'PHONY += modules_prepare' to the common part
> git bisect bad 7f37181393a9aaa695187701bb38f356df1f1cf8
> # bad: [f110e5a250e3c5db417e094b3dd86f1c135291ca] kbuild: refactor single builds of *.ko
> git bisect bad f110e5a250e3c5db417e094b3dd86f1c135291ca
>
> f110e5a250e3c5d "kbuild: refactor single builds of *.ko"
>
> that looks plausible but reverting the commit does not make it work.


Right. Thanks for the report.

I will send a fix.





-- 
Best Regards
Masahiro Yamada
