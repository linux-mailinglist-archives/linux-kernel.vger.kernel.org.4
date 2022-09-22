Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07645E6866
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiIVQaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIVQaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:10 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D604F39A;
        Thu, 22 Sep 2022 09:30:02 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1M8Pmu-1ofovQ0zwG-004Wqk;
 Thu, 22 Sep 2022 18:29:44 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/8] arm64: dts: colibri-imx8x: improve include notation
Date:   Thu, 22 Sep 2022 18:29:20 +0200
Message-Id: <20220922162925.2368577-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a2yLh8xwRFIDUXjXWVEotQ0HX+nV1/GpWkmkS1TDcsRkjWgpdui
 5tNs2DsHr5AVJskYkmTE+Y+XCgXzQmjTRzLn0I8hz4sAEBRXJJozPO22IZbTFwHkwnnBX+6
 mnhbKCWxmTUsEKVV7XpDGRZ3pU4Bnh4jlQjo+WDDIT01xmNpcMuTWMOyg8s10uRpHyozrzq
 DWOHcF2/1qle5OMMYEobg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pCL6f4yxZDo=:3TxfySBYwx1Wd9+pUioMs/
 To7KAoVzlbsmJC1KAe82ZvCmefD0lWeIoioE5nBXB8CZMiDNeQA0RiVSecyARBtwZ9G1H5q6C
 VYHgqnF6xAY07vdT5duSap2djgvjfbSDkVD25iFs9imAdbRzipPm0mheJDTjTLNCVZpdy9bxB
 HnUb37u8JOd+o1kenGkXlVzipJ2YxGa91kS0/iODjkThbK+3sbTiXnnc5q6ahSJyNdkrzVJF4
 hKrjuUU0P6Er8NtWhsjLGv9CBOscBQeTpZsES2pkqYBxOGLV/zDc4nMdS6qadOvfZrrPJKp5n
 Gwx8Q8IHwYz+sXi2CWvvTS0yjxSP+zFzzbhLoNv3jsUBBLK5MRyTwD9SAU3SqWjfSxP56PEdm
 d7s6SpM3eU7FOLShnwN3lpUozs/RvYrDR8VWiWM2O+2zbCR6M04jUYTAcPUGWRC4WWHCLnE07
 F6dhD9YoS85kM92mqm0lbtqwfMXnQiEJGn+SWHo78JUDzfn4PiT3cGqC5NNwtiU8jzlXHpCdM
 aSrQvnK/QkLTZWAp2pkWuoddJX20d/UeGzWeZpTCRK/pVKgmTRWPjavsyUxLMPCgBOJJI2Bmo
 BkETbctvrW8GaVkFR5lQQBkx63xwHi9TuVthtzWxle2Cxi3kIm1uGOo5VVE+PysNAkpCb2XqU
 ZsQkGaHMWZf4MPO0ZzdMBvK1MBHjVMX1nsQxN5Xy+64Q0p3Bsqe2Zc2/6qYgnw2ZRiAjNK+Oy
 SPkaaAeuiuI+8Yfcm0ilClXLzPa0+9MxDFSLAOv3lKBzbulSi6tXdOEVx74H9cLsnECxLICYc
 k7KJe7K
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Improve include notation. Usually only dtsi files from the same location
are included with an absolute path in quotes. Others should use a
relative path enclosed in angle brackets.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
index a08e70fb7c7a..7c334b93db3b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
@@ -3,7 +3,7 @@
  * Copyright 2019 Toradex
  */
 
-#include "dt-bindings/input/linux-event-codes.h"
+#include <dt-bindings/input/linux-event-codes.h>
 
 / {
 	aliases {
-- 
2.36.1

