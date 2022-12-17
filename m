Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA73964F8E2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 12:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiLQL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 06:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQL7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 06:59:39 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0F644B;
        Sat, 17 Dec 2022 03:59:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4407c61433bso25519547b3.9;
        Sat, 17 Dec 2022 03:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rE0oBKTowIW25OwfMNBrVynx9tRsGIghoSQzivHM5+k=;
        b=hpB40kFK/csHhF8tnrhg44BII0yfzhxMur7Ruk9uvXWd2CWHIIbOMzk+CxvyRGohIE
         gN26nd5qWK230ub5XXo81hr9sa2RjLIAy9c6pxR0I7eETb9Dsm4lRL5bk9Hb6y6+U507
         Mv43dwTygE/GLCden1Ea26abdU4c/nRgL/iplj53zxPIGEb3AXuKSt4xPKnZ1hcWsTrr
         mS706sXENCc7C0FHWEqxBogHVdtMT+Zb5ocgbmW+IyjN94NNymTou7Fh/01Ez0ksoXsn
         C/XYamggXt/zyOjqAPFqo2OevlgdHKx0xi6KY+kCfqbz51c8mfYuRIPH/h4kmctrhzbg
         7ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rE0oBKTowIW25OwfMNBrVynx9tRsGIghoSQzivHM5+k=;
        b=uuw6y31H15TmSMz9tseOHCaX3FWfdZ0XlTjdvwMB7su/mD+podnOceKA9gjO4dhlFj
         Ztd3TArndLkwKY3AgHTgGifUtEgb+r0R4QF2i4xhGL04YO06XQxeNAVfenKcm6MC0kq6
         Z3Z2M6HX3bm1yIvI/WvjthqYWc8eLCHK+nmW3T3+HDcd+C9TIMcw455+3oIZn4LSWxgk
         foXZLbLmjV/W2VwVyE/uyGcBEfGO4IHLQ4hf7dmYP2MMpLmaBHxo2RBVDVe4z3l4urGI
         A8Ekk9/1HNDK/7SKwnMk3psNvyZPSca02GD4fn0Xro6xmH7nBd59eB61Jt4ufCeJsOdG
         1QDw==
X-Gm-Message-State: ANoB5pmu+EQKnPfjpJmZakuxh9amMqAxOzjegVwSQd350sBDgFkA7Qo2
        Tg9ddQumv+BHuCxUH2FLI2/6Y8RutgwDwxFNzqc=
X-Google-Smtp-Source: AA0mqf6Sg8SR47w1xjUSAitaiDIbC5Yl+Hj+ggD2OOSN67ffz5Gx79lZL7+Z36B2bdVAnQHLJ9XgKwwtLSQXjU07bNc=
X-Received: by 2002:a0d:c4c3:0:b0:3bc:7270:cb70 with SMTP id
 g186-20020a0dc4c3000000b003bc7270cb70mr3436784ywd.83.1671278376633; Sat, 17
 Dec 2022 03:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20221217044436.4138642-1-davidgow@google.com>
In-Reply-To: <20221217044436.4138642-1-davidgow@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 17 Dec 2022 12:59:25 +0100
Message-ID: <CANiq72nsTR0Ez4_q_J=Vhoy+SACwnNzRVLKx6_707mP8N6VgGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] rust: arch/um: Rust support for UML
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        rust-for-linux@vger.kernel.org, linux-um@lists.infradead.org,
        llvm@lists.linux.dev, linux-doc@vger.kernel.org,
        kunit-dev@googlegroups.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Daniel Latypov <dlatypov@google.com>,
        Jonathan Corbet <corbet@lwn.net>
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

On Sat, Dec 17, 2022 at 5:44 AM David Gow <davidgow@google.com> wrote:
>
> This series adds support for building and running code in the Rust
> programming language under x86_64 UML kernels.

Thanks for all your work and support on getting KUnit/UML + Rust ready
(long before we landed in mainline!).

> This series is currently based on the uml/next branch: I'm happy to
> rebase it next year once we're past the 6.2 merge window (though it
> applies cleanly to torvalds/master at the moment). Equally, it
> should be possible to take these changes in via the rust tree instead,
> but since it's mostly UML Makefile changes, it probably makes more sense
> for it to go in via the uml tree.

Agreed.

> Also note that this series marks UML as a "maintained" architecture for
> Rust support. It's definitely my intention to keep this working, but if

That is great -- thanks for stepping up!

Cheers,
Miguel
