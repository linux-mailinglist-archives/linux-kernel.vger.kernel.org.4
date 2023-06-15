Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5166F732088
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFOTzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjFOTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:55:01 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAA295A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:55:00 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bd20beffda6so2200978276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686858900; x=1689450900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zarhNLNxJGcgzFm4V/dlUfwEydM2+khl1826v1Ld6wo=;
        b=omzFWI9V+BtaWILreAC2kA65CZu3BhXlKb9bd1vTMVRxwqvTQ86NWOMb8UBr7/+zom
         +k1fUe4ve3JpHGCqQcK9NsZVkImdB/Lo+/njCuQPf32XfaaZL9CZBdhjOsBBUZSZqcae
         SmQGh+G7KR6p70maYmVRYPCLLZ04fZaf0q6LeoWmhLvvRZyGg2Wqz1Chrg2E1ZaR+1tR
         gHcjBvMlW4iE9ItnxoZRvMeeOIbZVsIENG7e3JHw8Wz6k7d0NwrafuHHwwoYFP6Wkv6+
         hwyJMjWgJqY/3Ux+26E2hWY3M57/nh2n7O2MenAcHc6+q88IETUCRGyLS7ahtXvbnf+L
         q7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686858900; x=1689450900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zarhNLNxJGcgzFm4V/dlUfwEydM2+khl1826v1Ld6wo=;
        b=SAlufzdAWUdy1Nl3ezqfSd4lMZRfv6TxG6hMH2IOwn4OCadPGngX/nkNeH/rdP7Lup
         glTBZSG6eqWPxPH9Z7w2as71hercpKE/suTfbsP7pbjBQQE9kSs0JYtHymoo316HHE5t
         jmeNEPp1dDxcYy++mOdyPJ6tg6mAZbCSSZoqyR/vJIN+ZFX/rLaAkBnLHHoRcIX+dmfH
         faGWof0wOYPlxTK/VCZgoyMxxKSWGbmnEjCbT3qyxpWnSxZiVx+VELuLKh/clklLBJDi
         o1pftUdWsexDiHmBqagezUPd2hozsZPGCqhkSGFnUvl1MBsFw01Wxub6MJTQOqn5pW7R
         4wow==
X-Gm-Message-State: AC+VfDz00gqhypxYHoMZ/zcyrfMRmTrVTdU5t7HwcxoFPpcNYcTfemlx
        wM/1OTkOyHD1/l6y5EU55IlsmQmd+FJ6ZxjqHHVmIg==
X-Google-Smtp-Source: ACHHUZ6Yx/mZVW7nno+7MO/Qy94W3ta+kHrxF19zn9d6b4qJpSAQFM1D+WoaDzO9Q8B9HSCJAgBJFmvbmrbEGNKRsaE=
X-Received: by 2002:a25:cc86:0:b0:bca:9c66:e53b with SMTP id
 l128-20020a25cc86000000b00bca9c66e53bmr6280244ybf.14.1686858899754; Thu, 15
 Jun 2023 12:54:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230607151127.1542024-1-pavacic.p@gmail.com> <20230607151127.1542024-4-pavacic.p@gmail.com>
In-Reply-To: <20230607151127.1542024-4-pavacic.p@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 21:54:48 +0200
Message-ID: <CACRpkdbrEA54qmfTKSsFRG9ZS4u8hM6P5TXtOjRAiW+TD_v-fQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/panel-fannal-c3004: Add fannal c3004 DSI panel
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paulo,

thanks for your patch!

Overall this looks very good.

I doubt that the display controller is actually by Fannal, but I guess
you tried to find out? We usually try to identify the underlying display
controller so the driver can be named after it and reused for more
display panels.

Some minor questions/nitpicks below.

On Wed, Jun 7, 2023 at 5:11=E2=80=AFPM Paulo Pavacic <pavacic.p@gmail.com> =
wrote:

> +static int fannal_panel_enable(struct drm_panel *panel)
> +{
> +       struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(panel->dev);
> +
> +       mipi_dsi_generic_write_seq(dsi, 0xFF, 0x77, 0x01, 0x00, 0x00, 0x1=
3);
> +       mipi_dsi_generic_write_seq(dsi, 0xEF, 0x08);

Why is everything using mipi_dsi_generic_write_seq() instead of
mipi_dsi_dcs_write_seq()?

Especially here, because 0x11 is certainly a command:

> +       mipi_dsi_generic_write_seq(dsi, 0x11); //MIPI_DCS_EXIT_SLEEP_MODE

Instead use:

    ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
    if (ret)
            return ret;


> +       mipi_dsi_generic_write_seq(dsi, 0x29); //MIPI_DCS_SET_DISPLAY_ON

Instead use:

    ret =3D mipi_dsi_dcs_set_display_on(dsi);
    if (ret)
            return ret;

Yours,
Linus Walleij
