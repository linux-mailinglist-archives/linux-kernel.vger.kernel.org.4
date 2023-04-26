Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F216EED8A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 07:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbjDZF2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 01:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbjDZF2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 01:28:48 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789E62D4E;
        Tue, 25 Apr 2023 22:28:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-94f0dd117dcso970847566b.3;
        Tue, 25 Apr 2023 22:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682486922; x=1685078922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6sKTnga5osoBChiq0wC1tiBZnMTBNSiyIak8o4AC7LI=;
        b=djsY6zxING+g2l5KOLqSIPqSIeSPFcbcuGKUzAGuj2UFRivzX/RuQYRCmN2jqtmIm8
         VGx6fwTYoauSqJwQAnMC6EQsIjvlTJ72kF1JQDVyMeefckikBpS2j3cviqyOae7wtcXb
         XPCbiJQTJi2L8tw2BeS+OEV8ip8n15Xor8COAlGdysVjag2FEpahr2TWT3zPhGsqiehe
         qjgXcR2iUgzLDMkLS6ti4UreHt1YikUMIK29GCK7oAyWCr7nC1vQAzgCSTzQ3xelEmge
         kqqauDaClv4AFSD+Jx3liqD4BsQftz7yKBcI5qxfPcfIXOGgHHpYpR+IPHeBahI3w/XA
         3GyQ==
X-Gm-Message-State: AAQBX9fmADb3K16E0VK27t67yr/XIogdD/+Rv76vIt+5qG3AKJM0mfOz
        eEXMPiVRaiC90aYvdHOBt3jxZZ4r8Bk=
X-Google-Smtp-Source: AKy350afIwgIUzk7/1vNhIB1UUFEJtteADzFrDD5QGP+/lq4u5bIcqIkZK/MyC4E+wHZ/4sZ2kJT5g==
X-Received: by 2002:a17:907:7e94:b0:94e:d75b:5998 with SMTP id qb20-20020a1709077e9400b0094ed75b5998mr18238906ejc.5.1682486921617;
        Tue, 25 Apr 2023 22:28:41 -0700 (PDT)
Received: from cizrna.home (cst-prg-36-136.cust.vodafone.cz. [46.135.36.136])
        by smtp.gmail.com with ESMTPSA id i21-20020a05640200d500b00501d73cfc86sm6598206edu.9.2023.04.25.22.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 22:28:40 -0700 (PDT)
From:   Tomeu Vizoso <tomeu@tomeuvizoso.net>
To:     linux-kernel@vger.kernel.org
Cc:     Tomeu Vizoso <tomeu@tomeuvizoso.net>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support),
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support)
Subject: [PATCH] arm64: dts: VIM3: Set the rates of the clocks for the NPU
Date:   Wed, 26 Apr 2023 07:28:31 +0200
Message-Id: <20230426052831.59391-1-tomeu@tomeuvizoso.net>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise they are left at 24MHz and the NPU runs very slowly.

Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Suggested-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 4e8266056bca..3a14b21998c4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -52,6 +52,9 @@ galcore {
 
 &npu {
 	status = "okay";
+	assigned-clocks = <&clkc CLKID_NNA_CORE_CLK>,
+			  <&clkc CLKID_NNA_AXI_CLK>;
+	assigned-clock-rates = <800000000>, <800000000>;
 };
 
 /*
-- 
2.38.1

