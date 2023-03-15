Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919AC6BB5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjCOOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjCOOMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:12:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F93697B67
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x17so8352762lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678889497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IH0ZCvPL/3GU0CeiB2YhHJI9Er8cEK0jH1qxynvAopg=;
        b=PjKAf6X3eFI/0MCgnJCdHc9AL15IWihL5/Kw7NJ+krTegNtKwSiVRHpodRJMt0bVuk
         sNEaIEgdhCKPGXO76ZkgRAQMgqAJxGbx5dNwatztsZ/97indPCbHwadrlwz9CqFoW0Ne
         okyFFrhA57JJuYJaSdr2K2gnLjAx2WdIbQZFotLVnZQuy2RpYLE8C5t9m5x6Uf5dSonU
         glQ/2wGbxcDV89p0itlzWMTi8H6i9RFc3iirgGW2xnbrcnTPV7oYd0goN0Rf/KuWtMz/
         +MZTBtD4TPQKafC1r8Nx1i6s6p688crckHrXl3WJL+xUw3tXaQ/atnG39UQR05Dro880
         +K4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678889497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IH0ZCvPL/3GU0CeiB2YhHJI9Er8cEK0jH1qxynvAopg=;
        b=boJ8E7cuyVMfQGeV9vzV56pYXB67Qqj59/XsktgH9igddDp8PTMcz+QX1hoNZmdGDp
         HmpdMV5y16WF7kdBVKdcAqjvg9ueC1EReQ6tpW1ILc8sJNY1DTzEV3TTPAKY4tfqDw88
         LG7o9dE5+Gi0cwxPgOramtYeczv8/U7pQDPX74hYm2/afjqJjTqr8thZfkSMC+tJudRq
         TgZOstPeHdjXK3aLsIJqzD75yPk4GzYbHgDj0RuIjE6rqp/zmA/kh4nu7KrLSsNZkrNH
         xYs+O5pyajVazR/LjgRIaRJKBlYvQrh4jwUB8jEA3f8vzgvaTMYtF2TgiQ3wYN+GnKmm
         NxDA==
X-Gm-Message-State: AO0yUKWe0I4q2pU28GalDYRtq3saWpmGNlI3se7ezeGBEw15KdN0v0FE
        SZUHOCByODkmViqUKRkv+tZUFQJbJfS4FdanTA4=
X-Google-Smtp-Source: AK7set9/4xpsujgcrVzF+YSyF91LdK1odpZ3atDaQLKajYDk0IISydOJyU8ZDVTDJfIRV8IFT0Z4kQ==
X-Received: by 2002:ac2:508f:0:b0:4e8:44a5:6018 with SMTP id f15-20020ac2508f000000b004e844a56018mr1912896lfm.44.1678889497508;
        Wed, 15 Mar 2023 07:11:37 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id b8-20020ac25e88000000b004e845a08567sm824678lfq.291.2023.03.15.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 07:11:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 15 Mar 2023 15:11:24 +0100
Subject: [PATCH v3 6/7] arm64: dts: qcom: sdm845: Use the correct BWMON
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230304-topic-ddr_bwmon-v3-6-77a050c2fbda@linaro.org>
References: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v3-0-77a050c2fbda@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678889480; l=954;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IFc3qKQ/mzYt/DYUL06igVAb6D7fe/8j8f5wmJWco+Y=;
 b=GX6YCA+EVcASk66NmRcaCbYhYHJGj5/eoBll4XT8Qsp0Cl4XcBcXpzEzdmOzBaiZFF4WvXzWuxWZ
 oLsT6VFNC89txHmw/qTWlRNtC9Nvc2sw6rx+0aQtBSIBOl2TLwDU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the incorrect msm8998 fallback and use the new qcom,sdm845-cpu-bwmon
compatible to distinguish the CPU BWMON found on this platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 479859bd8ab3..1f2a97a20ef3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2241,7 +2241,7 @@ opp-4 {
 		};
 
 		pmu@1436400 {
-			compatible = "qcom,sdm845-bwmon", "qcom,msm8998-bwmon";
+			compatible = "qcom,sdm845-cpu-bwmon", "qcom,sdm845-bwmon";
 			reg = <0 0x01436400 0 0x600>;
 			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
 			interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_LLCC 3>;

-- 
2.39.2

