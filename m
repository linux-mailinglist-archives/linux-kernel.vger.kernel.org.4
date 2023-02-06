Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8D968B47F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBFDbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBFDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:31:20 -0500
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Feb 2023 19:31:19 PST
Received: from out-167.mta1.migadu.com (out-167.mta1.migadu.com [95.215.58.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B914214
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:31:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675653798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xOwSS+IVqwUgIpvtg0R2on3YiSF2ie4HZMHON0xzNfg=;
        b=xGaJ0KbKXJD7f5xgfXOoDyl03x2BmVvjf77RH15tEGXF9J+E4DyzxjhJI0nCDK2yQF0zQt
        9YPmmOwQ4Vlh0EdVqCj/CMmcD3znlfqQpqSrELn6pIIVNk2lVODtEucaH2AFEIL80/ECB9
        XJJGnVgDNTUSmeXZVqj6Kfc8l7XqJ9E=
From:   Jackie Liu <liu.yun@linux.dev>
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, liuyun01@kylinos.cn
Subject: [PATCH] mfd: si476x-cmd: fix codespell
Date:   Mon,  6 Feb 2023 11:22:31 +0800
Message-Id: <20230206032231.3208296-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jackie Liu <liuyun01@kylinos.cn>

Fix some typo, find by 'codespell drivers/mfd/si476x-cmd.c'

succsess -> success
interace -> interface
comand   -> command
failre   -> failure

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/mfd/si476x-cmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index f32f1fb93e37..c9a0ec084aa8 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -251,7 +251,7 @@ static int si476x_core_parse_and_nag_about_error(struct si476x_core *core)
  * @usecs:    amount of time to wait before reading the response (in
  *            usecs)
  *
- * Function returns 0 on succsess and negative error code on
+ * Function returns 0 on success and negative error code on
  * failure
  */
 static int si476x_core_send_command(struct si476x_core *core,
@@ -398,7 +398,7 @@ static int si476x_cmd_tune_seek_freq(struct si476x_core *core,
  * The command requests the firmware and patch version for currently
  * loaded firmware (dependent on the function of the device FM/AM/WB)
  *
- * Function returns 0 on succsess and negative error code on
+ * Function returns 0 on success and negative error code on
  * failure
  */
 int si476x_core_cmd_func_info(struct si476x_core *core,
@@ -429,7 +429,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_func_info);
  * @property: property address
  * @value:    property value
  *
- * Function returns 0 on succsess and negative error code on
+ * Function returns 0 on success and negative error code on
  * failure
  */
 int si476x_core_cmd_set_property(struct si476x_core *core,
@@ -545,13 +545,13 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_dig_audio_pin_cfg);
  *       SI476X_IQCLK_NOOP     - do not modify the behaviour
  *       SI476X_IQCLK_TRISTATE - put the pin in tristate condition,
  *                               enable 1MOhm pulldown
- *       SI476X_IQCLK_IQ       - set pin to be a part of I/Q interace
+ *       SI476X_IQCLK_IQ       - set pin to be a part of I/Q interface
  *                               in master mode
  * @iqfs: - IQFS pin function configuration:
  *       SI476X_IQFS_NOOP     - do not modify the behaviour
  *       SI476X_IQFS_TRISTATE - put the pin in tristate condition,
  *                              enable 1MOhm pulldown
- *       SI476X_IQFS_IQ       - set pin to be a part of I/Q interace
+ *       SI476X_IQFS_IQ       - set pin to be a part of I/Q interface
  *                              in master mode
  * @iout: - IOUT pin function configuration:
  *       SI476X_IOUT_NOOP     - do not modify the behaviour
@@ -589,7 +589,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_zif_pin_cfg);
 
 /**
  * si476x_core_cmd_ic_link_gpo_ctl_pin_cfg - send
- * 'IC_LINK_GPIO_CTL_PIN_CFG' comand to the device
+ * 'IC_LINK_GPIO_CTL_PIN_CFG' command to the device
  * @core: - device to send the command to
  * @icin: - ICIN pin function configuration:
  *      SI476X_ICIN_NOOP      - do not modify the behaviour
@@ -1014,7 +1014,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_phase_diversity);
  * NOTE caller must hold core lock
  *
  * Function returns the value of the status bit in case of success and
- * negative error code in case of failre.
+ * negative error code in case of failure.
  */
 int si476x_core_cmd_fm_phase_div_status(struct si476x_core *core)
 {
-- 
2.25.1

