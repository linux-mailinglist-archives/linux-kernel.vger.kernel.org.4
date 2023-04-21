Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8A6EB5CD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233847AbjDUXs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbjDUXsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:48:54 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0582137;
        Fri, 21 Apr 2023 16:48:50 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54f6f0dae19so12848897b3.0;
        Fri, 21 Apr 2023 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682120929; x=1684712929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLOHSowAq3qXxVnp8tQm0eq1f2X6Iz2Ob1qD9V70Jyc=;
        b=N6FlboiknJp6c3M8T/xFon/pnuArObgBjhHXYdXy6bl1PlLUyDQjS14PTHy1fKFBrg
         H+RBH0tYkzYHl46iJGFKYpFtJ75H+ecQGmLEEUb7S0pGJgAt69lH/1IS5quQ4qLwVtOf
         u+ld1xcGZYVvnFj4d15tuSkaK3IjGK78unsQvKt87YWucazsEpoMeN1iaYAOqkFi+CWm
         TQ4BgDHIdIGicv6TisI5OPxaD+b9U8Ml9PH/0mvWs+WhwytJKZAWXtnW9WLZm2M/Mj86
         +oQltTkY7/D2T0daxBxOa/5JCL3CSOG6SQ6rcu7E9bbeEPTFmVC07Lwe71fo11cFe2vW
         t7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682120929; x=1684712929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tLOHSowAq3qXxVnp8tQm0eq1f2X6Iz2Ob1qD9V70Jyc=;
        b=g0WdpUWpgT2um5D5GaKJlYkW2JbNxPQljpYcNdk3bChfiVh6mjqGYgT3PNFLikUoRL
         hgpRHdbwiL3JoiMSZOr34vmBSB+Zr8FjHVriTsc7tQe17KDtZSSJuLysba9FMKfX8sbO
         Y6t4e+P7lhEUXBVXAI0e31WRkFAvyepPXYUg/LeWPMD6sfplokQX1i0ANzffoYp18sRK
         t5wQPf+Mobu/1TZCmlurYAqidquffMauOqAozSbb7yh8ltKVMYpWIU+DmOXY68VPlasA
         cJDW+1o4bhUTfh/0nRCYk/6dDU0O3BSeNVTNBa7TSyRjbXrwSAb5y2jtzGkAxRLDUl3I
         NmHA==
X-Gm-Message-State: AAQBX9f/+iMqEPyDYixI3UfSCW4Bh+mnN6d9QHC2xRH+x9Bl6FFCQbMT
        98utHE1G9MxZNJ+nc/wtdbua0YN4seIeJ5PVrik=
X-Google-Smtp-Source: AKy350YUefHIkuKUui23iIRLtVxZ0q1CQI13Km7pDYoawxBws41dSc8jEVMIOQP++qYawwQ+uNh0e0QPUs+F1eVk7RQ=
X-Received: by 2002:a81:8302:0:b0:54f:9b01:b353 with SMTP id
 t2-20020a818302000000b0054f9b01b353mr3028442ywf.9.1682120929644; Fri, 21 Apr
 2023 16:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230329-rust-uapi-v2-0-bca5fb4d4a12@asahilina.net>
In-Reply-To: <20230329-rust-uapi-v2-0-bca5fb4d4a12@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 01:48:38 +0200
Message-ID: <CANiq72kZcDfV-hz6ku93RFxg3eOYfNp1d=-GWYy97T8maoZpMQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: Add uapi crate
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev
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

On Mon, Apr 3, 2023 at 11:34=E2=80=AFAM Asahi Lina <lina@asahilina.net> wro=
te:
>
> The first patch introduces the `uapi` crate proper and stands on its own,
> while the second patch introduces the `ioctl` module in the kernel crate
> that uses it.

Applied to `rust-next`, with added support for the `rustdoc` and
`rusttest` targets, since we want to keep those working. Thanks!

Cheers,
Miguel
