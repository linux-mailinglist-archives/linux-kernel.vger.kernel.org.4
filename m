Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F329873AE8F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 04:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjFWCYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 22:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWCX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 22:23:58 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CE41BC1;
        Thu, 22 Jun 2023 19:23:52 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id D6FCE5FD25;
        Fri, 23 Jun 2023 05:23:49 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687487029;
        bh=LSrYU9Za3aez8EGwCKmAePmxhFcW4UYhK9sMcYhgfkg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=EQi9Aw6+t23MHwjeQar8O0FWuOMHEnCzaUQidDb9YTt3HUkgFfZnb6hxTtWmPBZeX
         sGkFA1+t5fIr9CnVj9GdZTTREtt64oCsLUfurdf4yY+zg2oXfYVdg2068VpBbjQZEX
         Ph74+kLp3IBFYLDh1HjwQzBG6dolzuu7s1+ZibVPczRS92u6frNvx+bXNI1I8i4L7Z
         isbuhPBikYFJ21rbl41Ebprxlwiz0Kti/j0diu52gN0mdDXoHPNFFVZXJAZ0AArlOE
         6HmUYvgMhfRBkPCTE3oMwBkjeVIbamFnLXaEHm6Yq1TqXDHv8wDRM1xoJT0Hecy9CY
         iqoinOYJPYwgw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 23 Jun 2023 05:23:49 +0300 (MSK)
From:   George Stark <gnstark@sberdevices.ru>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>,
        <andriy.shevchenko@linux.intel.com>, <nuno.sa@analog.com>,
        <gnstark@sberdevices.ru>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <kernel@sberdevices.ru>,
        George Stark <GNStark@sberdevices.ru>
Subject: [PATCH v2 1/6] meson saradc: move enums declaration before variables declaration
Date:   Fri, 23 Jun 2023 05:20:09 +0300
Message-ID: <20230623022334.791026-2-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623022334.791026-1-gnstark@sberdevices.ru>
References: <20230623022334.791026-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 21:10:00 #21557945
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move enums declaration before variables declaration.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 18937a262af6..af38d95bd504 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -202,6 +202,28 @@
 	.datasheet_name = "TEMP_SENSOR",				\
 }
 
+enum meson_sar_adc_avg_mode {
+	NO_AVERAGING = 0x0,
+	MEAN_AVERAGING = 0x1,
+	MEDIAN_AVERAGING = 0x2,
+};
+
+enum meson_sar_adc_num_samples {
+	ONE_SAMPLE = 0x0,
+	TWO_SAMPLES = 0x1,
+	FOUR_SAMPLES = 0x2,
+	EIGHT_SAMPLES = 0x3,
+};
+
+enum meson_sar_adc_chan7_mux_sel {
+	CHAN7_MUX_VSS = 0x0,
+	CHAN7_MUX_VDD_DIV4 = 0x1,
+	CHAN7_MUX_VDD_DIV2 = 0x2,
+	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
+	CHAN7_MUX_VDD = 0x4,
+	CHAN7_MUX_CH7_INPUT = 0x7,
+};
+
 static const struct iio_chan_spec meson_sar_adc_iio_channels[] = {
 	MESON_SAR_ADC_CHAN(0),
 	MESON_SAR_ADC_CHAN(1),
@@ -227,28 +249,6 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(9),
 };
 
-enum meson_sar_adc_avg_mode {
-	NO_AVERAGING = 0x0,
-	MEAN_AVERAGING = 0x1,
-	MEDIAN_AVERAGING = 0x2,
-};
-
-enum meson_sar_adc_num_samples {
-	ONE_SAMPLE = 0x0,
-	TWO_SAMPLES = 0x1,
-	FOUR_SAMPLES = 0x2,
-	EIGHT_SAMPLES = 0x3,
-};
-
-enum meson_sar_adc_chan7_mux_sel {
-	CHAN7_MUX_VSS = 0x0,
-	CHAN7_MUX_VDD_DIV4 = 0x1,
-	CHAN7_MUX_VDD_DIV2 = 0x2,
-	CHAN7_MUX_VDD_MUL3_DIV4 = 0x3,
-	CHAN7_MUX_VDD = 0x4,
-	CHAN7_MUX_CH7_INPUT = 0x7,
-};
-
 struct meson_sar_adc_param {
 	bool					has_bl30_integration;
 	unsigned long				clock_rate;
-- 
2.38.4

