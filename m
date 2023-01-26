Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952D967C971
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjAZLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbjAZLJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:19 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B63E0B9;
        Thu, 26 Jan 2023 03:09:18 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MWDHz-1pADPd1HHV-00XLGB;
 Thu, 26 Jan 2023 12:09:04 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v5 04/10] firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains
Date:   Thu, 26 Jan 2023 12:08:27 +0100
Message-Id: <20230126110833.264439-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g9rJbsNAMkGKWFW/+p94zF4HAvZrYUgNKwgUsv7S3vBGfWkFJoJ
 7LV5pqSAun0VNMfwnlxxUVFYMoR3cjve2PNVVDIDZk7dT8X+diA6iIkUuNggdNY86fPuo+Y
 Up0x9d23B/UIHniC7jLy6k9l3moSILlVwlkAWTIyD1x3z28U0Dsqj38ObjsRmiDtvQLZoD0
 chi/ENxf3Hu8BPbG1qHkQ==
UI-OutboundReport: notjunk:1;M01:P0:5b1N6F5WFLI=;+wO+ZSMpU03z/R3+DzT5Q17k/+q
 +L206R8q7lqj7xmhsG+P6nfPmIltEuQNC2IjPwDLzFxFcx+uCu7lJCPnnTKXljDeUw5aYiqBe
 QDt3ZQhkky+rgs/8P3x2E6D1z7qf/3tnlmn4RIVJiVbyS1awgBd/zNRxUR02rWa6JeuhT6ZFt
 UonhC5G9gyuEAHiv6lNYJadgEw5qDFzsQR1RO3GuTeB2qkMorsMXJvsTI7Sdz2LMLk3/BNsye
 s/eSuGdjd8lWB/p4AdVbnVGoBjRd2XPQntQq9Vjrir0D8KDkTEKH964rO/Qv3FeLa8E9BelUd
 15rNfejcMLZXtjt1VR7RHYdCD64bcgu6daGK1gljQfnEXuMl4WpZCBKFq5qsAXOUHMKAaN081
 k/7pZkTXwp//KFV5B5xIq7VSQCJpDKwibKfbuntkAXlR6lJqI/Sj6AivdrNZxlEvC9bYwyW6Q
 aQkC95aL0PKA7K+KAYPeo5Ws3cz1uIoT4j+uQjMb2qUJtRcGqrCV2Iy2t7knVaZbwWmUotSry
 Duhp/z6v07M7Rlx1gDx8aF8S3/hu84z49wg13f/Zm1emXXBdYtDco7R1jlGYO2gTU+ZpF2oRg
 kjlnZGBNFopDQn2hLOM70FMbc0Xfv1tqw1V4+CsPPF89IloideL55/jp7vkrg4iIF+I5Q+VqQ
 ie4OFrmusk1nltSf2niviNrisrqZ25yUc/Qaj1E/dw==
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

