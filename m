Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D37732C93
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjFPJ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbjFPJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:57:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F04A2D6B;
        Fri, 16 Jun 2023 02:57:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54fb23ff7d3so374650a12.0;
        Fri, 16 Jun 2023 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686909461; x=1689501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSWPkl0GFydjtQjoGfD84JMg5QUAqadLvCPjoKyFk/g=;
        b=NI1iKvl3RMZOqooY3oDaUiNuG3ljgxd4rNh/b6GXzeq0LrnAbYqiWGW5dkYeHhF6Q0
         rgPnLKX35oso6ufA6urIqmAymiVx7S2rJ6y4WU9DNpVSqCNQM36yvM9LIJe/jheqa5FI
         ngbGI0HBdTEV2LjiX1ePJa5zE3kCQ221VhINFVDFTXk6zXYyBfh3zwe3xW1elT58Zu7I
         d3n9IqsiBrSfdgYEp0iDz0+BI1N1g/ku0IqjbcxBOYE2Td0A2zJG7707JtR+AIvWEEX/
         Xvtsb3SWvWxxA2IMhNguq9a6EyUwspbcb5JByF/vPAIbnTZitkV9ntyPkLMI3V+mii2m
         H7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686909461; x=1689501461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSWPkl0GFydjtQjoGfD84JMg5QUAqadLvCPjoKyFk/g=;
        b=K0Xy8XiXqDhscb9uNPHFGcYHNHNnbnxvcw6AJ8uTTOQbwg+cMTiW5xagCqdyUG8rMa
         6nBqt6jc20Bf3zYrFFhqYm42HCvPmGNd4QLdbqtEplSwF2ThUGsF8eU9ubfWvCZ+JVlF
         uG7PQJSu6gcfXZYc0gLX2Kpa9u4gUHNpQWjAwjTkhrtf5M2RvD+oH1ODNtYwBTC8LNDK
         1Pv+4YQVSxWPmD8/84PcybR99Y8I940bM8UZRpCQJ4wMJ9fgHMEX1WcAtOetcMOZ58Jl
         266tQ7xslaPk68+Kn8WMGVMsXLCb9SrFeVPzQWb9Q+Rl5p1wk/r7RQSL+XNnKZuMG4s4
         HEQw==
X-Gm-Message-State: AC+VfDx/V8GgWEIw0PFUl2BjuL9PdH5SNwMW7OHYehc87Demy2osIkJ4
        U8cvTAw5EDMp4Ri4hCVAh8DmINyYoGxjqQop3js=
X-Google-Smtp-Source: ACHHUZ6Xr7jEKTocO3zdpMURLNPKvIe0g4CLZ3O+v7Vi0S2kHoaUXSUaqAbwMWkTRwVpsbZ6aT3vLCDQxPIZ3EeC4cc=
X-Received: by 2002:a17:90a:898c:b0:256:cf39:afce with SMTP id
 v12-20020a17090a898c00b00256cf39afcemr1020399pjn.43.1686909461105; Fri, 16
 Jun 2023 02:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
 <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
In-Reply-To: <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Fri, 16 Jun 2023 11:57:29 +0200
Message-ID: <CAO9szn00vRFm+iM1m7KgkW0WRuKyJEgVU4tVx4f5tF6KPnE=2w@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

thank you for the comments.

=C4=8Det, 15. lip 2023. u 21:55 Linus Walleij <linus.walleij@linaro.org> na=
pisao je:
>
> Hi Paulo,
>
> thanks for your patch!
>
> Overall this looks very good.
>
> I doubt that the display controller is actually by Fannal, but I guess
> you tried to find out? We usually try to identify the underlying display
> controller so the driver can be named after it and reused for more
> display panels.

Yes, of course, the controller is ST7701S.

>
> Some minor questions/nitpicks below.
>
> On Wed, Jun 7, 2023 at 5:11=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.com=
> wrote:
>
> > +static int fannal_panel_enable(struct drm_panel *panel)
> > +{
> > +       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(panel->dev);
> > +
> > +       mipi_dsi_generic_write_seq(dsi, 0xFF, 0x77, 0x01, 0x00, 0x00, 0=
x13);
> > +       mipi_dsi_generic_write_seq(dsi, 0xEF, 0x08);
>
> Why is everything using mipi_dsi_generic_write_seq() instead of
> mipi_dsi_dcs_write_seq()?

Okay, I will replace it.

>
> Especially here, because 0x11 is certainly a command:
>
> > +       mipi_dsi_generic_write_seq(dsi, 0x11); //MIPI_DCS_EXIT_SLEEP_MO=
DE
>
> Instead use:
>
>     ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
>     if (ret)
>             return ret;
>
>
> > +       mipi_dsi_generic_write_seq(dsi, 0x29); //MIPI_DCS_SET_DISPLAY_O=
N
>
> Instead use:
>
>     ret =3D mipi_dsi_dcs_set_display_on(dsi);
>     if (ret)
>             return ret;
>

Okay I will replace all commands with a functions found here:
https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_mipi_dsi=
.c#L995

> Yours,
> Linus Walleij

Best regards,
Paulo
