Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3595F624D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJFIHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiJFIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:07:17 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904D46846;
        Thu,  6 Oct 2022 01:07:16 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 195so1248153pga.1;
        Thu, 06 Oct 2022 01:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=G+toKQpufbPMnd1NtuG1DlYOX/0SX3T7igfqYXNs3MU=;
        b=0uD3glvCaQGTivdVrdg+fJV/vGRyaa5ZgCX5cFd34XRoQIokJW7z2bkhDdREHTXKzb
         BFYOWT6CkQKV57ML49p+qMjGiLX5mjxEp+ObadTusRlG74u3p/8FS221RE8RvcaIPCMm
         ykEQFzVbFXqXiZ1Az4a9NQiY9oeZ+5s/Cay9N3vN/xqYym1pDH14jDKNVr8Wa4sld1FQ
         fLLmZRVyRkoNaUreKy2KKnKmF0vU4iSTLnMdD8EEqUomJiMZ+7DkLPmUig5rqVNQcfsv
         UJfkTiTa94HzsoIfQsIW7c8guoYsMDIZ+tkMT2+NWCUom+ded+zuVowZGdn07vjBdw24
         Ki4w==
X-Gm-Message-State: ACrzQf3+8su8zYh81EJQjHOOhwKXU2Xjp3aCwhH43ZO0PZFhqwnq460R
        0YFw2zZ6MBsjcmlb8ml3jLYdOMRbXYWJYB+9Ui0=
X-Google-Smtp-Source: AMsMyM6iJlpRTImKb+vaNT6xzQUSY6ey2L/uvoRgGAC15I7tfMtKy8WXMIOWBMQSr+tt7auxJyTOu20/F3bMDrRmnbI=
X-Received: by 2002:a65:6944:0:b0:43c:da07:5421 with SMTP id
 w4-20020a656944000000b0043cda075421mr3532690pgq.72.1665043635666; Thu, 06 Oct
 2022 01:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221006080154.5396-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20221006080154.5396-1-lukas.bulwahn@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 6 Oct 2022 10:07:03 +0200
Message-ID: <CANBLGcx5JTXDFGVBgnG=_VPMK9tXLHRF_xZcnbcmBnZWCT=sug@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust STARFIVE JH7100 PINCTRL DRIVER after
 file movement
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@linux.starfivetech.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 10:02, Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit ba7fdf88e98a ("pinctrl: Create subdirectory for StarFive drivers")
> moves pinctrl-starfive.c into its own subdirectory starfive; further,
> commit ba99b756da17 ("pinctrl: starfive: Rename "pinctrl-starfive" to
> "pinctrl-starfive-jh7100"") adds the suffix jh7100 to the driver and
> dt-bindings header file name.
>
> These commits however do not adjust the entry in MAINTAINERS. Hence,
> ./scripts/get_maintainer.pl --self-test=patterns complains about a broken
> reference.
>
> Adjust the entries for STARFIVE JH7100 PINCTRL DRIVER after file movement.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Good catch.
Reviewed-by: Emil Renner Berthing <kernel@esmil.dk>

>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a1347b5fd07..37a9f9e7f6c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19603,8 +19603,8 @@ M:      Emil Renner Berthing <kernel@esmil.dk>
>  L:     linux-gpio@vger.kernel.org
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/pinctrl/starfive,jh7100-pinctrl.yaml
> -F:     drivers/pinctrl/pinctrl-starfive.c
> -F:     include/dt-bindings/pinctrl/pinctrl-starfive.h
> +F:     drivers/pinctrl/starfive/
> +F:     include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
>
>  STARFIVE JH7100 RESET CONTROLLER DRIVER
>  M:     Emil Renner Berthing <kernel@esmil.dk>
> --
> 2.17.1
>
