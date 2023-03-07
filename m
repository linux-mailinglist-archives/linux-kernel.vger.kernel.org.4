Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5C16AD5D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 04:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCGDp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 22:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCGDpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 22:45:55 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7B3250C;
        Mon,  6 Mar 2023 19:45:54 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id g3so47340480eda.1;
        Mon, 06 Mar 2023 19:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678160753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WFYzmYMI13NGyI9RVWU+B5u5ZNy5SSZeg3RTeQ3FS4=;
        b=RbGZd472V0mVea6Q/CdYoaWjP6UZwTd+MXhE38lo2a4xGqBjdGJBk/FxdFXeribDDi
         3zDaZmVB7PU2pwW/kHOM2RuQFCkUTuLt9OIRjqHmoVIbrxY9+NlxD9PjMsk67Llj5L2o
         qgQuRhr/fNfRypyEir8uyuKCNINxA71JFHyfxAFRal+zMnJEIiUOikmzR3oiqcefc76m
         X7SBfQQVCJw0CCpMWhLPPvme8sPIlbztqy8VqrwdmrBP3Nv98hrK1MbB3fdd0Nu25N0L
         Gkwozz8oRk1N2ZPFA6lPCPqMr4gCVCNbycQCMyu2rhd+yDXCKkRmEEbdGgKtCeWaEkX+
         3LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678160753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WFYzmYMI13NGyI9RVWU+B5u5ZNy5SSZeg3RTeQ3FS4=;
        b=xiuhe3XH7IZfxjGh4kuB6Pk6pLXdiPU7mqeaD0miF1fmN/DQowENxP8VP9RcK2+KpH
         2/OgR51dlbgoxfEXc37mNsqHD0H+NlQMPt/Yc/fxOVFRsCL5+GjKepNrumy1h3jXceM+
         fVIBjlu4id9QqcJcp7/vSLWU1CNjDB858/+6IDv45AfixtZawYsU3Kdtl7RN+aRaW8n9
         aa8CIesNevcaO2aZQKRZC2Hs94xqKir0Xqy+PzCVp2kb1q3LtGMzWz2ACRIkBelIBvf1
         7MvBM/j/WYYN09k+ulvlLBQloBLVMB7rejTyx40rQFxdQUqzQxcJ1DXPBhKdWbJI12ls
         hhYQ==
X-Gm-Message-State: AO0yUKXGydHu/uvutjoLOL1WMNbjjsVfOopQDR2cbfhtTHgZdKxrbQiT
        wLNaKmKjnxEx2PcrVSKs6OkMG1D2KPQmzhb7tek=
X-Google-Smtp-Source: AK7set/bDf7jZs8BadF17KUJmFRr2SpATO3txBELeojm6hKxTx9bH/strG41JGbMxurM5Eq8vfjECTwY7Abzb+ve+gg=
X-Received: by 2002:a50:d581:0:b0:4ab:4b85:a6a8 with SMTP id
 v1-20020a50d581000000b004ab4b85a6a8mr7092721edi.4.1678160753041; Mon, 06 Mar
 2023 19:45:53 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-3-keguang.zhang@gmail.com> <CAMRc=Me3yVwQm8=CmUVM2gyYnFxntW47-OOPdmq1TzXTJB5ETg@mail.gmail.com>
In-Reply-To: <CAMRc=Me3yVwQm8=CmUVM2gyYnFxntW47-OOPdmq1TzXTJB5ETg@mail.gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Tue, 7 Mar 2023 11:45:36 +0800
Message-ID: <CAJhJPsX1q6PGSb+eoCSdCC2_vDtbaShLLzEbuNOqD_Jzd8Ozdw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: loongson1: Use readl() & writel()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 6, 2023 at 5:30=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
> >
> > This patch replace __raw_readl() & __raw_writel() with readl() & writel=
().
> >
>
> Please say WHY you're doing this.
>
readl & writel contain memory barriers which can guarantee access order.

> Bart
>
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> > V1 -> V2: Split this change to a separate patch
> > ---
> >  drivers/gpio/gpio-loongson1.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson=
1.c
> > index 8862c9ea0d41..b6c11caa3ade 100644
> > --- a/drivers/gpio/gpio-loongson1.c
> > +++ b/drivers/gpio/gpio-loongson1.c
> > @@ -23,8 +23,8 @@ static int ls1x_gpio_request(struct gpio_chip *gc, un=
signed int offset)
> >         unsigned long flags;
> >
> >         raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> > -       __raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | BIT(offset=
),
> > -                    gpio_reg_base + GPIO_CFG);
> > +       writel(readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
> > +              gpio_reg_base + GPIO_CFG);
> >         raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> >
> >         return 0;
> > @@ -35,8 +35,8 @@ static void ls1x_gpio_free(struct gpio_chip *gc, unsi=
gned int offset)
> >         unsigned long flags;
> >
> >         raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> > -       __raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~BIT(offse=
t),
> > -                    gpio_reg_base + GPIO_CFG);
> > +       writel(readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
> > +              gpio_reg_base + GPIO_CFG);
> >         raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> >  }
> >
> > --
> > 2.34.1
> >



--
Best regards,

Kelvin Cheung
