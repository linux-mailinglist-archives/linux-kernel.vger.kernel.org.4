Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CB8744289
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 20:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjF3StR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjF3Ss5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 14:48:57 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B56423F;
        Fri, 30 Jun 2023 11:48:46 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-345e55a62d8so5444235ab.3;
        Fri, 30 Jun 2023 11:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688150925; x=1690742925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tT/O+U0RmxR2jpWjaZx0ivpKPFNChJ8QTbrsz4zzr2o=;
        b=DzRnMbF9p4e/P8q/OxkONEyAHuHFxgzTrjmMVj9oDNcGwx+fK/Qh9g5K7KhJPwMAiH
         +416KZ24mO3o9j2k82CE4ZYXU3/cFQ6qblaaoetL86hBZmBbhbsAZ4FjGKm4n9ayOmDD
         M/OGeROdDcp+IYRZ8ApuaPRD4N37LCOyaseOhyYlaWpOzYqNiMttre2jKNwKoM7vLBwj
         LpORVo01Y/A8DRWTqgWxtUgoNmC3Ml4mXxRFknXoizq+DD5BK/X70KF/PeVZGqcuYQlF
         D6OHXS6w0iFsRw2Er3ydFbzZSVqDSVTn9zabQhWmczt+Fejm5ahiRq1X62PY3VMAWTdy
         gokg==
X-Gm-Message-State: ABy/qLZk0h0ttE47wj/CFnrbGNhFJQtiAraB27JpSwpYRVIU37H3FZ9O
        h5Oskl8lzdooNPpRjBrMRA==
X-Google-Smtp-Source: APBJJlEsaVcNQQEabIiUYoxHPkAdUfY2kc0MbUJ8HEBxSFsA27fEXvavVTlAWeDcC8PLHTIZ2mHyog==
X-Received: by 2002:a92:d386:0:b0:345:a6c5:1ce8 with SMTP id o6-20020a92d386000000b00345a6c51ce8mr3048485ilo.14.1688150925318;
        Fri, 30 Jun 2023 11:48:45 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c18-20020a92cf12000000b00341f8926cecsm4935638ilo.73.2023.06.30.11.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 11:48:44 -0700 (PDT)
Received: (nullmailer pid 2165422 invoked by uid 1000);
        Fri, 30 Jun 2023 18:48:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: cpus: Add Cortex-A520 and Cortex-A720
Date:   Fri, 30 Jun 2023 12:48:08 -0600
Message-Id: <20230630184807.2164597-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the Arm Cortex-A520 and Cortex-A720 CPUs.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 9e6a45eea4e5..9a39dd26b6dc 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -143,8 +143,10 @@ properties:
       - arm,cortex-a78ae
       - arm,cortex-a78c
       - arm,cortex-a510
+      - arm,cortex-a520
       - arm,cortex-a710
       - arm,cortex-a715
+      - arm,cortex-a720
       - arm,cortex-m0
       - arm,cortex-m0+
       - arm,cortex-m1
-- 
2.40.1

