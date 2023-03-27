Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533516CAB73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjC0REl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjC0RD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:03:56 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429CA423C;
        Mon, 27 Mar 2023 10:03:02 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id o15-20020a4ae58f000000b00538c0ec9567so1441667oov.1;
        Mon, 27 Mar 2023 10:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPOFBMhoL4jHZsvJmOjSl5D0BIN5gJSRQGiqE9q2H3c=;
        b=EV95hzMCUzndCFTjh9sIYlnowRNnMu6abJVpBzlHRvAYWrLfUfbg+hO7bQSUPvgIqJ
         3B2RupqgWWp3FGKQo5DhzOUSlUi8vaLwJFDBMytPiivB3GBlSBQWw51OwLofIZPxXjRO
         7i2oMmclJI6R0heMP1jVUxY9TXwbWAP6rQOQhLMmzy5BTDhnDdPNi+NBlraOmJYPyEZz
         KXUNTdwcvxwc0T4DTkDg5hb+ff6B6OUNeIuvSha5lttUQqlYHLo56kooLUL21gh86Kx9
         M/iEgpB4mhwAWGk8z0A81qxkOZNa0j8vmU/+OcAk+N2UcJfplWf8NOXq80EF86U8DNxB
         N+0Q==
X-Gm-Message-State: AO0yUKUc2lzfbgI36YRC0lJiyjijA+tge9zLpSnt7y/vtq64zKvQcSlc
        r4NrNDoxXU3d7EyBmEoGtMmj/xjD4g==
X-Google-Smtp-Source: AK7set+ReDeZtRjKuKxOhzOxaf9gzw3n2yPYHW0trSCSXupHPjmIjp9ZmSyOMp5s4T1qdqiErzfeYA==
X-Received: by 2002:a4a:4185:0:b0:533:c6b7:27dc with SMTP id x127-20020a4a4185000000b00533c6b727dcmr5766669ooa.0.1679936549473;
        Mon, 27 Mar 2023 10:02:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j13-20020a4a944d000000b00539b8372bd7sm10950434ooi.29.2023.03.27.10.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:02:28 -0700 (PDT)
Received: (nullmailer pid 4108900 invoked by uid 1000);
        Mon, 27 Mar 2023 17:02:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: soc: amlogic: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:02:22 -0500
Message-Id: <20230327170222.4107746-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml      | 4 ++--
 .../bindings/arm/amlogic/amlogic,meson-mx-secbus2.yaml        | 4 ++--
 .../devicetree/bindings/soc/amlogic/amlogic,canvas.yaml       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
index 1748f1605cc7..7dff32f373cb 100644
--- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-gx-ao-secure.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/amlogic/amlogic,meson-gx-ao-secure.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/amlogic/amlogic,meson-gx-ao-secure.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Firmware registers Interface
 
diff --git a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-mx-secbus2.yaml b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-mx-secbus2.yaml
index eee7cda9f91b..09b27e98d4c9 100644
--- a/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-mx-secbus2.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic/amlogic,meson-mx-secbus2.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/amlogic/amlogic,meson-mx-secbus2.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/amlogic/amlogic,meson-mx-secbus2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson8/Meson8b/Meson8m2 SECBUS2 register interface
 
diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
index c3c599096353..cd06865e1f2a 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,canvas.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/amlogic/amlogic,canvas.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/amlogic/amlogic,canvas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Canvas Video Lookup Table
 
-- 
2.39.2

