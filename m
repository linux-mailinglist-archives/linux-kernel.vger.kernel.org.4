Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53E767C47F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 07:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjAZGef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 01:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAZGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 01:34:29 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F55EF8A;
        Wed, 25 Jan 2023 22:34:27 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3AA0B3200A5B;
        Thu, 26 Jan 2023 01:34:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jan 2023 01:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1674714865; x=1674801265; bh=H8
        Frwk6r4D/FDf+TfookzCIBrBL7WAl2zM9ijFvdAXM=; b=C9A27TFkyNFZUfpd6Z
        yVxCpnskHTy05mB2LqkMdRMnvUGMFu/CuDrr42C5YMK3FcBYeVjbALPKfdx1YtPO
        4i/1gcWL85LTSPbn90VQrv2BPaogNBZYcVNem7nT1HKpztxnDe1XfQni6UUxMrxz
        JKCLX3PT7R2j3VRSMebl5kvSjY0BimS8nPgUxSZccEEDNmaOPT2hd8JqCLwlhk5h
        Bv4zzm7/dsTpI58hBfYYqwKbZvGosmOVthEzCNvGQ2NtZLUGyhe25X4GPUCzpI//
        IF4EaeSFg4hSnKF568ze706nKBndK+GDKzJvJYn/sR1OMGdB5dfyrh14TEQmdaE+
        F3Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1674714865; x=1674801265; bh=H8Frwk6r4D/FD
        f+TfookzCIBrBL7WAl2zM9ijFvdAXM=; b=i7Ne2Nwm4bu2STG3V6zoeYIl+gPAf
        0yiwqIeBOBrOl+6Wm4SGKiEDW88+Pk6Ic2UNJqGkBVQWUIOiHGmQPyzLnLD816B0
        gywQXJPY768uNIQQjKDFI01wBtzSuYaTJ1SB8iKVP67d0bkBuKAFbGhlOBopZqDV
        Igpg02c0jhZh5HKSMvEycecIFsE9y/1pvMKaONPenAVQMfIWJ5eD+3PR2HPHPzwx
        i4huHL66/fLvAaDKvRHTw2y74sSkzjuLgFINtrhqtKhz+YJfXBmUrZ+92dQ8f7HV
        E0NfJVhyeLOKSJjsTaaV1rISqJPQocPhZ8384/29T0c8McqVhktOU5qEg==
X-ME-Sender: <xms:8R7SY1BXZ619rnRuvI-wtys3-7np3x6ll4PT_EoOp3ZKkfVNqBUBPA>
    <xme:8R7SYzgpKNMiNsjn79BUhHBsqZWm36tpZpxusG87GskxmPxBhLPPYxseRHVwDWuAB
    mD8qTGkNMYn4Y275Q>
X-ME-Received: <xmr:8R7SYwk1IoRUBySNbRh46WWlAE6-zcIc2iGEiQRtq92JLJ-aFJURQ4ke_8Lh60sH8j1Uj1zgs1z17bAeUh99-AMZdUC6Byqx_WWpu7TDj6nfQwZ_PElba_0nSXcvXzMORdv-Rw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:8R7SY_wWZvVL042QjC3udAe65z_CQtEypc1tkVM6o-z-L9Jzy477TA>
    <xmx:8R7SY6T1sSm2W0A8ZqgJPfAP671Fhre_Mp2ViggEJeg7-D76o_QkYA>
    <xmx:8R7SYyaLjc92dcwT3k09p6MfUKvPPh73VFsi1SVwANg9gccEcUEBIg>
    <xmx:8R7SY0BxkDPNnGqV9jPMpMOt_CfIElB4_bEiBU1Vr_Qfzt5ysgvNrw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jan 2023 01:34:24 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] soc: sunxi: Add Allwinner D1 PPU driver
Date:   Thu, 26 Jan 2023 00:34:18 -0600
Message-Id: <20230126063419.15971-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230126063419.15971-1-samuel@sholland.org>
References: <20230126063419.15971-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PPU contains a series of identical MMIO register ranges, one for
each power domain. Each range contains control/status bits for a clock
gate, reset line, output gates, and a power switch. (The clock and reset
are separate from, and in addition to, the bits in the CCU.) It also
contains a hardware power sequence engine to control the other bits.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v2:
 - Removed possibly misleading comment from the Kconfig description

 drivers/soc/sunxi/Kconfig      |   8 ++
 drivers/soc/sunxi/Makefile     |   1 +
 drivers/soc/sunxi/sun20i-ppu.c | 207 +++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)
 create mode 100644 drivers/soc/sunxi/sun20i-ppu.c

diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index 8aecbc9b1976..29e9ba2d520d 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -19,3 +19,11 @@ config SUNXI_SRAM
 	  Say y here to enable the SRAM controller support. This
 	  device is responsible on mapping the SRAM in the sunXi SoCs
 	  whether to the CPU/DMA, or to the devices.
+
+config SUN20I_PPU
+	bool "Allwinner D1 PPU power domain driver"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	select PM_GENERIC_DOMAINS
+	help
+	  Say y to enable the PPU power domain driver. This saves power
+	  when certain peripherals, such as the video engine, are idle.
diff --git a/drivers/soc/sunxi/Makefile b/drivers/soc/sunxi/Makefile
index 549159571d4f..90ff2ebe7655 100644
--- a/drivers/soc/sunxi/Makefile
+++ b/drivers/soc/sunxi/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_SUNXI_MBUS) +=	sunxi_mbus.o
 obj-$(CONFIG_SUNXI_SRAM) +=	sunxi_sram.o
+obj-$(CONFIG_SUN20I_PPU) +=	sun20i-ppu.o
diff --git a/drivers/soc/sunxi/sun20i-ppu.c b/drivers/soc/sunxi/sun20i-ppu.c
new file mode 100644
index 000000000000..98cb41d36560
--- /dev/null
+++ b/drivers/soc/sunxi/sun20i-ppu.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/reset.h>
+
+#define PD_STATE_ON			1
+#define PD_STATE_OFF			2
+
+#define PD_RSTN_REG			0x00
+#define PD_CLK_GATE_REG			0x04
+#define PD_PWROFF_GATE_REG		0x08
+#define PD_PSW_ON_REG			0x0c
+#define PD_PSW_OFF_REG			0x10
+#define PD_PSW_DELAY_REG		0x14
+#define PD_OFF_DELAY_REG		0x18
+#define PD_ON_DELAY_REG			0x1c
+#define PD_COMMAND_REG			0x20
+#define PD_STATUS_REG			0x24
+#define PD_STATUS_COMPLETE			BIT(1)
+#define PD_STATUS_BUSY				BIT(3)
+#define PD_STATUS_STATE				GENMASK(17, 16)
+#define PD_ACTIVE_CTRL_REG		0x2c
+#define PD_GATE_STATUS_REG		0x30
+#define PD_RSTN_STATUS				BIT(0)
+#define PD_CLK_GATE_STATUS			BIT(1)
+#define PD_PWROFF_GATE_STATUS			BIT(2)
+#define PD_PSW_STATUS_REG		0x34
+
+#define PD_REGS_SIZE			0x80
+
+struct sun20i_ppu_desc {
+	const char *const		*names;
+	unsigned int			num_domains;
+};
+
+struct sun20i_ppu_pd {
+	struct generic_pm_domain	genpd;
+	void __iomem			*base;
+};
+
+#define to_sun20i_ppu_pd(_genpd) \
+	container_of(_genpd, struct sun20i_ppu_pd, genpd)
+
+static bool sun20i_ppu_pd_is_on(const struct sun20i_ppu_pd *pd)
+{
+	u32 status = readl(pd->base + PD_STATUS_REG);
+
+	return FIELD_GET(PD_STATUS_STATE, status) == PD_STATE_ON;
+}
+
+static int sun20i_ppu_pd_set_power(const struct sun20i_ppu_pd *pd, bool power_on)
+{
+	u32 state, status;
+	int ret;
+
+	if (sun20i_ppu_pd_is_on(pd) == power_on)
+		return 0;
+
+	/* Wait for the power controller to be idle. */
+	ret = readl_poll_timeout(pd->base + PD_STATUS_REG, status,
+				 !(status & PD_STATUS_BUSY), 100, 1000);
+	if (ret)
+		return ret;
+
+	state = power_on ? PD_STATE_ON : PD_STATE_OFF;
+	writel(state, pd->base + PD_COMMAND_REG);
+
+	/* Wait for the state transition to complete. */
+	ret = readl_poll_timeout(pd->base + PD_STATUS_REG, status,
+				 FIELD_GET(PD_STATUS_STATE, status) == state &&
+				 (status & PD_STATUS_COMPLETE), 100, 1000);
+	if (ret)
+		return ret;
+
+	/* Clear the completion flag. */
+	writel(status, pd->base + PD_STATUS_REG);
+
+	return 0;
+}
+
+static int sun20i_ppu_pd_power_on(struct generic_pm_domain *genpd)
+{
+	const struct sun20i_ppu_pd *pd = to_sun20i_ppu_pd(genpd);
+
+	return sun20i_ppu_pd_set_power(pd, true);
+}
+
+static int sun20i_ppu_pd_power_off(struct generic_pm_domain *genpd)
+{
+	const struct sun20i_ppu_pd *pd = to_sun20i_ppu_pd(genpd);
+
+	return sun20i_ppu_pd_set_power(pd, false);
+}
+
+static int sun20i_ppu_probe(struct platform_device *pdev)
+{
+	const struct sun20i_ppu_desc *desc;
+	struct device *dev = &pdev->dev;
+	struct genpd_onecell_data *ppu;
+	struct sun20i_ppu_pd *pds;
+	struct reset_control *rst;
+	void __iomem *base;
+	struct clk *clk;
+	int ret;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	pds = devm_kcalloc(dev, desc->num_domains, sizeof(*pds), GFP_KERNEL);
+	if (!pds)
+		return -ENOMEM;
+
+	ppu = devm_kzalloc(dev, sizeof(*ppu), GFP_KERNEL);
+	if (!ppu)
+		return -ENOMEM;
+
+	ppu->domains = devm_kcalloc(dev, desc->num_domains,
+				    sizeof(*ppu->domains), GFP_KERNEL);
+	if (!ppu->domains)
+		return -ENOMEM;
+
+	ppu->num_domains = desc->num_domains;
+	platform_set_drvdata(pdev, ppu);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return ret;
+
+	for (unsigned int i = 0; i < ppu->num_domains; ++i) {
+		struct sun20i_ppu_pd *pd = &pds[i];
+
+		pd->genpd.name		= desc->names[i];
+		pd->genpd.power_off	= sun20i_ppu_pd_power_off;
+		pd->genpd.power_on	= sun20i_ppu_pd_power_on;
+		pd->base		= base + PD_REGS_SIZE * i;
+
+		ret = pm_genpd_init(&pd->genpd, NULL, sun20i_ppu_pd_is_on(pd));
+		if (ret) {
+			dev_warn(dev, "Failed to add '%s' domain: %d\n",
+				 pd->genpd.name, ret);
+			continue;
+		}
+
+		ppu->domains[i] = &pd->genpd;
+	}
+
+	ret = of_genpd_add_provider_onecell(dev->of_node, ppu);
+	if (ret)
+		dev_warn(dev, "Failed to add provider: %d\n", ret);
+
+	return 0;
+}
+
+static const char *const sun20i_d1_ppu_pd_names[] = {
+	"CPU",
+	"VE",
+	"DSP",
+};
+
+static const struct sun20i_ppu_desc sun20i_d1_ppu_desc = {
+	.names		= sun20i_d1_ppu_pd_names,
+	.num_domains	= ARRAY_SIZE(sun20i_d1_ppu_pd_names),
+};
+
+static const struct of_device_id sun20i_ppu_of_match[] = {
+	{
+		.compatible	= "allwinner,sun20i-d1-ppu",
+		.data		= &sun20i_d1_ppu_desc,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sun20i_ppu_of_match);
+
+static struct platform_driver sun20i_ppu_driver = {
+	.probe	= sun20i_ppu_probe,
+	.driver	= {
+		.name			= "sun20i-ppu",
+		.of_match_table		= sun20i_ppu_of_match,
+		/* Power domains cannot be removed while they are in use. */
+		.suppress_bind_attrs	= true,
+	},
+};
+module_platform_driver(sun20i_ppu_driver);
+
+MODULE_AUTHOR("Samuel Holland <samuel@sholland.org>");
+MODULE_DESCRIPTION("Allwinner D1 PPU power domain driver");
+MODULE_LICENSE("GPL");
-- 
2.37.4

