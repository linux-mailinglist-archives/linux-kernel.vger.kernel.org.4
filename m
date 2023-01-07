Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D1660F93
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 15:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjAGOpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 09:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjAGOpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 09:45:30 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89A158D24;
        Sat,  7 Jan 2023 06:45:28 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-4a0d6cb12c5so58487337b3.7;
        Sat, 07 Jan 2023 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c42PqleJT+CrwpE/0wAr6VFhbnZEn57VzvNCINiN8M8=;
        b=jzKHU6LcN4Sn5jJZHxedhEokm2C7gulg+3A52BKPn3TflJS5NTIfUzY6KPVLFUexU+
         N/sHftJLbIhv7F038duKuUOPGZVztQh9Xt9JZrjiwUMYfIr/CAh7Jnypj14ZZCFOFRzJ
         +ItqmOEZTdkYsEX9Ul6Ej6ftIPLTUGs6DeHzEPCliec7iSeyZMpptFPxp14sYSZ3lkFL
         rF+EPT8urQIngRgSm8pA18JX84MRrYa52rigJi9nZ+0fbB9SfkQ1ksFwaMYWCLP0ENot
         bPZi2uShl/fqKPDp47tFbTACYQwuuJF8CGDtIkw8nFjNX9Featcvrgx0H9+L8o7krox8
         RVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c42PqleJT+CrwpE/0wAr6VFhbnZEn57VzvNCINiN8M8=;
        b=S3eH6B5irYNsc5gbRH8398AHCJoG1iIDrdQzevVO4d8cxp+C0IaO0nasEA8oCJv9Dx
         wrF9ozn71vNYwKXAwmGIR46D5RH89J0FsxOXNo5a1BH6V5K8XZw8vk4UOrhEIgVBxUgK
         EvlRXHA4zphgAc2h0vbQZUbD+b40BYxkAuiZSVLj9fZ+4WQJUOLfdwYRjfB1NdNaKCzW
         DlXDqk2rDaWO7WC/ymMmwhZj7zfUMD5g/dTpwF1zy/Qz2xOyfOgzVOZ3iHkcmpAbu/oZ
         qkAnxSuW1tu8+MFvVp/gsLBD8w23YZ0uQy/d0kjwnQMtPI+7GBOVANREH80aq4zi7BfY
         AKqg==
X-Gm-Message-State: AFqh2kpmqG7r8saHthTXVs46gnMaD1D0N+smMEoPGMzfkzu8BRfKfwjN
        aIn9BxCu0svo7/xCwDh1OlilsyC/X0Oh0henZnE=
X-Google-Smtp-Source: AMrXdXt79BWq/11+rFBgsU43EqyS061ANwERlSY5Gd8B5vK8RBxRlH3O2bkP5YTISEO/NAJibaCoLDrXp3sAIhDFgwQ=
X-Received: by 2002:a0d:f601:0:b0:3d8:8c0e:6d48 with SMTP id
 g1-20020a0df601000000b003d88c0e6d48mr561810ywf.462.1673102728122; Sat, 07 Jan
 2023 06:45:28 -0800 (PST)
MIME-Version: 1.0
References: <20221231083028.1635698-1-masahiroy@kernel.org>
 <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com>
 <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com>
 <CANiq72=vgQRsBQO8Wwucj2aEout4hzbecgZcgg-W+e5s2WyaDQ@mail.gmail.com> <CAK7LNARKUX9S3K0TiQuRnnYB=WwQMuYjygGwyGMBYWwW5UbtQQ@mail.gmail.com>
In-Reply-To: <CAK7LNARKUX9S3K0TiQuRnnYB=WwQMuYjygGwyGMBYWwW5UbtQQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 15:45:17 +0100
Message-ID: <CANiq72nUuqqiRmLmmzAeZgK1D6kZJb9XLKAza02SzyPT=xgzZQ@mail.gmail.com>
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

On Sat, Jan 7, 2023 at 10:43 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I usually do not add $(objtree)/.
>
> include/config/auto.conf is also a generated file.
>
> It is inconsistent to add $(objtree)/
> to scripts/generate_rust_target,
> but not to include/config/auto.conf.
>
> (obj)/target.json: $(objtree)/scripts/generate_rust_target
> $(objtree)/include/config/auto.conf FORCE
>           $(call filechk,rust_target)
>
> is annoying.

Being consistent sounds good to me, and I agree there are already a
lot of `$`s around in `Makefile`s... :)

In general, I tend to prefer explicit over implicit -- it would make
non-prefixed paths less ambiguous on whether they are relative or
anchored to the root. And I guess it could help reduce confusion, e.g.
`arch/powerpc/boot/Makefile` mentions:

    # clean-files are relative to $(obj).

Either way, it is fine. Thanks a lot for explaining the logic! I just
sent a quick patch for Kbuild docs since I noticed it was outdated
regarding `objtree` for `clean-files`.

Cheers,
Miguel
