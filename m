Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5F3744E90
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGBQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBQUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:20:39 -0400
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42855E61
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1688314838; bh=ihsW05Uhu9hqcllR7UBKHvIYj/SkTR9WK8vpLcgHFF8=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=KzXpI2w3XfjW1YbDtx1QDnhdKsZt2NEzSM9fWeVK4/wffHdVy9cvudVlwTFRmnAz/
         /XU4qGNw4uS2S2eBVqr//83AshPg+egZuITcdSacRy6HbGjPKYCNcbd6XkS+XyE4mv
         fxtymz6n3Dtt5ii1Csl/ZwW+Z6mRIDMk7c9nPiUfkbdM5/8XteUEYMPyxiWaPgJmRv
         dftQjOy903DSph6BpLRs3G7lD7PtNn0zpMfIW9BcBY+RxiDNIHkyZq0yLIUPmUiMBk
         xeDwI8j/iznUJKA0LC4ZQdDsu3DBSj2p1UQNt8An1JzhvfLEf+8K8M+WATFjB91U0h
         QdXjM1NQzH24A==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id C0D521680318;
        Sun,  2 Jul 2023 16:20:37 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     avolmat@me.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: st: move leds out of soc in stih418-b2264.dts
Date:   Sun,  2 Jul 2023 16:19:34 +0000
Message-Id: <20230702161936.134429-3-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702161936.134429-1-avolmat@me.com>
References: <20230702161936.134429-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Hq7pmxZDyMLLDW0rNQx6exNUaiH5LqEj
X-Proofpoint-ORIG-GUID: Hq7pmxZDyMLLDW0rNQx6exNUaiH5LqEj
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-11=5F01:2022-01-11=5F01,2020-02-14=5F11,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=550 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307020155
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the leds node out of the soc section
and correct the following warning:
Warning (simple_bus_reg): /soc/leds: missing or empty reg/ranges property

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418-b2264.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
index f496ca28850d..d4874282cfba 100644
--- a/arch/arm/boot/dts/st/stih418-b2264.dts
+++ b/arch/arm/boot/dts/st/stih418-b2264.dts
@@ -73,15 +73,15 @@ aliases {
 		ethernet0 = &ethernet0;
 	};
 
-	soc {
-		leds {
-			compatible = "gpio-leds";
-			led-green {
-				gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
-				default-state = "off";
-			};
+	leds {
+		compatible = "gpio-leds";
+		led-green {
+			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
 		};
+	};
 
+	soc {
 		pin-controller-sbc@961f080 {
 			gmac1 {
 				rgmii1-0 {
-- 
2.34.1

