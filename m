Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3037291D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbjFIH4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239473AbjFIH4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:56:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A56A4206;
        Fri,  9 Jun 2023 00:56:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f62cf9755eso1807970e87.1;
        Fri, 09 Jun 2023 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686297354; x=1688889354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XDBOKDA6bfl/qmJTSZHOtCV0YaHuP39l5+ZHaqyhDE=;
        b=SO3wMSPRuf7Dg8JYNPq00RVBzG9EQtH+filTpzwquADZPkHN5CZSZBHmLCHYXnduiA
         vupVF5759/HcGksJRNsE90CQrZxj3jo0/wmVBiYr8oW4H1e7Ua0LTZ8yo3usQQZ400/5
         UooFVXpkq59+SkIIq/uwMHJdTbKIqmYkP4cSn75FVSaYU8UiZtqE8na4dUGq5XntIcp9
         L3N1BUU+E+9cz03GXpOafpGjryW3BGoPbwxHKeqL66d0RlCC0PFUUtB+WkiG1DKKqgKK
         LvqtOc9+oBPTA6q/BzPuuB4ZF7++s1ub39gZlInY9pLDp6/xP/nO05wLQ0PhScStteFA
         mwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686297354; x=1688889354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7XDBOKDA6bfl/qmJTSZHOtCV0YaHuP39l5+ZHaqyhDE=;
        b=cE73Bhx52eKPKSTS5IwOzdISvJ4IUNQR3bCiCsdjB04F1jcXOi7nqlFvEiJ4C2IBbI
         CuB5LQgWSuLsefpuYXqJ7P5dQ7llBLEl/WZmb/F/CyuX9oeOqXs65Gr1uUzq9QGASr8D
         u/HybdMnCkDq6G6an3nxx+SD7i98+rW2sRSMHi7l7vNME0pRAcZHtq64rmfEt9Uh/ycE
         qkwJBiBAYJ+lJZToDwM4M2NCF7qN1OpwqUKdC3pv41KynQcC4SHmJVsrby+pqU/2azug
         nbiEeBBuupBeqhb+4iO9EVxm/VaY7W+rExfEmn9z+dqvczpYZH3dZe3gzcjLNi8aw8nv
         7AkQ==
X-Gm-Message-State: AC+VfDwqbUbqSFw36wsJw3cFHa7mgjetz4ZuXqC6RnOrsqZ7vjHEC3ax
        K0iotmGSyIkW+/XmWZ3UXKo=
X-Google-Smtp-Source: ACHHUZ52DeNk/IADD/j/BqpPoRKGiHRiaSyBny/WfMinS1Vtiuxjt1HkkNvew5ltdn4YGjVqt7VtwA==
X-Received: by 2002:a19:6518:0:b0:4e8:c81b:1a11 with SMTP id z24-20020a196518000000b004e8c81b1a11mr428022lfb.49.1686297354332;
        Fri, 09 Jun 2023 00:55:54 -0700 (PDT)
Received: from localhost.localdomain (bba-2-50-150-163.alshamil.net.ae. [2.50.150.163])
        by smtp.gmail.com with ESMTPSA id n5-20020a7bcbc5000000b003f7eafe9d76sm1788703wmi.37.2023.06.09.00.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:55:53 -0700 (PDT)
From:   Yongsheng Yang <iyysheng@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yongsheng Yang <iyysheng@gmail.com>
Subject: [PATCH v2] Documentation/hwmon: Fix description of devm_hwmon_device_unregister()
Date:   Fri,  9 Jun 2023 11:55:10 +0400
Message-ID: <20230609075510.1305-1-iyysheng@gmail.com>
X-Mailer: git-send-email 2.41.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_hwmon_device_register_with_info to replace
hwmon_device_register_with_info in description of
devm_hwmon_device_unregister.

Signed-off-by: Yongsheng Yang <iyysheng@gmail.com>
---
 Documentation/hwmon/hwmon-kernel-api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
index c2d1e0299d8d..6cacf7daf25c 100644
--- a/Documentation/hwmon/hwmon-kernel-api.rst
+++ b/Documentation/hwmon/hwmon-kernel-api.rst
@@ -66,7 +66,7 @@ hwmon_device_register_with_info.
 
 devm_hwmon_device_unregister does not normally have to be called. It is only
 needed for error handling, and only needed if the driver probe fails after
-the call to hwmon_device_register_with_info and if the automatic (device
+the call to devm_hwmon_device_register_with_info and if the automatic (device
 managed) removal would be too late.
 
 All supported hwmon device registration functions only accept valid device
-- 
2.37.1

