Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3813973F85A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjF0JKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjF0JKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:10:15 -0400
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C81718;
        Tue, 27 Jun 2023 02:10:13 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b698371937so41529831fa.3;
        Tue, 27 Jun 2023 02:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857012; x=1690449012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJ4ox9zZfq6KQM/b5bg29ZlihQTwce7dLHJXfPOkyG4=;
        b=l0/lDGVnz9LeBA0EkDGODSUllgwKP3kq233E9U3sX8YtjbZ/uagCGNoJBPCmmZCQ1Z
         13V01VoDMxE21jPdmuUM66+aOR+8QjVk2J/icvdt+VwYzpHEKmK+Ys/iyB3J+Ksa/CgF
         cwWydhoXh+56Fl207ZGCXjK4jET2lr0jLadzpDzJEl/25lT1ROMGr9IQvTKj9S1XLx7z
         OJjLmDdF4jV09Sc8sLvtiL62PZPYzfxRyDZRNPPT9ROMtoAfU0xWm5AWlDou0GR63c6P
         tm2cTAOeyvIYqEfwJXR8Z8m9S67KFfT/UDYcDHJ5S5Ju6zviX7I1pwWl+Q8jd7wx+eK0
         FhMA==
X-Gm-Message-State: AC+VfDzpAm1x6JHZmU01x4Uc+0M9EAl+p1C3V58FlmFMXkSEq0ze4BYr
        PMkIRUSW32YShJ/Y/ebfJI8VZPkQwZUPq9SE
X-Google-Smtp-Source: ACHHUZ7fSXRncc/WNbUjlTRqfhyq2XPf1I7o7GDIYcMY+0k+/BGmCnQ2hMRniMAAq1/HHMIODpfiYQ==
X-Received: by 2002:a2e:9212:0:b0:2b5:bc27:d6e1 with SMTP id k18-20020a2e9212000000b002b5bc27d6e1mr5281655ljg.3.1687857011458;
        Tue, 27 Jun 2023 02:10:11 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c15-20020adffb4f000000b00313e4d02be8sm8880122wrs.55.2023.06.27.02.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:10:10 -0700 (PDT)
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
Subject: [PATCH v6 1/4] dt-bindings: arm: amlogic: add Amlogic A311D2 bindings
Date:   Tue, 27 Jun 2023 10:10:04 +0100
Message-ID: <20230627091007.190958-2-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230627091007.190958-1-tanure@linux.com>
References: <20230627091007.190958-1-tanure@linux.com>
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

