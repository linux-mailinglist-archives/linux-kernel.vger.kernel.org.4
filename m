Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AFE6BD1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjCPONX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjCPONK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8513689F2F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:07 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id z5so1831767ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8raBTXfySji8fpCPLBYPhkx+Ml6mdyfbjzhF4yIreP0=;
        b=azxV0C7ElI9nuIrzcyidvF7wgMwRjrYpY0h3aDMacTQtr27ionpn4UIG6e7iJ55i6C
         +gN0i6O6HGBVpaTf1OQ2Ku8d+g5jDBPI2DNV6HVoUer4aNZ79cJltykl/9VlvKinM2iK
         0ekYHVYFjtRhraNTIswyN17bFotw4ZKNm70U7WS7+Z4zp5tlGErso3sdtCXHXbtf0cO3
         y/Mk2MXFcKV5vOJzqf8m/2iFqY3XM72P3RCywjy5mIevJICr5G6tsYnaI0vQ60VZoQqO
         ptInUSWaMFRl7ZuxhmFjiyf0ztk5dHPzlt+hWBuO5vy174976jqRU4J3Sxg5HZqB6pGE
         qMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8raBTXfySji8fpCPLBYPhkx+Ml6mdyfbjzhF4yIreP0=;
        b=G7REw8Xpo/YDDoj3f242SCsAFkccJdxESJkn7OdoG7dfQQNC/9K/35LnjaOr1aPUBN
         hhclD2xJ2Vc7pvp0WHBFzgWIba+Va4ceg3R43tnwci8sjeHCmxY0b83Z25tfeg1XeKYf
         X8OdzV0f0aOqgITOVZlrcNYUSpCpXRut/hc1Nt1rSp8hiLhvQiwNssBeDGRaOsa/oa1j
         wQu1fECpaXTw5vFi2y4vq0WyMT9ve4/WZ0yhSongnFZK4tWvceYHG13l3z2ZH3lb8G24
         y+nzVPHw+nQJJEhhoRebKObYp77Ink6PxnGhtR1pM7niYEFcUKDBGaiBneHEOMgVw5HN
         jBsA==
X-Gm-Message-State: AO0yUKVRjK7twRitt7JnwbuXzEKBtGwjMPlqIk7SKtJ7L+6JilTwYDj6
        EbUokBbBTedvQp3TaFmrflw7pw==
X-Google-Smtp-Source: AK7set8TUH1Gft3ha6FOirDCP6FOLXq32NPtBNRJjeOI4lUYMguEYQtUAO/4c/EPiSZ3Iy21WVSPbA==
X-Received: by 2002:a2e:850d:0:b0:290:8289:8cc8 with SMTP id j13-20020a2e850d000000b0029082898cc8mr2002890lji.22.1678975987062;
        Thu, 16 Mar 2023 07:13:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:06 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:53 +0100
Subject: [PATCH v2 04/14] arm64: dts: qcom: sm6375: Add RPM sleep stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-4-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=761;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DKx+rSMb2n+6CPR4L2fodh6IzfCfn+ctrSy97qX3zGU=;
 b=kgTjRf+0MZH83jHV0+hWfT5jLGkzIuDSYLc2nQr1s13EaX8qETr6kQs7C8nt53DKqE14Vs4CKI87
 dFLEuKAqClp7xo7Qh9Lv+Zic8bOij0SKVMfKLQ0Tp1FCMygSzx5f
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

Add a node for RPM sleep stats to enable sleep monitoring.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 31b88c738510..de5882c0ff81 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -718,6 +718,11 @@ rpm_msg_ram: sram@45f0000 {
 			reg = <0 0x045f0000 0 0x7000>;
 		};
 
+		sram@4690000 {
+			compatible = "qcom,rpm-stats";
+			reg = <0 0x04690000 0 0x400>;
+		};
+
 		sdhc_2: mmc@4784000 {
 			compatible = "qcom,sm6375-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x04784000 0 0x1000>;

-- 
2.39.2

