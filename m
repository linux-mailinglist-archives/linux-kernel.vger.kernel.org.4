Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA1619659
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKDMjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbiKDMjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:39:01 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D22995FCD;
        Fri,  4 Nov 2022 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=cFqUD
        lfwiLgi5JaL4lWh07zL/as/VAx2pOsopS0dn9A=; b=OPgdPQdErABZ1xHz93n+b
        XgwcTi0Gbfr0JPcgyAMcbdwmhEe0XRWvRNb4/fC+18AgGpxiMjtx3p6bCDs8thv5
        iSxpRKw4Ce0EyBW1CSLOeE/wElLw6G2dfWbVU+nEI4BLUx2Xs9VVA9GwhxLmGYGa
        xFYhXVccE1gwIH6tQ1a7M8=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp4 (Coremail) with SMTP id HNxpCgCXXyetB2Vjm7K0qA--.37423S2;
        Fri, 04 Nov 2022 20:38:09 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, pgwipeout@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/2] dt-bindings: rockchip: Add Rockchip rk3566 box demo board
Date:   Fri,  4 Nov 2022 20:38:04 +0800
Message-Id: <20221104123804.484109-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCXXyetB2Vjm7K0qA--.37423S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxuw1xGFy5XrWfZrWfGrg_yoWfXrcE9a
        4xZr4UCF4FyFyY9w1UCa97GFy5tw17KFnrAF4rAF1DC34qy395tFZ3t342yFyxWr13urn3
        CF40qry7KFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRJKsj7UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBEhGvXmI0U2Dd9wAAs9
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree binding for Rockchip rk3566 box demo board.

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 244c42eaae8c..618c78fb9d5e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -754,6 +754,11 @@ properties:
           - const: rockchip,rk3568-evb1-v10
           - const: rockchip,rk3568
 
+      - description: Rockchip RK3566 BOX Evaluation Demo board
+        items:
+          - const: rockchip,rk3566-box-demo
+          - const: rockchip,rk3566
+
       - description: Rockchip RK3568 Banana Pi R2 Pro
         items:
           - const: rockchip,rk3568-bpi-r2pro
-- 
2.34.1

