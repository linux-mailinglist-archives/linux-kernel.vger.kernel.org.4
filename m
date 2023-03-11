Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC8B6B576E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjCKBWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjCKBWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:06 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D913C358
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:54 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so8952024lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lv9ffsMB9cvrQAQl78BbFisHbhS6V78XQlZQsZ3tAJM=;
        b=AtZmgykyjuBrfVIFZJblK5yWVFccA8Li0B18J8KWEclP6zw4CLk5iR8K2DPF+zlalD
         BFKaYmKtUHx5uwJNDJ5Cl3fM4GtDtOR1P8PDhiW79AeJ0p1tAJFCQptHC/jkh5Gx5nWt
         MtuKhSX9U6WiSe4Y36x1Vp70hnSTZ1w979AFkt8DGCey2Iolc5LBS3Lh0DDCnPZMdLNf
         dY6M3GCxHeZp0lnVj78lfQq/fkZnsfyIqCjXyQLdc1NVXH9dx6JYtJsMBK4MJElig9L+
         qoZOGDSxXNOr8+SXYv/0vnmI6nctymYOicUvHj198YdCLcBr9IgdJNI+GCMiOwuvh09y
         wVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lv9ffsMB9cvrQAQl78BbFisHbhS6V78XQlZQsZ3tAJM=;
        b=YypZgBIi/phwwPAGvMtcuwVYjo0PyU1GUQPVIb7S6X1dv9YTtH/KjgIRkaGww/4itN
         +XyFu8ajhPhaUZkiIKRSC2hnxqtxQ4Ujhf97pIs3LpL6fjg87VnbtchCp/OA1ELOw5w3
         rebbWdk4l1VekoeKNuKoXakeuhY/Ay5844Qai7+Hpn/6XBOSwf54UueLCR673DHCHihn
         3BAQtt9XpOWwxDeUnZI9pYq8fn+Bkp4Yir2xtExupOOQa/4E8+JgNeMgEGjcnrug+QnO
         jI5tQdX/2/d+uZwpgQbInF4ZphyQ60Fm3X4fMtx9XbpV+xfZxeIE+Qhm+hairWH/XTv1
         lh2Q==
X-Gm-Message-State: AO0yUKU4sdLoEN5OvtAVjyi/wiePEDEj6Fj3Yk/GBF1pbz+WAGLL1iXi
        OnDrJQd8dklbdAub/x/FLhCEYg==
X-Google-Smtp-Source: AK7set+ob5N1i28MCSXlM/r7hCI7/W5rIPxWISYn2nqirqW/y2vbTfXvUgbidDMbxaWuxne7FOb8gA==
X-Received: by 2002:a19:ac05:0:b0:4b5:5b36:28bd with SMTP id g5-20020a19ac05000000b004b55b3628bdmr1347255lfc.2.1678497713377;
        Fri, 10 Mar 2023 17:21:53 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:53 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:38 +0100
Subject: [PATCH RFC 08/15] arm64: dts: qcom: qcs404: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-8-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
In-Reply-To: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=697;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JZg07Z0Hetp/XyclPUnW2dP85TWCIAK/Cx2TQVH6fxQ=;
 b=CnqnFHIzRghZVqMbCq2D5DMLfi+8sP7XzncNERq9Z+Nd0i95Aa/Jbh1B/rXoqqBIwlF0Jxmhc0Ow
 UMyt5FlcAAa6oXIgNqZ09+FnhG+O1jYWVsfLp36nzHxacDwm8UNb
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

Add the missing compatible to make the node compliant with the bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
index bc2ed73afb74..474a042f89f3 100644
--- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
@@ -317,7 +317,7 @@ turingcc: clock-controller@800000 {
 		};
 
 		rpm_msg_ram: sram@60000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x00060000 0x6000>;
 		};
 

-- 
2.39.2

