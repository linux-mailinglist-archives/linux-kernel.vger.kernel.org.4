Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312CB61A08E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiKDTI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiKDTIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:08:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD9831364
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:08:46 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id z6so3609090qtv.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1v+UD2x/ZGiBuFs1pqpwsc0Q+q/HiYmDrjtee4/iOo=;
        b=U59WupiCImSr3i+3Lwom8Pzuy91rERyfxy7lMPPwObrCPlJDcdkOfhsmHy41B4Oni+
         HyBr01TrWM5ppvE1fgXPwLaaRky3w28symvqhnjEjLuzvEavxxcNgGp6PlE61nCl2hah
         7orGdv0SsxM651X19prphQZFQ7tRaFSx4A/DEXXfqmbe+dMCfJ6qcyVVzbJjqco8RfyT
         MvDSKuOG7IbjKzUvHBFcBhKdhGSStUpLx9XjKQJTdq+eL80uvtJCmGSaiuN3nW5dwX58
         MCNmxwCfFs+K9i+x7wXd4umMQBpmuo7if163pTutAJiD4kmV8Vs2i+v9oYvqWODB4gwW
         MPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1v+UD2x/ZGiBuFs1pqpwsc0Q+q/HiYmDrjtee4/iOo=;
        b=T4hD9oKJnjuZcr/b1QgddUhC2nNE4Kpu75vi0BidLLa3e6M3k0f5N43EjvkoHNhYQ3
         Xl4CIaYfhS0bFRoc8V0Bq6xF8yzNLpxvV90PPeOk8zuGU/IrnZtvdrtmI4qoQhnce4T5
         Rrkz/KlOC8pjIbzDMGKCgStgKoQx4ArS/IOIqtajorHpqGgc3PWEdQb+lsIHTErX/x55
         x3BWzc3sgSkLL6XbKb5FZZr6Ba8PwHWinSltCJyTSuFs7mG54NOyV+x2QHR/Rd8WIWFK
         54WMA4R47pqwO2tVu9k0VWW+v3qyWJC1aAwZwyFmgBL406YOTS37TkM4z/kQTzqL9vRo
         z97Q==
X-Gm-Message-State: ACrzQf063crgNmySMw+cGa2dvbReYU9YmqOsiCM1XV/UY+ExXSund5lN
        JUCCGYaj8Dst2Lvcxy3n5t2LhA==
X-Google-Smtp-Source: AMsMyM7tcvfdp7t3JvIV3qkPiTFyCSZ/1YHNmRHq3CejPqxWZ8mJP9dvchKDyn412+xREKj9pL2ezQ==
X-Received: by 2002:ac8:785:0:b0:3a5:46b0:ffd7 with SMTP id l5-20020ac80785000000b003a546b0ffd7mr12088044qth.632.1667588925880;
        Fri, 04 Nov 2022 12:08:45 -0700 (PDT)
Received: from krzk-bin.. ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id d14-20020ac851ce000000b0035d08c1da35sm63834qtn.45.2022.11.04.12.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:08:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: sdx65: add dedicated IMEM and syscon compatibles
Date:   Fri,  4 Nov 2022 15:08:40 -0400
Message-Id: <20221104190840.134733-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104190840.134733-1-krzysztof.kozlowski@linaro.org>
References: <20221104190840.134733-1-krzysztof.kozlowski@linaro.org>
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

Add proper compatibles to the IMEM device node:
1. syscon as required by the bindings, even though it is not currently
   used,
2. dedicated compatible as required for syscon and simple-mfd nodes.

Align the node name to match IMEM type of device - SRAM.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx65.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom-sdx65.dtsi
index 4cd405db5500..b073e0c63df4 100644
--- a/arch/arm/boot/dts/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx65.dtsi
@@ -441,8 +441,8 @@ pdc: interrupt-controller@b210000 {
 			interrupt-controller;
 		};
 
-		imem@1468f000 {
-			compatible = "simple-mfd";
+		sram@1468f000 {
+			compatible = "qcom,sdx65-imem", "syscon", "simple-mfd";
 			reg = <0x1468f000 0x1000>;
 			ranges = <0x0 0x1468f000 0x1000>;
 			#address-cells = <1>;
-- 
2.34.1

