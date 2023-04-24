Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1326EC976
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjDXJvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjDXJvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:51:39 -0400
Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A1930FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:51:32 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:261e:0:640:2e3d:0])
        by forward501b.mail.yandex.net (Yandex) with ESMTP id 49E9E5EB14;
        Mon, 24 Apr 2023 12:36:12 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JZBb1pbWwKo0-sRmf96JB;
        Mon, 24 Apr 2023 12:36:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1682328972;
        bh=Ti4rmk9GtD+fdUS3cXOpHQKoJb3lg100jXiX2vylp5A=;
        h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
        b=f+2TuJ4q7vopWgrQYEdbOHo5PlYImRqhUgnB8d6vd6ffvEptPbYF0vq61RH4v+phm
         lP9auUVDmh9yJohjldy73bMbEKO0eXtMLtH1ty2dIwvZ5mHYp8GhRbyl1YVlfZ5Xbh
         ZxrQymSyC+5EpXqfd9iC3SrV7UOANPc1g5wlgRv4=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
From:   Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 38/43] ARM: ep93xx: soc: drop defines
Date:   Mon, 24 Apr 2023 15:34:54 +0300
Message-Id: <20230424123522.18302-39-nikita.shubin@maquefel.me>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424123522.18302-1-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary defines, as we dropped board files.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 include/linux/soc/cirrus/ep93xx.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/linux/soc/cirrus/ep93xx.h b/include/linux/soc/cirrus/ep93xx.h
index f0f770a103be..bba0a5ca4335 100644
--- a/include/linux/soc/cirrus/ep93xx.h
+++ b/include/linux/soc/cirrus/ep93xx.h
@@ -2,34 +2,12 @@
 #ifndef _SOC_EP93XX_H
 #define _SOC_EP93XX_H
 
-struct platform_device;
-
 #define EP93XX_CHIP_REV_D0	3
 #define EP93XX_CHIP_REV_D1	4
 #define EP93XX_CHIP_REV_E0	5
 #define EP93XX_CHIP_REV_E1	6
 #define EP93XX_CHIP_REV_E2	7
 
-#if defined(CONFIG_ARCH_EP93XX) && !defined(CONFIG_OF)
-int ep93xx_pwm_acquire_gpio(struct platform_device *pdev);
-void ep93xx_pwm_release_gpio(struct platform_device *pdev);
-int ep93xx_ide_acquire_gpio(struct platform_device *pdev);
-void ep93xx_ide_release_gpio(struct platform_device *pdev);
-int ep93xx_keypad_acquire_gpio(struct platform_device *pdev);
-void ep93xx_keypad_release_gpio(struct platform_device *pdev);
-int ep93xx_i2s_acquire(void);
-void ep93xx_i2s_release(void);
-#else
-static inline int ep93xx_pwm_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_pwm_release_gpio(struct platform_device *pdev) {}
-static inline int ep93xx_ide_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_ide_release_gpio(struct platform_device *pdev) {}
-static inline int ep93xx_keypad_acquire_gpio(struct platform_device *pdev) { return 0; }
-static inline void ep93xx_keypad_release_gpio(struct platform_device *pdev) {}
-static inline int ep93xx_i2s_acquire(void) { return 0; }
-static inline void ep93xx_i2s_release(void) {}
-#endif
-
 #if defined(CONFIG_ARCH_EP93XX)
 unsigned int ep93xx_chip_revision(void);
 #ifdef CONFIG_SOC_EP93XX
-- 
2.39.2

