Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F57695007
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjBMS52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjBMS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:57:26 -0500
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093E1F5D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676314642; bh=LCJ3fFVLWk/eUK9yUGCcjdXiFDDHOVpEFnZbOY9pThU=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Td3XoOXLl1QwuEmqo8i5PhYP+FXKHiDCDkBpjeOYJFwFJOzTCJilhKymY3vaVbM3/
         DSJuAQ+FGRUAzIYkg2HFU4IN0e4acsdd2QJolHVKm7R/7ggyLIlpL2LNHo5IkifcqY
         eWwJWemOkJLUtdc4M2PlK1IyMRtvdhq52GEdIE1bgxrQqBsFzQ3yvU/vPkFioCQV2W
         SovFgA0pD0HwePq2m/hp3w691elrATw4NFvnNeeyoPTqQCTnNV9vqXnmD81D8zO8MV
         iz7KrYG4rT1hiW0iklJ9F3484UPJ5RnMPpi9M4rwdq0QH+EUzsg8kqn/jerr5wHKEo
         Sqa4+xXhdQDzQ==
Received: from localhost (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 8F275800825;
        Mon, 13 Feb 2023 18:57:20 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     Alain Volmat <avolmat@me.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: arm: sti: add STi boards and remove stih415/stih416
Date:   Mon, 13 Feb 2023 19:56:31 +0100
Message-Id: <20230213185633.15187-3-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230213185633.15187-1-avolmat@me.com>
References: <20230213185633.15187-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K1Ft_7tA40Xa_jTu1TYNWO1G5EboWe3n
X-Proofpoint-GUID: K1Ft_7tA40Xa_jTu1TYNWO1G5EboWe3n
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=887 bulkscore=0
 mlxscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302130166
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for STi platform boards and remove stih415/stih416

Signed-off-by: Alain Volmat <avolmat@me.com>
---
v3: move back file into bindings/arm and update commit log accordingly
v2: update licensing
    move file into soc/sti folder
 .../devicetree/bindings/arm/sti.yaml          | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/sti.yaml b/Documentation/devicetree/bindings/arm/sti.yaml
index 3ca054c64377..842def3e3f2b 100644
--- a/Documentation/devicetree/bindings/arm/sti.yaml
+++ b/Documentation/devicetree/bindings/arm/sti.yaml
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/arm/sti.yaml#
@@ -13,13 +13,20 @@ properties:
   $nodename:
     const: '/'
   compatible:
-    items:
-      - enum:
-          - st,stih415
-          - st,stih416
-          - st,stih407
-          - st,stih410
-          - st,stih418
+    oneOf:
+      - items:
+          - const: st,stih407-b2120
+          - const: st,stih407
+      - items:
+          - enum:
+              - st,stih410-b2120
+              - st,stih410-b2260
+          - const: st,stih410
+      - items:
+          - enum:
+              - st,stih418-b2199
+              - st,stih418-b2264
+          - const: st,stih418
 
 additionalProperties: true
 
-- 
2.34.1

