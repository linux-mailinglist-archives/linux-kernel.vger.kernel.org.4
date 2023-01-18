Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6C6727A0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjARTAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjARS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 13:59:38 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212E853E5C;
        Wed, 18 Jan 2023 10:59:33 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-15ebfdf69adso44974fac.0;
        Wed, 18 Jan 2023 10:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t21dCSgXMADUq1pWfl156WNqD9atSWj6SahX+ddDCFs=;
        b=PWJv9FVBhirkqEqeeFHznZmcwj8JOIo7Lo9cdFmgHARnJ+JcLqLl79u3TwVpTVn5Xe
         YFEFHYF4NlsCGpuAgoWDy+MPWvIcefPXyBVmsbyTc9D6FDTG5YJ/RYGSFzeKfEv6t2hi
         sef7Tk+/djUBZvEXs4ST9Ueq/OMR9MqITm+LVw+KvSfJerrYBRgqDmjlYIq0AJHkF6QI
         PxAX/lqxq+PVTCCMRqiuWpmKXA4CsojNdU4VtE/DI8/X0tI+DMwyLJ3zU967OWcJtDJm
         AKtS4hgB00T9w/ujoDC6yBG9v9ibJIcz7H8Butb5//VP5TfvRxlWqhDo0R/7KqTRXQ7a
         svDQ==
X-Gm-Message-State: AFqh2kpbQivmi2mIVZWbCsyLfQXzhy+FJI2i8d2hf2eDN6zESa7VlqjD
        b1fnUlb3r+moQPS3IlFpeQ==
X-Google-Smtp-Source: AMrXdXu1m2DIrv1ryGF/RTJllp6w43tl35oqGQcA5exBroeqivdYJaPoylgEUL5k6Lc/e6NTdaZI0g==
X-Received: by 2002:a05:6871:4207:b0:144:a774:15bf with SMTP id li7-20020a056871420700b00144a77415bfmr4223145oab.48.1674068372392;
        Wed, 18 Jan 2023 10:59:32 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id eq2-20020a056870a90200b0014fb4bdc746sm18661681oab.8.2023.01.18.10.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:59:31 -0800 (PST)
Received: (nullmailer pid 629754 invoked by uid 1000);
        Wed, 18 Jan 2023 18:59:29 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 18 Jan 2023 12:59:27 -0600
Subject: [PATCH v2 5/5] dt-bindings: usb: Convert Nuvoton EHCI to DT schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v2-5-926bc1260e51@kernel.org>
References: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
In-Reply-To: <20230110-dt-usb-v2-0-926bc1260e51@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Lee Jones <lee@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openbmc@lists.ozlabs.org
X-Mailer: b4 0.12-dev
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Nuvoton EHCI binding is just some compatible strings, so add it to the
generic-ehci.yaml schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/usb/generic-ehci.yaml        |  2 ++
 .../devicetree/bindings/usb/npcm7xx-usb.txt          | 20 --------------------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index ebbb01b39a92..050cfd5acdaa 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -76,6 +76,8 @@ properties:
           - generic-ehci
           - marvell,armada-3700-ehci
           - marvell,orion-ehci
+          - nuvoton,npcm750-ehci
+          - nuvoton,npcm845-ehci
           - ti,ehci-omap
           - usb-ehci
 
diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
deleted file mode 100644
index 352a0a1e2f76..000000000000
--- a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-Nuvoton NPCM7XX SoC USB controllers:
------------------------------
-
-EHCI:
------
-
-Required properties:
-- compatible: should be one of
-    "nuvoton,npcm750-ehci"
-    "nuvoton,npcm845-ehci"
-- interrupts: Should contain the EHCI interrupt
-- reg:        Physical address and length of the register set for the device
-
-Example:
-
-	ehci1: usb@f0806000 {
-		compatible = "nuvoton,npcm750-ehci";
-		reg = <0xf0806000 0x1000>;
-		interrupts = <0 61 4>;
-	};

-- 
2.39.0

