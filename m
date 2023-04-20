Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE5A6E9F19
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjDTWds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjDTWdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:33:40 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B201700;
        Thu, 20 Apr 2023 15:33:04 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8aea2a610so9169921fa.3;
        Thu, 20 Apr 2023 15:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682029969; x=1684621969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu5fEGna14apSV36eBzrBJKSSgNGXIkFyyYc8j8im+A=;
        b=M8NzpQPDufCc/THsQ6NUHXVlCqectlkQUml+fbYe0mHFdOks/dkqlkolj90S3/lw0z
         tmpl/xt+3sQcegT2/5HKHE5EJz1Mg9l23K+YP60mBbUVx7cdf9FzhM8ghFYPOfDdCKfl
         62mZ3X8cURbQccP7odvT/uplCzdlCyHNmXbJowfu+f8Ns7htPoln35fYpZeqQqzCxG2H
         pt2Q48CyDaew2DAlrW7e5fhyZRSt1yK8jJjyGA3bNY7MTkvKvwpFIZWn7ryG+etzxse7
         jAav/T8MPS7OYJurm3tadx19fg/wvc+EbPkjGwrO2mOKBHE9cnmRqyLm1z1OWoh9xUX8
         3fTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029969; x=1684621969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uu5fEGna14apSV36eBzrBJKSSgNGXIkFyyYc8j8im+A=;
        b=F3rdvCAvFwFRjVS5dZkSQajdHHVeDSpHlVTG1XvtRfH9iMfl8O1WzbWjMsjwkPNtqP
         jd//OUy814JxaQvqne2gjYATvrdW3640IR3CxgadOATk9i/WiNXES7EM3sSmyy/NbO63
         TP+j36Y2s3wZmGb6PkH/Tz8YASvsxNTtUAhGugBZvE8UdFJ+jmibwt9k4mo0aJCnlxe5
         Xd8w20JHFDJXu/dZdINqwKvWA9e0YPMxp7BppY1KPO9ebVi18y4psywf5AT1AcpXTGuF
         eAD/yAlBlQkOpheHIMc5csGNPnnr11hmIPLpVxWVhcqYOBs2F2XNHrNRGoXjahzJuc0N
         i9Xg==
X-Gm-Message-State: AAQBX9dlvHDlc3nxvDyZstuwkl6kX66qNI2bmWcSynrxF7Jn/VkbKDkI
        wxnpxPsvj6oB6X8yfnxqCkg2BMmXPXLjSyyvbl0=
X-Google-Smtp-Source: AKy350YvQx5zR5xZc6+121+MdNqnfEy5eH4YDG5HCIQmBw1915BCnOfYvXxjmAJ627xWYymyLsV+CIwKOxUWVb8sgKU=
X-Received: by 2002:a05:6512:69:b0:4eb:1192:ce6f with SMTP id
 i9-20020a056512006900b004eb1192ce6fmr804371lfo.13.1682029968553; Thu, 20 Apr
 2023 15:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230412221823.830135-1-ojeda@kernel.org> <CAFRnB2VygPYBY7MbxoftzEtqs52YG5AN_EO72Nm1ukLWnApa=Q@mail.gmail.com>
In-Reply-To: <CAFRnB2VygPYBY7MbxoftzEtqs52YG5AN_EO72Nm1ukLWnApa=Q@mail.gmail.com>
From:   Alex Gaynor <alex.gaynor@gmail.com>
Date:   Thu, 20 Apr 2023 16:32:37 -0600
Message-ID: <CAFRnB2W_KSpUMJQXvzyOcR8XBUmO=Bx+hDZH_Se-QrMfyiKsgQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Benno Lossin as Rust reviewer
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My previous line was incorrect. Corrected:

Reviewed-by: Alex Gaynor <alex.gaynor@gmail.com>

On Wed, Apr 12, 2023 at 4:21=E2=80=AFPM Alex Gaynor <alex.gaynor@gmail.com>=
 wrote:
>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
>
> On Wed, Apr 12, 2023 at 6:18=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> w=
rote:
> >
> > Benno has been involved with the Rust for Linux project for
> > the better part of a year now. He has been working on solving
> > the safe pinned initialization problem [1], which resulted in
> > the pin-init API patch series [2] that allows to reduce the
> > need for `unsafe` code in the kernel. He is also working on
> > the field projection RFC for Rust [3] to bring pin-init as
> > a language feature.
> >
> > His expertise with the language will be very useful to have
> > around in the future if Rust grows within the kernel, thus
> > add him to the `RUST` entry as reviewer.
> >
> > Link: https://rust-for-linux.com/the-safe-pinned-initialization-problem=
 [1]
> > Link: https://lore.kernel.org/rust-for-linux/20230408122429.1103522-1-y=
86-dev@protonmail.com/ [2]
> > Link: https://github.com/rust-lang/rfcs/pull/3318 [3]
> > Cc: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90abe83c02f3..bf9deaa4aa5a 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -18225,6 +18225,7 @@ M:      Wedson Almeida Filho <wedsonaf@gmail.co=
m>
> >  R:     Boqun Feng <boqun.feng@gmail.com>
> >  R:     Gary Guo <gary@garyguo.net>
> >  R:     Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> > +R:     Benno Lossin <benno.lossin@proton.me>
> >  L:     rust-for-linux@vger.kernel.org
> >  S:     Supported
> >  W:     https://github.com/Rust-for-Linux/linux
> >
> > base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> > --
> > 2.40.0
> >
>
>
> --
> All that is necessary for evil to succeed is for good people to do nothin=
g.



--=20
All that is necessary for evil to succeed is for good people to do nothing.
