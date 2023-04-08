Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06626DBB36
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDHNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjDHNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 09:42:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C832CD53C;
        Sat,  8 Apr 2023 06:42:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F67D60959;
        Sat,  8 Apr 2023 13:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5255C4339E;
        Sat,  8 Apr 2023 13:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680961323;
        bh=+rvCJwQnhgHtRPTA4FpOWMqeq2UPBg8NLPxv4nEuxX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j8wXnh8jcxeZy5hlnL9j7yhf1PfZDoBKolcpy8BAI3zytnC6o3YeEcQ21+RGU398S
         lwlY1lX1+rGmxa3RW1a4ssgZVrMNHXDCC6WIPr8GtoapHSeRq8QJ4+1MkRoPe/q1co
         pBZRK9TS0XYB4rlCrpX5ng+gaXL15uri2QVjR6Fo1l66G9KP7d7+87JoNRfKRWutR0
         HW8KaNz2q7SbsqNYO02xV8LQKQ8X11uv0ovd00bz1EsLtjqCS292zKcsS54/wMPkBY
         +uoYQ0p8nmdgW2/VffK8mE2GMfG1FpQRopt7rW1Yx0C1UStZhRxsOGAwfAxnow3PDU
         QQ1B9czlK0ofA==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-183f4efa98aso7338404fac.2;
        Sat, 08 Apr 2023 06:42:03 -0700 (PDT)
X-Gm-Message-State: AAQBX9dA5dw3P+QzJm+QO4Nf7oxi0zIrxD8wfTvooJpOm7DS9gZ084xA
        Nfodljys+vmFyg7Xrr+jn2PFxFWa1zyZs9s8Z9E=
X-Google-Smtp-Source: AKy350YM5FAGa/kRWBMoLt816ScO0UDcA4Pm4t4Ada1UZVKLZfKRP4ulOWZgDvkSe3Ul/chuG7STZWY4sSR50yAJtLg=
X-Received: by 2002:a05:6870:1119:b0:17e:d9e2:a55c with SMTP id
 25-20020a056870111900b0017ed9e2a55cmr2268082oaf.11.1680961323046; Sat, 08 Apr
 2023 06:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230407070517.204676-1-andrea.righi@canonical.com>
In-Reply-To: <20230407070517.204676-1-andrea.righi@canonical.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Apr 2023 22:41:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNATG0rmbV79Uo8a8mX5uFNn878UbP0BEJ3c=cYSsO_a3ww@mail.gmail.com>
Message-ID: <CAK7LNATG0rmbV79Uo8a8mX5uFNn878UbP0BEJ3c=cYSsO_a3ww@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Eric Curtin <ecurtin@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 4:05=E2=80=AFPM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> Commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> introduced the constraint "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE"
> to enable RUST.
>
> With this constraint we don't need is_rust_module.sh anymore, because
> 'pahole --lang_exclude=3Drust' already has the capability to exclude Rust
> CUs. If pahole isn't recent enough (< 1.24) to support --lang_exclude,
> then DEBUG_INFO_BTF can't be enabled with RUST and is_rust_module.sh
> isn't used as well.
>
> In any case is_rust_module.sh is obsolete and we can just drop it.
>
> Link: https://lore.kernel.org/lkml/Y+p2xKIN6TJnQinK@righiandr-XPS-13-7390=
/
> Signed-off-by: Andrea Righi


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada
