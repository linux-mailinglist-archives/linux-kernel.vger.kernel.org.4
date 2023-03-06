Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D7F6ACE28
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 20:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCFTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 14:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCFTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 14:33:56 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEBC9EF4
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 11:33:54 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s17so6256138pgv.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 11:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678131233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7AQFc3LtW9Lbl6pASToCJCN49VYg0IVzRV+aopA7R0=;
        b=lX6Kq32L7kysvwkv0O9qBGe6oFp8KQFy0gzkEf+oQYiD01LHgCbmfukA7qQu0tVB14
         UkRa9CruMi6ymFEZfM3NNHInKaDjLlDsKJa4k6wMiQapb77Ggzcw+E8fVSuOwdwJuWJ7
         GNPalzre1ndxLDK69qy04r+LBtTLh+hVQSfTvfm0x511eHiLx8Mh3U5PvRAzGzK0atb1
         YTxEpfyJ9N2uqXwiPHXbKMc9WZ3n7LZrO90tpj9kxXvxyPYHj/fTKIJR9vhWyDTHdSha
         kdwI6Qsnsz31WSLOZuVhI34BgYFB8UGg9X2K44hh+QJVzko+z/Csqj/8Abost5NH9zuT
         8iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678131233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C7AQFc3LtW9Lbl6pASToCJCN49VYg0IVzRV+aopA7R0=;
        b=z6SG7SwpQcHgtcYHVhpgOLoT4Y6ZPuRW4ZO0ufE4XIwD/J17UmqK+bo6OHMUbm0jqZ
         EM0C2QJU6SmFbuJStg9Kt2oVks6v1r2QisUiDFRNFGak8BHkBrUa1gApJi2VnVK9ldzq
         hgCSubh2FU9LTiOTemkLlyyrsbuR9zms929v3vAMKN+BMoA8ZpXenNFA00akONuxa8qO
         d/gkizklIm4IaVaTT60oUlJF8CQvlIQsq5iGG7oXBqa0U30BMy06CYeLoBlviIhpBy7/
         wHqNKnb/WtylUWUGqK/W0echaKBJmY6xUEg4u6XZwBKsN/us4tVlSad/KKYbtx6V1f2m
         9U7w==
X-Gm-Message-State: AO0yUKXyGIgB5TWIijxTzxb5gZqZVNpfwyQza5OTJ4NDeeGhctoy/4Jy
        E7XcMHQPQ+eu5Ixcjd1xCtIiV4R/E1AyhPmFL8lmSg==
X-Google-Smtp-Source: AK7set8eWmi5aPInvKjDHJn3kJ57Ju1XKRFVH+BoMz9PzaJk6QQag0QUL9fV8tGcvfeJb3jpLQa8164OFUla1hBZPhw=
X-Received: by 2002:a63:5904:0:b0:4fc:7e60:d0c with SMTP id
 n4-20020a635904000000b004fc7e600d0cmr4033113pgb.11.1678131232887; Mon, 06 Mar
 2023 11:33:52 -0800 (PST)
MIME-Version: 1.0
References: <20230306191712.230658-1-ojeda@kernel.org>
In-Reply-To: <20230306191712.230658-1-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 6 Mar 2023 11:33:41 -0800
Message-ID: <CAKwvOdn2dwMheFdzmvVdEdMUxw5Kz6OxXp-CW1Z84OJ=ME2Z7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: programming-language: remove mention of the
 Intel compiler
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 11:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> The Intel compiler support has been removed in commit 95207db8166a
> ("Remove Intel compiler support").
>
> Thus remove its mention in the Documentation too.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  Documentation/process/programming-language.rst | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/Documentation/process/programming-language.rst b/Documentati=
on/process/programming-language.rst
> index 5fc9160ca1fa..10dc772671d8 100644
> --- a/Documentation/process/programming-language.rst
> +++ b/Documentation/process/programming-language.rst
> @@ -12,10 +12,6 @@ under ``-std=3Dgnu11`` [gcc-c-dialect-options]_: the G=
NU dialect of ISO C11.
>  This dialect contains many extensions to the language [gnu-extensions]_,
>  and many of them are used within the kernel as a matter of course.
>
> -There is some support for compiling the kernel with ``icc`` [icc]_ for s=
everal
> -of the architectures, although at the time of writing it is not complete=
d,
> -requiring third-party patches.
> -
>  Attributes
>  ----------
>
> @@ -38,7 +34,6 @@ Please refer to ``include/linux/compiler_attributes.h``=
 for more information.
>  .. [c-language] http://www.open-std.org/jtc1/sc22/wg14/www/standards
>  .. [gcc] https://gcc.gnu.org
>  .. [clang] https://clang.llvm.org
> -.. [icc] https://software.intel.com/en-us/c-compilers
>  .. [gcc-c-dialect-options] https://gcc.gnu.org/onlinedocs/gcc/C-Dialect-=
Options.html
>  .. [gnu-extensions] https://gcc.gnu.org/onlinedocs/gcc/C-Extensions.html
>  .. [gcc-attribute-syntax] https://gcc.gnu.org/onlinedocs/gcc/Attribute-S=
yntax.html
>
> base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
