Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88991721981
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 21:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFDTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjFDTZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 15:25:34 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D14FB0
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:25:32 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75d4dd6f012so151424885a.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685906731; x=1688498731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MwNKZVctXPizN8iBxMBmg4YxNthyD5P5FXyKM458G2M=;
        b=qWk6mdnKWwcCEerxqvccSDqYhVpgED8SjJnC5g/4acFJjSp2DCDmVG+D6ly3XIJkur
         9vNv8kfK3iPIdR/LZycOdJO4zy+Tqef0uKhSrYc2lpS8EDTTE5RsrVld3ulshYwsrzq3
         E2bFAKjIavhNiH6TC0GHv3Sx3XPAz32ZgxKyxa3e7lKbD1Zb4oavbFz5Txo4LtX5Gcbh
         tTXGx0giuent+blha2mb9bj9RJ4dnYg7vfnus49i6X8LY+h67txiiI9c8jBvYqTw8j7v
         VaPUQqFdjl6jA7ZHfuQfbVpLmV7Wv5hihn4/PjymaQ8pOdZTvRgnDECHiBUT8bt5VKnk
         i82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685906731; x=1688498731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MwNKZVctXPizN8iBxMBmg4YxNthyD5P5FXyKM458G2M=;
        b=aq/Hha5p/vkSkloo91K9dT51oB/qB0Eg7nPT3dSzIaL+W8IUUlTpgCj3y6ju8fAbLJ
         0KfUdlXdg6Ilkp2JwCGLClCmDWCdNXaxJrkbpOrYA3xiHHqMLxa07D6oK4ye3eQimsvz
         JwQA7+k1MEsKr4/rUvfI2dD2qvMRE7HZk+US/3+wAUYcy24J+o1Vav8uNkqWvq71W0d7
         XqohsHVb4DCxCl2qBpJDkJXuaoK8U5nndbLUOypfBGx1u2N3V9Xy2mRa94HhFIB000yo
         wijeyzGvwwV7WKVF/lVYUY9txppzAMT2YaWN3kRvVdEVfmTjSfFwzIw0JO1J9ep/Ox3E
         Pbqw==
X-Gm-Message-State: AC+VfDwd1snU7IUObfBOYY7AA/og8slNaL1iKoS82zmJLJg+eMC4geBt
        r2HpmZFAwy4kf/GwOpnzaEVwviPxrgzY5g0BuVs=
X-Google-Smtp-Source: ACHHUZ68Zhy5Uh3dWc9r/KiWZKpqap2WTZSewbMqDmSd9UtizMYjR8XLz5s/0eOHFg0j0JI/DJrd2U8M0aBZk3GoXhU=
X-Received: by 2002:a37:a813:0:b0:75c:b919:b4e5 with SMTP id
 r19-20020a37a813000000b0075cb919b4e5mr18649567qke.32.1685906731527; Sun, 04
 Jun 2023 12:25:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me> <ZHudRkB1YcMD_DaQ@surfacebook>
 <44c969a1-8dda-425b-acf3-9a80dfa60e79@app.fastmail.com>
In-Reply-To: <44c969a1-8dda-425b-acf3-9a80dfa60e79@app.fastmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 4 Jun 2023 22:24:55 +0300
Message-ID: <CAHp75VcJ7bvGMQkVpnP2g_FXxQYapf0mXSZ9ETXj2P=cH9N17Q@mail.gmail.com>
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-kernel@vger.kernel.org
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

On Sun, Jun 4, 2023 at 8:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sat, Jun 3, 2023, at 22:06, andy.shevchenko@gmail.com wrote:
> > Thu, Jun 01, 2023 at 08:34:00AM +0300, Nikita Shubin kirjoitti:
> >> This us a rewrite of EP93xx timer driver in
> >> arch/arm/mach-ep93xx/timer-ep93xx.c trying to do everything
> >> the device tree way:
> >>
> >> - Make every IO-access relative to a base address and dynamic
> >>   so we can do a dynamic ioremap and get going.
> >> - Find register range and interrupt from the device tree.
> >
> > ...
> >
> >> +config EP93XX_TIMER
> >> +    bool "Cirrus Logic ep93xx timer driver" if COMPILE_TEST
> >
> > This is strange. What do you gain with this "if COMPILE_TEST"?
>
> This ensures the driver is compiled in an x86 allmodconfig,
> like most other clocksource drivers, but it's hidden on
> all other configs without EP93xx support.

This is cool!

> As long as the platform selects it, this is the normal
> way to add a clocksource driver.

Shall we now require this format of COMPILE_TEST for all new code
(which is selectable)?

--=20
With Best Regards,
Andy Shevchenko
