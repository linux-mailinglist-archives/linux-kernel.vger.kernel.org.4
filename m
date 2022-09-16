Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB305BAE2B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 15:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIPNaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 09:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiIPNas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 09:30:48 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AB72FC1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:30:47 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t14so36065335wrx.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=6x3Tj7tEWzF/PXB7GiOSZ3dAZDugeuF///iJalkLWP0=;
        b=b+/A0ne7xCPUFUEcIOb1qqYJd5dEbE0v/cz5WgUMA6KxktE1V0BwE70WWjuJjs+mJp
         U+UYln+XpTrvZN0eoj1oc7bBLD9oRO3t04C8gbH5b1J/0gKiI0AdPoHsGoJNZisBbN5E
         q1QBBZF9Bp/8PsR1dH4UwtR9Qv3VbMq8HAlP1+HC4AVsgQvlgcJ8m7ri0R0yAobu6ePR
         tswWNfE8nFcPhmZX64dh15uH/5SOsNlSzanBkQmwN3ns3zMWaMETMbxBIcgMgQI0ShYz
         GW/slyafSXX08b+cVKHLOqrHf+jkZ3wHhuRhv5douRIs9JEoCo/EBISOy3MJyaN+ZH9Y
         D4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=6x3Tj7tEWzF/PXB7GiOSZ3dAZDugeuF///iJalkLWP0=;
        b=VSne14a9VK4lla5Y+PjRTLt9bfbdityHPuX1v8mWF9wA4LqHpsU3Dj+N4o3h5fJ8Jt
         PlwhyYPlME++iYRPr9O4340C9hdmWv28Siqa7gNwIzHYW7NvsvCMvqUrAkdzwdT5GxWd
         KLRy4eDcpbBPXplw277Fc23f06+/ZLACDbKM+WytNp+6FX5/aYyk33fnOjVmCyhLrbCv
         AH+/NAiq1rvf38KawKlP7AI9VwjU/KMdPMXyy9KRc8yiEKuifjdEnwlr5GVvLkTq0yNk
         3gZqlO8BX51VsQirQbz5eVRqULm0RbnYWJj1rH/Cj0j8HDVgY+KaqYGoj5q5LLi18t8v
         W0ng==
X-Gm-Message-State: ACrzQf1HwjYkYObJVurg1s5GAxqS9jmV/gHVOztg4QtgH2Guo1ij+aLR
        hma8ueBo6JF1sagXBgEgiRLn5w==
X-Google-Smtp-Source: AMsMyM41h9RQuxsubvEd0b0gS3dZ5OGByovX4AVlxZ5K45YtQnYwYnOM7DlxiXxmAmB6ii/mwrLc5A==
X-Received: by 2002:a5d:4dcd:0:b0:228:d1e4:9cf1 with SMTP id f13-20020a5d4dcd000000b00228d1e49cf1mr2774634wru.182.1663335045759;
        Fri, 16 Sep 2022 06:30:45 -0700 (PDT)
Received: from localhost.localdomain (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id k21-20020adfb355000000b0022584c82c80sm4934404wrd.19.2022.09.16.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:30:45 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     maz@kernel.org, mark.rutland@arm.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH] dt-bindings: timer: Add QEMU compatible strings
Date:   Fri, 16 Sep 2022 14:30:00 +0100
Message-Id: <20220916132959.1910374-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QEMU uses both "arm,armv8-timer" and "arm,armv7-timer" as compatible
string. Although it is unlikely that any guest relies on this, we can't
be certain of that. Therefore, add these to the schema. Clean up the
compatible list a little while at it.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../devicetree/bindings/timer/arm,arch_timer.yaml   | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
index df8ce87fd54b..fa03fc0fe320 100644
--- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
+++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
@@ -22,16 +22,17 @@ properties:
   compatible:
     oneOf:
       - items:
-          - enum:
-              - arm,cortex-a15-timer
-          - enum:
-              - arm,armv7-timer
+          - const: arm,cortex-a15-timer
+          - const: arm,armv7-timer
       - items:
           - enum:
               - arm,armv7-timer
-      - items:
-          - enum:
               - arm,armv8-timer
+      - description: QEMU uses both compatible strings.
+          This format is deprecated.
+        items:
+          - const: arm,armv8-timer
+          - const: arm,armv7-timer
 
   interrupts:
     minItems: 1
-- 
2.37.3

