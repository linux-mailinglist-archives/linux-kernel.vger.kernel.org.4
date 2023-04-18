Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54E6B6E679F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjDRO4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjDRO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:56:33 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E183B15470;
        Tue, 18 Apr 2023 07:56:15 -0700 (PDT)
Received: from shark2.inbox.lv (shark2 [10.0.1.82])
        by new-shark9.inbox.lv (Postfix) with ESMTP id CA283480B06;
        Tue, 18 Apr 2023 17:55:46 +0300 (EEST)
Received: from shark2.inbox.lv (localhost [127.0.0.1])
        by shark2-out.inbox.lv (Postfix) with ESMTP id B289FC0163;
        Tue, 18 Apr 2023 17:55:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681829746; x=1681831546;
        bh=H4pQJKYCOnpRLmsk5f6sq1pSgz19A7jPwuM6L4oJHNw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         From:Date:To:Cc:Message-ID:Subject:Reply-To;
        b=iJG2Q4SQntat0OXQuWdcyEB9Q8jNyXUmxCifE1sY+ftbskG+IGx91zSJgQb5DjAcs
         1AVMK2eUy0jcQOHdzK5of4YZzCQjbuZtCgCZpAitLB6kymiLqefTg+0vb9tpTn0THj
         7XO+ljKGlNJK7UArwHk9sHw0RQNh4LrVzLgQ8WcE=
Received: from localhost (localhost [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id A7776C0157;
        Tue, 18 Apr 2023 17:55:46 +0300 (EEST)
Received: from shark2.inbox.lv ([127.0.0.1])
        by localhost (shark2.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id KvW7JHCmu__P; Tue, 18 Apr 2023 17:55:46 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark2-in.inbox.lv (Postfix) with ESMTP id 5A95EC00C2;
        Tue, 18 Apr 2023 17:55:46 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Karl Chan" <exkcmailist@inbox.lv>,
        Karl Chan <exxxxkc@getgoogleoff.me>
Subject: [PATCH v4 1/2] dt-bindings: arm: amlogic: add Xiaomi Mi box 3 binding
Date:   Tue, 18 Apr 2023 22:55:14 +0800
Message-Id: <20230418145515.19547-2-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418145515.19547-1-exkcmailist@inbox.lv>
References: <20230418145515.19547-1-exkcmailist@inbox.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: EZeEAiZdmGU1y83GUJgOk+7lwN6zX18hviD70sRQ5HNYv63DsNlreWyLE4Xze3G0c2HD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Karl Chan"  <exkcmailist@inbox.lv>

Add the board binding for the Xiaomi Mi box 3 Android Set-Top Box device.

Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index b634d5b04e15..bc4da146a5de 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -99,6 +99,7 @@ properties:
               - libretech,aml-s905x-cc
               - libretech,aml-s905x-cc-v2
               - nexbox,a95x
+              - xiaomi,mibox3
           - const: amlogic,s905x
           - const: amlogic,meson-gxl
 
-- 
2.40.0

