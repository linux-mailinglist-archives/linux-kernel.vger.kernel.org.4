Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19D46B468D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjCJOoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjCJOnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:43:46 -0500
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E601EFCF1F;
        Fri, 10 Mar 2023 06:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678459421;
        bh=UGzmVkXCL+1EkPSwzlDgNi3i411tT8zWbKctyhvLmow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vIeVl9ykyZz35GKcZWAPeSCGGw2SH6irRPNoyyT1IFXDepP7t/PWaMf5PY6rTLA6P
         +d/h3w18YitflKHhr10lUIBnZm83fnKNB/20uZ1NJqtl5MJdqQwpzH7Az8ta1gwz0d
         mfXA0g8AKYm+Ln/h8LOYN0Phh0X5cQWbc6tqPZK4=
Received: from DESKTOP-ZMX.localdomain ([115.156.143.0])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 8A61225E; Fri, 10 Mar 2023 22:34:38 +0800
X-QQ-mid: xmsmtpt1678458904tlpmm9eo4
Message-ID: <tencent_62395CA0D608DD0078DD3D889F6E4E22BA05@qq.com>
X-QQ-XMAILINFO: NupD2wIGF7MkbLXrURGLr0r0johuVIoGwBoq/JHBCOruw2uSS9jS+BMqd9dldZ
         qVJLBxTB9v93hyTPPsO2OMwOSJqVqimvxSCU+OIhe9JhtTCjUcI3IaK8f+RW71xY+qIkO1ctmD2H
         c17ZnkE+HhOaJxwiXLa/iB7pTywZFrIGfNpK9J6ZjhO1H1mVn15DgzCWmonXqtCSS7SblPip83rm
         7bqPhguIrqnq63bThqEhunaHhY3QU6jZVcNhjuU2en84POVg7VkBLW2RAklAw95o7aYUyACL0qrd
         EWJgeV2VGpuF3HSH9UoR6M61+4b+y5bj58xIIrdASUGCj8RWgbxc+jBIXrxRtogFJg3Ut9g59Pp2
         u3PvEHnKdYW8qimtkb9XMtdRC6xiISrZqtPa0MboJIelvVD2LoX5zgK+QFBxHVyJdTPnQ+5EeQny
         h8rle+kEBGvtUP6c+3I6C+2H/a/Uk03Md6B0GYBgu3Vvkk0H/7Nl7pXROhEhvnvdqG8RCzeSa9oD
         IFmzItzrW2Bi5JBWH1gWH4k1VYloU5+4YmCYu5+KRAPm+nC8a8BhARaG3YdfJzly3n91VlzefipC
         YFdYzmVfamzCKn8tdPZGiPgEKkQyVcEGCtSKrWBef5QEpyflrK/+U8r6igjm7u/fKFkOVqGi2+Hu
         3+OhomhkDzBUU5faUhK0M4yEYzWiXdzoYMQZYsq3g1MArnt6R6+3gvNldW9r0l3uOz9hP2Y19QDp
         uz7luM73o+XFnVSZ/35vxf0pAzZS+T7s4yM8KuGdjpA9my3RhVhwd40JykS/bqHgrDinm7AfzFwn
         cVqa1o2h8MznjP1fTQRJOYquySrxSBdNqBRMPXM6aEiREid5Xlq/bQwUEQI36wLQMNUcBKvKDPqS
         2LPE6yh9qU0jTr4eW1MomXxlrEyp0qUVn5VQFHjeWDXhrAq/QjrjnlN2zPLe4ij1mFapvIhmip3/
         armkDUMlIEmUtmmMUpsCL7Nf6BgRbtZyLQ6mhphl776WQAzuEltzuwEGdiE6s1WV1iBhu0x0g=
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 3/3] arm64: dts: qcom: msm8916-yiming-uz801v3: Add initial device tree
Date:   Fri, 10 Mar 2023 22:33:30 +0800
X-OQ-MSGID: <20230310143330.9485-4-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230310143330.9485-1-forbidden405@foxmail.com>
References: <20230310143330.9485-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds support for the uz801 v3.0 WiFi/LTE dongle made by
Henan Yiming Technology Co., Ltd. based on MSM8916.

Note: The original firmware does not support 64-bit OS. It is necessary
to flash 64-bit TZ firmware to boot arm64.

Currently supported:
- All CPU cores
- Buttons
- LEDs
- Modem
- SDHC
- USB Device Mode
- UART

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../boot/dts/qcom/msm8916-yiming-uz801v3.dts  | 35 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31aa54f0428c3..0c4c71d6277b7 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-samsung-serranove.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-uf896.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-thwc-ufi001c.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-wingtech-wt88047.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-yiming-uz801v3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-motorola-potter.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-daisy.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8953-xiaomi-mido.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
new file mode 100644
index 0000000000000..74ce6563be183
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/dts-v1/;
+
+#include "msm8916-ufi.dtsi"
+
+/ {
+	model = "uz801 v3.0 4G Modem Stick";
+	compatible = "yiming,uz801-v3", "qcom,msm8916";
+};
+
+&button_restart {
+	gpios = <&msmgpio 23 GPIO_ACTIVE_LOW>;
+};
+
+&led_r {
+	gpios = <&msmgpio 7 GPIO_ACTIVE_HIGH>;
+};
+
+&led_g {
+	gpios = <&msmgpio 8 GPIO_ACTIVE_HIGH>;
+};
+
+&led_b {
+	gpios = <&msmgpio 6 GPIO_ACTIVE_HIGH>;
+};
+
+&button_default {
+	pins = "gpio23";
+	bias-pull-up;
+};
+
+&gpio_leds_default {
+	pins = "gpio6", "gpio7", "gpio8";
+};
-- 
2.39.1

