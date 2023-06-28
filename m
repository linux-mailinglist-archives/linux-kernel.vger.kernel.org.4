Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB66740CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjF1J2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjF1JWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:22:51 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C5E213D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:22:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-bd77424c886so5736131276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687944169; x=1690536169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/BYorY/q5cLcDCJ090Ghd9w+MLE7Dxtd/FOA8XGDK0=;
        b=yGjc51d+pnM9hgZXegh8DLv4eBfWeNuQiQAqZqW/yiUB1oZacLRVjQkPKxQ1SD3+cr
         OB9/i0YTbxwHomeiZ+R6g4e8ZlP9pHZrNtvk4dODAOPVPjg62kWiAbzqUknUJlbv2w8w
         80uXgaDuIp90IZ8SgDVZ/RMIX03ZD3Jgq5ih+FL9wx6yYgNE/zB/3VhKzl+nyVnXExaC
         ZQToOuiiFgx5ELsVyQhptW9UqaLW7uN0QNjQ0qavMfUQHvMtu1Oa9hBD1Dz4qd2PQrUy
         4Xhys1MVsogiRyPPJtcTynNPChMfuNIlaSus7JRWHT4Kpac2UG9+lVMsrpqHfGfBuCGM
         hw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687944169; x=1690536169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/BYorY/q5cLcDCJ090Ghd9w+MLE7Dxtd/FOA8XGDK0=;
        b=hHh6QSrOFtyjERiFpuOFJstdLJ0JPtTmY2O9i4jB7ixPhmg9bSu8V7hE6N0WKBRB4H
         NpihZJ6157/OfUH2LGFG1UfpHjdF2LhoyjjyaDkBsPoJl0gmMA8NtKBDD1M0BVg4g3A3
         HBvP4rg7v8G+xm2gsNZjqaodOYLaX0D7vaVQ8N5u0gMxgB4i0BjwcOi/8vkbG4LyQh1D
         +JzkEWgPy1LkI7VjKy6s+3GgVlX3CGV++erjmZsQ2t+kB57NdDWXWm1+CNal0mcyjmGU
         vWj771lscC8J8a/x/YG9Sqe0KwrT84mGotZaB1qjNPYm/eMhuuhBkmGd4JH/AkL6F2Dm
         UNeQ==
X-Gm-Message-State: AC+VfDy3wV/Dm4ckUhpfA1oW7WlItXHGXU9zU5cxiW3T+Z85F4WmySYY
        wme41WxN9zIFIY7kkW4p/oIyI7lHmGpJpRwzX9hyrg==
X-Google-Smtp-Source: ACHHUZ4r8WinXJCe974MXutLGlQG6R6mzm8uxHQuDvBriU4zf9/VBOQVyva1v0fUYCoOQYRpUOz5Bz8N4Lm1mHqZQc8=
X-Received: by 2002:a25:838e:0:b0:c12:abdb:c22d with SMTP id
 t14-20020a25838e000000b00c12abdbc22dmr12289571ybk.61.1687944169188; Wed, 28
 Jun 2023 02:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230521-drm-panels-sony-v1-0-541c341d6bee@somainline.org> <20230521-drm-panels-sony-v1-10-541c341d6bee@somainline.org>
In-Reply-To: <20230521-drm-panels-sony-v1-10-541c341d6bee@somainline.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 28 Jun 2023 11:22:37 +0200
Message-ID: <CACRpkdbrk_pPqewo-bGPq4NQScHSRKNMeO0ik_aqEQ+BY12BBQ@mail.gmail.com>
Subject: Re: [PATCH RFC 10/10] drm/panel/sony-griffin-samsung: Add panel
 driver for Sony Xperia 1
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Caleb Connolly <caleb@connolly.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 11:23=E2=80=AFPM Marijn Suijten
<marijn.suijten@somainline.org> wrote:

> The Sony Xperia 1 (codename kumano griffin) features an unnamed 4k OLED
> DSI cmd mode panel produced by Samsung.  It can be driven in a
> 1644x3840@60 or 1096x2560@60 mode, and always has Display Stream
> Compression 1.1 enabled.
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
(...)

> +static int sony_griffin_samsung_on(struct sony_griffin_samsung *ctx)
> +{

> +       ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
> +               return ret;
> +       }
> +       usleep_range(10000, 11000);
> +
> +       ret =3D mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLA=
NK);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set tear on: %d\n", ret);
> +               return ret;
> +       }
> +
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +       mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x05);
> +       mipi_dsi_dcs_write_seq(dsi, 0xd7, 0x07);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +       /* Enable backlight control */
> +       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, BIT(5=
));
> +       msleep(110);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +       mipi_dsi_dcs_write_seq(dsi, 0xe2, enable_4k ? 0 : 1);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +
> +       ret =3D mipi_dsi_dcs_set_column_address(dsi, 0, hdisplay - 1);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set column address: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret =3D mipi_dsi_dcs_set_page_address(dsi, 0, vdisplay - 1);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set page address: %d\n", ret);
> +               return ret;
> +       }
> +
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +       mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x70);
> +       mipi_dsi_dcs_write_seq(dsi, 0xb9, 0x00, 0x60);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
> +       mipi_dsi_dcs_write_seq(dsi, 0xc5, 0x2e, 0x21);
> +       mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
> +
> +       ret =3D mipi_dsi_dcs_set_display_on(dsi);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to turn display on: %d\n", ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}

This is eerily similar to the sequence in panel-samsung-sofef00.c:

static int sofef00_panel_on(struct sofef00_panel *ctx)
{
        struct mipi_dsi_device *dsi =3D ctx->dsi;
        struct device *dev =3D &dsi->dev;
        int ret;

        dsi->mode_flags |=3D MIPI_DSI_MODE_LPM;

        ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
        if (ret < 0) {
                dev_err(dev, "Failed to exit sleep mode: %d\n", ret);
                return ret;
        }
        usleep_range(10000, 11000);

        mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);

        ret =3D mipi_dsi_dcs_set_tear_on(dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK=
);
        if (ret < 0) {
                dev_err(dev, "Failed to set tear on: %d\n", ret);
                return ret;
        }

        mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
        mipi_dsi_dcs_write_seq(dsi, 0xf0, 0x5a, 0x5a);
        mipi_dsi_dcs_write_seq(dsi, 0xb0, 0x07);
        mipi_dsi_dcs_write_seq(dsi, 0xb6, 0x12);
        mipi_dsi_dcs_write_seq(dsi, 0xf0, 0xa5, 0xa5);
        mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x20);
        mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_WRITE_POWER_SAVE, 0x00);

        ret =3D mipi_dsi_dcs_set_display_on(dsi);
        if (ret < 0) {
                dev_err(dev, "Failed to set display on: %d\n", ret);
                return ret;
        }

        return 0;
}

Isn't this just the same display controller with a different configuration?
Especially the sleep ranges are even the same.

I almost feel like buying these phones just to pry them apart and put
under a microscope to figure out what these displays actually contain.

Yours,
Linus Walleij
