Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54725627858
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiKNI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbiKNI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:59:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A291CFC6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668416381; x=1699952381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4ZUDBICbMDZqlh25FYQGX210sivr3l1viVzgWGRSaEA=;
  b=fEOzzQ1Kkp72KxjPahMPwy/MHwsYvxPUeU84IvgS028rxStQBWE14Pac
   1uAw8nO6WzFI98FeLKhCsuvOJ+gkOe8OavPyFDQk+W3zHkaPRxDaI3vfZ
   L31SFx2d/jW5Y8sAI1yCxdU9sM2E/xt7k2OI/yZPVo93pXCIFayXoovB/
   hifTkHtMfmlDWET5hjBr+UuFbPvG/VB7AqqlomAxS6Ml4CQzCq9EGTfNd
   rVqYxHEQ2QxZ0JorqUbC1RiDvZBaJ0k5XDYbqamagqJAT4RN1UZ9wKOCc
   ofmhlNy4FTbwvWlJ/y7d44C/povIpQsnprsqRg7qyHxFFncrND/BCtahd
   A==;
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="199668596"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Nov 2022 01:59:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 14 Nov 2022 01:59:41 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Mon, 14 Nov 2022 01:59:39 -0700
Message-ID: <4be97a62-4749-c3a3-5401-6e440c24c3f4@microchip.com>
Date:   Mon, 14 Nov 2022 09:59:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/4] MAINTAINERS: add entries for misc. RISC-V SoC
 drivers and devicetrees
To:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <soc@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
References: <20221109212219.1598355-1-conor@kernel.org>
 <20221109212219.1598355-2-conor@kernel.org>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221109212219.1598355-2-conor@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 at 22:22, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Following some discussion both on & off list, I have volunteered to take
> over maintaining the miscellaneous RISC-V devicetrees & soc drivers from
> Palmer to ease his load.
> 
> So far only SiFive and Microchip have stuff in drivers/soc. For the
> former, a SiFive entry exists with a dead GitHub repo - so remove that
> to avoid confusion since the patches for drivers/soc & devicetrees will
> be routed via my tree & other drivers go through their subsystem trees.
> The Microchip directory only contains a RISC-V driver for now, but is
> likely to contain drivers for other archs in the future. To that end,
> change the PolarFire SoC entry to specifically mention the RISC-V driver
> & the new directory level entry does not mention an architecture.
> 
> CC: Arnd Bergmann <arnd@arndb.de>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Conor, best regards,
   Nicolas

> CC: Palmer Dabbelt <palmer@dabbelt.com>
> Link: https://lore.kernel.org/linux-riscv/mhng-e4210f56-fcc3-4db8-abdb-d43b3ebe695d@palmer-ri-x1c9a/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   MAINTAINERS | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 046ff06ff97f..b88ced1ff72c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13627,6 +13627,12 @@ S:     Supported
>   F:     drivers/misc/atmel-ssc.c
>   F:     include/linux/atmel-ssc.h
> 
> +MICROCHIP SOC DRIVERS
> +M:     Conor Dooley <conor@kernel.org>
> +S:     Supported
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:     drivers/soc/microchip/
> +
>   MICROCHIP USB251XB DRIVER
>   M:     Richard Leitner <richard.leitner@skidata.com>
>   L:     linux-usb@vger.kernel.org
> @@ -17749,12 +17755,21 @@ F:    drivers/mailbox/mailbox-mpfs.c
>   F:     drivers/pci/controller/pcie-microchip-host.c
>   F:     drivers/reset/reset-mpfs.c
>   F:     drivers/rtc/rtc-mpfs.c
> -F:     drivers/soc/microchip/
> +F:     drivers/soc/microchip/mpfs-sys-controller.c
>   F:     drivers/spi/spi-microchip-core-qspi.c
>   F:     drivers/spi/spi-microchip-core.c
>   F:     drivers/usb/musb/mpfs.c
>   F:     include/soc/microchip/mpfs.h
> 
> +RISC-V MISC SOC SUPPORT
> +M:     Conor Dooley <conor@kernel.org>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +Q:     https://patchwork.kernel.org/project/linux-riscv/list/
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:     Documentation/devicetree/bindings/riscv/
> +F:     arch/riscv/boot/dts/
> +
>   RNBD BLOCK DRIVERS
>   M:     Md. Haris Iqbal <haris.iqbal@ionos.com>
>   M:     Jack Wang <jinpu.wang@ionos.com>
> @@ -18781,7 +18796,6 @@ M:      Palmer Dabbelt <palmer@dabbelt.com>
>   M:     Paul Walmsley <paul.walmsley@sifive.com>
>   L:     linux-riscv@lists.infradead.org
>   S:     Supported
> -T:     git https://github.com/sifive/riscv-linux.git
>   N:     sifive
>   K:     [^@]sifive
> 
> @@ -18800,6 +18814,13 @@ S:     Maintained
>   F:     Documentation/devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml
>   F:     drivers/dma/sf-pdma/
> 
> +SIFIVE SOC DRIVERS
> +M:     Conor Dooley <conor@kernel.org>
> +L:     linux-riscv@lists.infradead.org
> +S:     Maintained
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
> +F:     drivers/soc/sifive/
> +
>   SILEAD TOUCHSCREEN DRIVER
>   M:     Hans de Goede <hdegoede@redhat.com>
>   L:     linux-input@vger.kernel.org
> --
> 2.37.2
> 

-- 
Nicolas Ferre

