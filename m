Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EDA6871EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 00:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjBAX2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 18:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBAX2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 18:28:51 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD991205D;
        Wed,  1 Feb 2023 15:28:49 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id d8so162615ljq.9;
        Wed, 01 Feb 2023 15:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1TJGIvRrjUyr/9IaggmaLPZelXPwdqIaj19FFw1HR84=;
        b=cfmC9qCNz6NafgTKqfctc3/FV1eJol6vi1JPQgIAXKAdYE/TO61FpTE7RaIFztDcBw
         X7dAEh/5GBCZ7Z/CMNG59rPZ1AlwQkQD4v56erQiNDlchRnP5LKmPQkWCp1sXRdb1Gcn
         Zf1tuQHwYsAmruGPXjofX98Cs3szAfaclKirr4GQ+SqA8g3cXK0YWwoXZUbpCQHXbw0B
         RmFCZclxe0RqH8SJnISlXfV7tpv5z3+eMHBBOUKq1dYK+TZAKjHnSpYNHXbMi3UYS1LU
         CWrb3jQnk5bYf/4WMqJ3UPIvY63YOPSG4I/CsbEdfXXeX91rCWE5oNdFxEu/vGUyx14r
         vK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1TJGIvRrjUyr/9IaggmaLPZelXPwdqIaj19FFw1HR84=;
        b=SUC3i6G63EGWqgGH+h2i3Ega4nWF9Q7SJlyUOT3SfUw2ubZmVM2iCZ/H+lRbwKs79x
         dmPk8oNruLTBFAAx8k6QkhChKrLUH+3s0Md8Em+zQ4LyAtO2mRGwGSLLXV8p762u7GkS
         RhPbSDem4fgoX9h4nSaH9hlIWyDiNDE7Q74lBcxYZmUHv/oMzExBR/QWuunWQnKM0GAb
         X+v2+dXaNNS9q0K+K2NUPzmwiigvnzgor4Hm3Tm53cdAFoO6lsKDzNtUnAWIsYRvdP5d
         MFy9/r4iXhj1AkGHcYLpDTp5OmrWNnrBanibHck8VsNbae9twkSSGspWb1rZf8E6SER+
         v/OA==
X-Gm-Message-State: AO0yUKUJ/FWPsTYdZgvcxAK4kahn0YSO7RjrfMwxLkve8OO0X6MBtYzt
        UoEefQMha1kSQ8WBPwKQ7FkWFogwG1LIfBjLOkc=
X-Google-Smtp-Source: AK7set9igR3QIgrtrWCvjA166/G4Bk0ijI+kCf7WjSnT+JQn8Ah14oogcJFxL9Gpoujs/RLjO/RtYvYjgH2FrdE8N+g=
X-Received: by 2002:a2e:5717:0:b0:290:4fce:f881 with SMTP id
 l23-20020a2e5717000000b002904fcef881mr606608ljb.126.1675294127194; Wed, 01
 Feb 2023 15:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20230201192509.4124319-1-ndesaulniers@google.com>
In-Reply-To: <20230201192509.4124319-1-ndesaulniers@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 2 Feb 2023 00:28:10 +0100
Message-ID: <CA+icZUVFjpZBL-kNJFkU+-L_23DuErcFKMhsquNmMSwFS+eEWA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/llvm: add Chimera Linux, Google and Meta datacenters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Kolesa <q66@chimera-linux.org>,
        Chris Mason <clm@meta.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 8:47 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> Chimera Linux is a Linux distribution from 2021 that builds its kernels
> with Clang.
>
> Google transitioned its data center fleet to run Clang built kernels in
> 2021, and Meta did so as well in 2022.  Meta talked about this at LPC
> 2022 at a talk titled Kernel Live Patching at Scale.
>
> These were important milestones for building the kernel with Clang.
> Making note of them helps improve confidence in the project.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Cc: Daniel Kolesa <q66@chimera-linux.org>
> Cc: Chris Mason <clm@meta.com>
> ---
>  Documentation/kbuild/llvm.rst | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/kbuild/llvm.rst b/Documentation/kbuild/llvm.rst
> index 6b2bac8e9ce0..6a37ab903e45 100644
> --- a/Documentation/kbuild/llvm.rst
> +++ b/Documentation/kbuild/llvm.rst
> @@ -15,12 +15,15 @@ such as GCC and binutils. Ongoing work has allowed for `Clang
>  <https://clang.llvm.org/>`_ and `LLVM <https://llvm.org/>`_ utilities to be
>  used as viable substitutes. Distributions such as `Android
>  <https://www.android.com/>`_, `ChromeOS
> -<https://www.chromium.org/chromium-os>`_, and `OpenMandriva
> -<https://www.openmandriva.org/>`_ use Clang built kernels.  `LLVM is a
> -collection of toolchain components implemented in terms of C++ objects
> -<https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM that
> -supports C and the GNU C extensions required by the kernel, and is pronounced
> -"klang," not "see-lang."
> +https://www.chromium.org/chromium-os>`_, `OpenMandriva
> +<https://www.openmandriva.org/>`_, and `Chimera Linux
> +<https://chimera-linux.org/>`_ use Clang built kernels. Google's and Meta's
> +datacenter fleets also run kernels built with Clang.
> +
> +`LLVM is a collection of toolchain components implemented in terms of C++
> +objects <https://www.aosabook.org/en/llvm.html>`_. Clang is a front-end to LLVM
> +that supports C and the GNU C extensions required by the kernel, and is
> +pronounced "klang," not "see-lang."
>

Nick thanks for the patch!

My ex-colleague Bernd Helmle corrected me - it's not "See-Lang" it's
"Klang" and encouraged me to work on ClangBuiltLinux.

"Klang" means German tone, sound, etc. like vocal tone.

That "sounds" nice (shrillness):
clangor (AE) / clangour (BE) - schriller Klang (DE)

For Bernd:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

BR,
-Sedat-

[1] https://dict.leo.org/englisch-deutsch/Klang

>  Clang
>  -----
> --
> 2.39.1.456.gfc5497dd1b-goog
>
