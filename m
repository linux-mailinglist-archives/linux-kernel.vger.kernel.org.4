Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDF6480EC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiLIKZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiLIKZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:25:47 -0500
Received: from mail-m121145.qiye.163.com (mail-m121145.qiye.163.com [115.236.121.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599546ACC3;
        Fri,  9 Dec 2022 02:25:45 -0800 (PST)
Received: from amadeus-VLT-WX0.lan (unknown [218.85.118.194])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 03935800118;
        Fri,  9 Dec 2022 18:25:35 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     FUKAUMI Naoki <naoki@radxa.com>, Peter Geis <pgwipeout@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Radxa CM3I E25
Date:   Fri,  9 Dec 2022 18:25:23 +0800
Message-Id: <20221209102524.129367-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221209102524.129367-1-amadeus@jmu.edu.cn>
References: <20221209102524.129367-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT00eVk9NShhCGEgZT0tOTFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlKQ1VDTlVKSkNVSkJPWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6Kxw*Cz0sLEsrNUMWIzkw
        KkhPCytVSlVKTUxLTkNKTkhNTkJKVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlK
        Q1VDTlVKSkNVSkJPWVdZCAFZQUlISEM3Bg++
X-HM-Tid: 0a84f66b45ccb03akuuu03935800118
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radxa CM3 Industrial (CM3I) is an System on Module made by Radxa
based on the Rockchip RK3568 SoC. The first carrier board supported
is the Radxa E25. Add devicetree binding documentation for it.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 88ff4422a8c1..3af95dbb95dc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -599,6 +599,13 @@ properties:
           - const: pine64,soquartz
           - const: rockchip,rk3566
 
+      - description: Radxa CM3 Industrial
+        items:
+          - enum:
+              - radxa,e25
+          - const: radxa,cm3i
+          - const: rockchip,rk3568
+
       - description: Radxa Rock
         items:
           - const: radxa,rock
-- 
2.25.1

