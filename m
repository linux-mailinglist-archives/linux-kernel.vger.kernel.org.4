Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD5274B969
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjGGWQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGWQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:16:10 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C11BE1;
        Fri,  7 Jul 2023 15:16:08 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3461053677eso5565495ab.0;
        Fri, 07 Jul 2023 15:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768168; x=1691360168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKBw1VHW9bCdy/+mW5EjuBfcrbR3Fe4lXFIemQXKnPQ=;
        b=e/BQOfzayGzarbCGSc0r+CTLZveqA0vcgU7YopLZOzh35vxgLy3FvkKFFel+yhXAd8
         IO1jfIzmfMFsyqHs9/vyQ+9U3m3hqdGyd+Lvk1zdl7xU4dOPRG96OLuy5DDX1LJIt0EG
         vAV5lgS/Ap/FI9ZLFyOrAemGiqMMF1rWfuBy3sbuinm2htWYZH0+4W1rn8+ltDZCqaRW
         JxHHRxo/mO10NSUQCRdIU2hyPGi37LySZqhJeisUTJY5+cSDEJqA2niU21HOSt4P3rqt
         8SwHTQWII9oJj/052Rl75IF8n5qNc2DV9uBBmTUKdkoS9mUY0BZXXRxZnktoBLPSRNa+
         rAKQ==
X-Gm-Message-State: ABy/qLYqOTAyBmpD3yMwCtPJU4dxZR/cdqVHaYuO9gGcPUEQTTgeemjF
        0Ozhttsy7Qe5gZnf9tZxphFiblw19g==
X-Google-Smtp-Source: APBJJlEBJ8NigleNlLyhwiUZQhq1AptjKhnPtb9ArmdnA07oQII+e/ZxotrK9hotFfFYGrgc5ky3Vw==
X-Received: by 2002:a05:6e02:b4f:b0:342:2abd:f757 with SMTP id f15-20020a056e020b4f00b003422abdf757mr7160046ilu.16.1688768167796;
        Fri, 07 Jul 2023 15:16:07 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id el25-20020a0566384d9900b0042b37dda71asm1499090jab.136.2023.07.07.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:16:06 -0700 (PDT)
Received: (nullmailer pid 1064038 invoked by uid 1000);
        Fri, 07 Jul 2023 22:16:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Remove obsolete cavium-uart.txt
Date:   Fri,  7 Jul 2023 16:16:02 -0600
Message-Id: <20230707221602.1063972-1-robh@kernel.org>
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

cavium-uart.txt binding is already covered by 8250.yaml, so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/serial/cavium-uart.txt           | 19 -------------------
 1 file changed, 19 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/cavium-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/cavium-uart.txt b/Documentation/devicetree/bindings/serial/cavium-uart.txt
deleted file mode 100644
index 87a6c375cd44..000000000000
--- a/Documentation/devicetree/bindings/serial/cavium-uart.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-* Universal Asynchronous Receiver/Transmitter (UART)
-
-- compatible: "cavium,octeon-3860-uart"
-
-  Compatibility with all cn3XXX, cn5XXX and cn6XXX SOCs.
-
-- reg: The base address of the UART register bank.
-
-- interrupts: A single interrupt specifier.
-
-- current-speed: Optional, the current bit rate in bits per second.
-
-Example:
-	uart1: serial@1180000000c00 {
-		compatible = "cavium,octeon-3860-uart","ns16550";
-		reg = <0x11800 0x00000c00 0x0 0x400>;
-		current-speed = <115200>;
-		interrupts = <0 35>;
-	};
-- 
2.40.1

