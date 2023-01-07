Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A3D660E75
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 12:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjAGLxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjAGLxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 06:53:16 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AF3E659B;
        Sat,  7 Jan 2023 03:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7pKMz
        uunzgd8Gl/u//B8xBMd+LHSKbAp95fT9I7HvY4=; b=FcdVETPnWguE1QZYNf+y4
        NDxqDmFQ61hvh6yYtzSdnw/ck8I2WcUhIKGY4z8z6BCiBdnRUe27zYwo4W5WQi8q
        o9wBw+S3nEplpcwWpMSr7sQ3UzK5McgYD+qkuZih5Lx29Kv1gYrnPOQhoMpUt6w+
        SWG1LHCfpwDX4oDkCwAKQM=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-2 (Coremail) with SMTP id _____wBHu7D2XLljEhFdAA--.29863S2;
        Sat, 07 Jan 2023 19:52:26 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     lasstp5011@gmail.com, Andy Yan <andyshrk@163.com>
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 2
Date:   Sat,  7 Jan 2023 19:52:21 +0800
Message-Id: <20230107115221.2125368-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230107115159.2125308-1-andyshrk@163.com>
References: <20230107115159.2125308-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHu7D2XLljEhFdAA--.29863S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAF4UArykuFy7tr45trb_yoW3ZFX_ua
        yxZr48CFW8AFWFqw1qka97CFyj9w4xKrykC3WFyF1DC34vy398tFZ3t34ayFy7Cr47urn3
        CF4SqrWUKFnxWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRJ5r2tUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiFgDvXl44WehpWQAAsA
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EmbedFire LubanCat 2

Signed-off-by: Andy Yan <andyshrk@163.com>

---

 Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 058ed707f3cd..870c32f8574b 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -100,6 +100,12 @@ properties:
           - const: embedfire,lubancat-1
           - const: rockchip,rk3566
 
+      - description: EmbedFire LubanCat 2
+        items:
+          - const: embedfire,lubancat-2
+          - const: rockchip,rk3568
+
+
       - description: Engicam PX30.Core C.TOUCH 2.0
         items:
           - const: engicam,px30-core-ctouch2
-- 
2.34.1

