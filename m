Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCDB68E897
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjBHG5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBHG5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:24 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE4241E8;
        Tue,  7 Feb 2023 22:57:23 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LhPuw-1omF2x2xaS-00mXvd; Wed, 08 Feb 2023 07:57:08 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>
Subject: [PATCH v7 04/10] firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains
Date:   Wed,  8 Feb 2023 07:56:35 +0100
Message-Id: <20230208065641.23544-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8z/dM6R4fOkz3siVjLs2DNqPqf9ERzK24v6zMkgYrSf9p6CMkUt
 /5Tmd0flfqaNkSx/gM2sqjeFmzXmgQ+qoU/IrOJuVkGsKiNgv6ByjCj7oeSPkQDmm5kaPRc
 sd9XurSU9Xg4Ee/Ev2AljUOhrA/pZkolTDEwHfI5bU6taZM6rW0vAAwN9cGz0jMpGciDxt4
 ucLZJ5TzmQwBSzTlqK8Uw==
UI-OutboundReport: notjunk:1;M01:P0:jPh6HV837kc=;YPd23tpIRcktikbBEAHIuLeDpQ6
 G6YuvW50MSXBPsPKq14YEWAUKK/XdEE0bfk4hRMbpM+8Z4duiXYLkVsS3Af8FsKIJahknAyZj
 hwFGm0JcnzE5eTcJnSSaAW4h7UAL4nuZLQoBWxB6vPGp1A0IgZD5n3Mp+QIQzJ7oJtKUlJMvj
 kIT7P+vOyRjQNpy1faikyCWNnv2NqTHGDVgxzOODCRrbcEpmLo3qgWHsDFfkosrSuVmeU0cLW
 8cuez14nFcFHedOfA6BUc9qsRfMMQN98bd887Lu5HGcaNPhCo9Tk8uza3Sp7oK2d9wyVi3OEM
 mAHbb6EAZ2WLasQQxg+Rma2BdRV1KVTlv0zzGnDN+GtaZx8UyIGBcCDCsGAl3r0NF5VGtGDFf
 IPeK8OKzhjmuwdYvJRNn9sdNbA3KEdMa+qFLrWYtEr/Q4BVsVfVVlFEWOXVYgzlCV+5P+DsYr
 8997fTnOygMgk0DCYy4nj5M9FbEDhTafwIFvdtJgQ7tAZD8+3VxSaQv3IiTTn5Ff6nxA3MwgZ
 baCPQe0Gsc9ipF69RAZRQoiDPeVF4e73kNHOqfnTIR/mzA6PVj4FfKzRGokJhdjbKfroxYlZB
 ZLiqeUhMYaB9iblR5wBZnHehrQmz9J03/zDnjUeAlLEPhFLF/G+dmkNRLimJ/gFRngPrKE4Pt
 hqZBmbqWPYdwXpJq0ez8ncgUu0LgpiwL8DTx3/bLKg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

(no changes since v4)

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
2.36.1

