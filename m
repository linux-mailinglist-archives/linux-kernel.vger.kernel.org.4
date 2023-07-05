Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87B7747C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGEFEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGEFEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B92C10FA;
        Tue,  4 Jul 2023 22:04:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41E9F61423;
        Wed,  5 Jul 2023 05:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D1C433C9;
        Wed,  5 Jul 2023 05:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688533482;
        bh=2i0Ae7rBMhcEAYB+PDsBxsKOdpkbQVHO6Hi3mRd2nXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0e4hy6cx7OdhVzd+5ZUFqqpRMtHn/bpzwjv1SbHB9NmOtLk1QD/zQuXLvv7TLR1R
         tmSGVEdxgsfZp9WzsImiPe6/7nHHM9fzOfJTKW3B7RXw5j8eoqaQALDoFxFU4/ipmy
         KtWqrJn9Cmhl9MqW845LMjMaQECWyXwLiwtNz4CviuJiaA45FJMWYXFwZP89KTYWDC
         AX6dgly76sbqqjCGxpgIIzwpWV+ldixpeRGRX8jLeXRscGF91MRRZmQvGExHusFD05
         4PLLlKKfbl0h1j4ZnmqhoMbg0RecFOAR8QvwLX+RDM0eDTH1Krsq+XNMRVoTTNK4TH
         YPs+MPprVqXzA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-56598263d1dso3960041eaf.0;
        Tue, 04 Jul 2023 22:04:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDw4HkB/AxjQj9TGvEjOEAf0dyyvMXT+HWss5YcjLMaRbquAWWEh
        FmTnDLMtLvAoH1v+tw62Dp2MeYguGbfj1e1/H5k=
X-Google-Smtp-Source: ACHHUZ4hnZqcvzQcojh0JHfNNvc0QV0Z+wEtOYv/w3KKG9gOFLEIliQM9zwO3fxRyh45qx0+0X0GyLue3ME7b3N3njE=
X-Received: by 2002:a05:6808:189d:b0:3a1:e4d1:878d with SMTP id
 bi29-20020a056808189d00b003a1e4d1878dmr15216554oib.9.1688533481807; Tue, 04
 Jul 2023 22:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiJHMje8cpiTajqrLrM23wZK0SWetuK1Bd67c0OGM_BzQ@mail.gmail.com>
 <ZKTncHqLwgbZbRVl@bergen.fjasle.eu>
In-Reply-To: <ZKTncHqLwgbZbRVl@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 5 Jul 2023 14:04:05 +0900
X-Gmail-Original-Message-ID: <CAK7LNARM04vuv7o+GJ082140efWCCN-q7jCaacrA_DT=FuoUWQ@mail.gmail.com>
Message-ID: <CAK7LNARM04vuv7o+GJ082140efWCCN-q7jCaacrA_DT=FuoUWQ@mail.gmail.com>
Subject: Re: Overly aggressive .gitignore file?
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On Wed, Jul 5, 2023 at 12:46=E2=80=AFPM Nicolas Schier <nicolas@fjasle.eu> =
wrote:
>
> On Tue 04 Jul 2023 12:49:01 GMT, Linus Torvalds wrote:
> > So this keeps happening to me - I go to apply a patch I just
> > downloaded with 'b4', and I do my regular
> >
> >      git am -s --whitespace 2023<tab>
> >
> > and the dang thing doesn't autocomplete.,
> >
> > The reason it doesn't auto-complete ends up being that my kernel tree
> > contains some other random stale mbx file from the _previous_ time I
> > did that, because they effectively get hidden from "git status" etc by
> > our .gitignore file.
> >
> > So then those stale files end up staying around much too long and not
> > showing up on my radar even though they are just old garbage by the
> > time I have actually applied them.
> >
> > And I always use auto-complete, because those filenames that 'b4'
> > generate are ridiculously long (for good reason).
> >
> > And the auto-complete always fails, because b4 just uses a common
> > prefix pattern too (again, for a perfectly good reason - I'm not
> > complaining about b4 here).
> >
> > This has been a slight annoyance for a while, but the last time it
> > happened just a moment ago when I applied David Howells' afs patch
> > (commit 03275585cabd: "afs: Fix accidental truncation when storing
> > data" - not that the particular commit matters, I'm just pointing out
> > how it just happened _again_).
> >
> > So I'm really inclined to just revert the commit that added this
> > pattern: 534066a983df (".gitignore: ignore *.cover and *.mbx"). It's
> > actively detrimental to my workflow.
> >
> > I'm not sure why that pattern was added, though. These are not
> > auto-generated files from our build.  So before I go off and revert
> > it, let's ask the people mentioned in that commit.
> >
> > I *suspect* the thing that triggered this wasn't that people actually
> > wanted to ignore these files, but that it was related to the misguided
> > "let's use .gitignore to build source packages" project.
> >
> > But at least for me, it's a real problem when .gitignore contains
> > other files than the ones we actually generate.
> >
> > The only one that actually commonly affects me is the *.mbx file,
> > although I could certainly see the same being true of the *.cover
> > thing.
> >
> > And there might certainly be other patterns like this that I just
> > don't react to, because they don't have the same detrimental effects
> > on how I work.
> >
> > Comments?
> >
> >                Linus
>
> Thanks for sharing some details of your concrete workflow.  I think,
> having this in mind, it is quite a fair point to criticise the handling
> (or ignoring, respectively) of files that are are not generated or used
> during kernel builds.  But in general, I don't find it that easy to
> draw the line; should we also remove
>
>    *.kdev4
>    *.orig
>    *.patch
>    *~
>    \#*#
>    patches
>    series
>
> from .gitignore?   I don't think so, even though they (partially) fall
> into the same category.
>
> From my point of view, this is a decision of personal preference.
> I do like the ignoring of *.mbx and *.cover, as I tend to have those
> files around for some time by intention.  But a revert would not cause
> any trouble to me and optimisation of your workflow is magnitudes more
> important, so I am perfectly fine with it, if you want to have the
> commit reverted.


Already reverted.
(d528014517f2b0531862c02865b9d4c908019dc4)

I also chimed-in too late.

If he wants to hear opinions from people
who live in different time zones, he can wait
for 24 hours, but his decision is usually quick.



--=20
Best Regards
Masahiro Yamada
