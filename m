Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42FE6D9C49
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbjDFP0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239510AbjDFP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:26:03 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30EF83D0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:25:55 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g19so38177180lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680794754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jwso8CqMD9AGHGBLzSp/xS2037BXb0OXe0Wu07iPUOQ=;
        b=cA/bfLPj9+BwjNIqRC0zghZhU6bgLWHjXQwJz6MmGu3QnF6uAny7yFGb6gUAK0Uk5+
         eGwnzH39ZK75mleQ6YcSq9VXgfZhQGIajeoh6EsXd0EHELEDv3FqL7y6uF9rAwG6UtGk
         BV+wUN7SmS+mHdzBAlvhcb0kKOptn7ZfTirH74DHdAimg44O4LStFBXLepNqgtEJwMEH
         Q2P9i6wWFdTphkDa513cqhkSvxfN/+ZebPf4isxcuKwauXEYkT8vkZ4Y89ePgaotEe0p
         DlwZQflBWacu5/NZ1V+qZH2oYH1aFsdW+P7zoyZn++yhBuMDKjJkfopsnRoYrD6Q6uIk
         ODiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680794754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jwso8CqMD9AGHGBLzSp/xS2037BXb0OXe0Wu07iPUOQ=;
        b=4y6IzCQeApS2aYHD1NFpbn3eBb0aTu+jhxJmLV9bJRvQN8a1pZrXG0HVDcP8uVBsiZ
         rN2MKcbiNTI8MS5hKYUJhhePte7oooo+O75tEAVIbh075Up3fDmhyOTBdULI7asuq/Oy
         MOHFQRERFPT6MQheoiO4jKFqMCdfjfl/WcDBj4Dquj2dhGG4cA+TA4cwXE6vfaqWhlN/
         B6rCT9C/dWPFffkSrakDxSVxYB0LL2/UDnOsRcF/fRSGTppePbdpGRwe/KrDVxKg+bip
         agiTXJ2hurq/etSTZIfXYsVzeQ4IbMX5UoVSKZrQ15h/INLV2GRd11GwEpOkoWCWEreg
         wV7g==
X-Gm-Message-State: AAQBX9dRxl4jfkfa7Z5E1p8Zp4K3KxIXYD7KjbZGdjFNSxzLQGX3aQgw
        44hmvsIq48wuAO7bM7FjQBcSag==
X-Google-Smtp-Source: AKy350aVCrtbH2QN4u3ULqVcBzcc3Rj4cuJ2LPxL+8YdRjJLX6wp7mlc6IklNtrpx3ZZQ05cSLw8hg==
X-Received: by 2002:ac2:43db:0:b0:4cb:4374:cc78 with SMTP id u27-20020ac243db000000b004cb4374cc78mr3040252lfl.26.1680794754131;
        Thu, 06 Apr 2023 08:25:54 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id h4-20020a197004000000b004cc9042c9cfsm300103lfc.158.2023.04.06.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:25:53 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 17:25:51 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm6115: Add RMTFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v1-2-c73a5180e48e@linaro.org>
References: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v1-0-c73a5180e48e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680794750; l=1190;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x5MHZmqmlYV5OLUnYudsfP3G5g0esVKENrYXJUkL5oQ=;
 b=VVfhbTr+seJhYw5dXlK2ZZ/smRaMydn7EPAaLxiaGdLgCfiJtXPhhuQGGi98A5cb+iOH19h7/glX
 a5xxtdBvB3Ydn2SBKN6NJ5/o3bP7fXo0IV5/F6U9wM+Hn4xA1NLP
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for RMTFS and associate it with MSA and NAV IDs to enable
modem functionality on SM6115.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 2505c815c65a..99c6550663c8 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,sm6115-gpucc.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/dma/qcom-gpi.h>
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
@@ -290,6 +291,15 @@ removed_mem: memory@60000000 {
 			reg = <0x0 0x60000000 0x0 0x3900000>;
 			no-map;
 		};
+
+		rmtfs_mem: memory@89b01000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x89b01000 0x0 0x200000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA QCOM_SCM_VMID_NAV>;
+		};
 	};
 
 	rpm-glink {

-- 
2.40.0

