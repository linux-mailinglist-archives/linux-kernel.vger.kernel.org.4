Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9077120E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjEZH12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236862AbjEZH10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:27:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F91A7
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:27:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-30aa1eb95a0so326770f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685086038; x=1687678038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDBB5eovZhlXrO3g9LqieVp5YonZKlA4uqXGyTCZauw=;
        b=s6NXn1a9+f1yxRDLZnaZR1IlK/wd01PSrJlX5zKR38PS8N0L9yVuE/nXahJqTpU6nW
         3MfxHXTRXKu3h1hU5MEEcXkG2+WuTXmUOzg/Kcfq9O7j6iBdbSUGQGDfswvhooSYZso+
         z9KdZNa5bre5xMS1f+rwJEhHmK9gPCGRtKWs+XHopFzCxtHuPKb173CD5xANhudaOqGg
         AuRy9PysDziq/YBnEzbY3p7wnPJhT7XEttDv9OgkzRAgbpnSHavpc4R//E95Sx2SjpVk
         7L/gvW1ksCh8v9t2O8NjRe4djsksy4eIuGzwpqVCfu33MDJYD5AUO6sNq6I/boyZ2aYF
         0h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685086038; x=1687678038;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HDBB5eovZhlXrO3g9LqieVp5YonZKlA4uqXGyTCZauw=;
        b=Aoje9fxDti4zyzNMFJS20nb2ZlhW5j1OTWsQZ7XniJWJMQ0YK4kiGEAYVucvyy81et
         SWKaRhi4t3Dn+qqmSrqzBOXqHJ9GMfs56oxMmdWtSgYe/pLro4zHmiznlmg/AYKcyUHd
         q+wv7ZrEEw9NT3h4UnGbtwVAYYC+rOIF8q4YE081IlEy6TSKenWELdTZ5UVVRW0CKCGn
         cgc3Jx9fJF0jIoxyXRcoCXvX6JAcj0XfIXuskVIpq9YT2vGvJamlEaGY+tyNLC800OO0
         1S0AELnqCkZz10jQdKhwfUXYZ/h3LL47vCq+eRc3B3G+fHfeTjw9vLt+AbZ6Cbt0cxu1
         Y6hg==
X-Gm-Message-State: AC+VfDydGl1NtCUK6AnskXhtppbvT7v1vVAUhDVu1mESIu33MQdQddAu
        5nC0Or7PtdcPPJ5oAsMnLa3Gcw==
X-Google-Smtp-Source: ACHHUZ5P9CXsJJ60w1KQqJgy7f1CIIOVw3ItSGBLqDHqhJ7IlZSnsbm8DHUs2HIcAP0igdCbVAPdGQ==
X-Received: by 2002:adf:e941:0:b0:309:44ed:ccff with SMTP id m1-20020adfe941000000b0030944edccffmr678149wrn.1.1685086038397;
        Fri, 26 May 2023 00:27:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d54c4000000b002c70ce264bfsm4119604wrv.76.2023.05.26.00.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 00:27:18 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 26 May 2023 09:27:16 +0200
Subject: [PATCH] Revert "dt-bindings: bridge: samsung-dsim: Make some flags
 optional"
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-revert-bad-binding-v1-1-67329ad1bd80@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFNfcGQC/x2NQQqDQAxFryJZN6BjVexVSheZmagBiSWjpSDev
 aHL9/iPf0JhEy7wqE4w/kiRTR2aWwVpIZ0ZJTtDqENbd6FHH7HtGCljFM2iM07DQG2isb83I3g
 YqTBGI02Lp3qsq8u38STf/9PzdV0/1P20cHkAAAA=
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1881;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1qywf6uKYxPPVGd+4S1H+CwZp4Z/nUxjv97YfdQmNPo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkcF9V9rgQyPLabyak6KxRL0N36QLgt3oUO6eirYJj
 w8i13PeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHBfVQAKCRB33NvayMhJ0R14D/
 91Z/BQ19siSPfErk/MdDGU0O3VokdOdXV7s5NPCVig89zIBcuVB1wIjA7FXca5tKORvNdJLC2kMBDt
 VNWmuA+OZUiHcbP6BcVzDtYPzzDni1V/2lYFudG7Y6kbR+Dk6lE9kFL2s6G4MZ5IoysrgAW/sdwd18
 GEaQJmFYTPYOLtnueL1K5HGn8IdleSOGnbt205nfjNBqVj75uXOj80TuteuRqwSOkp/ak+k+/N0CD2
 CN8VFySoIYCsoevUEWAM+SBsP9FAAiNEsZAk6Q2NnT2irPWqcx1PsE44Eb0qzB88/s7vLeF6H0W2zy
 BOIln/AXDCFKAZED/Y+QHmBCn4QCpmWPH7tvTDoUEIc/AB4Zs3nSujj9DGoapi6tyHg/tsIh6F6W7l
 35fpXYrXC5KLiKG2pqTMKs093OYhV3FePLnzkT0qLR4b7ee2A7cItZs94d1wy8w42yddgXr62/iook
 XnM4ohxOoOaoGsFHdV4BNaN2a57chF/+Z81mqfwEvRKQ3nxhTAYOFIvKkjpBr+jQEvwm7mlfsOT5Yi
 S0W+v/vjeKLkNal+IsECxCRHYDS5SOxzMgor//H4fNEnx1pgTE2Kd8YNow5cr0FQ45x7CTxdKlstep
 d9S662YGufYcUTcnnBFt3FBJCrznnK1JsDbbk/7cFtP/muShVlUTwFm2xk7Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cfaf76d349837f695c8aa6d7077847fec4231fe5 which was applied
without review due to a bad tool manipulation.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml    | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
index 360fea81f4b6..9f61ebdfefa8 100644
--- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.yaml
@@ -70,9 +70,7 @@ properties:
   samsung,burst-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM high speed burst mode frequency when connected to devices
-      that support burst mode. If absent, the driver will use the pixel
-      clock from the attached device or bridge.
+      DSIM high speed burst mode frequency.
 
   samsung,esc-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -82,8 +80,7 @@ properties:
   samsung,pll-clock-frequency:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-      DSIM oscillator clock frequency. If absent, the driver will
-      use the clock frequency of sclk_mipi.
+      DSIM oscillator clock frequency.
 
   phys:
     maxItems: 1
@@ -137,7 +134,9 @@ required:
   - compatible
   - interrupts
   - reg
+  - samsung,burst-clock-frequency
   - samsung,esc-clock-frequency
+  - samsung,pll-clock-frequency
 
 allOf:
   - $ref: ../dsi-controller.yaml#

---
base-commit: cfaf76d349837f695c8aa6d7077847fec4231fe5
change-id: 20230526-revert-bad-binding-f77a3ca96419

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

