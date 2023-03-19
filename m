Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5880F6C0561
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 22:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjCSVSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 17:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjCSVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 17:18:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA5A1A4A9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:18:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id j7so10872341ybg.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679260681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvuN9jR+G4W2pj0hYHw8fCbcQee3vmX+JNF1Jp+xXy4=;
        b=ZvR6jfv7uP8WYBs2D1jZNN/C/OpwONxAwGY8g4y5Y6CCqtOnA+7n//k/XDwV9VBgTa
         XM1qNRq51rD9AuUOu3/TFVWZUsVA80XFrgGOUEvzM2KJWwA9VPihrLwVvSQAxa5k4JNt
         lTEBuZBYSCyL5+W3TcAAfnSixOanlqLP4dVI/9bdXGeS6XQEjHuVZSoZXF2vTFJ/J+lZ
         loH1NcRrBf4DdaCt6DSvW4YDdStWURtLpVJJ2SRk7Vi9AROqZhZ8kr17hjzuDUjnzAq0
         v8OIHE8q0sw9XszdserPpgjcmpYtOsWJNmWcBTYD6NRza3pzELR1Zl+AL6J3nz7s3npM
         Jx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679260681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvuN9jR+G4W2pj0hYHw8fCbcQee3vmX+JNF1Jp+xXy4=;
        b=Nt2gL4R1jyVwAf92CWGF2cllU/6Wfo+T8FZ9jkHB5wph6sbUPZTfQJilSkwE8cTowm
         E0KwNQyTiqlynuj9jrheQJPNR6uX/u4hrhSH3E8xY5Sdx5QnGFtpiLl9m29QsORCymNP
         U75NvaU1UjWWMT6rZsd+VhUyGidDD2RCTGacOjtAQ92zvnt+4Y2peFAZYe5YufZeWmZU
         fi3bwqOFYy50IEG3qyLozdjDXiJWWsZFZmDQm8fNq8YMFdttJgx8DZA8LWa2BKhWwJ/N
         8dARdUl4lOmG9LG8wSgs3/AXu1uIoVGtZUZocMil3hXiC+kXhH4YbY7gZaGji8/o4dgE
         Rg1g==
X-Gm-Message-State: AO0yUKVp4VqnTuq+EcYkwLf4Gd8JuVy9+4+Aj2bIMdg7VOnq/id1C8bI
        yCqfVYubxC+qe/5vFInU94WICtkRAZBuf9vKqyCqLw==
X-Google-Smtp-Source: AK7set+9VnS+Zx/Lf+kkoI5Pn5uEfuXiMP/8MBqDkugjbYgC+nPgXVZvyjCbx64znVipe6WWNffPhmpNXjZ+Lq3mMew=
X-Received: by 2002:a05:6902:1243:b0:b13:7a6:f462 with SMTP id
 t3-20020a056902124300b00b1307a6f462mr5166402ybu.3.1679260680938; Sun, 19 Mar
 2023 14:18:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230319143640.1704735-1-trix@redhat.com>
In-Reply-To: <20230319143640.1704735-1-trix@redhat.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 19 Mar 2023 22:17:50 +0100
Message-ID: <CACRpkdZW0_tdUaoykjE9TkeQ2e-+CfmOVEHmKLuoqyf1AzL1nQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: pxa: remove unused gpio_is_pxa_type function
To:     Tom Rix <trix@redhat.com>
Cc:     robert.jarzmik@free.fr, brgl@bgdev.pl, nathan@kernel.org,
        ndesaulniers@google.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 3:36=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:

> clang with W=3D1 reports
> drivers/gpio/gpio-pxa.c:174:19: error: unused function
>   'gpio_is_pxa_type' [-Werror,-Wunused-function]
> static inline int gpio_is_pxa_type(int type)
>                   ^
> This function is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
