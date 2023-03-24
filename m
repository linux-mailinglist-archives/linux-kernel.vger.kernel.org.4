Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBC66C78E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjCXHcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCXHcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:32:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CF1198
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:31:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o2so1101208plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679643118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLwbqhkP3x7d9e508XmAAFyMChf+5bvOpcoj8t6arpQ=;
        b=V4OuRY0X0mSGzHnm+klSyWUnsEr8WBD5exIeFu787Enw/u3mEIEtCYmLkDqcMfhhuR
         mtz09DZrMebbCURoMzVJGb7/SuCUmv/7MJz0oCOgyC7z9TvwjkCO3Dnul1fIMC+J/7Dm
         O+jHaVdwMigP7pUOufxcx83PdltzmN9rEb2Ev6cw1AF5QuXUUSADXZP90RmhVERw0cbY
         +0WaRXPpDPiVz0wY3l6xBMglBxFG5Hz1bATZwDeDbJ52U3PAK95QPWNB/OaOKRS6p/tu
         E9eK8q+x0RhijCpTG/xU/5y19bm3A66XK4dxL6PmyXTf5OtMc2NkMoAez3sNr2/lfwG9
         1pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679643118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLwbqhkP3x7d9e508XmAAFyMChf+5bvOpcoj8t6arpQ=;
        b=NskCkqjVmV/m7TOXvz+lBUeVfuxoNkX4BICc6YIjNqwRx8me2VGXvLdbeleE2t/6DG
         PReLtfYzulXN83QuHYU1719uSUjiBdqU6Uq5Bo66//ZMmQ5ezJ86DIgJwswCvuD0LvxU
         /ymushaplU6YYI9VM0dNBSXRG5iigavkHKYDfIBgwhGm/ld+WA2uyQPj29h4HJXfej00
         rqPGqzx/qD+DyA3VaZM/j/Y6TgYdaykA1gGxrFB1hyPxqKvLtqWREt0snr7bT0cxauP2
         uhaUQ/9kKNa/5RnnDSzE+9iShvOXVbEmi3zPd8tVlflcRTSOhzRy5FGKRJEHoOi5OxLG
         fqtg==
X-Gm-Message-State: AAQBX9cTygwPj7KLd4hc47yhE6/vkTC8exIDgxM5GGGKAar/5xPp0gz5
        IIYEREz6FmyDrY91AUsHaIE=
X-Google-Smtp-Source: AKy350YV5ki71rAX+GEaClRDCHhl8SLu+UFi2u05G9ndCaFXgdafTTnqC4cipNikC2ZOFxlh9bvTUg==
X-Received: by 2002:a17:902:e812:b0:199:4be8:be48 with SMTP id u18-20020a170902e81200b001994be8be48mr1852380plg.19.1679643117590;
        Fri, 24 Mar 2023 00:31:57 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id v12-20020a1709029a0c00b0019a75ea08e5sm13511604plp.33.2023.03.24.00.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:31:57 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 1/3] Staging: greybus: Use inline function for macro gpio_chip_to_gb_gpio_controller
Date:   Fri, 24 Mar 2023 00:29:54 -0700
Message-Id: <215538f49cca6be05f846704e2ca15cd10144207.1679642024.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679642024.git.sumitraartsy@gmail.com>
References: <cover.1679642024.git.sumitraartsy@gmail.com>
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
v2: Change patch subject, noted by Alison Schofield 
<alison.schofield@intel.com>

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

