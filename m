Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D465C6476AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiLHTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiLHTkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:40:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF581AA23
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:40:04 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id i83so860005ioa.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6knfdCbn21BCTb9mG6T6YdbL/IZU8aMeiwcDOSNAJo4=;
        b=gnTxgQ2YNwFnoPYgG4cIMS+LZ97bY5Yp0AHyoiPlrUT7G4ndzlsjZQoB2Gfq67kx88
         YiWicu4p4r1Zdr+9vpbO+5nEJZTqDOqwgKsxzmVAK537CbhlTySJfvrgonsJVt26ojyT
         pbJpSWBBpnn09OI6AweyatYOvcVUfVsBAhQaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6knfdCbn21BCTb9mG6T6YdbL/IZU8aMeiwcDOSNAJo4=;
        b=h7kBJ66w5ZGWVEQ7wsEbUQglj8KT005KhJad0l+WKZrUlSspDCX3IRDwgTdwngJqs0
         LgOIId4B4Gg41RRDRy43jocEfIOfD2NEwE465OjPNuYwnL9DlVu2dmhJzrE0PRuPpWU1
         T9ckeWsF/oUD3/IK3vIepd7SAKK9PVWJ5E2izMTGTomMTmkaC0F1R5uQz7AojtheUvZi
         swV55qdZi8mPFnzIybogCbG/bODatGBY0PYY2SvnVtznkyUaILRkovHPUwY0dfv5G/NB
         6ieDpUectokhWMJWaQab/juJBJvP/q6Lv+FoO9J6E17hQXQ1BPkroQYquubx5x4pCl3m
         4vKw==
X-Gm-Message-State: ANoB5pntU3lW4emhCvl5isHuVIOZc06vKQOka4S9M63SHWjO8HSxqYnJ
        YE9tNryMiosIxqbBR43R53l+JW4XMs1TtNC6
X-Google-Smtp-Source: AA0mqf6htiQQBANxQtC64ij512XLq0BetgIsGBfEonOfV8+AaIxjPeGn0rvLwyBUCwAQtpNC3yxztA==
X-Received: by 2002:a05:6602:381b:b0:6bc:d715:b8f8 with SMTP id bb27-20020a056602381b00b006bcd715b8f8mr2455896iob.7.1670528398762;
        Thu, 08 Dec 2022 11:39:58 -0800 (PST)
Received: from markhas1.roam.corp.google.com (63-225-246-100.hlrn.qwest.net. [63.225.246.100])
        by smtp.gmail.com with ESMTPSA id b5-20020a05660214c500b006df13af1f16sm9245441iow.50.2022.12.08.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:39:58 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
Subject: [PATCH v11 2/3] dt-bindings: mfd: cros-ec: Add UART compatible string
Date:   Thu,  8 Dec 2022 12:39:51 -0700
Message-Id: <20221208123944.v11.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221208123944.v11.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
References: <20221208123944.v11.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

Add a compatible string to support the UART implementation of the cros
ec interface. The driver does not support the reg and interrupt
properties, so exempt them from being required for UART compatible nodes.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Changes in v11:
- Update commit message to include device

Changes in v10:
- No change

Changes in v9:
- Rebase onto for-next
- Update node-name from uart0 to serial
- Remove reg and interrupt property requirement for UART compatible
  nodes.
- Update authorship

Changes in v8:
- Update commit message

Changes in v7:
- No change

Changes in v6:
- No change

Changes in v5:
- No change

Changes in v4:
- Changes in commit message.

Changes in v3:
- Rebased changes on google,cros-ec.yaml

Changes in v2:
- No change

---
 .../bindings/mfd/google,cros-ec.yaml          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index 3d5efa5578d1b..cdf1d719efe9d 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -33,6 +33,9 @@ properties:
       - description:
           For implementations of the EC connected through RPMSG.
         const: google,cros-ec-rpmsg
+      - description:
+          For implementations of the EC connected through UART.
+        const: google,cros-ec-uart
 
   controller-data: true
 
@@ -187,6 +190,15 @@ allOf:
       properties:
         mediatek,rpmsg-name: false
 
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - google,cros-ec-rpmsg
+                - google,cros-ec-uart
+    then:
       required:
         - reg
         - interrupts
@@ -299,4 +311,12 @@ examples:
         vdd-supply = <&pp3300_fp_mcu>;
       };
     };
+
+  # Example for UART
+  - |
+    serial {
+        cros-ec {
+            compatible = "google,cros-ec-uart";
+        };
+    };
 ...
-- 
2.39.0.rc1.256.g54fd8350bd-goog

