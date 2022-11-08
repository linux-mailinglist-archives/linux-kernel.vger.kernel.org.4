Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A73620969
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 07:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiKHGP5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Nov 2022 01:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKHGPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 01:15:54 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B013CEE12;
        Mon,  7 Nov 2022 22:15:53 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so16999903pji.1;
        Mon, 07 Nov 2022 22:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXJtUy05+C7un676W8scGbm8GkeZwqkjF2mv8wCWTzQ=;
        b=u9QNYNrpLRZR2Lr0KDI4CqhQAjs6lSjF3tD9DsvUvtyNdYYk8bNhZFLxCt6LuX1I1o
         DIbq8PujgWJHIOrkriU5xlPwIptUGQAQbdxtbTlhSAvsntePGqORdm3D10jxcv5CQ8+6
         3Jx7hQR4msB/S663s92suug74hr0oe9vTBGtBa/zn1ZBnnVcgNbVqjxDj8OJNF+R8uMF
         J8c/6yjPFqpjP2m0xOZS5vBGnbQL+8AOrIojL5byi4q+nYTWM7ZRbZCv3xRJCS3LpxIp
         qC0Yro6X/IO471rxadvRBmvKtC80NeoVu7ub3NhniVqhTYEvV+T3kQM1cVYhtUskB8kH
         kEjw==
X-Gm-Message-State: ACrzQf18H1bokkrxSP1CFZrfAjf/QPgYcWAXAUS/QaUODt/FyE735XqM
        tfVsrNDJ5HIxwOZHihqYAzbGrzS0B8PiOIKmq0aNY6TqfYw=
X-Google-Smtp-Source: AMsMyM7qVTp0wkYGW+FJZg54WTZgsic/z0B/rKaZ0SgCB+Es1GlyTwiSBPi/J+r841xcqZZs3LEt1TED0fASyprVFs8=
X-Received: by 2002:a17:903:185:b0:187:2430:d39e with SMTP id
 z5-20020a170903018500b001872430d39emr45168485plg.65.1667888152914; Mon, 07
 Nov 2022 22:15:52 -0800 (PST)
MIME-Version: 1.0
References: <20221106100120.849735-1-mailhol.vincent@wanadoo.fr> <20221106125546.855266-1-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20221106125546.855266-1-mailhol.vincent@wanadoo.fr>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Tue, 8 Nov 2022 15:15:41 +0900
Message-ID: <CAMZ6RqKZJcSq=dMh84gacY3yh_4=XnW=Hupq4dZztE681ZACHg@mail.gmail.com>
Subject: Re: [PATCH v2] can: etas_es58x: sort the includes by alphabetic order
To:     linux-can@vger.kernel.org
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun. 6 Nov. 2022 at 21:56, Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
> Follow the best practices, reorder the includes.
>
> While doing so, bump up copyright year of each modified files.
>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> ---
>
> Changelog:
>
> v1 -> v2:
>
>   * rebase on linux-can-next/testing. v1 was based on a local branch
>     and did not apply (sorry for the noise).
>
>   * add the copyright bump. That was initially of this patch:
>     https://lore.kernel.org/linux-can/20221104073659.414147-1-mailhol.vincent@wanadoo.fr/raw
>     but figured out that it is better to put this next to the
>     modifications of the includes.
> ---
>  drivers/net/can/usb/etas_es58x/es581_4.c    | 4 ++--
>  drivers/net/can/usb/etas_es58x/es58x_core.c | 6 +++---
>  drivers/net/can/usb/etas_es58x/es58x_fd.c   | 4 ++--

The header file es58x_core.h also has some includes which are not
sorted correctly...

This was meant to be a trivial patch, but finally, it will need a
third revision. Please don’t take it, I will resend. And sorry for the
noise.

>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/can/usb/etas_es58x/es581_4.c b/drivers/net/can/usb/etas_es58x/es581_4.c
> index 1bcdcece5ec7..4151b18fd045 100644
> --- a/drivers/net/can/usb/etas_es58x/es581_4.c
> +++ b/drivers/net/can/usb/etas_es58x/es581_4.c
> @@ -6,12 +6,12 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
>
> +#include <asm/unaligned.h>
>  #include <linux/kernel.h>
>  #include <linux/units.h>
> -#include <asm/unaligned.h>
>
>  #include "es58x_core.h"
>  #include "es581_4.h"
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
> index 51294b717040..7d6e688f2b46 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_core.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
> @@ -7,15 +7,15 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
>
> +#include <asm/unaligned.h>
> +#include <linux/crc16.h>
>  #include <linux/ethtool.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/usb.h>
> -#include <linux/crc16.h>
> -#include <asm/unaligned.h>
>
>  #include "es58x_core.h"
>
> diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> index c97ffa71fd75..fa87b0b78e3e 100644
> --- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
> +++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
> @@ -8,12 +8,12 @@
>   *
>   * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
>   * Copyright (c) 2020 ETAS K.K.. All rights reserved.
> - * Copyright (c) 2020, 2021 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> + * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>   */
>
> +#include <asm/unaligned.h>
>  #include <linux/kernel.h>
>  #include <linux/units.h>
> -#include <asm/unaligned.h>
>
>  #include "es58x_core.h"
>  #include "es58x_fd.h"
> --
> 2.37.4
>
