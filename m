Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C3678EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 04:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjAXDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 22:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjAXDF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 22:05:27 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5493C2CFC9;
        Mon, 23 Jan 2023 19:05:26 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id i5so12171296oih.11;
        Mon, 23 Jan 2023 19:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t21dCSgXMADUq1pWfl156WNqD9atSWj6SahX+ddDCFs=;
        b=lUGjFf3oEyxPGdUPeZoUQluGQ+cqEF9h1WR63aJmfBraJOCMMY9cYX7l18fuGH4Irb
         VFJtwShlKz4tr5lbVN77FTRGpBr3t+K148N6huJnqs0ClLxby0/kuVPPAJMoDFAzOeYU
         +w+DNCqqatx2ryMvqGq3EpY8oYi5uQ6Y9vQUPFjF1RhAADcQZzfQNTYgh3bM5Dyfiv1F
         SfKOhwTVgPdUrrrn0m/NMdljFylhQISw9gvQ+D96Dr93lnz9ZbvO0GEJxIzYs8VyrmIw
         U6JrpGI0fiv0mrJhpPhBvnAhKYo44eSTCbqi/Dv6rEX9n0wgz/KaoV8YLXquiqYbVnaM
         2/rg==
X-Gm-Message-State: AFqh2krzx5LCsxiXBCa2Dvv1ipoG6fwn4fxGQu7l/LeQDHERLllPi/95
        IIqgPE7PISB75RaRZ1hpbg==
X-Google-Smtp-Source: AMrXdXsQxU+g4VkhTO6PSGz2Uzgx2PhXFUQ4vF3YFaAwscF0LSrRJQAelA7PCrv0Epi3/ObSdAJ3mA==
X-Received: by 2002:a05:6808:2a8c:b0:36a:8422:d962 with SMTP id fc12-20020a0568082a8c00b0036a8422d962mr10569363oib.2.1674529525545;
        Mon, 23 Jan 2023 19:05:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s26-20020a056808009a00b003645ec41412sm492545oic.27.2023.01.23.19.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 19:05:24 -0800 (PST)
Received: (nullmailer pid 3266348 invoked by uid 1000);
        Tue, 24 Jan 2023 03:05:20 -0000
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 23 Jan 2023 21:05:19 -0600
Subject: [PATCH v3 5/5] dt-bindings: usb: Convert Nuvoton EHCI to DT schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-dt-usb-v3-5-5af0541fcf8c@kernel.org>
References: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
In-Reply-To: <20230110-dt-usb-v3-0-5af0541fcf8c@kernel.org>
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
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

