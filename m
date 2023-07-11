Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D5374F8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGKUJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGKUJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:09:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E216C171E;
        Tue, 11 Jul 2023 13:09:17 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-668730696a4so3446551b3a.1;
        Tue, 11 Jul 2023 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689106157; x=1691698157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0AjrurSLjCfnq22wQVPyzNWuhvJYbXtr4WWuyj0oB9s=;
        b=smN2+HX0faRVYygGOZFPccaAota1KFLmMs1jQjvZhI3B9d8PAf3rFlwY9kdCT7kktV
         UunleB1j7AOzmZkoPtTcx496fwQsKRkLhmGIwiWAAofX0QAAMMQagFRvWkv2x+KBc9kE
         pnTrvemOtC5P2PNJfBaTY64JKpZcwmT9foE0IoyBrAPGhszG2fXx6uS7QOMmFRY5D7Yw
         TORYFr/ThLsC6nQaD2VxzuzAyE5eYf4rCJrCoBwUIDySEKc0lRkGNJG8wSZ2mFcFFLNz
         GdAMrAiVgGFanSg/x/8WnpLC8OTL6cpjVGhtA2YaaHiDcJSxIl8BoShUuMCChsvWdAxd
         WOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689106157; x=1691698157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AjrurSLjCfnq22wQVPyzNWuhvJYbXtr4WWuyj0oB9s=;
        b=LKMLSNap2x/0W5M34SbbXD1tEfcBfcehEzFWF7qzdF5+gmapBzuXRSVxgF1YUXzxrk
         MeW6okjkE5AEo4phP3caxn/QRN1CE1fJjZfyYsj6lMn9GvIvWOMVMYEqCpgidLdAW7ui
         SExAd8GecDCogt7HNrjecF+9nvYREAqN8LVDa5t5IGS5eYri1oMGYGMtXEXrCiOx5+Uz
         JS7mkOOwCir98dSFH733q7eYLv9d+G2uKTtxoPWaaT35MirxXZx0nxCHAgZ+heux7Sd3
         ngz4TumKUZJB39OG1Zeu0n7GvWiqaBsdH27XwvGEKkSu1Zg2+Rhc0cLIy+rrxeQqWnoF
         9gVA==
X-Gm-Message-State: ABy/qLaAIQ+ckU/UX6mKk3nsbwe0b1HZ1iWoT+QSBHJVg4XYQGvNDfme
        hGW5yAwFOoap3djmTREZ5IU=
X-Google-Smtp-Source: APBJJlGDQu2odG6nQ82sJP4Hvl6xC0g6W/0X6YKALLPC2oPn9xZJg+vaExMRgdxQvRyTgsW8Dx4LMQ==
X-Received: by 2002:a05:6a00:1745:b0:67a:c810:3cb0 with SMTP id j5-20020a056a00174500b0067ac8103cb0mr15187493pfc.3.1689106157228;
        Tue, 11 Jul 2023 13:09:17 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id j6-20020a633c06000000b0051b36aee4f6sm1964047pga.83.2023.07.11.13.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:09:16 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     claudiu.beznea@microchip.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v3] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Wed, 12 Jul 2023 04:09:05 +0800
Message-Id: <20230711200905.6464-1-aarongt.shen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver would never call clk_enable() if the PWM channel was already
enabled in bootloader which lead to dump the warning message "the PWM
clock already disabled" when turning off the PWM channel.

Add atmel_pwm_enable_clk_if_on() in probe function to enable clock if
the PWM channel was already enabled in bootloader.

Signed-off-by: Guiting Shen <aarongt.shen@gmail.com>
---
 drivers/pwm/pwm-atmel.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..f8f1fbb8732d 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -464,6 +464,31 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
+static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm)
+{
+	unsigned int i;
+	int err;
+	u32 sr;
+
+	sr = atmel_pwm_readl(atmel_pwm, PWM_SR);
+	if (!sr)
+		return 0;
+
+	for (i = 0; i < atmel_pwm->chip.npwm; i++) {
+		if (!(sr & (1 << i)))
+			continue;
+
+		err = clk_enable(atmel_pwm->clk);
+		if (err) {
+			dev_err(atmel_pwm->chip.dev,
+				"failed to enable clock: %pe\n", ERR_PTR(err));
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm;
@@ -504,8 +529,15 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
+	if (ret < 0)
+		goto remove_pwmchip;
+
 	return ret;
 
+remove_pwmchip:
+	pwmchip_remove(&atmel_pwm->chip);
+
 unprepare_clk:
 	clk_unprepare(atmel_pwm->clk);
 	return ret;
-- 
2.25.1

