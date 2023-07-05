Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520EC747B60
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 04:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjGECAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 22:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjGECA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 22:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6C910F2;
        Tue,  4 Jul 2023 19:00:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66DC161419;
        Wed,  5 Jul 2023 02:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F17C433CA;
        Wed,  5 Jul 2023 02:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688522426;
        bh=LyIj0LgbZheKqVcxnc/9rbSxnPsiv0uraZX/A+7U2xU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sGHDbFXToOaFW2AuWUahZ4JDgj/O9GyYJpy7SbPYCgCVOUck1Zhf04iCgkChytAlJ
         YwpK2Nj74Gr60IoxXloe7qqMmXKEnZTL3E5BnzV5nIzKrLRiwkZBvScbvqj+szgcNy
         cndcsb0V+cTvMregc2SxprWnzyxMbfuFgsTbAyx2oL7Ru/P76G05KHngvJWpoebfu+
         qikkBWuaqQ8GPiBGDCucVgXlOK1wBWnm1phSC/igVGezqSYoso2uQ4O2tOT30c0Ooy
         rHF+1rF5eGedTKDlzOJWi3JZXmTWwyQ8cjnF9TiGUgibngXGYMKO69sAoc0qe8023+
         5C87CmqecjyoQ==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso6981740276.2;
        Tue, 04 Jul 2023 19:00:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLZL0sr3Xl68GuxsdQrZpoD/RLt0YRdEI6+BhXWZ8BTyzRlLD6VS
        Pnru2N/2mkyWRXKs6tf5tpoUBzfMmuQ9dSmA3SY=
X-Google-Smtp-Source: APBJJlH2PMes5979bVULwNKr8mjq8Mkm/rvueqx6pTxDCqrBsToWU+IiqE0Lj/Kfo1g1zurXBEFhRBNSEbG/fzebGNY=
X-Received: by 2002:a05:6870:42cf:b0:19f:7b5b:2855 with SMTP id
 z15-20020a05687042cf00b0019f7b5b2855mr17608954oah.15.1688522405064; Tue, 04
 Jul 2023 19:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 5 Jul 2023 10:59:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQas0cK7pgi72tYC3yU=ZkQxnr41YYW1mXd-sWiHtG+UA@mail.gmail.com>
Message-ID: <CAK7LNAQas0cK7pgi72tYC3yU=ZkQxnr41YYW1mXd-sWiHtG+UA@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Hello Linus,

On Wed, Jul 5, 2023 at 4:49=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So this keeps happening to me - I go to apply a patch I just
> downloaded with 'b4', and I do my regular
>
>      git am -s --whitespace 2023<tab>
>
> and the dang thing doesn't autocomplete.,
>
> The reason it doesn't auto-complete ends up being that my kernel tree
> contains some other random stale mbx file from the _previous_ time I
> did that, because they effectively get hidden from "git status" etc by
> our .gitignore file.
>
> So then those stale files end up staying around much too long and not
> showing up on my radar even though they are just old garbage by the
> time I have actually applied them.
>
> And I always use auto-complete, because those filenames that 'b4'
> generate are ridiculously long (for good reason).
>
> And the auto-complete always fails, because b4 just uses a common
> prefix pattern too (again, for a perfectly good reason - I'm not
> complaining about b4 here).
>
> This has been a slight annoyance for a while, but the last time it
> happened just a moment ago when I applied David Howells' afs patch
> (commit 03275585cabd: "afs: Fix accidental truncation when storing
> data" - not that the particular commit matters, I'm just pointing out
> how it just happened _again_).
>
> So I'm really inclined to just revert the commit that added this
> pattern: 534066a983df (".gitignore: ignore *.cover and *.mbx"). It's
> actively detrimental to my workflow.
>
> I'm not sure why that pattern was added, though. These are not
> auto-generated files from our build.  So before I go off and revert
> it, let's ask the people mentioned in that commit.
>
> I *suspect* the thing that triggered this wasn't that people actually
> wanted to ignore these files, but that it was related to the misguided
> "let's use .gitignore to build source packages" project.


Exactly. You are right.

My motivation for 534066a983df was
the silly scripts/list-gitignored tool.

I needed to exclude as many untracked files as possible
from source packages.

That tool is gone with 05e96e96a315.
I have no objection in reverting 534066a983df.


If somebody wants to ignore *.mbx for some reason,
they can add the *.mbx pattern to
~/.config/git/ignore.



Perhaps, a slightly similar case is *.patch.
(We do ignore *.patch)

People quite often run 'git format-patch'.
And, the generated patches have similar prefixes.
(0001-, 0002-, 0003-, ..., for good reasons)

The autocomplete does not work if 000* files
exist from the previous time I ran 'git format-patch'.
I repeatedly run 'rm -f 00*' even if 'git status' does not show them.



A tricky case is *.orig and *.rej
We ignore *.orig.
We do not ignore *.rej (but we used to ignore it)
The reason is described in:
1f5d3a6b6532e25a5cdf1f311956b2b03d343a48



So, actually I cannot tell the clear criteria.
(perhaps, whether Linus is annoyed or not?)

I have no objection in either way.




If we want to minimize our ignore patterns, we could drop
*.mbx, *.cover, *.patch, *~, \#*#, *.orig, patches, series, etc.
from our .gitignore because they are not project-specific.

If people want to ignore them, they can add them
to ~/.config/git/ignore.







--=20
Best Regards
Masahiro Yamada
