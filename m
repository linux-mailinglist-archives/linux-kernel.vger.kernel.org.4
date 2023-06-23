Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF073B26C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFWIMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjFWIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:12:49 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC62105;
        Fri, 23 Jun 2023 01:12:47 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f766777605so354684e87.1;
        Fri, 23 Jun 2023 01:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507966; x=1690099966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/BXWd+aXbwkUNKUI7mfSjhHzxj8tSAcMR0CS9iLOvM=;
        b=jmIqHT/CcdyLsFc5y7eBYiVlKStmiR3TIJ13zxXRudhCX1fa21cPRZTIJXgzCfbRAQ
         X6K2+gdp7e/M6X1NYU9bFQ5My3n7u7aa6PBO993ksUF2fB8Sn1sy4nogY/KFNlYsgaEU
         IfwxoKgBM3Yi4xD1rQpkqEoObIbInHMGbNjjr+tDerMJqQmBAU45nB9LQal3SzFvjxvZ
         3Xe7BE0xmDVrGKeFajx75H9D07B4nWRP7w7RNqPqkCmRDU+mBxN96121V1xQI0QUNy+W
         A+PswPDyG6SzDWT/mfX5pT6+5lJ0QUhxjOXZW00+1/lQ9XGp7QSpBANUuCWXmDGI15DT
         11Aw==
X-Gm-Message-State: AC+VfDxLqj8jMWb2Fns3Yp+tibvDISf2jn8iqZMlG69RtWZZcBDyqS/o
        2UbdJLkwWsLk/HChQkKIxlQ=
X-Google-Smtp-Source: ACHHUZ4ck5IbQ01mdf/Ix/HFvSnfENX3i8B4yUMTbBumPBiunLk6yqstbrgqlT6rHg2SlJAMH3vWJw==
X-Received: by 2002:a19:7708:0:b0:4f8:770f:1b0b with SMTP id s8-20020a197708000000b004f8770f1b0bmr7889691lfc.33.1687507965493;
        Fri, 23 Jun 2023 01:12:45 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id l21-20020a7bc455000000b003f9b29ba838sm1594141wmi.35.2023.06.23.01.12.44
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
        Lucas Tanure <tanure@linux.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/4] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Fri, 23 Jun 2023 09:12:39 +0100
Message-ID: <20230623081242.109131-2-tanure@linux.com>
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

Add bindings for the Khadas Vim4 board, using A311D2 soc, a Meson T7
family chip.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 274ee0890312..8dbd65170c50 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -211,6 +211,13 @@ properties:
               - amlogic,aq222
           - const: amlogic,s4
 
+      - description: Boards with the Amlogic Meson t7 A311D2 SoC
+        items:
+          - enum:
+              - khadas,vim4
+          - const: amlogic,a311d2
+          - const: amlogic,t7
+
 additionalProperties: true
 
 ...
-- 
2.41.0

