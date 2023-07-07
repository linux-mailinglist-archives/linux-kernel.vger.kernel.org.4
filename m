Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDEA74B96C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 00:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbjGGWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjGGWQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 18:16:14 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DC2108;
        Fri,  7 Jul 2023 15:16:14 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7835971026fso86560939f.3;
        Fri, 07 Jul 2023 15:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688768173; x=1691360173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HlUhAky3I6lbcHfVaorBQpgHZHmOUsL/DPXCPOigXk=;
        b=SZNyGl+Kxb/szKU0H2bW6WYDb01ZT4gEJAq0REqh0VxfvRW5uWdtAI/wk/rk6Z/o9A
         gd1kOmhrumZytrCVoecWodGNsjlTWAQNDxPDJ8s6jfADEsAc+XywT1Jsx5DTkQNrIWq1
         lGxypNxLXVH6CoGm0zKIE3FQ1NIz9p5ykPDcUXMtiXOhnxZ96Pgk/D8ExYCvwSYDpLyL
         2u5arEHORBc1f5Vp/1VcacpsclsmY+tzz0ZU6NQubkDGumxb2FQ2zaZlt5Mc9ai9mehO
         RSzwxw7e0UPTLhjTBeD03RblhKzm8hRUuDCfc0JzkFbloiRBpKBY+rKfE4cOKwOR2QRk
         FxyQ==
X-Gm-Message-State: ABy/qLbPssXq2b1QpnsDCmJbomAa2B/yqRmawGzI7wNx7PFxjSR1XkMM
        tNwGv2y+/qC/Lr8hsljJzg==
X-Google-Smtp-Source: APBJJlGRkCnNP5i8lxAWu/yyaDXioxwmbsWTdbDQiguZS7lvcWh1pszYPCM9iUaitA9ZeMbvEU829Q==
X-Received: by 2002:a5d:9d57:0:b0:786:2672:5331 with SMTP id k23-20020a5d9d57000000b0078626725331mr6047342iok.2.1688768173228;
        Fri, 07 Jul 2023 15:16:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eq24-20020a0566384e3800b0042319c38763sm1596556jab.15.2023.07.07.15.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 15:16:12 -0700 (PDT)
Received: (nullmailer pid 1066786 invoked by uid 1000);
        Fri, 07 Jul 2023 22:16:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: Remove obsolete nxp,lpc1850-uart.txt
Date:   Fri,  7 Jul 2023 16:16:06 -0600
Message-Id: <20230707221607.1064888-1-robh@kernel.org>
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

nxp,lpc1850-uart.txt binding is already covered by 8250.yaml, so remove
it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/serial/nxp,lpc1850-uart.txt      | 28 -------------------
 1 file changed, 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt b/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
deleted file mode 100644
index 04e23e63ee4f..000000000000
--- a/Documentation/devicetree/bindings/serial/nxp,lpc1850-uart.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* NXP LPC1850 UART
-
-Required properties:
-- compatible	: "nxp,lpc1850-uart", "ns16550a".
-- reg		: offset and length of the register set for the device.
-- interrupts	: should contain uart interrupt.
-- clocks	: phandle to the input clocks.
-- clock-names	: required elements: "uartclk", "reg".
-
-Optional properties:
-- dmas		: Two or more DMA channel specifiers following the
-		  convention outlined in bindings/dma/dma.txt
-- dma-names	: Names for the dma channels, if present. There must
-		  be at least one channel named "tx" for transmit
-		  and named "rx" for receive.
-
-Since it's also possible to also use the of_serial.c driver all
-parameters from 8250.txt also apply but are optional.
-
-Example:
-uart0: serial@40081000 {
-	compatible = "nxp,lpc1850-uart", "ns16550a";
-	reg = <0x40081000 0x1000>;
-	reg-shift = <2>;
-	interrupts = <24>;
-	clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
-	clock-names = "uartclk", "reg";
-};
-- 
2.40.1

