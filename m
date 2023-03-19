Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5B6BFFEA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 08:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCSH6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 03:57:58 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE9C211DC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:57:49 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so35503732edb.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 00:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1679212668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZCPz8CRvnK87BzmSaf42c3MAOCXZ8j4GoGGR4DIqXs=;
        b=ZQ2pKNkaAXNEzx1OHhNU+xuOqSepQEoAEgVLKxagddfArXtB8tkU+YQq//m6nnsR8a
         Iv6kNEs3uehv4+E877rarqdq3kutF/qqobRKZtP5NE1Do1nA6fXxyp+ubIGM6anOb3Hw
         N0P1xh82E4LypFuEVGeoNajFvkRvFjhSR68+laXzhuUa5FxqI+xEBA+yOnWO/44mAUZA
         CZwf40uKz27amhdme9Cku82wOUmrEi9yS2uH7VSaUKXf9iovDgbtd+CjyFlP2AgvY8KB
         njuxwzVSyV4XrWIIC3GHtr7pHSqI6rv/gpFORcdqqZdIdN0qHfFcJ9p6451NkRCc+Rqa
         kwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679212668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZCPz8CRvnK87BzmSaf42c3MAOCXZ8j4GoGGR4DIqXs=;
        b=vAiiw76ZlScbOOlYqctcOORNZYRTpYuHR9qK/UaLCADXcCKkkiSoRgtzVfMAOOLNgj
         pDlJayYbO2aI6nQB88NRZcsEiZkmPBoejvBJTeR8edF9b0ZszI3xGws2dSpSaRyakBiB
         BwfCZ9yZf9D3eD/fA5+Ea7jKFMVK6Ii2jKh19B1k9WWSm2yPthUtpwVG5sz2FkNI+JWY
         s9sSK0FcoCkZxhohnK97Jn6N4cX3yokSAWnCY5hKCbu3eo//ud1jS6Xn08IGcZXGN2gk
         yyQzakqr6m+vMXQKek1g15EtmFLvlOel+uleSKxrXZ1OxkL2YhhLSx6mXndGPGUPM9YY
         FHNQ==
X-Gm-Message-State: AO0yUKUAn7ltFHFnbtXAkxjZQrc0eJQh49GwRp/tIZKh0jGrYSqH5APk
        WNN3mniyWnrg6VXNv8P3r3F/JPI4mHsHtiojBke5wjVA7Jgyv4ev
X-Google-Smtp-Source: AK7set/iG/PXfZlZuPaDRugMV84KD1F+LKSh+aRP++O1sU8sK32l6YAA+prNONu+wwMVwnmEQM+6Hnpw7I6n7eAUYJ8=
X-Received: by 2002:a17:906:4549:b0:877:747d:4a90 with SMTP id
 s9-20020a170906454900b00877747d4a90mr2351731ejq.14.1679212668373; Sun, 19 Mar
 2023 00:57:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATXqPy6F+gB8-1Zqh8hooXh3U_5+3xeMFZDZwYsUi=aeg@mail.gmail.com>
 <20230312200731.599706-1-masahiroy@kernel.org> <20230319011217.147183-1-steev@kali.org>
 <CAK7LNATrzAWiu36=-JXXjSt48O12OAQG4ZAtLABd_PyiE2f_VQ@mail.gmail.com>
 <CAKXuJqjWORL0GmyOg9_NFUCjUH3Jd7yrNbTYpnQiTk7AptMZMw@mail.gmail.com> <CAK7LNAQKV9HD-ZJrqiHq5aGOmZZ=spgqM-Aw+X4hYuGF1Ntriw@mail.gmail.com>
In-Reply-To: <CAK7LNAQKV9HD-ZJrqiHq5aGOmZZ=spgqM-Aw+X4hYuGF1Ntriw@mail.gmail.com>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sun, 19 Mar 2023 02:57:36 -0500
Message-ID: <CAKXuJqhSPckPmy3PTtUfFtUOe_2r6gvPf2TLU1LxbzZcLR6beg@mail.gmail.com>
Subject: Re: [PATCH 0/6] kbuild: fix some packaging issues, and use
 git-archive for source package
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        terrelln@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

Once again, sincerest apologies, but i do appreciate your time and knowledg=
e!

On Sun, Mar 19, 2023 at 2:07=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Mar 19, 2023 at 12:21=E2=80=AFPM Steev Klimaszewski <steev@kali.o=
rg> wrote:
<snip>
> It did not go away.
> LOCALVERSION_AUTO is meant to set kernelrelease,
> which will result in 'uname -r' in the installed system.
>
> LOCALVERSION_AUTO should not affect the Debian package version,
> which is a different thing.
>
>
>
>
> >  I'm not sure why the
> > package version overrides what I'm trying to set in the first place in
> > the kernel config?
> >
> > Your workaround is mostly fine, but that "-100" on the end means I
> > have to now personally track how many builds I've done?
>
> "-100" is the build revision, which will go into the .version file
> while building the kernel.
> It is not so important, you can set whatever number.
>
This is actually what was throwing me for a loop!
>
> If you leave the revision auto-incremented,
> this is equivalent to what Kbuild is doing internally.
>
> make KDEB_PKGVERSION=3D$(make kernelversion)-$(init/build-version) bindeb=
-pkg

Aha!  So the issue seems to be that I do out of tree builds, and
init/build-version does not take that into account, so I was always
getting whatever is in the kernel source's .version and not what is in
my actual build directory.  I'm still not entirely sure how to get
that one, but I'm a lot closer, thank you again so much, for your time
in putting together the patchset to fix the building of the packages,
as well as answering my questions.

-- steev
