Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9018F5B3CCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIIQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIIQQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:16:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62425FD;
        Fri,  9 Sep 2022 09:16:22 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:d3c:a31c:505b:8c33])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 68C2C6601FCC;
        Fri,  9 Sep 2022 17:16:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.co.uk;
        s=mail; t=1662740180;
        bh=Hm55QYd3o7JpTilmkeW0jrl7fsyX4VP54gZONEhFths=;
        h=From:To:Cc:Subject:Date:From;
        b=JPvSowkJNxrebAegvT18huox0SvsWkilvP5PF2H0q8vLL4PXfyXzyx9gZshlKGrKY
         A0aZXA+Q+8HJMhHQOEYuWdvos1gBhF5M49I2yLmUxNPYPmgmFgJxMLP7pkE5p8aaZA
         V7Fe6JP3fWe211M/sRqH0pUlW15qmRrJGztDtUb9vwvUAxwif+dw+wj+/TRULVq6fJ
         buzhdy4ueiESDwcg0j5ag0ur/hFG+siAwqcCeMGX3HXfP2Pc99vYaLKFRQXB7Cuj6b
         gLHW6JKqDjz5FzE4YW4beErxiEhdbKFigK0HzqyxS/0jfecBIKLsLBR7RVAu+HRbIX
         lsKA3d1sMsqpQ==
From:   Martyn Welch <martyn.welch@collabora.co.uk>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.co.uk>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: iio: st,st-sensors add LPS22DF.
Date:   Fri,  9 Sep 2022 17:16:09 +0100
Message-Id: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ST LPS22DF, an I2C/SPI pressure sensor.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index fcb2902683c7..250439b13152 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -73,6 +73,7 @@ properties:
       - description: STMicroelectronics Pressure Sensors
         enum:
           - st,lps001wp-press
+          - st,lps22df
           - st,lps22hb-press
           - st,lps22hh
           - st,lps25h-press
@@ -141,6 +142,7 @@ allOf:
             - st,lis2mdl
             - st,lis3l02dq
             - st,lis3lv02dl-accel
+            - st,lps22df
             - st,lps22hb-press
             - st,lps22hh
             - st,lps25h-press
-- 
2.35.1

