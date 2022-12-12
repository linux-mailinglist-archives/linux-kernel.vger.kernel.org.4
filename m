Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF32649D64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 12:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLLLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiLLLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 06:16:36 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222DDE1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:56 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so17934695lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 03:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTI6uu5AITYvREVqtOpKN7sGBu2v711s53EZQB7u+MA=;
        b=zcRtLnuJKvg90mpvevY4hb8nfKlac+QDrrVfXFhC2Ao33aGMVhCiroOpXY5TH2ktG+
         7+f10UrQksKkOF92vxAFJ6imaAQlanmoHJQYvd8UNRovy3t72JS46VNgnhpTK1ugP6zJ
         5EFOt1AgNXAC5oG+xJab61KqJ68u56zQdmQQOsqTyjZOwxGlEyRdyn4aHo0R2Cbsxl2Q
         sQXHQAugwYC682up155x6UqKYnKwUAFF8VXYXu2yb8EP3K/utSxtPZPxmoptsu0JNs4e
         tRwU8G0tHgYeogKA5AfOqn6Hbxcwu2jU/Y149V66zJI3hYichZmk7RC/VovZPpwOF9Su
         XB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTI6uu5AITYvREVqtOpKN7sGBu2v711s53EZQB7u+MA=;
        b=iXg819fSn6GLkEBW7AYfva6uNtcLoVPI92p5nkrtcL96sWLe9XNHDpOjVtLudsfxgL
         DTwmvpy+gaSm+ljVKbL0LNvqLTQvUc8Qp/KhXFYwEp3zn/a2SlDNK+62AMm6z79k0qou
         iR6m5TxilwTymJTKObUz0R62lL9HieMgBF2DrZqcrS1E/CoaRAH+SLk3vSH1eywKrpAF
         sSTHEbgLenANZz2iGADR91aNhNQONF18EkKJPRzdKCxby5/UKIg5skj+mDn+Jpk0toE7
         fSZ4d5HGnXkAN6WIdUnRrXH9My+K8p+dToIvZCT7pn+7yxaVVs0QWTwZzElRVZdBsXk7
         9M4A==
X-Gm-Message-State: ANoB5plJSW+BEQp06vBJ55tEyePGFA87XYzDSAzhVaFCViO7IJE1TDz3
        +U3tFsDHajNdbovkxcCKdG6rug==
X-Google-Smtp-Source: AA0mqf4lOOfs9IkU8vRv/jlzuukyaqPNhnw1tRbDvz9nnzxMoGKSraiUzQ+GGdYnEbimIY/2RrlOQQ==
X-Received: by 2002:ac2:4c49:0:b0:4a9:f2e3:3cfa with SMTP id o9-20020ac24c49000000b004a9f2e33cfamr5499171lfk.32.1670843456214;
        Mon, 12 Dec 2022 03:10:56 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id b4-20020a056512060400b004b57a810e09sm1599110lfe.288.2022.12.12.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 03:10:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] arm64: dts: qcom: sm8150: Use lowercase hex
Date:   Mon, 12 Dec 2022 12:10:36 +0100
Message-Id: <20221212111037.98160-9-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212111037.98160-1-konrad.dybcio@linaro.org>
References: <20221212111037.98160-1-konrad.dybcio@linaro.org>
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

Use lowercase hex, as that's the preferred and overwhermingly present
style.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 55b5709445b6..3f940cc3f32b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -927,7 +927,7 @@ ethernet: ethernet@20000 {
 			power-domains = <&gcc EMAC_GDSC>;
 			resets = <&gcc GCC_EMAC_BCR>;
 
-			iommus = <&apps_smmu 0x3C0 0x0>;
+			iommus = <&apps_smmu 0x3c0 0x0>;
 
 			snps,tso;
 			rx-fifo-depth = <4096>;
-- 
2.38.1

