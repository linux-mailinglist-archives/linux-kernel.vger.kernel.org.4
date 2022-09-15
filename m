Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6215BA00D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiIOQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIOQxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:53:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F56F2;
        Thu, 15 Sep 2022 09:53:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k9so31850761wri.0;
        Thu, 15 Sep 2022 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=p4zPXFzEmWgLuo+i2mZoclcbSp19IgN0lgmH+INT3lc=;
        b=RGscQldbrixtH4VM1aTTz2PSE2Mz4g/j9su1k4VwR+w8eezShNjMUBYHRNSMnDsQLZ
         9z5dyAoOuFGYhGrZ7ukgctCygt2nUujjVWQQkzMHr6XYZ8HvZIWIVr+ornpDFgz5Y+Mr
         HIx/VBe+696Cs56RCUVON/3CmiwusrVUQ8cu+XUw8U/62QtYZg3j2fmwsTjRJWVLXPWs
         fGWvGO/bqkUhmR9jVMOmbKBNAJcWKK8UEuwt43LiZc4AeOXfxXsa2DEXf67epmYzkzjA
         Ywi4gPZBB5d5s/9uxzvq1UD6T2bsWlqcIBQ+7ksFz2SJUgC1+H+msQ1SjUR7vZkBjaKY
         7fiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=p4zPXFzEmWgLuo+i2mZoclcbSp19IgN0lgmH+INT3lc=;
        b=uf+roq3TR7EFW6sk0hkUqwb6m/DUcYjp9Ta23p6TrliLB/DZiZLmCEB7zdMRpk1q/W
         mXgvgb1Tt103kU3rvzSzsIMfOP02B7n1HjCMt1RKleXara/smaWFBBjHu3vRz2nfNRy1
         IJePl5k8nsMTom8iklGhXXn1JFeFhngnjA8b30Im991z5j7nD4lmcFOADlvkr5J3vn9Z
         FPuQ+ZyD3A8pAPz5+9RW5wiMZtM+rmmumtxeZVdqFhzoGWpN8PdbLmUROPQybZP2gGyX
         el5wdoFBEjdke04DN60NKmlRLzzbJT2hdJcXUPHC5lOZW3bC6K9vimi7AQuAJ2n+b880
         UzFg==
X-Gm-Message-State: ACrzQf0PxL6DK5bSLcWnzONXB1m1tMs9YtN0R/tov7xC1rxG8+O9o+hs
        kqwL6ioY6lEC1o+NRmm1Cy8=
X-Google-Smtp-Source: AMsMyM5T0VA4b5gmZF/SHhNtsIKv5qgv6/KCmvNkiR6tgSp0RDeSL56OGc3lM2iBEPphMDcAlySq0A==
X-Received: by 2002:adf:f804:0:b0:228:62fd:6e9a with SMTP id s4-20020adff804000000b0022862fd6e9amr372716wrp.697.1663260819608;
        Thu, 15 Sep 2022 09:53:39 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:fc6e:cfa1:9281:3490])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c4fcf00b003b332a7bf15sm3562129wmq.7.2022.09.15.09.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:53:38 -0700 (PDT)
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
Subject: [PATCH 1/2] arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
Date:   Thu, 15 Sep 2022 17:52:55 +0100
Message-Id: <20220915165256.352843-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220915165256.352843-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Move including the rzg2ul-smarc-som.dtsi from the carrier board
rzg2ul-smarc.dtsi to the actual RZ/G2UL SMARC EVK board dts
r9a07g043u11-smarc.dts. Also move the SW_SW0_DEV_SEL and
SW_ET0_EN_N macros to board dts as they are used by SoM and carrier
board DTS/I.

This is in preparation of re-using the SoM and carrier board DTSIs
for RZ/Five SMARC EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 12 ++++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi      | 11 -----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 121e55282d18..059885a01ede 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -6,7 +6,19 @@
  */
 
 /dts-v1/;
+
+/*
+ * DIP-Switch SW1 setting
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
+ * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
+ * Please change below macros according to SW1 setting on the SoM
+ */
+#define SW_SW0_DEV_SEL	1
+#define SW_ET0_EN_N	1
+
 #include "r9a07g043.dtsi"
+#include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index f9835c12023e..2a1331ed1a5c 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -5,17 +5,6 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
-/*
- * DIP-Switch SW1 setting
- * 1 : High; 0: Low
- * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
- * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
- * Please change below macros according to SW1 setting
- */
-#define SW_SW0_DEV_SEL	1
-#define SW_ET0_EN_N	1
-
-#include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
-- 
2.25.1

