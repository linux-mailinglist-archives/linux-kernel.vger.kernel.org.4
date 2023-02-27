Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA46A3F35
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 11:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjB0KKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 05:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB0KKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:10:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15221EFDE;
        Mon, 27 Feb 2023 02:10:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BC0C60D14;
        Mon, 27 Feb 2023 10:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42BBC433EF;
        Mon, 27 Feb 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677492620;
        bh=9GwMQmvjKRgxrugSzouoPvn3i22XmcoGz7HfCf+GqYY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lYRXQL5rmLVJPwlYPCq/BMuyQuMuYgRwq+6wXL6SZUPfZRUXJo5n3L3pJmuFcjnjv
         stqUMil3zj408Egr2g/II+h0zfWrgnSKwhdSyjttQx7NarbuPKdOqJ59Kai+Kz8FaI
         gNeInOYEYCG8a4+HKIn4DMvxzTs2maoTBawn6+OfOoSvSQspLl5lT65cPr7QIBaoEa
         icWi+mhT0Mnh4AMUj0D9vcqyUfMsBZIkBdHJfF6NHHfQNuGkrP0hqO8iLXxoZUTHrl
         M2wPM0demfBlZC/TKb+QHGSKh2MIFPayS81yKeQCREgPDQb+cH1GeEJL/YINeCSP75
         Hd9OxswVDoTug==
Received: by mail-ot1-f42.google.com with SMTP id h6-20020a9d7986000000b0068bd8c1e836so3247436otm.3;
        Mon, 27 Feb 2023 02:10:20 -0800 (PST)
X-Gm-Message-State: AO0yUKXeM3JItqfFx3h+mWicaM2nb1CEq2TwwGdphqj/FfxlguwCJjqx
        ht83VWqyNIbRs7s/aVqF/Vy9pT9b4XaCXaQQlTM=
X-Google-Smtp-Source: AK7set+CRuaAJMGtvAcSAjlCh246wJ4skNpX4nXFWqpRSbqFPoj/diJsZ8SHUpQ+wFVUHHKG7OSMVDggQFeTwiktKZI=
X-Received: by 2002:a05:6830:26c2:b0:68b:df73:951e with SMTP id
 m2-20020a05683026c200b0068bdf73951emr4499896otu.1.1677492620030; Mon, 27 Feb
 2023 02:10:20 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNATJ-3JQ0QQGQ5R+R8aBJEq-tmBL8iBZrbM_4t0zeoYTaw@mail.gmail.com>
 <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
In-Reply-To: <CAHk-=wi49sMaC7vY1yMagk7eqLK=1jHeHQ=yZ_k45P=xBccnmA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 19:09:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com>
Message-ID: <CAK7LNAR40OOCJhz2oNF4FXWeyF=MOQPwfojHCU=XZ0jHcuSP5g@mail.gmail.com>
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

Hi Linus,


On Mon, Feb 27, 2023 at 3:58=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Feb 26, 2023 at 8:34=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Masahiro Yamada (46):
> >       kbuild: add a tool to list files ignored by git
> >       kbuild: make perf-tar*-src-pkg work without relying on git
>
> I've pulled this, but I really object to these kinds of silly games.
>
> That whole list-gitignored thing should go away, and silly
> work-arounds for "I don't use git" should likewise just be killed.
>
> There's absolutely _zero_ exzcuse for making our build tools more
> complicated for bad reasons. The "I don't have git" may have been a
> reason a decade ago. It's *not* a valid reason today.


We can say "You must install git on your machine", but IMHO
"the kernel must be managed by git" is a too strong assumption
because snapshots are delivers as a tarball (e.g. https://www.kernel.org/)
I could be wrong, but that is my intent (as in the commit description).


>
> People who insist on using quilt etc should just realize that then
> they don't get the featrues that git offers.
>
> You can't have your cake and eat it too.
>
> I do *not* want to see git functionality basically duplicated in some
> kernel C helper script just because somebody can't be bothered to just
> use git.
>
>               Linus


If tar's --exclude-vcs-ignores option had worked correctly,
I would not have written such a gitignore parser by myself.
When tar implements --exclude-vcs-ignores correctly,
I am happy to remove this silly tool.
(In turn, tar will end up with a similar gitignore parser as git, though.)





--
Best Regards
Masahiro Yamada
