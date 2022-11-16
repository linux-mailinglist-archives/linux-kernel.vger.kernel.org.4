Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BF062BA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238775AbiKPLBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiKPLAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:00:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A97023EBA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:39 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id w14so29224235wru.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJpNB4o6sq/KoJPxbv4+HnBkm66WaeN+eBfhYyJgn4g=;
        b=UeYzRKm/WhtHDkCjsXfmP7gUPfeiY7xA8g2hujjlhyX3DeE+PbdvVRoL+pald37lTr
         /g3n4PTJ3xewNd2bIDUjBsNLOqvBM6uas/KDPqND5VCGkNirUyLwXowDZUrNon7psvT9
         nCQCytL03SRgg1zzL34yafwk1GH23FEpkNv+0rWHiY6DmFjYMcLE1H+IXWkTDqX3/w8E
         A7GvFWgTnaJSemUFCsbBUNDAQF/85p/ueVyfyBozS3g93ylZ1VRcpSPzQJYGfb3OxR9A
         qWf2uI/5ur8kUonjwul4oYmHp+t9FKxIsGYCmc8fA82y5mSvCRYiTspWY0QDRLhZf3Mp
         U7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJpNB4o6sq/KoJPxbv4+HnBkm66WaeN+eBfhYyJgn4g=;
        b=xfwbaUtdvK6b2wQ1j1+duZobpP/Y6XhFzoTIo+yw+wn23N42mYUSgyHp9uwBgKPJ3w
         niVa8q6oKgV4iB2dAKPbNCLxdP9nWX3IGwvYBEPP/pGaRYNA/L8TUjQAPtiRMxupyzWy
         Zd2kjFsnPKUciKTKWcyGDSpRljBOIeP/ZcanvC/b+dYTMr7vBp8K0ejsi/38IijULyq+
         o+eaj8ZGPvQfzhYG96js0V1ZCInVQskuQ5ShI4pmYNY96ho/rltJwuIRILNNsNA41bC9
         YSQCnlFf6Fwra1HhnqONq73r13Sp/URY6WXNtLq7PJZQDDiEAFgGJI4wLb9E4ENzIE13
         y+TQ==
X-Gm-Message-State: ANoB5plukGiIXTM2DrR5a5yCLVs5kdS/xeus0bIckqyVxc22Xxd2f4qg
        e2uyp+i/dx0bjNGNvkMjUmMB6CjFY51SSg==
X-Google-Smtp-Source: AA0mqf5P1fAqx7LVazRB/UIa2Da3c2VrKrrT68FCZfvUAr+DHQjG4v5dxecYZymSaLMDkrjZkVa7AA==
X-Received: by 2002:a5d:4846:0:b0:236:5aa8:a07e with SMTP id n6-20020a5d4846000000b002365aa8a07emr13910605wrs.437.1668595717609;
        Wed, 16 Nov 2022 02:48:37 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id n1-20020a05600c4f8100b003cf78aafdd7sm1833012wmq.39.2022.11.16.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:48:37 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:48:35 +0100
Subject: [PATCH] arm64: dts: qcom: sm8550: add QCrypto nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221115-topic-sm8550-upstream-dts-qce-v1-0-fe750dfa90f6@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the QCE and Crypto BAM DMA nodes.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Depends on:

- QCE new socs support [1]
- SM8550 QCE bindings [2]
- SM8550 base DT [3]

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

[1] https://lore.kernel.org/all/20220920114051.1116441-1-bhupesh.sharma@linaro.org/
[2] https://lore.kernel.org/all/20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org/
[3] https://lore.kernel.org/all/20221116103146.2556846-1-abel.vesa@linaro.org/
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 07ba709ca35f..a490b705ce5c 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1372,6 +1372,30 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		cryptobam: dma-controller@1dc4000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x0 0x01dc4000 0x0 0x28000>;
+			interrupts = <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			iommus = <&apps_smmu 0x480 0x0>,
+				 <&apps_smmu 0x481 0x0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
+		crypto: crypto@1de0000 {
+			compatible = "qcom,sm8550-qce";
+			reg = <0x0 0x01dfa000 0x0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x480 0x0>,
+				 <&apps_smmu 0x481 0x0>;
+			interconnects = <&aggre2_noc MASTER_CRYPTO 0 &mc_virt SLAVE_EBI1 0>;
+			interconnect-names = "memory";
+		};
+
 		tcsr_mutex: hwlock@1f40000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x0 0x01f40000 0x0 0x20000>;

---
base-commit: a237afe452d9079aa024e465642b4cde0a04c7ff
change-id: 20221115-topic-sm8550-upstream-dts-qce-7f4fe79e0375

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
