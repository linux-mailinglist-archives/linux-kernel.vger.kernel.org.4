Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103576C62A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjCWJE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjCWJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:04:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E187E1DB85
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso1282555pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 02:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679562247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjcZplfqBfGxkesm/SQ2YHNMoUVOYWANADhv4EwbVKw=;
        b=hoFy1YlM+Ou4lh0YKLuMnMSIdbLbE14MqBS1SC7KjUNh2kF/qIvdI94Q/6Pf6fQYgD
         SLOV7FX4N/holaDTDjRHZYO5HjilL5W6VQ/vdCtKhXubLcAQBRhJvxnItxYn4W3Eoqkn
         qGZdnJtgtBoUwyYEJUkd/ZhRZ16fPJiij1SSdyQrqqoAWQ5/R8L774dQwWWPYDjV444G
         8sUCpfgwE2HbjBA/hwPluQ53d9VYOftWc/jM7PE8763T7HywEa+7U8M+nzXd2hsKbyWq
         eYeA5Z65UH7hAE1wRhvXz2D9i6gGDFXwp+uXSIZ3X4415fvat6tbxl4r5ewZEaIsLvZW
         ga5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679562247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjcZplfqBfGxkesm/SQ2YHNMoUVOYWANADhv4EwbVKw=;
        b=1w4xv7RNK99vBlFOfaQJgEA50GzB6Mv164f83tX9g5vjX7TjZbARwxyTIbCIq7VTIt
         MIjYk28Km55oVuj3ExHFmF2ifst+2GmHT+v/vtD/FaWaviUq0FOpqPY7t/PMkYHl5bwN
         MNvM0UYz4T5RyMzwYl3PhLEx8IV0veV9/zj2i2g1muUHF9u3zudAQiQdceZkD4OiZ2O2
         n+qI2bbbQcHnceK4VwMaEAkKcFBd3eA1/4uDaWDvGf5jzGV7cbpDSyW8uDInvhyLbdzG
         +9yf8jU5r9nfZD/aUaxDFDW89036aDUz0SCXvSgqolcW9r0st6P4hwuZvpImJ2ThT8vV
         VbMw==
X-Gm-Message-State: AO0yUKUCXwsrTCaKk01I8DRHpy9MnR7CfrNeUfXIZ0+0TeHDT/82BthA
        eKBQYld8o14Tc1MlN9qaZi0=
X-Google-Smtp-Source: AK7set/oTTiOrApmUymSuNVVr+CSlC/dlZSzh452dlK3gzZb5t+MSmqd5fk4C8IAizbPWqksg3qEQQ==
X-Received: by 2002:a17:903:247:b0:19a:9880:175f with SMTP id j7-20020a170903024700b0019a9880175fmr6518482plh.51.1679562247398;
        Thu, 23 Mar 2023 02:04:07 -0700 (PDT)
Received: from ubuntu.localdomain ([117.207.139.205])
        by smtp.gmail.com with ESMTPSA id q8-20020a656848000000b005034a57b963sm11277116pgt.58.2023.03.23.02.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 02:04:06 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH 1/3] Staging: greybus: Convert macro gpio_chip_to_gb_gpio_controller to an inline function
Date:   Thu, 23 Mar 2023 02:03:34 -0700
Message-Id: <92e39b9957a1863d13fc5ce9e346e99c68550fa3.1679558269.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679558269.git.sumitraartsy@gmail.com>
References: <cover.1679558269.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'gpio_chip_to_gb_gpio_controller' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/greybus/gpio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index d729b922a750..2a115a8fc263 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -41,8 +41,11 @@ struct gb_gpio_controller {
 	struct irq_chip		irqc;
 	struct mutex		irq_lock;
 };
-#define gpio_chip_to_gb_gpio_controller(chip) \
-	container_of(chip, struct gb_gpio_controller, chip)
+
+static inline struct gb_gpio_controller *gpio_chip_to_gb_gpio_controller(struct gpio_chip *chip)
+{
+	return container_of(chip, struct gb_gpio_controller, chip);
+}
 
 static struct gpio_chip *irq_data_to_gpio_chip(struct irq_data *d)
 {
-- 
2.25.1

