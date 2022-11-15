Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7062A1EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 20:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKOTcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 14:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiKOTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 14:32:52 -0500
Received: from smtpcmd12131.aruba.it (smtpcmd12131.aruba.it [62.149.156.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5D6F2C11A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 11:32:49 -0800 (PST)
Received: from localhost.localdomain ([146.241.88.137])
        by Aruba Outgoing Smtp  with ESMTPSA
        id v1fpoedd9ae4mv1froaGVo; Tue, 15 Nov 2022 20:32:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1668540767; bh=CZGNAdcyRYcjhzECvTdpmDDAmXrU1WfFbXnrYeTMrSU=;
        h=From:To:Subject:Date:MIME-Version;
        b=K7W5wU7S+T75J9qH9XKpq2z+UgM5j8BCI0Iwo1eOkGYN//UJdLRtAxQwKjgl1RLiW
         HQd17v9FtOpuewC6cIwFwPCZN8AJrZGNwoQZJ96O3KM1m3a5um7stUrydTVqSRWRPk
         4KgIGza6Lk96hn36jzd/O54iUY7CAYgmGamXpDejN6v2opam9ClEpkf/Ug7xUfvp/r
         7vilTTjOh+o5KRAx8nCMjKhA8aluk52IK/SYs5qdR2LvCOqC7P8p+HRyCZREUwg+7C
         jD5KHnLLbM+HNDaG2HSjj3EG506smLbTZN3jPknJ+qhGVJ0/CG2YtbGDytZrMHqeM9
         lPheSzyFFHliA==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Subject: [PATCH v2 3/4] ARM: dts: imxrt1050: increase mmc max-frequency property
Date:   Tue, 15 Nov 2022 20:32:43 +0100
Message-Id: <20221115193244.10484-3-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfHG0IczV7O1OTEH8JFjCezO1cBEeuOrntfvuuFG8PrRE7fAjtWiGlULy3ubD/SNhJP2iKOMP+oqBb4b3g7HT2k3Zl39NRg1zVev0rOZ0ZrRPqwlyqCac
 2tPfcNK22ELx1VDRMD2BbY+ufGqHgk/7TiphF9O9963UuAGcfPeBLxfMDq0b+tSGFfx1koHdwlN7HFKnmHeo2a7KRX9Gqt4f9rZFvI16DHltHTz79H9uxEJo
 pY+QR07ue2/8uVwBTVvtooatB/Fgr6uMfX5nAHdEm3xz9ILJrouqGhnijH7WuV+2o0EUCMEqGqokQbVZfHnrg/uI3Zf91khEE4K4m9OOAvn5SgkjDa0UWKsN
 7SF4VmZo3P8N/wHd1trd71WDrk7k/Vt8zztuc2b6gLqQ3lATtWLlHoh7fOaXvDeQPCKDx0IZAWK6881yChZ0ASD5bdS8bWFDsuToH3IpQCRF4JdTBQCQmAJE
 IItI8nT4To37VWZUTmrblO5T/tSw/uUURPinxqQUhJLo9c1aOHWRIozvHtcrZjV53nlhHxbzerNKNAz3c1sZbCd5CrPof1ockKn6UgIlX1cUTzUFJFvxeyCM
 NbxNBRw4Utc20xTUIiBlEPye3bazMXWVHrHRxQv7Y3F35S7L2Gyx9vLNt1sKZHp0Lda2Sx+w0sszOaWFAl8FhZ7UUY3OTGT0EIZRF/fSepbnMjHb/DX9l+I1
 DfLMRZA9H4y012QQ47ptJZpy/xwIM3GawOfJfWnPgrEK3xplQw9pJ4dzfP/MOpIC5tExYTig2Dn9YTyQWXRmthAWwd7zvKtIJub86zseqmGYvQBcPjYPGg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to i.MXRT1050 Datasheet usdhc supports up to 200Mhz clock so
let's increase max-frequency property to 200Mhz.

Cc: Jesse Taube <mr.bossman075@gmail.com>
Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
---
V1->V2:
* set max-frequency to 200Mhz instead of removing it as suggested by
  Bough Chen
---
 arch/arm/boot/dts/imxrt1050.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imxrt1050.dtsi b/arch/arm/boot/dts/imxrt1050.dtsi
index 114465e4dde6..5b1991c32748 100644
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

