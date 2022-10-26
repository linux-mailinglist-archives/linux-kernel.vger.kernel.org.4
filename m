Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A509360DF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbiJZL0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiJZL0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:26:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB68B2E7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:26:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k22so3273315pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PIiOLjtnf2qbxkuXcBFpYSERKNLiy0vN0TgZPAlpRjI=;
        b=y3AltkaH/WeQVuWZdTks3oMsOwOdaRAp3Vup5pEkIZGuzLowz3YlhxeQatzvFZMk9l
         pqIp9SGTHos8srmXNwjuc6XF+dUF9/H/OSaQPF9I8cxjaLJV/2H1nCvKiMU2J8JjYN3Z
         oqXoxpFlS+gXDJPTkkGgyPiLRfPIb7v2zGs/YmfiIUvcZZfm6EGratCTW1HbWjEK1xlk
         TbgmxRAhbbDMaOyWx4nQkB1tauFJuvIYKaS4ukMwtfQKoJ0+Gpsj/CnrmF+jzpljUrT4
         mBycOO7IgpVKJB3tMrXXRtc4ZHByPxU1DCD8plMI2qxrvEJjlyBMTLlxxSBiqcdpAv2u
         Ws/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIiOLjtnf2qbxkuXcBFpYSERKNLiy0vN0TgZPAlpRjI=;
        b=SLp7fr0bGgv1QRPmiMd1admtF5XIDGSjmqcYbIxaLX+oF0lqeYc+ZezDC5e5XeqSQw
         zoTtF6sTh/p1mJw4fvXpJekWez1Bme3XceUtVOS6TPKm8CKpoRqpdnFkf91q4Is768Bd
         xBuJCklT/AyoIuMn+WagBD4Nj1rSXceeuiNrkXHGaFWa2FvO0Li9OtJhJO0TolQgUuAO
         wKpoc0ufpSaUSk3PXu3oyeVuSHofjbyR368TcA8YCiT3s5qpTexgXw8orGsImKrC4cLg
         5ervAOz4Lg7/XZr8AG+VGZY3p5dMWIWxX+ACpr2fwvovcrP8UWT9qenEC9W/GgHz/xGF
         8Baw==
X-Gm-Message-State: ACrzQf1dqDXpApeN7+Xv/1yVl8Myw5vvRafsbiJ2Ea2jJA1NCc60KaLa
        hZEQkQQwFspeYNDJ0n4CbnIDCyQEIytoSGEP/1UX4Q==
X-Google-Smtp-Source: AMsMyM7KVNwJRn9XUHGfIaLNGJ3yt+K/RIDMpM6kVr83jtTNXXXw7fsFhVW5kigCfMN9KGs+iC0vAFLKjLRxr8LPspA=
X-Received: by 2002:a63:1612:0:b0:461:4180:d88b with SMTP id
 w18-20020a631612000000b004614180d88bmr37998315pgl.434.1666783578179; Wed, 26
 Oct 2022 04:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221024181759.2355583-1-briannorris@chromium.org>
In-Reply-To: <20221024181759.2355583-1-briannorris@chromium.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Oct 2022 13:25:41 +0200
Message-ID: <CAPDyKFoWoUFOL1Q5tiP07PMCbn8U6sY+FRdo03c8FZCQh_R2Dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
To:     Brian Norris <briannorris@chromium.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 20:18, Brian Norris <briannorris@chromium.org> wrote:
>
> This driver is pretty simple, and it can be useful to build it (for
> validation purposes) without BMIPS or ARCH_BRCMSTB.
>
> It technically depends on CONFIG_OF to do anything useful at runtime,
> but it still works out OK for compile-testing using the !OF stubs.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index f324daadaf70..453fba8d2d9d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -1040,10 +1040,10 @@ config MMC_SDHCI_MICROCHIP_PIC32
>
>  config MMC_SDHCI_BRCMSTB
>         tristate "Broadcom SDIO/SD/MMC support"
> -       depends on ARCH_BRCMSTB || BMIPS_GENERIC
> +       depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         select MMC_CQHCI
> -       default y
> +       default ARCH_BRCMSTB || BMIPS_GENERIC
>         help
>           This selects support for the SDIO/SD/MMC Host Controller on
>           Broadcom STB SoCs.
> --
> 2.38.0.135.g90850a2211-goog
>
