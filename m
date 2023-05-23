Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73A70E3DD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbjEWRbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238083AbjEWRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:31:29 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF38E42
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:31:05 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-56187339d6eso97747997b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684863056; x=1687455056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCJa6a9Ra0P6pgbG0lhDXLRP41OI9WKqV43rqziMdQ8=;
        b=ve1uZ4uzbxpWqFdZAeBe4akBPIsstn7rc643BsI62tzmJXzN0UOAQSh5WDvBcvmdnr
         4pV3C7ImiPfdiT5O8+w4pLLfV7EhcM4tQRCmcnsmHEDN9yPvXiH92r0sJS0HOtJORZDc
         kCN1qKjbRje3eM2FnszyLZoJjdx/8dXklM6BY9pO/hFXprIpQLpMayP7eE5dEd0p0xlq
         lLNWO/y+pbHTNIfNsUWJKOjQM0fcJafjd0pXCAio2y+poeMOyVoD7i+9POdcOKaH1bhK
         KsWqH76g8SZBwXRRDvw8Rt/ohdLjozmCKIJp5KKJAjXAHPN7ladD5eZs2KQqPCj8i8NJ
         Javg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863056; x=1687455056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCJa6a9Ra0P6pgbG0lhDXLRP41OI9WKqV43rqziMdQ8=;
        b=awwHh7Q5LnmDEi3WlKIvPVQR5WNac8KekJ4OFKDsO+rgj1G+cZVVF8xrD2xUF3aBWT
         ce73HQNgrc3zcojIclvPjcKNzzqQPYjArAL6RdCxYSIVlQWsSD0C/vHjGHVZV7ustS54
         ineHeMiHOA0urYldMSV/PpC6Tz2BR+nwhtaUcJGspdZNlMcMHWmYco4e1pzFjWNuuSaM
         2ERlHBiNLA3gACyNzrCgUM4E0rN22DaJ4joUGa0cWQ3YfdhAnATVIxH/BwZqYsU6aJ8y
         37mCoXJLOprYEe71gv1NfYKpXm+fbbwQi5MfinvvMDlIn956fCyfkiVnHQpG1bOFwce3
         K1rA==
X-Gm-Message-State: AC+VfDxOywXnbx5MGr1kZOq0dv694JDqPaPiCsIhDoiyu69NllsCmf/P
        O+cCzgT8L/lzh2burs2uZbkh78/e9noHAY392YjgLg==
X-Google-Smtp-Source: ACHHUZ6IWi/mxhp9wdD5jINZn8HH6CcwIeGxgs86a21+3mAKzVveQ6aQ30xRzyYLqcPze9lXJiK6c1Rghx2XzcBAopw=
X-Received: by 2002:a0d:eb0e:0:b0:55a:72f6:a451 with SMTP id
 u14-20020a0deb0e000000b0055a72f6a451mr12125650ywe.41.1684863056089; Tue, 23
 May 2023 10:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAO9szn03msW6pu37Zws5EaFGL10rjp9ugPdCuDvOPuQRU72gVQ@mail.gmail.com>
In-Reply-To: <CAO9szn03msW6pu37Zws5EaFGL10rjp9ugPdCuDvOPuQRU72gVQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 May 2023 19:30:44 +0200
Message-ID: <CACRpkdYwcFk0k18hxWPyPHukE87eiXSJm0_0+fjSJ=ktD_MEoA@mail.gmail.com>
Subject: Re: drm/panel: Add panel-mipi-dsi-bringup
To:     =?UTF-8?B?UGF1bG8gUGF2YcSNacSH?= <pavacic.p@gmail.com>
Cc:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>, sam@ravnborg.org,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 9:52=E2=80=AFAM Paulo Pava=C4=8Di=C4=87 <pavacic.p@=
gmail.com> wrote:

> From 118419935002e076b44292c832e9b26106f93c89 Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Paulo=3D20Pava=3DC4=3D8Di=3DC4=3D87?=3D <pavacic.p@gmai=
l.com>
> Date: Fri, 12 May 2023 17:38:29 +0200
> Subject: [PATCH] drm/panel: add panel-mipi-dsi-bringup driver
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit

This header is really mangled. I wonder what happened?

> +//macro for writing to DSI
> +#define WRITE_DSI(dsi, seq...)
>            \
> +    {                                                                   =
     \
> +        const u8 d[] =3D { seq };                                       =
   \
> +        int ret =3D mipi_dsi_generic_write(dsi, d, ARRAY_SIZE(d));      =
   \
> +        if (ret < 0) {                                                  =
 \
> +            dev_err(&dsi->dev,                                       \
> +                "Error (%d) occurred while trying to"            \
> +                " write MIPI DSI command: %s (decimal value)\n", \
> +                ret, d);                                         \
> +        }                                                               =
 \
> +    }

This is reinventing
mipi_dsi_generic_write_seq() from <drm/drm_mipi_dsi.h>
so use that instead.

> +static void brup_panel_fannal_c3004_enable_function(struct
> mipi_dsi_device *dsi)

Doesn't look like a good name for a generic function?

> +    WRITE_DSI(dsi, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x13);

Use
mipi_dsi_generic_write_seq()

I suppose these review comments go fo rthe c3004 driver too.

Yours,
Linus Walleij
