Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF86739A33
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjFVIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbjFVIlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:41:11 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05E22707;
        Thu, 22 Jun 2023 01:40:50 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fa0253b9e7so3701465e9.1;
        Thu, 22 Jun 2023 01:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687423249; x=1690015249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/BXWd+aXbwkUNKUI7mfSjhHzxj8tSAcMR0CS9iLOvM=;
        b=giYs465E4aKphj+Di8wzv6flm2H1WdXJTvgHFAVyh9aZjznwFu3PVMQJ16R8fL5m04
         Z668ePE+hf+4kIJs39gQ9t7mMcVrenP8dOXRAdhb6UqFfdIBXCuSW8SbupXaYFeFj8Zr
         gCcyF9qC5sMgJxSUHg5Op/jrQB64KT/GIITWQ9cpSZy4IdCpLvEUWbfO56BSbSrF/ZIg
         pDPplM7eVWn5XaEiN+J7ZiF7uPy6BJAssUFjXuuIt8jvTu2ojG2b23mEd8NXrgECujZz
         5bipQBddnunBYMgBnEotkaY0as7ajVwy9ZPqgFvvwYfam50hwPh4dlni4LIbMLrFlgsU
         3DZQ==
X-Gm-Message-State: AC+VfDykzhAMkJ7aVlqvfKSrTsBjGOnegrSYiqaUrbOol4Gt5wyET22Q
        bCtO1zEnl9n2zC8JZp4/+os=
X-Google-Smtp-Source: ACHHUZ4Ca7iBZ3ZCuOXAnDKqAifQ64bKpCk3sOUgGBoiSfKcvNVDLsJWLheN8E6T+jv0GFN4aJdQfw==
X-Received: by 2002:a05:600c:808a:b0:3f9:b93:ed5 with SMTP id ew10-20020a05600c808a00b003f90b930ed5mr11376889wmb.12.1687423248844;
        Thu, 22 Jun 2023 01:40:48 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003f7f87ba116sm15441277wml.19.2023.06.22.01.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 01:40:48 -0700 (PDT)
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
Subject: [PATCH v4 1/3] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Thu, 22 Jun 2023 09:40:43 +0100
Message-ID: <20230622084045.519203-2-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622084045.519203-1-tanure@linux.com>
References: <20230622084045.519203-1-tanure@linux.com>
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

