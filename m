Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8236073B26D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjFWIM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjFWIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:12:49 -0400
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636B61FEF;
        Fri, 23 Jun 2023 01:12:48 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-4f875b267d9so383029e87.1;
        Fri, 23 Jun 2023 01:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507966; x=1690099966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGvZYo2Xe8nWteW+0mB4VjnmUSaAF1CaOPdHGsKnyTU=;
        b=YH68iH/UlDCgUZIunI2Z1XOlLO+wfo//pkUFRYmF9stx6gxqRWyFlyFHf0Dq2mhFuZ
         rWRhio/BLRpLACKwsD02wi0ziCEuf7sJxxClnX4RipnjCTFilzchKCdt8T0mCxExpYth
         HijWA5OfMp8KgxshPOX68+pvCgFlx6ybZuoLoQe4y1fMqUK2+ehR1Dcw0nHtdJItrmxL
         OUvTk+K09qqz/fU3xQ6Fx4QhjnyuKTQpjTlkX1snwdalLiFMxJI+rvJCnRJToZXrlr4X
         o8XukkYQXvFEv9Mqj8x7EbA4Bvbw/eyJ85151BKQzAh5ND9Z+DsOsYCSBuMFh7YffMVq
         H8wg==
X-Gm-Message-State: AC+VfDzbBTd82UiFegyva13/yretUWAqTN/VW4CqwHzEfQIwhlj1T7A6
        7KMJTUdY30D9zAAeK9/3FaY=
X-Google-Smtp-Source: ACHHUZ7SXZVXvO3FSaVk617WP+fiSNU/3M9rGM3KTy+vnSTVvZiAFrnSd7gmCEczmqQ/5m9A4TcPfg==
X-Received: by 2002:a19:8c49:0:b0:4f8:6e6e:4100 with SMTP id i9-20020a198c49000000b004f86e6e4100mr9597994lfj.52.1687507966306;
        Fri, 23 Jun 2023 01:12:46 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bc455000000b003f9b29ba838sm1594141wmi.35.2023.06.23.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:12:45 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH v5 2/4] dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
Date:   Fri, 23 Jun 2023 09:12:40 +0100
Message-ID: <20230623081242.109131-3-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230623081242.109131-1-tanure@linux.com>
References: <20230623081242.109131-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
There is no need for an extra compatible line in the driver, but
add T7 compatible line for documentation.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..ad970c9ed1c7 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -50,6 +50,10 @@ properties:
         items:
           - const: amlogic,meson-g12a-uart
           - const: amlogic,meson-gx-uart
+      - description: UART controller on T7 compatible SoCs
+        items:
+          - const: amlogic,meson-t7-uart
+          - const: amlogic,meson-s4-uart
 
   reg:
     maxItems: 1
-- 
2.41.0

