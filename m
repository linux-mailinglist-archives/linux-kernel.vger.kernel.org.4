Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11176723920
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbjFFHgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFFHgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:36:51 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCB9106;
        Tue,  6 Jun 2023 00:36:50 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b0201d9a9eso42378375ad.0;
        Tue, 06 Jun 2023 00:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686037010; x=1688629010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nD/LkGWtI5flKQ+Ke2jMCbqz9Sr5XNRMirWL/QAprxA=;
        b=AcmFSCfdJkk9Hn7hgZC5mDeXrTp+dEiBAeSopwWhIpVuqmeml2QyMIXHyh+KVYJGfp
         lpoc7El2Ps0adh7C5569hmz7fR/33rQhMwylPaXozbK83Egh744tigif2cmQj5HKJYva
         Oaz1+2HOPMYwoHWfTiW+JXO451kD2H5QbejrwOC1sjZAoB70C+reunq2k//0tR5/dDOO
         r5WRDhytXwr0fbWnnEAGRpO0WZyo6XMJvq7oO82X3Io6jQeyPm3p/ZAsApmJmb0Oo+gs
         y9me+NeBEdnwJiaZW0hSWRTjAhnSHcTJj70+EqAom7xhYVuLApaUL0/k7c2FwTuZRKiI
         jLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686037010; x=1688629010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nD/LkGWtI5flKQ+Ke2jMCbqz9Sr5XNRMirWL/QAprxA=;
        b=hA81Hu2nz8CI7RFKFJAdN2diPHfVjP9wD7NQPeU0xDQyTaGU9bPsted/5LD3dBNx/W
         iiCyCL3Bzc4eC7J9flYFAFwLkywCJONKLz2qjOwHsWZTlsICWIbeB6tEmZ2cOSHdQvav
         AAIpavDAyRQIU7w/YippaCiwP59LCg2RATSWlmnUMPqJwz4i6trxwCixUg2NfSoRkoQa
         7pe2dB40s/Hf2sU9HP7u9Mmd/vhLwYWFYTtF8b0HHXD/as3MUoheyXemsPoyonwbEQqY
         FzMC+9g+znMgQmYRIVjHIZTg1GV5NJ/JqGVktG0th9VzvUB8gvEI9q6dAdhaPIFqNrge
         GR5Q==
X-Gm-Message-State: AC+VfDxEfn+vBEE00WtowqT5SQXP39x4ilj4MCT0Hpj905oOOcT8Be5O
        XyyhNVAuJpgLaTHRHxtsdxlQv6TS5yd9CYOEaQI=
X-Google-Smtp-Source: ACHHUZ428r6gqxfQi0LZN59H7BZK1TBLgS52eAK3fHMnnNGvKJfr7euZ5zxRhhFrw6faArzEBTIeE6YDOATI6/h9tiI=
X-Received: by 2002:a17:902:e845:b0:1ac:820e:c34a with SMTP id
 t5-20020a170902e84500b001ac820ec34amr11893662plg.0.1686037009953; Tue, 06 Jun
 2023 00:36:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230605153539.497602-1-pavacic.p@gmail.com> <20230605153539.497602-4-pavacic.p@gmail.com>
 <4bb22e77-b3f0-be07-5e8a-442c3aa3fd48@linaro.org>
In-Reply-To: <4bb22e77-b3f0-be07-5e8a-442c3aa3fd48@linaro.org>
From:   Paulo Pavacic <pavacic.p@gmail.com>
Date:   Tue, 6 Jun 2023 09:36:39 +0200
Message-ID: <CAO9szn05edU_HZHVnREMZcwm6TbBa4psABoqSqLWghFc=KbV7w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/panel-fannal-c3003: Add fannal c3004 DSI panel
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzysztof,

uto, 6. lip 2023. u 09:14 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisao je:
>
> On 05/06/2023 17:35, Paulo Pavacic wrote:
> > Fannal C3004 is a 480x800 display made by fannal that requires
> > DCS initialization sequences.
> >
> > Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> > ---
>
> > v3 changelog:
> >  - using generic mipi_dsi_dcs_write_seq
>
> This is marked as v2?

I have ruined numbering. At first this driver was named
panel-mipi-dsi-bringup and parts of it weren't handled under patchset.

>
> >  - removed success prints
> >  - removed some comments
> >  - simplified code/removed support for different panels
> >  - changed namespace from fann to fannal
> > v2 changelog:
> >  - renamed from panel-mipi-dsi-bringup
> >  - only one MAINTAINER e-mail
> > ---
> >  MAINTAINERS
>
>
> > +static int fannal_panel_probe(struct mipi_dsi_device *dsi)
> > +{
> > +     struct device *dev = &dsi->dev;
> > +     struct fannal_panel_data *panel_data;
> > +     int ret;
> > +
> > +     panel_data = devm_kzalloc(&dsi->dev, sizeof(*panel_data), GFP_KERNEL);
> > +
> > +     if (!panel_data)
> > +             return -ENOMEM;
> > +
> > +     panel_data->reset = devm_gpiod_get_optional(
> > +             dev, "reset", GPIOD_OUT_LOW | GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>
> dev should be in previous line
>
> Why this is nonexclusive? How many instances of same driver are
> expecting to get this on one system?
>
> > +
> > +     if (IS_ERR(panel_data->reset)) {
> > +             ret = PTR_ERR(panel_data->reset);
> > +             dev_err(dev,
> > +                     "error: probe: get reset GPIO: (%d) Check the fdt\n",
> > +                     ret);
>
> return dev_err_probe
>
> > +             return ret;
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
>
> So you leave the panel in reset state?
yes

> > +
> > +     drm_panel_init(&panel_data->panel, dev, &fannal_panel_funcs,
> > +                    DRM_MODE_CONNECTOR_DSI);
> > +     dev_set_drvdata(dev, panel_data);
> > +
> > +     drm_panel_add(&panel_data->panel);
> > +
> > +     ret = mipi_dsi_attach(dsi);
> > +     if (ret) {
> > +             drm_panel_remove(&panel_data->panel);
> > +             dev_err(dev, "error: probe fail: can't attach mipi_dsi!\n");
>
> No need to shout, skip exclamation mark.
>
>
> Best regards,
> Krzysztof
>

Thanks,
Paulo
