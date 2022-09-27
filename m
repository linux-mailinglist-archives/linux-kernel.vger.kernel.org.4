Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1165EBADA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 08:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiI0Gle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 02:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiI0Glb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 02:41:31 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365C80484;
        Mon, 26 Sep 2022 23:41:30 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a14so3212509uat.13;
        Mon, 26 Sep 2022 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=mFh6NsEr1L0/g93EnTYq+6Sa+0CU8JHFpiWEKCGOkR8=;
        b=qF57YCZupFWGBIxMIKZYL6Kt8BangP8hdYRrZ6j+IZYMqY/PePENXRnKuunVz9xtoL
         9f05cfme8U5aex6FaU/SLwJrhASE76mIzQYVqQqsJuVS9LQ4eTMa1crm4bXlMFn/T8R0
         X69Akmkgdbw4vR7gCXsY1XrypfJZG4COGJdauudrAQv6QAyfTqG7qzvaoZjyO2YqA6dz
         SU1156kVS1i6eKoFG8tNXGV7JiJq1MeJQ97eiZCMwnjY+8oLRDb2yWVnzlWGQLGtUK69
         B0EzlHGmfisE/kC/h+7yi6R2MRXKNRkxQgzdvTDZRD8oDfzop1Cj2aawpXxeVvOyopHZ
         ZDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mFh6NsEr1L0/g93EnTYq+6Sa+0CU8JHFpiWEKCGOkR8=;
        b=vxVf5A0IuADTb8ZSuBP8Soja6lorht6DeHZeKCj6JFTBnjj78dW4TwE4l3HWeV0OV5
         JkhnuwkbyHCxiSUBp2GpuJ9xTZrecpNQLynOcr4/NXYVEsihkFnxDcn19xFZMxj1Sims
         IwAcKpdq00QBluBtXRwviZvKxQ0yy3OpxIs6W30QoExgQpd1JrJG1qVJU1WVV7dT9DPO
         xH+rHLcOUnbn/2UsTG+KA+HAGIuL6Cw5db8Jx74ZxFy2Mm0QOioYaS6pkj0EDlXaIkGx
         E2aR+/9vHQPGmd4ty1vYd1GRQPomLSQeMv6JqucA5JzVj3moHQqOFiJ7IkI2yIYRF9IJ
         zfsg==
X-Gm-Message-State: ACrzQf0epbWKSZmktN8zFsnKiRAGp67Gts24D4eg3IOwoQx1MyzedZex
        E+t9N4MyK6xbd3J6vI21cHrFO/sP8B2EGQSeous=
X-Google-Smtp-Source: AMsMyM51gajmAGQxmY2CPH1PAtXWHmIvx24FcR1pBMGJzHAvgISRbjE74dgZApEAxpte15rRTi3BILSpkBR/kgJURbo=
X-Received: by 2002:ab0:2256:0:b0:3cd:36b4:41c with SMTP id
 z22-20020ab02256000000b003cd36b4041cmr5233315uan.73.1664260888910; Mon, 26
 Sep 2022 23:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220907131241.31941-1-romain.perier@gmail.com>
In-Reply-To: <20220907131241.31941-1-romain.perier@gmail.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Tue, 27 Sep 2022 08:41:17 +0200
Message-ID: <CABgxDoKeJrVK2NxJXd=MicdBWUyusf1aGbgKvyrOyB7m0xbPaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Add PWM for MStar SoCs
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
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

ping ;)

Regards,

Le mer. 7 sept. 2022 =C3=A0 15:12, Romain Perier <romain.perier@gmail.com> =
a =C3=A9crit :
>
> This patches series adds a new driver for the PWM found in the Mstar
> MSC313e SoCs and newer. It adds a basic pwm driver, the corresponding
> devicetree bindings and its documentation.
>
> Changes since v1:
> - Fixed commit message for the dt-bindings doc
> - Removed "OneOf" from the dt-bindings doc
> - Re-ordered alphabetically in Kconfig and remove
>   unseless empty lines
> - Explain and adds comment in _writecounter() (hw
>   constrainst)
> - Reworked the msc313e_pwm_config() function
> - Fixed clk handling
> - Removed extra callbacks, only keep .apply and .get_state
> - Implement .get_state completly, this fixes the driver with PWM_DEBUG
>   (the whole driver has been tested with PWM_DEBUG).
> - Dropped useless lines in _probe
> - I have kept regmap_field() because it is more clean and helpful, it
>   avoids to do too much of offset and mask and shift all over the place.
>
> Daniel Palmer (1):
>   pwm: Add support for the MSTAR MSC313 PWM
>
> Romain Perier (4):
>   dt-bindings: pwm: Add Mstar MSC313e PWM devicetree bindings
>     documentation
>   ARM: dts: mstar: Add pwm device node to infinity
>   ARM: dts: mstar: Add pwm device node to infinity3
>   ARM: dts: mstar: Add pwm device node to infinity2m
>
>  .../bindings/pwm/mstar,msc313e-pwm.yaml       |  46 +++
>  MAINTAINERS                                   |   1 +
>  arch/arm/boot/dts/mstar-infinity.dtsi         |  10 +
>  arch/arm/boot/dts/mstar-infinity2m.dtsi       |   8 +
>  arch/arm/boot/dts/mstar-infinity3.dtsi        |  10 +
>  drivers/pwm/Kconfig                           |  10 +
>  drivers/pwm/Makefile                          |   1 +
>  drivers/pwm/pwm-msc313e.c                     | 269 ++++++++++++++++++
>  8 files changed, 355 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/mstar,msc313e-p=
wm.yaml
>  create mode 100644 drivers/pwm/pwm-msc313e.c
>
> --
> 2.35.1
>
