Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9C730D4C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbjFOCkm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 14 Jun 2023 22:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242178AbjFOCkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:40:36 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BE8269E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:40:34 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-39e87ad392fso451412b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 19:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686796833; x=1689388833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzJECtrl96+oShM83EMIlq/tfEMuyZFqCkDk9mCEWHo=;
        b=cMMXn9gyB9RR6DsIJ4apQovdZFYDJXmXfP1SH/Ynsp1jdzxJiMRb4yRbRitrfBes0h
         vD2hneb0mGhys8WUy08Ar6ztHJzpTwUeZ3QFQfs+EgZNyob5oKrYyjFeRPBhtKleLkcF
         yg89JEvobEcip0HZTXtyq7fJTgD5REeEVDJPkN3O1na7rCmuf5kYVh7I65XhAktcqvDR
         kpEofxNAoZsERazpQ5+Bajur4Dw7vPnvHcNOJplpjohJTjSfoA5G/MPoyoDJk3gb821g
         x+6AvPsb/LExiFGwkFUwDWAhEqT27lep5TsNiJbNlUAvdE4tGa4oYx6vqBVdY16ffd+/
         GNQA==
X-Gm-Message-State: AC+VfDx54RIQhz/AiBkSLjDiAhJ3pQrrFFd2o6Y0dJseC3k69MJDK4zx
        bb4CMrpOadofSEJKiXRI5P0QH0FOpWdlJYKv9ho=
X-Google-Smtp-Source: ACHHUZ6f3YmYnOw3UpEAOmy5xgx6yLxVldxaJoYwZmJSQv2c8n6NHxX47lvfbl2YKC/7UqqtqHogGwEPjThVhqlOy+8=
X-Received: by 2002:a05:6808:f06:b0:398:2b60:dbf4 with SMTP id
 m6-20020a0568080f0600b003982b60dbf4mr15280115oiw.19.1686796833538; Wed, 14
 Jun 2023 19:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <87sfb1oz13.fsf@meer.lwn.net>
 <8f27ad5f-9a9c-3db0-a934-88e1810974f3@digikod.net> <CACT4oue7DgUf+65yat+6t9VrSji1N0njxunObHbRzfjMCAPmYQ@mail.gmail.com>
 <CAMZ6RqJ66wxVAcveVunQ3W6sYihQM43Hi44D7TAee_nUPk+ZXA@mail.gmail.com> <CACT4ouc23BYWNBrE7w0a8Huy5hrhaix3=0P3kuXFQhwk_uib1g@mail.gmail.com>
In-Reply-To: <CACT4ouc23BYWNBrE7w0a8Huy5hrhaix3=0P3kuXFQhwk_uib1g@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 15 Jun 2023 11:40:22 +0900
Message-ID: <CAMZ6RqKHTYcGfBX=RZWqzSD+PFpOoH8A_dM0vY6yp2P3Acd=Wg@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org,
        danny@kdrag0n.dev, masahiroy@kernel.org, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 14 Jun. 2023 at 22:04, Íñigo Huguet <ihuguet@redhat.com> wrote:
> On Wed, Jun 14, 2023 at 2:55 PM Vincent MAILHOL <mailhol.vincent@wanadoo.fr> wrote:
> > On Wed. 14 Jun. 2023 at 20:40, Íñigo Huguet <ihuguet@redhat.com> wrote:

(...)

> > > Right now I see 2 possibilities:
> > > - Provide an .editorconfig.default so those that want to use it, can
> > > do it. But I wouldn't mess with cherry-picking directories that
> > > already complies and those that don't, just the developer chooses to
> > > use it or not, and that's all.
> > > - Provide an .editorconfig directly, and those that don't want to use
> > > it, either disable it in their editors or manually delete the file.
> > >
> > > Please tell me what approach you prefer.
> >
> > Personally, I vote for the latter. My honest opinion is that we are
> > putting too much consideration into the risk of rejections.
>
> I completely agree.
>
> > Íñigo previously stated that editors such as Kate can not opt out. I
> > think that the reason is simply that no one has complained about it so
> > far. I did some research on the internet with the keyword "kate
> > disable editorconfig", and nothing  relevant appeared. A deeper
> > research made me found this:
>
> I have not "complained", but I have filled a request just today, that
> I think won't reach far: https://bugs.kde.org/show_bug.cgi?id=471008

Wow! That's a lot of investment on your side. Clearly, there is no
appetite from the maintainers. But if something needs to be done
(which I doubt), I think it should be on the editor's side rather than
on the project using that .editorconfig file.

> >   KatePart has support for reading configurations from
> >   .editorconfig files, when the editorconfig library is
> >   installed. KatePart automatically searches for a .editorconfig
> >   whenever you open a file. It gives priority to .kateconfig
> >   files, though.
> >
> > source: https://docs.kde.org/stable5/en/kate/katepart/config-variables.html
> >
> > So it appears that for Kate, installing the editorconfig lib is a
> > prerequisite. I think it falls in the opt-in category.
>
> I'm not 100% sure, but I think that this is a requisite at build time.
> So unless you build Kate from source, it will be built-in without
> opt-out choice.

It seems you are right. On Ubuntu, the "kate" package actually depends
on "libeditorconfig0", so indeed, that's a hard dependency. My bad.

That said, on source based distribution, it should be configurable.
Taking gentoo as an example, you get an editorconfig USEFLAG which
allows to choose whether or not you enable editorconfig during the
compilation:

  https://packages.gentoo.org/packages/kde-frameworks/ktexteditor

I continued my investigation. Here is the commit which adds
editorconfig to ktexteditor (used by kate):

  https://github.com/KDE/ktexteditor/commit/f9f133b6ac72dfa12bdeeab1a37c5e9dc9a9354e

Looking at what the code does, it first walk through the absolute path
in reverse and if it finds a .kateconfig file, it does an early
return:

  https://github.com/KDE/ktexteditor/blob/f9f133b6ac72dfa12bdeeab1a37c5e9dc9a9354e/src/document/katedocument.cpp#L2578

This should act as a kill switch. Not tested, but adding a .kateconfig
seems like a valid opt out method. This is consistent with the
paragraph I quoted in my previous message:

  It gives priority to .kateconfig files, though.

Problem solved?

> > Is there really an editor with default opt-in and no options to
> > opt-out? I doubt...
>
> Kate is the only one I have seen so far, but it's difficult to know.
>
> > I really think we should have the .editorconfig at the root and for
> > the rare edge cases where the user really wants to opt-out, I
> > sincerely believe that there will be solutions. I have seen many
> > projects using it and I do not recall push backs or complaints.
