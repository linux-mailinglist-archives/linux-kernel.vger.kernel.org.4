Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1297671A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 12:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjARLVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 06:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjARLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 06:19:21 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E927169B3B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t5so29035297wrq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 02:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx2/zPduR9kyydYgB7n51yrhAvGD9FHDkQln9sB/Ijs=;
        b=YkynYi4wp/W5U2kj7v3/YAg8OKGKrA9QD7xlZ6nuoEWMOG78rbLDLgIJz2NU1WnI4s
         2TlXWW+1TyIzqcuUdnfo2+fjh+u1vgKdfV1kR0riw+XmfwxlRlEdp9xTIq7G3aKYojcr
         agBbBxYznwMSQDBHlWT3rp2DMST5cfCaIRdNihZpIH18TJsQ5iyBHeLkZg8Xu5pcskMb
         BWjK+KRMK05C2OGeAoXnRMtSNi/aDwX8Wp5K56EhJ0pHkgSQvWGXlO6VOsEa7DliV0VB
         o5DfjMEkzzp2x2hMPzlcuFvTbex/oczAXlDS9XnwcoglwsE+uBdIBMopxcef45bWYEmY
         zjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx2/zPduR9kyydYgB7n51yrhAvGD9FHDkQln9sB/Ijs=;
        b=6VTmzzoFAw9zz1miLEmQLgzOv4zBV3sX+5i9hUNagWehUdMoRG7TBTm5MfiqhVlYT6
         bAwKVkNo6mcFbIgE8lf+2XJIuAkM3cv+0GD/WYaKXSNa8j6t7hDGxLcq6+0niikyUrro
         kJfgGAJNInkgB9jlKjrIkJNu1OWtmmiz/FXqeFy+V2iZT8fdDVj4YqliOnosPWg4CGkx
         RHbsq4aMtSOPuQvKPcaY+ZVIdVeCpCbzB8iTjYtUzMcSMT2iHiDlI1wBbkuZXH41JNU3
         Viwxa/pLGAmaQEUB3L4vN9a4F7dGtbTcej4M1sbu+P490TrosYuLWUA9TeJ5wreOMRVO
         WHFA==
X-Gm-Message-State: AFqh2koR+77LxTKqSYIn7os9Uow61Ep4CTBeQjzO1CkJaAeIEIgCQNdY
        ssWSTM1bleeCdSdtCyndDwPaTQ==
X-Google-Smtp-Source: AMrXdXvslf3z1cVuDVN1383bkZcjnwwOVW03en/Xkj6ZCKWVzbgTKVKbjqSLWQEFD8GAN+UzdxcWzQ==
X-Received: by 2002:a05:6000:1f95:b0:2bc:371a:8a2 with SMTP id bw21-20020a0560001f9500b002bc371a08a2mr5990033wrb.37.1674038105466;
        Wed, 18 Jan 2023 02:35:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ba29-20020a0560001c1d00b002b065272da2sm10076731wrb.13.2023.01.18.02.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 02:35:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RFT PATCH v2 3/6] arm64: dts: qcom: sdm850-lenovo-yoga: correct sound compatible
Date:   Wed, 18 Jan 2023 11:34:55 +0100
Message-Id: <20230118103458.107434-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
References: <20230118103458.107434-1-krzysztof.kozlowski@linaro.org>
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

There is dedicated compatible for Lenovo Yoga C630 sound card
(documented in bindings and used by Linux driver), so use it along with
a generic sound card fallback. The device is actually fully compatible
with the generic one.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes since v1:
1. New patch

Bindings: https://lore.kernel.org/alsa-devel/20230118101542.96705-1-krzysztof.kozlowski@linaro.org/T/#t
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index d9581f4440b3..d55ffd69155e 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -511,7 +511,7 @@ dai@2 {
 };
 
 &sound {
-	compatible = "qcom,db845c-sndcard";
+	compatible = "lenovo,yoga-c630-sndcard", "qcom,sdm845-sndcard";
 	model = "Lenovo-YOGA-C630-13Q50";
 
 	audio-routing =
-- 
2.34.1

