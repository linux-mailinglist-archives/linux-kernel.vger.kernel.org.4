Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9406C6882A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjBBPfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjBBPfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:06 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8C159C9;
        Thu,  2 Feb 2023 07:34:30 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MLePl-1pMmEX4707-000sNo;
 Thu, 02 Feb 2023 16:32:55 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Clark Wang <xiaoning.wang@nxp.com>,
        Frank Li <Frank.Li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v6 04/10] firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains
Date:   Thu,  2 Feb 2023 16:32:14 +0100
Message-Id: <20230202153221.197308-5-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1CcnIaTwaybvRBD0M5isTZGbqmZi3GT97hDI0lh2cMExvulL/Ky
 lGZ5PW0zkH+XQJS+C2WD+SXp4OLpj+RezI2AtEjPfPL2w95Ktp1sEhJ6UmDBfBtfd9d1/sJ
 V68pQ6WCJrlX63Nfs5pGP9EGij8SrfcOWkg3HAyFXKYbHteEqbXuWXuHIRfMUmFcIN2/T1f
 ZYUUVPsFZSgPeAFrzscPw==
UI-OutboundReport: notjunk:1;M01:P0:im/G66r0JOg=;g1erqgTWReHSh/vNsr4ZBuAyylv
 0CrvmKlozmKYeJ8c1hQF+/1Dqyh+R5bVK6bOdHPNVSSBd8zUDf/a2TQ3lSC6jlLEaBNn+yK7u
 m3HejQGhsFE3r9/fT2cnajwZVYQwMvbs+nCyV25zPRlc6ZuNmTPNL0L/6vdtjGuCzZTTMK9Hv
 ntlGAE9eaYG8wdBlnGVUpjAOy8adYcOoUnnHVSgFstmycbnPNyasZ+efMndOiSdocEl/oLZTv
 /Dujd0ogpL7rKuVDXlheE7Dg0aLMOlQ754Ti1XviMOWQGELeGPxebdSSwgXRtTLyoXzsBLBGV
 izLwkmJnGTzNJt3uEy8NMV5dKGDpphJL+7apWGLTMZXLzQvvsKMzhdlkkBqe4Pdf/TIDtvY72
 EWFVEy03e96q9TbJgwLrEWUD23IKDjsjYWLDOPxrBgmDXGO9N9DD1N1rTIRIeFeY8gKIKpx+j
 ZR9U1ODfW8BufBSv3+14mVjlvwfmtIM4H4xYpWCxGk6o9HVfhmZ1kv2pdZHx0l5KskscdLToU
 YDuTHgp1fYGe3Gu/nY7yYyfdXYzEKfm1koPa3Bph0o0HUXsPRetPTIX2hJWn+hZKQIGTR376K
 jdJQ00TaNFhTyTuKe5AsQ5J7InSeDExH8MtZyWAc4r3PutcojK9jQPqH8QEzTwuFvBc9JKEfL
 VH90xREpEm45l14wCdDWt+FRG0oDhX3BlV0UqtPUDw==
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

