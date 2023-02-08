Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5DC468EEF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjBHM1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 07:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjBHM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:27:36 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D54AD2D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 04:27:34 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id b5so19061968plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 04:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3pZYKYfkdSQT68SJNCftLQUT8dA3bIPuHLgF4x+0BQ=;
        b=eq7qxSBzge3b5OUiBBoHYkNnBBuhl1834PkVvMDIKLtdfoKGbdd2ABIFHVDNbdM6P1
         V4+jZV7yalvVafWmhYJiwYEym70qSx5kSseejBwBkoISzOzgPbosW9+jXXtYApQVd8fT
         +IAJ2nm4ALaSV7k9KDd2moyrybb5VbRC1ig61kwmrAhhnd2ZgZVPwMD42xIR+l5Nh/wH
         upHICVogu/Kj8t2Fvuv2+kgiRdHh5GrTHkDALZ1BpR0IpfdfiW28C41QEL0tx9vzu4HR
         2JsltAWvcXvhOjqx8p2ywxr+hyo+dMdLB/E4RDxN57/RnseiN7Yy2Gm/veOgUA++c8rR
         YN6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3pZYKYfkdSQT68SJNCftLQUT8dA3bIPuHLgF4x+0BQ=;
        b=xWm6Hhrni8SRw/W0Nm7JciQATRZDu0+PtSAT8HQa4PrXXL6EiptphtM+WcBRykHx2Z
         IzWMtc6IFJ5IjCsAaZQbEHYtT2wQIyC+ffmGyer8iseTrv6d3u522iLzt2chqJ7J8B3b
         EUmeQvm8/vfftDkClA9hMdS3IfE+Yhm/zwZF7mK43csEjmeSJRXPixu8iNiOOiOoFaGm
         RD8WJRZJTtRdxL+QNKLMYdZI9pAKUSDB1riu2qi3L3g5wTjY6azOOaoIgO+818QWnrQ/
         xCJBuTih11gKamB4ODZb6LqshEw40lTLs92CqAHf/si+544/BjIRuGLD9wiKl94uLXDQ
         p7lQ==
X-Gm-Message-State: AO0yUKU3LjWggUvXNfmShIOx71X95t8bnsOFtbszHZur7AVbZSLfNgP/
        fqfmwe5ZvYGUqcsv574O+Yu5wA==
X-Google-Smtp-Source: AK7set/kTlTLW1jcI345R/bAzrSsgmJj8RuFZzJ86G7lKYbVI+rX1YXb68COYhPoZs5wpxzDuntA8g==
X-Received: by 2002:a17:90b:4a0f:b0:230:d387:8bbb with SMTP id kk15-20020a17090b4a0f00b00230d3878bbbmr8999731pjb.5.1675859254139;
        Wed, 08 Feb 2023 04:27:34 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:4214:7b1c:f777:96cb:1db4:73e6])
        by smtp.gmail.com with ESMTPSA id r16-20020a638f50000000b004eca54eab50sm9664468pgn.28.2023.02.08.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 04:27:33 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm6115: Add geni debug uart node for qup0
Date:   Wed,  8 Feb 2023 17:57:18 +0530
Message-Id: <20230208122718.338545-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qup0 on sm6115 / sm4250 has 6 SEs, with SE4 as debug uart.
Add the debug uart node in sm6115 dtsi file.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Changes since v1:
  - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20221128171215.1768745-1-bhupesh.sharma@linaro.org/
  - Addressed Konrad's review comments on v1.
  - Rebased againt latest linux-next/master which now has the 'qupv3_id_0' node
    already in the dtsi file, so just add the debug uart node in v2.

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 50cb8a82ecd5..3eccfb8c16ce 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -963,6 +963,15 @@ spi4: spi@4a90000 {
 				status = "disabled";
 			};
 
+			uart4: serial@4a90000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0x04a90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				interrupts = <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
 			i2c5: i2c@4a94000 {
 				compatible = "qcom,geni-i2c";
 				reg = <0x04a94000 0x4000>;
@@ -992,7 +1001,6 @@ spi5: spi@4a94000 {
 				dma-names = "tx", "rx";
 				#address-cells = <1>;
 				#size-cells = <0>;
-				status = "disabled";
 			};
 		};
 
-- 
2.38.1

