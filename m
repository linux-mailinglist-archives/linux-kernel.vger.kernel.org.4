Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6466A6B3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 00:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjAMXKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 18:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjAMXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 18:10:22 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107772AE5;
        Fri, 13 Jan 2023 15:10:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v19so18279216ybv.1;
        Fri, 13 Jan 2023 15:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=12LpQywJJjBUt3FCMjBNpWZt4HLsrmq3D+lfWqk6LQM=;
        b=fRrF6T6XabAL4uomg1EBZjf0pG8RRsV9KFwYLgx0AgGZ5PzhyNocQe6FI8oroqiu5q
         eOfUU4c2+Ed1v+y9Z1doeIlckw+oOgbTct1ziWgWR6MX3BaWmALJcE/pMOtF1OK+BACi
         bULY/xzsuDVDHcvRw8Gw+Ml4y46953meYP8XqKxShlh2WaVgRkgYF5lo5q6m8G8K00kK
         cB1zYo2puvKiPeyUjvCOjNSWXVr/D+lb9iFTh07ISTck420D6q7SF4Bg5Nu4Q+NvxfmK
         4E1BucCijZaAtoAZJurv49EQz5dCPv5iIIydwMdAwgy0DjT1rvib24QS/PWyDbWZcqSa
         RTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12LpQywJJjBUt3FCMjBNpWZt4HLsrmq3D+lfWqk6LQM=;
        b=GkAIIyWWUjVDf7IHOz22ycUPzLghqzjih2MDaONJGe2mNOwtGrJ2FEI20PR/ZqFBDz
         iPTrYmkJeBkRP6GHbYe5BkCNcGVNT/7tdCKvDstz9NZexZpSlZEEIwGFrRBA2Tri2ezn
         yC6hpnTG2s0TQXgJbkXuRypIzYNFYuQUoZNJXXN9Ec6aJG6Qu1Ytc3zRfZ6hEZehV7cK
         /GTTWkXErmtrKy97s6tvcSJxVHb/Wp81MkVBni5ebZFsZU+KYpzEb5qUTkrPoBQ+7SG6
         NfYmRfr/mT7Qg44m0tBa6rrZ90IjNpNMwS9jpCk15vwdR9g6M/lN/eozOAdM1kUm5Whi
         UTIw==
X-Gm-Message-State: AFqh2kpYy1AsHaCmQ3pAUripsZ/4s5Z+jEJTRkcanwhj6hdwiB3BED7d
        om1Kv44y4C+F1ufoHtUY4061J8dfpeqol0aNotc=
X-Google-Smtp-Source: AMrXdXs0dEMNst1mDvKhLbzcUm5c3putoAqwcOSEik/6eKrko8ZBfOxL/z4F7QwYPbUY7iJt64JnMnFORkPuNWfECts=
X-Received: by 2002:a25:bc43:0:b0:7b2:343d:6b11 with SMTP id
 d3-20020a25bc43000000b007b2343d6b11mr4500515ybk.75.1673651421281; Fri, 13 Jan
 2023 15:10:21 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
 <CAK7LNATVJ5e=DnbJ++03iEMk0bN3-UvODBLkEKcYdSnJZa_tmA@mail.gmail.com> <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com>
In-Reply-To: <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 00:10:10 +0100
Message-ID: <CANiq72k6jCf_LP5vmBHKEpZ5njmH+u1HpJUjs_GyFi1a4B94ew@mail.gmail.com>
Subject: Re: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
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

On Thu, Jan 12, 2023 at 5:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> I meant this:
>
> if ! bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
> $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null); then
>        [snip]
> fi
>
> (">/dev/null" was lost in the previous email)

I used the error code in the message below. I am happy either way.

Cheers,
Miguel
