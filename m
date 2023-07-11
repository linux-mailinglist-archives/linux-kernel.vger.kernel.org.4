Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E78174F8A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGKUCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGKUB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:01:56 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16C51710;
        Tue, 11 Jul 2023 13:01:53 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id CEF2E12000D;
        Tue, 11 Jul 2023 23:01:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CEF2E12000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689105710;
        bh=m9C1KL5cCkterbhi7MeVtxjNf/UJZRZoiiyKbjEZRt0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=dhfBdqp0x9seZw2TSC7QnjYSH3Ide6WpYd3rpFCQRhLcXuQN7DbZpj9/195/066Bh
         10lo4lKpw5lYmUYNyOKOKtzlTXXTjCVEqjD2BbHqykvgwK+5gtxVE5uPqj/tRROrVH
         hv+R0qyCAYxViChxCkoSk5tRHaJHL9n2wzcCvLgghiClxgE0HbVFhaVFpcTnKMIa/4
         4/PRuHBWCj9S5/29JSGg5VVVINO82a3uqLTE3LVEag2gs87g4ylmd7THUPbWtlif2R
         MLeAUp9hqT01XCRIX4pculOkC4RRHWOGaPudM57qheCmCkJu/AcH83bzYo5BAV2iyD
         H2ki+ZUeoUACA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue, 11 Jul 2023 23:01:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 11 Jul 2023 23:01:40 +0300
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
Subject: [PATCH v5 2/6] iio: adc: meson: move enums declaration before variables declaration
Date:   Tue, 11 Jul 2023 23:00:18 +0300
Message-ID: <20230711200141.239025-3-gnstark@sberdevices.ru>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711200141.239025-1-gnstark@sberdevices.ru>
References: <20230711200141.239025-1-gnstark@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178558 [Jul 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: GNStark@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 521 521 0c3391dd6036774f2e1052158c81e48587b96e95, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/11 13:07:00 #21597915
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to use enum items for variables initialization.
For this, move enums upper in the code.

Signed-off-by: George Stark <GNStark@sberdevices.ru>
---
 drivers/iio/adc/meson_saradc.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 569ffc178935..98b6697a21f6 100644
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
@@ -225,28 +247,6 @@ static const struct iio_chan_spec meson_sar_adc_and_temp_iio_channels[] = {
 	MESON_SAR_ADC_TEMP_CHAN(8),
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

