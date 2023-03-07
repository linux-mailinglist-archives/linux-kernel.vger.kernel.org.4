Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69876AD941
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCGI3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCGI3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:29:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90837F3E;
        Tue,  7 Mar 2023 00:29:41 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ec29so18263735edb.6;
        Tue, 07 Mar 2023 00:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678177780;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3AbvUXReTTM4AVHYC5kqdjEokxzgC2ZBAFH06E7ehB4=;
        b=IS6tlqa7BHjdbJXvlwdGYpY0tlL7AnTvkm5MLjGJKBcnWmCztjRzqOW8C0c2dt8CnU
         TZv/V35oG40BhjADsVoBnbN27t2eCqXNe6NwxGzcBX/fYM1cBlRV6NJfBZUzvvaGMUzs
         nXRHaGNi6Aq00NszXO8bx7qSChKkSMBtMlQEqnZUzf+Z8qL6w4VE9MRMaQyfIyD6RW8A
         owFrS4Maej/CDQkDTMorZEHDjx2AwgAvKQUtDvGq2SvhPKAaFuYVGqsQNeWPQVfa+P3q
         gxYWl3Y2ts1qCaIoASBhKY+DLg3HwP/kASBo0QVkpa6eJAfl4j57I9r+Tkol2JTU4XXI
         vMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678177780;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3AbvUXReTTM4AVHYC5kqdjEokxzgC2ZBAFH06E7ehB4=;
        b=BJl/bc5RAa+tnOMhdUAqXbCgi908N/DCTWtuZG89Q1M8cMdiH5VkDbVYokvPdYNq7z
         lRftbqzqCAM8uQZDmLA2vU/a0zoO2EBFIOtUebDdnImFKGuhwYCXG47WVT0Vynxyj5p2
         xKFvI3JsIJEk3g8eQCeV02paemLsqR+bFAYA9nuZ4VbA94ZPko4dGdl7w7s6thXeJhf/
         pGVdwcgForOS4IzFjKTMAeugSfbKiEzSMxWYSqyd6usa4BUqT4vAXJqkuyT8lTVjVU16
         ykT32LNOX2YV64viuicm8f+JmLiBl1FtQ4jvoV4iMx2BQRN87x3xJ6T6zGRfHsrP+w44
         cqOQ==
X-Gm-Message-State: AO0yUKV5EmLOSZZOJuIfKyiGas35ZyoOd338uTB4MN6pX/EBm4iypT+O
        VvWKRPhWc/csIp1WQPG7alTw7jbW49AJ0A==
X-Google-Smtp-Source: AK7set+NqOA0GuLBi95jD9sL2EFZoTyWxqtV9tJspk9SNlbbF0WHDeIQzi+MHhbMHljWACWH9ttvUw==
X-Received: by 2002:a17:907:8b16:b0:8b1:2e7c:df49 with SMTP id sz22-20020a1709078b1600b008b12e7cdf49mr15440608ejc.7.1678177779745;
        Tue, 07 Mar 2023 00:29:39 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a517:a52e:cdbc:e30d])
        by smtp.gmail.com with ESMTPSA id f27-20020a50a6db000000b004acc61206cfsm6304353edc.33.2023.03.07.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:29:39 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Pavel Machek <pavel@ucw.cz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     William Zhang <william.zhang@broadcom.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of ARCH_BCM4908
Date:   Tue,  7 Mar 2023 09:29:36 +0100
Message-Id: <20230307082936.16631-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.

Probably due to concurrent development, commit a0ba692072d8 ("leds:
bcm63138: add support for BCM63138 controller") introduces 'LED Support
for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
not visible during the config refactoring from the commit above. Hence,
these two changes create a reference to a non-existing config symbol.

Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
ARCH_BCM4908 to remove the reference to the non-existing config symbol
ARCH_BCM4908.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/leds/blink/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/blink/Kconfig b/drivers/leds/blink/Kconfig
index 945c84286a4e..bdcb7377cd4e 100644
--- a/drivers/leds/blink/Kconfig
+++ b/drivers/leds/blink/Kconfig
@@ -1,10 +1,10 @@
 config LEDS_BCM63138
 	tristate "LED Support for Broadcom BCM63138 SoC"
 	depends on LEDS_CLASS
-	depends on ARCH_BCM4908 || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
+	depends on ARCH_BCMBCA || ARCH_BCM_5301X || BCM63XX || COMPILE_TEST
 	depends on HAS_IOMEM
 	depends on OF
-	default ARCH_BCM4908
+	default ARCH_BCMBCA
 	help
 	  This option enables support for LED controller that is part of
 	  BCM63138 SoC. The same hardware block is known to be also used
-- 
2.17.1

