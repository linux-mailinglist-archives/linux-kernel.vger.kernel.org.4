Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B4F74F267
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjGKOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 10:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjGKOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 10:35:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBBE171C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:35:23 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso88573161fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689086120; x=1691678120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7822Zli8Tp5k/SZN6d8OwvrpyzkoEFi3QjuAaZmR3SA=;
        b=Huhm4XgNW75OEhw3a42sRrUuoix8e9mjt55v3QngBR/SLmqCP7J80/rmLfx8SeL7fn
         av2nBMZHP/qhsOPHwHKmW1YF1cYgu9nf7rHjPLTFLebfMGPAuR0ViIf7R/ske/uX9ZxN
         bLdemNdf6F1LMJduDvr0Vi/jQIhwLn+CsqiAe2PQeiyPv2CF0EJ+ycjMT0y9eDkRx914
         +MpSoA1zYqOH2m+qdyZSBvOx6fk6zGngJ2n2ZEd+4HrWlkwyoBl5qAf9D2aHPp7mIm1N
         HQaL3naVoz67Iq0lE5TjTyRsPajiiLxQ7eCKeRoFxuBRwR10d/n2X+UBt+0utwSukcYV
         cNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689086120; x=1691678120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7822Zli8Tp5k/SZN6d8OwvrpyzkoEFi3QjuAaZmR3SA=;
        b=aSsjkksqbKVfVY9g71jelixyENSoPWzym8bxZFLnSoGxKFKe5/58aGtrbKdZnmS4Le
         3mM9q7VHHvJJhskrn9TB8qtmXCi2h4FtuDAEMg40z7IH8ahL6sY7sHw2WU5Xgh7Fm7/l
         w+TxTDcSBo8ET3rJAxG3YOTZ6HH8HmgXNtDdMX66nHBNex0oSo5VBJMQa+cSZmMFj/di
         sqChMhzyV/z8Ty5WjR6po/6O+Xk+j8JJPuW5SCxiz/yt1jSteTpfdRrnAqESVR20JYvW
         wt4EVzKw6Xixv6IdNg36wDrVO/NYktzwnY4Gtq+YGCM1FMoSF5tU+UnXPnzOWbZz5MG2
         DmxQ==
X-Gm-Message-State: ABy/qLZ7QqWHu/IE1j8naNa5HzFW3cflo24w4q8vlkNw79AuUmYJAw4u
        RkRcLa8WPsUBWRqZkVRUfL8ebQ==
X-Google-Smtp-Source: APBJJlEtm3DcykOwcBkltVajL+9CvEs0dUWcZKqIaPepqBP5KYURx7Hji81DhV8F+gjg6+oXQdHEuQ==
X-Received: by 2002:a2e:b615:0:b0:2b6:a3a0:5f7 with SMTP id r21-20020a2eb615000000b002b6a3a005f7mr13241124ljn.9.1689086120586;
        Tue, 11 Jul 2023 07:35:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl96.neoplus.adsl.tpnet.pl. [83.9.31.96])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e90cb000000b002b71c128ea0sm484221ljg.117.2023.07.11.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 07:35:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Jul 2023 16:35:15 +0200
Subject: [PATCH 3/4] arm64: dts: qcom: sm8250: Add BWMONs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230711-topic-sm638250_bwmon-v1-3-bd4bb96b0673@linaro.org>
References: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
In-Reply-To: <20230711-topic-sm638250_bwmon-v1-0-bd4bb96b0673@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689086115; l=3475;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=AjSbQFowYEpEAVY6Ao5qGWn/ZAomBZOs9ZzqIelG35Y=;
 b=vewgiErH5HUNculf4ayVWQLYqVP3SzOhtfH/Uez+HWq49AESmrGxC4z6BnlRAK9IYaPJ5LNOC
 yFj42ej2mBAC1U2fHUUuaDD3aHylik3JYlO6804wl3j6/ko17hZE/do
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPU and LLC BWMONs (skip the NPU ones for now) on sm8250.

LPDDR4X levels are skipped, as LPDDR5 seems more popular with SM8250 and
voting for inexistent levels doesn't uptick the bus frequency, which
results in no increased bandwidth, which results in bwmon deciding we
shouldn't go higher.. you see the point!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 122 +++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e03007e23e91..80abd0bdc526 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3694,6 +3694,128 @@ opp-202000000 {
 			};
 		};
 
+		pmu@9091000 {
+			compatible = "qcom,sm8250-llcc-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0 0x09091000 0 0x1000>;
+
+			interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&mc_virt MASTER_LLCC 3 &mc_virt SLAVE_EBI_CH0 3>;
+
+			operating-points-v2 = <&llcc_bwmon_opp_table>;
+
+			llcc_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-800000 {
+					opp-peak-kBps = <(200 * 4 * 1000)>;
+				};
+
+				opp-1200000 {
+					opp-peak-kBps = <(300 * 4 * 1000)>;
+				};
+
+				opp-1804000 {
+					opp-peak-kBps = <(451 * 4 * 1000)>;
+				};
+
+				opp-2188000 {
+					opp-peak-kBps = <(547 * 4 * 1000)>;
+				};
+
+				opp-2724000 {
+					opp-peak-kBps = <(681 * 4 * 1000)>;
+				};
+
+				opp-3072000 {
+					opp-peak-kBps = <(768 * 4 * 1000)>;
+				};
+
+				opp-4068000 {
+					opp-peak-kBps = <(1017 * 4 * 1000)>;
+				};
+
+				/* 1353 MHz, LPDDR4X */
+
+				opp-6220000 {
+					opp-peak-kBps = <(1555 * 4 * 1000)>;
+				};
+
+				opp-7216000 {
+					opp-peak-kBps = <(1804 * 4 * 1000)>;
+				};
+
+				opp-8368000 {
+					opp-peak-kBps = <(2092 * 4 * 1000)>;
+				};
+
+				/* LPDDR5 */
+				opp-10944000 {
+					opp-peak-kBps = <(2736 * 4 * 1000)>;
+				};
+			};
+		};
+
+		pmu@90b6400 {
+			compatible = "qcom,sm8250-cpu-bwmon", "qcom,sdm845-bwmon";
+			reg = <0 0x090b6400 0 0x600>;
+
+			interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
+
+			interconnects = <&gem_noc MASTER_AMPSS_M0 3 &gem_noc SLAVE_LLCC 3>;
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-800000 {
+					opp-peak-kBps = <(200 * 4 * 1000)>;
+				};
+
+				opp-1804000 {
+					opp-peak-kBps = <(451 * 4 * 1000)>;
+				};
+
+				opp-2188000 {
+					opp-peak-kBps = <(547 * 4 * 1000)>;
+				};
+
+				opp-2724000 {
+					opp-peak-kBps = <(681 * 4 * 1000)>;
+				};
+
+				opp-3072000 {
+					opp-peak-kBps = <(768 * 4 * 1000)>;
+				};
+
+				/* 1017MHz, 1353 MHz, LPDDR4X */
+
+				opp-6220000 {
+					opp-peak-kBps = <(1555 * 4 * 1000)>;
+				};
+
+				opp-6832000 {
+					opp-peak-kBps = <(1708 * 4 * 1000)>;
+				};
+
+				opp-8368000 {
+					opp-peak-kBps = <(2092 * 4 * 1000)>;
+				};
+
+				/* 2133MHz, LPDDR4X */
+
+				/* LPDDR5 */
+				opp-10944000 {
+					opp-peak-kBps = <(2736 * 4 * 1000)>;
+				};
+
+				/* LPDDR5 */
+				opp-12784000 {
+					opp-peak-kBps = <(3196 * 4 * 1000)>;
+				};
+			};
+		};
+
 		dc_noc: interconnect@90c0000 {
 			compatible = "qcom,sm8250-dc-noc";
 			reg = <0 0x090c0000 0 0x4200>;

-- 
2.41.0

