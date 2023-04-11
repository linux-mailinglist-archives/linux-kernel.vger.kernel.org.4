Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A26DDAF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDKMgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDKMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:36:15 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AB23C25;
        Tue, 11 Apr 2023 05:36:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54ee108142eso157253517b3.2;
        Tue, 11 Apr 2023 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681216573; x=1683808573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTZiJkh4SNH3a//CZAcPFpSvwQ67wtqUj8XGzW7S/K8=;
        b=eyccItTKNLzhYwm3jQk6tUWBMpT5vsMYte+J2ELWoCHBj07FIvuorS1VTxF9bX4tQR
         86gZzfJNolGUVBEswXnTV4uZrxwFp7bMW9G7QlAhY6zIEvnDI9xKgoCKInektOEbUaq+
         tlEauRCj+gHpC5ZgQPAZsM1Hnm3QngYUtejU5VphH78F3Ca1bAbf1qIN1vfH7bLpn5K0
         /lrBNArw8dNc4OE3a9fVntFOgqnPmaPFQnTKrBJXzHvQ7FaGVHbWxZMUiNXBN9jlFKWA
         vaMlw2p91Nx1iGAr4QyjgCCwawW6wQ92R5+rnujTbzrX01QBWpnv+8ohuS+gne7qjDjb
         VSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681216573; x=1683808573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TTZiJkh4SNH3a//CZAcPFpSvwQ67wtqUj8XGzW7S/K8=;
        b=plHjIKlNyMdtC68HtB/Losjfc5vm4VrNvTOLw5B/DgZH7KYUvqKXLyNIJLFVWdvL9y
         s4Gk3R51W3Vjt9+RnmmH15ZYLfDMRbSbQz4/jIDJFQX/UQw0d51fHXbnPfqLKgFY1czu
         XAnFFp7Q2xNZ5RK2QKndIe9mkVG26oattXJC+uVJg1kWf3e2gx0J9/K0ItOI/4hVF0sc
         07FMdm8seyyckKLrhWlrlyPa5lUgCeBswX28DS4OfuRRMiwPVhVJ3bJ0Ijkxw78Te00Z
         Pl/UqgJlt47jYXqQrblJ8jovsmaLrSrvMyvoCAsg/kqxICuq8LrKGWP6KXWZ2GUwuJ7t
         FuJg==
X-Gm-Message-State: AAQBX9eitAhiPIAU1qpbgLPGTsapntWShVA7oljYfUkJlasX2AqXF1Bd
        MuU4Lg/4tx4a707v2bUQJB6kyXPPI5Fwv8yFlEE=
X-Google-Smtp-Source: AKy350aAEQGFc9EUTMDsEXy8PB3OPt5BRQ9kMKxLjxaNUQyo4xwTVFMYo17obfrHQQl+dhbfX4AUeT5SKFa4D9EmoEo=
X-Received: by 2002:a81:ae5d:0:b0:549:143f:3d3 with SMTP id
 g29-20020a81ae5d000000b00549143f03d3mr7623571ywk.0.1681216573072; Tue, 11 Apr
 2023 05:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <441a96cb-7dd1-0885-df64-933ebdb55e9e@selasky.org> <0ec4becd05c49e8f0bf214fbd62208ea67c2b4c3.camel@collabora.com>
 <6fc0a0c6-a7c9-5350-9b9e-1ea9dab568d0@selasky.org> <CANiq72m812+L6dc4Qs2wUXW85eBQwgrjWYYKc1MSsqN5AG_sFw@mail.gmail.com>
 <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
In-Reply-To: <9f896097-8410-4d09-b614-6e792b2160f4@selasky.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 11 Apr 2023 14:36:01 +0200
Message-ID: <CANiq72mv2uYe1x6cy4zUq8XHhAZcYYpt6hVXMG4yQZeqw1kY7Q@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Hans Petter Selasky <hps@selasky.org>
Cc:     Daniel Almeida <daniel.almeida@collabora.com>, wedsonaf@gmail.com,
        ojeda@kernel.org, mchehab@kernel.org, hverkuil@xs4all.nl,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
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

On Tue, Apr 11, 2023 at 11:52=E2=80=AFAM Hans Petter Selasky <hps@selasky.o=
rg> wrote:
>
> Assume you need to update both the kernel and the rust compiler at the
> same time. How do you do that? In the binary download case you have two
> machines. One to build rust and one to build the kernel, so it is
> technically not possible?

I don't understand the problem -- you can build (or download) new
toolchains without changing the kernel, and you can keep several
kernels and several toolchains installed, too.

> I'll give you a real-life example to emphasis this. Apple and Microsoft
> has done something very bad in the file system area. They mistreat what
> happens to be the Norwegian character "=C3=A5" (0xE5). Norway is where I
> live. Their solution is to split the "=C3=A5" character into the "a"
> character (0x61) and the combining ring-over character (0x30A).

Sorry, but I don't see how all that relates to the current discussion (kern=
el).

> Daniel and Miguel: By saying it is not a good thing to build systems
> completely from source,

I haven't said that at all. I regularly build from source myself, in fact.

> For people that build stuff on their laptops it still matters. If you
> have a beefy machine, it is a different case.

I don't follow. You said you are downloading 100s of GiB for XCode,
but you are not OK with 100s of MiBs for Rust?

Anyway, both the Rust toolchain and the kernel can be built on laptops
(I do so), and they don't need to be the highest end ones at all.

> I thought that Rust didn't allow you to write outside the bounds of
> arrays, similarly to the old Turbo Pascal language?

It avoids all UB, including data races, not just out-of-bounds
accesses, as long as the unsafe parts are sound (and there are no
compiler bugs etc.). Which is one of the main reasons we want it in
the kernel.

> If there could be one base compiler and toolchain, I would be happy.

If you mean a single vendor, then it may be interesting for you that
GCC will include Rust support in future releases. It remains to be
seen when their compiler is ready for building the kernel parts, but
it is one of their goals as far as I understand.

> Right, so think about where that slowness may end up one day, if you
> suddenly need to re-build everything from sources so to say :-)

If you want to build everything from source, then you will need some
CPU time to do so. That is just how things work. Most people will just
use the toolchain from their distribution.

> Thanks for your input!

Not at all, thanks for your input too :)

Cheers,
Miguel
