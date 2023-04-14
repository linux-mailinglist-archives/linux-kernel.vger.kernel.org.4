Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC266E245A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjDNNgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjDNNgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:36:35 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD383E3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:36:32 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id g10so1984317ybu.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681479391; x=1684071391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCMMqYXqdLzftYPyxap730NaR/BDwk+TJ6kmlEYvp48=;
        b=YEt3CDL9MSdSVh6XkAStD2cO5TGpHGncPbKV8aVwUs5fCzuGR9+SwHo4vlTeGp8mmo
         9URlBi9ZyRZkkn5ycruLpDiuV41Me2mn/fMsEUo6vcLvkTnkZdMZYSC1LMpyiZ0K+BF8
         ua84+5iWLzEwozDVYbjn5tI3TdSu+lzQ9FYcSjZ0REO721IihVzjhXDJPVbYeDHVXkyC
         Mf9bv41H96tEbGxXUIAqscfDZa0AoATkByTfn9ePFIKlItbhrCXzcZm7jsSVlByIXUo2
         Wiv/6i/nwrtgxJlm1nu1637RHinpq2mNocQKhDUVmIb4Ht0fw0IITNmN1aKeanWvuVH2
         HkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681479391; x=1684071391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCMMqYXqdLzftYPyxap730NaR/BDwk+TJ6kmlEYvp48=;
        b=NC/4QqQ4oMeSwBiXZEunqih9N074BntbSX+rviLMEYCOU9BbTBMcjxspa+glPFVVD+
         mKM8sDjWiQQqZYQDuIjRPbszFysjtemcNiFGhc5QVzwWlY71i6/A+6m7fZFlACir3d9J
         zBxJN3Oz7YnOSLDuphQ+7l4eDAFXtL0oe/TcYZTYzGyavs1D2dcSlgEUTkq6ThQT4rgS
         cNJoC9jdiVmhDl1GSMw5t/Hrr+y11UlLo+E/PgvqCQKubPFtXE0D5h6bM9GN2I2t1JRY
         1hzG6wqhCkNd17bZnCAbcz0m+ftj1AYuNCGxOyK4e+kGTzYlh4dMWtdrQaKvdkcNmVdj
         eXvg==
X-Gm-Message-State: AAQBX9eDkLgxoC2Bz1UsXwcdB1l+LuVwGyxM0GL16ugudWQxfRQgtO76
        G04z0xokpM7UMNoQUJDNSTMbDOQRp/CaPRfec8I=
X-Google-Smtp-Source: AKy350bqM4zM1q8oCeAZ1JNgqtK/Wwvrnwzuwj3VbLQqJMeHQJUS/aR6xQXxF2C5z3fw32E7/0cJz2/YhLeSu4xDGyE=
X-Received: by 2002:a25:d6d8:0:b0:b8f:5680:7d99 with SMTP id
 n207-20020a25d6d8000000b00b8f56807d99mr3717296ybg.11.1681479391314; Fri, 14
 Apr 2023 06:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230414101052.11012-1-ihuguet@redhat.com>
In-Reply-To: <20230414101052.11012-1-ihuguet@redhat.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Apr 2023 15:36:19 +0200
Message-ID: <CANiq72=vTLT1PnbWu4pwNNyMO0S413G3O+_TLcCGLiDGr5fH7Q@mail.gmail.com>
Subject: Re: [PATCH v3] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Cc:     ojeda@kernel.org, masahiroy@kernel.org, jgg@nvidia.com,
        mic@digikod.net, danny@kdrag0n.dev, linux-kernel@vger.kernel.org,
        corbet@lwn.net, joe@perches.com, linux@rasmusvillemoes.dk,
        willy@infradead.org, Andrew Morton <akpm@linux-foundation.org>
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

On Fri, Apr 14, 2023 at 12:11=E2=80=AFPM =C3=8D=C3=B1igo Huguet <ihuguet@re=
dhat.com> wrote:
>
> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.

Thanks -- v3 looks much safer!

To clarify the risks (it would be nice to detail these in the commit messag=
e):

  - Did you sample files manually or did you automate the search (e.g.
grepping for spaces/tabs, for LF, etc.) to verify the current rules
match the files in the kernel tree?

  - Would it be possible to go further than grepping and apply the
rules (e.g. trigger a "save") through the entire tree to see whether
there would be spurious changes?

    If that comes out clean (or mostly clean), then we would be fairly
confident this will not surprise developers (and it would be nice to
have the script around for future updates of the `.editorconfig`).

    Perhaps EditorConfig provides a script to check this already?
Otherwise perhaps it can be done with editorconfig-core-c or
editorconfig-vim or directly scripting on a couple editors?

  - Are we sure the rules match the output of automated formatters we
are using? (e.g. for Rust we enforce `rustfmt`, and thus we need to
ensure the editor does not "fight" the formatter; otherwise developers
may need to run the formatter more).

Cc'ing Andrew since he applied originally the `.clang-format`.

Cheers,
Miguel
