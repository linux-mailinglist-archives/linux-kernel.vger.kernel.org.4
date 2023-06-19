Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20D9734EE6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjFSI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 04:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjFSI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 04:58:43 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A309E62
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:58:00 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5702415be17so26513227b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687165079; x=1689757079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLmeJWd/edsFY2ls/Yz70yLNc/eoAErRFP6oqVGaQzo=;
        b=uIr0hcR/YywyPAn1Q9NNec4n4+nmGsa9QwL8DBaVlBbyAkaJwg20xEqKD4ly3I2aVj
         BQyWFsp6A9kFryjQcNVsM+x32cYfVnFmDqL66ku1aFu2ZbDAwTzeu2PDry2Sq5HtQ7ZE
         D/GcEb21bpeuRiXhhVx4B44cJGiL0tdXU/UduN4U1SvhInp2hUshVs9ec8TvARKAmuZI
         D/CJUYRpjiJhPBty1vLybrP32uODyW51NPMX395ko6lcldvDcibUDq6/3CJtQYIqCP+D
         eHD4MGOHPb2qMmcVE8o6OIIDznY6aOEFSdXT801SIgY4pE1lQe1IyCTJhQDM6JVHCnA8
         Q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687165079; x=1689757079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLmeJWd/edsFY2ls/Yz70yLNc/eoAErRFP6oqVGaQzo=;
        b=h5DdFTXmvGU41F2Mzvv+kw3hg8CUgFnHU9hh46WBeflr9RNdyZqj4fygQC3h/yBZw/
         O95JzA0U2uoqq1cL92FaM7IvmIMDoMzuOg2sekNzpd0yEnEepZ3UG4sVrhYWUMyuQ+J2
         33tmgU2NpahLnNfMo/q3eF6vzZTOfpHPW14DctS/1Xk56WIkGTBYiO8t36iCFP7kccpP
         omf9Vr8u8XWPDJCfnNUblZCeDwLLplwJHm1kFJwVvpw0HZZ5u9S+CCtAQWx7C3z+9shO
         WEyq4ZKeCkFlS946V62moEHaUXu8hGgPeoXwIPcqFgEhewxD5qxba43MBNPZTfUK8/Iq
         CTNQ==
X-Gm-Message-State: AC+VfDzLQMpbdq3fLd6NjEak6kUtlCvojtfpMO1T4QtNSf5122MvN17p
        yfGBSm5adBGx2+TINJehW139sq8njPTbVmDS5XkOjQ==
X-Google-Smtp-Source: ACHHUZ5+r5xud6CHZeGlG1QSWzO428im7bO5R2mp0md9VvDElGt3sdaijKYmfRcsXy0ZO73h1kU6UMMNy9w6gPMGHyg=
X-Received: by 2002:a25:ce85:0:b0:b96:4634:146 with SMTP id
 x127-20020a25ce85000000b00b9646340146mr4203242ybe.60.1687165079656; Mon, 19
 Jun 2023 01:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230616145036.3910153-1-arnd@kernel.org>
In-Reply-To: <20230616145036.3910153-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 19 Jun 2023 10:57:48 +0200
Message-ID: <CACRpkdaNqELB8OtCuEbqny80OvJnxo1Ggw4kEQQ59+9BonDpeA@mail.gmail.com>
Subject: Re: [PATCH] gpio: synq: remove unused zynq_gpio_irq_reqres/zynq_gpio_irq_relres
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Michal Simek <michal.simek@amd.com>,
        Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Andy Shevchenko <andy@kernel.org>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 16, 2023 at 4:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The driver now uses the generic request/release callbacks, so the custom
> ones are no longer called. When building with -Woverride-init, gcc produc=
es
> a warning about the duplicate entries:
>
> In file included from drivers/gpio/gpio-zynq.c:10:
> include/linux/gpio/driver.h:621:43: error: initialized field overwritten =
[-Werror=3Doverride-init]
>   621 |                 .irq_request_resources  =3D gpiochip_irq_reqres, =
         \
>       |                                           ^~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-zynq.c:611:9: note: in expansion of macro 'GPIOCHIP_IRQ=
_RESOURCE_HELPERS'
>   611 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/gpio/driver.h:621:43: note: (near initialization for 'zynq_=
gpio_level_irqchip.irq_request_resources')
>   621 |                 .irq_request_resources  =3D gpiochip_irq_reqres, =
         \
>       |                                           ^~~~~~~~~~~~~~~~~~~
> drivers/gpio/gpio-zynq.c:625:9: note: in expansion of macro 'GPIOCHIP_IRQ=
_RESOURCE_HELPERS'
>   625 |         GPIOCHIP_IRQ_RESOURCE_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/gpio/driver.h:622:43: error: initialized field overwritten =
[-Werror=3Doverride-init]
>   622 |                 .irq_release_resources  =3D gpiochip_irq_relres
>       |                                           ^~~~~~~~~~~~~~~~~~~
>
> Removing the old ones has no effect on the driver but avoids the warnings=
.
>
> Fixes: f569143935378 ("gpio: zynq: fix zynqmp_gpio not an immutable chip =
warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Right.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
