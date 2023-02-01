Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB168706A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 22:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBAVQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 16:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBAVQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 16:16:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C3C6D5FD;
        Wed,  1 Feb 2023 13:16:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C6876195A;
        Wed,  1 Feb 2023 21:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0E1C433D2;
        Wed,  1 Feb 2023 21:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675286212;
        bh=GjAJTCPxFyK/Ksgvsd+9f/hTN+Uz4VEAS+IvJJTfcQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VU5TuFGfDXYueW1KttmiC1CFnyMpUz7CaycnbbeKpduPd4yJf0jrGqXsEWvvS0E/L
         JJhK5NExglSo879CIZD2PNm0W+vqF0bJGAnpoVSIJjK4rueuVVS3o13qjDO6kETnXs
         dtRv/xFuiMt4EpdIvhmpttgZmr2REcWdNgI7rKljovic8XjTSJs5QuIwu4wkG69csw
         m/sF4F9Gff/92OsU2QtXKWKgv4HC3g1r/bgcsD/YptJS6rX7Bg/Ri0MaRmjtqIWl7u
         ePqmhi2GdwHabRq7VMtSkkRs8XpEhx1+3RnaZXULvEPDOmLN/caDtnS1xAwhbNYKDm
         IaVgY77YA36nA==
Date:   Wed, 1 Feb 2023 14:16:50 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, Tom Rix <trix@redhat.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Kolesa <q66@chimera-linux.org>,
        Chris Mason <clm@meta.com>
Subject: Re: [PATCH] Documentation/llvm: add Chimera Linux, Google and Meta
 datacenters
Message-ID: <Y9rWwmRkYnUiroFY@dev-arch.thelio-3990X>
References: <20230201192509.4124319-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201192509.4124319-1-ndesaulniers@google.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 11:25:09AM -0800, Nick Desaulniers wrote:
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

Reading a docs diff makes my head hurt :)

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

One note, the signoff plus authorship looks odd to me. Perhaps this
should be using Co-developed-by: ?

https://kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by
Documentation/process/submitting-patches.rst, "When to use Acked-by:, Cc:, and Co-developed-by:"

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
>  Clang
>  -----
> -- 
> 2.39.1.456.gfc5497dd1b-goog
> 
