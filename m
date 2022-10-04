Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9125F45BA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJDOjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJDOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:39:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473C661B2E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 07:39:13 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bq9so21651095wrb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 07:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newflow-co-uk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=APkf5QO/iIflSA/eCgx8N6MrlEP4zWezzkSwwaKVCyU=;
        b=DtIcO3HPn7aNTAksB0OgAyHu9TrlJUAa79qJ2w1Ox2OlUAQ2pB9UrUpwxPFRwlBGHE
         GN5SCELa+aLKLnG5FJYxxF+NmamrB9Zlk2e7aHDcObXGB0aYviwLMhwcHMzjxbReODlT
         r8IIoIKZ9mtva7u6Wnd/MrF9DBsUMV/gn4HJpkJZ6YULNqSNV+O0mt3zkUBwJD9jKmTm
         RNM1Zn4emcnTvNFiQFRFmXNvb2v5bqw2663mtqIQYSgmoNFawiLC+Ac+3/y6eyjHi+Vx
         qc8mw+6+/+sm2eD2pZbovHjJJZw4v6lYOzsxdvZBDFy5NkJz3kqybSmLvMdt05tV0Iww
         U2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=APkf5QO/iIflSA/eCgx8N6MrlEP4zWezzkSwwaKVCyU=;
        b=p1H9qsT9FMyCgqJDo9XDZmn7d7S9FevdgmtTy3nlOuGXgedNGSpuAhiYndz1JpIXkH
         s/h4u+y8kHBKxwEWZoePOOKu7GA7g9jqsDEphK/ET3XZQM/8uGmdehx+zJ9Cy7vGFp0D
         tjs42TWVh++xKuyXF1DG5phHgXwST8WZOdlvOcJKnJygdouE4DdOIuPNY3BHyAkqDfHA
         RwCNA5fXVPyV9ZSAY5dgdIhumDUDwV9auH5dXB8ItgV+8AMM6yx7QJ7+xsbAsa8YEg03
         D2hfbuVNn4Vq27VVyq/CgjX5XITuVr49OtDzUr4WzyZs8a3SPvYEDfebuGzruXlUBcI2
         ZS+g==
X-Gm-Message-State: ACrzQf0HvBs8i4uNaqMxL3SDFhMTMxPF049DhhKAJoIbN/1LBEetSggU
        1LAh7/MqKadNqtrHvebOLk3yYvtyvPLaQ3jlN/4=
X-Google-Smtp-Source: AMsMyM7isIdNE9hXBuvE575BEzXIW4bP1bQ8o5B1P/mDDv9Czsfd+sfgz4Gs2ajjo8CXd3tdf1NoCg==
X-Received: by 2002:a5d:64e8:0:b0:22a:bb78:1e44 with SMTP id g8-20020a5d64e8000000b0022abb781e44mr17867360wri.378.1664894351037;
        Tue, 04 Oct 2022 07:39:11 -0700 (PDT)
Received: from mpfj-VirtualBox.. ([94.12.112.226])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003a5c244fc13sm21669306wms.2.2022.10.04.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:39:10 -0700 (PDT)
From:   Mark Jackson <mpfj@newflow.co.uk>
To:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        tony@atomide.com, mpfj@newflow.co.uk
Subject: [PATCH] Update Nanobone
Date:   Tue,  4 Oct 2022 15:39:01 +0100
Message-Id: <20221004143901.130935-1-mpfj@newflow.co.uk>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Nanobone DTS file as follows:-
- Add USB hooks
- Fix GPIO settings for RTS/CTS pins
- Add LM75 hooks
- Fix GPIO settings for MMC pins

Add nanobone_defconfig file.
---
 arch/arm/boot/dts/am335x-nano.dts   |  58 ++++++--
 arch/arm/configs/nanobone_defconfig | 222 ++++++++++++++++++++++++++++
 2 files changed, 268 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/configs/nanobone_defconfig

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index b6f2567bd65a..e387a7b5de9b 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -102,8 +102,8 @@ AM33XX_PADCONF(AM335X_PIN_UART0_TXD, PIN_OUTPUT, MUX_MODE0)
 
 	uart1_pins: uart1_pins {
 		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE7)
-			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT, MUX_MODE7)
+			AM33XX_PADCONF(AM335X_PIN_UART1_CTSN, PIN_OUTPUT, MUX_MODE7)		/* uart1_ctsn.gpio0[12] */
+			AM33XX_PADCONF(AM335X_PIN_UART1_RTSN, PIN_OUTPUT, MUX_MODE7)		/* uart1_rtsn.gpio0[13] */
 			AM33XX_PADCONF(AM335X_PIN_UART1_RXD, PIN_INPUT_PULLUP, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_UART1_TXD, PIN_OUTPUT, MUX_MODE0)
 		>;
@@ -120,17 +120,17 @@ AM33XX_PADCONF(AM335X_PIN_SPI0_D0, PIN_OUTPUT, MUX_MODE1)		/* spi0_d0.uart2_txd
 
 	uart3_pins: uart3_pins {
 		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data10.uart3_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE6)		/* lcd_data11.uart3_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA10, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data10.gpio2[16] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA11, PIN_OUTPUT, MUX_MODE7)		/* lcd_data11.gpio2[17] */
 			AM33XX_PADCONF(AM335X_PIN_SPI0_CS1, PIN_INPUT, MUX_MODE1)		/* spi0_cs1.uart3_rxd */
-			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)		/* ecap0_in_pwm0_out.uart3_txd */
+			AM33XX_PADCONF(AM335X_PIN_ECAP0_IN_PWM0_OUT, PIN_OUTPUT, MUX_MODE1)	/* ecap0_in_pwm0_out.uart3_txd */
 		>;
 	};
 
 	uart4_pins: uart4_pins {
 		pinctrl-single,pins = <
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE6)	/* lcd_data12.uart4_ctsn */
-			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE6)		/* lcd_data13.uart4_rtsn */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA12, PIN_INPUT_PULLUP, MUX_MODE7)	/* lcd_data12.gpio0[8] */
+			AM33XX_PADCONF(AM335X_PIN_LCD_DATA13, PIN_OUTPUT, MUX_MODE7)		/* lcd_data13.gpio0[9] */
 			AM33XX_PADCONF(AM335X_PIN_UART0_CTSN, PIN_INPUT, MUX_MODE1)		/* uart0_ctsn.uart4_rxd */
 			AM33XX_PADCONF(AM335X_PIN_UART0_RTSN, PIN_OUTPUT, MUX_MODE1)		/* uart0_rtsn.uart4_txd */
 		>;
@@ -149,9 +149,9 @@ AM33XX_PADCONF(AM335X_PIN_MMC0_DAT3, PIN_INPUT_PULLUP, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT2, PIN_INPUT_PULLUP, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT1, PIN_INPUT_PULLUP, MUX_MODE0)
 			AM33XX_PADCONF(AM335X_PIN_MMC0_DAT0, PIN_INPUT_PULLUP, MUX_MODE0)
-			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_clk.mmc0_clk */
-			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)	/* mmc0_cmd.mmc0_cmd */
-			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)	/* emu1.gpio3[8] */
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CLK, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_MMC0_CMD, PIN_INPUT_PULLUP, MUX_MODE0)
+			AM33XX_PADCONF(AM335X_PIN_EMU1, PIN_INPUT_PULLUP, MUX_MODE7)		/* emu1.gpio3[8] */
 			AM33XX_PADCONF(AM335X_PIN_MCASP0_ACLKR, PIN_INPUT_PULLUP, MUX_MODE7)	/* mcasp0_aclkr.gpio3[18] */
 		>;
 	};
@@ -188,12 +188,22 @@ &uart3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_pins>;
 	status = "okay";
+	rts-gpio = <&gpio2 17 GPIO_ACTIVE_HIGH>;
+	rs485-rts-active-high;
+	rs485-rx-during-tx;
+	rs485-rts-delay = <1 1>;
+	linux,rs485-enabled-at-boot-time;
 };
 
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
 	status = "okay";
+	rts-gpio = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+	rs485-rts-active-high;
+	rs485-rx-during-tx;
+	rs485-rts-delay = <1 1>;
+	linux,rs485-enabled-at-boot-time;
 };
 
 &uart5 {
@@ -220,6 +230,12 @@ tps: tps@24 {
 		reg = <0x24>;
 	};
 
+	lm75@48 {
+		compatible = "lm75";
+		reg = <0x48>;
+		status = "okay";
+	};
+
 	eeprom@53 {
 		compatible = "microchip,24c02", "atmel,24c02";
 		reg = <0x53>;
@@ -403,8 +419,26 @@ &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <4>;
-	cd-gpios = <&gpio3 8 0>;
-	wp-gpios = <&gpio3 18 0>;
+	cd-debounce-delay-ms = <5>;
+	cd-gpios = <&gpio3 8 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio3 18 GPIO_ACTIVE_HIGH>;
+};
+
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
 };
 
 #include "tps65217.dtsi"
diff --git a/arch/arm/configs/nanobone_defconfig b/arch/arm/configs/nanobone_defconfig
new file mode 100644
index 000000000000..236ce7210013
--- /dev/null
+++ b/arch/arm/configs/nanobone_defconfig
@@ -0,0 +1,222 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_USELIB=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_NAMESPACES=y
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_RD_BZIP2 is not set
+# CONFIG_RD_LZMA is not set
+# CONFIG_RD_XZ is not set
+# CONFIG_RD_LZO is not set
+# CONFIG_RD_LZ4 is not set
+# CONFIG_RD_ZSTD is not set
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_ARCH_OMAP3=y
+CONFIG_SOC_AM33XX=y
+# CONFIG_SOC_OMAP3430 is not set
+CONFIG_ARM_THUMBEE=y
+CONFIG_PL310_ERRATA_588369=y
+CONFIG_PL310_ERRATA_727915=y
+CONFIG_ARM_ERRATA_720789=y
+CONFIG_ARM_ERRATA_814220=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_OABI_COMPAT=y
+# CONFIG_CPU_SW_DOMAIN_PAN is not set
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_ARM_ATAG_DTB_COMPAT=y
+CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
+CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_FPE_NWFPE=y
+# CONFIG_STACKPROTECTOR is not set
+# CONFIG_BLK_DEBUG_FS is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_MQ_IOSCHED_KYBER is not set
+CONFIG_BINFMT_MISC=y
+CONFIG_SLAB=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM_USER=y
+CONFIG_NET_KEY=y
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_INET_DIAG is not set
+# CONFIG_IPV6 is not set
+CONFIG_NET_SWITCHDEV=y
+# CONFIG_WIRELESS is not set
+# CONFIG_ETHTOOL_NETLINK is not set
+CONFIG_UEVENT_HELPER=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_FW_CACHE is not set
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_STAA=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_MTD_PLATRAM=y
+CONFIG_MTD_BLOCK2MTD=y
+CONFIG_MTD_UBI=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_EEPROM_AT24=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ALACRITECH is not set
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ASIX is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_DAVICOM is not set
+# CONFIG_NET_VENDOR_ENGLEDER is not set
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_FUNGIBLE is not set
+# CONFIG_NET_VENDOR_GOOGLE is not set
+# CONFIG_NET_VENDOR_HISILICON is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_WANGXUN is not set
+# CONFIG_NET_VENDOR_LITEX is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MELLANOX is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_MICROCHIP is not set
+# CONFIG_NET_VENDOR_MICROSEMI is not set
+# CONFIG_NET_VENDOR_MICROSOFT is not set
+# CONFIG_NET_VENDOR_NI is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_PENSANDO is not set
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+CONFIG_TI_CPSW=y
+CONFIG_TI_CPSW_SWITCHDEV=y
+# CONFIG_NET_VENDOR_VERTEXCOM is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_SMSC_PHY=y
+# CONFIG_USB_NET_DRIVERS is not set
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_LEDS is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_LDISC_AUTOLOAD is not set
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
+# CONFIG_HW_RANDOM_OMAP3_ROM is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_PTP_1588_CLOCK is not set
+CONFIG_PINCTRL_MCP23S08=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_GENERIC_PLATFORM=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_SENSORS_LM75=y
+CONFIG_WATCHDOG=y
+# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
+CONFIG_OMAP_WATCHDOG=y
+CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_TPS65217=y
+CONFIG_REGULATOR_TPS65217=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_MON=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_OMAP2PLUS=y
+CONFIG_USB_MUSB_DSPS=y
+CONFIG_USB_TI_CPPI41_DMA=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_AM335X_PHY_USB=y
+CONFIG_MMC=y
+# CONFIG_PWRSEQ_EMMC is not set
+# CONFIG_PWRSEQ_SIMPLE is not set
+CONFIG_SDIO_UART=y
+CONFIG_MMC_DEBUG=y
+CONFIG_MMC_OMAP_HS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_RTC_CLASS=y
+# CONFIG_RTC_NVMEM is not set
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_DMADEVICES=y
+# CONFIG_VIRTIO_MENU is not set
+# CONFIG_VHOST_MENU is not set
+# CONFIG_COMMON_CLK_TI_ADPLL is not set
+CONFIG_HWSPINLOCK=y
+CONFIG_HWSPINLOCK_OMAP=y
+# CONFIG_ARM_ARCH_TIMER_EVTSTREAM is not set
+# CONFIG_ARM_PMU is not set
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_EXFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_JFFS2_FS=y
+# CONFIG_JFFS2_FS_WRITEBUFFER is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RUBIN=y
+CONFIG_JFFS2_CMODE_NONE=y
+CONFIG_UBIFS_FS=y
+CONFIG_UBIFS_FS_ADVANCED_COMPR=y
+# CONFIG_UBIFS_FS_ZLIB is not set
+# CONFIG_UBIFS_FS_ZSTD is not set
+# CONFIG_UBIFS_FS_XATTR is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_KEYS=y
+CONFIG_SECURITY=y
+# CONFIG_INTEGRITY is not set
+CONFIG_LSM="yama,loadpin,safesetid,integrity"
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
+CONFIG_CRYPTO_DEV_OMAP=y
+CONFIG_CRYPTO_DEV_OMAP_SHAM=y
+CONFIG_CRYPTO_DEV_OMAP_AES=y
+CONFIG_CRYPTO_DEV_OMAP_DES=y
+CONFIG_CRC_CCITT=y
+CONFIG_CRC_T10DIF=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC7=y
+CONFIG_LIBCRC32C=y
+CONFIG_PRINTK_TIME=y
+# CONFIG_SYMBOLIC_ERRNAME is not set
+CONFIG_DEBUG_FS=y
+CONFIG_STACKTRACE=y
+# CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
-- 
2.34.1

