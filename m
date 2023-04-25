Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545FB6EE632
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjDYQ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234849AbjDYQ5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:57:35 -0400
Received: from new-shark9.inbox.lv (new-shark9.inbox.lv [194.152.32.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9214E5594;
        Tue, 25 Apr 2023 09:57:24 -0700 (PDT)
Received: from shark3.inbox.lv (shark3 [10.0.1.83])
        by new-shark9.inbox.lv (Postfix) with ESMTP id 187FA48052F;
        Tue, 25 Apr 2023 19:57:23 +0300 (EEST)
Received: from shark3.inbox.lv (localhost [127.0.0.1])
        by shark3-out.inbox.lv (Postfix) with ESMTP id 081BD28018F;
        Tue, 25 Apr 2023 19:57:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.lv;
        s=p20220324; t=1682441843; x=1682443643;
        bh=lBR6HTqHzgUoGzc6OeC2Zmr/AmFRAGLoGdUpO8fVKuA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:X-ESPOL:
         From:Date:To:Cc:Message-ID:Subject:Reply-To;
        b=kDxf8oLZ/uot97+ZDSyqMQpF9tzhBwVz6dXrdGjp/3PdpNpCCUwXvpDEO0EE6w4QY
         F1AC6PENWOnHs8Q6UtEWxhgWP0aXNXhBpOQYzwqYJgTq07NSuy/KwgWjZYMd+lSI5y
         sJ0Kz/4SNqMArdTeQaXEMoMFgIQyaWDo88hZ3znk=
Received: from localhost (localhost [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id F401328018D;
        Tue, 25 Apr 2023 19:57:22 +0300 (EEST)
Received: from shark3.inbox.lv ([127.0.0.1])
        by localhost (shark3.inbox.lv [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id ujduB6TBSSOC; Tue, 25 Apr 2023 19:57:22 +0300 (EEST)
Received: from mail.inbox.lv (pop1 [127.0.0.1])
        by shark3-in.inbox.lv (Postfix) with ESMTP id AF02728018A;
        Tue, 25 Apr 2023 19:57:22 +0300 (EEST)
From:   Karl Chan <exkcmailist@inbox.lv>
To:     linux-amlogic@lists.infradead.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, "Karl Chan" <exkcmailist@inbox.lv>
Subject: [PATCH v5 1/2] dt-bindings: arm: amlogic: add Xiaomi Mi box 3 binding
Date:   Wed, 26 Apr 2023 00:56:23 +0800
Message-Id: <20230425165624.11999-2-exkcmailist@inbox.lv>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425165624.11999-1-exkcmailist@inbox.lv>
References: <20230425165624.11999-1-exkcmailist@inbox.lv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: OK
X-ESPOL: EZqEOgIB4BlLvMKgKZpu5uH6z9GvNCkuvCbmvcM9qS0Zt6+jx9N0dmeVEoHtGgW4bg==
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

Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
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

