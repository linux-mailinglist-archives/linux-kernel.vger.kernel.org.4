Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A98732000
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbjFOS3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjFOS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:44 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79D10F7;
        Thu, 15 Jun 2023 11:29:43 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3111cb3dda1so166128f8f.0;
        Thu, 15 Jun 2023 11:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853782; x=1689445782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lrjdhAQll3ozbKk3iq4lsIPgqd1B5L8UK1g627bZ2E=;
        b=EoKBbrbEPEkyJ/1brXTdkMWBrkGhHZwCFquTXrkEE97vqzpSFAAHCn2szP3G5DvAz5
         vw3FF4HHQiOpNxK+xI19j01YS8cDViVtYTir9hRLlNC8PNjUzyI+jUhv9qRhOjjoMTC2
         6vSS3MzbmC5+rCMx347+TOKWe8kobXR5xrf5KeAILQuAUfkYQSHdvk1ZR2sG9+h7kVX6
         ssHQ1Y2XFzqGhFPl88v3R90a8SPQxQ1gHUXuarHewG+qu7j2Ffs0BRnkXwiwLomff7Am
         Tl9CZlL4/yrzWpnVhsSGzoorW2h+fdf/7M7Cumi93bpF1kVSHPcHoXd3dPvYDDAgSuSw
         IsIg==
X-Gm-Message-State: AC+VfDxOdElDsREeV/eFT0HRQm2UPScD52HSp5CWGht0LWtkCb0D25va
        iYwuU0VymbqODtFQHdUlRys=
X-Google-Smtp-Source: ACHHUZ7r+9ZYNEqFLrWEjTH7jRPfEPnVtyW0dG2pYyt3SbaAiUU94hflUBEFZtkXrTda0ZhMeKhdLQ==
X-Received: by 2002:a5d:6b8c:0:b0:30a:c35d:25d3 with SMTP id n12-20020a5d6b8c000000b0030ac35d25d3mr14887733wrx.52.1686853782041;
        Thu, 15 Jun 2023 11:29:42 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:41 -0700 (PDT)
From:   Lucas Tanure <tanure@linux.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick <nick@khadas.com>, Artem <art@khadas.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Lucas Tanure <tanure@linux.com>
Subject: [PATCH 1/6] dt-bindings: arm: amlogic: add Amlogic T7 based Khadas VIM4 bindings
Date:   Thu, 15 Jun 2023 19:29:33 +0100
Message-ID: <20230615182938.18487-2-tanure@linux.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615182938.18487-1-tanure@linux.com>
References: <20230615182938.18487-1-tanure@linux.com>
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

Add bindings for the Khadas Vim4 board.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 274ee0890312..1091abbae6a2 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -159,6 +159,13 @@ properties:
           - const: amlogic,a311d
           - const: amlogic,g12b

+      - description: Boards with the Amlogic Meson t7 A311D2 SoC
+        items:
+          - enum:
+              - khadas,vim4
+          - const: amlogic,a311d2
+          - const: amlogic,t7
+
       - description: Boards using the BPI-CM4 module with Amlogic Meson G12B A311D SoC
         items:
           - enum:
--
2.41.0

