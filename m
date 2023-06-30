Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B12743D19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjF3N6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjF3N6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:58:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761F92118;
        Fri, 30 Jun 2023 06:58:30 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f973035d60so3145381e87.3;
        Fri, 30 Jun 2023 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688133509; x=1690725509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xr+BE0ly7fBWXnqMsQwKwm70dkU7KbNm8LkIP3WhyM=;
        b=DSnREMF0t6Qc7HldDaPdQWNjEWBUF0ZyO7+NRR3Hs8PS2c1wPLX1eQt3TDJbT9P8za
         F5m24a0iEUnzZCkjef1CKSsb2xbHA1WMlF4Tff745ZVVy8ZYFKgFpJbmKxy1B9fOTVvr
         mHaKpIB9kmXj9r3cL/+3CxfnG7ULRhkLmw2F3VIK9wmAxzrxaLjZemAoVzDIyywttHTM
         uD41WlyfLtla6iyh/DmSKJF28vYz7ExSyfN5KfhGDvg6icsJ7V/aJ4cEmvgyxFje1vrS
         PD4ArxjMxCeaEHFudtDZIJFe7vVv4MIj0tP7L7yMkwI4j/tcYwX1wqX20JmYnGrHTS2R
         2gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688133509; x=1690725509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xr+BE0ly7fBWXnqMsQwKwm70dkU7KbNm8LkIP3WhyM=;
        b=ATLkdSFP7yeotWcpHA5hNRYMPYslR/bC8inT0Ph81VybDa4flR/IytRK5WXinrTlSu
         qZ7gurXZBaUlcaGVK7GtV0uzNIGGoy1yxMhtHrPcKLovYIWhPx7bA0vTXIDa0wDYPsx9
         +38lRcpFpcXUzHB54CAuWcvaL3PeXNqFToEu+Tf0V1XJ0YULqEgrHJ9mTleDUTip6f3e
         rYcFjDuHQf0EbgzP/t/yT7Bni54xXCkEd5iUW9zIIhMJBjyPhVlrvp6niLSG9h8sm2Rg
         pcHxLYLtsD+5GfsjXC6L8+cJFbPKSEdYKc+LrAQz3DZzVFvPLjBYJ6ivXbPY9qmxZR5L
         7A7Q==
X-Gm-Message-State: ABy/qLb1bibASA2IIlRIle62F4glL8gzatdo2ZMqeYYpdg9gjj5BVRZA
        Icx8vnMB11+yIB2EtxH1nURFgd+1wPIlw/5/jyi4HNUOG8Y39Q==
X-Google-Smtp-Source: APBJJlErxfH7dl9dMd59h8X+td0bzEYk+tOW/ORTtUeuHdVs108TJTdPx/yccjEiXV37/2wbet3pMQvjmdD8LKPYXAA=
X-Received: by 2002:a05:6512:285:b0:4fb:82d8:994f with SMTP id
 j5-20020a056512028500b004fb82d8994fmr2224306lfp.33.1688133508366; Fri, 30 Jun
 2023 06:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230621174943.30302-1-andriy.shevchenko@linux.intel.com>
 <20230621174943.30302-5-andriy.shevchenko@linux.intel.com> <CACRpkdbOoDKZRF+8cys6FAf4Yy=v7UokPAmUp9mSkVnbqsH2tw@mail.gmail.com>
In-Reply-To: <CACRpkdbOoDKZRF+8cys6FAf4Yy=v7UokPAmUp9mSkVnbqsH2tw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jun 2023 16:57:52 +0300
Message-ID: <CAHp75VdDJ2Eeur3oG01_1s6iS9aZXBzaoDfk+s6tEgEdqbdTow@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] gpiolib: Replace open coded gpiochip_irqchip_add_allocated_domain()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 2:52=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Wed, Jun 21, 2023 at 7:49=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>
> > Replace open coded variant of gpiochip_irqchip_add_allocated_domain()
> > in gpiochip_add_irqchip().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> and this concludes patches 4,5 very nicely as well.

Yep!

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you for the review!

While at it, I would like to ask on ->to_irq() callback. IIUC
assigning it with an IRQ chip makes a dead code in the driver. Am I
correct? If not, can somebody shed some light on how the RT5677
driver, for example, works with GPIO IRQ?


--=20
With Best Regards,
Andy Shevchenko
