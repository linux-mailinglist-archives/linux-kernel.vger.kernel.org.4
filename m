Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255447064B9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjEQJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjEQJ4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 05:56:53 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CA421E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:56:51 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-783dd1c02c9so208282241.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1684317410; x=1686909410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XPSuVta2HOg8vUR/UtRay+7le/6KZcKOQV/SsBICAQ=;
        b=xg2SrZFsIcXofYfCA/oEKWGumYVHRqt2E7GiaCt4zYD0Oo1spN4WAfYjdLySKN5cPH
         jNx9oLYtmKwyXXDchLi6waDj9wX+mshKdt+XbyjAU7y9+2wqNf8pSV9EFJ1h7C6mbjyo
         74Uz8uSQwULzZekhN914f4AEZgLj97M+LN9+YR1QrmKvDkdZNv86a2Q7KvozqCbQ214x
         2NDIyrBVCpMOuV7+0xgcYAccg+CWD9lHU2sAB5aZy+ceCNBNlNI25jaypvwQyHPNcZoh
         aLggCDng1mIU8SjvpYt9wxmZddfKA0kVhAvoBe9pHisF8KujGXCt3/LH/tHFPufYklg7
         z/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684317410; x=1686909410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XPSuVta2HOg8vUR/UtRay+7le/6KZcKOQV/SsBICAQ=;
        b=R8bs5W2ideR79TCSapWUm8G7Zmrg2xQGgI4nyDktT8vbdxx4PxMSijqOcsiZDS7P8Q
         01sI/8NYHQaFauJ9A3O/pP386lbBtPk/BVkiDIZT0GCA1NT1BPlhS0enyEo8fqB+tJut
         7YrASDzN+fE8H4LgNTYV34nBdnny+S+ItA/Ltj1TR09qRnB3DT9RK5F1WvceJjpnAZ4J
         nK5mXviPACVFh/nD2Jf/Z4Wnd4x93EfwzbAeagJqOGfEA5wax1I0FtUd2/KLo2gafyL9
         ffXeaRgd7SLQ4GmSoFlzMm2w78SWn9raCYv5vubgHfTlQvkXDFineUYxWpYazY//A5WJ
         n9Cg==
X-Gm-Message-State: AC+VfDw/N66jfKRu9vDs05gpC6fhT1qZOFeVWZ5UovCejA6E9MM/3IX+
        VKYiRnSci1TdWPD1o+uYlpWw9mKQf0EM8cqm3PN8SA==
X-Google-Smtp-Source: ACHHUZ7dirwHzYqNcWJVEqkux+QzlRUgjKDMGdkdIXhV7Xz7wEKIF4dhBqxRzz2JM//g+mgozFgPI8R4rAGnRt/XgIQ=
X-Received: by 2002:a1f:4bc4:0:b0:440:125:7e59 with SMTP id
 y187-20020a1f4bc4000000b0044001257e59mr14096028vka.1.1684317410290; Wed, 17
 May 2023 02:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230517095301.903567-1-arnd@kernel.org>
In-Reply-To: <20230517095301.903567-1-arnd@kernel.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 17 May 2023 11:56:39 +0200
Message-ID: <CAMRc=McaZQ=e18=fo1GzOmMh2nRdF3A5Z8a1ftUJhvrM3VtZOw@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: sa1100: include <mach/generic.h>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:53=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> sa1100_init_gpio() is declared in a machine specific header so it
> can be called from platform code, but the definition is in the device
> driver, which causes a warning:
>
> drivers/gpio/gpio-sa1100.c:310:13: error: no previous prototype for 'sa11=
00_init_gpio' [-Werror=3Dmissing-prototypes]
>
> It's already possible to include mach/generic.h from drivers, so add
> this one here as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rebase back on mainline tree
> ---
>  drivers/gpio/gpio-sa1100.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-sa1100.c b/drivers/gpio/gpio-sa1100.c
> index edff5e81489f..242dad763ac4 100644
> --- a/drivers/gpio/gpio-sa1100.c
> +++ b/drivers/gpio/gpio-sa1100.c
> @@ -12,6 +12,7 @@
>  #include <soc/sa1100/pwer.h>
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> +#include <mach/generic.h>
>
>  struct sa1100_gpio_chip {
>         struct gpio_chip chip;
> --
> 2.39.2
>

Now applied, thanks!

Bart
