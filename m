Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3D274211A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 09:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjF2HfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 03:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF2HeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 03:34:25 -0400
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D63130D1;
        Thu, 29 Jun 2023 00:34:24 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-51d88f1c476so403460a12.0;
        Thu, 29 Jun 2023 00:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688024063; x=1690616063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ4ox9zZfq6KQM/b5bg29ZlihQTwce7dLHJXfPOkyG4=;
        b=VeRwiXwdHm7PtSUS7OD7KsFU63ivfoqUzdTat6N+mDNc5wLnD3S3H3/vKOfAun5/oe
         U93SmyfTraT/LP3zsN5e3V9XyG0CPrTMf5dCLoIkKc2iCK6uKo5BWrP2G6aw2/Mne13C
         XqU/kG6RoGP8wnnwH2X+bDWUVI1oTzqVhmZH42UaDt7ComVESjXvWmRSbaY1hPVR4Uky
         ic5yAimyx6fQrOSFZ0TV8xCWSkXfpEkW1eH+WR09h5vZnx1AxS2tbDzQCVdLGEGYysMW
         YECOvoz9FzWuJCJ1exH0uw4WH759rlvR1MmRKU7mEdJ4purN4PGiM2qkdazdt67R4rjM
         XYug==
X-Gm-Message-State: AC+VfDyZr44a5iXFPzflTD8oMvzHtF8Q5pegiqB1Ed7sXt7Tdw/L8tfB
        m/olZS3OR1P+r12gt6zPau4=
X-Google-Smtp-Source: ACHHUZ5ZWSjPN0NrgQepSKQo3xSVhg4hRbqN5hNVmCYj7p5kdjKL+k22FpEd/8HjjJgdz7L8YI5FnQ==
X-Received: by 2002:aa7:c685:0:b0:51d:d2c7:70e3 with SMTP id n5-20020aa7c685000000b0051dd2c770e3mr1922641edq.42.1688024062591;
        Thu, 29 Jun 2023 00:34:22 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id be28-20020a0564021a3c00b0051bfb7de166sm5453716edb.39.2023.06.29.00.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 00:34:22 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/4] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Thu, 29 Jun 2023 08:34:16 +0100
Message-ID: <20230629073419.207886-2-tanure@linux.com>
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

Add bindings for the Khadas Vim4 board, using A311D2 Soc from Amlogic T7
family chip.

Signed-off-by: Lucas Tanure <tanure@linux.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 274ee0890312..f5c51dfe4281 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -211,6 +211,13 @@ properties:
               - amlogic,aq222
           - const: amlogic,s4

+      - description: Boards with the Amlogic T7 A311D2 SoC
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

