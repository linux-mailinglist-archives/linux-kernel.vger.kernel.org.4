Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E905EEACF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 03:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbiI2BQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 21:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiI2BQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 21:16:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225BB1138E0;
        Wed, 28 Sep 2022 18:16:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id v186so85612pfv.11;
        Wed, 28 Sep 2022 18:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BU+nDgTp4FzYVpuKCb0JHUgNuGWH3Om1JL3bunVELiE=;
        b=A0x2qxxd7VgDTwVVmF44TCkowfDAT8LZM/ThFvomS1q6mGKiPpWLuHmLPozdAIQ6bk
         8DGmPjWUuHqevrxLJRSxTeQz+ghGSlSFzb9V8IjihndL5lzA/gbT/jsLrSKbpIeAlxTM
         iNvGazSV6E/BTLTq5+jUfMfh153cyZ24zEIaWdFp5eZOEd2HUF9It3wPdSjH4y5Bz7Ly
         WL8HcE+xScGlqCiG89WS/xvsaTzmdMGBwHXSPtGLqaoQ3VXWo8Ru8wEfkAIOsexx7P0u
         gn5Xsi7qHkrRcJOjofGsS6C8okv42dPYeXKuzuogvAmGAIkRBWK/JDVYBMJMBI4p93b3
         ez1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BU+nDgTp4FzYVpuKCb0JHUgNuGWH3Om1JL3bunVELiE=;
        b=dYddea3TawRiIGoq617xL/st0pZoailueXuAx14EFbEeiHKgG5gYYrBgC1gaEInNIy
         my/6Q+CJA8a9SJzggjwMISj8743P2M3YRN4D+YvRqOIVkHd1RJFS9Tag69fftl+42PWr
         N7cuUcsLWsCWNEvhyKGoQb90ptnRZs5kYmgGOCqES+cddkxyrjyqXOp77ENxyOxVDpdS
         puijlTpaw7SOP8Ea44vU80/FfWr1E758ytGf4r4/t0cjhVzqtUfm/O7YYv/7Cxs8ugdJ
         dMSpxI7L8o1QWptqF11wNjLPedVTOedlYtM7DYU5mrRv99P8oveA367dVZDiTIVlbkEu
         yUlw==
X-Gm-Message-State: ACrzQf1WMU8gtjSkJmeg6d0+sR18sDPykCGIrUoWWuP/wyG88bfT8wyX
        PrlB6Vo9WvTcD1RLBlPrwmM=
X-Google-Smtp-Source: AMsMyM6hjulu0JTSOCybn1i/7qzxsqC/IdkN8d1HzIAGH28CBW+sxxckdBQvuc2a8V8BGBIRzXn/ow==
X-Received: by 2002:a63:3348:0:b0:439:db24:8b02 with SMTP id z69-20020a633348000000b00439db248b02mr568358pgz.425.1664414161469;
        Wed, 28 Sep 2022 18:16:01 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:637c:7f23:f348:a9e6])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78f30000000b00540a3252191sm4737655pfr.28.2022.09.28.18.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 18:16:00 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Krzysztof Opasiak <k.opasiak@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: exynos: fix polarity of "enable" line of NFC chip
Date:   Wed, 28 Sep 2022 18:15:55 -0700
Message-Id: <20220929011557.4165216-1-dmitry.torokhov@gmail.com>
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

According to s3fwrn5 driver code the "enable" GPIO line is driven "high"
when chip is not in use (mode is S3FWRN5_MODE_COLD), and is driven "low"
when chip is in use.

s3fwrn5_phy_power_ctrl():

	...
	gpio_set_value(phy->gpio_en, 1);
	...
	if (mode != S3FWRN5_MODE_COLD) {
		msleep(S3FWRN5_EN_WAIT_TIME);
		gpio_set_value(phy->gpio_en, 0);
		msleep(S3FWRN5_EN_WAIT_TIME);
	}

Therefore the line described by "en-gpios" property should be annotated
as "active low".

The wakeup gpio appears to have correct polarity (active high).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 91c9bd1b47dd..bde6a6bb8dfc 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -795,7 +795,7 @@ s3fwrn5: nfc@27 {
 		reg = <0x27>;
 		interrupt-parent = <&gpa1>;
 		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
-		en-gpios = <&gpf1 4 GPIO_ACTIVE_HIGH>;
+		en-gpios = <&gpf1 4 GPIO_ACTIVE_LOW>;
 		wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
 	};
 };
-- 
2.38.0.rc1.362.ged0d419d3c-goog

