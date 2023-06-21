Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BDC7392DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjFUXKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFUXKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:10:12 -0400
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66E51997;
        Wed, 21 Jun 2023 16:10:07 -0700 (PDT)
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-77e3f25446bso1371039f.1;
        Wed, 21 Jun 2023 16:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687389007; x=1689981007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uZ5k4Dp/46/3VEiWRW3fgGgoJsPLZRDZDhLXzW7k1Jo=;
        b=Nzy4h8ly5RoJoTJt1Vd3YBaQTNoM1if9vw64XdWxuE2O5PCIXA/QoRx+8FVrkfosvw
         qj2DH/w02t2kUQdO8y3n5TPp7PRmxlxKkhsTTV39xLOJ5rj15Dj9Ri3RtQkR9k7W1raN
         9nHoDkeNOCGPbNHeLGluDoDEl10AQ54pUkkh4jSGiZL+UQkalwYt11iDxF9qw5W+wl4T
         oBvGv67Mr/iwlQunovMEUzvqU0kIGSq35ZkXV1pGEzG1bZ05Ktmc9H7F2sIHvkXUfEjz
         akFQ59Fnb4FEOwkVAnUQBpjpFfyPeygUDS0QJmFgKyvpYxTL6TAgtxLgiGJcGIfpxTkW
         YL5Q==
X-Gm-Message-State: AC+VfDwzx8RODIjrei27ne9Jy6fEkvEvYGVB30UuRryiNZiNH42wRbyy
        vAv2xPWfLRjs4qYWTP15BA==
X-Google-Smtp-Source: ACHHUZ6xSF+H5lFNbNWgsiKD9LxRhFRCqXetCy8jY2budOoUKjxD1V+o68khuqMZ/FJzH7C+s93T7A==
X-Received: by 2002:a6b:d906:0:b0:777:a6a7:e83d with SMTP id r6-20020a6bd906000000b00777a6a7e83dmr11343275ioc.4.1687389006760;
        Wed, 21 Jun 2023 16:10:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t4-20020a6b0904000000b00760e7a343c1sm1697035ioi.30.2023.06.21.16.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 16:10:05 -0700 (PDT)
Received: (nullmailer pid 3815982 invoked by uid 1000);
        Wed, 21 Jun 2023 23:10:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: brcm,brcmstb-usb-phy: Fix error in "compatible" conditional schema
Date:   Wed, 21 Jun 2023 17:09:58 -0600
Message-Id: <20230621230958.3815818-1-robh@kernel.org>
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

The conditional if/then schema has an error as the "enum" values have
"const" in them. Drop the "const".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml         | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
index 43a4b880534c..580fbe37b37f 100644
--- a/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml
@@ -115,8 +115,8 @@ allOf:
         compatible:
           contains:
             enum:
-              - const: brcm,bcm4908-usb-phy
-              - const: brcm,brcmstb-usb-phy
+              - brcm,bcm4908-usb-phy
+              - brcm,brcmstb-usb-phy
     then:
       properties:
         reg:
-- 
2.40.1

