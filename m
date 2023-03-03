Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127356A911E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 07:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjCCGhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 01:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCCGhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 01:37:15 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911B247409;
        Thu,  2 Mar 2023 22:37:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q23so876435pgt.7;
        Thu, 02 Mar 2023 22:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677825424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uUufnqGUd6ZHw3YSoTgde4z4+kgG2gE44eDuR5QPdSQ=;
        b=T0qlZ92uB9S9P2212hvx5nufAkStuhEvfjJuYeTTt38/bUnwhLGGjMOjSpq8kVJkoi
         acuuH28YYfnaUKPCpLVh783Ku4PotFXIOkfGYHJiifeSQ7s11NPkw8wd+QF9+TZiB2f1
         LESAtvLfZbZ5x2/7qPZnkVEHu29RZYsN/ukETcbAVw3qrAb5Seh52p2IYb3cWOSKocxO
         3p2V4e3lO73eaV5M/qzGkh9eEBBz6/g8liVM8hK4i1mHDfnOdZH//nFQjfexiNLwfESU
         c7GUtHaa2ZIfVAgAtoA8tSqCSZFgVS4nioNTiNRNZgspdEJmfGM1Z344Gwv80hPzzfcN
         KK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677825424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUufnqGUd6ZHw3YSoTgde4z4+kgG2gE44eDuR5QPdSQ=;
        b=DDRI+iBLi8rRJ3j9d8mQ6hrIe0ySxS4bxYlUkRozhipnUTrleobfrJHYoVOq7Pye8b
         rnWLSygJRhSFvG7hljKVIi08/orheqzFwPxomrs0GRxLFk9UCtny6Q181BYqJI20TGLF
         PFkvQ+UulJeLmI6lkBTrcaaDH6Qjs2nUV5OC0Xn+ZlrVZXdPSahRxQ4eIvWbjl8NKpMl
         +1BtNibvtacPDSKg30ILQjP82oooU4neJu01wnVIWriMDr+LAtcj7zJ9JXGSEdwEfy94
         vNVwVKo6GEh2X9ZHpz1DYGACCLR5zrAwNikYM/BWJtuGxwPeJR5IN51G7KFSFcijmkbQ
         kcng==
X-Gm-Message-State: AO0yUKVr9VjsTB8+S6KYlJYzKcqbr83pE6aVKwzH34jpx9JfwjECtRVq
        IRA6aJYgk1B/0rkdv5x3s84=
X-Google-Smtp-Source: AK7set+KhVV1I4OqZOVr0styK+EuLYSUZYlFYuUiA/gFYJhR8P8CMhyhb1vyP7395AzuKK1/fwoDXg==
X-Received: by 2002:aa7:940b:0:b0:5a8:b705:4dd3 with SMTP id x11-20020aa7940b000000b005a8b7054dd3mr1212764pfo.13.1677825423959;
        Thu, 02 Mar 2023 22:37:03 -0800 (PST)
Received: from davidwang.dhcpserver.bu9bmc.local (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id l30-20020a635b5e000000b004ff6b744248sm736348pgm.48.2023.03.02.22.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 22:37:03 -0800 (PST)
From:   David Wang <tomato1220@gmail.com>
X-Google-Original-From: David Wang <davidwang@quantatw.com>
To:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        fran.hsu@quantatw.com, David Wang <davidwang@quantatw.com>
Subject: [PATCH 6/7] ARM: dts: nuvoton: gsj: Add non-mainline nodes
Date:   Fri,  3 Mar 2023 14:34:34 +0800
Message-Id: <20230303063435.803097-6-davidwang@quantatw.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230303063435.803097-1-davidwang@quantatw.com>
References: <20230303063435.803097-1-davidwang@quantatw.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the remaining non-mainline component of the patch that adds the
GSJ machine.

Signed-off-by: David Wang <davidwang@quantatw.com>
---
 arch/arm/boot/dts/nuvoton-npcm730-gsj.dts | 35 +++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
index 2a394cc15284..48110f8aa3ca 100644
--- a/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm730-gsj.dts
@@ -14,6 +14,7 @@ / {
 	aliases {
 		ethernet1 = &gmac0;
 		serial3 = &serial3;
+		udc9 = &udc9;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
@@ -184,10 +185,40 @@ &gmac0 {
 	status = "okay";
 };
 
+&mc {
+	status = "okay";
+};
+
+&emc0 {
+	phy-mode = "rmii";
+	use-ncsi;
+	status = "okay";
+};
+
 &ehci1 {
 	status = "okay";
 };
 
+&ohci1 {
+	status = "okay";
+};
+
+&aes {
+	status = "okay";
+};
+
+&sha {
+	status = "okay";
+};
+
+&pcimbox {
+	status = "okay";
+};
+
+&udc9 {
+	status = "okay";
+};
+
 &watchdog1 {
 	status = "okay";
 };
@@ -216,6 +247,10 @@ &adc {
 	status = "okay";
 };
 
+&otp {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 
-- 
2.25.1

