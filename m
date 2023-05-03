Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897D16F56F4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjECLIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:08:33 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF1F4EDE;
        Wed,  3 May 2023 04:08:24 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-555e853d3c5so46802447b3.2;
        Wed, 03 May 2023 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683112103; x=1685704103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XRvyoBO4AO/TxyQQrkvIAn6f4aXp991XpmSJsSj6DU=;
        b=nhlejzrMxeYuUoeujbaHc5FMHwmvv/DGMh0WX+wsc1bbiAHYEA+A8GoOLrvnU6FdVj
         26RUneDIB5GxIJvvBC4/1K09Pj+2lOaxykc3lvianocnz5ZJrIodOCUMs9da1PnotP81
         3Jq57/TSK2lw+7a5ep245cMtaZC8bYlpeinLG5VvdmEbmPcpcrLnUhZkSadMIaJc3xER
         4Sofz71yS95/fAkOl5KAhZB2t2xn1UlfFjWI766MZ8wIetRdWk4whdTM1VMuuxtwtFWB
         SWLpbDVZotMkx/FdOoJtylrLpH0eViARH+c8+jpXLVGeUcnugIq5LBYjqbIrHY4UtBYM
         OHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683112103; x=1685704103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XRvyoBO4AO/TxyQQrkvIAn6f4aXp991XpmSJsSj6DU=;
        b=XSc+I7f64Ymyv5qd82MPT7zPSbH0CEwB5Bl4PE2UICl2LXs9FneXtCvsImcMV+aTkN
         tCqv9jQZiQY6ZFExlTL9B3lt+ZolIIUtP5Ts1reZEFDNYcDgzEfCk8D50GloVizSMjMW
         AIqQGT13cLhZWBWeOOt8QEBusJkHd942V1IT7n7B//eiMti1Wdy2MZRg46iNQcCPYPdy
         zVhLJ7cTjGnjr/dxlipEj6EgobM8QsI3crAsLq4YmUgAum6YVhm3VI+y0PK4LkbNRf66
         lldXVUyAWZPGYq250CswsHcewdQ6BBBrAxwntCGNXG9Bdwm8L2qoCi5zdQX3U/lxICcg
         G+ng==
X-Gm-Message-State: AC+VfDybonaiA7i0keoaFuXrnVB0jSyCCAs1A8PBjC3yY9uc8rCZCSZP
        YFydlR4Bo/WNyVNsy6/n74Ytqd7qzJOwSCnLkjo=
X-Google-Smtp-Source: ACHHUZ7piRrKAF1UtoNrQ8bYwi3fDJtg2cWK9hVNdVr7ND314M45ivGeyru0TGopRmeONqV0CAmUNZG5DucwB5W8myk=
X-Received: by 2002:a81:920b:0:b0:544:5b74:cfe with SMTP id
 j11-20020a81920b000000b005445b740cfemr19305504ywg.6.1683112103572; Wed, 03
 May 2023 04:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230426224748.34056-1-materoy@proton.me> <dIXozfBEyCqYQ9-l0IgxfaoL6paYc_6NjXMxHp3qUqAxQdF-c5qRoULMp4K_Lv4bCOPRez2c_4v4PuFKMysFxhNkK2r1t0grU89YosKzTbE=@proton.me>
In-Reply-To: <dIXozfBEyCqYQ9-l0IgxfaoL6paYc_6NjXMxHp3qUqAxQdF-c5qRoULMp4K_Lv4bCOPRez2c_4v4PuFKMysFxhNkK2r1t0grU89YosKzTbE=@proton.me>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 May 2023 13:08:12 +0200
Message-ID: <CANiq72k5LyriTgTnYwVVzJLROoq-VEZra=WbwKBGh-O6a+guqQ@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: fix sorting of rust/bindings/bindings_helper.h's
 #includes
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     materoy@proton.me, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 12:45=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> A couple of nits for the commit message (these can be
> applied by Miguel when picking the patch, if he agrees):

Given this is one of the "get yourself familiarized with the kernel's
development process" issues that I create from time to time, it is a
good opportunity for Roy to fix those and send a v2.

Roy, could you please do that? Please pass `-v2` to `git format-patch`
when you do so, then also collect the two `Reviewed-by`s you got and
put them above your `Signed-off-by`.

> - capitalize 'Rust',
> - add a `.` at the end,
> - remove the newline between the tags.

Also: typo "idoms" -> "idioms", and the title could be improved to:

    rust: bindings: sort `#include`s of `bindings_helper.h`

since "rust/bindings" is already given by the prefixes etc.

However, what does it mean "...and rust idoms"? This is C code, not
Rust code, and thus it should follow kernel C idioms (which, in some
cases, do sort the `#include`s too, so that is fine).

Perhaps remove that bit, or say instead "Rust subsystem idioms"
instead (since we do want to keep them sorted :)

Thanks!

Cheers,
Miguel
