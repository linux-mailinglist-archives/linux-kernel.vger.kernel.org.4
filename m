Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC76E3BCA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 22:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDPUFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 16:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDPUFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 16:05:42 -0400
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBE526B5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681675538; bh=wnvonY8cnXrliGmn7aIfZnPhUdpyDka/v9LrWi+FIl0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NIvZaZuHfcdLdq89uX12X6DgOcconIr1IUBvDADK3fevsp3zKSfPyX4k+/3/TJiZy
         0pbCsYlm0dgIC/18QI4XYgkgH3VfYIYojnBPZeu5Cf1mW+Z9M3CEShltUQz9wzs2b9
         tI6aElHqBY6IjSziQ0U+WyU43SXgHeHn5mkwkA8YqMO3Ay0ZkP+B1ne04d9McfnnaV
         7vf1kLy4lJjwoXXJczx3Uh7i02if5Qx3JMBbG8E829BC5WiF19DQaofeKTq6/LO8EQ
         ZkiRUtoeZT3fbnWBvqp2drg1KBuIa+QznYPtGA1yHP7drXkKzjSdhzSKUUQs5fK0DF
         +zg+vVIU+APMQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id 7146119811D7;
        Sun, 16 Apr 2023 20:05:37 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     patrice.chotard@foss.st.com, Alain Volmat <avolmat@me.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: remove stih415/stih416 reset
Date:   Sun, 16 Apr 2023 22:04:41 +0200
Message-Id: <20230416200442.61554-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8l1_BUPAhyJrbMOakdFZKh31Yw0gBKN2
X-Proofpoint-GUID: 8l1_BUPAhyJrbMOakdFZKh31Yw0gBKN2
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=511 phishscore=0 mlxscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160190
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the stih415 and stih416 reset dt-bindings since those
two platforms are no more supported.

Signed-off-by: Alain Volmat <avolmat@me.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Patch previously sent via a serie: https://lore.kernel.org/all/20230209091659.1409-10-avolmat@me.com/

 include/dt-bindings/reset/stih415-resets.h | 28 ------------
 include/dt-bindings/reset/stih416-resets.h | 52 ----------------------
 2 files changed, 80 deletions(-)
 delete mode 100644 include/dt-bindings/reset/stih415-resets.h
 delete mode 100644 include/dt-bindings/reset/stih416-resets.h

diff --git a/include/dt-bindings/reset/stih415-resets.h b/include/dt-bindings/reset/stih415-resets.h
deleted file mode 100644
index 96f7831a1db0..000000000000
--- a/include/dt-bindings/reset/stih415-resets.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for the reset controller
- * based peripheral powerdown requests on the STMicroelectronics
- * STiH415 SoC.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH415
-#define _DT_BINDINGS_RESET_CONTROLLER_STIH415
-
-#define STIH415_EMISS_POWERDOWN		0
-#define STIH415_NAND_POWERDOWN		1
-#define STIH415_KEYSCAN_POWERDOWN	2
-#define STIH415_USB0_POWERDOWN		3
-#define STIH415_USB1_POWERDOWN		4
-#define STIH415_USB2_POWERDOWN		5
-#define STIH415_SATA0_POWERDOWN		6
-#define STIH415_SATA1_POWERDOWN		7
-#define STIH415_PCIE_POWERDOWN		8
-
-#define STIH415_ETH0_SOFTRESET		0
-#define STIH415_ETH1_SOFTRESET		1
-#define STIH415_IRB_SOFTRESET		2
-#define STIH415_USB0_SOFTRESET		3
-#define STIH415_USB1_SOFTRESET		4
-#define STIH415_USB2_SOFTRESET		5
-#define STIH415_KEYSCAN_SOFTRESET	6
-
-#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH415 */
diff --git a/include/dt-bindings/reset/stih416-resets.h b/include/dt-bindings/reset/stih416-resets.h
deleted file mode 100644
index f682c906ed5a..000000000000
--- a/include/dt-bindings/reset/stih416-resets.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * This header provides constants for the reset controller
- * based peripheral powerdown requests on the STMicroelectronics
- * STiH416 SoC.
- */
-#ifndef _DT_BINDINGS_RESET_CONTROLLER_STIH416
-#define _DT_BINDINGS_RESET_CONTROLLER_STIH416
-
-#define STIH416_EMISS_POWERDOWN		0
-#define STIH416_NAND_POWERDOWN		1
-#define STIH416_KEYSCAN_POWERDOWN	2
-#define STIH416_USB0_POWERDOWN		3
-#define STIH416_USB1_POWERDOWN		4
-#define STIH416_USB2_POWERDOWN		5
-#define STIH416_USB3_POWERDOWN		6
-#define STIH416_SATA0_POWERDOWN		7
-#define STIH416_SATA1_POWERDOWN		8
-#define STIH416_PCIE0_POWERDOWN		9
-#define STIH416_PCIE1_POWERDOWN		10
-
-#define STIH416_ETH0_SOFTRESET		0
-#define STIH416_ETH1_SOFTRESET		1
-#define STIH416_IRB_SOFTRESET		2
-#define STIH416_USB0_SOFTRESET		3
-#define STIH416_USB1_SOFTRESET		4
-#define STIH416_USB2_SOFTRESET		5
-#define STIH416_USB3_SOFTRESET		6
-#define STIH416_SATA0_SOFTRESET		7
-#define STIH416_SATA1_SOFTRESET		8
-#define STIH416_PCIE0_SOFTRESET		9
-#define STIH416_PCIE1_SOFTRESET		10
-#define STIH416_AUD_DAC_SOFTRESET	11
-#define STIH416_HDTVOUT_SOFTRESET	12
-#define STIH416_VTAC_M_RX_SOFTRESET	13
-#define STIH416_VTAC_A_RX_SOFTRESET	14
-#define STIH416_SYNC_HD_SOFTRESET	15
-#define STIH416_SYNC_SD_SOFTRESET	16
-#define STIH416_BLITTER_SOFTRESET	17
-#define STIH416_GPU_SOFTRESET		18
-#define STIH416_VTAC_M_TX_SOFTRESET	19
-#define STIH416_VTAC_A_TX_SOFTRESET	20
-#define STIH416_VTG_AUX_SOFTRESET	21
-#define STIH416_JPEG_DEC_SOFTRESET	22
-#define STIH416_HVA_SOFTRESET		23
-#define STIH416_COMPO_M_SOFTRESET	24
-#define STIH416_COMPO_A_SOFTRESET	25
-#define STIH416_VP8_DEC_SOFTRESET	26
-#define STIH416_VTG_MAIN_SOFTRESET	27
-#define STIH416_KEYSCAN_SOFTRESET	28
-
-#endif /* _DT_BINDINGS_RESET_CONTROLLER_STIH416 */
-- 
2.34.1

