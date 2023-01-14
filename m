Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FA066AB4C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjANMMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjANML6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:11:58 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA80658F;
        Sat, 14 Jan 2023 04:11:58 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so319895957b3.9;
        Sat, 14 Jan 2023 04:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qadApUskd1cmnf3V0uX5pB2OviK6XICzMAvYb4D0ACk=;
        b=M8tRVcsnUUjmGQBAPSt+T9H0jGs8nH+t+8hiN5SYI2LHcyzNswtdQQ3Drv8cMPyUcn
         s3SdC+JPZxQcKd5mydvVkEkDbgfo0cTws8Scju/gyWs9Wd0+LmOCck8RcnxWjMrwE6Cu
         mDG0S2BIeJeIqf6GZNQSePK3t3WBSBNwcHwWLrtfIVzxqOQyraX22PcHV9LYzkGryp5x
         rL8LqYKtiykkaFXA4+YAO2vhYfxcro0+05XqqE4lxiaIty551MI6nmoxrpzSebqp0Q9z
         IGJNWmVnlf9QQdEOY93ENXZserVaLj7rDN5jYsLE03q1cALsG/gqbpH2i+WLeOhJAhXn
         2G0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qadApUskd1cmnf3V0uX5pB2OviK6XICzMAvYb4D0ACk=;
        b=VUXHqB4w1ur1hLRLqu1bpSfl3rxdIvJgUeHsUt0/a7DYKD56PHfQxAKnMsHIlx6aBp
         KMcIFEWLmP6oWrWIBYrqarSuk2/rkhGn4ehc7qse6157EfwmxAdyU884AdPpwoPSZaM1
         C8RI6XYfNcBDQlu6B+vrtAsfC/UDJmv0vn3fiHPq/fmnenbPdhfeOKsP7BhdacKOl14c
         wtvEY+2J+p2U6lFR4L3c33rw+kDu2TTL7YPott9rKZz7HL+QLkjzwBeZa1KA/n+kVu1I
         dn9ulIrqd3ag/EB99n1iCgEGgG58gW6iV81/2bskmN2dlYdvKAxTEQAEOv+0HiptQECx
         GXlQ==
X-Gm-Message-State: AFqh2kpLNElJspdbGBZTHENfwC30x2LBQwB7q3j2DS+eK+Z/EE5c6GJg
        7SyLYz/oXTm07YQRCwiDT4CXivq735Vs3iF7V9w=
X-Google-Smtp-Source: AMrXdXvskHzenVRqRLn+Wh7NzU6ue6GUkYyPPdOgZ2b+ge/bwI1705ql2ufw1IejiURmm52e6z7nQdxJKKQAa7E5/fQ=
X-Received: by 2002:a81:a110:0:b0:484:a94f:210 with SMTP id
 y16-20020a81a110000000b00484a94f0210mr1543433ywg.129.1673698317372; Sat, 14
 Jan 2023 04:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20230109204520.539080-1-ojeda@kernel.org> <20230109204520.539080-3-ojeda@kernel.org>
 <CAK7LNATVJ5e=DnbJ++03iEMk0bN3-UvODBLkEKcYdSnJZa_tmA@mail.gmail.com>
 <CAK7LNASDu+i4G88TYYa6feg-bha-_cLv1si_ujuSMbWuyUve0Q@mail.gmail.com>
 <CANiq72k6jCf_LP5vmBHKEpZ5njmH+u1HpJUjs_GyFi1a4B94ew@mail.gmail.com> <CAK7LNAS-5UaBX4CYrt_VFZrfHxLy=M=CpT8Hb-LpH4EAntRRSw@mail.gmail.com>
In-Reply-To: <CAK7LNAS-5UaBX4CYrt_VFZrfHxLy=M=CpT8Hb-LpH4EAntRRSw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 14 Jan 2023 13:11:46 +0100
Message-ID: <CANiq72mRkJV37b+WP1PtpiOVUkRG5w9mJyVQfzJQRGKXvHOKng@mail.gmail.com>
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

On Sat, Jan 14, 2023 at 10:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Ah, I see.
>
> How about this?
>
> bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname
> $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null) \
>          || bindgen_libclang_code=$?
>
> You can get the error code of bindgen without toggling -e.

As you prefer -- personally I tend to avoid assigning two variables in
a single "statement" (like in C), but I am also happy avoiding to
toggle `-e` since it is global state and therefore ugly too anyway.

Cheers,
Miguel
