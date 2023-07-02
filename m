Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4D744E92
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 18:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjGBQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGBQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 12:20:43 -0400
Received: from qs51p00im-qukt01080501.me.com (qs51p00im-qukt01080501.me.com [17.57.155.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668BFE62
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1688314841; bh=tikfUA3+VXi/hwqJ7CqZ/vgC+Mb6/V7T56yDg/1Q3/I=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=NWpYhx20spcAAG+lHyg2puSmMYdYYu11/fTgg+Fu4Bp1ajCyd83by4TKOi2Okc2hV
         XPTlgRvEWvFDVsImdV8xwrQANmh+bmXhNT7FgnHLJYv7I/arVr3Pl1TzfRuMnOsbN8
         3mgoHI4zyqdDHLjbygRWrPgweYqJ2IPO2tNMW4N80gitl/KVbR/rdbw2nsjN1oMxZn
         IgZJapw0EqB/08flrnDxmG7PkwoN1DSElCcoOCDnMAaDqfCPVg6iroTNN8jCnH9PHZ
         /N83/qfmaFxyOIcw1dUMXJkUDiOuWFE9+6utSh2pdm9Y9b0airqnLkAldJMykE2gqd
         u6vREY2zh73VQ==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id AEDF6198028B;
        Sun,  2 Jul 2023 16:20:40 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     avolmat@me.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: dts: st: correct led level in stih418-b2264.dts
Date:   Sun,  2 Jul 2023 16:19:35 +0000
Message-Id: <20230702161936.134429-4-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230702161936.134429-1-avolmat@me.com>
References: <20230702161936.134429-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HywNm_p0YEdWCCbmxWq_YEsGX7TzKvOu
X-Proofpoint-GUID: HywNm_p0YEdWCCbmxWq_YEsGX7TzKvOu
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=661 classifier=spam adjust=0 reason=mlx scancount=1
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

The state of the green led on the stih418-b2264 is currently
inverted.  Correct this by fixing the GPIO active state.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418-b2264.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
index d4874282cfba..fdc16e9f5822 100644
--- a/arch/arm/boot/dts/st/stih418-b2264.dts
+++ b/arch/arm/boot/dts/st/stih418-b2264.dts
@@ -76,7 +76,7 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
-			gpios = <&pio1 3 GPIO_ACTIVE_HIGH>;
+			gpios = <&pio1 3 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 	};
-- 
2.34.1

