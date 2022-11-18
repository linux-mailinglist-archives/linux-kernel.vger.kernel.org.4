Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466062F9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242406AbiKRPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242297AbiKRPuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:50:15 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966738B124
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:50:09 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id i186-20020a1c3bc3000000b003cfe29a5733so7815078wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 07:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZLQieUidZlNqVrKwu39po09Jc+DVA7oSfqP+BkaPT0=;
        b=XqNd0uAyJhWFtotx7vjCSEtvyrwCBbOy730MU2iqH9Bb6DXPmJEGFeKr4QtZDd7Tjy
         7IejBtA0HLuYABlkkjh2YvpHHI+g4jgWFpeisHhAFvP4jeomO1tNgCvNn433rh9zJiBi
         Fsoc1TOdRPVBBwRGj6Os62dOucnSbPdirCII9CdDD4kwp6Dlzck+KwQiXqPnZMIWJX4V
         96psaJA9hMsp1STUmWWHdfwi6SPcY5+T3t10yf7W+5dx9+UDHw0z4PkLIqGbueZbDDyo
         U2b3pzo25Kyup8PT1V9FKlQAQHrKHRzwH8CgHOtBdTKEpN3xPCAb1ckxA8uf4UXmMV71
         eZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZLQieUidZlNqVrKwu39po09Jc+DVA7oSfqP+BkaPT0=;
        b=oI7BEu+UVNrFAbwtU61PbeBX+6xLA5en/SIu5YLfJcndo8fjm0HbKWzN1p0FmzzaUM
         5k5ca2naBrVy495cWJTQE3H32WZeqQVZx4L7oYvYIO46/t1rZOa0AdXC5XWXrdd8GmC8
         cqwp721iAI8HVpGWTrXRKCru6ddLQ3rSSqxRbBw0k87x6XKdSlXkIngxd4ch7jY5c3WL
         ewhNCngD6QBIpwxhgcjAgns3HST5sym0XfRcsl3kq+ZPjGfcW3Zxk93rcNUDg+TRxgYY
         CBZI+/WBRWISKGRJoU3RDaOLif68Ay90KN1nFpPOU7iebXK0ygzdtWegCDkQYSOQOIhG
         CAqA==
X-Gm-Message-State: ANoB5pl0fB3fdi3wEYHDXAzBE36siNoKulxUobB0RW1MS0XQ6ymRtzr4
        L8SRYWmyBOyUMMwBCZbas2fGQw==
X-Google-Smtp-Source: AA0mqf7cj+n72vPORo59VxFb5rqtLtnKdyXmn3W8xEo2uhlOrcC7huqtnuGH5Z3zdkviwiXoWdJ2lw==
X-Received: by 2002:a1c:f401:0:b0:3c7:84d:72d with SMTP id z1-20020a1cf401000000b003c7084d072dmr8854319wma.181.1668786607821;
        Fri, 18 Nov 2022 07:50:07 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d53cd000000b002383edcde09sm3812465wrw.59.2022.11.18.07.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 07:50:07 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 18 Nov 2022 16:50:05 +0100
Subject: [PATCH v2 1/2] dt-bindings: amlogic: document Odroid Go Ultra compatible
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <20221031-b4-odroid-go-ultra-initial-v2-1-a3df1e09b0af@linaro.org>
References: <20221031-b4-odroid-go-ultra-initial-v2-0-a3df1e09b0af@linaro.org>
In-Reply-To: <20221031-b4-odroid-go-ultra-initial-v2-0-a3df1e09b0af@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Sebastian Reichel <sre@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pm@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the Odroid Go Ultra, a portable gaming device,
with the following characteristics:
- Amlogic S922X SoC
- RK817 & RK818 PMICs
- 2GiB LPDDR4
- On board 16GiB eMMC
- Micro SD Card slot
- 5inch 854×480 MIPI-DSI TFT LCD
- Earphone stereo jack, 0.5Watt 8Ω Mono speaker
- Li-Polymer 3.7V/4000mAh Battery
- USB-A 2.0 Host Connector
- x16 GPIO Input Buttons
- 2x ADC Analog Joysticks
- USB-C Port for USB2 Device and Charging

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 9fda2436c618..e16b5fa55847 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -163,6 +163,7 @@ properties:
               - azw,gsking-x
               - azw,gtking
               - azw,gtking-pro
+              - hardkernel,odroid-go-ultra
               - hardkernel,odroid-n2
               - hardkernel,odroid-n2-plus
               - khadas,vim3

-- 
b4 0.10.1
