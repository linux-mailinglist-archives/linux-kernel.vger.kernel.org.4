Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB996A5CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjB1QUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjB1QUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:20:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C81E283;
        Tue, 28 Feb 2023 08:20:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F7B9B80E19;
        Tue, 28 Feb 2023 16:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8DEC433D2;
        Tue, 28 Feb 2023 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677601231;
        bh=ui+2BVSMErurQQKP1GO0zuy/s8AMVS9122TTr3yDGWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XRGbW32WNCFW9WYStqKcKfb9YXX3BbJuaRoq/0rB/VN0JWHfUUKH7Nix1nk2cVQi3
         ZW6V7MlxZZVe8eGapt9oSbMfBJ7xmKwilY0TepJNg9TvS4rRJ2NTW0G4DcxT6mx0US
         qAs092Zjt+nRI0WUn331amrpJlBhMpRduNDlKv8hi0rAzek6Ud0UbIg/UP42aw7g/D
         fdtifypog98yDcYr1tsSkUjuFs5MHKOiHxWjOnpXIJS7NLxcTMdj9xNPp+7TFawQnV
         a8QSTdkoCseddwcD/Goz/nTgqvSYWFGIIhj9BWXpEbXydOvrCInUdl0f7A4lp+W/3A
         scJ74LbxeHYJA==
Received: by mail-ot1-f47.google.com with SMTP id r23-20020a05683001d700b00690eb18529fso5904510ota.1;
        Tue, 28 Feb 2023 08:20:31 -0800 (PST)
X-Gm-Message-State: AO0yUKW+ygsJ6ghbieA7VqkaXtrf6+F9ut1lscuQkWBKhNf/9tPtgp2w
        GQyVXVsaNf6oJcvHxEpq8QTh1kdrGn+tr46M78I=
X-Google-Smtp-Source: AK7set8YS1Vv0suz5K+Dx+3soGLtMePJFoubCuwPDhovyLAbxjeDWPRZM+w5+GIIDxLfP+Hwf2M0GE6YsRPfdMDJYgI=
X-Received: by 2002:a9d:1c7:0:b0:688:d1a8:389e with SMTP id
 e65-20020a9d01c7000000b00688d1a8389emr1179515ote.1.1677601230840; Tue, 28 Feb
 2023 08:20:30 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
 <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
 <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com> <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
In-Reply-To: <CAHk-=wh5AixGsLeT0qH2oZHKq0FLUTbyTw4qY921L=PwYgoGVw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 1 Mar 2023 01:19:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQj9=yzb3C0OdTq=6MPr4SZE=PBXaZY7xPMbti1Fe7n6g@mail.gmail.com>
Message-ID: <CAK7LNAQj9=yzb3C0OdTq=6MPr4SZE=PBXaZY7xPMbti1Fe7n6g@mail.gmail.com>
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

On Tue, Feb 28, 2023 at 2:08=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Feb 27, 2023 at 2:10=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > If tar's --exclude-vcs-ignores option had worked correctly,
> > I would not have written such a gitignore parser by myself.
>
> But that thing is *WRONG*.
>
> Seriously. It's fundamentally wrong.
>
> The thing is, you don't even seem to understand how gitignores work.
>
> A gitignore pattern doesn't actually mean "this path does not exist in th=
e VCS".
>
> It means "git will ignore this path for unknown files".
>
> And that's a *big* difference.


Of course, I know this difference.

I wrote it in the commit description of
5c3d1d0abb12a6915d0f43233837053945621a89

Please read it closely.





We are talking past each other due to the disagreement
about=E3=80=80what the source code means.

You think "what is committed in the VCS is the source code"
in other words, files in "HEAD" are sources.



I think "what exists in the source tree is the source code"
that is, files in the "working tree" are sources.

Of course, the working tree contains a lot of build artifacts, hence
the list-gitignored tool excludes them.




>
> That "for unknown files" means that *known* files can still match the pat=
tern.

Yes,

'git ls-files -i -c --exclude-per-directory=3D.gitignore'

lists those files. None of them is needed for building the kernel,
and if we want, it is easy to fix .gitignore files.


>
> And that is actually a perfectly valid pattern, and is very much by
> design. You can say "ignore unknown *.o files", but still actually add
> one explicitly to a git repository, if there is some special case.
> There's nothing wrong with it.
>
> But the way you have done things, it now is actively wrong.
>
> We are *not* adding complexity for no good reason, particularly when
> said complexity is fundamentally *broken*.
>
> Yes, we export the kernel as a tar-file. But that's for people who
> just don't want to deal with the full deal, and even that is partly
> for legacy reasons that aren't necessarily all that true any more.
>
> I suspect that by now, there are probably _more_ people used to git
> than there are people who are still used to the "tar-files and
> patches" workflow.

I do not know.
We are discussing from upstream developers' point of view,
not from packagers' point of view.



>
> So here's the simple rule: if the packaging people can't be bothered
> to use "gti archive" to make their packages, then they had better just
> do a "make clean" first (or, better yet, do "git clean -dqfx" to
> really clean up, because "make clean" isn't 100% reliable either).
>
> We don't add more broken infrastructure to deal with broken workflows.
> Just do the right thing.
>
> Or if package managers want to do their own thing, then they can damn
> well do it in their own broken systems, not adding a completely broken
> script to the kernel.

Fair enough.


>
>                 Linus


--
Best Regards
Masahiro Yamada
