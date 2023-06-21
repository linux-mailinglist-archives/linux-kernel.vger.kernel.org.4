Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76AC73853A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjFUNcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjFUNc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:32:29 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5519E19AB;
        Wed, 21 Jun 2023 06:32:28 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-39ecf031271so2748802b6e.1;
        Wed, 21 Jun 2023 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354347; x=1689946347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+epYfBWfb+1x9J48BBgefK4RbF1tT6DdUYZkz0j7yII=;
        b=OMwS+96FQA1ZGTmDpCLiKjeF6afzAUFnejnLRpu6JHFTM0b1aNQwmxa6VbAibxcSWu
         udcm3Qh6+qgJY7qyjynpElBRwU0OoT22LmijPL+1fzFZQjVUULR1rX4B+P4Ct5i6iNb0
         lb0K285TswW2+O7qtztiQzKXgtAXy+k3AGrtsnrFPc4FD1+HMIHcEkmzQrGkLrDNZKKc
         //ZiDHOQ8ceVUdjjQuANndEz5v0qRSCctrg0Qe1I8URZLyglm6DfZn5lI6voJHHRfz6X
         HZsxP3yTw8nM/u7VMLHQ/jaNiec+TSwj6JyFLBgHv63BUtGvDao9clCNuGJIIoQHeZa5
         MWBw==
X-Gm-Message-State: AC+VfDwvSsOt86IgHCn3ARRmFbW9lSVeqU6v1sev7Ik3W6aFcFYibQS/
        NmRn+3x1Fg9hLcG9JwWvPdyL9B4OavmANF3r
X-Google-Smtp-Source: ACHHUZ4zNPDAe5uEN/n6D0xeeiNucAc8zANUHhXM9re06jw8HAHMKRDY+ryg26hjRI79GzQMdlcUjA==
X-Received: by 2002:aca:f0b:0:b0:396:11b3:5851 with SMTP id 11-20020aca0f0b000000b0039611b35851mr16382216oip.54.1687354347631;
        Wed, 21 Jun 2023 06:32:27 -0700 (PDT)
Received: from localhost.localdomain (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id bf24-20020a056808191800b00395f2c84b81sm2114206oib.54.2023.06.21.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:32:26 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
Date:   Wed, 21 Jun 2023 14:32:14 +0100
Message-ID: <20230621133215.109254-3-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230621133215.109254-1-tanure@linux.com>
References: <20230621133215.109254-1-tanure@linux.com>
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
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..860ab58d87b0 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -33,6 +33,7 @@ properties:
               - amlogic,meson8b-uart
               - amlogic,meson-gx-uart
               - amlogic,meson-s4-uart
+              - amlogic,meson-t7-uart
           - const: amlogic,meson-ao-uart
       - description: Always-on power domain UART controller on G12A SoCs
         items:
@@ -46,6 +47,7 @@ properties:
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
           - amlogic,meson-s4-uart
+          - amlogic,meson-t7-uart
       - description: Everything-Else power domain UART controller on G12A SoCs
         items:
           - const: amlogic,meson-g12a-uart
-- 
2.41.0

