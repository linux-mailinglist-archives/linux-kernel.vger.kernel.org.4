Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AF6E3B6F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 21:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDPTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDPTLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 15:11:15 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 16 Apr 2023 12:11:14 PDT
Received: from st43p00im-ztfb10073301.me.com (st43p00im-ztfb10073301.me.com [17.58.63.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3362D5B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 12:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1681672273; bh=SHEIfHZdwV1MgUhja3Pb7A0Q8HBViX4AhyXV3iC/XmE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=IEp/xzCQksUYhUhiofR4fY9KsVezXAMrdQDRS9Qmb/R1e18RX4DVVZYt66l977Wpt
         fCBIJ/bayDQXSSDKFgf4Ts2G3LlEYlA7fkgSxWMCBfkClp8xfzNOiLWfhILR/DGVYq
         HXzq9wEk5PaN57/qD8gq1qfLAtEVr2lJ92tSAfIz425GNLsEgFommRIzAJ2R7l1hj5
         QOEkj+btC1jKgU2fOtnguUgVo04sdtmoPsbjmfQ3Er0xLw/UX1pe6p+9UBvsncCUeO
         ZYEWrSL6ngMnRmei0Qv59njFtqkC/PsdzAflZmswDtrs1McE63xDOtma9D65xKZ4C8
         zbCxZWA1F6dWA==
Received: from localhost (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
        by st43p00im-ztfb10073301.me.com (Postfix) with ESMTPSA id 71783800D29;
        Sun, 16 Apr 2023 19:11:12 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     patrice.chotard@foss.st.com, Alain Volmat <avolmat@me.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: irqchip: sti: remove stih415/stih416 and stid127
Date:   Sun, 16 Apr 2023 21:09:50 +0200
Message-Id: <20230416190950.18929-1-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jkl-dPGDjNp7nHuhdjtxZtB-NUEdponJ
X-Proofpoint-GUID: Jkl-dPGDjNp7nHuhdjtxZtB-NUEdponJ
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-17=5F04:2020-02-14=5F02,2022-01-17=5F04,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=611 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304160181
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove bindings for the stih415/stih416/stid127 since they are
not supported within the kernel anymore.

Signed-off-by: Alain Volmat <avolmat@me.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Patch sent previously via serie: https://lore.kernel.org/all/20230209091659.1409-5-avolmat@me.com/
 .../bindings/interrupt-controller/st,sti-irq-syscfg.txt  | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
index ced6014061a3..977d7ed3670e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
@@ -6,11 +6,7 @@ and PL310 L2 Cache IRQs are controlled using System Configuration registers.
 This driver is used to unmask them prior to use.
 
 Required properties:
-- compatible	: Should be set to one of:
-			"st,stih415-irq-syscfg"
-			"st,stih416-irq-syscfg"
-			"st,stih407-irq-syscfg"
-			"st,stid127-irq-syscfg"
+- compatible	: Should be "st,stih407-irq-syscfg"
 - st,syscfg	: Phandle to Cortex-A9 IRQ system config registers
 - st,irq-device	: Array of IRQs to enable - should be 2 in length
 - st,fiq-device	: Array of FIQs to enable - should be 2 in length
@@ -25,11 +21,10 @@ Optional properties:
 Example:
 
 irq-syscfg {
-	compatible    = "st,stih416-irq-syscfg";
+	compatible    = "st,stih407-irq-syscfg";
 	st,syscfg     = <&syscfg_cpu>;
 	st,irq-device = <ST_IRQ_SYSCFG_PMU_0>,
 			<ST_IRQ_SYSCFG_PMU_1>;
 	st,fiq-device = <ST_IRQ_SYSCFG_DISABLED>,
 			<ST_IRQ_SYSCFG_DISABLED>;
-	st,invert-ext = <(ST_IRQ_SYSCFG_EXT_1_INV | ST_IRQ_SYSCFG_EXT_3_INV)>;
 };
-- 
2.34.1

