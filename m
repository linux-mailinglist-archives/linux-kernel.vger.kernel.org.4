Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB965A845
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 00:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbiLaXkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 18:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiLaXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 18:39:13 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0737669;
        Sat, 31 Dec 2022 15:39:10 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 993755C00A4;
        Sat, 31 Dec 2022 18:39:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 18:39:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672529949; x=1672616349; bh=QB
        0PymlUuhvD0YEuPWlz6lqlgooYVVVb1wPf8p3kU9g=; b=mF7/eLNo7cgDlxZ+OT
        3b0hSjDuhnwTM6Vc1khPmNRba3CujmGTpHRkgNs0ukg1mtnz5o02UdcCASm5yVAm
        n3z8HXo/j7jDVPa04PE/gvv4t9kRFf7KiM78hbjxJMqywabjN/CMzxwZiT5JphzQ
        nkirFuG95QZTbTarSMNwkDDahZcK0PB200T9ZsoxsraEgCn1ASqvrEax4EWhxma6
        XhVZ4x8/Fzv5TxQz5J+PRfrksKvLDxSa8SZEoJxErh0Iqwb0+Q17gsl7t615P9mY
        3V3P4Ni8fL3s3UOgvgqcAausB4LJBjqyOeCssh2w8UuC+CYPPpuH2c30vfqOh+zO
        YGhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672529949; x=1672616349; bh=QB0PymlUuhvD0
        YEuPWlz6lqlgooYVVVb1wPf8p3kU9g=; b=FIIyJOoUW9nayuLPVqGBM8h7TVd0d
        kBS8gZFZQZNPIl9J2kWazprzHhLLmbs81dNV4VkYKoCzNChaehqOp//fcwOGLXc+
        1oM+fKhBoG8dwv2IBuE3DVV0owjIdiunMFUPZaGPlieQR26mHxCddJJcE/jTLFA+
        ZjxNrqPa1mV6f3bDMQAOwZI04S+7Eok/DMlxgP7yobYgRNlCz8dzXhrEhlM+/D6C
        xLBy1GQFsSKfJocsOV+1EQ5qoM8rZrJEC8ym8esTcPnmjfrUGfvTw1HKKott0zO5
        hHi4tpLubh+cMRWOY7izszJ0z0/YdV6VPLJPeZebWEOlCWd/AdlJQ5EEg==
X-ME-Sender: <xms:HciwY7o8RMSoNJ6ghH9f9jOlqHh9LYDMN1K3FSUDCgZlQ0RjjEi23Q>
    <xme:HciwY1oTC28M4eBeQXp5dq95-zqvgEno-YhX8UIkT_a5Ktv6GjDGAvocZpcSV4hsq
    omLg0VjWHEkKXEG5w>
X-ME-Received: <xmr:HciwY4NxchW7XBMcc_RO1cXIL9rXOnZRipLFPhAju3Hqwt9i7MUzX_v4_On_JsmURaMssELxlJ_6iIPHk86mkZ7BKLqax5ILRKtAHe4QWiw9clPWdtDMW_DJRjUWADb8xgFu9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieelgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HciwY-5yXXf028YOkGx8sSm1ccPHaEVHhz5tvvQuqY3y6b4hNNwY2Q>
    <xmx:HciwY66Ht1s_WXHNYqrGEH605AFuGkpyQQWaRH43T4Z5ALjzJYBGbQ>
    <xmx:HciwY2i1WWrgHRJzU2ea1ljYs1PTx1es22Hbig76qvAydXeqfeeyaA>
    <xmx:HciwY_NbLUPxa5JUnz8MWG_3OAUB5LuP8wrY86TAlUiYdBvpm3BmKQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 18:39:08 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: [PATCH v4 12/12] riscv: defconfig: Enable the Allwinner D1 platform and drivers
Date:   Sat, 31 Dec 2022 17:38:51 -0600
Message-Id: <20221231233851.24923-13-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231233851.24923-1-samuel@sholland.org>
References: <20221231233851.24923-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that several D1-based boards are supported, enable the platform in
our defconfig. Build in the drivers which are necessary to boot, such as
the pinctrl, MMC, RTC (which provides critical clocks), SPI (for flash),
and watchdog (which may be left enabled by the bootloader). Other common
onboard peripherals are enabled as modules.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Rebase on v6.2-rc1 + soc2arch-immutable

 arch/riscv/configs/defconfig | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 128dcf4c0814..d98d6e90b2b8 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -29,6 +29,7 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
 CONFIG_ARCH_RENESAS=y
 CONFIG_SOC_SIFIVE=y
 CONFIG_SOC_STARFIVE=y
+CONFIG_ARCH_SUNXI=y
 CONFIG_SOC_VIRT=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
@@ -120,8 +121,10 @@ CONFIG_VIRTIO_NET=y
 CONFIG_MACB=y
 CONFIG_E1000E=y
 CONFIG_R8169=y
+CONFIG_STMMAC_ETH=m
 CONFIG_MICROSEMI_PHY=y
 CONFIG_INPUT_MOUSEDEV=y
+CONFIG_KEYBOARD_SUN4I_LRADC=m
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
@@ -130,14 +133,20 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_HW_RANDOM_VIRTIO=y
+CONFIG_I2C_MV64XXX=m
 CONFIG_SPI=y
 CONFIG_SPI_SIFIVE=y
+CONFIG_SPI_SUN6I=y
 # CONFIG_PTP_1588_CLOCK is not set
-CONFIG_GPIOLIB=y
 CONFIG_GPIO_SIFIVE=y
+CONFIG_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_DRM=m
 CONFIG_DRM_RADEON=m
 CONFIG_DRM_NOUVEAU=m
+CONFIG_DRM_SUN4I=m
 CONFIG_DRM_VIRTIO_GPU=m
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
@@ -150,21 +159,32 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_UAS=y
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_SUNXI=m
+CONFIG_NOP_USB_XCEIV=m
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_SUNXI=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_SUN6I=y
+CONFIG_DMADEVICES=y
+CONFIG_DMA_SUN6I=m
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VIRTIO_MMIO=y
+CONFIG_SUN8I_DE2_CCU=m
+CONFIG_SUN50I_IOMMU=y
 CONFIG_RPMSG_CHAR=y
 CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_ARCH_R9A07G043=y
+CONFIG_PHY_SUN4I_USB=m
 CONFIG_LIBNVDIMM=y
+CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
 CONFIG_EXT4_FS_SECURITY=y
-- 
2.37.4

