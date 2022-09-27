Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4475ECFF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiI0WFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0WFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:05:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7113D2D44;
        Tue, 27 Sep 2022 15:05:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q35-20020a17090a752600b002038d8a68fbso69355pjk.0;
        Tue, 27 Sep 2022 15:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=PnX3CTK8Zi/GFiq6cOApXc7JemEFXP3BVlCstRnzeVE=;
        b=UZxCiPMdneRhR1zMpsq6m+Za1l+DjCwmsa12S2HstAjJJAGw0wrjYRm6sZUCylDLIH
         UvAFcV2u+J688aF9AGJ+0kW5aIEUsSle4gI/HkDu/kMb5MzDgY5/60DaiwA85D9zdc+F
         T7m95eI7arF9MJmNOS9Bw4bsvqe37h6uL2cdh+8pXT5B92x6OIjhMrEo+OzKhIE7sb0x
         hKl5fGG65VTblomdsVxvixTTuOYrwewaYz7pTo/M+t8XpBxKRxKoI416/bNoiVlzvy1X
         R40QyK4+S17bdq7ZI8A6ao2YkDEg3RHGmlWbQ/4Al+kNh2iBGd/ADI2OL5lpFMJcinEV
         Clhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=PnX3CTK8Zi/GFiq6cOApXc7JemEFXP3BVlCstRnzeVE=;
        b=GgLPR623TA5SurJ6t1N9GMoHrjsBUA7bdN7jrNLrcNKgSKhZG6ywvYJWGsyKCVMt8V
         9yd9H7LObSVVJ5KJroJavciG6II7dszPuMsRL7i0g8MEEDuPXE9pkLI01FqAbnP+b+GF
         ox3prhyyq+glgFHUK6Ms9dMbn0wfAQsJCS4iG99bnmwhbYp4f7xe6wMJxYx3ftaRI8HS
         OfeBFSrRQ5MO39bidiroqO88i7RD+mCL+NkONpAkWYWUxsDO3RihB18j1pX+G4XlTljC
         d8MyZXmOXZJNfRr8c7MF2eBIMbqPk/aCHZ5R0tru0vh6zfHvGnYWS5JoUZsKl/xAiq5O
         IrRw==
X-Gm-Message-State: ACrzQf0o7qcFFhexPC1segjIc/9Upo4rW8OUVKqg4wvKGzKgbEvV5O/N
        Qsl7w++B+uuExA9KlHA098c=
X-Google-Smtp-Source: AMsMyM6Qey9ZeFIp1MguvDe3X+YReqLE0XvCk637reYX3ZwJhK/u/om/ItckfnCalVVon+Z4AfAKHQ==
X-Received: by 2002:a17:902:d512:b0:178:6946:a2aa with SMTP id b18-20020a170902d51200b001786946a2aamr29503248plg.116.1664316309002;
        Tue, 27 Sep 2022 15:05:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090301c900b001782398648dsm2051220plh.8.2022.09.27.15.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:05:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: exynos: fix polarity of VBUS GPIO
Date:   Tue, 27 Sep 2022 15:05:03 -0700
Message-Id: <20220927220504.3744878-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EHCI Oxynos (drivers/usb/host/ehci-exynos.c) drives VBUS GPIO high when
trying to power up the bus, therefore the GPIO in DTS must be marked as
"active high". This will be important when EHCI driver is converted to
gpiod API that respects declared polarities.

Fixes: 4e8991def565 ("ARM: dts: exynos: Enable AX88760 USB hub on Origen board")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/exynos4412-origen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 6db09dba07ff..a3905e27b9cd 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -95,7 +95,7 @@ &exynos_usbphy {
 };
 
 &ehci {
-	samsung,vbus-gpio = <&gpx3 5 1>;
+	samsung,vbus-gpio = <&gpx3 5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 	phys = <&exynos_usbphy 2>, <&exynos_usbphy 3>;
 	phy-names = "hsic0", "hsic1";
-- 
2.38.0.rc1.362.ged0d419d3c-goog

