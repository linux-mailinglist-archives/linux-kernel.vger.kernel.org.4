Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCA26DB491
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 21:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDGTzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjDGTyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 15:54:52 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52722A5D5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 12:54:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id c9so45220890lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 12:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680897289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hc2CsV2PdwIrwzsquuwQ6o8Ebf/JgkdU7cj1UvOiFY=;
        b=QvQt0Ei+1MDhYXEJ07cnGLSac1IxZsgQMdLEILTL+nv/+Ks/4Lvaa4cLWm4j6nQp9L
         mGDwAyQIExKHg3wa/3GtozueaeeN67KgioUY05VLevyQMgj5ti2Cqjgm3krfDrcHsFwV
         KLcP9mqjtpfTGMyL94juV8bN4Wsf9kS/+NOtVNjTkuYJSJKXDqIVA9fvJ1GSTMN1ILBF
         eh8SGNJe6V6Tdpkfknv+D0p+xd3H9ha4z1ojcZRWKk6rBqGmGlXFmkivHsao/pVW6LmX
         fSiVaN+bmiRngu5fAPM8jmFcEKL/R6oIa7BrDU/rmVJFFMvZM78E5tlWSTXnV3ItxSsB
         n8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680897289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hc2CsV2PdwIrwzsquuwQ6o8Ebf/JgkdU7cj1UvOiFY=;
        b=3H23B1+9D7wJIX+U3FE+AQMiqt6ARqrD6GxfNuCngEkoWm7ygMUgUXd+9/CKW2H6NH
         Vi+7KAZxJ3bvqkgLlEan+6t7JU6g2Ux9n9JzZ0KxLc7P7pPzINqDiDki/lkaIFIbhCI7
         8Dii21gk6UCwHB9wTC2bZc+fbE5vj0pKkmKqnrWy2q4Xi1CE7rX+MBOIPoSXkQoGRLXO
         pVmFnwmTyoXd27n3n+Kr0jmIhB8rUcC0f39gsTR5Kf9jIfNMZOddU+w8XWTP8ol6ygKi
         fbdr1CzQ/oDgu3cKsSACfH0fKbeP1vFTUbp9kwTzCGoyvw4+P/XsTZfJ4zNUscPSOobq
         mSNA==
X-Gm-Message-State: AAQBX9czxJTR9+GRbUPPlYws8jlOD6ApTr6SZjEBP807jYjwgqY3z1To
        b1XJLFY1PhvLeZzMF5DiiEXSjQ==
X-Google-Smtp-Source: AKy350brwHhDHTUjaTh8oqttmQTVfaSdK6qmK4y44KS68oPBdw4iu1VqnPwG/ZS46VJHIxlcPiQgtg==
X-Received: by 2002:ac2:5094:0:b0:4eb:3cac:23b9 with SMTP id f20-20020ac25094000000b004eb3cac23b9mr764776lfm.9.1680897289310;
        Fri, 07 Apr 2023 12:54:49 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id u5-20020ac248a5000000b004d856fe5121sm839981lfg.194.2023.04.07.12.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 12:54:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 07 Apr 2023 21:54:42 +0200
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm6115: Add RMTFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-lenovo_features-v2-2-625d7cb4a944@linaro.org>
References: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
In-Reply-To: <20230406-topic-lenovo_features-v2-0-625d7cb4a944@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680897283; l=1251;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IIk+twEwz0LlHdxtIsrn9UJGLOCT8VZyIM/WB4QSvH0=;
 b=I9rgSh4Kma+lc/Zkd3I2PwnJjpRVICDW88ksWJU/j7VwMjJs4MCqm1bT39j3aVdu+jnXciLSG1Pj
 CxRQkMzUDTkGjcgbvNxsfMJQzXoTENCv6Wxik2nL2Z6arW/YRZv8
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

