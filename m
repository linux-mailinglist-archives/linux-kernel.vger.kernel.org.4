Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC967CF23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjAZPDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjAZPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:03:48 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C01C6AF6B;
        Thu, 26 Jan 2023 07:03:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m15so1315340wms.4;
        Thu, 26 Jan 2023 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6hGazIFpNgMsQBh0HkRBOxGzy6+XWZOvugjcdhOak+s=;
        b=mTjsrxvyQ0i5vQW9fiCojh0KHZUVIbFGqjsUGUPayCpoxwkL352L2/Y1YDVlDtbeNp
         4EG+jagxpkpCGphip07OugfBVauvutCvSS7T+VfT9NP8Gw+iM65hPQOqOdiB/ymCoKbX
         EYKRHb9XwiIdI7oSGQU3m7BRlU64QwfSn7Qz6QjZUYmbOydFdK5Nm6OVNtgZPnq0xqyE
         +CmytVW5eFISBkBdraEYNjw0z66ViBU1jvf+C7w2u5h3WZuouzqv+teYwHwpnNRTRLXd
         E5BC2nfHxSf2afdhVJ9Iw1du3EwUJ5o+oXuNJhx/++1vfMcXuYSYXZeLmyr0sQ1TJvf7
         vsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hGazIFpNgMsQBh0HkRBOxGzy6+XWZOvugjcdhOak+s=;
        b=SU0wQpmYxnSOLD9nWXpF9LcbPU0RhzATXZJE5lTr2qy1O1GPUtOXpjzzmkjK3DBLS4
         6oOsBZmvC6mL8aUi2hOwsHbzQX2shG/ZzxnX2zVd89ydhkCGWWAQtFmrlZJbcyKoVxAW
         i+7LlWk8qeOQoZg5PP5I+InsfHDpT4WFPtInFEKRbbAZVGtS12O3Q157i8UQhI4lcdJ0
         qvrxBszr/UNkuR86vtq5PGwiHIm1DfqiKmURd1AwH/5AyeZi8Zp+xP11tDQQR/OWaB50
         /gwL8AU9BKlUufgQZIIwBWmy3XyV4nFNbiWic0cQioEUQV9/R7w2T6lxUY/eZxlYqwPj
         aTfw==
X-Gm-Message-State: AFqh2krbkOJwbdWpBNJlPpGU8bDpxIpdjQn2TBA7Z4aPfcjAdKV59LZB
        L8+kzAhvVp5oaY2ybHyUQck=
X-Google-Smtp-Source: AMrXdXtPNYmJpvLc4Nh+1bx72S+PxCPGNH7N8INCFgZPlCPh2qlK8EqT9nBrkWZetRqWumanXKho0Q==
X-Received: by 2002:a05:600c:19d0:b0:3dc:c05:9db6 with SMTP id u16-20020a05600c19d000b003dc0c059db6mr11626561wmq.33.1674745425630;
        Thu, 26 Jan 2023 07:03:45 -0800 (PST)
Received: from DE008-GL-00034.UMK.kls.zentral (p5dda2d96.dip0.t-ipconnect.de. [93.218.45.150])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c500d00b003db2b81660esm5254565wmr.21.2023.01.26.07.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 07:03:44 -0800 (PST)
From:   Leif Middelschulte <leif.middelschulte@gmail.com>
X-Google-Original-From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: imx27: fix race condition .apply,.get_state
Date:   Thu, 26 Jan 2023 16:03:13 +0100
Message-Id: <20230126150313.764284-1-Leif.Middelschulte@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>

With CONFIG_PWM_DEBUG=y after writing a value to the PWMSAR
register in .apply(), the register is read in .get_state().
Unless a period completed in the meantime, this read yields the
previously used duty cycle configuration. As the PWM_DEBUG code
applies the read out configuration for testing purposes this
effectively undoes the intended effect by rewriting the previous
hardware state.

Note that this change merely implements a sensible heuristic.
The i.MX has a 4 slot FIFO to configure the duty cycle. This FIFO
cannot be read back in its entirety. The "write x then read back
x from hw" semantics are therefore not easily applicable.
With this change, the .get_state() function tries to wait for some
stabilization in the FIFO (empty state). In this state it keeps
applying the last value written to the sample register.

Signed-off-by: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
---
 drivers/pwm/pwm-imx27.c | 50 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 29a3089c534c..32389ca2da3e 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -75,6 +75,7 @@
 						   (x)) + 1)
 
 #define MX3_PWM_SWR_LOOP		5
+#define MX3_PWM_FIFOAV_EMPTY_LOOP	4
 
 /* PWMPR register value of 0xffff has the same effect as 0xfffe */
 #define MX3_PWMPR_MAX			0xfffe
@@ -118,8 +119,28 @@ static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 	clk_disable_unprepare(imx->clk_ipg);
 }
 
+static int pwm_imx27_wait_fifo_empty(struct pwm_chip *chip,
+				     struct pwm_device *pwm)
+{
+	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	struct device *dev = chip->dev;
+	unsigned int period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm), NSEC_PER_MSEC);
+	int tries = MX3_PWM_FIFOAV_EMPTY_LOOP;
+	int fifoav;
+	u32 sr;
+
+	while (tries--) {
+		sr = readl(imx->mmio_base + MX3_PWMSR);
+		fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
+		if (fifoav == MX3_PWMSR_FIFOAV_EMPTY)
+			return;
+		msleep(period_ms);
+	}
+	dev_warn(dev, "FIFO has been refilled concurrently\n");
+}
+
 static int pwm_imx27_get_state(struct pwm_chip *chip,
-			       struct pwm_device *pwm, struct pwm_state *state)
+				struct pwm_device *pwm, struct pwm_state *state)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	u32 period, prescaler, pwm_clk, val;
@@ -161,10 +182,33 @@ static int pwm_imx27_get_state(struct pwm_chip *chip,
 	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
 	 * use the cached value.
 	 */
-	if (state->enabled)
+	if (state->enabled) {
+		/*
+		 * From the i.MX PWM reference manual:
+		 * "A read on the sample register yields the current FIFO value that
+		 *  is being used, or will be used, by the PWM for generation on the
+		 *  output signal. Therefore, a write and a subsequent read on the
+		 *  sample register may result in different values being obtained."
+		 * Furthermore:
+		 * "When a new value is written, the duty cycle changes after the
+		 *  current period is over."
+		 * Note "changes" vs. "changes to the given value"!
+		 * Finally:
+		 * "The PWM will run at the last set duty-cycle setting if all the
+		 *  values of the FIFO has been utilized, until the FIFO is reloaded
+		 *  or the PWM is disabled."
+		 * Try to be at least a bit more deterministic about which value is
+		 * read by waiting until the FIFO is empty. In this state the last/most
+		 * recently pushed sample (duty cycle) value is continuously applied.
+		 * Beware that this approach is still racy, as a new value could have
+		 * been supplied and a period expired between the call of the wait
+		 * function and the subsequent readl.
+		 */
+		pwm_imx27_wait_fifo_empty(chip, pwm);
 		val = readl(imx->mmio_base + MX3_PWMSAR);
-	else
+	} else {
 		val = imx->duty_cycle;
+	}
 
 	tmp = NSEC_PER_SEC * (u64)(val) * prescaler;
 	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, pwm_clk);
-- 
2.39.1

