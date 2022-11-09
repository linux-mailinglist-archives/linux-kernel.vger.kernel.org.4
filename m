Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEB0622AB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKILhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiKILhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:37:32 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C52EF57
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:37:28 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EB082412BF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 11:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1667993846;
        bh=PUPJbzepJx5AFbllHqJhTSHtk/HwYip0Muk/9EDtYSQ=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=MmrQ2LVIc+NXpRvTTrrTO9+fRdLs4V/YtQyh4kLdi0EGsZ5P7iXmNPi+AZrx33T3I
         bH0huCjcUczj80ltgE4kTX5Uippw3jbT9tloKL/v46favap5NHJ4484BZDcxXPvLVo
         vPqQSnq8E6N3li8AK00dbCkvb0/2ZYfSsikF3OmXhGZbUNnnr3XnXv/hCgx91ySqXr
         ettLO4wtSO2Y3TnjwnFbd/dzJ6sLN9YKi9gVgY5o1EeuMejb6z+sYTlPyyzi0YGwON
         Jxm/8LYmfPUFrHiOUjC+8t9HjRqUkc3tXuq3ytxqrHM2faddufJXbSKChPlAUJ9SmL
         ybHqD8qFi1gzw==
Received: by mail-wm1-f72.google.com with SMTP id r187-20020a1c44c4000000b003c41e9ae97dso890127wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:37:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUPJbzepJx5AFbllHqJhTSHtk/HwYip0Muk/9EDtYSQ=;
        b=oyt93wBo7I3u5KuUdqs7ElFM3oFPIU6IzqguKgBDwXthOEgEcDUV7xTl4tUckyRG1N
         pZwXTYDRyEfnrIXpAVVaDc5EzmGuq4gzk5jP2vp6aELY38E+oJWQaecP2j1Nv2TnLcxw
         22ZBvFc8BqnQDe6hgHcknxEJ4llf4TU6qrikkyHh3hZoZo1exVVPbJtTulmvZ2xz70pN
         x7xTCllodkpAMUpQpxq7aT4DcTgr+3P5juJw/dqGyVXvKDaAGnysnucx0EjZyYrP0RjP
         oE6PO7mJEAVh/3MXRjtzuKOQ4MwQ7Zt6d/lfth1o7QQAsex8jcGOwZ92u0cFIGLjCyQI
         B18A==
X-Gm-Message-State: ACrzQf0E/30BtWuxGpkUTE2wdYmTUCCvBFQgFv8GFmBIRAyaii7xyGdV
        T1wiIqOMlJhZ3/nagKr/ZP/+HACNx8+SIv5z39Z2MlqFWCtsO+Pqvh6UEhEqiIaeHPlia6P9AT2
        ZJKxbJ0PNkh6wfvL9TXPOC4vmMIR85X4GRnJ5IqMajg==
X-Received: by 2002:adf:dd88:0:b0:236:57e3:fc86 with SMTP id x8-20020adfdd88000000b0023657e3fc86mr37599038wrl.493.1667993846676;
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6NtbE5g2zTudkMZu+AtZfvOOIrFo9uWBtwl+NVJp9Bq1Dv1FfXdNKK8Djewf5xz5JNHgBBSg==
X-Received: by 2002:adf:dd88:0:b0:236:57e3:fc86 with SMTP id x8-20020adfdd88000000b0023657e3fc86mr37599028wrl.493.1667993846479;
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id m27-20020a05600c3b1b00b003cf6c2f9513sm1487261wms.2.2022.11.09.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 03:37:26 -0800 (PST)
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Cc:     linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: sifive: Always let the first pwm_apply_state succeed
Date:   Wed,  9 Nov 2022 12:37:24 +0100
Message-Id: <20221109113724.519021-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2cfe9bbec56ea579135cdd92409fff371841904f added support for the
RGB and green PWM controlled LEDs on the HiFive Unmatched board
managed by the leds-pwm-multicolor and leds-pwm drivers respectively.
All three colours of the RGB LED and the green LED run from different
lines of the same PWM, but with the same period so this works fine when
the LED drivers are loaded one after the other.

Unfortunately it does expose a race in the PWM driver when both LED
drivers are loaded at roughly the same time. Here is an example:

  |          Thread A           |          Thread B           |
  |  led_pwm_mc_probe           |  led_pwm_probe              |
  |    devm_fwnode_pwm_get      |                             |
  |      pwm_sifive_request     |                             |
  |        ddata->user_count++  |                             |
  |                             |    devm_fwnode_pwm_get      |
  |                             |      pwm_sifive_request     |
  |                             |        ddata->user_count++  |
  |         ...                 |          ...                |
  |    pwm_state_apply          |    pwm_state_apply          |
  |      pwm_sifive_apply       |      pwm_sifive_apply       |

Now both calls to pwm_sifive_apply will see that ddata->approx_period,
initially 0, is different from the requested period and the clock needs
to be updated. But since ddata->user_count >= 2 both calls will fail
with -EBUSY, which will then cause both LED drivers to fail to probe.

Fix it by letting the first call to pwm_sifive_apply update the clock
even when ddata->user_count != 1.

Fixes: 9e37a53eb051 ("pwm: sifive: Add a driver for SiFive SoC PWM")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/pwm/pwm-sifive.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 2d4fa5e5fdd4..b3c60ec72a6e 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -159,7 +159,13 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
-		if (ddata->user_count != 1) {
+		/*
+		 * Don't let a 2nd user change the period underneath the 1st user.
+		 * However if ddate->approx_period == 0 this is the first time we set
+		 * any period, so let whoever gets here first set the period so other
+		 * users who agree on the period won't fail.
+		 */
+		if (ddata->user_count != 1 && ddata->approx_period) {
 			mutex_unlock(&ddata->lock);
 			return -EBUSY;
 		}
-- 
2.37.2

