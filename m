Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346787331DD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344750AbjFPNHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjFPNHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:07:52 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DA426B8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:07:51 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-be49e41a3d6so402026276.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 06:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686920871; x=1689512871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kyLPSg7lW2woOKm7c3P9mBg/EYKVo5C6C3A7VsM0oE=;
        b=X0YElBsxjc5tOW2JHzbsJ/cX95ZvII2wewHODfJ3nVk4A6FxM3TYOipyutD1uwwa9O
         gNzGvHOBdyPeiufgXx2WQgWAsI7a7BzOH8LCGsU9snXtE79K31IlNwWBdtNCd8Gamkib
         5CNOjAj1/me0vijRzAr7rey5jckmMSSNE9ksJqJG0HhYWQB4f4m69Ai/MOtkRIVzdrPu
         BQlC25cFQLzz43ljwXfexQJOjsHZm4qmYNcEVgu2JImEZ/fJ5y/7iGeN8+ofzNXIkoUf
         hnc1VQcatmi73FxopUvxpUjvoduIaR7EIJwJbYRviStEiKBRR3E9UWQZUR48LPW3m5Bn
         jXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686920871; x=1689512871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kyLPSg7lW2woOKm7c3P9mBg/EYKVo5C6C3A7VsM0oE=;
        b=gFEqQKmORVBmI5cpojazCjHspsc0erSXJMs0vQtih1UeO5XSWia8jby+9PvIOJFcnB
         3h+PN6ttikUCHeh6CmaGGnOeSWiCmU8jpdA5+EPbokdnLRKgEIyHLrM+b4SEWpMthwi4
         OzawqzD9b4R/4hPnOHU0vWmQR9rkTDNGhh7kWn3Vm8FYKUbF8FthtaIzK/NT/Rl1ms6A
         R8YcLE1e2dHnomcSQFtK7ouU73Al4xd7/ejC/+sMOIJGQoel1QFxx7DFJKrvTOw4lDCN
         sA5BVbY3KXvk5OgCsMJ9kH04/tDQh6V9rppPG/11hNANFZJkdreRRsgjQ8feBruwFgmY
         2pZQ==
X-Gm-Message-State: AC+VfDysSqtNnnLe8XT1O3IKKKH2XD0qNtBBLSk0L67/GNR40WheqrFE
        nY7Vj+lsd+V3/yBb4MSF+PXDRyL4aJsegK1tVBmI7A==
X-Google-Smtp-Source: ACHHUZ4UNXZmzz9+z8ONXfEmulc4fpjKnnRYyxP6hWCr/X3HKLKSe/AXXDCS4gqZ5n4gqF5eKvHKJQuaabFDaKOhaJY=
X-Received: by 2002:a25:2e51:0:b0:bac:42d1:3ca0 with SMTP id
 b17-20020a252e51000000b00bac42d13ca0mr1299896ybn.48.1686920871103; Fri, 16
 Jun 2023 06:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
In-Reply-To: <20230616-fixes-gpiolib-irq-domain-v1-1-27fe870db961@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 16 Jun 2023 15:07:39 +0200
Message-ID: <CACRpkdbkzAmwgzfL=dkHCynPFvYP-5Fcp4qQiBfbZ4649Ntn+A@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Fix irq_domain resource tracking for gpiochip_irqchip_add_domain()
To:     Michael Walle <mwalle@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiawen Wu <jiawenwu@trustnetic.com>
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

On Fri, Jun 16, 2023 at 9:30=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:

> Up until commit 6a45b0e2589f ("gpiolib: Introduce
> gpiochip_irqchip_add_domain()") all irq_domains were allocated
> by gpiolib itself and thus gpiolib also takes care of freeing it.
>
> With gpiochip_irqchip_add_domain() a user of gpiolib can associate an
> irq_domain with the gpio_chip. This irq_domain is not managed by
> gpiolib and therefore must not be freed by gpiolib.
>
> Fixes: 6a45b0e2589f ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
> Reported-by: Jiawen Wu <jiawenwu@trustnetic.com>
> Signed-off-by: Michael Walle <mwalle@kernel.org>

Oh right.

I guess we can't devres it some way...
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
