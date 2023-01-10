Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ABF664077
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbjAJM2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238402AbjAJM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:28:38 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1C45F98;
        Tue, 10 Jan 2023 04:28:37 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4bf16baa865so151042657b3.13;
        Tue, 10 Jan 2023 04:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2vRpvlz/nTbkuUWpiT0ilG/Sg8qqMAAl8bfBXBzFCxg=;
        b=iZLPUyiqSibhLkBnGrBg3hGw/AMODHqYyvgvfr2R0O/W7SxuuDn6gFWytT2k++2EAy
         HczFFtSB/qhgr2f28uXRl0+zWfU/7MyOBwKXvKOfQ2+5YLVIGPKOYHchXMbzGL8eGxYO
         99ff0hquQQ0oC98c+Dt/gHwxYsviqX5NbsfKsNa0QySsneUCNurnCeEqGczdy0lnkKRY
         hIuExqvBgRRtwS6luRBMKaVVm3E7ta64yQY+oxG/EzVm0RmPurL+LXtxBx/Cx9URVulo
         i6EaKBELkj+AHHg1ejZyDFOvdWAK9HsIT6fLlgt8ytGSty0HtfM25Wq5SQb+7svTpzLQ
         MaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vRpvlz/nTbkuUWpiT0ilG/Sg8qqMAAl8bfBXBzFCxg=;
        b=u0tgp45ziOg0XdgjquieWhinUKdb+0Eyw/uE6k0xzzMQcOoCoMbN6jlRWp6AUkqUQl
         cwZ8kpqQsnWTL6pt1j1Dq+bWIgNUEnsh/+eOmr6O9BpzDp2dmQJ1MOmyHAXQmCuoyvc5
         6eyCniwjbEz+lzYTZZJCy6Bn19WCxla59jYEpWNIpCblhpa4/rIV9hOp3/jDffWvnwsl
         +emiCxsYTh3QaiTl1kGCwA6tCiBcX1/EZii5lnrulEbfYufJnlFyW/SFueVkubo3GPII
         xbbGTnkKc1r5/MI/xyaJmj/j59MamkvpDnSajluIBaQRdDD7Ys5dlVqqSkNes4tz56c8
         3pow==
X-Gm-Message-State: AFqh2kpWI1nUjA0mis8OZpezSXS0GnU2J2awnvw6lBVQZzheZfZmW9QH
        Z74zDL/v1b5keSceEpLXa4YuG5HjqiclqgybLIU=
X-Google-Smtp-Source: AMrXdXvBz8/Dl4bwHgsKcFKZ43+bE2HeLAUWlYQrqbBvPXwRkdFlRzK/6PXnpStRCc6iPNFNVUp06TSwBjekEL1JMWE=
X-Received: by 2002:a81:b60b:0:b0:45c:d900:f30c with SMTP id
 u11-20020a81b60b000000b0045cd900f30cmr1581382ywh.256.1673353716487; Tue, 10
 Jan 2023 04:28:36 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-2-ojeda@kernel.org>
 <1E542F5E-220F-4061-BC71-F37C76616F34@nyantec.com>
In-Reply-To: <1E542F5E-220F-4061-BC71-F37C76616F34@nyantec.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 Jan 2023 13:28:25 +0100
Message-ID: <CANiq72mYHzHVk9s6Tf+vbG5ToChzCTBh0vX67s87P5sxbD-PVQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] kbuild: rust_is_available: print docs reference
To:     Finn Behrens <fin@nyantec.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alex Gaynor <alex.gaynor@gmail.com>,
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

On Tue, Jan 10, 2023 at 11:16 AM Finn Behrens <fin@nyantec.com> wrote:
>
> As I always use my systems rustc/bindgen, I always get the warning, which already clutters the build output a bit. But I see why it is helpful, so not a fan, but this patch is reasonable.

Indeed, if one uses a different version, it may end up becoming too
annoying when running it during build -- it is something I worried
about when adding it back then in commit 11c0cf1e8c06 ("rust: run
rust-is-available on build") in our repository.

I think, for a while, until more people is accustomed to dealing with
Rust, it may be worth the pain for some of us in order to help to
catch bad setups, since otherwise users may not attempt to check with
the `rustavailable` target themselves.

In any case, of course, the "too new" warnings will go away when we
reach a stable version situation since they will not be needed anymore
(but we can also do it sooner than that, for the build step
especially).

Thanks for the review!

Cheers,
Miguel
