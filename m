Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0818D66AF1F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 03:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjAOCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 21:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjAOCsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 21:48:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF3859D2;
        Sat, 14 Jan 2023 18:48:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908AF60C12;
        Sun, 15 Jan 2023 02:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C385AC43398;
        Sun, 15 Jan 2023 02:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673750932;
        bh=kgaY6jbQpeo2Rmou/wW3RuGDXgok5CczcJfarE0vI8Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sBL5XlTf28rpF3PCr8Re4z/72+iDc+0PDzJNRTWB1UTOHsChRGH+zBWkn0tqJWCfd
         8K+McSv0Us+qyBMhCT4GtYopGHU98GMEeFAtWuBTwuo/POF8lESXYSef8jcwyWGbZC
         DxTft7d1pbfC8wTvxJG8VbqFEPUIKwD5QEhQ2lIrIFIKSOhdOFzqdIaQgG0v1X8ZK0
         ec3iNFqyMP3cgOueOfSaeUyD6Ov4gPh17cv0x4jon4byxvNBrY4lrCAbRzQeQ+zXYJ
         6TFoO0Bu39U4KoFaGniq2loG7g/3+ZPU9a0me3oPEc1i2HE9g26AM/UKYjWOG6mM8f
         2V+ucnScA+MKA==
Received: by mail-oi1-f181.google.com with SMTP id n8so20706176oih.0;
        Sat, 14 Jan 2023 18:48:52 -0800 (PST)
X-Gm-Message-State: AFqh2kr6bTTaPwfeWHJT8cPjvLyM0p1wyWFzMd6z5ssoumVOXtiZ1o25
        dx0lpOmCKYgrljGaPRr63ucR/Cfs9Kch2mWI6fI=
X-Google-Smtp-Source: AMrXdXsm9gUnwpvlhutyPpDTsOvXTiSoz/kxV5XIxQNp8ZH6wuffaVTW/E19Fs510l1dx+TMHxotrQpBFbYtyjei9Rg=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr5439109oia.287.1673750931973; Sat, 14
 Jan 2023 18:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-6-ojeda@kernel.org>
 <CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com> <CANiq72kyUr9PGYqHTsNzYn0_cyuYA0vAxHLC08ivxKo5XvOESg@mail.gmail.com>
In-Reply-To: <CANiq72kyUr9PGYqHTsNzYn0_cyuYA0vAxHLC08ivxKo5XvOESg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 15 Jan 2023 11:48:15 +0900
X-Gmail-Original-Message-ID: <CAK7LNASawny3wSTvjB8-CZJ2Mw8UnB0C4k5-X8yC8TyrmsM8RQ@mail.gmail.com>
Message-ID: <CAK7LNASawny3wSTvjB8-CZJ2Mw8UnB0C4k5-X8yC8TyrmsM8RQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] kbuild: rust_is_available: normalize version matching
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 8:15 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jan 12, 2023 at 7:23 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > Maybe, your purpose is to use sed consistently, but
> > perhaps you can avoid forking sed if you know the
> > format of the first line.
>
> The most unknown format would be the one of the libclang check, where
> there may be other lines before the one we are interested in. However,
> the pattern expansion would still match newlines, right?
>
> > BTW, what is missing here is, you do not check if
> > ${RUSTC} is really rustc.
> >
> > I can fool this script to print
> > "arithmetic expression: expecting primary: "100000 *  + 100 *  + "
>
> We can test if nothing was printed by `sed` for that (or do it with
> shell builtins).
>
> Having said that, I would say fooling the script on purpose is an more
> of an oddity compared to the case `MAKEFLAGS` attempts to cover
> (please see my reply on the other patch). So if we cover this, then I
> would say we should really cover the other one.



get_canonical_version() in scripts/as-version.sh has
a little more trick to avoid
"arithmetic expression: expecting primary: "100000 *  + 100 *  + "
but it is up to you.




> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
