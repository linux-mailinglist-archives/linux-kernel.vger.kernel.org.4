Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE36C521E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjCVRQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjCVRQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:16:31 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003867022;
        Wed, 22 Mar 2023 10:16:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id kc4so5294800plb.10;
        Wed, 22 Mar 2023 10:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679505363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v5Lu9OAJ6YsotRRIx5xX4C7y7EyPhqOmAF4dQrNJsFU=;
        b=C85fvvarLU3Ogwuk7AJV59+o/hrYbhNNlrLot/DDOX9oVLnpJYHOCa0JKsxGhw8XwQ
         qb8YKAEoxyfpOaPgz1tJ82Ln+iNgYjpxXI4PRsPFwaL3Jh+390R+jvPIza3Uvifem45I
         aSHip6GR8ds7gmMzGCyUqWKHnHxbxWpkBC0fMC9dOdkawzLTaFWEEW3NIn5goysg0hih
         dedDZugNFm7T8EYltA6XuW+57UWsjDXAN3xr2dqxHzHGgm7ha8Zs+XCtqk+IfMT+/NjL
         2mI4bjYWbUfdiLPma8CFv0p5673CecMQHsQeF1SwhF3z9YKzM08vd4k6I+rH6SCaYptX
         OFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679505363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v5Lu9OAJ6YsotRRIx5xX4C7y7EyPhqOmAF4dQrNJsFU=;
        b=Vdq0baU1CLVLNu1HgARwfeizcAQQdfPgjik+fe3CrFoK3yFUQnGX1bJoVz9KCuU06v
         ku+JY4ehAWRenHBn8fy9MTPfGtIrCfAIqS01r/pChF05L+bVFVXjVjGSW9it728fzbvt
         /fGEZpy0SqkgbENLVRI+Cpu5742FJJxxBD7tr6ucUBZOFa+ABmagwzMbMOBBsmsB9NTe
         BmIUCU8b3g0QWJhX1+w/dcEuYhc9zA1JJX9zociRm0aQJcweF4ueugTLaNe9GOVB6sdA
         mzDBucP5J7zJ/+lR6H1ePIqbzTqU/Pm6rWA/vl+vOYPuXL0xBKDvQqu9Sjx5XW6WxDAc
         bD7w==
X-Gm-Message-State: AAQBX9df7BYcrRQijBFu+sv/WyDe85gnvL5wqpj7BVcLkiOZydSZBA99
        FL/fYWLeY2tPgJAkxFpRDcA=
X-Google-Smtp-Source: AKy350YNO4UIxw70VOrky+hJnmB189eJUNoIWY5OMBbWpoA9Wc6C3KpjBzRS2hX2LVpEKxKWeVW84Q==
X-Received: by 2002:a17:90b:1c84:b0:23b:4438:e9ee with SMTP id oo4-20020a17090b1c8400b0023b4438e9eemr2750750pjb.12.1679505362625;
        Wed, 22 Mar 2023 10:16:02 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id b1-20020a6567c1000000b005023496e339sm10097353pgs.63.2023.03.22.10.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 10:16:02 -0700 (PDT)
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Jianhua Lu <lujianhua000@gmail.com>
Subject: [PATCH v2 1/4] arm64: dts: qcom: Move elish dts to common dtsi
Date:   Thu, 23 Mar 2023 01:15:52 +0800
Message-Id: <20230322171555.2154-1-lujianhua000@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two panel variants of xiaomi-elish, BOE and CSOT panels.
In order to support both panels, so move elish dts to common dtsi.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
Changes in v2:
  - Remove sm8250-xiaomi-elish.dtb to avoid build failure.

 arch/arm64/boot/dts/qcom/Makefile                             | 1 -
 ...m8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} | 4 ----
 2 files changed, 5 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sm8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} (99%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1a29403400b7..8d2b3c57a4a8 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -183,7 +183,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-xiaomi-elish.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
similarity index 99%
rename from arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
rename to arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index dd79671f5614..a43d4b73ffca 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -3,8 +3,6 @@
  * Copyright (c) 2022, 2023 Jianhua Lu <lujianhua000@gmail.com>
  */
 
-/dts-v1/;
-
 #include <dt-bindings/arm/qcom,ids.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8250.dtsi"
@@ -24,8 +22,6 @@
 /delete-node/ &xbl_aop_mem;
 
 / {
-	model = "Xiaomi Mi Pad 5 Pro";
-	compatible = "xiaomi,elish", "qcom,sm8250";
 	classis-type = "tablet";
 
 	/* required for bootloader to select correct board */
-- 
2.39.2

