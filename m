Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B508873EE88
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjFZWM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbjFZWMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:12:23 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E694230F3;
        Mon, 26 Jun 2023 15:10:17 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7835ffc53bfso37462139f.1;
        Mon, 26 Jun 2023 15:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687817417; x=1690409417;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riyoS0XQhiArcxIoPKub70n8ZIyykLagdDPG18REZSA=;
        b=GQHaiIp8cfp3GCInPaC0EWrDijS5+OQZJi6ITTV9AfwIDAdkzTNgfnCx1KvsDoWFrf
         TeRMS0kv0j4QEJz2qRqWdEzlmy4kWq9RGAB8Dl1TVLzWNO5mf/JLeInPrq2kEDK20UDY
         hN8YpLKYggEY/+dXvWgIo4F6CQxahc4Og5WIvC+RbDXLzN0QkIgZCMJJI8Rb2o2L3LPU
         OvH1fz3HiFuhAIu5JqveG3btDCQXQOMrJ9yV3zn0YAvio1tsrqqmR4WbbaSJbxBPoXQL
         Jxituw+d7CK8XLDpDVxdmO/Ep45IT6QzBDLNcoNdB//Vx+EYWgQTlmzfl6+xJgPQCDVm
         CB+g==
X-Gm-Message-State: AC+VfDzylt0EaCsZd6bHDgOLAHAGdl7ZX8wE5GSrNOXd9s068UfDWJ0t
        FSD3CiqoTlG6OcEiXLYXlvOCLdh2Ag==
X-Google-Smtp-Source: ACHHUZ4NnWJsAfN5DLGSbWMvOtqp/CfSR59mOLh3GQVF1iyJtqhN/myX//Gf+m7RBPwsVByz850IMA==
X-Received: by 2002:a5d:9cd5:0:b0:783:727a:8e15 with SMTP id w21-20020a5d9cd5000000b00783727a8e15mr349465iow.6.1687817416929;
        Mon, 26 Jun 2023 15:10:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c11-20020a6bfd0b000000b0077e24ace3edsm2363315ioi.52.2023.06.26.15.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:10:16 -0700 (PDT)
Received: (nullmailer pid 3946378 invoked by uid 1000);
        Mon, 26 Jun 2023 22:10:14 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: at91-vinco: Fix "status" values
Date:   Mon, 26 Jun 2023 16:10:10 -0600
Message-Id: <20230626221010.3946263-1-robh@kernel.org>
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

The defined value for "status" is "disabled", not "disable".

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm/boot/dts/microchip/at91-vinco.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91-vinco.dts b/arch/arm/boot/dts/microchip/at91-vinco.dts
index ebeaa6ab500e..ecbdacf48708 100644
--- a/arch/arm/boot/dts/microchip/at91-vinco.dts
+++ b/arch/arm/boot/dts/microchip/at91-vinco.dts
@@ -159,7 +159,7 @@ usb0: gadget@400000 {
 			atmel,vbus-gpio = <&pioE 31 GPIO_ACTIVE_HIGH>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_usba_vbus>;
-			status = "disable";
+			status = "disabled";
 		};
 
 		usb1: ohci@500000 {
@@ -168,7 +168,7 @@ usb1: ohci@500000 {
 					   &pioE 11 GPIO_ACTIVE_LOW
 					   &pioE 12 GPIO_ACTIVE_LOW
 					  >;
-			status = "disable";
+			status = "disabled";
 		};
 
 		usb2: ehci@600000 {
-- 
2.40.1

