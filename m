Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76E604BAE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiJSPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJSPgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:36:55 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797AB1DC4F9;
        Wed, 19 Oct 2022 08:32:54 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id x188so19662143oig.5;
        Wed, 19 Oct 2022 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zqy3E7Ljn1Po59QT2BcCLeBrVV82ElW8LGYHfgQZyfA=;
        b=h6uk8hTCVSRMZqO3bEgxbGEw9bbxFFeNAHazOJc493Gn3IbZEecV6Blo0AP9oeH/nT
         flh5EASozPgJLpfmYGOJmYLCxOkBq5WU6b3fNdSb1AMdKZgVjZ3aU6K0dWUJBjcvlmX1
         ID4Bu9OxeVlRF5mwhJnImPZr/4ltnOdXWU3PtvzcKSOXsjW/I+tFdB6gEUbY7ua+LUON
         tW5Q+WTuWBTvP5B5JMqnMnZ0xyw4D0hTV2sHyBZkqiFE+TJjfJHDsdnzlASyRWkvX6Qp
         edkmGXEEXQi8slgtP78r6qI1BOrHJkRdOBfYftE0dUzXm1NW12bZArsqZ5VQYgkR1Gb8
         BAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqy3E7Ljn1Po59QT2BcCLeBrVV82ElW8LGYHfgQZyfA=;
        b=yPAVJd2bwKKi9SzS4zSfLfguSLf1wZS5W8fpn+xJV9fccfxrUHN5l8ez7RJkWCQH7v
         B7pdIy4jxbloMD97ePOdAv3ChiyYUnXjSaMMncIYee3kz6QQ5mRP7g78AjJPIDwo9As7
         kOJMTbA9Q9j9IxhjTbS00cUz4FmDtUTNP5ZFLUiuSG86wGiulpsZ0KuRZKDQqNWdvVT/
         JCNgkiYriQ96lcuu7s+pmWs1hSCzUB4ngzfvqc8vk5AIVN5RQ+FxWUVHDkyHtrMZtbPL
         B7516wANCHXN1V+fJZJtnB0iUoT/gwkH8ULYBOM1wZWH0a5zttw5AW+QxsXT40prItyq
         EXsQ==
X-Gm-Message-State: ACrzQf0y7Eita55wqxCX8Se9PGgt464sgqtiDwiNZ4uQUNrperCksXJ4
        HXqB4JAuIVTsxqLSAoJjHKs=
X-Google-Smtp-Source: AMsMyM4qW3m6PF9cIZeFfx7xRpFhIthWH8MkgpRbUVgkqFG62NjMpRdchK912Iys3qr6E/J6ftFkvQ==
X-Received: by 2002:a05:6808:219a:b0:354:daec:53cb with SMTP id be26-20020a056808219a00b00354daec53cbmr4395176oib.2.1666193456505;
        Wed, 19 Oct 2022 08:30:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l10-20020a4a434a000000b004768f725b7csm6539649ooj.23.2022.10.19.08.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 08:30:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 19 Oct 2022 08:30:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrej Picej <andrej.picej@norik.com>
Cc:     linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        kernel@pengutronix.de, s.hauer@pengutronix.de,
        wim@linux-watchdog.org, robh+dt@kernel.org
Subject: Re: [PATCH 0/3] Suspending i.MX watchdog in WAIT mode
Message-ID: <20221019152915.GB4602@roeck-us.net>
References: <20221019111714.1953262-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019111714.1953262-1-andrej.picej@norik.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 01:17:11PM +0200, Andrej Picej wrote:
> The i.MX6 watchdog can't be stopped once started. This means that
> special hardware suspend needs to be configured when the device enters
> low-power modes.
> Usually i.MX devices have two bits which deal with this:
> - WDZST bit disables the timer in "deeper" low power modes and
> - WDW bit disables the timer in "WAIT" mode which corresponds with
> Linux's "freeze" low-power mode.
> 
> WDZST bit support is already in place since 1a9c5efa576e ("watchdog: imx2_wdt: disable watchdog timer during low power mode").
> WDW bit is not common for all imx2-wdt supported devices, therefore use
> a new device-tree property "fsl,suspend-in-wait" which suspends the
> watchdog in "WAIT" mode.

I think that needs to be validated using the "compatible" property;
it should not be possible to set/accept the new flag for devices
which don't support it.

Thanks,
Guenter

> 
> Andrej Picej (3):
>   watchdog: imx2_wdg: suspend watchdog in WAIT mode
>   dt-bindings: watchdog: fsl-imx: document suspend in wait mode
>   ARM: dts: imx6ul/ull: suspend i.MX6UL watchdog in wait mode
> 
>  .../devicetree/bindings/watchdog/fsl-imx-wdt.yaml          | 5 +++++
>  arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi           | 4 ++++
>  drivers/watchdog/imx2_wdt.c                                | 7 +++++++
>  3 files changed, 16 insertions(+)
> 
> -- 
> 2.25.1
> 
