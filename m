Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D73A660D4F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 10:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjAGJn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 04:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjAGJny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 04:43:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6558B66989;
        Sat,  7 Jan 2023 01:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA34A60A3B;
        Sat,  7 Jan 2023 09:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9E7C43392;
        Sat,  7 Jan 2023 09:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673084632;
        bh=PhOJCYOc7RcUqVJNPzLzdYaEQtAZoKVd9doNS0XxjFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e5wkBL0D+aLU604jZHXa+QI84X1B9dGPwBSoYAG6mtaREU/e94nVQ62a/sLc3HwFP
         tw0DePUa/hh9yxURGkuMWalcPgxqpNFZa/TaBtog9Kd6ISIgKjarScBDv2qNV8E4AR
         xzXJ+/SnmLuGJUsz06LUHE9N/v777RIkWnh1UxZH7Z+8z2M3uRsbj3eeau5w/78Y6X
         obWKmFLZ5nC5wCFDZVq1dKJRheL4CYKrnrYJHX/nq4V6nFWGNG9ka03GwAv6k5Eygh
         2D5JoDBEfO39VGTW33kgD6ACaWaHXNHhcFNKx0F6OwO2/9yIh/AbC4oetfzm8VWfMe
         eczNoG175VPZQ==
Received: by mail-oi1-f176.google.com with SMTP id r205so3025199oib.9;
        Sat, 07 Jan 2023 01:43:52 -0800 (PST)
X-Gm-Message-State: AFqh2kqiugRbG7JX2qvY279b/WVOuof9J+5+3he3KML3R3GIbw9DwWKU
        CMsjWMQT8pZBiH5tIf1kl8LPJxOfem1JEpL78UM=
X-Google-Smtp-Source: AMrXdXvf13JhvOcKgxVFlmLtSuMDh/N3kFiICVwvyUGsaYjNLIl7Aiwly8PqFbncHD/inPs8IfGIVfiEIiKJUiQ/a8o=
X-Received: by 2002:aca:2b17:0:b0:361:24b6:466c with SMTP id
 i23-20020aca2b17000000b0036124b6466cmr2392654oik.194.1673084631503; Sat, 07
 Jan 2023 01:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20221231083028.1635698-1-masahiroy@kernel.org>
 <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com>
 <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com> <CANiq72=vgQRsBQO8Wwucj2aEout4hzbecgZcgg-W+e5s2WyaDQ@mail.gmail.com>
In-Reply-To: <CANiq72=vgQRsBQO8Wwucj2aEout4hzbecgZcgg-W+e5s2WyaDQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 7 Jan 2023 18:43:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKUX9S3K0TiQuRnnYB=WwQMuYjygGwyGMBYWwW5UbtQQ@mail.gmail.com>
Message-ID: <CAK7LNARKUX9S3K0TiQuRnnYB=WwQMuYjygGwyGMBYWwW5UbtQQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: move rust/target.json to scripts/
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023 at 12:08 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Dec 31, 2022 at 3:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > No.
> > scripts/target.json is a generated file.
> > It is generated in objtree, not in srctree.
>
> I meant `$(objtree)`, i.e. I meant if we should use a $(...)` prefix
> for clarity/consistency (even if it is just `.`).


I usually do not add $(objtree)/.


include/config/auto.conf is also a generated file.

It is inconsistent to add $(objtree)/
to scripts/generate_rust_target,
but not to include/config/auto.conf.



(obj)/target.json: $(objtree)/scripts/generate_rust_target
$(objtree)/include/config/auto.conf FORCE
          $(call filechk,rust_target)

is annoying.



-- 
Best Regards
Masahiro Yamada
