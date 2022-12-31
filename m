Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A7465A5A4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiLaQEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 11:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiLaQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 11:04:09 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CC66469;
        Sat, 31 Dec 2022 08:04:08 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 943365C00CC;
        Sat, 31 Dec 2022 11:04:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 31 Dec 2022 11:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672502647; x=1672589047; bh=Q1
        vwtqB3F/Lg9EeKX7ncuUV0pXZNB1/Hc2bxCcup/GU=; b=FTyiVms9Ncc93x/vDX
        6gGWIDwQBjlChR+KMWk7rLWlZTUsfTje6F3/vY74jU7uPzJ9W0HO5S5y/GqcJhTs
        OZeAlrdxKcti/iJ/AwGkb6QbNJPfxY5/2oIZYzAiD5zj4FebJLS2/3JEx3Sfbm4Z
        ZQuZk7p+MbYGpt8z0ZbV0a65YxqmJfgY/YxBLUlsN05dznNPp6+to5g/x7HC/Fqd
        KpVgCf24mVWKjsW9G7LdMM2KhlFl73/hOfX8lf+YaOroeoodDP3FeNGHKTu4TleD
        nsOMf47AsaecVLu+lIjGw2zzyvx5k7b3w/1y/8oPdeyc9uMwacjun2kk6c7jNsi/
        9c+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672502647; x=1672589047; bh=Q1vwtqB3F/Lg9
        EeKX7ncuUV0pXZNB1/Hc2bxCcup/GU=; b=AxlCX2xbB4v8Q85DUWOkEZm3z3KzN
        6DmwSJJNFQ+LbzyWhVuxiWX3W/wAN3hjjPtYvzmFkJ2w2eYOTCDsfajQRErI+p8P
        dzRDm7BVnpfbMOgXRdzplj9U/CedZ9VNNfPek7CJRF1wx4gXkuYtoTFn88/n0opF
        qAfI+bWMJc/dCP/hEAn4Mer61r9vRhBFr67PlbnfG0fCL5NoRjIUEg9YuGhvAHut
        aTGl3z4evDxqyaxcIhe0DXcD+K3+k5Ly5wnrZk2CRFafwcNMj9QqwWGKVSg9DL4U
        /HksN3FNaQrk2b5clHTMjMrQnqb0Q8BPkUkDs6yowfFh0UdvKrPUQEDKg==
X-ME-Sender: <xms:d12wY-KMq_ykox2twyraEmQUHBEg9O74pajCZi-tVFfvOYwEx_jKqg>
    <xme:d12wY2Ik7NlNoqefF_V1nbpClXw_c2Dfu5U3ngJSxjANd-Qyji37XWsGG2bj_vaVX
    cFVZ22KMwEBihvyHA>
X-ME-Received: <xmr:d12wY-vh82_j3LgZirCDrjm0gQJck8spN_H5MMfV-UxqEZSXQ6Yowwathr7z1M7Bccr_sSM1CbBznrXPnYsYFoai1mny70aBY9lsB5SxRblNk9CyI-YVyF0KHQI7VY3OCmJKxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieekgdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:d12wYza_Vxv8XdF4X05EiGRcD6RvGoxDQIKmXeE3u5SKsD7WIYevaQ>
    <xmx:d12wY1ayMtBOP1OJBhgpovoCVw7WznRf2mMYcBKR3KEvIp2LYbO7Wg>
    <xmx:d12wY_DO_a0QW7BeC9PVTLid6CxPKLI7ejFcRBtDuIfVLr6P6dhVzg>
    <xmx:d12wYzMb2wrs4MlKTwSgKx82y0BHe96qCFPLeZGW2IlRGD5C_F6hig>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Dec 2022 11:04:06 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/2] soc: sunxi: Add Allwinner D1 PPU driver
Date:   Sat, 31 Dec 2022 10:04:02 -0600
Message-Id: <20221231160402.16157-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221231160402.16157-1-samuel@sholland.org>
References: <20221231160402.16157-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/soc/sunxi/Kconfig      |   9 ++
 drivers/soc/sunxi/Makefile     |   1 +
 drivers/soc/sunxi/sun20i-ppu.c | 207 +++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/soc/sunxi/sun20i-ppu.c

diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
index 8aecbc9b1976..5e84cf4b8510 100644
--- a/drivers/soc/sunxi/Kconfig
+++ b/drivers/soc/sunxi/Kconfig
@@ -19,3 +19,12 @@ config SUNXI_SRAM
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
+	  All power domains are on by default, so this is optional.
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

