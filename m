Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07AD736DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjFTNtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbjFTNtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:49:25 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E8D1982;
        Tue, 20 Jun 2023 06:49:03 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-30adc51b65cso4858554f8f.0;
        Tue, 20 Jun 2023 06:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268942; x=1689860942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/BXWd+aXbwkUNKUI7mfSjhHzxj8tSAcMR0CS9iLOvM=;
        b=NApmLDnNfjQ1YrC/l/zcCPX3CUlQw+ypVIQPsCywjBxU6TWZqiuzU0zG3JSpLZvh/W
         yCJ9gli72sWF4KXBdflmhZtN2hlBVImGEzJiWSbzTw+FeeeOOixkBBS+dd0VZDvN1lJX
         JULMZz/OK5b2BsItiDxQ7o2k55gyB9aLzsnF1QcwVjTvx4QEPkLNPLmecs18OdUY7oqN
         pgL5QBjZY4mwMfuXQekHisZ3fCvG7nlFwfWriR/Slr0MOqOPg6Yq1/94uJpMZFCHW1iF
         C8foQ99S0FIFASCq2CQ19BzwI8/ztANic9yBQVEWlVIF4tMHocERb6qy1GX5aYkkHFBc
         OZPg==
X-Gm-Message-State: AC+VfDyq2h772t3LBN4sR/lFHAKe7L2OZyK6S3Ww0aCNN9qPSs4DoTGW
        aKlAyy0+H4JhUD2hoKtafwc=
X-Google-Smtp-Source: ACHHUZ4HNFVMIUb0Zh7Gx0B6Oq8Kqx+HNyzAbEMjbWZVsRqaf8aq8GMkLYWMW/gF2A+AWb/keBBOCw==
X-Received: by 2002:a5d:4cc2:0:b0:30f:bea9:bf17 with SMTP id c2-20020a5d4cc2000000b0030fbea9bf17mr12536587wrt.30.1687268941809;
        Tue, 20 Jun 2023 06:49:01 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d4283000000b00312780bedc3sm2038012wrq.56.2023.06.20.06.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:49:01 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Tue, 20 Jun 2023 14:48:56 +0100
Message-ID: <20230620134857.238941-2-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620134857.238941-1-tanure@linux.com>
References: <20230620134857.238941-1-tanure@linux.com>
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

