Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E8474A0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjGFPSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGFPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:18:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA021730;
        Thu,  6 Jul 2023 08:18:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-263121cd04eso498774a91.2;
        Thu, 06 Jul 2023 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688656708; x=1691248708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPB85WR0P+xgxqs8Q8QLiKAMJpfbqqxVyu2DnLqctsg=;
        b=UzHtICmgU/4K1rkod7vW7YianCzTXkLEfApsbzxnNRVFSML67a+WEeZgjdGNQtaOUS
         PhSFodmYF1UYuQK2PxXSUMuk9s+fWS4PFHbLpoEzBBIcL7XpnEVYo+zay7WSad3x+e1b
         UZfGln8snwQfvjSqE8fBjPW2qj3wIGsaw5/SbfZ9BZa1YTgOKgPDNXjxMhuoKKrvXlft
         KoDOMe9MvIqkyfC05Vsk4ywZiVPrNn6Vy2WxiDMmWi3uH3Xtzs8ukz+pK8jyiz6IFRov
         0jkDQYZHWWLANre+0+IXeknMuUc2youFbr0s0TNgB8proRli0iJ+kuqk6JbWBsP5CmbC
         9AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656708; x=1691248708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPB85WR0P+xgxqs8Q8QLiKAMJpfbqqxVyu2DnLqctsg=;
        b=l3E8RhN2qH4SDCUNLb/ljOMcP3l+m8VmddWbsPRZz7Gw2V3VojX/Y2QcY6VxLNG/fJ
         uPTwSG0zV25MKt3BfRWdiPoGbje6XsKbwNJGjhfBqB8dIf7D9jJM7M4B0hhBV/p3UsyI
         JMTJUauWthVbIBEXPeTnKCS2fwt1oFZJCf3wLcf8PmANhpkiyhqGOMKuaFILNWV7fFmf
         HfQi28JVWnAKOJdSSQh6Lqy+oOOwC1r9/pntN0Y+dKenH7bH2YsVbk3fWaVXMhzGrNSx
         WzRu/j92IsHuOyXMBfBp4zqSCSLCT2K5oVQeIxVtLr6YRSr9ZEujQJRe8LhxDWUExunK
         ONbQ==
X-Gm-Message-State: ABy/qLanIjw2iYE1zNknoITzRmIdS4cpwYRx6Gk+60f6fZ6Dt3o+lNSk
        xSZDSUff1nwOR2cO4YjBhezAeSqeTQfNmxhDyx0=
X-Google-Smtp-Source: APBJJlGbEK7+CMHGVikG5qSAkmi1koYQ7PRIaz5FQN5/ZPfU4hjy6xAtf8Iu7wMQZ/X0FMTcoopzGs9SvwJ6Mw+QQ+4=
X-Received: by 2002:a17:90b:1d10:b0:262:d4c8:cb3c with SMTP id
 on16-20020a17090b1d1000b00262d4c8cb3cmr1341343pjb.49.1688656708131; Thu, 06
 Jul 2023 08:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
 <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
 <CACRpkdaw8M3dSkmiV5QDOt3BBB7Jo6NxT0Og=zvA4REMA_7y9g@mail.gmail.com>
 <CAO9szn29A0qCABG0ACni42UGpsGKLwG7OT1y_ho3DgQ0WLvfmw@mail.gmail.com>
 <CACRpkdYXtQwmZR1u-1fwmyC_8Yq4bMkjDBcUCfuGqSz_UhXWJQ@mail.gmail.com>
 <CAO9szn0OuKW+-JZMs3TPUHiwLCe6cUPcsUq+og64K2utMyZpqQ@mail.gmail.com> <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
In-Reply-To: <CACRpkdb5stXKb7FNk_FC-PKduCngRX3sZTbzcxN+kRskz78fuQ@mail.gmail.com>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Thu, 6 Jul 2023 17:18:17 +0200
Message-ID: <CAO9szn3oTzrrwiyr91H14ep7OPUkA-SDST3CSQAQHvFFnkJWfA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jagan Teki <jagan@amarulasolutions.com>,
        Marek Vasut <marex@denx.de>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
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

Hello Linus,

=C4=8Det, 22. lip 2023. u 10:22 Linus Walleij <linus.walleij@linaro.org> na=
pisao je:
>
> On Wed, Jun 21, 2023 at 5:09=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.co=
m> wrote:
>
> > A lot of modifications to st7701 are required. I believe it would
> > result in a driver that doesn't look or work the same. e.g compare
> > delays between initialization sequences of panel-fannal-c3004 and
> > panel-st7701. I think it would be optimal to create st7701s driver and
> > have special handling for st7701s panels. If there was a flag for
> > whether panel is st7701 or st7701s it would end up looking like a
> > mess.
>
> What matters is if the original authors of the old st7701 driver are
> around and reviewing and testing patches at all. What we need is
> active maintainers. (Added Jagan, Marek & Maya).
>
> I buy the reasoning that the st7701s is perhaps substantially different
> from st7701.
>
> If st7701s is very different then I suppose it needs a separate driver,
> then all we need to to name the driver properly, i.e.
> panel-sitronix-st7701s.c.

I had in person talk with Paul Kocialkowski and I have concluded that
this is the best solution.
I believe I should rename it to st7701s due to the hardware changes. I
would like to create V5 patch with driver renamed to st7701s.
Please let me know if you agree / disagree.

>
> Yours,
> Linus Walleij

Thank you for your time,
Paulo Pava=C4=8Di=C4=87
