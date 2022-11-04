Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8715A619D21
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKDQZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiKDQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:24:59 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58329DFDD;
        Fri,  4 Nov 2022 09:24:58 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-13ae8117023so6043087fac.9;
        Fri, 04 Nov 2022 09:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mijph9nYOClLlhlDvaNVyj+gW4UdraQc7MUV78asgpQ=;
        b=4/WRVvAtxVmPw5KQItmQOAodaq8YXWoigrrWpQuYyaUqfp8FF10Oe14FlxgTU4iDgm
         87K3tBhztftuOFRU3SIbovHBvzcVwqlK/4pgrrZDwEDVHJVt8yuRFqtCcwpfx/Q+mgFM
         uR4nLp0DwKeGIHvAmel55Gtpjtm0vRJdM00Oc1bksMxB2q9F5gZBhuQLGb2ILUGelygJ
         gbu2F4zaSiXAMtr3Rl6/9suUMolehiQArc8lr/ega2nApqxupid/SDZHg1vfK5PO8Zl+
         KbpDGDNUkFvoh2gPszaryUozDt7eEpwl8BqaMJ9e8VozjEP6WV3TRc7/RGikqdUlg1o2
         Xyrw==
X-Gm-Message-State: ACrzQf3tbUzlubcV8g2ek+D0Lly9+SlAYBeWv7mW9Z0oytD5KEhX9COC
        VdLTgN7MqHszrAt18z39pA==
X-Google-Smtp-Source: AMsMyM512JGAoIyz1ru+NCHgeIQSfX6xmG7Swlnjoz3p+YpO+cLeKUEjuF8qoz08zOdzUlsH2BJ6oA==
X-Received: by 2002:a05:6870:42cd:b0:13c:d8a9:4fee with SMTP id z13-20020a05687042cd00b0013cd8a94feemr19332009oah.275.1667579097590;
        Fri, 04 Nov 2022 09:24:57 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a4ade46000000b0049e9aacbd3asm1294403oot.16.2022.11.04.09.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 09:24:57 -0700 (PDT)
Received: (nullmailer pid 1982298 invoked by uid 1000);
        Fri, 04 Nov 2022 16:24:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: cooling-devices: Add missing cache related properties
Date:   Fri,  4 Nov 2022 11:24:50 -0500
Message-Id: <20221104162450.1982114-1-robh@kernel.org>
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
 .../devicetree/bindings/thermal/thermal-cooling-devices.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
index 850a9841b110..7bb9327caa13 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
@@ -76,9 +76,13 @@ examples:
                     next-level-cache = <&L2_0>;
                     L2_0: l2-cache {
                             compatible = "cache";
+                            cache-unified;
+                            cache-level = <2>;
                             next-level-cache = <&L3_0>;
                             L3_0: l3-cache {
                                     compatible = "cache";
+                                    cache-unified;
+                                    cache-level = <3>;
                             };
                     };
           };
-- 
2.35.1

