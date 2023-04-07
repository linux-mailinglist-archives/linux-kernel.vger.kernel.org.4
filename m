Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076EC6DB778
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 02:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjDHAAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 20:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDGX76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:59:58 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8FBB96;
        Fri,  7 Apr 2023 16:59:57 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id z9so94624ybs.9;
        Fri, 07 Apr 2023 16:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680911997; x=1683503997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGZafIXu1oZoLrFZaJuaTlQovGr7le+3cdq/cC4fsMs=;
        b=mVY1J6nlfbu/iYNUUB1czpzlhOwb6wotQJWPnqexv2JfgOnhKeRX/F+x4jXLi4KF4T
         u5xIxlRTrqStnOiox2EguzbvIiDwEd8bQ8owcaDQeXZd9bVw7BgD4FlfQmdQvaR8lTQ0
         mtjFdli66KAO9crZx1LlPIcO+bVH4674rJE6gG+7Pg9ZI84IdnHA8Sk8foPtKdqgZiCn
         Wk7LMnTUMXIcM0dj+S40slHKAXaq/vP0jokBTgo/7dLNggylJuApVWHPCxgRIWshDvXm
         n7lpCF9BHx+UCQnJC64VpxS2/y8hIdOpyiByxo4jj46wiSmlm2HaG7HAG0PxzUdBSEX+
         pFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911997; x=1683503997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGZafIXu1oZoLrFZaJuaTlQovGr7le+3cdq/cC4fsMs=;
        b=dS+2UYZxyzZKEEnlO1npA9Lsr4Zu3NRindkPxHPkvW9EWZzpQBtEkM60QML7NT811I
         GrQuZQ0cdmGmDHCG1bMX8TH3zmXbYDnqvkwlVICC0jyDlAxIK43tvJmKy3b7KKawkbKO
         LkoSo0uT8GmOM39hz3sCn4qomXIBeVQrcuBgMStKE8F/c5Tt+Fvkjm6BPIko90MmdEd9
         dPGXZ98D4fKiLNww4vMVFaXVh81mEmCFGKnWnKaGchupRnAa2VQjBfEbuBBszeNHyA53
         +dKhVQEPJauYoEuOAt9LjxI5K0hMVlz0FOL3arfHGeIVSKCJaIwSoGthZqqq2DtkM0Aj
         B+VQ==
X-Gm-Message-State: AAQBX9eucAJ3hEzQifXPc6dFerZXuWkyYlEMdIr7eqMK/81jY8B60GDm
        7RJNXR5OlYvBCcAqMg11PNdJwrEh1F1GhsrbF0o=
X-Google-Smtp-Source: AKy350ZpczCV/ZtLHhbbuXp2lBGHxIpWYiQmG6s+QUOx8PqHwoFw68K8f5Hrb4p88m8kd/Us5psKv5+ktMAeBr1z4Tg=
X-Received: by 2002:a25:df47:0:b0:b8e:ce2d:290a with SMTP id
 w68-20020a25df47000000b00b8ece2d290amr337491ybg.11.1680911996813; Fri, 07 Apr
 2023 16:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
 <20230121052507.885734-1-varmavinaym@gmail.com> <CAK7LNAT1p=ykc1yruvzRiYthCAuXNcLq9461Mdgz95Z39_MYxQ@mail.gmail.com>
 <ZAdYIMYAwsOwErIl@nvrarch> <CANiq72=mg3LEdqaiy+4VDn67-C++Fyz21gefns_EvgUwGfPCTQ@mail.gmail.com>
In-Reply-To: <CANiq72=mg3LEdqaiy+4VDn67-C++Fyz21gefns_EvgUwGfPCTQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 8 Apr 2023 01:59:45 +0200
Message-ID: <CANiq72kD_ESDSh-gVmUS18HtVmkY=bgxkR7Wo=OiwfMyyD8EFw@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, alicef@alicef.me,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 8:55=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> No problem -- thanks!
>
> Note that we may need a rebase after
> https://lore.kernel.org/rust-for-linux/20230307120736.75492-1-nmi@metaspa=
ce.dk/
> (or equivalent) lands in `rust-fixes`. So perhaps wait for that, then
> rebase (especially if we go with the EAFP style), and then others may
> want to give it a spin for a re-test.
>
> When you rebase, please consider putting `f"{name}.o"` inside the
> function to avoid repetition, and perhaps consider inverting the
> condition to avoid indenting the file further (and reducing the diff).
> It makes the "Skip ..." comment more understandable (otherwise, you
> may want to change the comment to "Only process ..." or similar
> instead of using "Skip ...").

The EAFP style change landed in `rust-fixes` at
https://github.com/Rust-for-Linux/linux/commit/5c7548d5a25306dcdb97689479be=
81cacc8ce596.

Cheers,
Miguel
