Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF57D61D948
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKEKBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKEKAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:00:53 -0400
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0EC231235;
        Sat,  5 Nov 2022 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Czl4q
        KbZ1P2Rm8rk7b/rYCAyJZAXrME3xp7uotq4erI=; b=jOYKfXsKJSdQVWViEGg7E
        VpYC+42acnjYe7q6wsVj8lT8KValiJrVpHU3VH2ASRRsThYOYB+4mUq9KFi5fzUv
        XU3Lg3kHRxbxa7A8qHyh9BzrT0Xx+vda9eZYS7f8So4MSapUNeLx2vPY5J9OSNIm
        zgsBZglZhu9W2o6rAAhWoo=
Received: from ProDesk.. (unknown [58.22.7.114])
        by smtp1 (Coremail) with SMTP id GdxpCgC3vKgJNGZj5MCYpw--.33829S2;
        Sat, 05 Nov 2022 17:59:41 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, linux-rockchip@lists.infradead.org
Cc:     krzysztof.kozlowski+dt@linaro.org, pgwipeout@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Yan <andyshrk@163.com>
Subject: [PATCH v2 1/2] dt-bindings: rockchip: Add Rockchip rk3566 box demo board
Date:   Sat,  5 Nov 2022 17:59:35 +0800
Message-Id: <20221105095935.958144-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgC3vKgJNGZj5MCYpw--.33829S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtrWxAF4fAFyrWr1xKr45Wrg_yoWfAFXE9a
        4xZr45CF4rCFyY9w1jka1xGFyUtw47KFnrAF4rAF1DC34qy3ykKFZ3t347AFyxWr43urn3
        CF48XryqgFnxGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRX18m7UUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiTBOwXmI0WTuK3AABsS
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

Changes in v2:
- Move it before rk3568 evb

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 244c42eaae8c..e40a3da90000 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -749,6 +749,11 @@ properties:
           - const: zkmagic,a95x-z2
           - const: rockchip,rk3318
 
+      - description: Rockchip RK3566 BOX Evaluation Demo board
+        items:
+          - const: rockchip,rk3566-box-demo
+          - const: rockchip,rk3566
+
       - description: Rockchip RK3568 Evaluation board
         items:
           - const: rockchip,rk3568-evb1-v10
-- 
2.34.1

