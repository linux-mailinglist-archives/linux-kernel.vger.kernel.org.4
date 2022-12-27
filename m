Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E065696A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 11:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiL0KYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 05:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiL0KYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 05:24:02 -0500
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39BD9FE2;
        Tue, 27 Dec 2022 02:23:59 -0800 (PST)
Received: from pro2.mail.ovh.net (unknown [10.109.146.229])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 8F372147C1C0A;
        Tue, 27 Dec 2022 11:07:08 +0100 (CET)
Received: from localhost.localdomain (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Tue, 27 Dec
 2022 11:07:07 +0100
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
To:     <lee@kernel.org>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <sven.schwermer@disruptive-technologies.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <johan+linaro@kernel.org>, <marijn.suijten@somainline.org>,
        <bjorn.andersson@linaro.org>, <andy.shevchenko@gmail.com>,
        <jacek.anaszewski@gmail.com>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Subject: [RESEND PATCH v6 6/6] leds: Add a multicolor LED driver to group monochromatic LEDs
Date:   Tue, 27 Dec 2022 11:06:59 +0100
Message-ID: <20221227100659.157071-7-jjhiblot@traphandler.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221227100659.157071-1-jjhiblot@traphandler.com>
References: <20221227100659.157071-1-jjhiblot@traphandler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG3EX1.emp2.local (172.16.2.21) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 14108651734926113243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedriedtgdduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgjfhgggfgtihesthekredtredttdenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepudetveelveevgffgvdeuffffjefhheehueeitdegtdejgefhheeuuddugeeffeeunecukfhppeduvdejrddtrddtrddupdekkedrudeiuddrvdehrddvfeefnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdpphgrvhgvlhesuhgtfidrtgiipdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpshhvvghnrdhstghhfigvrhhmvghrseguihhsrhhuphhtihhvvgdqthgvtghhnhholhhoghhivghsrdgtohhmpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdhjohhhrghnodhlihhnrghroheskhgvrhhnvghlrdhorhhgpdhmrghrihhjnhdrshhuihhjthgvnhesshhomhgrihhnlhhinhgvrd
 horhhgpdgsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprghnugihrdhshhgvvhgthhgvnhhkohesghhmrghilhdrtghomhdpjhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmpdhlihhnuhigqdhlvggushesvhhgvghrrdhkvghrnhgvlhdrohhrghdpuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhohedvkedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By allowing to group multiple monochrome LED into multicolor LEDs,
all involved LEDs can be controlled in-sync. This enables using effects
using triggers, etc.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 drivers/leds/rgb/Kconfig                 |  10 ++
 drivers/leds/rgb/Makefile                |   1 +
 drivers/leds/rgb/leds-group-multicolor.c | 168 +++++++++++++++++++++++
 3 files changed, 179 insertions(+)
 create mode 100644 drivers/leds/rgb/leds-group-multicolor.c

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 204cf470beae..1a87f53faa8a 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -2,6 +2,16 @@
 
 if LEDS_CLASS_MULTICOLOR
 
+config LEDS_GRP_MULTICOLOR
+	tristate "Multi-color LED grouping support"
+	depends on COMPILE_TEST || OF
+	help
+	  This option enables support for monochrome LEDs that are
+	  grouped into multicolor LEDs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called leds-grp-multicolor.
+
 config LEDS_PWM_MULTICOLOR
 	tristate "PWM driven multi-color LED Support"
 	depends on PWM
diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
index 0675bc0f6e18..4de087ad79bc 100644
--- a/drivers/leds/rgb/Makefile
+++ b/drivers/leds/rgb/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_LEDS_GRP_MULTICOLOR)	+= leds-group-multicolor.o
 obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
 obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
diff --git a/drivers/leds/rgb/leds-group-multicolor.c b/drivers/leds/rgb/leds-group-multicolor.c
new file mode 100644
index 000000000000..1766642c7604
--- /dev/null
+++ b/drivers/leds/rgb/leds-group-multicolor.c
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * multi-color LED built with monochromatic LED devices
+ *
+ * Copyright 2022 Jean-Jacques Hiblot <jjhiblot@traphandler.com>
+ */
+
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+struct led_mcg_priv {
+	struct led_classdev_mc mc_cdev;
+	struct led_classdev **monochromatics;
+};
+
+static int led_mcg_set(struct led_classdev *cdev,
+			  enum led_brightness brightness)
+{
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	struct led_mcg_priv *priv = container_of(mc_cdev, struct led_mcg_priv, mc_cdev);
+	const unsigned int mc_max_brightness = mc_cdev->led_cdev.max_brightness;
+	int i;
+
+	for (i = 0; i < mc_cdev->num_colors; i++) {
+		struct led_classdev *mono = priv->monochromatics[i];
+		const unsigned int mono_max = mono->max_brightness;
+		unsigned int rel_intensity = mc_cdev->subled_info[i].intensity;
+		int b;
+
+		/*
+		 * Scale the brightness according to relative intensity of the
+		 * color AND the max brightness of the monochromatic LED.
+		 */
+		b = DIV_ROUND_CLOSEST(brightness * rel_intensity * mono_max,
+			mc_max_brightness * mc_max_brightness);
+
+		led_set_brightness(mono, b);
+	}
+
+	return 0;
+}
+
+static void restore_sysfs_access(void *data)
+{
+	struct led_classdev *led_cdev = data;
+
+	mutex_lock(&led_cdev->led_access);
+	led_sysfs_enable(led_cdev);
+	mutex_unlock(&led_cdev->led_access);
+}
+
+static int led_mcg_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct led_init_data init_data = {};
+	struct led_classdev *cdev;
+	struct mc_subled *subled;
+	struct led_mcg_priv *priv;
+	unsigned int max_brightness;
+	int i, count, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	count = 0;
+	max_brightness = 0;
+	for (;;) {
+		struct led_classdev *led_cdev;
+
+		led_cdev = devm_of_led_get_optional(dev, count);
+
+		if (IS_ERR(led_cdev))
+			return dev_err_probe(dev, PTR_ERR(led_cdev),
+					     "Unable to get led #%d", count);
+
+		/* Reached the end of the list ?*/
+		if (!led_cdev)
+			break;
+
+		count++;
+
+		priv->monochromatics = devm_krealloc_array(dev, priv->monochromatics,
+					count, sizeof(*priv->monochromatics),
+					GFP_KERNEL);
+		if (!priv->monochromatics)
+			return -ENOMEM;
+
+		priv->monochromatics[count - 1] = led_cdev;
+
+		max_brightness = max(max_brightness, led_cdev->max_brightness);
+	}
+
+	subled = devm_kcalloc(dev, count, sizeof(*subled), GFP_KERNEL);
+	if (!subled)
+		return -ENOMEM;
+	priv->mc_cdev.subled_info = subled;
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		subled[i].color_index = led_cdev->color;
+		/* configure the LED intensity to its maximum */
+		subled[i].intensity = max_brightness;
+	}
+
+	/* init the multicolor's LED class device */
+	cdev = &priv->mc_cdev.led_cdev;
+	cdev->flags = LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = led_mcg_set;
+	cdev->max_brightness = max_brightness;
+	cdev->color = LED_COLOR_ID_MULTI;
+	priv->mc_cdev.num_colors = count;
+
+	init_data.fwnode = dev_fwnode(dev);
+	ret = devm_led_classdev_multicolor_register_ext(dev, &priv->mc_cdev,
+							&init_data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+			"failed to register multicolor led for %s.\n",
+			cdev->name);
+
+	ret = led_mcg_set(cdev, cdev->brightness);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set led value for %s.",
+				     cdev->name);
+
+	for (i = 0; i < count; i++) {
+		struct led_classdev *led_cdev = priv->monochromatics[i];
+
+		/* Make the sysfs of the monochromatic LED read-only */
+		mutex_lock(&led_cdev->led_access);
+		led_sysfs_disable(led_cdev);
+		mutex_unlock(&led_cdev->led_access);
+
+		/* Restore sysfs access when the multicolor LED is released */
+		devm_add_action_or_reset(dev, restore_sysfs_access, led_cdev);
+	}
+
+	return 0;
+}
+
+static const struct of_device_id of_led_mcg_match[] = {
+	{ .compatible = "leds-group-multicolor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_led_mcg_match);
+
+static struct platform_driver led_mcg_driver = {
+	.probe		= led_mcg_probe,
+	.driver		= {
+		.name	= "leds_group_multicolor",
+		.of_match_table = of_led_mcg_match,
+	}
+};
+module_platform_driver(led_mcg_driver);
+
+MODULE_AUTHOR("Jean-Jacques Hiblot <jjhiblot@traphandler.com>");
+MODULE_DESCRIPTION("multi-color LED group driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:leds-group-multicolor");
-- 
2.25.1

