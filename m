Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB896330FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 00:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKUXwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 18:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiKUXwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 18:52:17 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F01D59;
        Mon, 21 Nov 2022 15:52:15 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-39e61d2087dso53421187b3.5;
        Mon, 21 Nov 2022 15:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PH1MFowh0m8X5SP47+4l8kVJrUDEKp1YYOWjduOTIHs=;
        b=CSA2yvphJeHULK54lTzNkWGZDZXfEJbsgyjC/WZgUP4CrT7HAHEiaR//3wDktmuUz7
         fSWtnkJM338VQ+95Aa63L3XPj8wb/u0TfMCpH2kh9LpwfPTUdB26fC+xbInbmS71VJIb
         9DOTwp30dkGb9Ay7Azi0BbaI+RWP39RPA4sKkIgv2s0gpip1iWumVfrDkxFad5JmR93x
         DxdvUZEM1Z3e61uP5TwCs0vFXHrMOGj0UTgyhjJuIAIdkBUFDWjjVA9NXk77o4Tt0nVp
         QU+b7UU5wAWWOFJIrbwXjLduAcfchbutXyOKOr10XkyzZlX32KXwF/OujtnEs9wuTC8g
         XlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PH1MFowh0m8X5SP47+4l8kVJrUDEKp1YYOWjduOTIHs=;
        b=b+mYri5fcYtUwHLHXvD3KCuGKx5F9APqYyvmtCWctWFxOc5ri4bTasP6LzUQ+Rh59L
         n/Ntya+IcIB7Qnecp6VwqwaRi9PfBL/JAprPw/KbMOeASym/G6nm+CCTK7Yrr+Qp2dX3
         lHJG2EE8NDuBOyq+gKzk+yWlASIjdLamZnK1xcuoe7SpJQj4ptpK9Kk2o7gyKaOnn96a
         W/8aTyBzoikfk1RPeM0FmGcl5K7Fq4q4iHb60aoTq0IghkKfmGQxYdEia278KDSYILDC
         J1ZkNM9yhVV19f9bTVqbsUHEPgRXdhx8O00/K75hMPG50kApujfX+aonif4NTAKqnNVD
         hhBQ==
X-Gm-Message-State: ANoB5pnLItgbUo47nmC2/Xg+eRPRSXUm3JGth2S6cFB5NYAqC/4UVAcp
        5sJLyppSlaZjHzf2eWiDW+Gdu1H06b8086jZQ54=
X-Google-Smtp-Source: AA0mqf7nUi7AvW46+GVluz4UhjtGfyNkH3sxKOsAJ3aoBlpwQwui55eNQ4N5bsjhgOp7z9OhpOvsZZ6xZ9hgJK1Kq44=
X-Received: by 2002:a81:7cd6:0:b0:385:136f:6e0b with SMTP id
 x205-20020a817cd6000000b00385136f6e0bmr1515338ywc.256.1669074734754; Mon, 21
 Nov 2022 15:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20221119165921.18806-1-bilbao@vt.edu> <87o7t07zrq.fsf@meer.lwn.net>
In-Reply-To: <87o7t07zrq.fsf@meer.lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 22 Nov 2022 00:52:03 +0100
Message-ID: <CANiq72kRB=g_G4cJUZKreKc+qP2npLf6ze8HJMzpBrA6YfDW9g@mail.gmail.com>
Subject: Re: [RFC] Integrate Rust code documentation into Documentation/
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Carlos Bilbao <bilbao@vt.edu>, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
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

On Mon, Nov 21, 2022 at 10:39 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Carlos Bilbao <bilbao@vt.edu> writes:
>
> > I propose we include in 'make htmldocs' the option to integrate
> > rustdoc-generated information. We could create and use
> > Documentation/rust/rustdoc.rst as linking point for that HTML. This
> > wouldn't be costly for the kernel itself. More importantly, the kernel
> > website could host this information by default.
>
> I'm all in favor of including that output, just haven't had the time to
> try to figure out how to make it actually work.  Got a patch that
> implements this behavior? :)

Agreed, generating them in `make htmldocs` is also what Konstantin
(Cc'd) proposed a long time ago. In which case, I assume he will need
to add the toolchain to some infrastructure so that we actually get
them.

There are a couple bits to handle: they should only be generated if
the Rust toolchain is available (and if the Rust support is enabled,
really; and probably that suggested `rustdoc.rst` should reflect the
result too). Also, the existing target depends on a kernel config --
we may use x86_64 allyesconfig for the moment.

Cheers,
Miguel
