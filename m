Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1069069025E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBIIot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBIIos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:44:48 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DC37F18
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:44:47 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso3346938wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PQYFfhPvS1XMnCTyI1izWMjlhb8SZHCdTPDA+HAHbo=;
        b=ufEpAtAVV50RYl4U3ECphhrDbUAX8E6N8askj6fthLaplFh62WakNZiAwkmw5YzmuQ
         sVa2rAmbxqHFS7dVxbSQK5rXoX0NsAuA1fS86f0itKqa0i9wXImYkXvqXYa/4NMWjUsY
         QX0DM0VLOxIVPlMwO/KjNstaDGGEJIuwSDQQSMz5kP5PfkKfOyaZQn+Xd6L7cKC7CZP0
         gO/fj3a4Iz5cmG3DCd4ZMBRYYqeHRrprNllY19e7Wpru2IKkT3Iz+ko4O1VmAez3ujkc
         w8h7Khd6uua5+hfB0Ybh023KNqXSp49ENAjjGuv3Ummzmo7lRzjW3sa08k6ntqcAjLxG
         luUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PQYFfhPvS1XMnCTyI1izWMjlhb8SZHCdTPDA+HAHbo=;
        b=it2gzQsFSYOdb3d3WEHACoKguids+yjKpRO4a89N1FrXAIR50T+CA6PTV4+QW98y/v
         nJsdHBpdQ1t3ysbRxjxxfcddOQMIMI4saftJblgfDtP8aU4iD0k+aVckLtbHvG18jdly
         i98aLTD0hNET//zVD9RPdMkG0YkvxTYVlpWT3m9EJJVuminl/jqEM2laChdMmNWG15V+
         Ar101ZRhi1KFMXsoGQnTJ5uW4lOLqls3nD0eJ60ZU3i91c/w3stSpujgMfgKxVA4Ju04
         fBrUYlqv6ct7iuhlLLzOknNP0nzB6w6O5xvMai4CO0WxIm810qGCHEVQnqtKQ1HotRZ1
         NziA==
X-Gm-Message-State: AO0yUKXi3syp+oqLzhBT9wrBudBot7s9MjfgTvDVvAebsIqspNCzeHsb
        w0X6ok8NIVmIKQUA/pY0vcYB4g==
X-Google-Smtp-Source: AK7set+sG7tpdWpQpa7p6C6ykijC1sZ0How8x7QFLJ1pZ/7zzL2u9Bflc96JeroZ0T6tjEq0h2YwDw==
X-Received: by 2002:a05:600c:4b1d:b0:3de:3ee3:4f6f with SMTP id i29-20020a05600c4b1d00b003de3ee34f6fmr9514830wmp.8.1675932285607;
        Thu, 09 Feb 2023 00:44:45 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c379300b003b47b80cec3sm4146392wmr.42.2023.02.09.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 00:44:45 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Feb 2023 09:44:43 +0100
Subject: [PATCH] arm64: dts: qcom: sm8550: remove invalid interconnect
 property from cryptobam
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230209-topic-sm8550-upstream-cryptobam-remove-interconnect-v1-1-84587c7bad0f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAHuy5GMC/x2OwQrDIBBEfyV47oIxtTT9lZKDmm0jxFVWE1pC/
 r1Lb/MG5jGHqsgRq3p0h2LcY42ZBPpLp8Li6I0QZ2FltBm00SO0XGKAmu7WathKbYwuQeBvadl
 LYkx5lxU15JCJMDS4un62oze3wVklZu8qgmdHYRE3besqZWF8xc//ynM6zx/4Cx7NmgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect property is already present in the qce node, which
is the consumer of the cryptobam, so no need for an interconnect property
as documented by the bindings.

Fixes: 433477c3bf0b ("arm64: dts: qcom: sm8550: add QCrypto nodes")
Suggested-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
[1] https://lore.kernel.org/all/20230207-topic-sm8550-upstream-bam-dma-bindings-fix-v1-1-57dba71e8727@linaro.org/
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 6ff135191ee0..206056890100 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1858,8 +1858,6 @@ cryptobam: dma-controller@1dc4000 {
 			qcom,controlled-remotely;
 			iommus = <&apps_smmu 0x480 0x0>,
 				 <&apps_smmu 0x481 0x0>;
-			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
-			interconnect-names = "memory";
 		};
 
 		crypto: crypto@1de0000 {

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230209-topic-sm8550-upstream-cryptobam-remove-interconnect-4a1d59b263a5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

