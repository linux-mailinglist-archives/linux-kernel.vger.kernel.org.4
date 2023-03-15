Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99036BBEDE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjCOVTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjCOVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:19:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3D8A42;
        Wed, 15 Mar 2023 14:18:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p6so21544701plf.0;
        Wed, 15 Mar 2023 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678915117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xxt4LuCxlszUcIHaA9c1/MXjkoSkJcmaannzFKOFoWA=;
        b=jw/5yZ+PC4ZhgprqPLctkKtf7zRMG/Lx3sPKN/L9gNqyC7YpTz9y65ImwIgC4BMGg0
         vYNJwfP5+s6NWBeZoDLrpeD6+ahK62DEsQDMDRhfCPHtM1Uhxng8pavsbnGVEb7my4hr
         AD00LAkXF9lL06WmQh3kUkpdD3wfAg05yjCrcwJKqCu0XYDNLVYi2drGoSqSduFgxkZ6
         L8mp5GTmM/2s3MU+AI65qw5uSdZ2R5rhiTRMs85OkyEwRYdf8FPtEer6EGJjKnIUE3uU
         8E5hbI66P5T6s879Mwu+RAsZr+4QS4m/r+HMSsF0aAgMjpF8MBC3bvJteIkrumPs0v+U
         l8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xxt4LuCxlszUcIHaA9c1/MXjkoSkJcmaannzFKOFoWA=;
        b=5igOejH/LCgPTnKMtKo6D3ZnVG4m7jvI98u5MXFap3XlpwLRUMpVIAAyrif0C75sDC
         TEamzvZXpZcFBVMKG8urLRJ13G4r6IVAcijWPnqoVtBE9EYzKq6Fx2t6QkygGGaChfth
         Ryrn6d8C2bfvXXcrsIxvIKqAeotrTLOGH2eOxcgBSJCC58YOL5Kvkos8mfThzOmWiocZ
         d4AOVZfsvUe09Ov+j/MFSdMQx/zFeWPQjsvSft7QfkcgMevCrpJQLYMTR5gHF7wCgzW8
         ZureSMPnnMdu+38tGT58Uk0zI2bxANW60MaqdhrULyGdRRKjOUW0CmEmGNYry2k52b72
         nZ8g==
X-Gm-Message-State: AO0yUKW46pAEDuzFtR19UUnUU1xoziNL5RPaaFGoDMe9gu67kmE0Q2Mo
        l6jC5ZEfeeU48BLzeUfpuMg=
X-Google-Smtp-Source: AK7set+szA0j2B23AyV0+EbIwuaJOlhCmgGfUruIUC4kbYGl34aKKksLBQ0UfkLyI+4IrRUcuBg+Uw==
X-Received: by 2002:a05:6a20:6904:b0:bf:8a97:6e48 with SMTP id q4-20020a056a20690400b000bf8a976e48mr1305164pzj.37.1678915117583;
        Wed, 15 Mar 2023 14:18:37 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.213.199])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b005897f5436c0sm3981695pfo.118.2023.03.15.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:18:37 -0700 (PDT)
From:   David Yang <mmyangfl@gmail.com>
To:     mmyangfl@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 3/4] dt-bindings: clock: Add Hi3798MV100 CRG
Date:   Thu, 16 Mar 2023 05:16:22 +0800
Message-Id: <20230315211628.963205-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315211628.963205-1-mmyangfl@gmail.com>
References: <20230315211628.963205-1-mmyangfl@gmail.com>
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

Add CRG bindings for Hi3798MV100 SoC. CRG (Clock and Reset Generator)
module generates clock and reset signals used by other module blocks on
SoC.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/clock/hisi-crg.txt          |  2 ++
 include/dt-bindings/clock/histb-clock.h             | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/hisi-crg.txt b/Documentation/devicetree/bindings/clock/hisi-crg.txt
index cc60b3d42..972c038c8 100644
--- a/Documentation/devicetree/bindings/clock/hisi-crg.txt
+++ b/Documentation/devicetree/bindings/clock/hisi-crg.txt
@@ -13,6 +13,8 @@ Required Properties:
   - "hisilicon,hi3516cv300-crg"
   - "hisilicon,hi3516cv300-sysctrl"
   - "hisilicon,hi3519-crg"
+  - "hisilicon,hi3798mv100-crg"
+  - "hisilicon,hi3798mv100-sysctrl"
   - "hisilicon,hi3798cv200-crg"
   - "hisilicon,hi3798cv200-sysctrl"
 
diff --git a/include/dt-bindings/clock/histb-clock.h b/include/dt-bindings/clock/histb-clock.h
index e64e5770a..704770ac8 100644
--- a/include/dt-bindings/clock/histb-clock.h
+++ b/include/dt-bindings/clock/histb-clock.h
@@ -58,6 +58,19 @@
 #define HISTB_USB3_UTMI_CLK1		48
 #define HISTB_USB3_PIPE_CLK1		49
 #define HISTB_USB3_SUSPEND_CLK1		50
+#define HISTB_USB2_UTMI_CLK1		51
+#define HISTB_USB2_2_BUS_CLK		52
+#define HISTB_USB2_2_PHY_CLK		53
+#define HISTB_USB2_2_UTMI_CLK		54
+#define HISTB_USB2_2_UTMI_CLK1		55
+#define HISTB_USB2_2_12M_CLK		56
+#define HISTB_USB2_2_48M_CLK		57
+#define HISTB_USB2_2_OTG_UTMI_CLK	58
+#define HISTB_USB2_2_PHY1_REF_CLK	59
+#define HISTB_USB2_2_PHY2_REF_CLK	60
+#define HISTB_FEPHY_CLK			61
+#define HISTB_GPU_BUS_CLK		62
+#define HISTB_GPU_GP_CLK		63
 
 /* clocks provided by mcu CRG */
 #define HISTB_MCE_CLK			1
-- 
2.39.2

