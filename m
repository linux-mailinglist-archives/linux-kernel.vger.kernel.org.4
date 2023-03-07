Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3186AF8FC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCGWhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbjCGWhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:37:13 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3A4B1EDE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:36:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id e194so13000304ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678228506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyb0rhnuV7oh3CLMKShl+J+wi5X4qG87kgpZAdrNvLo=;
        b=j2eJjWOeqSZqBlt1Ya6O396ehMlnu7bun7PacqdauNEkRClrB8l8duBGCZVtvxoS+N
         RpjWcYF+kLNzDgxJiKJH7/eQWNNMu5Vh3/AyEuy+++8brALwbb1CfyaXBvFZuPuDv/46
         e7+wyKEt41FixpsMi/mmgIACA2+6+MNGOfGRpBzHOw2DT2Ln98zlicoDcfiHFjxgnhGV
         0P+kxVAvbAVCjRaiKILKxjcQHTzFKgb+OIKfWKyCwN8BMUWIoyPUA7NLEM03KmA+VxnO
         fo47X0aDdRhCRXOv4KCWvSCqWHyMubIrLBjt0T0IvaMMmMlIiL4QmpeWKpeUFImkc6o+
         OR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yyb0rhnuV7oh3CLMKShl+J+wi5X4qG87kgpZAdrNvLo=;
        b=iZAQyR1ZvRVENYg2oEmGVpc8sVvPBmvKWsZPEhMaodPlflE3p2P78KXJvs8fywkbw/
         jrHw3/MlGsgFFM7+NUtHb4yzZJ0Pi9ydxgjTp+vZrRZD4r3JmFH5z45eykgMN0pq3PbR
         MMM3t31/Rvw/8mi58rfUZbjsJLgMjhZhvYwtlsnpvoaydtdxZ9gtH4n5dsBxN67KsFgv
         dUV/Uyt3GFTSd+qYuTdh+jFrHVP/H87CF3jJeDTDA6q84eMtcNHqThoNr023/iS0D78J
         1nPgY9s3ugmyb+y9TNAf3VCzb8SHGF/IxvUk224jZqP1STZ13xoYEs9JHPSx3McAhMlG
         EYjQ==
X-Gm-Message-State: AO0yUKX+oVQe9wSANmgXkqgc+pmMXoNQeLJod8CdMqybdEXqE5FGkSwu
        qS2UZrUqHYezIjToorWF/Maz552sIvLJeYMjekysVg==
X-Google-Smtp-Source: AK7set+qjWLKdRokY0PE/Ly5XTIkGJNsmaouJx7H7eHeFmFlb5PHA7OryQsrT4nZo7WdvCLp9Fsxze+058KE7Clp5w4=
X-Received: by 2002:a05:6902:c3:b0:9f1:6c48:f95f with SMTP id
 i3-20020a05690200c300b009f16c48f95fmr7774360ybs.5.1678228506476; Tue, 07 Mar
 2023 14:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20230220121258.10727-1-lujianhua000@gmail.com> <20230220121258.10727-2-lujianhua000@gmail.com>
In-Reply-To: <20230220121258.10727-2-lujianhua000@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 23:34:55 +0100
Message-ID: <CACRpkdbZCZiMM_qeqMd9=txVvPVHEzM4szOnPR-gCYdiXW_9eA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/panel: Add driver for Novatek NT36523
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianhua,

thanks for your patch!

It appears Konrad is working on a very similar driver, so I suggest merging
them into one Novatek NT36523 driver.

Possibly we can fix this up first and then add Konrads Lenovo-panel with
a patch on top.

On Mon, Feb 20, 2023 at 1:13=E2=80=AFPM Jianhua Lu <lujianhua000@gmail.com>=
 wrote:

> Add a driver for panels using the Novatek NT36523 display driver IC.
>
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>

(...)

I like how you abstract the panel with init commands in the panel info.

> +enum dsi_cmd_type {
> +       INIT_DCS_CMD,
> +       DELAY_CMD,
> +};
> +
> +struct panel_init_cmd {
> +       enum dsi_cmd_type type;
> +       size_t len;
> +       const char *data;
> +};
> +
> +#define _INIT_DCS_CMD(...) { \
> +       .type =3D INIT_DCS_CMD, \
> +       .len =3D sizeof((char[]){__VA_ARGS__}), \
> +       .data =3D (char[]){__VA_ARGS__} }
> +
> +#define _INIT_DELAY_CMD(...) { \
> +       .type =3D DELAY_CMD,\
> +       .len =3D sizeof((char[]){__VA_ARGS__}), \
> +       .data =3D (char[]){__VA_ARGS__} }

I have seen this type of reinvented wheels a few times now. Don't do this.

Look into other recently merged drivers and look how they do it, for exampl=
e
drivers/gpu/drm/panel/panel-himax-hx8394.c

For example:

- Use mipi_dsi_dcs_write_seq()

- If the delay is just used at one point in the sequence, do not invent
  a command language like above for it, open code the delay instead

- Try to decode as much magic as possible, if you look in Konrads
  driver you clearly see some standard MIPI commands, I bet you have
  some too.

- Maybe use callbacks to send sequences instead of tables, like in
  the himax driver?

Other than that it seems like something that could also handle the Lenovo
display, or the other way around, I don't know which driver is the best
starting point, but this one has the right Novatek name at least.

Yours,
Linus Walleij
