Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B9E7227C1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjFENpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjFENpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:45:46 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6778BED
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:45:44 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6260bb94363so26636996d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685972743; x=1688564743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tly3mLQtaB+X/gQUoEPLhuV5Kqx0BjdUsHHsp7x7Bsk=;
        b=IMnmPtNEmidGERk32PE71FcST4NFb2x03nZmMrMn9C3jdZVA9UubDuD60nGqJq/5nZ
         2e7zbV8iVPnFVC4uVLqr3/FNNnG1cLcdy132ngZ62YPUbDbZZnpKQYJW6i6OGpze00SC
         vINl+kYYyAMEDfimuer34/2rrY+iFOmVIGzjH+I+V61Z+7+fMfX3j7pu9uaJPK4JCxfr
         UvQN2L4b+erIzBpCySgl2tx7ICDkWTN9u8OfRw5rJz+2r1kweobpRl8iZK0h25N8IG3d
         0ObGm2NE38BclCl+SBInl6yhiaQCoAFnunQ0MWR4v2lmbmjbReSTbKpWAiqRLznNvZiB
         MWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685972743; x=1688564743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tly3mLQtaB+X/gQUoEPLhuV5Kqx0BjdUsHHsp7x7Bsk=;
        b=aKydYqHQd/iN/TkD+/AEu1KCb5q6K3+fTEshfuL4YnviRqov4geEZHzScxjsBwpgYN
         hjyxvYkaYQcocmQz4UWMD8SrEybLbafdbvjQ6REZWMFvsez7jeuXZ6Sx+Ty3MYwuqxM8
         5WjsQea0RF+CWRanhz6c6l6AysEUYo6+1ndhiSoHQSZKZXUdbdDlnXbv3L3yIHMglBSS
         Y4gxA+amQmDF4o4hlqcg+3pP9KnYzLzSB3/sPsoidpWJk4q25B5IGnGatjkqUAMDFrhd
         dlnHVZKZKdMC0Aigz+LChS8AL8UJFheIUj+YTKgj471BfLo69yzlz5z9s7/FK11EzJnH
         aI1Q==
X-Gm-Message-State: AC+VfDw6eVKiFqvgvG5KGGTDFQrrZatJVsoBwTce6wtRq2eFNxz1pwuU
        pCLLDgNETQ+a6PvcBjihFo6QU4iYVUooGZI8Sv+OizWqgbKgYQ==
X-Google-Smtp-Source: ACHHUZ4h9VwKquywsf42uUwtj8v9rgfLZKpjqpnyTURqMpYiPqP6+pkefQphd1BXVxvQlYHeSGswXGxn4GyMYVBD+gA=
X-Received: by 2002:a05:6214:518b:b0:626:2dec:e357 with SMTP id
 kl11-20020a056214518b00b006262dece357mr6949905qvb.9.1685972743466; Mon, 05
 Jun 2023 06:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me> <ZHudRkB1YcMD_DaQ@surfacebook>
 <44c969a1-8dda-425b-acf3-9a80dfa60e79@app.fastmail.com> <CAHp75VcJ7bvGMQkVpnP2g_FXxQYapf0mXSZ9ETXj2P=cH9N17Q@mail.gmail.com>
 <e7960f41-3d72-4037-9f9c-ff43fedd10e2@app.fastmail.com>
In-Reply-To: <e7960f41-3d72-4037-9f9c-ff43fedd10e2@app.fastmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 5 Jun 2023 16:45:07 +0300
Message-ID: <CAHp75VcimGn_h=0CNzKeG5S7iScpc3itieb=AuvSad-higzzbQ@mail.gmail.com>
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

On Sun, Jun 4, 2023 at 10:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
> On Sun, Jun 4, 2023, at 21:24, Andy Shevchenko wrote:
> > On Sun, Jun 4, 2023 at 8:19=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wr=
ote:
> >> On Sat, Jun 3, 2023, at 22:06, andy.shevchenko@gmail.com wrote:
> >> > Thu, Jun 01, 2023 at 08:34:00AM +0300, Nikita Shubin kirjoitti:
> >
> >> As long as the platform selects it, this is the normal
> >> way to add a clocksource driver.
> >
> > Shall we now require this format of COMPILE_TEST for all new code
> > (which is selectable)?
>
> It's somewhat subsystem specific. For irqchip and clocksource drivers,
> I think it's already done this way, but these are the ones that expect
> a platform Kconfig option to select the drivers, which is usually
> not done for other subsystems.
>
> If the driver is not selected by the platform, you usually have
>
> config FOO
>       tristate "description"
>       depends on ${PLATFORM} || COMPILE_TEST
>       default ${PLATFORM}
>
> which makes it possible to still disable it, or (optionally)
> hide the option by adding "if COMPILE_TEST && !${PLATFORM}"
> which I personally find a little too complicated but is
> appropriate for some drivers that are required for booting.

Thank you for this nice elaboration (every day to learn something new)!

--=20
With Best Regards,
Andy Shevchenko
