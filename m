Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF006882A3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjBBPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjBBPfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:22 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C5776A1;
        Thu,  2 Feb 2023 07:34:47 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MPnHA-1pIdV91vwg-004z77;
 Thu, 02 Feb 2023 16:33:10 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Zhou Peng <eagle.zhou@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>, Chester Lin <clin@suse.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>
Subject: [PATCH v6 07/10] arm64: dts: imx8qm: add vpu decoder and encoder
Date:   Thu,  2 Feb 2023 16:32:17 +0100
Message-Id: <20230202153221.197308-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S5iQzlDJLZeA2fmHghVZD5rsYZ6/YEhAtl0+n4eIKik8snJCymh
 T1aTvLk06kvGpFubSvy/PGEgVS7W4oyf0bLDG6hIr95Z14yOZG5LhB3d+gxkUgwKsKwBe5J
 wxrC0mjSac08kJpE3squsgUlxPu7tMiFa6QzuXUOh/zOUPcBiLFXypDUv1udc74P+u+JvHs
 m0X0oUVMMUrdCzCU4r2Dg==
UI-OutboundReport: notjunk:1;M01:P0:xkr2eF0M/4Y=;OXgGQFdzbBa/AkHFBqnAAwJoH62
 dD1Ax8d4ubqPi7h29PiBWoVObAe320NBxuWRVDHzMcsVact5uNuYQOU2z+jip3146wW02zHOL
 uuz09hjqOPC9kEwWUzWp6dXZ3Dwva4IfBiHgvSLD6+P4AWh4thmTyP0dom9h2fGhp2MdsE/vD
 XtbHWQTIeCi8zViodDbX39I4QNdrt8beyyyMl66i9TT2BKzrWbj1EIt5xqokDCMAHNRT9/4v3
 RYg35uuLbayUhtbTA5+Hi687HvlZtnGNuLlhzcAXm4uRDQ54qgN/8Acax7spmCm7kTFogdLsZ
 2opRH+siEhlMcgVBahLNudJKkdpROAmra2Zv0snkBHidH+ZS06Bi47ddbStVtwV9bKqDnSevY
 tHWYoZVtfbRpgLJnKXCThxwIpDpN0EZU96jXIw/RQdkn6OskfPEt+OUMNhDVnxV/ZT6ViKEDd
 YrNPMZRoHOonBPXnnOJ1SkQ09BlVWl5Mv2RWi5DFTEhPDv0nWBYv3CFpjBrhyQQZsZtH54j0R
 /UKqAdpkX1e44TO1/53V9jVJ1BBL0dzHAzRo4mabTeBfsl/2GGuYEFm6azXux5EsNvm1+rszo
 +X4ve0mpmPoloLGBOPQBMBUjmcQusEE6lmURMJGxnOSpxlBswiL6cr2Zk8AhxMHSUoa7Rardq
 nW5ulJsrM1csskVkyeQ7anJ8HhtgY6ijBN3S5J+W+w==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhou Peng <eagle.zhou@nxp.com>

Enable VPU decoder and encoder functionality.

Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

(no changes since v4)

Changes in v4:
- New patch combining the following downstream patches:
  commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
  commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")

 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 41ce8336f29e..9fff867709f0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -23,6 +23,9 @@ aliases {
 		serial1 = &lpuart1;
 		serial2 = &lpuart2;
 		serial3 = &lpuart3;
+		vpu_core0 = &vpu_core0;
+		vpu_core1 = &vpu_core1;
+		vpu_core2 = &vpu_core2;
 	};
 
 	cpus {
@@ -212,6 +215,7 @@ rtc: rtc {
 	};
 
 	/* sorted in register address */
+	#include "imx8-ss-vpu.dtsi"
 	#include "imx8-ss-img.dtsi"
 	#include "imx8-ss-dma.dtsi"
 	#include "imx8-ss-conn.dtsi"
-- 
2.36.1

