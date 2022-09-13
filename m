Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715D5B7740
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiIMRFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiIMRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:04:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691579EE1;
        Tue, 13 Sep 2022 08:54:57 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:dd1a:56ef:ffd9:f71c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F7596601F9E;
        Tue, 13 Sep 2022 16:54:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1663084441;
        bh=pvWhVzpGSdCdMt93Q2cYWMs/1fHlhI/I0Tq0M6hXpd4=;
        h=From:To:Cc:Subject:Date:From;
        b=C53bPee+1BzNSFOYVOXHTGVrO0Cnq7Mu+Cy/6k/69jQ6OTPDQ3W0Y+FHNgCp2ErFs
         8AOfI/wxiKMbe2jCPc9lmOH6He5wdxPsYtbMUv20kCB+HEw0wMfphZhjYVn0EBBFM5
         Ob9NSHeg3OBMFpfb7Bs0dqXvoirc4gfkzNu2A0DtAAJVyGwO9E3erj7b1eTt0Heq2q
         nhBEYDzTRTnIwn0Xfq66E+P18wyY2nYCD2dWjaGTfmmOPPc6d6EWqpCt72cG7M7mu0
         Ds5wdAm2ZubxofdHjvmJfbQH4w+L/QA/ipG6D19yjNDE+nGbIpamWO4LtpQAALk1a1
         8pi8FqvKCnz7g==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: add Diodes
Date:   Tue, 13 Sep 2022 16:53:44 +0100
Message-Id: <20220913155348.38716-1-martyn.welch@collabora.co.uk>
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

