Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774A35B5821
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiILKWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiILKWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:22:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445CE1CB3C;
        Mon, 12 Sep 2022 03:22:34 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:15b7:c21a:ebde:697f])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D0D2D6601FD2;
        Mon, 12 Sep 2022 11:22:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662978153;
        bh=UmkgFoL5ccaGlsU0tzCglPuAu5Sm6Tllr77E10a9Q80=;
        h=From:To:Cc:Subject:Date:From;
        b=iQVRfQqbfm+2/b78amv8vqK0LwZsO76ECfwoycC4RvXDbMZjbqJBrSWvkjqQHFrl7
         n+Dbf+hG62VWsj74sx1I+76ucBXR5lgRVhM/FJIO5UMi8LmmfQJzYUrmYQdmGhQcZX
         TvIf3iFNsg2QNcD/G3mwMdthHib3pt84j9SLGqqBxF7VVjX4twiVa6qRSKeLgw0/jd
         nS5ypIe7YAAMHXip9J/I/xPBXImYmiV0CigXymke+4hqlUzXGNcndG3FBtmM8yhsYC
         9FqJNmGcIZktDzl3pzzCf+1+fnkGj9z1fwcKzW8i5/88WIeMS9y0RSv1F/GHz8zF2D
         9MMQVRL/2xMbQ==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: add Diodes
Date:   Mon, 12 Sep 2022 11:22:18 +0100
Message-Id: <20220912102223.1050418-1-martyn.welch@collabora.co.uk>
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

