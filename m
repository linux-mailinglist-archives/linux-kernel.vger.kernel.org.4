Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64DD86DCB91
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDJTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJTbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:31:17 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430A41BC2;
        Mon, 10 Apr 2023 12:31:14 -0700 (PDT)
Received: from shark3.inbox.lv (shark3 [10.0.1.83])
        by new-shark9.inbox.lv (Postfix) with ESMTP id AFBBC480813;
        Mon, 10 Apr 2023 22:31:10 +0300 (EEST)
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id A11CE28011D;
        Mon, 10 Apr 2023 22:31:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1681155070; x=1681156870;
        bh=SGtFRlfF4YRNNAwJZKm0kdZRSUL9WWAjLwOeMWQbjiQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         From:Date:To:Cc:Message-ID:Subject:Reply-To;
        b=UKym7BzJMv0IqOeQba7Tl66krFgNiiWjUpuu26eqsy8dhNjUfO6cKD588Y14uo4Zm
         VlSzkzFJ/U5xsgrmM0+mXwxibq8ZLoAKjI7RuEkQ642Lyk5imXjH+Z5ee4iM7NLg8d
         YRjI6z1A/K2tgB1UOS3XC0WgWp8sFjW1LJWbAJDw=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 9A9D7280111;
        Mon, 10 Apr 2023 22:31:10 +0300 (EEST)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id gLX5lS8QRGnE; Mon, 10 Apr 2023 22:31:10 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id 54DB12800F5;
        Mon, 10 Apr 2023 22:31:10 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Karl Chan" <exkcmailist@inbox.lv>,
        Karl Chan <exxxxkc@getgoogleoff.me>
Subject: [PATCH v3 1/2] dt-bindings: arm: amlogic: add Xiaomi Mibox 3 binding
Date:   Tue, 11 Apr 2023 03:30:47 +0800
Message-Id: <20230410193048.31084-2-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230410193048.31084-1-exkcmailist@inbox.lv>
References: <20230410193048.31084-1-exkcmailist@inbox.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: G4mEQ3gUh3tFv963KJpk5v+XuNvzCRoioUWJw7wy9QEqu8u6r7wBfW6TE4TmHAC6dWLD
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Karl Chan"  <exkcmailist@inbox.lv>

Add the board binding for the Xiaomi Mibox 3 Android Set-Top Box device.

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

