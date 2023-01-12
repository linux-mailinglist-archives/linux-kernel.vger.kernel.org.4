Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342DE666FDD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237609AbjALKjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239872AbjALKin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:38:43 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF5559FE;
        Thu, 12 Jan 2023 02:32:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2311F5C018C;
        Thu, 12 Jan 2023 05:32:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 12 Jan 2023 05:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673519551; x=1673605951; bh=Y5ROO4oU/i
        Cq1rmDWeAvlP4LVr/mZczqwKvJWOs188A=; b=NgkwTvF8tLl8p1e1bGn0e3DnQ7
        71EprNW0FXxc2/Rp4Pt53MlPeQNvDXOXppx2eeLUgQafglbuGUnKcSK129c+Ktej
        EwjtACoZ73JWqk3F2CNHSkARPlIZMXLljEodAJFtaQi8n8CQLBsQezIUcasdCTL6
        1+nVk36Mg3+AwJgg9ruarFlUHhvc5OXHTYoPVinN1jSRCvzSTZryew+WyDWXfRPg
        BPHWkSkaAYDbwckRkj2v5jf0pGVqQjd3OWeXIpPFVDVdt9HAbksS/vEdx3j+3ex+
        Y//ni5GaS9rrrYVWgn3VDVJwhGm58fZsd5a5RgkN2fsYLPcUPu1SX2zfA7nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673519551; x=1673605951; bh=Y5ROO4oU/iCq1rmDWeAvlP4LVr/m
        ZczqwKvJWOs188A=; b=Pp/MlCBFYh/u6cvDAlFJFvNlS2qOPCDCJgCTytpL9uQU
        rMBk8UkgDqsg1GhKSnWvFNgegCGnREQd4rk3ugLebuau2GADatSfItbP7+7XqSOe
        vY1ILkVvEhGXrWxedurxf3gc7keo1Wps+iBheYDdnws/JT41CN4s0ePLJn2ZYcmN
        L0x64/X5t3uVuCwBO4HKdSqk0aYMW+8HbqozbclNOonEzunYRrTwHjRdzTIdQsdx
        BuIGZ/dl2r7JUcH7BOGroMQGqYyd00sY8+uZ2fYgstrFyLlbU7lTUb3CvQ2RPwiw
        qCiouInMlHiWW0/4wwwdbfkuPgoM7Ph7cp03nzO1qg==
X-ME-Sender: <xms:vuG_Y4mHvT9lma42jY4RNZRBPwnUDMRP9MdDu2Hto3o9gYi9RxxQJg>
    <xme:vuG_Y33nuXMLn4YEUbGyztMIcnyi5XR6uFhB4rZ-2fHrA0-Tj2Ue3Mafhv5mt3MGq
    h_GXChOpHyJbUTPvLE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleeigdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vuG_Y2o2vhDaX-hj1vU0hU7i6V2ngzxZetbzBaTmY5NaTDx4YO2MrA>
    <xmx:vuG_Y0nTe2AgHlkh-yfUMt_2iOba8EBO707CdBLQMkqEDFD7kuBQtg>
    <xmx:vuG_Y21QHKaIBYwyevJXSrkw-HfBqTmYLBwQiwdNncXovSeyta7VJw>
    <xmx:v-G_Y3KNb1xnAHzrPRZg8YnHOAyTajGssE_2t4oX5dvCOOk6OAmOXA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6637FB60086; Thu, 12 Jan 2023 05:32:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <4d1cb068-3e0f-440c-892c-8c7609f714ea@app.fastmail.com>
In-Reply-To: <CAKXUXMzRk1aK-_kELB7dZXAS711HuiF4TGaf_BgDK=dhY=iyVQ@mail.gmail.com>
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-3-lukas.bulwahn@gmail.com>
 <4d2f2b81-b7ab-4ad6-84cc-f3a3c932880d@app.fastmail.com>
 <CAKXUXMzRk1aK-_kELB7dZXAS711HuiF4TGaf_BgDK=dhY=iyVQ@mail.gmail.com>
Date:   Thu, 12 Jan 2023 11:30:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Cc:     "Aaro Koskinen" <aaro.koskinen@iki.fi>,
        "Janusz Krzysztofik" <jmkrzyszt@gmail.com>,
        "Tony Lindgren" <tony@atomide.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ARM: pxa: remove further dead code after pxa93 support removal
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023, at 10:26, Lukas Bulwahn wrote:
> On Thu, Jan 12, 2023 at 10:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
>> > Commit 150ccb6f9a89 ("ARM: pxa: remove pxa93x support") removes configs
>> > CPU_PXA930 and CPU_PXA935 and uses of cpu_is_pxa93x() and cpu_is_pxa935().
>> >
>> > Remove some further dead code in ./include/linux/soc/pxa/cpu.h on top of
>> > that commit above.
>> >
>> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>
>> I had this in an earlier version and ended up leaving this bit in
>> when I reworked the series to not drop support for PXA310 and PXA320.
>>
>> You are probably right that we should not reference the removed
>> Kconfig symbols, but I see that this causes a regression
>> unless I also bring back the change to
>>
>> drivers/mmc/host/pxamci.c:                              || cpu_is_pxa935())
>>
>
> Thanks for the insights of your previous attempt. In my janitorial
> work, I am just triggered by references to removed configs and hardly
> have the resources to test all the various arm pxa configs. Let us
> keep it as is for now, and see once your clean-up has settled in
> mainline, if we find a good suitable further cleanup patch on these
> code parts here then.

Sounds good, thanks.

It's very helpful to have you checks trigger on my modified patches
as that shows what I have missed in the updates, as well as showing
that the initial step I had done did not contain such mistakes.

The procedure I used to create my series was to remove all the
boards marked as 'depends on UNUSED_BOARD_FILES' and then recursively
remove orphaned header Kconfig symbols, header files.

There is another related set of patches that started looking
into, which is for device drivers that

- register a platform_driver, i2c_driver or spi_driver
- have no support of probing from DT or ACPI
- have no remaining device registration in tree

See below for the list that I came up with. I only annotated
the drivers at this point, as these are slightly more
controversial than the files that are clearly dead code
based on existing Kconfig dependencies etc.

If you're interested in helping out with these, feel free
to take anything from this list and send patches directly
to the subsystem maintainers.

    Arnd

---
commit 853e389693ce4da709641cbeb46a8f405d92287a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Oct 14 16:20:09 2022 +0200

    depends-on-unused
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3604074a878b..1c7e8ea4812c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -735,6 +735,7 @@ config X86_SUPPORTS_MEMORY_FAILURE
 config STA2X11
 	bool "STA2X11 Companion Chip Support"
 	depends on X86_32_NON_STANDARD && PCI
+	depends on UNUSED
 	select SWIOTLB
 	select MFD_STA2X11
 	select GPIOLIB
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0d4447df7200..3cad5c320add 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -305,6 +305,7 @@ config RPR0521
 config SENSORS_LM3533
 	tristate "LM3533 ambient light sensor"
 	depends on MFD_LM3533
+	depends on UNUSED
 	help
 	  If you say yes here you get support for the ambient light sensor
 	  interface on National Semiconductor / TI LM3533 Lighting Power
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d98650426dc2..8d11945f5bd6 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -30,6 +30,7 @@ config KEYBOARD_ADC
 config KEYBOARD_ADP5520
 	tristate "Keypad Support for ADP5520 PMIC"
 	depends on PMIC_ADP5520
+	depends on UNUSED
 	help
 	  This option enables support for the keypad scan matrix
 	  on Analog Devices ADP5520 PMICs.
@@ -53,6 +54,7 @@ config KEYBOARD_ADP5588
 config KEYBOARD_ADP5589
 	tristate "ADP5585/ADP5589 I2C QWERTY Keypad and IO Expander"
 	depends on I2C
+	depends on UNUSED
 	help
 	  Say Y here if you want to use a ADP5585/ADP5589 attached to your
 	  system I2C bus.
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5c2d0c06d2a5..578cb73ed59e 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -45,6 +45,7 @@ config INPUT_AB8500_PONKEY
 
 config INPUT_AD714X
 	tristate "Analog Devices AD714x Capacitance Touch Sensor"
+	depends on UNUSED
 	help
 	  Say Y here if you want to support an AD7142/3/7/8/7A touch sensor.
 
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 1a2049b336a6..61bb8e632413 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -46,6 +46,7 @@ config TOUCHSCREEN_ADS7846
 config TOUCHSCREEN_AD7877
 	tristate "AD7877 based touchscreens"
 	depends on SPI_MASTER
+	depends on UNUSED
 	help
 	  Say Y here if you have a touchscreen interface using the
 	  AD7877 controller, and your board-specific initialization
diff --git a/drivers/media/pci/sta2x11/Kconfig b/drivers/media/pci/sta2x11/Kconfig
index 118b922c08c3..3153544c0600 100644
--- a/drivers/media/pci/sta2x11/Kconfig
+++ b/drivers/media/pci/sta2x11/Kconfig
@@ -3,6 +3,7 @@ config STA2X11_VIP
 	tristate "STA2X11 VIP Video For Linux"
 	depends on PCI && VIDEO_DEV && I2C
 	depends on STA2X11 || COMPILE_TEST
+	depends on UNUSED
 	select GPIOLIB if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEO_ADV7180 if MEDIA_SUBDRV_AUTOSELECT
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/samsung/s3c-camif/Kconfig b/drivers/media/platform/samsung/s3c-camif/Kconfig
index f359f6382fff..0132b0f13dec 100644
--- a/drivers/media/platform/samsung/s3c-camif/Kconfig
+++ b/drivers/media/platform/samsung/s3c-camif/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_S3C_CAMIF
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV && I2C && PM
 	depends on ARCH_S3C64XX || COMPILE_TEST
+	depends on UNUSED
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/radio/Kconfig b/drivers/media/radio/Kconfig
index 616a38feb641..46b9606837f4 100644
--- a/drivers/media/radio/Kconfig
+++ b/drivers/media/radio/Kconfig
@@ -144,6 +144,7 @@ config RADIO_TIMBERDALE
 config RADIO_WL1273
 	tristate "Texas Instruments WL1273 I2C FM Radio"
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	select MFD_WL1273_CORE
 	select FW_LOADER
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c24841e5699..df7132c56e1e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -104,6 +104,7 @@ config MFD_AS3722
 config PMIC_ADP5520
 	bool "Analog Devices ADP5520/01 MFD PMIC Core Support"
 	depends on I2C=y
+	depends on UNUSED
 	help
 	  Say yes here to add support for Analog Devices ADP5520 and ADP5501,
 	  Multifunction Power Management IC. This includes
@@ -116,6 +117,7 @@ config MFD_AAT2870_CORE
 	select MFD_CORE
 	depends on I2C=y
 	depends on GPIOLIB || COMPILE_TEST
+	depends on UNUSED
 	help
 	  If you say yes here you get support for the AAT2870.
 	  This driver provides common support for accessing the device,
@@ -303,6 +305,7 @@ config MFD_CS47L92
 config PMIC_DA903X
 	bool "Dialog Semiconductor DA9030/DA9034 PMIC Support"
 	depends on I2C=y
+	depends on UNUSED
 	help
 	  Say yes here to add support for Dialog Semiconductor DA9030 (a.k.a
 	  ARAVA) and DA9034 (a.k.a MICCO), these are Power Management IC
@@ -988,6 +991,7 @@ config MFD_OCELOT
 config EZX_PCAP
 	bool "Motorola EZXPCAP Support"
 	depends on SPI_MASTER
+	depends on UNUSED
 	help
 	  This enables the PCAP ASIC present on EZX Phones. This is
 	  needed for MMC, TouchScreen, Sound, USB, etc..
@@ -1040,6 +1044,7 @@ config MFD_RETU
 
 config MFD_PCF50633
 	tristate "NXP PCF50633"
+	depends on UNUSED
 	depends on I2C
 	select REGMAP_I2C
 	help
@@ -1164,6 +1169,7 @@ config MFD_RT5120
 config MFD_RC5T583
 	bool "Ricoh RC5T583 Power Management system device"
 	depends on I2C=y
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	help
@@ -1225,6 +1231,7 @@ config MFD_SEC_CORE
 config MFD_SI476X_CORE
 	tristate "Silicon Laboratories 4761/64/68 AM/FM radio."
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	help
@@ -1387,6 +1394,7 @@ endmenu
 config MFD_STA2X11
 	bool "STMicroelectronics STA2X11"
 	depends on STA2X11
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_MMIO
 
@@ -1431,6 +1439,7 @@ config MFD_LP3943
 config MFD_LP8788
 	bool "TI LP8788 Power Management Unit Driver"
 	depends on I2C=y
+	depends on UNUSED
 	select MFD_CORE
 	select REGMAP_I2C
 	select IRQ_DOMAIN
@@ -1723,6 +1732,7 @@ config MENELAUS
 config MFD_WL1273_CORE
 	tristate "TI WL1273 FM radio"
 	depends on I2C
+	depends on UNUSED
 	select MFD_CORE
 	default n
 	help
@@ -1732,6 +1742,7 @@ config MFD_WL1273_CORE
 
 config MFD_LM3533
 	tristate "TI/National Semiconductor LM3533 Lighting Power chip"
+	depends on UNUSED
 	depends on I2C
 	select MFD_CORE
 	select REGMAP_I2C
@@ -1850,6 +1861,7 @@ config MFD_WM8400
 	bool "Wolfson Microelectronics WM8400"
 	select MFD_CORE
 	depends on I2C=y
+	depends on UNUSED
 	select REGMAP_I2C
 	help
 	  Support for the Wolfson Microelecronics WM8400 PMIC and audio
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 9947b7892bd5..b99a94080b2a 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -352,6 +352,7 @@ config SENSORS_TSL2550
 config SENSORS_BH1770
 	 tristate "BH1770GLC / SFH7770 combined ALS - Proximity sensor"
 	 depends on I2C
+	depends on UNUSED
 	help
 	   Say Y here if you want to build a driver for BH1770GLC (ROHM) or
 	   SFH7770 (Osram) combined ambient light and proximity sensor chip.
@@ -362,6 +363,7 @@ config SENSORS_BH1770
 config SENSORS_APDS990X
 	 tristate "APDS990X combined als and proximity sensors"
 	 depends on I2C
+	depends on UNUSED
 	help
 	   Say Y here if you want to build a driver for Avago APDS990x
 	   combined ambient light and proximity sensor chip.
diff --git a/drivers/misc/ti-st/Kconfig b/drivers/misc/ti-st/Kconfig
index 1503a6496f63..6be14cbfa023 100644
--- a/drivers/misc/ti-st/Kconfig
+++ b/drivers/misc/ti-st/Kconfig
@@ -8,6 +8,7 @@ config TI_ST
 	tristate "Shared transport core driver"
 	depends on NET && TTY
 	depends on GPIOLIB || COMPILE_TEST
+	depends on UNUSED
 	select FW_LOADER
 	help
 	  This enables the shared transport core driver for TI
diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
index 323ec56e8a74..cf1b9abc1f87 100644
--- a/drivers/net/ethernet/Kconfig
+++ b/drivers/net/ethernet/Kconfig
@@ -111,6 +111,7 @@ config KORINA
 config LANTIQ_ETOP
 	tristate "Lantiq SoC ETOP driver"
 	depends on SOC_TYPE_XWAY
+	depends on UNUSED
 	help
 	  Support for the MII0 inside the Lantiq SoC
 
diff --git a/drivers/net/ethernet/wiznet/Kconfig b/drivers/net/ethernet/wiznet/Kconfig
index 4bac2ad2d6a1..1f7a7edfa0b9 100644
--- a/drivers/net/ethernet/wiznet/Kconfig
+++ b/drivers/net/ethernet/wiznet/Kconfig
@@ -33,6 +33,7 @@ config WIZNET_W5100
 config WIZNET_W5300
 	tristate "WIZnet W5300 Ethernet support"
 	depends on HAS_IOMEM
+	depends on UNUSED
 	help
 	  Support for WIZnet W5300 chips.
 
diff --git a/drivers/net/wireless/marvell/libertas/Kconfig b/drivers/net/wireless/marvell/libertas/Kconfig
index 6d62ab49aa8d..287c2c84b412 100644
--- a/drivers/net/wireless/marvell/libertas/Kconfig
+++ b/drivers/net/wireless/marvell/libertas/Kconfig
@@ -30,6 +30,7 @@ config LIBERTAS_SDIO
 config LIBERTAS_SPI
 	tristate "Marvell Libertas 8686 SPI 802.11b/g cards"
 	depends on LIBERTAS && SPI
+	depends on UNUSED
 	help
 	  A driver for Marvell Libertas 8686 SPI devices.
 
diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
index e2f8dfcdd2a9..44f5f8a69672 100644
--- a/drivers/power/supply/Kconfig
+++ b/drivers/power/supply/Kconfig
@@ -281,6 +281,7 @@ config BATTERY_BQ27XXX_DT_UPDATES_NVM
 
 config BATTERY_DA9030
 	tristate "DA9030 battery driver"
+	depends on UNUSED
 	depends on PMIC_DA903X
 	help
 	  Say Y here to enable support for batteries charger integrated into
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0788e5..39d176052bef 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -463,6 +463,7 @@ config REGULATOR_LOCHNAGAR
 
 config REGULATOR_LP3971
 	tristate "National Semiconductors LP3971 PMIC regulator driver"
+	depends on UNUSED
 	depends on I2C
 	help
 	 Say Y here to support the voltage regulators and convertors
@@ -470,6 +471,7 @@ config REGULATOR_LP3971
 
 config REGULATOR_LP3972
 	tristate "National Semiconductors LP3972 PMIC regulator driver"
+	depends on UNUSED
 	depends on I2C
 	help
 	 Say Y here to support the voltage regulators and convertors
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2aba88a57a77..f8379e709c64 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1157,6 +1157,7 @@ config SPI_LOOPBACK_TEST
 config SPI_TLE62X0
 	tristate "Infineon TLE62X0 (for power switching)"
 	depends on SYSFS
+	depends on UNUSED
 	help
 	  SPI driver for Infineon TLE62X0 series line driver chips,
 	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
diff --git a/drivers/staging/media/omap4iss/Kconfig b/drivers/staging/media/omap4iss/Kconfig
index 6d1f55b09132..698dfcb286b6 100644
--- a/drivers/staging/media/omap4iss/Kconfig
+++ b/drivers/staging/media/omap4iss/Kconfig
@@ -4,6 +4,7 @@ config VIDEO_OMAP4
 	tristate "OMAP 4 Camera support"
 	depends on VIDEO_DEV  && I2C
 	depends on ARCH_OMAP4 || COMPILE_TEST
+	depends on UNUSED
 	select MEDIA_CONTROLLER
 	select VIDEO_V4L2_SUBDEV_API
 	select MFD_SYSCON
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ed0672d2d0ef..c50a7bbd9c54 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -316,6 +316,7 @@ config SERIAL_TEGRA_TCU_CONSOLE
 config SERIAL_MAX3100
 	tristate "MAX3100 support"
 	depends on SPI
+	depends on UNUSED
 	select SERIAL_CORE
 	help
 	  MAX3100 chip support
diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 511ab57cdc81..3384025f482e 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -209,6 +209,7 @@ config USB_PXA27X
 config USB_MV_UDC
 	tristate "Marvell USB2.0 Device Controller"
 	depends on HAS_DMA
+	depends on UNUSED
 	help
 	  Marvell Socs (including PXA and MMP series) include a high speed
 	  USB2.0 OTG controller, which can be configured as high speed or
@@ -217,6 +218,7 @@ config USB_MV_UDC
 config USB_MV_U3D
 	depends on HAS_DMA
 	tristate "MARVELL PXA2128 USB 3.0 controller"
+	depends on UNUSED
 	help
 	  MARVELL PXA2128 Processor series include a super speed USB3.0 device
 	  controller, which support super speed USB peripheral.
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index a97923897c8e..c7fadc9b5c23 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -368,7 +368,7 @@ config USB_ISP116X_HCD
 config USB_ISP1362_HCD
 	tristate "ISP1362 HCD support"
 	depends on HAS_IOMEM
-	depends on COMPILE_TEST # nothing uses this
+	depends on UNUSED # nothing uses this
 	help
 	  Supports the Philips ISP1362 chip as a host controller
 
@@ -654,6 +654,7 @@ config USB_U132_HCD
 config USB_SL811_HCD
 	tristate "SL811HS HCD support"
 	depends on HAS_IOMEM
+	depends on UNUSED
 	help
 	  The SL811HS is a single-port USB controller that supports either
 	  host side or peripheral side roles.  Enable this option if your
diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 5f629d7cad64..efa798b2d56e 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -130,6 +130,7 @@ config USB_MV_OTG
 	tristate "Marvell USB OTG support"
 	depends on USB_EHCI_MV && USB_MV_UDC && PM && USB_OTG
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
+	depends on UNUSED
 	select USB_PHY
 	help
 	  Say Y here if you want to build Marvell USB OTG transceiver
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2f5219cc36b4..4c5f4b188293 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1770,6 +1770,7 @@ config FB_PXA168
 	tristate "PXA168/910 LCD framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
 	depends on CPU_PXA168 || CPU_PXA910 || COMPILE_TEST
+	depends on UNUSED
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -2003,6 +2004,7 @@ config FB_DA8XX
 	tristate "DA8xx/OMAP-L1xx/AM335x Framebuffer support"
 	depends on FB && HAVE_CLK && HAS_IOMEM
 	depends on ARCH_DAVINCI_DA8XX || SOC_AM33XX || COMPILE_TEST
+	depends on UNUSED
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
@@ -2128,6 +2130,7 @@ config FB_PRE_INIT_FB
 config FB_MX3
 	tristate "MX3 Framebuffer support"
 	depends on FB && MX3_IPU
+	depends on UNUSED
 	select BACKLIGHT_CLASS_DEVICE
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/fbdev/mmp/fb/Kconfig b/drivers/video/fbdev/mmp/fb/Kconfig
index 0ec2e3fb9e17..18eaf625b67b 100644
--- a/drivers/video/fbdev/mmp/fb/Kconfig
+++ b/drivers/video/fbdev/mmp/fb/Kconfig
@@ -2,6 +2,7 @@
 config MMP_FB
 	tristate "fb driver for Marvell MMP Display Subsystem"
 	depends on FB
+	depends on UNUSED
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/sound/spi/Kconfig b/sound/spi/Kconfig
index f407c37c37fa..e93a1abfd7bd 100644
--- a/sound/spi/Kconfig
+++ b/sound/spi/Kconfig
@@ -13,6 +13,7 @@ if SND_SPI
 config SND_AT73C213
 	tristate "Atmel AT73C213 DAC driver"
 	depends on ATMEL_SSC
+	depends on UNUSED
 	select SND_PCM
 	help
 	  Say Y here if you want to use the Atmel AT73C213 external DAC. This
