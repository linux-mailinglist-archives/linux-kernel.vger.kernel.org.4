Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6940B6A2FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 14:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBZNk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 08:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBZNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 08:40:57 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45FFA5EC;
        Sun, 26 Feb 2023 05:40:56 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-536c02c9dfbso106623267b3.11;
        Sun, 26 Feb 2023 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=diOfltNJgTI4QcRIe1q5nwxDa2bShFvMq96Z1v8BgWA=;
        b=AkKeoB145HYWoRCQ1yjWXsdzeVkE0qiJz+4wKixkI7Ch6xKzh514t0xHZDjJKGzLoI
         qVn8ZyKf42a3Eg2B6XGEcwhmVuSl5kESZASUYfaehA223i7MXVbw1LvKvD/cJI8pg8kl
         8yh5br1o5/m8vqycAV/nIdSyOlmAlJ+KYprfo1ES02EFLF5ue0wz1gZW1jYH4CfHf2qL
         PO8UJab3vCXRQbA5MraSbP5Duc3difhxsoKMK5YQKsBQ57L6hQZVXi8xw0fM7VFJcMlJ
         A7yQ9COhtbl6qv5otPnWR6LKcvjrgx8aFrvrp5aO4SM7yzIJMLvmz8q4M5sc3lbjlEJd
         mSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=diOfltNJgTI4QcRIe1q5nwxDa2bShFvMq96Z1v8BgWA=;
        b=S7kZXXd8ff8s0wrF+89xA4RMDrXF+3CgdXzZVT0SNORb1icOl0JeyWqxX2wkLnRz6S
         IqIOizWDRjT3G+Tg5GoDBtaI2s25+eJouek7KP1NeSohX/7OHX6biCQ1p9uNeTe0kKTq
         m8t71+LEGs8xRZePhS5mtuw/ZguyGPmeDg2OcAb6GktpV0oRTW8RSCKAbH11Ir1gThpb
         JE5gas6uTrR55voEMXDcFrmsUU9kPNYJYMYZkPzn6pc+QRmRrDvjAh/uC6HGehH8rAmW
         zTqKL+rn+30bc8TD2aehc5xqGKijLG1Ac84Gogl1eS85Ln7g21rohx7Y4yrkUxYyOt5o
         MoNA==
X-Gm-Message-State: AO0yUKXqnFjRTDTY/rrzl4jGVCrCHQ1fO0c1aWmEjjppBbrbUWDE65MP
        bDdGDNq5cFTWXd3stI8gNwMeH7/WfKf1WSA1wY0=
X-Google-Smtp-Source: AK7set9rUznC6grtBh19Slp4e0aFAnHCKuGHYtL6QNpch43NKKm67TVU8yIkH3O4rF9oICebvIigo/oap6HR9vL20lE=
X-Received: by 2002:a81:ad10:0:b0:52e:bb2d:2841 with SMTP id
 l16-20020a81ad10000000b0052ebb2d2841mr8063756ywh.10.1677418855775; Sun, 26
 Feb 2023 05:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net> <Y/lOlcSpc+d9ytq/@boqun-archlinux>
 <20230225222340.34d749ee.gary@garyguo.net> <Y/rCU1S+GDgIojNf@boqun-archlinux>
In-Reply-To: <Y/rCU1S+GDgIojNf@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Feb 2023 14:40:44 +0100
Message-ID: <CANiq72m8jmW0WEmscR3+C2aiL+FCzYZXj2SrfruCu4UB98ZCYg@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 3:22=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Hmm.. looks like the `?` only "propagating them (the errors) to the
> calling *function*":
>
>         https://doc.rust-lang.org/reference/expressions/operator-expr.htm=
l#the-question-mark-operator
>
> , so this doesn't work as we expect:
>
>         https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=
=3D2021&gist=3D64c9039e1da2c436f9f4f5ea46e97e90
>
> Hope I didn't miss something subtle here..

There is `feature(try_blocks)` [1] for that:

    https://play.rust-lang.org/?version=3Dnightly&mode=3Ddebug&edition=3D20=
21&gist=3D8f40663d2ad51e04a13f2da5c4580fc0

[1] https://github.com/rust-lang/rust/issues/31436.

Cheers,
Miguel
