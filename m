Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246EC60E782
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbiJZSg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 14:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbiJZSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 14:36:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2816A50EA;
        Wed, 26 Oct 2022 11:36:20 -0700 (PDT)
Received: from fabians-envy.localnet ([84.167.206.69]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNso2-1oPT6s04Pw-00OFWf; Wed, 26 Oct 2022 20:35:58 +0200
From:   Fabian Vogt <fabian@ritter-vogt.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: nspire: Use syscon-reboot to handle restart
Date:   Wed, 26 Oct 2022 20:35:52 +0200
Message-ID: <4750364.GXAFRqVoOG@fabians-envy>
In-Reply-To: <20221026161302.5319-2-afd@ti.com>
References: <20221026161302.5319-1-afd@ti.com> <20221026161302.5319-2-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"
X-Provags-ID: V03:K1:hLePCTnLfGCqdPeOJbHL/d/IYxK0n7hZ4Rjwu0vVpkB6KS8ePho
 f0YuVo702j3Il5Ygms5NROXe30Zi6C9Lv7dCAJjM5RwqCAf/RbZNKM5Yn1vAuEsyHUdXJm2
 X6I/Twr9flRSh+weOGsTIvJRW9/Bq4vnhO/3kv2HPt8fHjZ3h1rIS8zehC6uqQpgv9urJcz
 cuo6hgoE2i97P31dPR3Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+7iQcA1o5M=:5Lwg2tg18+FQ0mfQop7/yN
 YZvt44e9rJQezCUlVkL/YW45SKHRYdAeKzbLhC9DHetsRU/WOPClb1eEvTnuDx+0C8MPTNUZ+
 9ZKi5odJtSNrZY9vs559SHwfz+vb8Z0ujxLVm0zjT5s2ME5mUa+P2fuOGLcFwui+Gy/VZGM4P
 LzFBYNtDR0OFGpc2XJbsrSh+2IPcQbQtPL0gjzrpoKfOmfp+0jowdmhHYJn94OqFu6cc50a/9
 QfWdAGdfW3gyVZ73gKTW1tHuaUiJIumQjN2/EdUKvNw4ipIH7pFiPA8wM0a8oAhVdUjXHxAJU
 JGMQFKFb3bX/ErtKhoZTebyJktGaUdoVmB13rByOaokSd98Y+eZELO0chzu2j0pVbyT/iRZbc
 ebsaofaSF77QQNinf/QBoj3TvyBoa2K3MQepJgbLfHAVEmLyoAJ2+GLG3GKwatKY8wgcA3QmH
 5o3ez/FTTvnYKpXK6hBW9kgyJjJni6U4hpEPxMsvRBsUEDeKQUXl9+NAClu6DqzQ3PM/7nCd+
 WINiQE9k7KJZ2R/KxxuZNHEekYjWeirHH4gHzfjgogUk+TykF6TRlDXLl1lLpRfd82fktOeuR
 EKxB8U8NAonBl+Yg8AGmMtEktpYFrz/1KfNlesFFy5ep71hguM2QEgI++ujVPhAULDCWLv3wV
 ls6AOaHlcy4uWzt02XrALwaEVcNYWHd0LBH9MA9NSIuQk7u5WnwCeFxEeporvjRgab3q58R3G
 nizrhfM6TaXlWFLGnG8/HnKaFQyV5b0WLGtd5czrsK0lW0gJ+Fgxe91hi+4PAlivXnLlToqW2
 aGhBVAL+bbVzB3YyBvTa+G4VwlWtA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 26. Oktober 2022, 18:13:01 CEST schrieb Andrew Davis:
> Writing this bit can be handled by the syscon-reboot driver. Add the
> info to DT and remove the machine_desc version.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

finally got this to run on real HW after reverting to an older .config
and refreshing options. Rebooting works fine here. Thanks a lot!

Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>

> ---
>  arch/arm/boot/dts/nspire.dtsi |  7 +++++++
>  arch/arm/mach-nspire/Kconfig  |  2 ++
>  arch/arm/mach-nspire/mmio.h   |  3 ---
>  arch/arm/mach-nspire/nspire.c | 10 ----------
>  4 files changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
> index bb240e6a3a6f..6357b803521e 100644
> --- a/arch/arm/boot/dts/nspire.dtsi
> +++ b/arch/arm/boot/dts/nspire.dtsi
> @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
>  			};
>  
>  			misc: misc@900a0000 {
> +				compatible = "syscon", "simple-mfd";
>  				reg = <0x900a0000 0x1000>;
> +
> +				reboot {
> +					compatible = "syscon-reboot";
> +					offset = <0x08>;
> +					value = <0x02>;
> +				};
>  			};
>  
>  			pwr: pwr@900b0000 {
> diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
> index b7a3871876d7..0ffdcaca1e6b 100644
> --- a/arch/arm/mach-nspire/Kconfig
> +++ b/arch/arm/mach-nspire/Kconfig
> @@ -9,5 +9,7 @@ config ARCH_NSPIRE
>  	select ARM_VIC
>  	select ARM_TIMER_SP804
>  	select NSPIRE_TIMER
> +	select POWER_RESET
> +	select POWER_RESET_SYSCON
>  	help
>  	  This enables support for systems using the TI-NSPIRE CPU
> diff --git a/arch/arm/mach-nspire/mmio.h b/arch/arm/mach-nspire/mmio.h
> index 48e32f13f311..2ce0656139ec 100644
> --- a/arch/arm/mach-nspire/mmio.h
> +++ b/arch/arm/mach-nspire/mmio.h
> @@ -5,9 +5,6 @@
>   *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
>   */
>  
> -#define NSPIRE_MISC_PHYS_BASE		0x900A0000
> -#define NSPIRE_MISC_HWRESET		0x08
> -
>  #define NSPIRE_PWR_PHYS_BASE		0x900B0000
>  #define NSPIRE_PWR_VIRT_BASE		0xFEEB0000
>  #define NSPIRE_PWR_BUS_DISABLE1		0x18
> diff --git a/arch/arm/mach-nspire/nspire.c b/arch/arm/mach-nspire/nspire.c
> index 2d4abb0288b9..1e13337972dd 100644
> --- a/arch/arm/mach-nspire/nspire.c
> +++ b/arch/arm/mach-nspire/nspire.c
> @@ -27,16 +27,6 @@ static const char *const nspire_dt_match[] __initconst = {
>  	NULL,
>  };
>  
> -static void nspire_restart(enum reboot_mode mode, const char *cmd)
> -{
> -	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
> -	if (!base)
> -		return;
> -
> -	writel(2, base + NSPIRE_MISC_HWRESET);
> -}
> -
>  DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
>  	.dt_compat	= nspire_dt_match,
> -	.restart	= nspire_restart,
>  MACHINE_END


