Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A145873200F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjFOSaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFOS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:29:48 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A3199D;
        Thu, 15 Jun 2023 11:29:47 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-311167ba376so797604f8f.1;
        Thu, 15 Jun 2023 11:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686853786; x=1689445786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+CTYF5ruN+Zlst0kqVClfG2q0zNldhioydCFUBAjqvk=;
        b=S054bT1lrM/PWsRaNvvPbZPVtKFjamZSjJcfWmZ84rdy5x9CazvAlGFjDhxxQkD5Yl
         qxGHB9nCJKRxxjgNZ/CSIs8x+5oAMVU96kYb2GG0kcCQakFj2Eff1xS/7BQoTOnAJOQg
         Hs9cTTaZ+oZoXQoPgyA8VhFqG3y3sr5lcjyz9kmwTz9zIZZW37dB9K4hFfW3bKTDZegS
         UzGqQxxui1Gcp+2tPJhQhJ0TcwUprzuZhLvMTxvx5ZW04ByEPFuwbK2lSl7zxGQuknek
         h902l07yY7u4wFLJ+yBhVYV+ek7XboQPME1m4QPPZ6gTw9I8Mbfv947+udFmcBGGyLff
         jvcw==
X-Gm-Message-State: AC+VfDwzhLbqvtSgdbIjOpvi5Rz7pVzfQYV5/FzKljFqvy8E1UH+le5c
        hnNOTERBBx+mQQ693y24x2A=
X-Google-Smtp-Source: ACHHUZ5vOqyhP1OdkXL8MuvOVzixmo0+GdlGzvK4fRijspT6ebuOU5lRkUpf2TtIYL8e5FP59PQNaQ==
X-Received: by 2002:a5d:6408:0:b0:30f:a938:6d5d with SMTP id z8-20020a5d6408000000b0030fa9386d5dmr10449466wru.56.1686853785730;
        Thu, 15 Jun 2023 11:29:45 -0700 (PDT)
Received: from ryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm21525887wrr.46.2023.06.15.11.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 11:29:45 -0700 (PDT)
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
Subject: [PATCH 4/6] dt-bindings: serial: amlogic, meson-uart: support T7
Date:   Thu, 15 Jun 2023 19:29:36 +0100
Message-ID: <20230615182938.18487-5-tanure@linux.com>
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

Add serial bindings support menson T7 SoC family.

Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..01b01f8840ea 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -46,6 +46,7 @@ properties:
           - amlogic,meson8b-uart
           - amlogic,meson-gx-uart
           - amlogic,meson-s4-uart
+          - amlogic,meson-t7-uart
       - description: Everything-Else power domain UART controller on G12A SoCs
         items:
           - const: amlogic,meson-g12a-uart
--
2.41.0

