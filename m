Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBFA6C65D6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCWKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 06:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCWKzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:55:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F5F74D;
        Thu, 23 Mar 2023 03:54:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x3so84514102edb.10;
        Thu, 23 Mar 2023 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679568853;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16i6j+3yiuKh2ZXYk8ydMHg2bRMTehsZ5TYSxtdY1MM=;
        b=qFq4a1qzImp0SnpEDDQDCvzXxR1iDbFV8+KCOvTR+uSlUpJcbxLsaJePMhAFNB8Eu8
         Pfqrm1+kymCqGkvu6IzANzqlGR5fsWzvu0R1/4FstHhh1weD99FM5AZDxvLM1y5m3FVS
         peMCw9zwwQIXn2Fh6Yt6FYcwVSP+RRB9CJA3HyKoGg7ZQHwOovNwUSTHcn41BvdqgXAL
         bDp2lrCYzM2cYG39MBEsRCd2vVALrk8uREmjDjSGnXZVBd3jgPg0tMAZzaU3s/0oMwfp
         TJGPsOAA2yqhQnv0Wy2BizY+BM+xVA2tRJiAwvzNJe47W3iWJWaAfeL6sEdGy7UXpNeA
         BF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679568853;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16i6j+3yiuKh2ZXYk8ydMHg2bRMTehsZ5TYSxtdY1MM=;
        b=eE6zRDrKKm636XWkln9fUpxWkQoupPH+utvzZ02EBMftzB2lnRq5s+srNbxjhjvPiT
         5Dn7wmCAvFFCdGt3TMvxz8t+2Ntrterf+KKnJQJeoQcsqr+bYddTt4EsP3CKIdy6onbT
         tWe8Bwmtfus/0SVO6R1DJbUznB9BmAp6gjvMB+pAtkkEXyEMi9BPNRiUy2KHqcI0cQn9
         rgTA7pSJJf4wUU7dBb+bMQ+bXRqpaJesWtkwDu5xO3jl2mC1El0E40uq4tMZtsEwbJpu
         lP+Q7ThXv28bXvq/BQZHP1JnFLs5ewrtYvspJ6Mdh8xdmFgovTk10Pc9ZKg9upewVAGC
         BzgQ==
X-Gm-Message-State: AO0yUKVuCreU48tb3IrXDPaHkXtPWv3SCUhaVo3FFkCB/XDt2mBaHa13
        kV9YMGhjjEestaUX28LQvIE=
X-Google-Smtp-Source: AK7set9h/xsukV2nSR76oXsdXVDrJHC8Ig8QGIbmb0xQW6o0fIDHbTop8LKSsnjjcS62c+Ie28lsPg==
X-Received: by 2002:a17:906:7107:b0:939:4d6d:1f26 with SMTP id x7-20020a170906710700b009394d6d1f26mr9944523ejj.50.1679568853204;
        Thu, 23 Mar 2023 03:54:13 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:d509:cbf0:f579:76f0])
        by smtp.gmail.com with ESMTPSA id ha25-20020a170906a89900b00934212e973esm5640824ejb.198.2023.03.23.03.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:54:13 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] leds: rgb: mt6370: correct config name to select in LEDS_MT6370_RGB
Date:   Thu, 23 Mar 2023 11:54:10 +0100
Message-Id: <20230323105410.10396-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink
type LED Indicator support") introduces the config LEDS_MT6370_RGB, which
selects the non-existing config LINEAR_RANGE. As the driver includes
linux/linear_range.h, it is a safe guess that the config actually intends
to select LINEAR_RANGES, which provides the library implementation for the
function prototypes defined in the linear_range header file.

Correct this naming confusion in the LEDS_MT6370_RGB config definition.

Fixes: 55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/leds/rgb/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
index 7d86bb26c54b..360c8679c6e2 100644
--- a/drivers/leds/rgb/Kconfig
+++ b/drivers/leds/rgb/Kconfig
@@ -29,7 +29,7 @@ config LEDS_QCOM_LPG
 config LEDS_MT6370_RGB
 	tristate "LED Support for MediaTek MT6370 PMIC"
 	depends on MFD_MT6370
-	select LINEAR_RANGE
+	select LINEAR_RANGES
 	help
 	  Say Y here to enable support for MT6370_RGB LED device.
 	  In MT6370, there are four channel current-sink LED drivers that
-- 
2.17.1

