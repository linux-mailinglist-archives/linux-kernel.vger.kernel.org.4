Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238717406CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjF0XTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF0XTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:19:08 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57CC2941
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:19:06 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id E3171120005;
        Wed, 28 Jun 2023 01:40:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru E3171120005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687905630;
        bh=LSrYU9Za3aez8EGwCKmAePmxhFcW4UYhK9sMcYhgfkg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=n7f8qvfHYgfGX/Pfta/RcE08RYeM0CO7vAv1eNMXrRhn4ov5WApS+EeNq4c/XC+2s
         XAyrOTawobECKrBgGatDt0c7kmT6HcQPSoNPdj+aNoj+BGWGBFpXsNwzPbIDBmzt/m
         wz51uQN3s02lwDUpfTfwunSm4pyr+/W2yMctLoDDEK0MbcY450uCg0nBy+eXo5kKyy
         ORVUtxqBSdA9TEPg375XIzcAIEHnWypsb82QwgSUzTmFMpWOS1B5MTooqsTQ0A2201
         soU307sdVJbAix4f1AvkRa4186LyEEqhQqVZIZ6Zb+Cfjo3uDWJycxhK97eFKlEU+L
         bURLeV3kaKPtw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Wed, 28 Jun 2023 01:40:29 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 28 Jun 2023 01:39:34 +0300
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
Subject: [PATCH v3 1/5] meson saradc: move enums declaration before variables declaration
Date:   Wed, 28 Jun 2023 01:37:14 +0300
Message-ID: <20230627224017.1724097-2-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627224017.1724097-1-gnstark@sberdevices.ru>
References: <20230627224017.1724097-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178297 [Jun 27 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 517 517 b0056c19d8e10afbb16cb7aad7258dedb0179a79, {Tracking_from_domain_doesnt_match_to}, p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/06/27 18:27:00 #21588965
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

