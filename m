Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476A67BFC2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbjAYWPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 17:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbjAYWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 17:14:58 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B265356C;
        Wed, 25 Jan 2023 14:14:49 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id n24-20020a0568301e9800b006865671a9d5so120656otr.6;
        Wed, 25 Jan 2023 14:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VntylNPkRn7HwDOyGLvqIMmZ4+nA7TLouy4C3scpsR4=;
        b=h+V7bftuqB2QH6zC9LY3BG+XKfF2PFH4QeqrqOXfZ0hFLvdLZe6/24A7KhUuUFT83q
         YdLblbs3QFag+5YpLSCWKLbwIenQC0uPNKV/6n7AnG4dUeF8LFYZ1/ncPuhM/kwb5MM9
         ACRt5nPmX9Zkb5BWFVTvHZCm6+54avEu1pykPXxNICupP/DW2+PH/kCM8FtfMzqxYIn/
         KSNZvQv6xiuaTKEFvlnyV+QX3wfJ/jfj1zE+OEyAJLCYTHoGNRuCnizSbMtcIEyywOhU
         wGdVR7v26Vg2kg3w12DXDPb63s6ukkKgAPtrlBG8V167ppdUnId7agdUEShUs3adIKmB
         JocQ==
X-Gm-Message-State: AO0yUKXHmoUyTJhGlcqhcf4DWpE8lz2kPPLyerAJbsWugoNsvTjSlm/J
        qEO3wGMk5bRgYT2RadIDlknlEi/JIg==
X-Google-Smtp-Source: AK7set92WE+b16Zc6lK++b0mfe9v5JKPbgYOLupTZTTfk+RBYuKrRvGSICJJo3MYY3Wn2iTJYHYGUQ==
X-Received: by 2002:a9d:70d6:0:b0:686:5b76:1610 with SMTP id w22-20020a9d70d6000000b006865b761610mr41333otj.1.1674684889198;
        Wed, 25 Jan 2023 14:14:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p7-20020a9d6947000000b0066e873e4c2csm2746090oto.45.2023.01.25.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 14:14:48 -0800 (PST)
Received: (nullmailer pid 3058728 invoked by uid 1000);
        Wed, 25 Jan 2023 22:14:48 -0000
From:   Rob Herring <robh@kernel.org>
To:     Yu Chen <chenyu56@huawei.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: hisilicon: Fix 'hisilicon,eye-diagram-param' differing types
Date:   Wed, 25 Jan 2023 16:14:43 -0600
Message-Id: <20230125221444.3058631-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'hisilicon,eye-diagram-param' is also defined in
hisilicon,phy-hi3670-pcie.yaml as a 'uint32-array'. Unify it to use
'uint32-array' everywhere.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml         | 3 ++-
 .../devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
index 20b79e2e8b82..b11d9873854a 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml
@@ -27,7 +27,8 @@ properties:
     description: phandle of syscon used to control usb tcxo.
 
   hisilicon,eye-diagram-param:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
     description: Eye diagram for phy.
 
 required:
diff --git a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
index 1cb00dbcd4c5..3c69aca6c7eb 100644
--- a/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
+++ b/Documentation/devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml
@@ -32,7 +32,8 @@ properties:
     description: phandle of syscon used to control phy deep sleep.
 
   hisilicon,eye-diagram-param:
-    $ref: /schemas/types.yaml#/definitions/uint32
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
     description: Eye diagram for phy.
 
   hisilicon,tx-vboost-lvl:
-- 
2.39.0

