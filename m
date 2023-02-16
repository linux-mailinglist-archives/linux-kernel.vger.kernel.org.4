Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592BC6994BE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 13:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBPMt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 07:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBPMt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 07:49:26 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F11BC5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:49:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bp15so2576329lfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I47sSPR7ZNaztONaWqb6mLDSnY0+foq2Vk2oB4VA64I=;
        b=AFEkKgWo5p6WqSLcM6zEraHsHV2ECKKOb9hmgH6XB5ib02yjOKY5cLPkIYq5/bozax
         zs7Mj+y11matrp+zaxkYMfqDl2J4yiaF+QMa2XrHBeSrU113HaNebmqBIqo1g59D3B9n
         cY1IaTsQ/bI+tWrC+hxn5KNBniXZ3qA+2a7SQQcNrcye6x6lud3CcndNhLFhQW6OUYlL
         O2hAwCfGW8XjNExiahGnSoaO+2saU+uq90GMpY8271HHoo9DXCCTbbovb2JILldjay1U
         KkBcMqiaPxD9TY+SQzhrVvojl42189s57S/AiK82JaPQtiVHFpCnM9WGrQZHDB7uJjWa
         4CzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I47sSPR7ZNaztONaWqb6mLDSnY0+foq2Vk2oB4VA64I=;
        b=q2I5+dGyXcHFaXJPy4G7ef6jQzH1K04JLn8wBKOgG83nSeYR0P5BYsCcm/ZH4LJXUS
         Lrd5MTDBZXQJXNgVV9/QzTsHuFGRg0Pgy5Uj124Qrxzc3ALOZFiMKGkNf+vp3AV/88Bt
         7vHy6HiUKozJD3sit3G+BqzHizrWD6IbQVEN2qb3/6Qy4IgRjZiwtHDQFCN5ZW65RcKG
         GvfBRUvnsZ8JQUn98IxH2jbvES7qtcSwgPYaIy0ENEUk+afl3m/DGqpH2x0ugLUEEqY0
         XoIjnWU8x5wKBjJVYnEJ07DedhIQJ49U/U22eIJPLL5/dQ83Qnh1iYLzWO90cN0S9WsV
         uspA==
X-Gm-Message-State: AO0yUKWaXLup7WvrpJczpaxy2IDzBa/c5x8GEFIhvQ2bRVA7hHIFXZ19
        VqSh0uSpKmizhUcO37xwEaSSuA==
X-Google-Smtp-Source: AK7set/vphJcdhdBi5i9v59LFbtq68qVsyrK5pUZtFl0htn0/p3pDul2S7SLk585kNGfAt6/9NcTwg==
X-Received: by 2002:ac2:5143:0:b0:4dc:4c53:4466 with SMTP id q3-20020ac25143000000b004dc4c534466mr960040lfd.37.1676551763729;
        Thu, 16 Feb 2023 04:49:23 -0800 (PST)
Received: from localhost.localdomain (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id z9-20020ac25de9000000b004d39af98af6sm284197lfq.81.2023.02.16.04.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 04:49:23 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm6115: Un-enable SPI5 by default
Date:   Thu, 16 Feb 2023 13:49:21 +0100
Message-Id: <20230216124921.3985834-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

The commit mentioned in the fixes tag erroneously enabled SPI5
unconditionally. Undo it.

Fixes: 25aab0b852d6 ("arm64: dts: qcom: sm6115: Add geni debug uart node for qup0")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 15811be82acc..5a8b4c334997 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1085,6 +1085,7 @@ spi5: spi@4a94000 {
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
+				status = "disabled";
 			};
 		};
 
-- 
2.39.1

