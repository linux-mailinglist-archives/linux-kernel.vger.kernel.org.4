Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DD733FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234425AbjFQJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjFQJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:08:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AE5213C
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:08:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-bdd069e96b5so1558736276.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686992901; x=1689584901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37w9RvtsspKKQvjpNoOQ2181ixYDa9kxnvKdFl+QGaE=;
        b=SdVp3/F/IFK4rHxuA6ZPm5ESvkKRiXqgzuMKRc+LS5JyOQlxtOfYvwSEghQBi8ncaS
         FSj5CIXbphSTBappIe+fSJo8as0k1n0KxOcg7mOE8S4NONpAoAhPFglbOBcau7Y6cJUz
         kWkpk1XjEWFg/vmi1TRB5f5Kt0cTsY79nrvV+6bQeiSUg0YAIr6SBhEuas5dNSqzklHG
         vU38c/ZhYy2J0wVoE45qIemAxQ8vs95jDiSMsgwcBxkT3gz502KDRmWsaWcsaKNyYh+E
         RHLXUIsJw1yxygwtSnlPPofrbMqMElyIiwV10S3SJ0+JQyhRjPW50Zp3pPjns33l6zSy
         uFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686992901; x=1689584901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37w9RvtsspKKQvjpNoOQ2181ixYDa9kxnvKdFl+QGaE=;
        b=bwFgXQdDNPuO9POqj9FL3wspTGrkf1qrykSlCZU0Z5RWrtjpEXl6kjrAFIbsD+4KhU
         hznMMI21kaXua0N5prw0DmfNTJyXaZmk7JLh0N5aHw0xpoKZryZnG/yzcaSRna21k8eu
         i3D6TNjuNt0yrp6cd/9bsN6evVfsSZTz9GiB1plbguBjEXepcu1SqsDDIyQpPsVLgtlT
         y2jCTvSPPY8gngHJxrJ1p76Eo9/mEnxHaY+dhyCJoR+o8eQaE1SMhxMHkvbGQ9nf0Z4Y
         ZuEmHu1sLVBOwdR8eMKYkQWBpImiNTLPLOpGXZ+eLnq5CfhI3gZaLd+pj5QG+de9GcFq
         rgdg==
X-Gm-Message-State: AC+VfDwLHhvsOdI6WjndF123hRq+QtQf54qusjbjr1k8w9j0RiVo2huU
        Xa4qZocPKkdsFdq2T0CtxEDwGu/cd+jYrEN+JwQZSm0F4dv4vCMa
X-Google-Smtp-Source: ACHHUZ5EEpIHhlrSGrwjFq2jgi8s4t5Onr0qinzP12iMzkKe+3SnEWkn2D/viO9B3Y0kTsqWdJcyyP7nP26sDfYvzJQ=
X-Received: by 2002:a05:6902:510:b0:bb3:8f5d:23f9 with SMTP id
 x16-20020a056902051000b00bb38f5d23f9mr1255390ybs.22.1686992901356; Sat, 17
 Jun 2023 02:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230616135313.76338-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 17 Jun 2023 11:08:10 +0200
Message-ID: <CACRpkdbPEvVvaehB521gdjkkzh+wFnFxsCNm36PD-hnTb1Na_w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Drop unused domain_ops memeber of GPIO
 IRQ chip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
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

On Fri, Jun 16, 2023 at 3:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> It seems there is no driver that requires custom IRQ chip
> domain options. Drop the member and respective code.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(...)
> -               /* Some drivers provide custom irqdomain ops */
>                 gc->irq.domain =3D irq_domain_create_simple(fwnode,
>                         gc->ngpio,
>                         gc->irq.first,
> -                       gc->irq.domain_ops ?: &gpiochip_domain_ops,
> +                       &gpiochip_domain_ops,

We better run this by Marc Zyngier, and Thierry who introduced it.

But some grepping and looking seems to conclude you are righ!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
