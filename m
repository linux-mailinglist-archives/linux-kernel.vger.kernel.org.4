Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E834B62BA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiKPKzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiKPKy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:54:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04BF2D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:16 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j15so29247326wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xjfAlgkUXxYtzoLU7VIB+TYqOioSKKQPDA1pUqCpVu0=;
        b=cU1vl1wb9/+TR+df56vzBSep6BtCgw/w1ou/y4xJ01/kIfP781OY1I1bx2P3rCOEPT
         KRP5pITCwoBCJUnyMlUKvSiM0D4tk5qzZzm+Kwb29saYC58u7vCPsNYcqyyGhKLl4zkb
         ecJj0gF9PHuETu3hBnE/odbCda01pwpkCa2OcRD4TBbTwL4M4K5a316eY6NqAuc7Qx69
         gIS5gDNd4M/BDthkDa7y6oxG2Aqi6dDhrqWfih4kmiwMs7JySUpb47mmPmBU632jmZFi
         srcpsV+qm5P+fWDDXVOS1wPHcNvXVqkLbSPsWIvSljncS9BUOaNKfAO5r0vHVLFhmDFx
         fgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xjfAlgkUXxYtzoLU7VIB+TYqOioSKKQPDA1pUqCpVu0=;
        b=tX+pWqNzzS/ZmHzoFx142hg7GhEcuIBUFmDnkxizVjqjie5wvApYEt8hZhBqtLTotv
         2uYSBcBqPYcVnAq3B1MjJhGaYXqXv9J6FgpvWS94DXe2kwQmtDjj6vD/yCqyqjOUEcVG
         qjy0253FdZVgUb9y93lci5uxVUmvwdaZBgFJRiTFGjap74bR1zWf8ktzxgxUeRQPa6jw
         MaVJYNKnpbyCcErpT28QCwSzTGl74EGZGdsT+XsvyQFYacXYvU35HmjBIc8E7c0ygmXl
         4V0qtXnJcJQRE3PUjidiXWpAL/J7v53GAVkT9Y0Cl4JXOeZCoLwwj09ufZHza8KQXGw6
         +KXg==
X-Gm-Message-State: ANoB5pkYCASWCQ5nPvEYRSDiNAaOEAkHiKPnds4gw0m5eUN+DbNE88FC
        V5YyyvZuxK6Vydr+ie1zCmuIjQ==
X-Google-Smtp-Source: AA0mqf7CV+Kqd4WkRCfWQMJorXUGaiEDIGHXzxMqiN1OWEBRsS2gYX0FVGNL8cOqVh1s/xZtDg3+Qg==
X-Received: by 2002:adf:e444:0:b0:236:489b:8c81 with SMTP id t4-20020adfe444000000b00236489b8c81mr13518978wrm.649.1668595394849;
        Wed, 16 Nov 2022 02:43:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t8-20020adff048000000b002238ea5750csm18010846wro.72.2022.11.16.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:43:14 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:43:12 +0100
Subject: [PATCH 3/3] arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp & mdss
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-3-379eec11d841@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v1-0-379eec11d841@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

Add the aDSP, cDSP and MPSS firmware and "Devicetree" firmware paths
for the SM8550 MTP platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index d4c8d5b2497e..be06e25409c3 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -376,6 +376,24 @@ &qupv3_id_0 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	status = "okay";
+	firmware-name = "qcom/sm8550/adsp.mbn";
+	qcom,dtb-firmware-name = "qcom/sm8550/adsp_dtb.mbn";
+};
+
+&remoteproc_cdsp {
+	status = "okay";
+	firmware-name = "qcom/sm8550/cdsp.mbn";
+	qcom,dtb-firmware-name = "qcom/sm8550/cdsp_dtb.mbn";
+};
+
+&remoteproc_mpss {
+	status = "okay";
+	firmware-name = "qcom/sm8550/modem.mbn";
+	qcom,dtb-firmware-name = "qcom/sm8550/modem_dtb.mbn";
+};
+
 &sdhc_2 {
 	status = "okay";
 

-- 
b4 0.10.1
