Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3C68D28D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjBGJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjBGJUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:20:11 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E05024C96;
        Tue,  7 Feb 2023 01:20:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso8126565pjb.4;
        Tue, 07 Feb 2023 01:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=qEusEdBfiDNNg0zGCZwalUdnyayrG6oU5MiTBryyzBd1czaeGECDhBevI1tbbKuDuJ
         /GGbdoZfVdSIb8QuveSZNeX7jt3CGlNov0mCvuu5QmP0QDf6AAWtl9YrCVwqS4GVGTVm
         5Ft2CMAKaFlJJ71+JKkQ1NqpAicK7EOTCTW7SLTAcBhI1INeJBrqKB1lh+nWv5J9uKUM
         UexXt4BVA7UOzfMga1Tpnz8jVLfSUZbonclTlpoHW9qusRxKJAU9AnwZ1cdak1tuyGaQ
         PyYsx/PHnKkyMJS8FAzdeFGbTM/Nm5Mrzfr12adVAOD4MxCk0hjrDAFAdNhZnjN8I++6
         FTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fuPzabFK+ItSAS4Njr3Xe+weyJyvM5VjKuGON2TO41E=;
        b=W6r9kSGRMg6bV/YVE6v4bB26KChclMIDjLLookiReI51Gu8plWhJEDbOUA/Mg7iorG
         NIEW8OndGtUnP5gbAXckM5EgssPIFatKf0S3JN+PDoAjPdihyjjCiptlet/3NaYvGmxH
         HAP21pQ8/W09LUnKrsbnRZoIrRyrfe/IdccWcHZ7w5CYge5qs0h+znPgc95O2R59FiKD
         Ew/PuRhtaZN4FgYV4ODT7qyyy45Qdg7exaroz1+OQQ7DvV8coXCDGn00JrE9EEM1vS/o
         /T15kXNq88vcacjUrTHwg0Dr1tXojDBj9CNyZ5MSMfSn7yaymjqwd4ZFM22xSg5h9BO+
         0M7Q==
X-Gm-Message-State: AO0yUKVRIQMipOzoYMto4za+ELBgZbBbUqe1K+YMlpfzjskchySQD+po
        4ZlqB/HIloonKsDt1PkfRbM=
X-Google-Smtp-Source: AK7set/oVVeXo2TGPpYMYfdUuGjB0RDyXCE8/IaXWR+Fn0JwqDiuqoGygI5uS9c6BnH8nSFh/7oqmA==
X-Received: by 2002:a17:902:c94e:b0:196:88b8:8616 with SMTP id i14-20020a170902c94e00b0019688b88616mr2447248pla.5.1675761610014;
        Tue, 07 Feb 2023 01:20:10 -0800 (PST)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id io20-20020a17090312d400b0019934030f46sm545327plb.132.2023.02.07.01.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:20:09 -0800 (PST)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v11 1/7] ARM: dts: nuvoton: Add node for NPCM VCD and ECE engine
Date:   Tue,  7 Feb 2023 17:18:56 +0800
Message-Id: <20230207091902.2512905-2-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207091902.2512905-1-milkfafa@gmail.com>
References: <20230207091902.2512905-1-milkfafa@gmail.com>
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

Add node for Video Capture/Differentiation Engine (VCD) and Encoding
Compression Engine (ECE) present on Nuvoton NPCM SoCs. Tested with
Nuvoton NPCM750 evaluation board.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index c7b5ef15b716..13a76689e14a 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -179,6 +179,24 @@ fiux: spi@fb001000 {
 			status = "disabled";
 		};
 
+		vcd: vcd@f0810000 {
+			compatible = "nuvoton,npcm750-vcd";
+			reg = <0xf0810000 0x10000>;
+			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_VCD>;
+			nuvoton,sysgcr = <&gcr>;
+			nuvoton,sysgfxi = <&gfxi>;
+			nuvoton,ece = <&ece>;
+			status = "disabled";
+		};
+
+		ece: video-codec@f0820000 {
+			compatible = "nuvoton,npcm750-ece";
+			reg = <0xf0820000 0x2000>;
+			resets = <&rstc NPCM7XX_RESET_IPSRST2 NPCM7XX_RESET_ECE>;
+			status = "disabled";
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -554,6 +572,11 @@ i2c15: i2c@8f000 {
 				pinctrl-0 = <&smb15_pins>;
 				status = "disabled";
 			};
+
+			gfxi: gfxi@e000 {
+				compatible = "nuvoton,npcm750-gfxi", "syscon";
+				reg = <0xe000 0x100>;
+			};
 		};
 	};
 
-- 
2.34.1

