Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4D2710E04
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbjEYOIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbjEYOIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:08:04 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD93E5B
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:07:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30a4ebbda56so2127522f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 07:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685023661; x=1687615661;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tF/YLiXt+Wz4pi2y/9855PYbDqln/umnaCm1hvZD/nY=;
        b=FshkKSklE4mhKDuI6cA8Jo6KkrVTc+5WF31v25PXSvMB1rfjab0/nMv74UstUBhCfU
         5MtIhSo6Xux7Ezw1l2v1Y2BPsxH+4Zt/6PrKAFVHHQ+3XW8SGHgFxBwo6YZTJP0zCTHr
         NLdeggUhG/BB9v0f0G9+FXR7gaqibHnL22DUBB7yrt5lOkfaYu5Smu6x3RITL0I7OLlr
         tOFfnrhOtqGJvlRjuIuxAhOv1OJ+WR/Ce5iIHQHmXrQbfCjHCqp+5gFvHc7i9IiIh+hM
         Uev0MHBAymDNkVZy42ErzwArl0KTFA37qHyPxU9N81IgDPCsnn6hAI3U1QoJNldvDJo/
         TGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685023661; x=1687615661;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tF/YLiXt+Wz4pi2y/9855PYbDqln/umnaCm1hvZD/nY=;
        b=elA1gqNPvI5nSyJkMH44uCnyqruTKI17ytt4et/e/3SILR1oAUYbSa+e1hTyAAMoz4
         ibs/rnpCICqkI8NSV4O6blC/aGY56qr1++7v1SoVsO73QWAoK+jYIrgxkk460XPw5qH1
         jxQlxku0efQ+sl2j/Mr88M6+E9Mrg98NnrG0oKecSwSszBrIeIL4WzpEqwRrLB2FLqxk
         jQO5HcuGM+0uLaT3rC80FPXVfBq6ER2L4njhcEoKfshqn3pERnET/kqP7k3sCqEwbVB7
         KS/B9arXGAUU4rNVKG/r5opthfy2XvMdJZlq0MaTs3kciaQsqVygdGP0n4xPc+ctnxYA
         TjKQ==
X-Gm-Message-State: AC+VfDxN6iTawNZ2HueTMLdDojA6vup87n9yg637nHbs/+9qSSzOBz3h
        4ykfiMtjqrHaJsa5r9RXigk9aA==
X-Google-Smtp-Source: ACHHUZ4ixPjz/IrEBqNV7Mpn53Q4wlZCzaDBAs9Ux+XQ1aLD12RR5fr2BMAIeKn7BLlXdlrzhMvtcQ==
X-Received: by 2002:a5d:58d4:0:b0:309:5029:b075 with SMTP id o20-20020a5d58d4000000b003095029b075mr2584321wrf.13.1685023660991;
        Thu, 25 May 2023 07:07:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:ed59:2d5:ca3d:ee5c])
        by smtp.gmail.com with ESMTPSA id e7-20020a056000194700b00307bc4e39e5sm1892289wry.117.2023.05.25.07.07.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 07:07:40 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 25 May 2023 16:07:39 +0200
Message-Id: <CSVF1AQBGQU0.1V5KJP08TCKLT@burritosblues>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <jpanis@baylibre.com>, <jneanne@baylibre.com>,
        <aseketeli@baylibre.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v5 2/3] pinctrl: tps6594: Add driver for TPS6594 pinctrl
 and GPIOs
From:   "Esteban Blanc" <eblanc@baylibre.com>
To:     <andy.shevchenko@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230522163115.2592883-1-eblanc@baylibre.com>
 <20230522163115.2592883-3-eblanc@baylibre.com>
 <ZG0QmjZwvzWbNwA4@surfacebook>
In-Reply-To: <ZG0QmjZwvzWbNwA4@surfacebook>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue May 23, 2023 at 9:14 PM CEST,  wrote:
> Mon, May 22, 2023 at 06:31:14PM +0200, Esteban Blanc kirjoitti:
> > TI TPS6594 PMIC has 11 GPIOs which can be used
> > for different functions.
> >=20
> > This patch adds a pinctrl and GPIO drivers in
> > order to use those functions.
>
> ...
>
> > +#define FUNCTION(n, g, v)                                             =
       \
> > +	{                                                                    =
\
> > +		.pinfunction =3D PINCTRL_PINFUNCTION((n), (g), ARRAY_SIZE(g)), \
> > +		.muxval =3D v,                                                 \
> > +	}
>
> It seems you have used SPACEs before \, can you move to TABs?

Once again clang-format is not doing the right thing. Sur I will fix
this.

> > +// Used to compute register address of GPIO1_CONF to GPIO11_CONF
>
> This is good.
>
> > -#define TPS6594_REG_GPIOX_CONF(gpio_inst)		(0x31 + (gpio_inst))
> > +#define TPS6594_REG_GPIOX_CONF(gpio_inst)	(0x31 + (gpio_inst))
>
> But why this?!

Once again, clang-format... I will fix this.

Thanks for your help.
Best regards,

--=20
Esteban Blanc
BayLibre

