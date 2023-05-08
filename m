Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319706FB905
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEHUzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjEHUzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:55:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D686BD
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:54:59 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-55a8019379fso46093207b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 13:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683579297; x=1686171297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebgkfCiodiKcun60kKBUwZij72grfP4UOmjlc+G6i8I=;
        b=k0YYa/u76d7Ieqtnsvy/Saa1HPB4iaH1dWzUdUuvpcLGfYYlTzbXgK21e8GZZqfZ7i
         YE+F+MB9zyXtiARKsPNIiY9f3Yvt1HVWAVLTf6t6yhR5GOODuvZu3luqlcRMbLYDDKCC
         QpsnZEqepGgE18Mu6mcHcKTrkO/b+Iy6POYKLn7fB3mza3FUb79uQ3OyDUmYLPLGyrU9
         yFfOpdYmElLihnmMJxGsSFbxtufg1vlUdp39zLnUMxZA1zevF+Nwgewq67DDlHNDL6rq
         W1tR4tE5bhj81NA+/5pweLJQAC6rL4aL5pDyC8sWhOEqEyQUW98xARAg6p4xXnZCWIp9
         mDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579297; x=1686171297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebgkfCiodiKcun60kKBUwZij72grfP4UOmjlc+G6i8I=;
        b=B4432vnBggNvoVWbNOPpRgHa6oNLxHae5SWH6sQP8CSASuUvU3dOoGmpByDHebRVWM
         h4n/WDrXmDSlhElF0tqMQ9Z/iHYocqhORpa4T6LmRjUkC97t2zh+iMoS1OamyJWQDks8
         t//dg1I7Gr4kIe/XozNGhUllaZtnffyjG4pufhKYltR78G7nyo1iLwIoCf1YFMZ6GatF
         GT5t/jQpKzlJE6IpDd20AdJBEDqZSVIqzicGr9HKILcEJ3T09g6mM9F8OAq3/dqbrMNq
         KbMPOUqlyVIU6YJsTnlPEUp0jG5qiUsrEBZ0oE3gXAHrl27bZeuTXe2MU6fnymHJIN2m
         yyHw==
X-Gm-Message-State: AC+VfDyKeFHZm6xEEtajfYu28bRN2XnEPja/9YaghDEp8rhOq3XikF1p
        6DweCz5UOehTHhbLaeoE+0vzaWS9Z/K/rswowlvgNA==
X-Google-Smtp-Source: ACHHUZ61Co9c2vfFGtG+tpLFRQ4UHj1QYb0g4ygOt03JqCB/lCRGyKCa19BWVLj8Nu27zbXZko10yxza9yB0luPTCMc=
X-Received: by 2002:a25:54b:0:b0:b99:f279:10dc with SMTP id
 72-20020a25054b000000b00b99f27910dcmr12394809ybf.28.1683579297026; Mon, 08
 May 2023 13:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org> <ZFkSMBhw5UaWdpsM@surfacebook>
In-Reply-To: <ZFkSMBhw5UaWdpsM@surfacebook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 22:54:45 +0200
Message-ID: <CACRpkda8zbR3CnRp5w=NvRder1rYTs+DYZN0QyhneDwR1E_qUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
To:     andy.shevchenko@gmail.com
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 5:16=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:
> Fri, May 05, 2023 at 01:16:55PM +0200, Linus Walleij kirjoitti:

> > The Nokia 770 is using GPIOs from the global numberspace on the
> > CBUS node to pass down to the LCD controller. This regresses when we
> > let the OMAP GPIO driver use dynamic GPIO base.
(...)

> >  #include <linux/gpio.h>
>
> Do we need it after this patch?

Yes, but it is finally removed in patch 3/3!

Fixed the rest, thanks!

Yours,
Linus Walleij
