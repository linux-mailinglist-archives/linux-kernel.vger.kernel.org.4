Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D8C74EFB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjGKM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjGKM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:59:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5508D1716;
        Tue, 11 Jul 2023 05:59:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b2b60731so25065785ad.2;
        Tue, 11 Jul 2023 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689080340; x=1691672340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mzGPc3eaP7RI7nv++MCFW+ZV7pSmS8SPo25wJPiLyKk=;
        b=C5RZhaPm5WxP7MWWAmZd5ocJxCI5fxYTtk67GZ+hzITSsajMYvH6Oe43tuHF4ROQwZ
         KowIYeOtAf9AH6iKG76osIwI7XLsUmyO0Knm8Vu7iEEbgnt+k53WP/0Rvj6dP/hIRJqG
         j3mmU1awgsnkyUyTYhiwUvIHuP68MJb1alrsK+RQ/VlZB25tpCjlywy1nCixu3JCo+k/
         0SIdXLQOkjrdUEnOL3vwR7C64jn5uHa4YWePciDCzSRKarM6ea1FN289IX3KYGYa8osy
         RUSRrbHKyeF/VcrwquSWjKvyoIqwN0g48x+TEJjuZIj2gidrr4w829LWNAuou8okxaK+
         VJHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689080340; x=1691672340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzGPc3eaP7RI7nv++MCFW+ZV7pSmS8SPo25wJPiLyKk=;
        b=IiVeNV6G6Vhg28Q40hxbXrRZEUTIttO78Jz8u+Y5oTu2EQ5QTEnoJNQmlr8Kk8/oZF
         G718t6nk1wm+O6NdONLngs+wOJhrNA5A/y228rtpOvHlvhq/l1xxiKKow0F1Q37/j13K
         lsJ+T56jbrTMSdd2rHFMynmakjchapXP0X0fqmqrc1XkrTd7GQF1U/7bnNqF7heSma6w
         XwqLAsGnNTfAleWdh67ztVWZMFJwmUPGP13E7ylVQYIICEIccruoyIpEv+JXf9iZI/cp
         1kHl6KTYUim7btfwQyPh+hig9rVhzzA1yh2Gb62QztIhzue5s5Xo4sAuK3egvol5x/5X
         +xtw==
X-Gm-Message-State: ABy/qLYD+bnWO8+71EoYgEk0/Br1w2D/dOOQa6E+JRbrkifoytgaXxjZ
        72bLZvBt2jRV1peZtm5pb1o=
X-Google-Smtp-Source: APBJJlGsFLEHy8B0RT8jKL0IRRcvS3w2NmnkHH/W30mkcwaEQQXCnaR7HJKTH14Ji3h4mt3DjpKxKw==
X-Received: by 2002:a17:902:d486:b0:1b2:1b22:196 with SMTP id c6-20020a170902d48600b001b21b220196mr17158736plg.48.1689080340280;
        Tue, 11 Jul 2023 05:59:00 -0700 (PDT)
Received: from localhost.localdomain ([113.103.7.132])
        by smtp.gmail.com with ESMTPSA id az10-20020a170902a58a00b001b04c2023e3sm1836998plb.218.2023.07.11.05.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:58:59 -0700 (PDT)
From:   Guiting Shen <aarongt.shen@gmail.com>
To:     claudiu.beznea@microchip.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guiting Shen <aarongt.shen@gmail.com>
Subject: [PATCH v2] pwm: atmel: Enable clk when pwm already enabled in bootloader
Date:   Tue, 11 Jul 2023 20:58:50 +0800
Message-Id: <20230711125850.12626-1-aarongt.shen@gmail.com>
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
 drivers/pwm/pwm-atmel.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..ced4ad3c68b2 100644
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
@@ -496,6 +521,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
+	ret = atmel_pwm_enable_clk_if_on(atmel_pwm);
+	if (ret < 0)
+		goto unprepare_clk;
+
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-- 
2.25.1

