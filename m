Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DCD73A161
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjFVNCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFVNC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:02:29 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD810F8;
        Thu, 22 Jun 2023 06:02:23 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D60DE5FDAD;
        Thu, 22 Jun 2023 16:02:19 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687438939;
        bh=w4D8j20IdblRYzBMBoVQwAQ0UD3FpLpcfi4gJumrTeQ=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=lv8HX8NapO5+UDMYVLqguE7sxm2Tq1ry6+DzAv7NHpkG1lbdpUGx3FRZt8AvWIVyU
         bXlhMfSnZ1z6Vyz95+3AY7nWP3NqAs4swTi7ktrVNHFFVFj0dWUS4X9fvH+sWGJ6bs
         naEnAWTJj9TJq+p9N0JDEyX50wlx+kxiQ1n3aEtVsSV/blwOVEq2sdRjhPxSH5ZwkZ
         smy0ZCTZ4psYPdyENpZ7PGdO/PUOClbRKxCL5iW2jbuUBwiaSMxOap1I+tL81DSB1x
         0yMn4XFxjCv2DQ6Hf0546pe/5qm+6/H1swrBWgA34TrFCjx6c9pB0RCUJUqjddG9+5
         ikfD5iWHAxmVA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 22 Jun 2023 16:02:16 +0300 (MSK)
Date:   Thu, 22 Jun 2023 16:02:16 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Neil Armstrong <neil.armstrong@linaro.org>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 17/19] clk: meson: a1: move bindings include to main
 driver
Message-ID: <20230622130216.ocfvwfnad7amex65@CAB-WSD-L081021>
References: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-0-38172d17c27a@linaro.org>
 <20230607-topic-amlogic-upstream-clkid-public-migration-v2-17-38172d17c27a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230607-topic-amlogic-upstream-clkid-public-migration-v2-17-38172d17c27a@linaro.org>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 09:26:00 #21554371
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 11:57:34AM +0200, Neil Armstrong wrote:
> Now the clock ids are no more defined in private headers,
> cleanup and include the dt-bindings headers from the main
> driver file.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/clk/meson/a1-peripherals.c | 2 ++
>  drivers/clk/meson/a1-peripherals.h | 3 ---
>  drivers/clk/meson/a1-pll.c         | 2 ++
>  drivers/clk/meson/a1-pll.h         | 3 ---
>  4 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1-peripherals.c b/drivers/clk/meson/a1-peripherals.c
> index a5cab418736a..070ea1427d73 100644
> --- a/drivers/clk/meson/a1-peripherals.c
> +++ b/drivers/clk/meson/a1-peripherals.c
> @@ -15,6 +15,8 @@
>  #include "clk-regmap.h"
>  #include "meson-clkc-utils.h"
>  
> +#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
> +
>  static struct clk_regmap xtal_in = {
>  	.data = &(struct clk_regmap_gate_data){
>  		.offset = SYS_OSCIN_CTRL,
> diff --git a/drivers/clk/meson/a1-peripherals.h b/drivers/clk/meson/a1-peripherals.h
> index 842b52634ed0..26de8530184a 100644
> --- a/drivers/clk/meson/a1-peripherals.h
> +++ b/drivers/clk/meson/a1-peripherals.h
> @@ -43,7 +43,4 @@
>  #define PSRAM_CLK_CTRL		0xf4
>  #define DMC_CLK_CTRL		0xf8
>  
> -/* include the CLKIDs that have been made part of the DT binding */
> -#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
> -
>  #endif /* __A1_PERIPHERALS_H */
> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
> index 25e6b567afd5..7de7d78c3813 100644
> --- a/drivers/clk/meson/a1-pll.c
> +++ b/drivers/clk/meson/a1-pll.c
> @@ -14,6 +14,8 @@
>  #include "clk-regmap.h"
>  #include "meson-clkc-utils.h"
>  
> +#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> +
>  static struct clk_regmap fixed_pll_dco = {
>  	.data = &(struct meson_clk_pll_data){
>  		.en = {
> diff --git a/drivers/clk/meson/a1-pll.h b/drivers/clk/meson/a1-pll.h
> index 0add1c7ea9f5..4be17b2bf383 100644
> --- a/drivers/clk/meson/a1-pll.h
> +++ b/drivers/clk/meson/a1-pll.h
> @@ -25,7 +25,4 @@
>  #define ANACTRL_HIFIPLL_CTRL4	0xd0
>  #define ANACTRL_HIFIPLL_STS	0xd4
>  
> -/* include the CLKIDs that have been made part of the DT binding */
> -#include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
> -
>  #endif /* __A1_PLL_H */

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

-- 
Thank you,
Dmitry
