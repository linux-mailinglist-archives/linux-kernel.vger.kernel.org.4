Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8359165C853
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 21:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbjACUpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 15:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbjACUpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 15:45:02 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC8EF0D;
        Tue,  3 Jan 2023 12:45:01 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id c124so34397653ybb.13;
        Tue, 03 Jan 2023 12:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SeLnyRcrosxbe7zf1NVtqwd15UENUyCvBtMhWBv4YcQ=;
        b=RgsXiF/LZxqKxVwy3PS7+xLpQTNa5yod6qXTeC6WE/1PoBqYtaLZEw+O1KnICdjsuF
         FVbislKOQciha5Os2si2N3f2G8cuUuMVJn+fk8OKGMSQYwcLMdpOn0/0Htijta8tVhGN
         2vU2rE6dyi1QmX2Sto+c47Vxcj7VlwgRPQCJQS1UeUd6qObj8wW0n+IxU1oirVG6KO+r
         fX5iytG4iLcfqzIa6kpPNDTQX3YYxYG4NY6Pa/xIRyZpX76K5KY5c4Yf9Pm0m9tY9rqc
         ts7HHaLxV2QINzyCIFqvIjaEqYDlWd9nWDY+UjW+//cGgGGPYyn5UjxyzvDpAozK0lVN
         yPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SeLnyRcrosxbe7zf1NVtqwd15UENUyCvBtMhWBv4YcQ=;
        b=hSfTiIY/xg/84cq+DrPnKz1PEJhidGnK1MgTG4PICKF0s5/u3/rYRW6rhMW5wY797P
         r/+Eu21JhUvveIkMq8dU5yC77RLsohfrZzvQ56HsBJ1xNiY+RHLN7jl3Wm+KKbbxaXU/
         Iijfb8CwPFpHE/0/ZfO/YtR/5v4HcD3gs+O7i9P8pl8uvukGlGn2z809bAoSeXmaHKD5
         81/Qtqt6rJNCA0/24uZP/BWRrcCCIy9WK5KgJTjJ+1MCySlCg74yvyVGLU7oFwnzSx7T
         0DyDkEOPKr5q6X99w5XS2J8NNCy2sV4azwRyO1oDTGMZzkRXZzDlTnuPb9uHX/sReMuj
         cf/w==
X-Gm-Message-State: AFqh2kqIk9kKtRO9aEvFS8ommTTmiQhf3YTl8Os8MWmwf9VMbashwtpD
        hbRQvXacAFW4MzcPuXq6P6RjpBC1iS47fZ1Xocs=
X-Google-Smtp-Source: AMrXdXu0aI6zgR44lJkZQk5J/ah2nhc8d7y8bZuvOHZmmoOGaXFvRF8UKRfA/3TxipvjPYEdZM+Vjy2tLh5Ul5tIvb4=
X-Received: by 2002:a25:ca4d:0:b0:771:56e1:e4e9 with SMTP id
 a74-20020a25ca4d000000b0077156e1e4e9mr4244307ybg.75.1672778701030; Tue, 03
 Jan 2023 12:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20221231064203.1623793-1-masahiroy@kernel.org> <20221231064203.1623793-2-masahiroy@kernel.org>
In-Reply-To: <20221231064203.1623793-2-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 3 Jan 2023 21:44:49 +0100
Message-ID: <CANiq72k8LSqsnWNd_aa-M1=rMNLWD7KJWrK6Pv0Waq15Exv59g@mail.gmail.com>
Subject: Re: [PATCH 1/6] kbuild: specify output names separately for each
 emission type from rustc
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        llvm@lists.linux.dev, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 7:42 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>   $ make -j$(nproc) samples/rust/rust_minimal.o samples/rust/rust_minimal.rsi \
>                     samples/rust/rust_minimal.s samples/rust/rust_minimal.ll

Yeah, we were testing the single targets, but not multiple at once, thanks!

> +               --emit=dep-info=$(depfile) --emit=obj=$@ --emit=metadata=$(dir $@)$(patsubst %.o,lib%.rmeta,$(notdir $@)) \

Perhaps a newline here to avoid the lengthy line?

>  hostc_flags    = -Wp,-MMD,$(depfile) $(_hostc_flags)
>  hostcxx_flags  = -Wp,-MMD,$(depfile) $(_hostcxx_flags)
> -hostrust_flags = $(_hostrust_flags)

This was originally meant to be consistent with C and C++ indeed, but
if you prefer less variables, I guess it is fine, in which case,
should we update the C/C++ side too (in another series)?

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
