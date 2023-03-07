Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B296AF870
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjCGWT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCGWTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:19:24 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85241A0299
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:18:39 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-53916ab0c6bso271616957b3.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678227517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3DiUR/GgkhgxD2cosHQ9gtTM4EkXnRYU9WOulYy+fI=;
        b=uXQ6pTKn/U2liBv6xoaR1ke+Sh9LHgFqCMu07bxAsguGWrsAegY7rzgPRxpIpb4qk6
         CeaBMbGxoMqpib1QGU73lov1dIR23psWLel2MCzUxJaZzgBIdTc0lfm8f3qzBa5tXEha
         Ly643bvs3Uvtalj9HSi95RwxbLGj093nxULaG4RcPU14sWRsrl6O8AotxZse7oyej7JH
         QgbrLNWKIXF9+RbNS4CYW0E9U5GV/QysiawP03KpoWHaeMvdLjPAZCNCVYrc2g4RGEJm
         t5oVl86KKmdHuwGtV0voKm148Bah5/B8uANQH8WPfsqr/nQD3Bym6YK3CYL5SSIPMD9D
         dOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3DiUR/GgkhgxD2cosHQ9gtTM4EkXnRYU9WOulYy+fI=;
        b=NlKnoUNZIvzkgSKR74nelXEecv3t9ZRwiTdMiWKQIJHIt4vyihYFoGlZDfsZ3rr9fE
         EdhfjauUko3TDN3gqECJRK4oNBVFOLdA2d1O7OX9bwOcRylcite7DlYBDeK5qut2rUTk
         C/GDSuYxxii8QJmB5kr56LZ3Z6uRdvyDZ4hNkFnYb0ADeVvlHl1iPnadvBaOIsPiSWXN
         gytKDMcpuZaGAH7qUDUPZBCs4goRWzLBOcOpxc0BOL0b8bDWVjkpPKjuKFPJX+89ZMQ/
         R9WA4zX8mw0UBUmndfM3SF+xUI6aRnvC7/K0TFUy9nLUmyJK5XOrGWB4I/tVrOtBguky
         FQcg==
X-Gm-Message-State: AO0yUKWijBMEN8znC3fFVTwZtSP987kJIYbeuYhpi0yB1arhGKvDpwSY
        RDiilQfMG+hJgZNJF4Q0SmxYdyIdvC56+QHEY9itAQ==
X-Google-Smtp-Source: AK7set/SYnYyFvNE6h8dqT6SwfI0vZ82td/XxR+z0aS3Qpc3Vvvm8bzcKrJkYNLWOiue2Fju36euDI5bybr7bBVpeHE=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr9656902ywh.10.1678227516874; Tue, 07
 Mar 2023 14:18:36 -0800 (PST)
MIME-Version: 1.0
References: <20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org> <20230217-topic-lenovo-panel-v2-2-2e2c64729330@linaro.org>
In-Reply-To: <20230217-topic-lenovo-panel-v2-2-2e2c64729330@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Mar 2023 23:18:25 +0100
Message-ID: <CACRpkdZ8RvFrieWXhx1WGO71M10H0-b3WbDXM7=xnngX7uWT6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gpu/drm/panel: Add Lenovo NT36523W BOE panel
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:26=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro.=
org> wrote:

> Introduce support for the BOE panel with a NT36523W touch/driver IC
> found on some Lenovo Tab P11 devices. It's a 2000x1200, 24bit RGB
> MIPI DSI panel with integrated DCS-controlled backlight (that expects
> big-endian communication).
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

I will think this is some variant of the Novatek NT36523 display
controller packaged up with Lenovo electronics until proven how
wrong I am.

I will listen to reason if it can be demonstrated that NT36523 and
NT36523W are considerably different and need very different
drivers, but I seriously doubt it. (For reasons see below.)

>  drivers/gpu/drm/panel/panel-lenovo-nt36523w-boe.c | 747 ++++++++++++++++=
++++++

We usually share code with different displays using the
same display controller, so panel-novatek-nt36523.c should
be used as name.

> +config DRM_PANEL_LENOVO_NT36523W_BOE
> +       tristate "Lenovo NT36523W BOE panel"

Name it after the display controller like the other examples
in the Kconfig, DRM_PANEL_NOVATEK_NT36523

> +       mipi_dsi_dcs_write_seq(dsi, 0xff, 0x20);
> +       mipi_dsi_dcs_write_seq(dsi, 0xfb, 0x01);
> +       mipi_dsi_dcs_write_seq(dsi, 0x05, 0xd9);
> +       mipi_dsi_dcs_write_seq(dsi, 0x07, 0x78);
> +       mipi_dsi_dcs_write_seq(dsi, 0x08, 0x5a);
> +       mipi_dsi_dcs_write_seq(dsi, 0x0d, 0x63);
> +       mipi_dsi_dcs_write_seq(dsi, 0x0e, 0x91);
> +       mipi_dsi_dcs_write_seq(dsi, 0x0f, 0x73);
> +       mipi_dsi_dcs_write_seq(dsi, 0x95, 0xeb);
> +       mipi_dsi_dcs_write_seq(dsi, 0x96, 0xeb);
> +       mipi_dsi_dcs_write_seq(dsi, MIPI_DCS_SET_PARTIAL_ROWS, 0x11);

I think it looks very similar to Jianhua:s driver:
https://lore.kernel.org/lkml/20230220121258.10727-1-lujianhua000@gmail.com/=
T/

Can't you just add this special magic sequence into
that driver instead?

Would it help if we merge Jianhua's driver first so you can patch on
top of it?

Yours,
Linus Walleij
