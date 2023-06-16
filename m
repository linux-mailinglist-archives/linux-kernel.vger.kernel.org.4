Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403A73313F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 14:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344054AbjFPMbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 08:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFPMbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 08:31:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E411FCC;
        Fri, 16 Jun 2023 05:31:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6664a9f0b10so614623b3a.0;
        Fri, 16 Jun 2023 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686918696; x=1689510696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm26FPRdEuF0YwkxWbrT+z8zY664CKlz4NjHENy56Us=;
        b=a05oQ1ePVVw5aKhJV/qcSzr4QWznhaIZ5pzXjcJZTHAoK67+GdFkyd52kBiq+Xo5wy
         6v1lgAXd26LTOw0MuJGgkxHAsBktMM5/FqTLDTBv8BsDm/4yeY3E4dSsIaQy8HzaRvKu
         T1X3PkRzIOldSrE79Wwb8PrnlmPYoht0PRGJStEaET7Vd8T1ex9uoFBuxawzlipL8ME0
         7KBy8VO24fCQwuwLxSfYZ6WsPFnfj/f/6QdfogmNw1jIU1SGKByaKcLudiMAOe/0TtMA
         AoPb3bdhIorOHE0u1wQ+Lu5gR5mPWGLqvhuqelZZdVlVinrCHh8GRZNsd8PuVJ8u7k/I
         Zt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686918696; x=1689510696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm26FPRdEuF0YwkxWbrT+z8zY664CKlz4NjHENy56Us=;
        b=gLVgNE8dtkFOyLUu8s7DP/A1u/cOfchQUwDGu/d48XWDl90ixs7YXl95oZsJOqvghp
         v6NfDWnYgytzJ7aPJ0lxl5zQcolhY/2J2RJcvv/hdJTYaq0aMpAA98J/K12oLh5CtXF9
         IMhArOrZtBrCX0fdL442ynEkgI8oNrJFIiAAsv6t0wc4PkZ7OGBJ4ONidho/Jcgp912o
         fq3kSOeYGvbO+BgF7HCpgroR+yvYjdlVpIvDTyEAFIPV5KgssdiPz9dNfmYzxGsu80so
         BHMDzkl2vAiOKIKzald9WU49fDsYMoZOxeUhb3UFyFo0DYugaj2xs+fn1N9KIMtcF34Z
         JawQ==
X-Gm-Message-State: AC+VfDxVmPUDHW1DLtfP5gfyBqowPdEcNExmzjZ00N7HtP41SoWga55U
        7BElWn17yTOOzR/cUw/+clJMQ/1+riLRiDXjmqOZ35h12FM=
X-Google-Smtp-Source: ACHHUZ4v59zC84NLCUrSS490QCKZGfzTuz9JmKYtcJPuSOdbHRtJu6+cZfkZCOvoJv1GUV6IauD+v8rwbtxKcgsidRE=
X-Received: by 2002:a17:90a:656:b0:259:343:86b5 with SMTP id
 q22-20020a17090a065600b00259034386b5mr1338940pje.47.1686918696408; Fri, 16
 Jun 2023 05:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com> <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
In-Reply-To: <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Fri, 16 Jun 2023 14:31:25 +0200
Message-ID: <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

pet, 16. lip 2023. u 13:44 Linus Walleij <linus.walleij@linaro.org> napisao=
 je:
>
> On Fri, Jun 16, 2023 at 11:57=E2=80=AFAM Paulo Pavacic <pavacic.p@gmail.c=
om> wrote:
> > =C4=8Det, 15. lip 2023. u 21:55 Linus Walleij <linus.walleij@linaro.org=
> napisao je:
> > >
> > > I doubt that the display controller is actually by Fannal, but I gues=
s
> > > you tried to find out? We usually try to identify the underlying disp=
lay
> > > controller so the driver can be named after it and reused for more
> > > display panels.
> >
> > Yes, of course, the controller is ST7701S.
>
> Hm did you try to just refactor
> drivers/gpu/drm/panel/panel-sitronix-st7701.c
> to support your new panel?
>

Yes I have tried, but there are too many changes needed and I wasn't
sure whether I would be breaking compatibility with st7701 based
panels.

> One major reason would be that that driver knows what
> commands actually mean and have #defines for them.
>
> Yours,
> Linus Walleij

Best regards,
Paulo
