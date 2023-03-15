Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CBA6BB330
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjCOMmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjCOMlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:41:52 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982CCA21B4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:40:40 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id k11so8042361vsq.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678884038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGB5TAVKgn+JcILTjBLEo3Nqv38rQmrITjGsZ3/q3RE=;
        b=5n/hTpt58q4I598NU4JHUH3nYG+EL32Sg6Jo+1++it5F30xId/SwVkkTBIKuMgzUTg
         VxZAJwBPt2ntUnzNHScF9w3/YQ3lVvKuyzuqXAKRm0PDDHZqWGXJXjV4J2dG1xQplcN6
         T1894NTFRqOIEhtkUmWgniVcjE6IY7V0HcfAi2sJlAlTamvg3lPKOvIg956y9hF3nGuu
         YwIzt8d8W5CCLzT3al/JZcM5mDESuVC09DbJyASwf6/U/llGV++mwAZqNRz+08QPAhqR
         hcaYklVgtjv6Of5K+O4bf056Ut5UQtbXnhPLA6GBfxOH8+Cr2Tqek/26+AY70w1RCq7O
         8+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678884038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGB5TAVKgn+JcILTjBLEo3Nqv38rQmrITjGsZ3/q3RE=;
        b=s7XPWYpcjx8oiP+sB3AutqwhlSn4AC7T1Wfd1gK2GZqGDURwK/M//F4GPdhw95WsVV
         rRQiKreem0onw5YdMdAv6PHbWz1nrnzbx6Q+GeRX+k634TsRS7MyiVghACqyZ9aq44ps
         GQK48b5d1HCpPPneFX84PjJRdCUVDT5HXDmzxTfZz+PxNV8NUwNRI+inTAgj6iOsJJm/
         fyyWbAhqazE6KAgQseJgdt3lpmHmxrG5wG2Udou/wJaIJHHWDhxleU2F7sn/POcLIPvR
         ZM+GtOx4t8NxFQkZxgCP+bcHkt56L5ANRpW5j6qFLGsp22ZM9qSJeosvmceqCDXh3xCE
         xDjw==
X-Gm-Message-State: AO0yUKVU+UmZq6pUMviM0Q53YurwSzO8POFrySLH/bowu8ON7ZXzdtsZ
        a3xzd9MdmkqPipl1SRZAWgTBKHGZZdyNCc09pz81cw==
X-Google-Smtp-Source: AK7set9i1vZR7QtDsiNzc05auoCocbWDaCPTtalDun15RYYZFlTRyYRm6WIDu3Mdp92FyZ391FDgsMxzChtD9/7ScXo=
X-Received: by 2002:a05:6102:3196:b0:423:e7a3:aedf with SMTP id
 c22-20020a056102319600b00423e7a3aedfmr7683678vsh.0.1678884038731; Wed, 15 Mar
 2023 05:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230309233929.3998-1-william.gray@linaro.org>
In-Reply-To: <20230309233929.3998-1-william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 13:40:27 +0100
Message-ID: <CAMRc=McfEpxmSe4cSWRywbDYeeChmutGNbSOkVJaiFH23gQ8Ug@mail.gmail.com>
Subject: Re: [PATCH] gpio: pcie-idio-24: Prune superfluous license boilerplate
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:39=E2=80=AFAM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> The SPDX License Identifier line renders the GPL boilerplate text
> superfluous, so let's remove it.
>
> Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
> ---
>  drivers/gpio/gpio-pcie-idio-24.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-id=
io-24.c
> index 8a9b98fa418f..92e693b69fc8 100644
> --- a/drivers/gpio/gpio-pcie-idio-24.c
> +++ b/drivers/gpio/gpio-pcie-idio-24.c
> @@ -3,15 +3,6 @@
>   * GPIO driver for the ACCES PCIe-IDIO-24 family
>   * Copyright (C) 2018 William Breathitt Gray
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License, version 2, as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
>   * This driver supports the following ACCES devices: PCIe-IDIO-24,
>   * PCIe-IDI-24, PCIe-IDO-24, and PCIe-IDIO-12.
>   */
>
> base-commit: b96eb88f59c023bb27891b5ab3dbd2b1a5200d53
> --
> 2.39.2
>

Applied, thanks!

Bart
