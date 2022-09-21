Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD15BF900
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiIUIWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiIUIWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:22:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0D08304C;
        Wed, 21 Sep 2022 01:22:30 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id e18so3867054wmq.3;
        Wed, 21 Sep 2022 01:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=H5pPXCSR18kwywyOge1PAaJr0wGHH6sXNgt54XvoBP8=;
        b=XifkRMc+1ZWXN4YyX7Oc2smwmjtRmnhBqVApSiKvH1tA8dJQz+/MBohKljL1zNCJfS
         zq0T+W3XwjZR06H97v0dJC/e0oLwko6ngqmLSf+TApICU47sZIXTPm1lJw6NBgz59hSm
         eZiPGC2W7SQyc8gcJS+RyX59DZMIo0izFrCug4dH570jGbINg6RMPXy25IrNelnnS1md
         sl7WIw6LVcgXq8h4FqsZQKIh2eB7X2YfDg2tCmxCJZ/y5pO5vyCx5a1XqytZulT2LwB5
         WYWV5t/oTr08KjlA/5uhz6f9gnpkgcz6tjVzcYE5mliE1Y54n0Ot71IouvT1KrvQIjUO
         ragw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=H5pPXCSR18kwywyOge1PAaJr0wGHH6sXNgt54XvoBP8=;
        b=pEXlZ9jVZTKb6PAm0iC8zvui5O5NtQ7On9UNH4PkJgrlyDAn7sNszvHZjj/aI9EFWJ
         zL0qzMuCt8NnorILX3lPzeozrp8q9nQkTJbggbtFJOufBLdpsn+/R0MVLezSB/2QpKs5
         Kt4ERPDXuepNqR6yDC7j05poo0EpVGIOF8MeZKNlq8YIb7FUP0PxXMsn8z4qJ23drjS/
         vFZ+J+utag1qgGt1yZm2fnWvNrIQuIA2nyl3X/e1jqI1EIIw/l2t+5QSk3wQgFeGxORo
         gShUrajPokJIb4blfJ7Wx2nYN7Q45bNR4J/5gtCB0EKRAt0TZ6wlK584SdsLT5RuK2ac
         sUqA==
X-Gm-Message-State: ACrzQf2y6AIMTWd4KPuqrJsAZvSQZ+Oq7BjdpM6EeT4OTgwcSY9i9+6F
        1fjmcCF/rfBR8QNDupgP269w8OFzDVjYsg==
X-Google-Smtp-Source: AMsMyM5bd8NKuFcIaKie8yXjkFGvIqTpDR7aUk3Ji0DUu8y1iRoihxa5oqiZQWfxjtFuatfIkCNjtg==
X-Received: by 2002:a05:600c:43d3:b0:3b3:2f1c:f01c with SMTP id f19-20020a05600c43d300b003b32f1cf01cmr4994864wmn.152.1663748549379;
        Wed, 21 Sep 2022 01:22:29 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:a137:83be:d4a3:8e44])
        by smtp.gmail.com with ESMTPSA id b15-20020a5d40cf000000b00228fa832b7asm1863529wrq.52.2022.09.21.01.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:22:28 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board DTSI
Date:   Wed, 21 Sep 2022 09:22:21 +0100
Message-Id: <20220921082221.10599-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

spi1 is available on the RZ/G2UL SMARC EVK carrier board (PMOD0), hence
moving the spi1 pinmux from SoM to carrier board. This is to keep
consistency with the other SMARC EVKs.

Also while moving the pinmux rename rspi1 to spi1 to be consistent with
other SMARC EVK DTSIs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 7 +++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi         | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index bd8bc858c28c..58923dc83faa 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -99,6 +99,13 @@ sound_clk_pins: sound_clk {
 		input-enable;
 	};
 
+	spi1_pins: spi1 {
+		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
+			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
+			 <RZG2L_PORT_PINMUX(4, 2, 2)>, /* MISO */
+			 <RZG2L_PORT_PINMUX(4, 3, 2)>; /* SSL */
+	};
+
 	ssi1_pins: ssi1 {
 		pinmux = <RZG2L_PORT_PINMUX(3, 0, 2)>, /* BCK */
 			 <RZG2L_PORT_PINMUX(3, 1, 2)>, /* RCK */
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 2a0feb53f0dc..931efc07d6fb 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -221,13 +221,6 @@ sd0_mux_uhs {
 			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
 		};
 	};
-
-	spi1_pins: rspi1 {
-		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
-			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
-			 <RZG2L_PORT_PINMUX(4, 2, 2)>, /* MISO */
-			 <RZG2L_PORT_PINMUX(4, 3, 2)>; /* SSL */
-	};
 };
 
 #if (SW_SW0_DEV_SEL)
-- 
2.25.1

