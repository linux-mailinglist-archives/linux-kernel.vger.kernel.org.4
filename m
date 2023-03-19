Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5C6BFFF7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCSIKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjCSIKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:10:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8856017CFB;
        Sun, 19 Mar 2023 01:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B8FCB80ABA;
        Sun, 19 Mar 2023 08:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AABC433D2;
        Sun, 19 Mar 2023 08:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679213413;
        bh=a5va3tEE4tXt4RbnY9wq9cGeJVVqrZTJXQVaAqJNs7I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t7Iw70ya9uQVCK20e6iFJax7/rZjaTW+nRxkgQeVhV7DVrNROAGSKMSZGybf9JXGG
         7z0VvNYUz5Xc6s96Usezq439boIWBXvInF1+XCUfzv3chvyA0nqbHB/DNF8/wErE6s
         L5FSY+qYRQqjkXou2o6DiUv7knILXdlxRCZD7tyclnXwpbN7rqr9hTikjVaqjmrMl/
         cl/YjMnDNGrZGHNyh3sCMKVd872VIoZpB6/7HvEqt88TQk4phDu4M0Q6ROXywQftr6
         HLqMfMNN6nSmyfI4NsWQZ7S54O56duC2+ztzXHMd0i4BNK/cM3BOuYZWl8rFeWPXkg
         WfI5Q9MBKVBcg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-17997ccf711so10210678fac.0;
        Sun, 19 Mar 2023 01:10:13 -0700 (PDT)
X-Gm-Message-State: AO0yUKXjIdj6JODZrhWXWHx07tBdJvyYjDRLTHl8E7R3Po4nCdOYeeb6
        vzzPkyePJbK3u2MSrtTxmfYjrK/U4LfYHx/dXM8=
X-Google-Smtp-Source: AK7set9E2ZsG/UD8QjqMoQ5NEHggJTNBfQWoUR0XzMx0OFjaipPPxI8WOQASYdT2zBZ4z08XLIWoinwIvyWaOajnHOw=
X-Received: by 2002:a05:6871:e85:b0:179:c3d1:42d0 with SMTP id
 vl5-20020a0568710e8500b00179c3d142d0mr1239161oab.11.1679213413097; Sun, 19
 Mar 2023 01:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230314004022.403937-1-bage@linutronix.de> <20230314004022.403937-2-bage@linutronix.de>
In-Reply-To: <20230314004022.403937-2-bage@linutronix.de>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Mar 2023 17:09:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJtiRkuQNpG7fhmwzOszi09W3PuDqojkCizNP5rxepig@mail.gmail.com>
Message-ID: <CAK7LNAQJtiRkuQNpG7fhmwzOszi09W3PuDqojkCizNP5rxepig@mail.gmail.com>
Subject: Re: [PATCH 1/1] builddeb: Eliminate debian/arch use
To:     Bastian Germann <bage@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 9:43=E2=80=AFAM Bastian Germann <bage@linutronix.de=
> wrote:
>
> In the builddeb context, the DEB_HOST_ARCH environment variable is set to
> the same value as debian/arch's content, so use the variable with
> dpkg-architecture.
>
> This is the last use of the debian/arch file during dpkg-buildpackage tim=
e.
>
> Signed-off-by: Bastian Germann <bage@linutronix.de>
> ---


Applied to linux-kbuild.
Thanks.

>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index ff5e7d8e380b..ef43e8937f25 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -99,7 +99,7 @@ deploy_libc_headers () {
>
>         # move asm headers to /usr/include/<libc-machine>/asm to match th=
e structure
>         # used by Debian-based distros (to support multi-arch)
> -       host_arch=3D$(dpkg-architecture -a$(cat debian/arch) -qDEB_HOST_M=
ULTIARCH)
> +       host_arch=3D$(dpkg-architecture -a$DEB_HOST_ARCH -qDEB_HOST_MULTI=
ARCH)
>         mkdir $pdir/usr/include/$host_arch
>         mv $pdir/usr/include/asm $pdir/usr/include/$host_arch/
>  }
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
