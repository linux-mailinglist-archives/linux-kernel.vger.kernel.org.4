Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9696E645402
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 07:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLGG3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 01:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLGG3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:29:30 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D9759FC5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 22:29:28 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h193so15401923pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 22:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iX94usecQpYHQ7lRzJnclRYWm0+XDQltVTyOpei9CJg=;
        b=Y0FkDKpJXUkz3HYS0zkrzo49g5Zg+1ELoJbVU4tiIQGVJZzQ1htzt/yhca2hBF0yix
         XKzCK7BNfcrU7GULKSiHY/PnOc1GD4uap7ZK19j5uNUb5ct/vO7Q3oTTuebryS7wBC3y
         lBSgsymD2u5El6A6D/qsUpsmeKJRh7canyXX0e5Xq9E5MXX5adzyHgrAPS+PvmOlPUZK
         KeO11Xfk32Uv7aLBnOn5tdscW8+TlW0EBdn/5IcpQEgCCshSVxVYM/JgZmK/opGnTmd2
         MMK8dVAz5sWxpmnYg9cqhuuGPLIxI5Kkky5hM83Cyl+37L5nCbYt2uacOsjILGNgDMjG
         Tfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX94usecQpYHQ7lRzJnclRYWm0+XDQltVTyOpei9CJg=;
        b=IASXD+bb02HPwMlh2tTUYnUhUdj4xZDjg6qcSuZuz2y9ynape+qlA5KKiEBEYStxEB
         gvvNhZf7pBei45SMpbKIxVJ+gnTI+4Ih/xOMjb36YYqIjnnIB3NEjWlAK8YiWfP3XzGl
         oQriIv7FoaVXLkE6qj55Koyj63e+UIXvo6Gtpw8DU/0rY57pZU3/qqA+qdxa02vKASRR
         csabSjkQvhBjEYfv36hLLsnb3H0DVIjHwMVdK8UclBJIsmD7R7sTpn2GPtexPNCC88UN
         qgcmhqG91R3JQZZTdqyJveXEpDhLuttI8S0CXB5OJqMNzTTeBx+GqlwL0auszwuXTNYO
         6yaw==
X-Gm-Message-State: ANoB5pkmN1d+IHS7uMPQk5r7ozsJPOOwQgQxAKZOm0Ee5y61hMLqwy+g
        P/PgY+vqo6KBbcgjNUcbYLM9Vg==
X-Google-Smtp-Source: AA0mqf6YkiqYUX4054aYIkAqpK1uekX0DRjKBdtSEfqUjlPpngKw3ZXu9AGoJDmTJ3kNSyK3iHlK9A==
X-Received: by 2002:a63:f4b:0:b0:46f:98cf:3bb6 with SMTP id 11-20020a630f4b000000b0046f98cf3bb6mr63190842pgp.332.1670394568155;
        Tue, 06 Dec 2022 22:29:28 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:463a:3448:b9c:1bc1:63ac])
        by smtp.gmail.com with ESMTPSA id c7-20020a056a00008700b0057726bd7335sm3306243pfj.121.2022.12.06.22.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 22:29:27 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8150: Fix iommu sid values for PCIe nodes
Date:   Wed,  7 Dec 2022 11:59:13 +0530
Message-Id: <20221207062913.3154262-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the iommu sid values for the PCIe nodes present on
Qualcomm SM8150 SoC dtsi (in sync the with downstream code).

Fixes: a1c86c680533 ("arm64: dts: qcom: sm8150: Add PCIe nodes")
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 32 ++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index d1b64280ab0b..e88d1617a1ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -1810,9 +1810,23 @@ pcie0: pci@1c00000 {
 				      "slave_q2a",
 				      "tbu";
 
-			iommus = <&apps_smmu 0x1d80 0x7f>;
+			iommus = <&apps_smmu 0x1d80 0xf>;
 			iommu-map = <0x0   &apps_smmu 0x1d80 0x1>,
 				    <0x100 &apps_smmu 0x1d81 0x1>;
+				    <0x200 &apps_smmu 0x1d82 0x1>,
+				    <0x300 &apps_smmu 0x1d83 0x1>,
+				    <0x400 &apps_smmu 0x1d84 0x1>,
+				    <0x500 &apps_smmu 0x1d85 0x1>,
+				    <0x600 &apps_smmu 0x1d86 0x1>,
+				    <0x700 &apps_smmu 0x1d87 0x1>,
+				    <0x800 &apps_smmu 0x1d88 0x1>,
+				    <0x900 &apps_smmu 0x1d89 0x1>,
+				    <0xa00 &apps_smmu 0x1d8a 0x1>,
+				    <0xb00 &apps_smmu 0x1d8b 0x1>,
+				    <0xc00 &apps_smmu 0x1d8c 0x1>,
+				    <0xd00 &apps_smmu 0x1d8d 0x1>,
+				    <0xe00 &apps_smmu 0x1d8e 0x1>,
+				    <0xf00 &apps_smmu 0x1d8f 0x1>;
 
 			resets = <&gcc GCC_PCIE_0_BCR>;
 			reset-names = "pci";
@@ -1909,9 +1923,23 @@ pcie1: pci@1c08000 {
 			assigned-clocks = <&gcc GCC_PCIE_1_AUX_CLK>;
 			assigned-clock-rates = <19200000>;
 
-			iommus = <&apps_smmu 0x1e00 0x7f>;
+			iommus = <&apps_smmu 0x1e00 0xf>;
 			iommu-map = <0x0   &apps_smmu 0x1e00 0x1>,
 				    <0x100 &apps_smmu 0x1e01 0x1>;
+				    <0x200 &apps_smmu 0x1e02 0x1>,
+				    <0x300 &apps_smmu 0x1e03 0x1>,
+				    <0x400 &apps_smmu 0x1e04 0x1>,
+				    <0x500 &apps_smmu 0x1e05 0x1>,
+				    <0x600 &apps_smmu 0x1e06 0x1>,
+				    <0x700 &apps_smmu 0x1e07 0x1>,
+				    <0x800 &apps_smmu 0x1e08 0x1>,
+				    <0x900 &apps_smmu 0x1e09 0x1>,
+				    <0xa00 &apps_smmu 0x1e0a 0x1>,
+				    <0xb00 &apps_smmu 0x1e0b 0x1>,
+				    <0xc00 &apps_smmu 0x1e0c 0x1>,
+				    <0xd00 &apps_smmu 0x1e0d 0x1>,
+				    <0xe00 &apps_smmu 0x1e0e 0x1>,
+				    <0xf00 &apps_smmu 0x1e0f 0x1>;
 
 			resets = <&gcc GCC_PCIE_1_BCR>;
 			reset-names = "pci";
-- 
2.38.1

