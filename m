Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F37619D1E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKDQYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiKDQYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:24:47 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEB1FDA;
        Fri,  4 Nov 2022 09:24:47 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso6023762fac.13;
        Fri, 04 Nov 2022 09:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=236MtMSiYq8PfbAvUMwAbvkjZMfzu/0gyBql4UnRQZQ=;
        b=Oq3H3AD2YLaTv3ZfGRNlOnU3Egp+qAU6PXayLEwKwDeTqGq+masS8fbvcDlg8AVMW6
         bqrs4Xa/DW63ubTzt/gaw0Z2XAx+pskHWswL9iKflQSjZ+kFuoBbV2LdWv8X8OpBcft/
         fznr1V+zKYIOJ6+PA2YiMpfL/tNLvR/WUegwp4Fpxn5Ul741WEgNLD3nmxePuFqvulNL
         c0H3dgtffA4EEFD5qdQWuCdb+52z4+hBynbk1TiKX9C+sUMee+BdZgJBcXi3Q/UAXq8k
         rTkkuhYjY7HQe0zfvIW3m0EPHPiObHg2KdQL7cXS/ysnUQXNnzcQwpENLdTueY0LRnmD
         ug3g==
X-Gm-Message-State: ACrzQf0qDoVJ1l56Fds59Are4iMAFBLoLCpRqC16Hcwm30Y1ocHy5IRd
        MG8dRyIgEDc02RiUS6zoi5p72u9D4A==
X-Google-Smtp-Source: AMsMyM63f5nI/3QWC4kluBY+6QxS5OfRPRvnf7sqUta3aTKn//+8mOCK+JCgL6rErbaXqdnVFReQ1Q==
X-Received: by 2002:a05:6870:3413:b0:13d:3e44:4a9e with SMTP id g19-20020a056870341300b0013d3e444a9emr12757042oah.228.1667579086482;
        Fri, 04 Nov 2022 09:24:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m35-20020a05687005a300b0011f400edb17sm1934261oap.4.2022.11.04.09.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:24:46 -0700 (PDT)
Received: (nullmailer pid 1982077 invoked by uid 1000);
        Fri, 04 Nov 2022 16:24:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: cpufreq: qcom: Add missing cache related properties
Date:   Fri,  4 Nov 2022 11:24:29 -0500
Message-Id: <20221104162429.1981729-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The examples' cache nodes are incomplete as 'cache-unified' and
'cache-level' are required cache properties.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 24fa3d87a40b..e58c55f78aaa 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -85,9 +85,13 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_0: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
           L3_0: l3-cache {
             compatible = "cache";
+            cache-unified;
+            cache-level = <3>;
           };
         };
       };
@@ -101,6 +105,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_100: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -114,6 +120,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_200: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -127,6 +135,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 0>;
         L2_300: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -140,6 +150,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_400: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -153,6 +165,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_500: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -166,6 +180,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_600: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
@@ -179,6 +195,8 @@ examples:
         qcom,freq-domain = <&cpufreq_hw 1>;
         L2_700: l2-cache {
           compatible = "cache";
+          cache-unified;
+          cache-level = <2>;
           next-level-cache = <&L3_0>;
         };
       };
-- 
2.35.1

