Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7082737D77
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjFUI3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjFUI3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:29:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B8910DA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:29:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso7437629a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687336147; x=1689928147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nk1REjxh13RDFMixwQF0Wa6MImxEsHq1Btoq+GOXg2o=;
        b=gL8pf0ZnrQlh0QuUD9HbLVyd9CpIiQ7jLKx6Zn/byg9iWx8klb6/iYvqwsW4kc+frm
         40nT/ceeyqpMv2Tnza1+0CMDmGTir2FGUWrnMNHyvomKX0kEvsmiMywdW+QMLXDZC4fP
         +VBIOYJCpSQpyGEU4OYyPG0Ukk8gHZ44jqhIK2g1A/36r3rLg1LwjqlZiiBY4uWePfsx
         Xb66AOP1h7IjlJMYCpJIFVfzVdCyUwHrDx5pupPb7RhKrVSeBy7wpOalNl0zEhmOHlsn
         xjW1RFPiHsa7+rRn7YDAHHHD5xroKFA92kAY5XDdSh7vJqjc/dNQs2UWbwrxAzPCRPks
         gFlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336147; x=1689928147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nk1REjxh13RDFMixwQF0Wa6MImxEsHq1Btoq+GOXg2o=;
        b=a8nupkBqRyNdSjaXgKvoQjEPoqbODl0DqQc17kx1XAtbZz3eihiWbMN1H2BNxBzXJr
         832OsjYLOLpVaVfThQQeXz/S2nPaQ0o8e57Vw0mKb5ekubDe0mMPwyYu0apdaMlnVqzt
         J43G3BM6ZHPKY3az1F8Oa03WitbymZfce1IqxMfmaRIABB8LWS5+CkjZpjZTYAofJ+bj
         ZJxG+IJwveQt9K7LNquLYHLIoYNshXRUDgOPa0clG4aFGqOoczsrcJwTTI9hDTkrPgvO
         k+LrZOLdODSEKwTXUaP9CtUoj9Ah3xdli21ilW8jnEiSF5BVx06EJmQyAOxH/3r4WdWK
         XJcQ==
X-Gm-Message-State: AC+VfDxNI9NyiSzkr2aRcCqHfdyme98C0pzWe5QatsW/3RT+acRO1VBg
        ZNMJHtEblYyUOqtqTGgKiyfsIPsRDR2PuI3mdFs=
X-Google-Smtp-Source: ACHHUZ5vCt0Y7ukOoL4v3riqB4xsP8+kCrpqJtePDRhN93rcN4HJaZV1EpHcrNBMm/5cE0TN16x74POF5bllWC4ECsA=
X-Received: by 2002:aa7:c314:0:b0:516:3261:17d with SMTP id
 l20-20020aa7c314000000b005163261017dmr9542121edq.20.1687336146807; Wed, 21
 Jun 2023 01:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-10-nikita.shubin@maquefel.me> <ZHudRkB1YcMD_DaQ@surfacebook>
 <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
In-Reply-To: <35bc18b2e685e8596b1fdc1a2e6212dc98725cd4.camel@maquefel.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jun 2023 11:28:30 +0300
Message-ID: <CAHp75VdygQvzeWUHcQBteKZmvC6nBDeQv1c2ZJ-SBCHcjn4h+A@mail.gmail.com>
Subject: Re: [PATCH v1 09/43] clocksource: ep93xx: Add driver for Cirrus Logic EP93xx
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Wed, Jun 21, 2023 at 11:22=E2=80=AFAM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

...

> > > +       irq =3D irq_of_parse_and_map(np, 0);
> > > +       if (irq <=3D 0) {
> > > +               pr_err("ERROR: invalid interrupt number\n");
> > > +               ret =3D -EINVAL;
> >
> > Shadowed error in case of negative returned code. Why?
>
> Majority of clocksource drivers shadow it. Same like above.

It doesn't mean they are correct or using brand new APIs.

Can you use fwnode_irq_get() instead?
The shadowing is most likely due to nasty =3D0 comparison.

Also that ERROR is a bit weird, pr_err() is already on error level.

--=20
With Best Regards,
Andy Shevchenko
