Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888366DA5FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbjDFWwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236907AbjDFWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:52:31 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8042A30D4;
        Thu,  6 Apr 2023 15:52:30 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54c0c86a436so67009407b3.6;
        Thu, 06 Apr 2023 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680821549; x=1683413549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGbq12cvGFhwzHD8RaS0k1IPBdh5/8SAgXm63YvkWfc=;
        b=S5nGz8ySThzYiDZxVI3+tNW7F4+ruAydf1N8VW9E8Ik/Dt5eWMvxromtCxM/Hp0ZUh
         21VOyOa8vhfyzkyoUcxrTJT0j+LhpKq2psGUdlCQ4uPCiUab4YcQH+mE3/NI/IJ2iG9I
         bBWs8sroNbnSwhzqvHTVzQCQa8N9e/ruB4g0hj5D+poZZx7On6O4+WaF54eB1DY8jLu5
         Qn18rF6zUVgb+ctT3qlJPbKFH0eXOrjQ5SpRaAnF4ewOcodilrESQDzJ63pQ9yzzcJEx
         waTlYN9OZ3h1BKMnQtmFvvnpX3Ux4acdGcOxBNo98Ulg6F7+5D0Xd81b/ZeEPJLpanky
         SNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680821549; x=1683413549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGbq12cvGFhwzHD8RaS0k1IPBdh5/8SAgXm63YvkWfc=;
        b=Io4bArsfcl6HujLUUOz8YSeNXaMB/qV2e6khwFdC7I5zm4HXWTDPrbiARkIPlrdjlx
         v2S/TgvmHo0/kds84ONnbKmlQO85SeHoi4FaemvsWy5/fuouYF05dckzJLYOfsz9L4gK
         SxFHjwkQKzZSpSNBuRWkaRmK69lZM87YTzJV/2H0Jq8h67rL3RYI6Tm/OWTma1cwm7nc
         XfZx0/VOLuwoJTmE1lCjnxoe3Hd5UDVIKjbdsZJCPx6OT4JpYKAPAQg6Dl4dQPSMZE1R
         ov6KLj6aF+Hdwx58ESruq4+EeuBLlbfgIDpkxQdfJ9doxV4J89CQgRJHbM9HoaVCyMyc
         tznA==
X-Gm-Message-State: AAQBX9d027i2Nw3pP94vJo3uX47xmw/DWdFHSqJfAMbscf+La7orsWxe
        emSwFg1vfEiDvFZIV1NxtfJPtndE96h72aPT8/M=
X-Google-Smtp-Source: AKy350YeDrOFV1a5MHN3BrPJvKrelweIcHIZXt/qClEZirm9rY8hSTf3e+vEwZosFuXPlEMM6zb5Ghnb4X0qG911uq8=
X-Received: by 2002:a81:c509:0:b0:54c:2889:7105 with SMTP id
 k9-20020a81c509000000b0054c28897105mr7089ywi.0.1680821549455; Thu, 06 Apr
 2023 15:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org> <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org> <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
In-Reply-To: <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 7 Apr 2023 00:52:18 +0200
Message-ID: <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Feb 11, 2023 at 3:35=E2=80=AFPM Andrea Righi <andrea.righi@canonica=
l.com> wrote:
>
> oic, with clang-16 we get a deprecated warning (but it doesn't fail),
> then starting with clang-17 the -enable.. flag is not available anymore.

Wait, Kees' link says it is deprecated in Clang 16, and the removal
will happen in 18.

> Then I agree that a better check would be version < 16, instead of < 17.

Applied to `rust-fixes` with that changed. Please take a look if it is
what you expected (both content and commit message):
https://github.com/Rust-for-Linux/linux/commit/1921ea54ab0d91d7a660c5bb980f=
ce1efc9223f9

Thanks!

Cheers,
Miguel
