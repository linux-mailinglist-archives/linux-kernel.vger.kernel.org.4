Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722506F0D47
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbjD0Ufp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjD0Ufn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:35:43 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F70F4496;
        Thu, 27 Apr 2023 13:35:24 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 57E8CCE0C1;
        Thu, 27 Apr 2023 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1682627692; bh=p922sNIfNiwflTrQNfKaHaOev78sv9e3hzmwAJNBX9E=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=T46tznhR2VZ1ohf0TbWvOVBzT1A52JxbtQcOoLN6aZCVG+Pcd+4EgVUm2cHhvqTC5
         IMk+81b1trddhCKEXSOxwns58AWZ4libR+9Skm+RZLXundFA7P4kScNSd28dRa34rv
         XkVB2Uck83bitmeeaSb7tLGOw40VUDVFwr2F14D0=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 27 Apr 2023 22:34:27 +0200
Subject: [PATCH 2/4] Input: pwm-vibra - add newline to dev_err prints
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-hammerhead-vibra-v1-2-e87eeb94da51@z3ntu.xyz>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=p922sNIfNiwflTrQNfKaHaOev78sv9e3hzmwAJNBX9E=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkStxlDv0aKCkhM1092jPP3TzJwgfzVji8WY9yL
 cwsMY+umYiJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZErcZQAKCRBy2EO4nU3X
 Vv0TEAC7PUqVbheNI7KK7uopE7LtMV0YovMzqYw4q3RPBjn4trxFOvkOM+7q4o6N6V9HW6I9S1O
 4TuoB9EWFWd8pcR40AXYLSrDKrrU421qZOkDafehQP64Z4Rteeri9/3GbFL8tUCsTHrJrztL7Wx
 LtJyfhDZCNjOQ3uStKj3glbfQqo5eauPKaLJEOzsJEr5yOC3oj+DPdt3aeSSuHjEDvuG7vVPxA1
 DGWMf5dz+hJGnTs+hiNlRdIhC9Y6FLwBcQ0MBlmtOxLz/aBUUa2EZyKbF3H1Dg1PgNwYqkotbQP
 AMSx9jkh5ECL6WXSt3wRTopyrK8ZObXp+GwYyx9cD4bZBbWNZRC3AbF0KIHbfnVk68qX2aHEve6
 S2LbJpwtG93jYhTcOqWeNVhB9JG+HrxUMt9yGPo9WzZlsZJbFk4C8L7O3K+ZC/Dam90H8JEkokG
 MT8U+rHYBMjbgUcx2hP3+a+quTGv4H9zjzcoSM7X6ZughIEdsnhQ8fg+RQczNGQFrStyk81icUn
 ARRQm3gQKrtKEopNSTrSJhGJ8gBxY46p3lLNq2YW0R0nSgpHgRwoCNwd3anQTHnwy14x86PH/Im
 X4K7r/7Tc/EBX/FUDJkW3UxCAfKNUvqLKZ6srxcHefQncVT2Pu50kcrSueSEg7eZGas/XCYOv8i
 zEEWLyFbekmvb4w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure all printed messages end with a newline.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/input/misc/pwm-vibra.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/pwm-vibra.c b/drivers/input/misc/pwm-vibra.c
index d0e58a7cdfa3..c08971c97ad6 100644
--- a/drivers/input/misc/pwm-vibra.c
+++ b/drivers/input/misc/pwm-vibra.c
@@ -42,7 +42,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 	if (!vibrator->vcc_on) {
 		err = regulator_enable(vibrator->vcc);
 		if (err) {
-			dev_err(pdev, "failed to enable regulator: %d", err);
+			dev_err(pdev, "failed to enable regulator: %d\n", err);
 			return err;
 		}
 		vibrator->vcc_on = true;
@@ -54,7 +54,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 	err = pwm_apply_state(vibrator->pwm, &state);
 	if (err) {
-		dev_err(pdev, "failed to apply pwm state: %d", err);
+		dev_err(pdev, "failed to apply pwm state: %d\n", err);
 		return err;
 	}
 
@@ -65,7 +65,7 @@ static int pwm_vibrator_start(struct pwm_vibrator *vibrator)
 
 		err = pwm_apply_state(vibrator->pwm_dir, &state);
 		if (err) {
-			dev_err(pdev, "failed to apply dir-pwm state: %d", err);
+			dev_err(pdev, "failed to apply dir-pwm state: %d\n", err);
 			pwm_disable(vibrator->pwm);
 			return err;
 		}
@@ -137,7 +137,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 	err = PTR_ERR_OR_ZERO(vibrator->vcc);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request regulator: %d",
+			dev_err(&pdev->dev, "Failed to request regulator: %d\n",
 				err);
 		return err;
 	}
@@ -146,7 +146,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 	err = PTR_ERR_OR_ZERO(vibrator->pwm);
 	if (err) {
 		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to request main pwm: %d",
+			dev_err(&pdev->dev, "Failed to request main pwm: %d\n",
 				err);
 		return err;
 	}
@@ -158,7 +158,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 	state.enabled = false;
 	err = pwm_apply_state(vibrator->pwm, &state);
 	if (err) {
-		dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
+		dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
 			err);
 		return err;
 	}
@@ -172,7 +172,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 		state.enabled = false;
 		err = pwm_apply_state(vibrator->pwm_dir, &state);
 		if (err) {
-			dev_err(&pdev->dev, "failed to apply initial PWM state: %d",
+			dev_err(&pdev->dev, "failed to apply initial PWM state: %d\n",
 				err);
 			return err;
 		}
@@ -189,7 +189,7 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 		break;
 
 	default:
-		dev_err(&pdev->dev, "Failed to request direction pwm: %d", err);
+		dev_err(&pdev->dev, "Failed to request direction pwm: %d\n", err);
 		fallthrough;
 
 	case -EPROBE_DEFER:
@@ -207,13 +207,13 @@ static int pwm_vibrator_probe(struct platform_device *pdev)
 	err = input_ff_create_memless(vibrator->input, NULL,
 				      pwm_vibrator_play_effect);
 	if (err) {
-		dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
+		dev_err(&pdev->dev, "Couldn't create FF dev: %d\n", err);
 		return err;
 	}
 
 	err = input_register_device(vibrator->input);
 	if (err) {
-		dev_err(&pdev->dev, "Couldn't register input dev: %d", err);
+		dev_err(&pdev->dev, "Couldn't register input dev: %d\n", err);
 		return err;
 	}
 

-- 
2.40.0

