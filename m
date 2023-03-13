Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89BC6B7DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjCMQee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCMQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:34:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318644608C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y14so13241870ljq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678725193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2frje31Y2fNq0lYe5DcH6dNkKqnLB8dR+H+Ds8PEhpo=;
        b=xQ7EJme0rZEWlpluRbdJkiXFvtEcRYsz/8xywyjaFjSD5YbbqJMinRGC8vxGoyvzDW
         OrVy6UCMZLIVIFRSI3N9bn18mZHjkWaJqnsk9jaKH2sJe2bLHEqPUcgyGH4FFST2CMKN
         FMElE8VlH04FPlX29dB+o/r+PIT2snDAnx3U4dak7AzTlvGMdAcbqs7e16h+I2HkJJTn
         rV+RtGlygNY1yZSDtG5Of3ubqpQR1QyT3szg/VrJeruX3XwDgA0z6PbswLddUEe6tax8
         aE3lT8sfVFRw6I4psm1Mmh7w7tFlcpsi8UMKDWX5hE6nLCWuRTzAPUZan/WvBJwcTx/L
         O1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678725193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2frje31Y2fNq0lYe5DcH6dNkKqnLB8dR+H+Ds8PEhpo=;
        b=s/d9LE4TUGVsCeKfploTjWy8mc1SI1QuhqsH9jblb1G//u5tPlTjFZQE87R9HtHnhs
         7jcfzXKj3P2on8f0ZoZnaJJ7LcQgNt2xcgoZW1Kn56V6UlyJCu53uHVMHx97pUwYItGE
         TjI+FdgJMODfyal4h3b6CCYeTgXlVsiYXpE0Z7Dp8UxjhUdMteMst1fGE5SrgzT4cBtr
         24OHfCSOEbUuoT5orTxESm8+Z/BN2iJHZ6V/TMnZE/Yg06iP0YFmj1E715Zkn7nFawo7
         6LeMxw6cVRd5sy3A68IHehtWXNR4aFO63afNNoP0iBFciLAxY5DLwuZV8oq7Xu+fCMKU
         v+UA==
X-Gm-Message-State: AO0yUKUM3cc2vA7BQR0OliNYRcQMZmORK3IkLnD6qresyzUVSDGe2ZvQ
        iYGH+33j17+1h+hbpZXQ4LU/1Q==
X-Google-Smtp-Source: AK7set/PMKuyRAOrmY81VkBc6HIS5XjMb4tGZu0zRXcsQnJ5g48OKx2dl/pOvCs7co4PV561KRZTqA==
X-Received: by 2002:a2e:2a41:0:b0:290:6af8:ec25 with SMTP id q62-20020a2e2a41000000b002906af8ec25mr9996801ljq.52.1678725193232;
        Mon, 13 Mar 2023 09:33:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id q62-20020a2e5c41000000b00295765966d9sm57417ljb.86.2023.03.13.09.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 09:33:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 13 Mar 2023 17:32:41 +0100
Subject: [PATCH v2 6/6] arm64: dts: qcom: sdm845-tama: Enable GPI_DMA0/1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-topic-tama_disp-v2-6-37ececf43770@linaro.org>
References: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
In-Reply-To: <20230313-topic-tama_disp-v2-0-37ececf43770@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678725183; l=728;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Zz0jpPtt5NqsJRQJ9rDZmNvMC4Id+uhckcZNV4HE0Dg=;
 b=gvUDcvkcH04zmmWJjOHgfleMiF7JaBRSbGVR+HMrS34+HwlZR5J5wvAWSjxyxbhnxfyx/4lKicgT
 MkXB7uBfBbLJya2stx7nx1PcjKrSsFSf4k/ojjL2T2NbFtGsTQPT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@somainline.org>

Enable both GPI DMAs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index 6a3da19c6b36..7d860c20149d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -420,6 +420,14 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 

-- 
2.39.2

