Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4BE5B8B95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 17:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiINPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 11:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiINPQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 11:16:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8D07D1D1;
        Wed, 14 Sep 2022 08:16:08 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:435d:1590:4ce7:da62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C9A46601688;
        Wed, 14 Sep 2022 16:16:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1663168566;
        bh=Awk8gdVLMc7GkngkNTgXjoLQjM9hAL8iu6EfvghDLeg=;
        h=From:To:Cc:Subject:Date:From;
        b=CHR09WNdkjUNos0yKd6JoZyAWikaYZYU0MB/T3WoxrQyOGEzeUkiecccCcvUcdL9I
         BbwyhoEEA2Y/hP+TniF7MIs/eugp/tvu270QdkQcVCIvh+KqcSfzgKtn6gHB7YtkJi
         3pJqNvxqQuc34g1mQmlvaDULLo7TtrLQTd8uTMN1W5jHp0IadBxNW/fO9ANGik12yd
         z88Sf+q1O7YhpW7LrezYEWpVwRBSAVnKqIBAm8BhWBmipyc18+DLiRx3+Jku9DY81+
         JG5tJ2pj8Y7OhulVoCIPyY1x4y6xUm4kiui9VCDZddVSwPIFiDjI5mLmcwsS20+pnU
         NvZMbomhvXgsw==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] dt-bindings: vendor-prefixes: add Diodes
Date:   Wed, 14 Sep 2022 16:15:53 +0100
Message-Id: <20220914151558.536226-1-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.com>

Diodes Incorporated is a manufacturer of application specific standard
products within the discrete, logic, analog, and mixed-signal semiconductor
markets.

https://www.diodes.com/

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v2:
 - None

Changes in v3:
 - None

Changes in v4:
 - None

Changes in v5:
 - None

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2f0151e9f6be..7ee9b7692ed1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -328,6 +328,8 @@ patternProperties:
     description: Digi International Inc.
   "^digilent,.*":
     description: Diglent, Inc.
+  "^diodes,.*":
+    description: Diodes, Inc.
   "^dioo,.*":
     description: Dioo Microcircuit Co., Ltd
   "^dlc,.*":
-- 
2.35.1

