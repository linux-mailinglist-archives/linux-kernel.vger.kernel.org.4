Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E69726170
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjFGNig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjFGNid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:38:33 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C53819BC;
        Wed,  7 Jun 2023 06:38:32 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-55b171c1e16so1011294eaf.1;
        Wed, 07 Jun 2023 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686145112; x=1688737112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3OWCbf5H61Lfol0csF8z8CFfOPa3TQ/ObPqUdE2SX4=;
        b=KAmyP/ini8v90wI/GFZqjfjS31ontpl+4VtaLOvLQs94la+/W4d9Fgv5fr8QackOCJ
         dCNzrA2qR/pEvumBrxz0oqTIZVZ+PuMVH4dK6hjoAeYbEhFyYdMWhPdxCJuTCO4Pt61N
         KeVlg5IRdU2msZJAvv8Gb4dOmYR7j4xw1unq1tULmlpfzSQ5F1Q1EoJcUN5GeYxGO+gu
         wcTfCKT13c8g+KWWiPZBO4TyhPOX5qZu5hdKXbCCKmlbCSomMQskSw5aBw0A15aYCfUI
         gQHacmh4BgpzFGIDk6OEzpSN2aM5g9LZ1bUzti2nqUhrJfOyONPnA6EAN1ZuPVNJHhmq
         38Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145112; x=1688737112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3OWCbf5H61Lfol0csF8z8CFfOPa3TQ/ObPqUdE2SX4=;
        b=NML8rErI+9kqrorzuNr9D417TM373yByiRyL0/k4HmUzwOjxlqeB710XSglA7DMOMN
         +/KhaWRQ0vwajeu+o0sP7OizEpHibrDzfiIrcitYlAwgI6QsEP6Mgj7oenSCShgb+Ygz
         0hQ9FImb6oJudxbquhFeD1y6Z8eo7fwRuP/huxyp6noQ6CRN+81fDTjEYYLwAlH0PfPh
         pQk/XhFdZhzAOxKKzDrQ/C+KLnCJrzaJ2wMnQQNiePJSUht45Vc5S8z+K/7GxdN6h8V2
         EAgQ4nBpqO/8pBYSNNlcM2t5zrdDN+MzjzcCyDNYZu02EJjGy1itf/VmeL45TB5qN77f
         8Yxw==
X-Gm-Message-State: AC+VfDyGJC9BqLxS5apuM9kswcpO0EcGWevauHQeqNxIysCgeBvSVrgJ
        kyZ/waDXV2rJhyEM+olmkuyUixvv6/NBGPHfnqw=
X-Google-Smtp-Source: ACHHUZ7ykAOu9yzsGVGgnF/U30QPe7I5TCv2TcaCoYPjApr8wINN1s7hJpFNRgkwQTTnByd7Lu0vdiqoVuvkrNRp8LE=
X-Received: by 2002:a05:6808:b0d:b0:39a:bc60:adf2 with SMTP id
 s13-20020a0568080b0d00b0039abc60adf2mr5640664oij.24.1686145111699; Wed, 07
 Jun 2023 06:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230606140757.818705-1-pavacic.p@gmail.com> <20230606140757.818705-4-pavacic.p@gmail.com>
 <dfe2c108-0268-c4d0-226e-b3d2bc8c3369@linaro.org>
In-Reply-To: <dfe2c108-0268-c4d0-226e-b3d2bc8c3369@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Wed, 7 Jun 2023 15:38:20 +0200
Message-ID: <CAO9szn3PyQQRKsxdsOrmVNMP2xuvN4_dHwb1_TWEqmhnr3TLPA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

uto, 6. lip 2023. u 16:45 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisao je:
>
> On 06/06/2023 16:07, Paulo Pavacic wrote:
> > Fannal C3004 is a 480x800 display made by fannal that requires
> > DCS initialization sequences.
> >
> > Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> > ---
> > v4 changelog:
> >  - formatting and style changes
>
> Are you sure? I see other changes - removal of some code, handling
> errors and GPIO.
>
> >  - change community room
>
> What does it mean? Where is this change in this patch?
>
> ...
>
> > +
> > +static const struct drm_panel_funcs fannal_panel_funcs = {
> > +     .prepare = fannal_panel_prepare,
> > +     .unprepare = fannal_panel_unprepare,
> > +     .enable = fannal_panel_enable,
> > +     .disable = fannal_panel_disable,
> > +     .get_modes = fannal_panel_get_modes,
> > +};
> > +
> > +static int fannal_panel_probe(struct mipi_dsi_device *dsi)
> > +{
> > +     struct device *dev = &dsi->dev;
> > +     struct fannal_panel_data *panel_data;
> > +     int ret;
> > +
> > +     panel_data = devm_kzalloc(&dsi->dev, sizeof(*panel_data), GFP_KERNEL);
> > +
>
> Drop blank line.
>
> > +     if (!panel_data)
> > +             return -ENOMEM;
> > +
> > +     panel_data->reset =
>
> You have wrong wrapping here. devm_gpiod_get_optional() goes after =.

I'm not sure why, but clang-format makes it that way. I'm using this
style: https://raw.githubusercontent.com/torvalds/linux/master/.clang-format
Do you have some other style?

>
> > +             devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> > +
>
> Drop blank line.
>
> > +     if (IS_ERR(panel_data->reset)) {
> > +             return dev_err_probe(
> > +                     dev, PTR_ERR(panel_data->reset),
> > +                     "error: probe: get reset GPIO: (%d) Check the fdt\n",
> > +                     ret);
> > +     }
> > +
> > +     mipi_dsi_set_drvdata(dsi, panel_data);
> > +
> > +     dsi->format = MIPI_DSI_FMT_RGB888;
> > +     dsi->mode_flags = MIPI_DSI_CLOCK_NON_CONTINUOUS |
> > +                       MIPI_DSI_MODE_VSYNC_FLUSH | MIPI_DSI_MODE_VIDEO_HSE |
> > +                       MIPI_DSI_MODE_NO_EOT_PACKET |
> > +                       MIPI_DSI_MODE_VIDEO_SYNC_PULSE | MIPI_DSI_MODE_VIDEO;
> > +     dsi->lanes = 2;
> > +
> > +     gpiod_set_value_cansleep(panel_data->reset, 1);
> > +
> > +     drm_panel_init(&panel_data->panel, dev, &fannal_panel_funcs,
> > +                    DRM_MODE_CONNECTOR_DSI);
> > +     dev_set_drvdata(dev, panel_data);
> > +
> > +     drm_panel_add(&panel_data->panel);
> > +
>
>
> Best regards,
> Krzysztof
>

Thanks,
Paulo
