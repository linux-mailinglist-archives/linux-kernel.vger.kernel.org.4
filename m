Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720D87508B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGLMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGLMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:50:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAB21727;
        Wed, 12 Jul 2023 05:50:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9891c73e0fbso158662566b.1;
        Wed, 12 Jul 2023 05:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689166223; x=1691758223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQV/KI0xKp02Tf1NnR0O2OPj1ob88SVAGpNsE94UZRY=;
        b=nktiyXVVyeMUeDoHdoSrZhrVLSY+HFfpBZxe1mucuRJlfGFnPnUCl5ZQ0OJx7XtkMn
         GcnnGQOjK57Yn7fWxyyQbvHU4vRZMOI0haSPbq0QodOIajRjECEjr/lGOaG660UNlNEE
         3HyZuosVTdl9oIEuRjSpwMnx9FKekG8cZ9U1aqOb1BE5WahEySBrq6uLFtbrYrgJIiSt
         sfUj9VUEKbhsRIyT7CMnh7qIgRJL1HHszG7PLZ3eEjsIRYQGpQuFs6PcTz0IJdZbs8zN
         wJ1HaUDBGUrGZYcjCxDEgEYkXAPo13nOP+lhPP04t+a3fQp8cnt/m96PQm8I+Ow/yAzD
         39Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166223; x=1691758223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQV/KI0xKp02Tf1NnR0O2OPj1ob88SVAGpNsE94UZRY=;
        b=dl9COGEEBLe+3GrxA/XFeTzGD132fgHWyOg27tIVwRjYRKYe1LH9JM4IcnqC3TLuuv
         /DHu7YS1be4O+ci4cpEdYVc3nu0ZqpHAj+GuF+jFYXNAFwfvU4wFwDJxD8lh7rp9f9ZX
         dz1oygyweJ8Nm7L39hL5ZcyAkvNw2TBNncxkSvMR81Q0Bjg5xFj2IR+ahC72ygUmdiG/
         NJ8RNdJ5GArjXL4FDmaHv99hSpmBANjoR8sVFd21aMIu4fsBQrsnFCbD38Z4Fni6l8SY
         PGUZFfD/pn1gPPIJV2KBvOCJe6ykf15zUmeZ9BO6EAeLHji30RVKYK7lDBLC57iE7scO
         LtHg==
X-Gm-Message-State: ABy/qLZcc0+Lhn1yIdjYFCXzRlUtVkAqelSLgqJwNLF7bKXojw7cFgxW
        8Agf3SeXAQxdikPr/JLLf7Vgdrm+ZlONjtZ+5beamkdJzObV2Q==
X-Google-Smtp-Source: APBJJlHm7GwhLcZsgAh15vkvtqXjpTbdVBdlUvKSPlHjXFU+r7qfdpWiAJU0xke6wicWsTB/uTleXl9LMLVEi5V+r9c=
X-Received: by 2002:a17:907:a410:b0:993:da5f:5a9b with SMTP id
 sg16-20020a170907a41000b00993da5f5a9bmr2422458ejc.8.1689166222484; Wed, 12
 Jul 2023 05:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230711083055.1274409-1-fshao@chromium.org> <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
 <20230712120026.GD10768@google.com>
In-Reply-To: <20230712120026.GD10768@google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 12 Jul 2023 15:49:46 +0300
Message-ID: <CAHp75Vd4cuNEQUotVZb8Xu+JMC9KKUk_Gg5N_YsA2KoEANwBKw@mail.gmail.com>
Subject: Re: [PATCH] leds: pwm: Fix an error code
To:     Lee Jones <lee@kernel.org>
Cc:     Fei Shao <fshao@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 3:00=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
> On Tue, 11 Jul 2023, Andy Shevchenko wrote:
>
> > On Tue, Jul 11, 2023 at 11:31=E2=80=AFAM Fei Shao <fshao@chromium.org> =
wrote:
> > >
> > > Use the negated -EINVAL as the error code.
> >
> > Thank you, it seems Dan had been the first one.
> >
> > Message ID <a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain>
>
> I don't know much about how other people operate, but I have no way to
> trivially navigate to this.  Would you be kind enough to use URLs
> please?

Use this pattern:
  https://lore.kernel.org/r/$MSG_ID
where $MSG_ID is a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain
in this case.

Hence, the URL:
https://lore.kernel.org/r/a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mount=
ain

Easier way is simply run `b4 mbox $MSG_ID` and open the loaded mbox
with your preferred MUA.

--=20
With Best Regards,
Andy Shevchenko
