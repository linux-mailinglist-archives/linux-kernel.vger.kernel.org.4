Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E206474F3BC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGKPhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbjGKPhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:37:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4C31BE1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3159d5e409dso1422599f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689089805; x=1691681805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z5zfDlJgblDPbH90jQkXFb124rj0cRvmHZvcD3c8U8=;
        b=Bf3HZ76PFgfk9RlSgcgP0opND/p+2ccJZ3qojqsfaH2pPZtwAfTO220Nvj9NltJ4y5
         OfiMPDE4fyb+MUdbJG4bKJLBLAHRybOSFgBxbR0nFFkdf6+e8q8blPW5xTeMbtDLvxHV
         CWxAIoY39ESXd1up+JFv5Ve7aDax8rtrxkQqEIRj1xzLdWdD9Ow3241EkvpFm4IR0Iqm
         UGBEI08vMzKDuoybIn4hV5TCJ1tNdD462Ab1kJ9sXmxtBdWDZ+I45Kj1g3eGvnDsySC4
         MHkD/2TAGu9Fd/65O2uLSV97rtfkjeftOk66frBFAAhUKFZQIey0iY5qBUknwt64Jeb8
         rcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689089805; x=1691681805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0z5zfDlJgblDPbH90jQkXFb124rj0cRvmHZvcD3c8U8=;
        b=Sym+dDY8laSho3vd+PT0a6hp1Erfan5NQv9jN695xrb/zFeA+p6y1MXTra5Z5YU5vS
         Ns0X852jB/95iPOePXgQofN/bfetJz1rZxpFnyvAuLr5ssSoVAzX3GYiWTCjwMfp2o+F
         pf3ESEOvWPadv73xbb+d+f6Q+fXylqmPNSKCgZylyG6W6/E+dLaXXP9SvbCM87ojld29
         sT6tE7MfNjqf3QhC3IWc4NaritKAXSfJPBg2wI3vSCeakrwebvc+/8W8p47eOmr5BBlr
         7QHJGi+2BKrC5MCUpx/koFpjrIkKooJWMGd84XyMWsb81BdXHX18C5h8vNru/ThPywOq
         xyeA==
X-Gm-Message-State: ABy/qLa3HNw0UmN3T/Z1mzbya4W6/yiItDWVuERns8st9WPcs+2APBDq
        01tKVALNUrdkVzJ54a73P8sZfg==
X-Google-Smtp-Source: APBJJlGXl4MDx60dGT+c7tQy3WNO23yUwT+V+1UoCMmX8/AIFycfsqE/pMSrZFmBZr2BvXHFVU7YYA==
X-Received: by 2002:adf:e4cb:0:b0:313:e88d:e6d3 with SMTP id v11-20020adfe4cb000000b00313e88de6d3mr18617688wrm.14.1689089805644;
        Tue, 11 Jul 2023 08:36:45 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v6-20020a05600c444600b003fbb1ce274fsm23458249wmn.0.2023.07.11.08.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:36:44 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 11 Jul 2023 17:36:27 +0200
Subject: [PATCH 1/3] dt-bindings: display: panel: add startek kd070fhfid015
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-startek_display-v1-1-163917bed385@baylibre.com>
References: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
In-Reply-To: <20230711-startek_display-v1-0-163917bed385@baylibre.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=Ujtb05N2fW+fMaNciuy01iapDl7k/u72Jx17MuBLiFk=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkrXcKfA2fh53Jo+c93oTbDBoSEtklb31hP5a4QQZQ
 L36xEaKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZK13CgAKCRArRkmdfjHURUo9D/
 44vQp6rRjJZELHD744OsROc4RSPqUfaqI7iGNPo2K5nE8hUTjDyTGZs/uOx+7xgFPhkim27iR8OmR6
 yGk7L012x/+lhRx1MdcBZtUW9IKgrrU60Z1Ljr6RIL8oKTHf1RhGhGBPZQO5SCVtzvTPfKDPHiFe4A
 yvHq+Mk5isCsQ3c3zx5uX2jfJ4r5T8T3RInVeUxpgt1s8BmlcYpmSIHIGeJ0RnZ5GOZtIkzXf45YoT
 Ay491CMz6+AZ1RuTqffJnVD8xSiYdiqRSAzmjeyLjpoON2V3f2ezA5BxvpGFpRRAawWVhOd6Xds3W8
 pv4rgCSuglELxhOTQ+z0Y0y08JhMRdOKETM5AaW6EeXodRIO1lWfLUkZzODdGC3WhxHHXboZ0StrHP
 VvwvpTvs4pgDL1zC/sM2u1llI2V2T30K0LLWIB1Ist7PzFoHxZDBgIZxPkC652flJU0HXFkB32dIWp
 +E7jZJhUyDHceICDDaYax6qsk3NraU+oGelTsIISp7+q4svhUdkdU8DZHpYopq9nTExJSYXAp+aPTU
 /h2U5XgSidiakTcnY4jbn7ge0vcvbgvv+MJ6qL1D/bIgHj1G1JtelVZhUZGWXXh7nv8KlsyBLi+Ysn
 5J/bY38Y/hJU1/gQASy1PpfbaSgLJaI1hrY2vULFjq/beLur+J1mNWg/i2yg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Startek KD070FHFID015 is a 7-inch TFT LCD display with a resolution
of 1024 x 600 pixels.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../display/panel/startek,kd070fhfid015.yaml       | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
new file mode 100644
index 000000000000..857658e002fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/startek,kd070fhfid015.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/startek,kd070fhfid015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Startek Electronic Technology Co. kd070fhfid015 7 inch TFT LCD panel
+
+maintainers:
+  - Alexandre Mergnat <amergnat@baylibre.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: startek,kd070fhfid015
+
+  dcdc-gpios: true
+
+  height-mm:
+    const: 151
+
+  iovcc-supply:
+    description: Reference to the regulator powering the panel IO pins.
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  reset-gpios: true
+
+  port: true
+
+  power-supply: true
+
+  width-mm:
+    const: 95
+
+additionalProperties: false
+
+required:
+  - compatible
+  - dcdc-gpios
+  - iovcc-supply
+  - reg
+  - reset-gpios
+  - port
+  - power-supply
+
+...

-- 
2.25.1

