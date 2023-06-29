Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7D974211D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjF2Hfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbjF2He1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:27 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4001B30C5;
        Thu, 29 Jun 2023 00:34:25 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so389436a12.3;
        Thu, 29 Jun 2023 00:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024063; x=1690616063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nc1BU6BhZ7z4IqTRybSYVNkHF2gq7R9QPn7Ka511/8o=;
        b=BFaqi0vF4yTbBXtBSATA53NGh4rs9XV/Ooj+wOecRaJidrRXr91wx27EQNUv10grIf
         KADqvJVFt15eLz5UpVtPnuArTdHk43zysNtZszA5BRsjLoOYpjGMHGABvLe1JqyxoCpi
         nHabLH1zY+nOos61p06+61bZgskpolZ3JC/e9Wx0VHSm0ThvwN5y14eohbjeoaHkdN/+
         no8a4XCZu9EEwfRlPKHsFLqIM7lQ0B1stm5vvat9yPoEDO1bWwt4Q21uHowcVv/ShzBo
         FYm7AaETy+BENVR0MG/Qj+Bwdw5Ux9oqieQCnKvwW6kMOzo5OjxiVOH2CuG2qpxsHNze
         xInA==
X-Gm-Message-State: ABy/qLb460cnhW7a1V5/7p2XWEyhO9VQZdU1ohjxDKfEJPd7SzfLZ43j
        FC1awMzx6q+lgKOMyIM14y0=
X-Google-Smtp-Source: APBJJlF7URx8BE0lY+MGEELC1a/SQZVKF9RkK/VhLFS096RToUMgbWS6WUN+sRTll4ZitQolY8aF6Q==
X-Received: by 2002:a50:fc13:0:b0:51d:df35:3818 with SMTP id i19-20020a50fc13000000b0051ddf353818mr733004edr.5.1688024063671;
        Thu, 29 Jun 2023 00:34:23 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm5453716edb.39.2023.06.29.00.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:34:23 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Lucas Tanure <tanure@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 2/4] dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
Date:   Thu, 29 Jun 2023 08:34:17 +0100
Message-ID: <20230629073419.207886-3-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629073419.207886-1-tanure@linux.com>
References: <20230629073419.207886-1-tanure@linux.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/serial/amlogic,meson-uart.yaml        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..591d1f8de191 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -50,6 +50,10 @@ properties:
         items:
           - const: amlogic,meson-g12a-uart
           - const: amlogic,meson-gx-uart
+      - description: UART controller on S4 compatible SoCs
+        items:
+          - const: amlogic,t7-uart
+          - const: amlogic,meson-s4-uart

   reg:
     maxItems: 1
--
2.41.0

