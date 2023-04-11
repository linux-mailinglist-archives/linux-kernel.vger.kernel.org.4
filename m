Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D1B6DD936
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjDKLRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjDKLRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:17:34 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D86421E;
        Tue, 11 Apr 2023 04:17:31 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id ch3so8741391ybb.4;
        Tue, 11 Apr 2023 04:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681211851; x=1683803851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd3u6ypnNuoPbKSx66oxDBYsbBNUgXKJyWsz/Cc9XCs=;
        b=hGLRl87JLi5CMoqAmhzXcPMA0V/AQ6lxdgw6dDTpjaCTjlEd39kmQ77M7zJc0LcHfx
         DJOLQaK7n1O+kDx0oVukcENjRTOr8mXUGAMQsm8R8CGWXPJlb4g9ZCKeLPeJkEL5NG6x
         h0rmyo+fq6N9WXMJaj5x/06twGYEvWz5UaxuSmbfCQ9aPsHlu3DIpOWJlLSPV0a8bAG2
         fgZLFNI+MLdVfyjVSin3XhDHbGNGrYEUSVeN7+ik/jcpAf6tepTPFY3JWMb+uRs2ry00
         xFLV4MGILZ+fDv9WOstqZ2BSVQh1sbid+Ouocqt/S/symCGAlQyFYahgWR+AcXpI3Y6W
         mW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211851; x=1683803851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fd3u6ypnNuoPbKSx66oxDBYsbBNUgXKJyWsz/Cc9XCs=;
        b=K2Gw2hy3mYLaRk/V2HQchB/zXc2G1W4bEJaSt61aZDuA4esEiUhD92ITpElMTisk1R
         1gNdip0nxjOO62iPctNziDf9qOvSKVMQxkCMoUGHQ9mcadaubcwGcE0et9JTMimAR7xf
         0OgI2upzJES11iEHO3P8SzM8hJpFT7NXD3Gcqsvn2ZWjQWHnTqrvqJ087x34xfXjjSW1
         kbZOg5+AG7koaNx437/mOIXhNWyWYaZQAVySeHn8gL77+WQl1Rcf4uFtCHiWXaae1xlE
         XgG5k9wfBIIMNVdQuTNFMYMPBSzU4FTiCKXE/PKdzqK/kQit7O2KNSyoWJeAknSWIVSe
         A3ig==
X-Gm-Message-State: AAQBX9c9q5uQmehPTeyVuPx9TZRxCGwWBtWUM4wY63xftzulkjSVqe+c
        RxrhJAva3e/GJEbGDIpUTgcDIQ6SYkb4hXoHql4=
X-Google-Smtp-Source: AKy350au3uYIW78d6r18IS62Iyy3h3HK3ZJChvUuw0OR4uM6IFzMNee3q+8sLaXzXyvJ+vmdhmtuDQsDdPRONr40Jio=
X-Received: by 2002:a25:7781:0:b0:b8e:cad0:6e57 with SMTP id
 s123-20020a257781000000b00b8ecad06e57mr5445631ybc.11.1681211850832; Tue, 11
 Apr 2023 04:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org> <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org> <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
 <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com>
 <ZC+x8pqUVzWQ35fv@righiandr-XPS-13-7390> <CANiq72ngN9bAiWaVVyJkkEK_WAoTQVb5mmYLMqs5PK7pu6gV9A@mail.gmail.com>
 <ZDUICqLhv6uSk9an@righiandr-XPS-13-7390>
In-Reply-To: <ZDUICqLhv6uSk9an@righiandr-XPS-13-7390>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 13:17:19 +0200
Message-ID: <CANiq72=JVJw_1vrecMDZhReYqJ2anGfhdkZW-ukt-ANDj_Fidw@mail.gmail.com>
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 9:11=E2=80=AFAM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> Yes, that looks more clear, the name of the option is a bit misleading. :=
)
>
> To be clear what is going to be removed is
> -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
> in this way clang will be compatible with gcc and they can both use
> -ftrivial-auto-var-init=3Dzero.

Exactly, i.e. `-enable` is the one getting removed, but the wording
within it (`knowing-it-will-be-removed-from-clang`) meant that the
`-ftrivial...=3Dzero` one was the one that would be removed, not
`-enable` itself (even if now what will happen is the opposite than
what the option suggested originally).

So when I read the commit message, the "this additional option ... is
going to be removed in the future (as the name of the option
suggests)" sounded wrong, since the name did not suggest that, but
rather that `-ftrivial...=3Dzero` would be removed, not itself (since
that was the original plan).

If I understood the story properly, that is. :)

Thanks for taking a look!

Cheers,
Miguel
