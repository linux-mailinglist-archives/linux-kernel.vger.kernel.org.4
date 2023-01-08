Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971C16615A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjAHOAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbjAHOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:00:06 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A241101D0;
        Sun,  8 Jan 2023 05:59:55 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id l139so6322229ybl.12;
        Sun, 08 Jan 2023 05:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j/huaWcf/wNot1L+tQ1khzuDXGBVMKYzsCxPwSk2Wd0=;
        b=kv+yArOYblsaDJGpwaN2kdNSGeGZrb4V9MOO/Z2cTE2lQG3aKpSf0pjAB0fZTkIjOH
         fitmC/Phz5XwI5sPOkEMdDzhIwhYDNylZGk7/C2uCwosyfacaoAR4zfdey5edUG8mDTo
         1FqEa/HrrJTSaojUx2rrJzQGO1yqhD6sWEWbdWRUsHb3u6g1HiN5BEM3y+nLF90e6tCY
         3VX20bUGqgA1nNop7mcNLVcztJZpW5z/B5J9/RZGsVSL/S2yZqGqQjQWXmHVHcu9LOby
         2C2HXWBhZt1m5FfKjkFAYTwFIFKDzR8EiWyY2puQBDOGh6xL3bgUDlLuSl1EUJY3ydo6
         4WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/huaWcf/wNot1L+tQ1khzuDXGBVMKYzsCxPwSk2Wd0=;
        b=5/fBjahkEvas82ueP7KHvpVDsQI+bKKcOROwPvLiJjC1BRN7GYk3eVeYl7yhRoxRju
         vCGgqmcd25bQF8/pTKLO3i+lwJukg9cv3wRODPiyxZWD8buDccYis/JBO9BvICkzmYho
         PcPaV3CirjTzGMpt+Z423fwNJ7XhpOGTtI0hMmbi08LIiNy33tCQ7QQB7K/5HsZvt+mj
         vs82LSEBu29cB+1CMr7Uy9ZAy3sta2PQgmogMm5Tu+n2jj3KqceV5IT2nysf4IFZi352
         1umXULOkrepp+g3Uw3pdVZdF5PoWP8yRhskm41wJXcHtBJGTc09BIM79UXbqv3kgE5ob
         0MCw==
X-Gm-Message-State: AFqh2krJt2zRCa6IINry8SqhiQvMXiUNVdqPqloMfnbMWhm7ydtb2t5r
        NN6eDty6Qv2S9GE5/a1I7PqLiSTAbV3soifODt8fMoGObPmCNdyHKvstYA==
X-Google-Smtp-Source: AMrXdXuwdsGKbhywEnrM+ME7ZJe9y09eQz+XfNyLKOQ4XmrnS1AS40weI9iuZ56AKMmqnyLKIfkYjFxSDgk19ks1yyQ=
X-Received: by 2002:a25:bc43:0:b0:7b2:343d:6b11 with SMTP id
 d3-20020a25bc43000000b007b2343d6b11mr1997224ybk.75.1673186394385; Sun, 08 Jan
 2023 05:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20230107094545.3384745-1-masahiroy@kernel.org>
 <CANiq72=q9pk2ZB2K9Zjn-COY1KD3MFAGthx7VJ_2YmtH61tdng@mail.gmail.com> <CAK7LNAQHqMHyX75MAwG6vh0V6Op_EGRXzprnBiNPeDmUuhHD_g@mail.gmail.com>
In-Reply-To: <CAK7LNAQHqMHyX75MAwG6vh0V6Op_EGRXzprnBiNPeDmUuhHD_g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 14:59:43 +0100
Message-ID: <CANiq72=zFqopMpwO1k=ZueGX=85=P4nRU+67bRCq-aS8bMuNyg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: move rust/target.json to scripts/
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Sun, Jan 8, 2023 at 2:49 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Please let me pick this up to my kbuild tree.
>
> If I have more spare time in this development cycle,
> perhaps, I may refactor the code a little more.

Of course. And thanks for all the cleanups again!

Cheers,
Miguel
