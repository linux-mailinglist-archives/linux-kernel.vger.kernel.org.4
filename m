Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43A66715A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjARH4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjARHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7331632E55;
        Tue, 17 Jan 2023 23:27:39 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M1lwy-1oSoqg1fg2-00toWx; Wed, 18 Jan 2023 08:27:29 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v4 04/17] firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains
Date:   Wed, 18 Jan 2023 08:26:42 +0100
Message-Id: <20230118072656.18845-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dCnhbYnZyKaso4/FN13s8VwCP5IQKAEKOdlIBFR9MwXN9ozp1Sj
 dksMR1ylutde+vWukfuPSNZK+W3M4Lv1FbYXnPMti/dvvPq+yrkAQgb/kTld2dxq1Cb0hIw
 6CoUpMgHPhsGpedgvAy9FyqBlkmQSjnA9hYCb/bgVJHGhERem9LYsVxzTLzbPhMuLfL4D3Q
 dxFw9roguhDIwLlIBILrw==
UI-OutboundReport: notjunk:1;M01:P0:X0a/GcqDZIM=;0qd0s/JIUMZxIl/+J0wG6H1eQco
 l/I1qY+HUgTv+zbdoANANWmwKwjCEgyAp+oLbRsHwP6WWfv/bDzxK63cXuVwHdg/ejXHFgOTt
 7nOPQkW5L/aJA+RdfPn3L+e1mHhMwywAhQTYwAMTfSGKmBf1Ndzw9SG1sMtxiPDikg8EYJH+y
 HtdXZkQMk5oc7kkChNNDI+2H4/i6smmg3bQxBz/Wc2/Yad5504SPUSIxQ0CWkh/AkT9ookxK5
 l/a2HIuOmhawLXZQjRIh01wZ0bd8H/xH3EPPZbrejHyRoE6IUkwN14jBDQgFHPrsOmDOELAm+
 V/nROKhIumxp+OOGTfbQYysWcTrCZpaRg135kpCLNi71FzqlVU9SwJB7S22MBuezvyMGW8z6K
 TJvOu6NBxBHGZ71ghGwdP9hIRTfsHH6RnyjJrqsEShu6o/DRHUo0VpOFlmWPbC2C7fTvYQfle
 usCUvAxyrkfGNzomzDaNiWm8JJzeSlA7D7CyvFpV8KanHfNoXhGVbHk0Xw8YI3g1hzNyMJCb9
 NUuTQANh85WiZxmNpuwQWMEy+pXeT3yK2a7B9fY6y7vFcTCI/OKIcbfwtBcidB/+duhfPaJ8W
 KVMXX63rCHhFwu31BaGIVhl+Zl/5tgxObuTvWjiE8iTG1GipgAPKvGXmjH2PyWsQUWcu/SfAR
 iC6zWSgkLNgNRtSYw1oIqbeScdIeT13NJQg+HGZ71Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clark Wang <xiaoning.wang@nxp.com>

LVDS' lpi2c and pwm power domains definitions are missed.
Add them here.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch inspired by the following downstream patch:
  commit 0c36c5b63c1e ("LF-3569-1 firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains")
  Avoiding the following being reported upon boot:
  [    1.309776] lvds0_pwm0_clk: failed to attached the power domain -2
  [    1.334097] lvds1_pwm0_clk: failed to attached the power domain -2
  ...
  [   15.281767] platform 57244000.pwm: deferred probe pending
  ...
  [   15.292630] platform backlight: deferred probe pending

 drivers/firmware/imx/scu-pd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 2a4f07423365..84b673427073 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -180,7 +180,11 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* LVDS SS */
 	{ "lvds0", IMX_SC_R_LVDS_0, 1, false, 0 },
+	{ "lvds0-pwm", IMX_SC_R_LVDS_0_PWM_0, 1, false, 0 },
+	{ "lvds0-lpi2c", IMX_SC_R_LVDS_0_I2C_0, 2, true, 0 },
 	{ "lvds1", IMX_SC_R_LVDS_1, 1, false, 0 },
+	{ "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
+	{ "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
 
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
-- 
2.35.1

