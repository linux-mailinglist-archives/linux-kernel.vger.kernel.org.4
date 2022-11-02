Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977A36170AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 23:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiKBWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 18:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:30:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DC959B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 15:30:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id cl5so241116wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9n8sGvPP+TowhsrDlUS2g6QOItwoCJK1HaaC6LkI2GU=;
        b=FMMjLZ+C7Rp3e7iSbVu8nPmQVwj2Cc7utbq+XfsCt510oX3wKH2qnlWHkk/+e9x/iA
         9V3bgRP9NcoaG8Scejt24CR1JayfCg6AiGUTZDMXveiqaEQbyReE7VRZkWkX6DCYV/wo
         zlCnFElE9GwRqkeW3xl8sltNXBldPG3DQ/D6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n8sGvPP+TowhsrDlUS2g6QOItwoCJK1HaaC6LkI2GU=;
        b=juQYA56vp/tNZNd3617WW2+Xrw4oo4mdiocQVRMmgzxqTW8aw6zjHtGudpBtBwLDpW
         F4b0kJjNnVX3ppIiKvMnjCvdZ6sBEgPMMngeCHGJoGDU/dVNSzH/UvV4ex3nOk7z/TsP
         vkgNFl7seAUTWCHhDr2+Dlw3sOlTSHkwF0djZwFLrSdG9QGlfSQYhF4qKYNmfs+SalY9
         /EvVQUqUZ3xdojBT6v3kDluKRB+7pKQ0kGrGvOtygUhyRIrGFXdPGKuyzUu2Ncqb8dNN
         cHYP7Md6qi1MFV2ZqO/oGp+dFSlLeAxaC0rR7pBSiiePKwkyNFwLd1+g3D3A6YYyTpJC
         6bUw==
X-Gm-Message-State: ACrzQf31SouclHnUA9CuitFKQNa6loQC8IyjPLbdPgcVJuAnGggoQQoS
        mjS8Cj5loh5iB2gSzRsbmLFEXbGAWTi6bBNZrvk=
X-Google-Smtp-Source: AMsMyM5BGRj2h7Q+N0lt+Hxwo83HYrV7eJPioCZTLE4SVROAdq8OB5aMDR3mnELajFnnkxm52KdjOvKqntq2k8x3mZk=
X-Received: by 2002:adf:e19e:0:b0:22e:64de:39fa with SMTP id
 az30-20020adfe19e000000b0022e64de39famr16147629wrb.369.1667428210957; Wed, 02
 Nov 2022 15:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20221101112134.673869-1-j.neuschaefer@gmx.net>
In-Reply-To: <20221101112134.673869-1-j.neuschaefer@gmx.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 2 Nov 2022 22:29:58 +0000
Message-ID: <CACPK8XfnRExua7ZhyAkMNUNwUtmcXrBL3phf9ZMCzpBMN452hw@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: Add wpcm450_defconfig for Nuvoton WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 11:22, Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.ne=
t> wrote:
>
> This defconfig aims to offer a reasonable set of defaults for all
> systems running on a Nuvoton WPCM450 chip.

I was going to ask if we could instead have a common nuvoton
defconfig, but this is an ARMv5 part so we can't also select the ARMv7
npcm750.

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
> v3:
> - Regenerate for 6.1-rc1 and enable a few Nuvoton-specific options as
>   well as the PECI subsystem
>
> v2:
> - Regenerate for 5.19-rc1
> ---
>  MAINTAINERS                        |   1 +
>  arch/arm/configs/wpcm450_defconfig | 213 +++++++++++++++++++++++++++++
>  2 files changed, 214 insertions(+)
>  create mode 100644 arch/arm/configs/wpcm450_defconfig
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f185023724..cac5a4ad4eb8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2543,6 +2543,7 @@ S:        Maintained
>  W:     https://github.com/neuschaefer/wpcm450/wiki
>  F:     Documentation/devicetree/bindings/*/*wpcm*
>  F:     arch/arm/boot/dts/nuvoton-wpcm450*
> +F:     arch/arm/configs/wpcm450_defconfig
>  F:     arch/arm/mach-npcm/wpcm450.c
>  F:     drivers/*/*/*wpcm*
>  F:     drivers/*/*wpcm*
> diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm45=
0_defconfig
> new file mode 100644
> index 0000000000000..702f2bf909f93
> --- /dev/null
> +++ b/arch/arm/configs/wpcm450_defconfig
> @@ -0,0 +1,213 @@
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_NO_HZ_IDLE=3Dy
> +CONFIG_HIGH_RES_TIMERS=3Dy
> +CONFIG_PREEMPT=3Dy
> +CONFIG_IKCONFIG=3Dy
> +CONFIG_IKCONFIG_PROC=3Dy
> +CONFIG_LOG_BUF_SHIFT=3D19
> +CONFIG_CGROUPS=3Dy
> +CONFIG_BLK_DEV_INITRD=3Dy
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy
> +CONFIG_PROFILING=3Dy
> +# CONFIG_ARCH_MULTI_V7 is not set
> +CONFIG_ARCH_NPCM=3Dy
> +CONFIG_ARCH_WPCM450=3Dy
> +CONFIG_CPU_DCACHE_WRITETHROUGH=3Dy
> +CONFIG_AEABI=3Dy
> +CONFIG_UACCESS_WITH_MEMCPY=3Dy
> +# CONFIG_ATAGS is not set
> +CONFIG_ARM_APPENDED_DTB=3Dy

Do you use this? OpenBMC systems tend to just use FIT, so we don't
need this option.

> +CONFIG_KEXEC=3Dy
> +CONFIG_CPU_FREQ=3Dy

Does the wpcm do frequency scaling? If not you could disable this.

> +CONFIG_CPU_FREQ_STAT=3Dy
> +CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> +CONFIG_CPU_IDLE=3Dy
> +CONFIG_KPROBES=3Dy
> +CONFIG_JUMP_LABEL=3Dy
> +CONFIG_STRICT_KERNEL_RWX=3Dy
> +CONFIG_MODULES=3Dy
> +CONFIG_MODULE_UNLOAD=3Dy
> +CONFIG_NET=3Dy
> +CONFIG_PACKET=3Dy
> +CONFIG_PACKET_DIAG=3Dy
> +CONFIG_UNIX=3Dy
> +CONFIG_UNIX_DIAG=3Dy
> +CONFIG_INET=3Dy
> +CONFIG_IP_MULTICAST=3Dy
> +CONFIG_IP_PNP=3Dy
> +CONFIG_IP_PNP_DHCP=3Dy
> +CONFIG_IP_PNP_BOOTP=3Dy
> +CONFIG_NET_DSA=3Dy
> +CONFIG_NET_DSA_TAG_DSA=3Dy
> +CONFIG_NET_DSA_TAG_EDSA=3Dy
> +CONFIG_NET_DSA_TAG_TRAILER=3Dy
> +CONFIG_NET_PKTGEN=3Dm
> +# CONFIG_WIRELESS is not set
> +CONFIG_DEVTMPFS=3Dy
> +CONFIG_DEVTMPFS_MOUNT=3Dy
> +CONFIG_MTD=3Dy
> +CONFIG_MTD_CMDLINE_PARTS=3Dy
> +CONFIG_MTD_BLOCK=3Dy
> +CONFIG_MTD_SPI_NOR=3Dy
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_FASTMAP=3Dy
> +CONFIG_MTD_UBI_BLOCK=3Dy
> +CONFIG_BLK_DEV_LOOP=3Dy
> +CONFIG_SRAM=3Dy
> +CONFIG_EEPROM_AT24=3Dy
> +CONFIG_SCSI=3Dy
> +# CONFIG_SCSI_PROC_FS is not set
> +# CONFIG_SCSI_LOWLEVEL is not set
> +CONFIG_NETDEVICES=3Dy
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_AQUANTIA is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_CADENCE is not set
> +# CONFIG_NET_VENDOR_CAVIUM is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
> +# CONFIG_NET_VENDOR_CORTINA is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_FARADAY is not set
> +# CONFIG_NET_VENDOR_GOOGLE is not set
> +# CONFIG_NET_VENDOR_HISILICON is not set
> +# CONFIG_NET_VENDOR_HUAWEI is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MELLANOX is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_MICROCHIP is not set
> +# CONFIG_NET_VENDOR_MICROSEMI is not set
> +# CONFIG_NET_VENDOR_NI is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_PENSANDO is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_SOCIONEXT is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_SYNOPSYS is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_XILINX is not set
> +CONFIG_REALTEK_PHY=3Dy
> +# CONFIG_WLAN is not set
> +CONFIG_INPUT_FF_MEMLESS=3Dy
> +CONFIG_INPUT_EVDEV=3Dy
> +CONFIG_KEYBOARD_QT1070=3Dm
> +CONFIG_KEYBOARD_GPIO=3Dy
> +# CONFIG_INPUT_MOUSE is not set
> +CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> +CONFIG_LEGACY_PTY_COUNT=3D16
> +CONFIG_SERIAL_8250=3Dy
> +CONFIG_SERIAL_8250_CONSOLE=3Dy
> +CONFIG_SERIAL_8250_NR_UARTS=3D6
> +CONFIG_SERIAL_8250_RUNTIME_UARTS=3D6
> +CONFIG_SERIAL_8250_EXTENDED=3Dy
> +CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> +CONFIG_SERIAL_OF_PLATFORM=3Dy
> +CONFIG_NPCM7XX_KCS_IPMI_BMC=3Dy
> +CONFIG_IPMI_KCS_BMC_CDEV_IPMI=3Dy
> +CONFIG_IPMI_KCS_BMC_SERIO=3Dy
> +CONFIG_HW_RANDOM=3Dy
> +# CONFIG_HW_RANDOM_NPCM is not set
> +CONFIG_I2C=3Dy
> +# CONFIG_I2C_COMPAT is not set
> +CONFIG_I2C_CHARDEV=3Dy
> +CONFIG_I2C_MUX=3Dy
> +CONFIG_I2C_NPCM=3Dy
> +CONFIG_SPI=3Dy
> +CONFIG_SPI_NPCM_PSPI=3Dy
> +CONFIG_PINCTRL_SINGLE=3Dy
> +CONFIG_PINCTRL_WPCM450=3Dy
> +CONFIG_POWER_SUPPLY=3Dy
> +CONFIG_SENSORS_NPCM7XX=3Dy
> +# CONFIG_THERMAL is not set
> +CONFIG_WATCHDOG=3Dy
> +CONFIG_NPCM7XX_WATCHDOG=3Dy
> +CONFIG_MFD_SYSCON=3Dy
> +CONFIG_REGULATOR=3Dy
> +CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> +CONFIG_FB=3Dy
> +CONFIG_FB_MODE_HELPERS=3Dy
> +# CONFIG_HID is not set
> +CONFIG_USB_CHIPIDEA=3Dy
> +CONFIG_USB_CHIPIDEA_UDC=3Dy
> +CONFIG_USB_GADGET=3Dy
> +CONFIG_USB_CONFIGFS=3Dy
> +CONFIG_USB_CONFIGFS_SERIAL=3Dy
> +CONFIG_USB_CONFIGFS_ACM=3Dy
> +CONFIG_USB_CONFIGFS_EEM=3Dy
> +CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> +CONFIG_USB_CONFIGFS_F_FS=3Dy
> +CONFIG_USB_CONFIGFS_F_HID=3Dy
> +CONFIG_NEW_LEDS=3Dy
> +CONFIG_LEDS_CLASS=3Dy
> +CONFIG_LEDS_GPIO=3Dy
> +CONFIG_LEDS_TRIGGERS=3Dy
> +CONFIG_LEDS_TRIGGER_TIMER=3Dy
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dy
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dy
> +CONFIG_DMADEVICES=3Dy
> +CONFIG_SYNC_FILE=3Dy
> +# CONFIG_VIRTIO_MENU is not set
> +# CONFIG_VHOST_MENU is not set
> +CONFIG_STAGING=3Dy
> +# CONFIG_IOMMU_SUPPORT is not set
> +CONFIG_PWM=3Dy
> +CONFIG_GENERIC_PHY=3Dy
> +CONFIG_PECI=3Dy
> +CONFIG_PECI_CPU=3Dy
> +CONFIG_MSDOS_FS=3Dy
> +CONFIG_VFAT_FS=3Dy
> +CONFIG_TMPFS=3Dy
> +CONFIG_UBIFS_FS=3Dy
> +CONFIG_SQUASHFS=3Dy
> +CONFIG_SQUASHFS_XZ=3Dy
> +CONFIG_SQUASHFS_ZSTD=3Dy
> +# CONFIG_NETWORK_FILESYSTEMS is not set
> +CONFIG_NLS_CODEPAGE_437=3Dy
> +CONFIG_NLS_CODEPAGE_850=3Dy
> +CONFIG_NLS_ISO8859_1=3Dy
> +CONFIG_NLS_ISO8859_2=3Dy
> +CONFIG_NLS_UTF8=3Dy
> +CONFIG_KEYS=3Dy
> +CONFIG_HARDENED_USERCOPY=3Dy
> +CONFIG_FORTIFY_SOURCE=3Dy
> +CONFIG_CRYPTO_RSA=3Dy
> +CONFIG_CRYPTO_AES=3Dy
> +CONFIG_CRYPTO_CBC=3Dm
> +CONFIG_CRYPTO_PCBC=3Dm
> +CONFIG_CRYPTO_CCM=3Dy
> +CONFIG_CRYPTO_GCM=3Dy
> +CONFIG_CRYPTO_CMAC=3Dy
> +CONFIG_CRYPTO_SHA256=3Dy
> +CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> +CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> +CONFIG_X509_CERTIFICATE_PARSER=3Dy
> +CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> +CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> +CONFIG_CRC_CCITT=3Dy
> +CONFIG_CRC_ITU_T=3Dm
> +CONFIG_LIBCRC32C=3Dy
> +CONFIG_PRINTK_TIME=3Dy
> +CONFIG_DEBUG_KERNEL=3Dy
> +CONFIG_MAGIC_SYSRQ=3Dy
> +CONFIG_DEBUG_FS=3Dy
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_DEBUG_PREEMPT is not set
> +# CONFIG_FTRACE is not set
> +CONFIG_IO_STRICT_DEVMEM=3Dy
> +CONFIG_DEBUG_USER=3Dy
> +CONFIG_DEBUG_LL=3Dy
> +CONFIG_DEBUG_LL_UART_8250=3Dy
> +CONFIG_DEBUG_UART_PHYS=3D0xb8000000
> +CONFIG_DEBUG_UART_VIRT=3D0x0ff000000
> +CONFIG_DEBUG_UART_8250_WORD=3Dy
> +CONFIG_EARLY_PRINTK=3Dy
> --
> 2.35.1
>
