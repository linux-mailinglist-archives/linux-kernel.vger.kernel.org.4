Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C346C4ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjCVPDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjCVPDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:03:39 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5124D21A35;
        Wed, 22 Mar 2023 08:03:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso19435148pjb.2;
        Wed, 22 Mar 2023 08:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679497416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vlDYEVeWXdvuDC7Z36pSTJuAsUJDvI1ubkbi2mOoDLM=;
        b=F6Wn/NvBdQrl5XFsJGT250xMrB1RP45wxwAU77e16tYFLnCA4vM6jzPDvt65zJ0Phe
         OLB75CccwBaLXOw4EQMvErfr91/wHM976Fet7kBrwfRUlNXqJhxnJOu94yIeZPb0TchO
         YmeSko0HsWl37Z0EpECz5+HbTOQG5kotRunJLlNLvmO9ljXAfPtW3AT2c/rM4j2xxvE0
         uQL+Cut9g8fjJMEv7Z/ETA03NZDeAKz/4HTRpl0pZAbEfb5CB8xW37pDezxEELMklaoE
         9crhirwDWaeH3Z3DabmtBuSdSUJ1IC+5tcRSO3ko3T6sIUeOxbplYD+Ky3JJXtNpMc94
         yUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679497416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vlDYEVeWXdvuDC7Z36pSTJuAsUJDvI1ubkbi2mOoDLM=;
        b=s39dJmYh8LBKr5n6x+teeH/cziULUE2yTZ1DtsKZD4PDk6YiBBonpYkXA8oAmTYo0i
         XgDam4SZMrV1nPPzCVnNC0x+0GxvA5t9jMwbsLiGroQuHdljRFbWKUJht7wzw8dJv66G
         AHEVlUPxys+EwesKVq2xgxfWvCPdfs6gbP/1VgU94WiFlB55AtP5KlRSh2WE6QyHU4bx
         udqH7MBpSIB/bEvgVmJbNodT+teIjjtyyFgvhNLHF32PWtI3D9TrFlZqg0PWbAEBLQwc
         6afsZe0lJuP46MRiUukUOToh75DYiXLn3vvJjbJ+QB3TAOEJPbadNdlw4upP61cHFH3v
         VJwQ==
X-Gm-Message-State: AO0yUKUkvKgwOhByqpB01Kpqs0AOZW0+IKmHQuTKDQ5ATAqepJNNJVrL
        r5L1B98gy25nZCH0aBNc0c8=
X-Google-Smtp-Source: AK7set/ol1/Ysh6iIZcjzavsEW0i0qlM2XSsNN8OYuiqN9bGCLaZLP0W5jGaakKQGAgMYGatTlUJXg==
X-Received: by 2002:a17:903:1391:b0:19c:e05a:ea6 with SMTP id jx17-20020a170903139100b0019ce05a0ea6mr2530816plb.56.1679497416393;
        Wed, 22 Mar 2023 08:03:36 -0700 (PDT)
Received: from localhost.localdomain (n220246252084.netvigator.com. [220.246.252.84])
        by smtp.gmail.com with ESMTPSA id o7-20020a635d47000000b0050fb4181e8bsm2761238pgm.40.2023.03.22.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 08:03:35 -0700 (PDT)
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
Subject: [PATCH 1/4] arm64: dts: qcom: move elish dts to common dtsi
Date:   Wed, 22 Mar 2023 23:03:17 +0800
Message-Id: <20230322150320.31787-1-lujianhua000@gmail.com>
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

There are two panel variants of xiaomi-elish, BOE and CSOT panel.
In order to support both panels, so move elish dts to common dtsi.

Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
---
 ...m8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} | 4 ----
 1 file changed, 4 deletions(-)
 rename arch/arm64/boot/dts/qcom/{sm8250-xiaomi-elish.dts => sm8250-xiaomi-elish-common.dtsi} (99%)

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

