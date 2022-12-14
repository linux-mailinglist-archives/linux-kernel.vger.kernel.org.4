Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1874664CE31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiLNQi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiLNQiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:38:22 -0500
Received: from smtpcmd0986.aruba.it (smtpcmd0986.aruba.it [62.149.156.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD7CF5FD7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:38:20 -0800 (PST)
Received: from localhost.localdomain ([146.241.66.6])
        by Aruba Outgoing Smtp  with ESMTPSA
        id 5UltpKir27DIo5UlupwQy3; Wed, 14 Dec 2022 17:38:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1671035898; bh=dsR3rZ2jkGJDSz8NDGqgHLaVYGKUo3DjuM532qLmDdo=;
        h=From:To:Subject:Date:MIME-Version;
        b=BbOVC9LpubGCVmqJfFqbm3TINglE+3+I/cQXESnPHWQppjzb1IPTGLAQFhVik18uO
         iJLvEYeZ7Hxf+eAOjaoyOWLDAyum8B8/CAtKQsAzprpQ93k9WnXyt16hipGdQzSGbr
         E2zZFpB5yzOvl4NHhMDTI8wPAo47EaWE72RFHIFuCXwCsW3SV1XQj1yeyz+F9N2Y7i
         dfd1h9DkiRorliUmAAPK/GHGykqlBUafhZHMzbQtxAZ0N4LdaKhcPIBQP+RMpGS3YI
         PAhqTROdE3BphT8w8W5GOpQ4zvqSiF0MAmwmH5fmUnWQrJG7ROuy0hYdUEYQOtFiIL
         buPNS1Aqj0Hjw==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v4] ARM: dts: imxrt1050: increase mmc max-frequency property
Date:   Wed, 14 Dec 2022 17:38:17 +0100
Message-Id: <20221214163817.55909-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCL3RHjrhS7KC74i6WassEwaV/G661sMy9IAaO2gQ7ot+2jadR5fQWAGAeHDCdzr7jYns2MVCOWI5hSX0BkuJhtVoEnOQ4WcYMB1xnociMjDEhUUI8L9
 9dTSvKTkmB2WxHlzTJXHQobs9gvedmBrvEJAy/R6d82vwKO50nGgk1JjrkrEsEswxYlWw/tuUu8twFdkw83+76Fh0aiRuRbrP7UHfRcdv/5oLnjsoRA+2xiA
 tXMYcQrc482BGYyr6sdd3EUA9y7MFTLqcHX9isas4eodnEJ3SclqipmGpZn5cbTOkmH3IKJu4pB4mnJiTt1xA4XLe0GSHG/NGN5R8fkdSj6MBwbAg2CZnOpv
 ZjaYKSsexUW+sjdNhVZhTFPLXRPx+BjzgDppYdKfJPV02x9jeYnARl09tawe+/hN1he2+7cr0Wvzt4+9wJCIP3iq6ayOtHSwQAaGYevnG8FepjvQrcsNG1y+
 2T5CJWR6Wq9KOec2BA3S9/ihlThQIJ4+t9QSd6tp0o+peRSL8pL/wxLZFQLFhDesZ4yx4SMJWyAGv9TKER+XkCcgNPkFNQuHNB/SyFTFEFnFVQd3xDdeErGM
 qKiLS/WtekFn1tnaqEj65q+xPYRoQrBAVGby0/j5xxfYbnI7c7Ju+Atz+40VrM0jiqJH9FQ3bJ+uCXgq0hI4+L3o
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
let's increase max-frequency property to 200Mhz.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
---
V1->V2:
* set max-frequency to 200Mhz instead of removing it as suggested by
  Bough Chen
V2->V3:
* added Jesse Taube's Acked-by:
V3->V4:
* added forgotten [PATCH V4] in subject
---
 arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 8768715adda4..fb531542609b 100644
--- a/arch/arm/boot/dts/imxrt1050.dtsi
+++ b/arch/arm/boot/dts/imxrt1050.dtsi
@@ -93,7 +93,7 @@ usdhc1: mmc@402c0000 {
 			bus-width = <4>;
 			fsl,wp-controller;
 			no-1-8-v;
-			max-frequency = <4000000>;
+			max-frequency = <200000000>;
 			fsl,tuning-start-tap = <20>;
 			fsl,tuning-step = <2>;
 			status = "disabled";
-- 
2.34.1

