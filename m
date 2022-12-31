Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC08F65A4E0
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiLaOZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 09:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLaOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 09:25:15 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B66F5FCE;
        Sat, 31 Dec 2022 06:25:14 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id n78so26126401yba.12;
        Sat, 31 Dec 2022 06:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7Hs8S2xbbpkpRDKrcN4xZsuFrJmgIIakXDfhMVQYTU=;
        b=dDpgYWewceRnnbtSrfGHiZKrD7uMQIRTC/lE8JRxvqpDJ6Lq0xdzk71WFsvzjebIPG
         42NQHo6EoJEBZHz6NdAoLEJdClOe8Kgc3wmHwUYcKZEEcTdfSISxQQFpA7t16FV+8hqo
         P0BuRAdfWVlH9AdaS0HBL4mM9SvfAORZ5UTj6bObMaSLtlYV/x/P72EXULV8aq3eINjj
         GXRui+SjxbyraKJSZ7t1Xup2RMe9G1ps+NmNFxpAEWfJMT51Hrd2gRSx8KGXFzoWGOOj
         /KW/rFYUv5Z7AiC9T8TJeKSO//LGdLzsqF5Q237ud2iYGv//Fh3T3y9wmicJMVGygYlU
         gViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7Hs8S2xbbpkpRDKrcN4xZsuFrJmgIIakXDfhMVQYTU=;
        b=ekXc4+Vi/KkAjAywWYtMyWuz8mxsuvXAFa+akIJzCG6IOLZ9t+JChCGCcEJ1LNZd9k
         jJBXOnKH/93U0Itr/V9c6P8/C2tNnvLHVstSbW1LM190xoAfmlSLuc4k1HDwqFatIUvg
         9KRL/44Q7v1ieC4R93QCiufNA53EFQ7JaTxIFOtWbBUURuP6lPQ0VIkRh0xyRuNMiPCu
         XDr7fCV1f3ayx1k4I7hKruAfoe8zNApfmZF73qgoVgmPC1wx6ElrPSAcuqbXM12TL49O
         3pABo+GN3JwFes/Me9zeVIdRqSjAzM5kS1/fe1ruXjG2RVCp7v9355f9azGfUO+zyUdp
         yiKQ==
X-Gm-Message-State: AFqh2kpPMbBznZQRHCv//OUOQxJe9I8QxmwfdC8M4DCm/Iiv5fSYSFOj
        mUhG8C65mwbMMlVSPVMvm7jEZDKjW8kRelUZdqc=
X-Google-Smtp-Source: AMrXdXvIYh1s5/WNW3ca3DCIvcpgVZcoqAb8Z3LehWyzAN4GpvOSbCC5CDc0k6KazM7ZHF+1UQ9Q2IBU8vN+de5EEkY=
X-Received: by 2002:a25:7653:0:b0:6f9:13cc:de91 with SMTP id
 r80-20020a257653000000b006f913ccde91mr4113828ybc.328.1672496713523; Sat, 31
 Dec 2022 06:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20221231083028.1635698-1-masahiroy@kernel.org>
In-Reply-To: <20221231083028.1635698-1-masahiroy@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Dec 2022 15:25:02 +0100
Message-ID: <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: move rust/target.json to scripts/
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Borislav Petkov <bp@suse.de>, David Gow <davidgow@google.com>,
        Helge Deller <deller@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
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

On Sat, Dec 31, 2022 at 9:30 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> scripts/ is a better place to generate files used treewide.

Agreed, and its generator is in `scripts/` already anyway.

> You do not need to add target.json to no-clean-files or MRPROER_FILES.

Maybe adding something like "If moved to `scripts/`, then (...)" would
make the sentence a bit more clear.

(Also, typo: `MRPROPER`)

> -$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs $(obj)/target.json FORCE
> +$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE

Should this be `$(srctree)/scripts...` for clarity/consistency? (I see
most instances like that elsewhere too)

Cheers,
Miguel
