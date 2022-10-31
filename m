Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFC06139DE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJaPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaPSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5B11441;
        Mon, 31 Oct 2022 08:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 251DD612B8;
        Mon, 31 Oct 2022 15:18:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B25EC433C1;
        Mon, 31 Oct 2022 15:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667229490;
        bh=fZQmE3ZoLyvvFn4DphHE7oXQ3j9AI9iK/6owWdIRsas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gJ+6M32c1NzKowboPOTlB8AjQ6s07iNwFn6R0waqYwLB63R+1+vqwRWCBFirJxe6k
         Gt/cYH3BTnDAp0fJ3l/bOSeEYjjQAR1XAH6HOXmT59zDOFpLJ12UddsWOELBUSmMxA
         R2yxrso2Vp2w0UDcSvijat+eS5aG+RdZQKXmLHiw4euF7z+rvfbGN6fa7m9H0hNizi
         oAhgIPLoO/wGcA5MrxrRdkImiY5S60bQT5WV+bOZh9/Mx67HCp7Jh8I8Z9lSG+NSSJ
         fNzfD4bcJhAm9kSwgFF/PedYUobZ/Hw9dQE31LYyJzxguFzoKkfV35LzKH5htLRlIP
         RklF91F9P9Wyw==
Date:   Mon, 31 Oct 2022 15:18:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Chubb <peter.chubb@unsw.edu.au>,
        Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 02/11] ARM: sa1100: remove unused board files
Message-ID: <Y1/nK0kLURkyel2n@google.com>
References: <20221021155000.4108406-1-arnd@kernel.org>
 <20221021155000.4108406-3-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221021155000.4108406-3-arnd@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The Cerf, H3100, Badge4, Hackkit, LART, NanoEngine, PLEB, Shannon and
> Simpad machines were all marked as unused as there are no known users
> left. Remove all of these, along with references to them in defconfig
> files and drivers.
> 
> Four machines remain now: Assabet, Collie (Zaurus SL5500), iPAQ H3600
> and Jornada 720, each of which had one person still using them, with
> Collie also being supported in Qemu.
> 
> Cc: Peter Chubb <peter.chubb@unsw.edu.au>
> Cc: Stefan Eletzhofer <stefan.eletzhofer@eletztrick.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  MAINTAINERS                                   |  11 -
>  arch/arm/Kconfig                              |   6 -
>  arch/arm/boot/compressed/head-sa1100.S        |   4 -
>  arch/arm/configs/badge4_defconfig             | 105 -----
>  arch/arm/configs/cerfcube_defconfig           |  73 ---
>  arch/arm/configs/hackkit_defconfig            |  48 --
>  arch/arm/configs/lart_defconfig               |  64 ---
>  arch/arm/configs/pleb_defconfig               |  53 ---
>  arch/arm/configs/shannon_defconfig            |  45 --
>  arch/arm/configs/simpad_defconfig             | 100 -----
>  arch/arm/mach-sa1100/Kconfig                  | 111 -----
>  arch/arm/mach-sa1100/Makefile                 |  21 -
>  arch/arm/mach-sa1100/badge4.c                 | 338 --------------
>  arch/arm/mach-sa1100/cerf.c                   | 181 --------
>  arch/arm/mach-sa1100/h3100.c                  | 140 ------
>  arch/arm/mach-sa1100/hackkit.c                | 184 --------
>  arch/arm/mach-sa1100/include/mach/badge4.h    |  71 ---
>  arch/arm/mach-sa1100/include/mach/cerf.h      |  20 -
>  .../arm/mach-sa1100/include/mach/nanoengine.h |  48 --
>  arch/arm/mach-sa1100/include/mach/shannon.h   |  40 --
>  arch/arm/mach-sa1100/include/mach/simpad.h    | 159 -------
>  arch/arm/mach-sa1100/lart.c                   | 177 --------
>  arch/arm/mach-sa1100/nanoengine.c             | 136 ------
>  arch/arm/mach-sa1100/pci-nanoengine.c         | 191 --------
>  arch/arm/mach-sa1100/pleb.c                   | 148 ------
>  arch/arm/mach-sa1100/shannon.c                | 157 -------
>  arch/arm/mach-sa1100/simpad.c                 | 423 ------------------
>  drivers/cpufreq/sa1110-cpufreq.c              |   6 -
>  drivers/mfd/Kconfig                           |   2 +-

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/pcmcia/sa1100_generic.c               |   5 +-
>  drivers/pcmcia/sa1100_h3600.c                 |   2 +-
>  drivers/pcmcia/sa1111_generic.c               |   4 -
>  drivers/usb/host/ohci-sa1111.c                |   5 +-
>  drivers/video/fbdev/sa1100fb.c                |   1 -
>  34 files changed, 4 insertions(+), 3075 deletions(-)
>  delete mode 100644 arch/arm/configs/badge4_defconfig
>  delete mode 100644 arch/arm/configs/cerfcube_defconfig
>  delete mode 100644 arch/arm/configs/hackkit_defconfig
>  delete mode 100644 arch/arm/configs/lart_defconfig
>  delete mode 100644 arch/arm/configs/pleb_defconfig
>  delete mode 100644 arch/arm/configs/shannon_defconfig
>  delete mode 100644 arch/arm/configs/simpad_defconfig
>  delete mode 100644 arch/arm/mach-sa1100/badge4.c
>  delete mode 100644 arch/arm/mach-sa1100/cerf.c
>  delete mode 100644 arch/arm/mach-sa1100/h3100.c
>  delete mode 100644 arch/arm/mach-sa1100/hackkit.c
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/badge4.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/cerf.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/nanoengine.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/shannon.h
>  delete mode 100644 arch/arm/mach-sa1100/include/mach/simpad.h
>  delete mode 100644 arch/arm/mach-sa1100/lart.c
>  delete mode 100644 arch/arm/mach-sa1100/nanoengine.c
>  delete mode 100644 arch/arm/mach-sa1100/pci-nanoengine.c
>  delete mode 100644 arch/arm/mach-sa1100/pleb.c
>  delete mode 100644 arch/arm/mach-sa1100/shannon.c
>  delete mode 100644 arch/arm/mach-sa1100/simpad.c

-- 
Lee Jones [李琼斯]
