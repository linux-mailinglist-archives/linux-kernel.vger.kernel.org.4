Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE9F6F42E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjEBLl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjEBLl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 07:41:26 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CB64C1D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 04:41:12 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-55a44a2637bso30760027b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 04:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683027671; x=1685619671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITaFxWMhFS6ez7EZxqZQwq9jNTNEkWM+vswf6PCefgs=;
        b=Vx6lD+4vRIvZvmBaS0Rp2JueUxwQBm3tbbYrRHx+gQcMhSUZlUtUjmfT3/Eu9J/KAl
         LV3D/nFOq/GgnFIcDFPu8882icl9/YTZx5dYC3qkV5EOAhviPCrZMRdhZhC9vTVLK1SL
         9CghL8W9KojzSfi+4xFyQH6CAH/hBBvSv0R8+bjR9PCMjkox+1WBjzALk1ww52ucObMv
         +1bExjHJU1Y02ArtvZ8PGYDtGezNOvmUttl7e9/JX3MBuq39r44kxHqWppYpmFIQdz1X
         43iRqq4Kihv9tlKF333uqM0tpIVQH82v2oRQoNvM79rbhz/2yKv0ClLmFqUGMdPxtno1
         wP0g==
X-Gm-Message-State: AC+VfDzwk+MAhyzgXglNJQLwjETo+yQ0MmwEcw84O8VqV18XWG+MUPIh
        qvwDjilNfe19u3h+pydt5hS164Om12QHUEeYmmbw30xOW3U=
X-Google-Smtp-Source: ACHHUZ5G67OX7jGeVwtHZf+6BPynO592/yOpuN+qX1JiZ97S3L1nY0ukM4dBIhtuII3HiF5kwhJWYc0oUnG8L44VS2Y=
X-Received: by 2002:a81:4844:0:b0:55a:3ce9:dc3d with SMTP id
 v65-20020a814844000000b0055a3ce9dc3dmr6706454ywa.13.1683027671654; Tue, 02
 May 2023 04:41:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230502102050.1418417-1-p.zabel@pengutronix.de>
In-Reply-To: <20230502102050.1418417-1-p.zabel@pengutronix.de>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Tue, 2 May 2023 13:40:59 +0200
Message-ID: <CANBLGcym0GnRnDPsFU-d8vL_hr+mFaN2PJtFB2RY22KEJqpY0w@mail.gmail.com>
Subject: Re: [PATCH] reset: starfive: select AUXILIARY_BUS
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 12:20, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> CONFIG_AUXILIARY_BUS is not a user-visible symbol, replace 'depends on'
> with 'select'.
>
> Cc: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Hal Feng <hal.feng@starfivetech.com>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Makes sense to me. Thanks!
Reviewed-by: <emil.renner.berthing@canonical.com>

> ---
>  drivers/reset/starfive/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
> index 1fa706a2c3dc..d832339f61bc 100644
> --- a/drivers/reset/starfive/Kconfig
> +++ b/drivers/reset/starfive/Kconfig
> @@ -13,7 +13,8 @@ config RESET_STARFIVE_JH7100
>
>  config RESET_STARFIVE_JH7110
>         bool "StarFive JH7110 Reset Driver"
> -       depends on AUXILIARY_BUS && CLK_STARFIVE_JH7110_SYS
> +       depends on CLK_STARFIVE_JH7110_SYS
> +       select AUXILIARY_BUS
>         select RESET_STARFIVE_JH71X0
>         default ARCH_STARFIVE
>         help
> --
> 2.39.2
>
