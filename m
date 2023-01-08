Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE286614A9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 12:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjAHLIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 06:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjAHLIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 06:08:21 -0500
Received: from m12.mail.163.com (m12.mail.163.com [123.126.96.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C975DAE66;
        Sun,  8 Jan 2023 03:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=uWVgd
        FKv8uXC1FyWceZYB1LxeZQTwMP3xvENwSOlOJc=; b=euWWRUaxuOnRSFsUJBxl1
        voWzqdTHENzNeZ8h4EwDCpvV1/l3BglPND2bbRp/twNBzUUyPH+attq4d3p4obmy
        ClcA5o9jVpWtvhBCRlBk3kSGR8C5os9tN60PZ74gHvK/9gbyg9B1fikrRifp4VZT
        piQ/zECtTOOJIcAT8IBX1I=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp19 (Coremail) with SMTP id R9xpCgBX9DwApLpjWHWuEg--.44923S2;
        Sun, 08 Jan 2023 19:07:49 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com, Andy Yan <andyshrk@163.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
Date:   Sun,  8 Jan 2023 19:07:42 +0800
Message-Id: <20230108110742.2214800-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108110708.2214718-1-andyshrk@163.com>
References: <20230108110708.2214718-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: R9xpCgBX9DwApLpjWHWuEg--.44923S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4DGw1fKF15Gw13Gw18Grg_yoWfCFXE9a
        yxZr1UCFW8AFyYgw4DKa97CFyYyw4xKrykCF1FyF1DC340yw45tFWkt343AFy3Cw47urn3
        CF4fXrWUCFnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRJEfYtUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbivAbwXmASam4hzgAAsN
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EmbedFire LubanCat 2

Signed-off-by: Andy Yan <andyshrk@163.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
- keep only one blank line

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 058ed707f3cd..c238c799dee7 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -100,6 +100,11 @@ properties:
           - const: embedfire,lubancat-1
           - const: rockchip,rk3566
 
+      - description: EmbedFire LubanCat 2
+        items:
+          - const: embedfire,lubancat-2
+          - const: rockchip,rk3568
+
       - description: Engicam PX30.Core C.TOUCH 2.0
         items:
           - const: engicam,px30-core-ctouch2
-- 
2.34.1

