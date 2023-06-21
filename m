Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18187738537
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjFUNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjFUNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:32:26 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A361997;
        Wed, 21 Jun 2023 06:32:25 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3a0423ea74eso962304b6e.1;
        Wed, 21 Jun 2023 06:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687354344; x=1689946344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/BXWd+aXbwkUNKUI7mfSjhHzxj8tSAcMR0CS9iLOvM=;
        b=WU2GMQcK1Lar7WTqPzOXlh/agjfKaubdBQ54PZ7V98k8ajh3Igigg3TswBKALW6/C/
         VW84CWYHgyDP2bvKkQ7zWn3oqjqj4I+vI14bikpVNhKtftBGg6tzWyK2+HJ6Zz9daRrK
         T8tV5wEvzAmAkprlZnh8/l8ZcTenITwyyJfPAAY1e+fUFeKOEuAkGLmG5b9rrvxytguD
         xrLm3tOX5K6kMBYubkbhDsI6gSk9YAl7zMY6fjlFntiDL7RXyEoDr+cLUIBmwQrJ232V
         EtEFIZKdaR4DzPdaHDv36K0kOhr2IqvpnLRef0InBqIa9fe8fA81InfZLc7fREtEv77C
         1XOw==
X-Gm-Message-State: AC+VfDxK2JbOwHPXzJDYWb0uCuaj7yu2u905/rUdhnULBkJUgUVom+Zi
        BqyV5k2cnXEvdYv/A6UszKE=
X-Google-Smtp-Source: ACHHUZ4zZPnP3Kwl2dc4iT9x6MuYM3yLaD3z3ulFocAGM5I9b07DhZrJuBAna5D/GjgtO3RZ+DCudA==
X-Received: by 2002:a05:6808:ddf:b0:3a0:3f15:1aca with SMTP id g31-20020a0568080ddf00b003a03f151acamr3971860oic.55.1687354344688;
        Wed, 21 Jun 2023 06:32:24 -0700 (PDT)
Received: from localhost.localdomain (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id bf24-20020a056808191800b00395f2c84b81sm2114206oib.54.2023.06.21.06.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 06:32:24 -0700 (PDT)
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
Subject: [PATCH v3 1/3] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Wed, 21 Jun 2023 14:32:13 +0100
Message-ID: <20230621133215.109254-2-tanure@linux.com>
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

