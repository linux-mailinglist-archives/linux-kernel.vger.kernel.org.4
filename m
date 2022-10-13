Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812FE5FD5F0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMIIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiJMIIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:08:38 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF9146381;
        Thu, 13 Oct 2022 01:08:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f140so1296128pfa.1;
        Thu, 13 Oct 2022 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcK9LwVTSuBxtC+4DRELD1Erud7HS/YE2Pwu+Qux9+4=;
        b=Hs5j6PA6tCF+LsDAVMDytwZtFyWeV2Myp6vq8KmzJILx6EmOz8kKfyUOuPHnrjatFB
         oknh5lW+TMing5A/TKjql45/m3T3UUEYsjxVwZKhjl/H5RttfDWpHsB/dq5feu3r0R+I
         N+9L/PWrOatfgYKOnB1OKzAtMcIpm1uq5b4/ComniGoHF/jG1Ruwo6OHY1bQlrDK2F7/
         9R4wLLR7qwInxt8sUy8TKh32GQY1cO87wrHZjdfPqytg2Y/yPkw9KFF/8oWzqDKntzOt
         AMo0DLmtw+OSIJtELe5qCz8JHuLiGsawdN4KGhz07ebNXv+7OeJJLJMJYnxJo8MsklVi
         gLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcK9LwVTSuBxtC+4DRELD1Erud7HS/YE2Pwu+Qux9+4=;
        b=vvaroRTZcYTiKhZkPgOXYS6lR+/5ehVOW7/c5PtsR+MU1IHHSvIzsLKBfN6/18hLF3
         g5S+KuBjrFLJKqQWJmVynnumHm2jB9SMtmTVX4WGh74mJevKmo0m8Xi3SDrbivDwNxRU
         HIz+/KX4h0L9uoPQxFvQtFEioPRptEY/3HBasMbfzLKHx9hp/ABTqv43/8LoEg/HPAY+
         jjYXHKOSQV2rCD6W6rx5JnGSKJqTQ2O+1nDGJ7+ShPvyPRLc3In4KuGYneF7lFnmEaKb
         uPHwM0fozJQ4cBVWeMwrMv2J4YB+JyMA1ofIi6WVVcJuGrn9RbScnRAJCMhlLXFOe7ip
         Rh8g==
X-Gm-Message-State: ACrzQf1v/GFJkz6O63V5+YBI62wxPNOvMeKw5oKJT8XEofM2AaqFf4Ks
        166IHkXnOgnHJAp3VDdxIIWH1mFTJOM=
X-Google-Smtp-Source: AMsMyM7YDC/l1w5XWGt/PZjucQVBkOiHVA3TcHWT6BSh6sZsI0WRNdVajwH2FT1iMpuvfx2rSfbQww==
X-Received: by 2002:a62:190e:0:b0:561:a818:41bb with SMTP id 14-20020a62190e000000b00561a81841bbmr35434267pfz.50.1665648514705;
        Thu, 13 Oct 2022 01:08:34 -0700 (PDT)
Received: from jeff-BM6660-BM6360-Invalid-entry-length-16-Fixed-up-to-11.richtek.com ([2402:7500:588:410b:2140:6680:e5c9:74df])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090a4bc900b0020ada6ed6c7sm2615547pjl.41.2022.10.13.01.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:08:34 -0700 (PDT)
From:   Jeff Chang <richtek.jeff.chang@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        jeff_chang@ricthek.com
Cc:     Jeff <jeff_chang@richtek.com>
Subject: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Date:   Thu, 13 Oct 2022 16:06:43 +0800
Message-Id: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff <jeff_chang@richtek.com>

The RT5512 is a boosted class-D amplifier with V/I sensing.
A built-in DC-DC step-up converter is used to provide efficient power for
class-D amplifier with multi-level class-H operation. The digital audio
interface supports I2S, left-justified, right-justified and TDM format for
audio in with a data out used for chip information like voltage sense and
current sense, which are able to be monitored via DATAO pin through proper
register setting.

Signed-off-by: SHIH CHIA CHANG <jeff_chang@richtek.com>
---
 .../bindings/sound/richtek,rt5512.yaml        |  50 +
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/rt5512.c                     | 860 ++++++++++++++++++
 4 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt5512.yaml
 create mode 100644 sound/soc/codecs/rt5512.c

diff --git a/Documentation/devicetree/bindings/sound/richtek,rt5512.yaml b/Documentation/devicetree/bindings/sound/richtek,rt5512.yaml
new file mode 100644
index 000000000000..6a21c9d1bd2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/richtek,rt5512.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/richtek,rt5512.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT5512 speaker amplifier
+
+maintainers:
+  - SHIH CHIA CHANG <jeff_chang@richtek.com>
+
+description: |
+  The RT5512B is a boosted class-D amplifier with V/I sensing.
+  A built-in DC-DC step-up converter is used to provide efficient power for 
+  class-D amplifier with multi-level class-H operation. The digital audio
+  interface supports I2S, left-justified, right-justified and TDM format for
+  audio in with a data out used for chip information like voltage sense and
+  current sense, which are able to be monitored via DATAO pin through proper
+  register setting.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt5150
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      rt5512@5c {
+        compatible = "richtek,rt5512";
+        reg = <0x5c>;
+        #sound-dai-cells = <0>;
+      };
+    };
diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index e3b90c425faf..0f2b4c2aded3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -176,6 +176,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT1019
 	imply SND_SOC_RT1305
 	imply SND_SOC_RT1308
+	imply SND_SOC_RT5512
 	imply SND_SOC_RT5514
 	imply SND_SOC_RT5616
 	imply SND_SOC_RT5631
@@ -1311,6 +1312,15 @@ config SND_SOC_RT1316_SDW
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
 
+config SND_SOC_RT5512
+	tristate "Mediatek RT5512 speaker amplifier"
+	depends on I2C
+	help
+	  Config of RT5512. It is a Smart power
+	  amplifier which contain speaker protection,
+	  multi-band DRC, equalizer function. It would
+	  be set to yes if device with RT5512 on it.
+
 config SND_SOC_RT5514
 	tristate
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9170ee1447dd..13e79d735779 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -199,6 +199,7 @@ snd-soc-rt1316-sdw-objs := rt1316-sdw.o
 snd-soc-rt274-objs := rt274.o
 snd-soc-rt286-objs := rt286.o
 snd-soc-rt298-objs := rt298.o
+snd-soc-rt5512-objs := rt5512.o
 snd-soc-rt5514-objs := rt5514.o
 snd-soc-rt5514-spi-objs := rt5514-spi.o
 snd-soc-rt5616-objs := rt5616.o
@@ -554,6 +555,7 @@ obj-$(CONFIG_SND_SOC_RT1316_SDW)	+= snd-soc-rt1316-sdw.o
 obj-$(CONFIG_SND_SOC_RT274)	+= snd-soc-rt274.o
 obj-$(CONFIG_SND_SOC_RT286)	+= snd-soc-rt286.o
 obj-$(CONFIG_SND_SOC_RT298)	+= snd-soc-rt298.o
+obj-$(CONFIG_SND_SOC_RT5512)	+= snd-soc-rt5512.o
 obj-$(CONFIG_SND_SOC_RT5514)	+= snd-soc-rt5514.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI)	+= snd-soc-rt5514-spi.o
 obj-$(CONFIG_SND_SOC_RT5514_SPI_BUILTIN)	+= snd-soc-rt5514-spi.o
diff --git a/sound/soc/codecs/rt5512.c b/sound/soc/codecs/rt5512.c
new file mode 100644
index 000000000000..a843fd730df3
--- /dev/null
+++ b/sound/soc/codecs/rt5512.c
@@ -0,0 +1,860 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Mediatek Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/pm_qos.h>
+#include <linux/pm_runtime.h>
+#include <linux/version.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+
+#define RT5512_REV_A	(2)
+#define RT5512_REV_B	(3)
+
+#define RT5512_REG_DEVID		(0x00)
+#define RT5512_REG_SERIAL_DATA_STATUS	(0x01)
+#define RT5512_REG_SYSTEM_CTRL		(0x03)
+#define RT5512_REG_IRQ_EN		(0x04)
+#define RT5512_REG_IRQ_STATUS1		(0x05)
+#define RT5512_REG_SERIAL_CFG1		(0x10)
+#define RT5512_REG_DATAO_SEL		(0x12)
+#define RT5512_REG_TDM_CFG3		(0x15)
+#define RT5512_REG_HPF_CTRL		(0x16)
+#define RT5512_REG_HPF_COEF_1		(0x19)
+#define RT5512_REG_HPF_COEF_2		(0x1B)
+#define RT5512_REG_PATH_BYPASS		(0x1F)
+#define RT5512_REG_WDT_CTRL		(0x20)
+#define RT5512_REG_HCLIP_CTRL		(0x24)
+#define RT5512_REG_VOL_CTRL		(0x29)
+#define RT5512_REG_CLIP_CTRL		(0x30)
+#define RT5512_REG_CALI_T0		(0x3F)
+#define RT5512_REG_BST_CTRL		(0x40)
+#define RT5512_REG_BST_L1		(0x41)
+#define RT5512_REG_PROTECTION_CFG	(0x46)
+#define RT5512_REG_PLL_CFG1		(0x60)
+#define RT5512_REG_DRE_CTRL		(0x68)
+#define RT5512_REG_DRE_THDMODE		(0x69)
+#define RT5512_REG_FINE_RISING		(0x6C)
+#define RT5512_REG_FINE_FALLING		(0x6D)
+#define RT5512_REG_PWM_CTRL		(0x70)
+#define RT5512_REG_DC_PROTECT_CTRL	(0x74)
+#define RT5512_REG_DITHER_CTRL		(0x78)
+#define RT5512_REG_MISC_CTRL1		(0x98)
+#define RT5512_REG_GVSENSE_CONST	(0x9D)
+#define RT5512_REG_SPK_IB		(0xA2)
+#define RT5512_REG_ANA_SPK_CTRL6	(0xA6)
+#define RT5512_REG_NSW			(0xAD)
+#define RT5512_REG_VBG			(0xAE)
+#define RT5512_REG_BST_BIAS		(0xB0)
+#define RT5512_REG_VSADC_BLKBIAS	(0xB1)
+#define RT5512_REG_CS_CTRL		(0xB3)
+#define RT5512_REG_ANA_TOP_CTRL0	(0xB5)
+#define RT5512_REG_ANA_TOP_CTRL1	(0xB6)
+
+struct rt5512_chip {
+	struct i2c_client *i2c;
+	struct device *dev;
+	struct snd_soc_component *component;
+	struct mutex var_lock;
+	struct regmap *regmap;
+	int t0;
+	int pwr_cnt;
+	unsigned int ff_gain;
+	u16 chip_rev;
+	u8 bst_mode;
+	u8 dev_cnt;
+	struct pm_qos_request rt5512_qos_request;
+};
+
+static struct regmap_config rt5512_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = 0xff,
+};
+
+static int rt5512_codec_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* un-mute */
+		ret = snd_soc_component_update_bits(component, 0x03, 0x0002, 0);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		break;
+	}
+	return ret;
+}
+
+static int rt5512_codec_classd_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component =
+		snd_soc_dapm_to_component(w->dapm);
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/*  charge pump disable & disable UVP */
+		ret |= snd_soc_component_update_bits(component, 0xb5, 0xf9fc,
+						     0xf9fc);
+		mdelay(11);
+
+		dev_info(component->dev, "%s rt5512 update bst mode %d\n",
+			 __func__, chip->bst_mode);
+		/* boost config to adaptive mode */
+		ret = snd_soc_component_update_bits(component, 0x40, 0x0003,
+						    chip->bst_mode);
+		mdelay(2);
+
+		ret |= snd_soc_component_update_bits(component, 0x98, 0x0700,
+						     0x0100);
+		/* charge pump enable */
+		ret |= snd_soc_component_update_bits(component, 0xb5, 0x0001,
+						     0x0001);
+		break;
+	case SND_SOC_DAPM_POST_PMU:
+		mdelay(2);
+		ret |= snd_soc_component_update_bits(component, 0x98, 0x0200,
+						     0x0200);
+		dev_info(component->dev, "Amp on\n");
+		cpu_latency_qos_update_request(&chip->rt5512_qos_request,
+					       PM_QOS_DEFAULT_VALUE);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		dev_info(component->dev, "Amp off\n");
+		cpu_latency_qos_update_request(&chip->rt5512_qos_request, 150);
+
+		/* enable mute */
+		ret = snd_soc_component_update_bits(component, 0x03, 0x0002,
+						    0x0002);
+		/* Headroom 1.1V */
+		ret |= snd_soc_component_update_bits(component, 0x41, 0x00ff,
+						     0x002f);
+		ret |= snd_soc_component_update_bits(component, 0x98, 0x0010,
+						     0x0010);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		/* un-mute */
+		ret |= snd_soc_component_update_bits(component, 0x03, 0x0002,
+						     0x0000);
+		mdelay(2);
+
+		/* charge pump disable*/
+		ret |= snd_soc_component_update_bits(component, 0xb5, 0x0001,
+						     0x0000);
+
+		mdelay(1);
+		/* set boost to disable mode */
+		ret |= snd_soc_component_update_bits(component, 0x40, 0x0003,
+						     0x0000);
+		/* D_VBG, Bias current disable */
+		ret |= snd_soc_component_update_bits(component, 0xb5, 0xfffe,
+						     0x0000);
+		break;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static const char * const rt5512_i2smux_text[] = { "I2S1", "I2S2"};
+static SOC_ENUM_SINGLE_DECL(rt5512_i2s_muxsel,
+	SND_SOC_NOPM, 0, rt5512_i2smux_text);
+static const struct snd_kcontrol_new rt5512_i2smux_ctrl =
+	SOC_DAPM_ENUM("Switch", rt5512_i2s_muxsel);
+
+static const struct snd_soc_dapm_widget rt5512_component_dapm_widgets[] = {
+	SND_SOC_DAPM_MUX("I2S Mux", SND_SOC_NOPM, 0, 0, &rt5512_i2smux_ctrl),
+	SND_SOC_DAPM_DAC_E("DAC", NULL, RT5512_REG_PLL_CFG1,
+		0, 1, rt5512_codec_dac_event, SND_SOC_DAPM_POST_PMU),
+	SND_SOC_DAPM_ADC("VI ADC", NULL, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_PGA("PGA", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV_E("ClassD", RT5512_REG_SYSTEM_CTRL, 2, 0,
+			       NULL, 0, rt5512_codec_classd_event,
+			       SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
+			       SND_SOC_DAPM_PRE_PMD | SND_SOC_DAPM_POST_PMD),
+	SND_SOC_DAPM_SPK("SPK", NULL),
+};
+
+static const struct snd_soc_dapm_route rt5512_component_dapm_routes[] = {
+	{ "I2S Mux", "I2S1", "AIF1 Playback" },
+	{ "I2S Mux", "I2S2", "AIF2 Playback" },
+	{ "DAC", NULL, "I2S Mux" },
+	{ "PGA", NULL, "DAC" },
+	{ "ClassD", NULL, "PGA" },
+	{ "SPK", NULL, "ClassD" },
+	{ "VI ADC", NULL, "ClassD" },
+	{ "AIF1 Capture", NULL, "VI ADC" },
+};
+
+static int rt5512_component_get_t0(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+
+	dev_info(component->dev, "%s, chip->t0 = %d\n", __func__, chip->t0);
+	ucontrol->value.integer.value[0] = chip->t0;
+	return 0;
+}
+
+static int rt5512_get_bstmode(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = chip->bst_mode;
+	return 0;
+}
+
+static int rt5512_set_bstmode(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	chip->bst_mode = ucontrol->value.integer.value[0];
+	dev_info(component->dev, "%s, bst_mode = %d\n", __func__,
+		 chip->bst_mode);
+	return ret;
+}
+
+static int rt5512_codec_get_chiprev(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = chip->chip_rev & 0xf;
+	return 0;
+}
+
+static int rt5512_codec_put_istcbypass(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	int ret;
+
+	pm_runtime_get_sync(component->dev);
+	if (ucontrol->value.integer.value[0]) {
+		ret = snd_soc_component_update_bits(component,
+						    RT5512_REG_PATH_BYPASS,
+						    0x0004, 0x0004);
+	} else {
+		ret = snd_soc_component_update_bits(component,
+						    RT5512_REG_PATH_BYPASS,
+						    0x0004, 0x0000);
+	}
+	if (ret)
+		dev_err(component->dev, "%s set CC Max Failed\n", __func__);
+	pm_runtime_put_sync(component->dev);
+	return ret;
+}
+
+static int rt5512_codec_get_istcbypass(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	int ret;
+
+	pm_runtime_get_sync(component->dev);
+	ret = snd_soc_component_read(component, RT5512_REG_PATH_BYPASS);
+
+	if (ret > 0 && ret&0x0004)
+		ucontrol->value.integer.value[0] = 1;
+	else
+		ucontrol->value.integer.value[0] = 0;
+	pm_runtime_put_sync(component->dev);
+	return 0;
+}
+
+static int rt5512_codec_get_volsw(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	int ret;
+
+	pm_runtime_get_sync(component->dev);
+	ret = snd_soc_get_volsw(kcontrol, ucontrol);
+	if (ret < 0)
+		dev_err(component->dev, "%s get volsw fail\n", __func__);
+	pm_runtime_put_sync(component->dev);
+	return ret;
+}
+
+static int rt5512_codec_put_volsw(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component =
+		snd_soc_kcontrol_component(kcontrol);
+	int  put_ret = 0;
+
+	pm_runtime_get_sync(component->dev);
+	put_ret = snd_soc_put_volsw(kcontrol, ucontrol);
+	if (put_ret < 0)
+		dev_err(component->dev, "%s put volsw fail\n", __func__);
+	pm_runtime_put_sync(component->dev);
+	return put_ret;
+}
+
+static const DECLARE_TLV_DB_SCALE(vol_ctl_tlv, -1155, 5, 0);
+static const struct snd_kcontrol_new rt5512_component_snd_controls[] = {
+	SOC_SINGLE_EXT_TLV("Volume_Ctrl", RT5512_REG_VOL_CTRL, 0, 255,
+			   1, rt5512_codec_get_volsw, rt5512_codec_put_volsw,
+			   vol_ctl_tlv),
+	SOC_SINGLE_EXT("Data Output Left Channel Selection",
+		       RT5512_REG_DATAO_SEL, 3, 7, 0,
+		       rt5512_codec_get_volsw, rt5512_codec_put_volsw),
+	SOC_SINGLE_EXT("Data Output Right Channel Selection",
+		       RT5512_REG_DATAO_SEL, 0, 7, 0,
+		       rt5512_codec_get_volsw, rt5512_codec_put_volsw),
+	SOC_SINGLE_EXT("Audio Input Selection", RT5512_REG_DATAO_SEL,
+		       6, 3, 0,
+		       rt5512_codec_get_volsw, rt5512_codec_put_volsw),
+	SOC_SINGLE_EXT("IDAC Gain Selection", RT5512_REG_ANA_TOP_CTRL1,
+		       0, 31, 0,
+		       rt5512_codec_get_volsw, rt5512_codec_put_volsw),
+	SOC_SINGLE_EXT("VBAT BIT OUT EN", RT5512_REG_TDM_CFG3, 11, 1, 0,
+		       rt5512_codec_get_volsw, rt5512_codec_put_volsw),
+	SOC_SINGLE_EXT("Boost Mode", SND_SOC_NOPM, 0, 3, 0,
+		       rt5512_get_bstmode, rt5512_set_bstmode),
+	SOC_SINGLE_EXT("T0_SEL", SND_SOC_NOPM, 0, 7, 0,
+			rt5512_component_get_t0, NULL),
+	SOC_SINGLE_EXT("Chip_Rev", SND_SOC_NOPM, 0, 16, 0,
+			rt5512_codec_get_chiprev, NULL),
+	SOC_SINGLE_BOOL_EXT("IS_TC_BYPASS", SND_SOC_NOPM,
+		rt5512_codec_get_istcbypass, rt5512_codec_put_istcbypass),
+};
+
+static int rt5512_component_setting(struct snd_soc_component *component)
+{
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	ret = snd_soc_component_read(component, 0x4d);
+	if (ret < 0)
+		return -EIO;
+	chip->ff_gain = ret;
+	if (chip->chip_rev == RT5512_REV_A) {
+		/* RT5512A_RU012B_algorithm_20201110.lua */
+		ret |= snd_soc_component_update_bits(component, 0xA1, 0xff18,
+						     0x5b18);
+		ret |= snd_soc_component_write(component, 0x69, 0x0002);
+		ret |= snd_soc_component_write(component, 0x68, 0x000C);
+		ret |= snd_soc_component_write(component, 0x6C, 0x0010);
+		ret |= snd_soc_component_write(component, 0x6D, 0x0008);
+		ret |= snd_soc_component_write(component, 0x30, 0x0002);
+		ret |= snd_soc_component_write(component, 0xA7, 0x0A84);
+		ret |= snd_soc_component_write(component, 0x20, 0x00A2);
+		ret |= snd_soc_component_write(component, 0x8B, 0x0040);
+
+		/* BST optimizations for efficiency */
+		ret |= snd_soc_component_write(component, 0xAD, 0x40F7);
+		ret |= snd_soc_component_write(component, 0x41, 0x0028);
+		ret |= snd_soc_component_write(component, 0x49, 0x0495);
+		/* 2019.0821 */
+		ret |= snd_soc_component_write(component, 0x46, 0x001D);
+		ret |= snd_soc_component_write(component, 0x45, 0x5292);
+		ret |= snd_soc_component_write(component, 0x4C, 0x0293);
+
+		ret |= snd_soc_component_write(component, 0xA2, 0x355D);
+		ret |= snd_soc_component_update_bits(component, 0xAE, 0x00ff,
+						     0x0056);
+		ret |= snd_soc_component_write(component, 0xA5, 0x6612);
+		ret |= snd_soc_component_write(component, 0x70, 0x0021);
+		ret |= snd_soc_component_write(component, 0xA6, 0x3135);
+
+		/* boost THD performance enhance */
+		ret |= snd_soc_component_write(component, 0x9B, 0x5f37);
+		ret |= snd_soc_component_write(component, 0x4A, 0xD755);
+
+		/* V.I sense performance enhance */
+		ret |= snd_soc_component_write(component, 0xB3, 0x9103);
+		ret |= snd_soc_component_update_bits(component, 0xB1, 0xfff0,
+						     0xA5AA);
+		ret |= snd_soc_component_write(component, 0xB0, 0xD5A5);
+		ret |= snd_soc_component_write(component, 0x98, 0x8B8C);
+		ret |= snd_soc_component_write(component, 0x78, 0x00f2);
+
+		ret |= snd_soc_component_write(component, 0x9D, 0x00FC);
+		ret |= snd_soc_component_write(component, 0x38, 0x9BEB);
+		ret |= snd_soc_component_write(component, 0x39, 0x8BAC);
+		ret |= snd_soc_component_write(component, 0x3A, 0x7E7D);
+		ret |= snd_soc_component_write(component, 0x3B, 0x7395);
+		ret |= snd_soc_component_write(component, 0x3C, 0x6A68);
+		ret |= snd_soc_component_write(component, 0x3D, 0x6295);
+		ret |= snd_soc_component_write(component, 0x3E, 0x5BD4);
+
+		ret |= snd_soc_component_update_bits(component, 0x12, 0x0007, 0x0006);
+		ret |= snd_soc_component_update_bits(component, 0xB6, 0x0400, 0x0000);
+	} else if (chip->chip_rev == RT5512_REV_B) { /* REV_B */
+		/* RT5512B_RU012D_algorithm_20201110.lua */
+		ret |= snd_soc_component_update_bits(component, 0xA1, 0xff18, 0x5b18);
+		ret |= snd_soc_component_write(component, 0x69, 0x0002);
+		ret |= snd_soc_component_write(component, 0x68, 0x000C);
+		ret |= snd_soc_component_write(component, 0x6C, 0x0010);
+		ret |= snd_soc_component_write(component, 0x6D, 0x0008);
+		ret |= snd_soc_component_write(component, 0x30, 0x0002);
+		ret |= snd_soc_component_write(component, 0xA7, 0x0A84);
+		ret |= snd_soc_component_write(component, 0x20, 0x00A2);
+		ret |= snd_soc_component_write(component, 0x8B, 0x0040);
+
+		/* BST optimizations for efficiency */
+		ret |= snd_soc_component_write(component, 0xAD, 0x40F7);
+		ret |= snd_soc_component_write(component, 0x41, 0x0028);
+		ret |= snd_soc_component_write(component, 0x49, 0x0495);
+		/* 2019.0821 */
+		ret |= snd_soc_component_write(component, 0x46, 0x001D);
+		ret |= snd_soc_component_write(component, 0x45, 0x5292);
+		ret |= snd_soc_component_write(component, 0x4C, 0x0293);
+
+		ret |= snd_soc_component_write(component, 0xA2, 0x355D);
+		ret |= snd_soc_component_update_bits(component, 0xAE, 0x00ff, 0x0056);
+		ret |= snd_soc_component_write(component, 0xA5, 0x6612);
+		ret |= snd_soc_component_write(component, 0x70, 0x0021);
+		ret |= snd_soc_component_write(component, 0xA6, 0x3135);
+
+		/* boost THD performance enhance */
+		ret |= snd_soc_component_write(component, 0x9B, 0x5f37);
+		ret |= snd_soc_component_write(component, 0x4A, 0xD755);
+
+		/* V.I sense performance enhance */
+		ret |= snd_soc_component_write(component, 0xB3, 0x9103);
+		ret |= snd_soc_component_update_bits(component, 0xB1, 0xfff0, 0xA5AA);
+		ret |= snd_soc_component_write(component, 0xB0, 0xD5A5);
+		ret |= snd_soc_component_write(component, 0x98, 0x8B8C);
+		ret |= snd_soc_component_write(component, 0x78, 0x00f2);
+
+		ret |= snd_soc_component_write(component, 0x9D, 0x00FC);
+		ret |= snd_soc_component_write(component, 0x38, 0x9BEB);
+		ret |= snd_soc_component_write(component, 0x39, 0x8BAC);
+		ret |= snd_soc_component_write(component, 0x3A, 0x7E7D);
+		ret |= snd_soc_component_write(component, 0x3B, 0x7395);
+		ret |= snd_soc_component_write(component, 0x3C, 0x6A68);
+		ret |= snd_soc_component_write(component, 0x3D, 0x6295);
+		ret |= snd_soc_component_write(component, 0x3E, 0x5BD4);
+
+		ret |= snd_soc_component_update_bits(component, 0x12, 0x0007, 0x0006);
+		ret |= snd_soc_component_update_bits(component, 0xB6, 0x0400, 0x0000);
+	}
+
+	if (ret < 0)
+		return ret;
+	mdelay(5);
+	return 0;
+}
+
+static int rt5512_component_probe(struct snd_soc_component *component)
+{
+	struct rt5512_chip *chip = snd_soc_component_get_drvdata(component);
+	int ret = 0;
+
+	pm_runtime_get_sync(component->dev);
+
+	chip->component = component;
+	snd_soc_component_init_regmap(component, chip->regmap);
+
+	ret = rt5512_component_setting(component);
+	if (ret < 0) {
+		dev_err(chip->dev, "rt5512 component setting failed\n");
+		goto component_probe_fail;
+	}
+
+component_probe_fail:
+	pm_runtime_put_sync(component->dev);
+	return ret;
+}
+
+static void rt5512_component_remove(struct snd_soc_component *component)
+{
+	snd_soc_component_exit_regmap(component);
+}
+
+static const struct snd_soc_component_driver rt5512_component_driver = {
+	.probe = rt5512_component_probe,
+	.remove = rt5512_component_remove,
+
+	.controls = rt5512_component_snd_controls,
+	.num_controls = ARRAY_SIZE(rt5512_component_snd_controls),
+	.dapm_widgets = rt5512_component_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(rt5512_component_dapm_widgets),
+	.dapm_routes = rt5512_component_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(rt5512_component_dapm_routes),
+
+	.idle_bias_on = false,
+};
+
+static int rt5512_component_aif_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *hw_params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm =
+				     snd_soc_component_get_dapm(dai->component);
+	int word_len = params_physical_width(hw_params);
+	int aud_bit = params_width(hw_params);
+	u16 reg_data = 0;
+	int ret = 0;
+	char *tmp = "SPK";
+
+	dev_dbg(dai->dev, "%s: ++\n", __func__);
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dev_info(dai->dev, "format: 0x%08x, rate: 0x%08x, word_len: %d, aud_bit: %d\n",
+			 params_format(hw_params), params_rate(hw_params), word_len,
+			 aud_bit);
+	if (word_len > 32 || word_len < 16) {
+		dev_err(dai->dev, "not supported word length\n");
+		return -ENOTSUPP;
+	}
+	switch (aud_bit) {
+	case 16:
+		reg_data = 3;
+		break;
+	case 18:
+		reg_data = 2;
+		break;
+	case 20:
+		reg_data = 1;
+		break;
+	case 24:
+	case 32:
+		reg_data = 0;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+	ret = snd_soc_component_update_bits(dai->component,
+		RT5512_REG_SERIAL_CFG1, 0x00c0, (reg_data << 6));
+	if (ret < 0) {
+		dev_err(dai->dev, "config aud bit fail\n");
+		return ret;
+	}
+
+	ret = snd_soc_component_update_bits(dai->component,
+		RT5512_REG_TDM_CFG3, 0x03f0, word_len << 4);
+	if (ret < 0) {
+		dev_err(dai->dev, "config word len fail\n");
+		return ret;
+	}
+	dev_dbg(dai->dev, "%s: --\n", __func__);
+	return snd_soc_dapm_enable_pin(dapm, tmp);
+}
+
+static int rt5512_component_aif_hw_free(struct snd_pcm_substream *substream,
+				    struct snd_soc_dai *dai)
+{
+	struct snd_soc_dapm_context *dapm =
+				snd_soc_component_get_dapm(dai->component);
+	int ret = 0;
+	char *tmp = "SPK";
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+	dev_info(dai->dev, "%s successfully start\n", __func__);
+
+	ret = snd_soc_dapm_disable_pin(dapm, tmp);
+	if (ret < 0)
+		return ret;
+	return snd_soc_dapm_sync(dapm);
+}
+
+static const struct snd_soc_dai_ops rt5512_component_aif_ops = {
+	.hw_params = rt5512_component_aif_hw_params,
+	.hw_free = rt5512_component_aif_hw_free,
+};
+
+#define STUB_RATES	SNDRV_PCM_RATE_8000_192000
+#define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			SNDRV_PCM_FMTBIT_U16_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_U24_LE | \
+			SNDRV_PCM_FMTBIT_S32_LE | \
+			SNDRV_PCM_FMTBIT_U32_LE)
+
+static struct snd_soc_dai_driver rt5512_codec_dai[] = {
+	{
+		.name = "rt5512-aif",
+		.playback = {
+			.stream_name	= "AIF1 Playback",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates		= STUB_RATES,
+			.formats	= STUB_FORMATS,
+		},
+		.capture = {
+			.stream_name	= "AIF1 Capture",
+			.channels_min	= 1,
+			.channels_max	= 2,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+		/* dai properties */
+		.symmetric_rate = 1,
+		.symmetric_channels = 1,
+		.symmetric_sample_bits = 1,
+		/* dai operations */
+		.ops = &rt5512_component_aif_ops,
+	},
+	{
+		.name = "rt5512-aif2",
+		.playback = {
+			.stream_name = "AIF2 Playback",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = STUB_RATES,
+			.formats = STUB_FORMATS,
+		},
+		.ops = &rt5512_component_aif_ops,
+	},
+};
+
+static inline int _rt5512_chip_power_on(struct rt5512_chip *chip, int on_off)
+{
+	int ret = 0;
+
+	dev_info(chip->dev, "%s, %d\n", __func__, on_off);
+	ret =  regmap_write_bits(chip->regmap, RT5512_REG_SYSTEM_CTRL, 0xffff,
+				 on_off ? 0x0000 : 0x0001);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static inline int _rt5512_chip_sw_reset(struct rt5512_chip *chip)
+{
+	int ret;
+	u8 data[2] = {0x00, 0x00};
+	u8 reg_data[2] = {0x00, 0x80};
+
+	/* turn on main pll first, then trigger reset */
+	ret = i2c_smbus_write_i2c_block_data(chip->i2c, RT5512_REG_SYSTEM_CTRL,
+					     2, data);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_i2c_block_data(chip->i2c, RT5512_REG_SYSTEM_CTRL,
+					     2, reg_data);
+	if (ret < 0)
+		return ret;
+	mdelay(14);
+
+	if (chip->chip_rev == RT5512_REV_B) {
+		reg_data[0] = 0;
+		reg_data[1] = 0;
+		ret = i2c_smbus_write_i2c_block_data(chip->i2c, 0x98, 2,
+						     reg_data);
+		if (ret < 0) {
+			dev_err(chip->dev, "%s write 0x98 failed\n", __func__);
+			return ret;
+		}
+		mdelay(10);
+		reg_data[0] = 0xE1;
+		reg_data[1] = 0xFD;
+		ret = i2c_smbus_write_i2c_block_data(chip->i2c, 0xb5, 2,
+						     reg_data);
+		if (ret < 0) {
+			dev_err(chip->dev, "%s write 0xb5 failed\n", __func__);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static inline int rt5512_chip_id_check(struct rt5512_chip *chip)
+{
+	u8 id[2] = {0};
+	int ret = 0;
+	u8 data[2] = {0x00, 0x00};
+
+	ret = i2c_smbus_write_i2c_block_data(chip->i2c, RT5512_REG_SYSTEM_CTRL,
+					     2, data);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_read_i2c_block_data(chip->i2c, RT5512_REG_DEVID, 2, id);
+	if (ret < 0)
+		return ret;
+	if (id[0] != 0) {
+		dev_err(chip->dev, "%s device id not match, id = %x\n",
+			__func__, id[0]);
+		return -ENODEV;
+	}
+	chip->chip_rev = id[1];
+	if (chip->chip_rev != RT5512_REV_A && chip->chip_rev != RT5512_REV_B) {
+		dev_err(chip->dev, "%s chip rev not match, rev = %d\n",
+			__func__, chip->chip_rev);
+		return -ENODEV;
+	}
+	dev_info(chip->dev, "%s chip_rev = %d\n", __func__, chip->chip_rev);
+
+	ret = i2c_smbus_read_i2c_block_data(chip->i2c, RT5512_REG_CALI_T0, 2,
+					    id);
+	if (ret < 0)
+		return ret;
+	chip->t0 = id[1];
+	dev_info(chip->dev, "%s chip t0 = %d\n", __func__, chip->t0);
+
+	data[1] = 0x01;
+	ret = i2c_smbus_write_i2c_block_data(chip->i2c, RT5512_REG_SYSTEM_CTRL,
+					     2, data);
+	return ret;
+}
+
+static inline int rt5512_component_register(struct rt5512_chip *chip)
+{
+	return devm_snd_soc_register_component(chip->dev,
+					       &rt5512_component_driver,
+					       rt5512_codec_dai,
+					       ARRAY_SIZE(rt5512_codec_dai));
+}
+
+int rt5512_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct rt5512_chip *chip = NULL;
+	int ret = 0;
+	static int dev_cnt;
+
+	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+	chip->i2c = client;
+	chip->dev = &client->dev;
+	chip->dev_cnt = dev_cnt;
+	mutex_init(&chip->var_lock);
+	i2c_set_clientdata(client, chip);
+
+	ret = rt5512_chip_id_check(chip);
+	if (ret < 0) {
+		dev_err(&client->dev, "chip id check fail, ret = %d\n", ret);
+		return -ENODEV;
+	}
+
+	chip->bst_mode = 1; /* Battery Mode */
+
+	/* chip reset first */
+	ret = _rt5512_chip_sw_reset(chip);
+	if (ret < 0) {
+		dev_err(chip->dev, "chip reset fail\n");
+		goto probe_fail;
+	}
+
+	chip->regmap = devm_regmap_init_i2c(client, &rt5512_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "failed to initialise regmap: %d\n", ret);
+		return ret;
+	}
+
+	/* register qos to prevent deep idle during transfer */
+	cpu_latency_qos_add_request(&chip->rt5512_qos_request,
+				    PM_QOS_DEFAULT_VALUE);
+	ret = rt5512_component_register(chip);
+	if (!ret) {
+		pm_runtime_set_active(chip->dev);
+		pm_runtime_enable(chip->dev);
+	}
+	dev_info(chip->dev, "%s end, ret = %d\n", __func__, ret);
+	return ret;
+probe_fail:
+	_rt5512_chip_power_on(chip, 0);
+	mutex_destroy(&chip->var_lock);
+	return ret;
+}
+
+void rt5512_i2c_remove(struct i2c_client *client)
+{
+	struct rt5512_chip *chip = i2c_get_clientdata(client);
+
+	pm_runtime_disable(chip->dev);
+	pm_runtime_set_suspended(chip->dev);
+	mutex_destroy(&chip->var_lock);
+}
+
+static int __maybe_unused rt5512_i2c_runtime_suspend(struct device *dev)
+{
+	struct rt5512_chip *chip = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dev_info(dev, "enter low power mode\n");
+	ret = regmap_write_bits(chip->regmap, RT5512_REG_SYSTEM_CTRL,
+				0xffff, 0x0001);
+	cpu_latency_qos_update_request(&chip->rt5512_qos_request,
+				       PM_QOS_DEFAULT_VALUE);
+	if (ret < 0)
+		dev_err(dev, "%s ret = %d\n", __func__, ret);
+	return 0;
+}
+
+static int __maybe_unused rt5512_i2c_runtime_resume(struct device *dev)
+{
+	struct rt5512_chip *chip = dev_get_drvdata(dev);
+	int ret = 0;
+
+	/* update qos to prevent deep idle during transfer */
+	cpu_latency_qos_update_request(&chip->rt5512_qos_request, 150);
+	dev_info(dev, "exit low power mode\n");
+	ret = regmap_write_bits(chip->regmap,
+		RT5512_REG_SYSTEM_CTRL, 0xffff, 0x0000);
+	if (ret < 0)
+		dev_err(dev, "%s ret = %d\n", __func__, ret);
+	usleep_range(2000, 2100);
+	return 0;
+}
+
+static const struct dev_pm_ops rt5512_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(rt5512_i2c_runtime_suspend,
+			   rt5512_i2c_runtime_resume, NULL)
+};
+
+static const struct of_device_id __maybe_unused rt5512_of_id[] = {
+	{ .compatible = "richtek,rt5512",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, rt5512_of_id);
+
+static const struct i2c_device_id rt5512_i2c_id[] = {
+	{"rt5512", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, rt5512_i2c_id);
+
+static struct i2c_driver rt5512_i2c_driver = {
+	.driver = {
+		.name = "rt5512",
+		.of_match_table = of_match_ptr(rt5512_of_id),
+		.pm = &rt5512_dev_pm_ops,
+	},
+	.probe = rt5512_i2c_probe,
+	.remove = rt5512_i2c_remove,
+	.id_table = rt5512_i2c_id,
+};
+module_i2c_driver(rt5512_i2c_driver);
+
+MODULE_AUTHOR("Jeff Chang <jeff_chang@richtek.com>");
+MODULE_DESCRIPTION("RT5512 SPKAMP Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("2.0.5_M");
-- 
2.17.1

