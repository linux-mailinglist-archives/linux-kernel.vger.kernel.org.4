Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC1A64D8ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 10:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiLOJq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 04:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLOJqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 04:46:19 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAA9DFF4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:45:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id t2so6293984ply.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 01:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXo7ON+W+HqSzfMLSf0nu5/9om0aVHW6nmyC6DVkBmI=;
        b=dZA28vUGIdi/CiCSP2VYFhfx23LWLuegyKCalwVTHGro5WZFLR17OKfUhcbXGA5Ioi
         7RSjXdP1A2r9Owi30lSohWAyKNuPGn7omsSCW6fF8atrOEubFTCJ0NQaBqG4e+gE2OiT
         BIowE0P946MCGwn9AMw9B4VeLtgqjKeSY66zc2exXj/Dd4jlLT4o9IhJbhQLXDUVp8U/
         cylC0FgvcipHZiGtXJXbKR5KyiJawqQZ/Ech4REWzjDj8XuvNIZxJVLwZmrC6DQnutnq
         bLnhfj78gsuuXbltmyi7cAYEKDYQERYzuOGkUvsxjcEUeemepDmZ8BzBCdLHDOGSUGEU
         8N7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXo7ON+W+HqSzfMLSf0nu5/9om0aVHW6nmyC6DVkBmI=;
        b=kFWBt5DherIJ/eHcO/W9TPuZ9gt1iTjU0aLFnRkwqRKNmv01XM4+QQIvkIhSqXM235
         /sNSgVx4P+r8WVfbXB0W6Gxsx6jP36J+Ca804HV0Rmn22G7mdfgFkkPdkbFBKvuNshB2
         fq7O95/mjs95/1T4Dg9rFzBLf4fImNyUcy4fcblRK/hmUAIYzuRp5LqjWEuY1gpS4Vtj
         tqnp57zmPWlLo0DMntINEIMXBHqOXe6JRhjhj3zpurx0VzXQ/mT+XtprexXI4X80s5Cv
         6iWKWCX/rKCz0l8a2X1JD1S12wvxvmLRJ4dhf8EQ9vEW8d3jJaSlXOTAMzVvaR9+ZlKa
         kTSw==
X-Gm-Message-State: ANoB5pnsYj16Q+TAOMKsSMvBWhshONYAHrGNYKnzGCUBQurO1ThZxWmE
        UpIeNSByuJuTIi+o3YNQlrLOxg==
X-Google-Smtp-Source: AA0mqf4HrL2HAz0eDVrE2pNSe4QzWZ/dBNMC9Q1rYp30JcAFV9nbdE4U6guklHYjEnmhjQ28grVBsg==
X-Received: by 2002:a17:902:ce04:b0:189:323d:df17 with SMTP id k4-20020a170902ce0400b00189323ddf17mr31042344plg.67.1671097555587;
        Thu, 15 Dec 2022 01:45:55 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5f:4e45:ae49:8018:6d22:e5b4])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0018971fba556sm3342646plk.139.2022.12.15.01.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:45:55 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, andersson@kernel.org
Subject: [PATCH v3 2/3] arm64: dts: qcom: sm6115: Move USB node's 'maximum-speed' and 'dr_mode' properties to dts
Date:   Thu, 15 Dec 2022 15:15:31 +0530
Message-Id: <20221215094532.589291-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
References: <20221215094532.589291-1-bhupesh.sharma@linaro.org>
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

Normally the 'maximum-speed' and 'dr_mode' properties
of a USB controller + port is dependent on the type of
the ports, regulators and mode change interrupt routing
available on the board(s).

So, move the same from the sm6115 dtsi file to respective
board file(s).

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 5 +++++
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 2 --
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index fa57f4bf58256..3f39f25e0721e 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -229,6 +229,11 @@ &usb {
 	status = "okay";
 };
 
+&usb_dwc3 {
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
 &usb_hsphy {
 	vdd-supply = <&vreg_l4a>;
 	vdda-pll-supply = <&vreg_l12a>;
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index b5f7480c2e713..e4ce135264f3d 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1031,8 +1031,6 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
-				maximum-speed = "high-speed";
-				dr_mode = "peripheral";
 			};
 		};
 
-- 
2.38.1

