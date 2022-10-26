Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3796660E784
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbiJZSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233986AbiJZSgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:36:45 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EB8BC788;
        Wed, 26 Oct 2022 11:36:44 -0700 (PDT)
Received: from fabians-envy.localnet ([84.167.206.69]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MsZif-1p3UlG0D2R-00txcW; Wed, 26 Oct 2022 20:36:25 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 2/2] ARM: nspire: Remove unused header file mmio.h
Date:   Wed, 26 Oct 2022 20:36:06 +0200
Message-ID: <1831268.tdWV9SEqCh@fabians-envy>
In-Reply-To: <20221026161302.5319-3-afd@ti.com>
References: <20221026161302.5319-1-afd@ti.com> <20221026161302.5319-3-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
X-Provags-ID: V03:K1:NClhhaipd4yOhixENQlrW9V7/6hYMN6nF2P3+MnbhQpJowYP8Hn
 XCHpdZXBu1gJ4IGZM4jSCfK4oFLIjbW3Jjh7+TBZoDGCsm+BtAT3XZF9kx4+GIQiPk4dlL+
 uJlY3/vzSOqlIixX4/NDJqfkq3UDEMmk7cNCNnkCx6E5WKPB0+gCu3Fo3kJdwtXJ/VKAVGV
 PUCnPO3ZU/vDqcjM+5T5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:edEhUVL0wyQ=:wewCERMKv2NNO2jcejQtmU
 x3/QE01B2ORMe7YwZgm24Niqzur6IH/BJ/OmgdyqqtAToWyrIH8SbmgnvcsQLPd8DXrphcisq
 FumB6hQXtfrI6C4pDYmm2hy66TiSdJI5bbZSBliATI3gdXevvVijYKQgJVY2+kVU8sd7k/4fx
 Pigo6KKoC7Mbf1jp9jXvuvzdZEU1KveJZieOsrCXKmKCVLMI/KcXQY7yYx+98gd1VM+w22zI+
 iUjrSvpl7VG6x14Q2nIC5yT8r5l8r+zS2pPNRqrw02ZV/bweNuhYe+Bkj+iRWCzUYx79wx9Ve
 y8i/RqwnsVU31uiiEamBapnDi48o7UwyWbYiKOlqxgikBiu6HnhBVoGAYB3396Cosi4NswXSq
 x3jknsBCcyUxvWzUgNgiFeXNhbMjm10geG3pa4o9dNR+rEnWmoqrP9XhtvV+QRy2wfVWxNgdC
 27jsbohen1b6EXIkVXAKxnNUeJ6KFd2mJ43C7FZnp97s3pRgZm9mYtg7sEq0ihS+JLCJxxFOX
 1AJiNhR2YoyHdrFVjA4aiCRLr7XDLxc7+aOLVH++LdEOXvvNpVgdZMl0VytG9U7t2P8rzLdf2
 zKHWl09wj7OmUSYooVv3hHklhAJzhsqzmUKxySaNbPkNR/V3SOlLyLvpxVbXAGHyjjLWrVPvJ
 GGW9uavz/UlKu4aXA8XcMbX6pdIg2h7cWX1ER90LiG4W6GV/OE3YBYRiT+v15ZbD+0zanicY8
 VXnRTBpbhc2TN/bc31DO7n42cMoLmUX0iiGUKfg8sLW1x5ywGljwx+JktIYiaWPrfmWKFmTAs
 0cInQDF7YucCMgZZAw3bb5BG+Z8VA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 26. Oktober 2022, 18:13:02 CEST schrieb Andrew Davis:
> The Nspire boardfile platform drivers have all been converted. None
> of the definitions in this header are used anymore. Remove it.
> 
> While here lets remove all the other unused headers and the file
> name from in the file itself.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Builds and runs fine here, thanks!

Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>

> ---
>  arch/arm/mach-nspire/mmio.h   | 13 -------------
>  arch/arm/mach-nspire/nspire.c | 14 --------------
>  2 files changed, 27 deletions(-)
>  delete mode 100644 arch/arm/mach-nspire/mmio.h
> 
> diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
> deleted file mode 100644
> index 2ce0656139ec..000000000000
> --- a/arch/arm/mach-nspire/mmio.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *	linux/arch/arm/mach-nspire/mmio.h
> - *
> - *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
> - */
> -
> -#define NSPIRE_PWR_PHYS_BASE		0x900B0000
> -#define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
> -#define NSPIRE_PWR_BUS_DISABLE1		0x18
> -#define NSPIRE_PWR_BUS_DISABLE2		0x20
> -
> -#define NSPIRE_LCD_PHYS_BASE		0xC0000000
> diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
> index 1e13337972dd..2fbfc23237ff 100644
> --- a/arch/arm/mach-nspire/nspire.c
> +++ b/arch/arm/mach-nspire/nspire.c
> @@ -1,23 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - *	linux/arch/arm/mach-nspire/nspire.c
> - *
>   *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
>   */
> -#include <linux/init.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_address.h>
> -#include <linux/of_platform.h>
> -#include <linux/irqchip.h>
> -#include <linux/irqchip/arm-vic.h>
> -#include <linux/clkdev.h>
> -#include <linux/amba/bus.h>
>  
>  #include <asm/mach/arch.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/map.h>
> -
> -#include "mmio.h"
>  
>  static const char *const nspire_dt_match[] __initconst = {
>  	"ti,nspire",
> 




