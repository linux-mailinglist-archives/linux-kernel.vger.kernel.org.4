Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3986E66CA0A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbjAPQ7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjAPQ5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:57:43 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933412CFC8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:40:42 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id 207so5271249pfv.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7vIF0NjJ6ridtH0ycWroVl3ltM4BPIf60BYeD4BHAf8=;
        b=y/+xQBDp6bkar+9ESYuKOcaDmEFQ7m7LqYLtDjWGYzUVtK9j6CPldh/Bi22Xaq8GZE
         fh23EO9hOqIrZhPi4cz7ISNtOoAZe7X4RLB0Gd8ka6mmokRZWXsr6zMkItC6nYl8KuAj
         gfmUwtmujO3hwODKg3sw/QgY2cX+sgIXhcX4Yd0GKbF9SbYMJgbKYsYZDfK/jV9s2MxK
         X1+28y24uKMAESfGPZf1qPofWIkIOUqeYa01iyyCFYSzg88P7ZMf7j+lybfXjzNfBkXT
         xO3SFOpYkWJniIpRIGpjjHdxyXmlaQP8pbuNtt9380cM/6cVacPLBNwGFhXE9vDh4qZE
         eqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vIF0NjJ6ridtH0ycWroVl3ltM4BPIf60BYeD4BHAf8=;
        b=EL1RdMhhZB8zclSV6uc/mVVKxmjZm3v8aoHEnVpbs3bnnY1N0V1EBbmW8yJ+PqTjag
         g2p3u7hdLa/aXmIv1kkZ/mItifMqbVKLB8+saXrx+1GqWx7Ca8+UDSOrUqcdIbzbCeL+
         PuYrdXcGDH5YHC/Mh6/9jKkm/zGxwHJADLnyfVgK4wiYolp9sqNo8TOs6ogFVbPAqKN0
         XG2gURG2S51OEfTWBFNNQVy8NmoFvvNIegugRjOz9FUVtTpb1kLMraAyihFa7BH60Eb0
         Dnhea743A2wSwG2QEeI0haZoNc4RK9vkdkUxRI5YQXd2XbshTdglg+yrJnvYOuIb8dpk
         bYmQ==
X-Gm-Message-State: AFqh2kpLLrIHaSVRN/HJagLbklo8fD/hJGavN3yeUW9Hr2zYuoyg/HLh
        xgWSG+KsMYEmrn5T7bAQ3lQ3Iw==
X-Google-Smtp-Source: AMrXdXud/hPOa5OM3UjlwyHhhj5hXBJd+KwvF511PfNNMKNPph/98E6hBLiuVTX64Vo/aZvkxwXd4A==
X-Received: by 2002:aa7:9208:0:b0:582:fba:319f with SMTP id 8-20020aa79208000000b005820fba319fmr19045262pfo.27.1673887241444;
        Mon, 16 Jan 2023 08:40:41 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:63d3:2d69:9f71:187e:f085])
        by smtp.gmail.com with ESMTPSA id x5-20020a628605000000b0058bca264253sm4129083pfd.126.2023.01.16.08.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 08:40:40 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sm6115: Add debug related nodes
Date:   Mon, 16 Jan 2023 22:10:32 +0530
Message-Id: <20230116164032.551223-1-bhupesh.sharma@linaro.org>
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

Add dtsi nodes related to coresight debug units such
as cti, etm, etr, funnel(s), replicator(s), etc. for
Qualcomm sm6115 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---

- Changes since v1:
 - v1 can be viewed here: https://lore.kernel.org/linux-arm-msm/20230114210754.353912-1-bhupesh.sharma@linaro.org/
 - Addressed stm node ordering as per Konrad's review on v1.
 - Collected Konrad's R-B.

 arch/arm64/boot/dts/qcom/sm6115.dtsi | 612 +++++++++++++++++++++++++++
 1 file changed, 612 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 478c5d009272..08f93b1dc2f8 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1237,6 +1237,618 @@ dispcc: clock-controller@5f00000 {
 			#power-domain-cells = <1>;
 		};
 
+		stm@8002000 {
+			compatible = "arm,coresight-stm", "arm,primecell";
+			reg = <0x08002000 0x1000>,
+			      <0x0e280000 0x180000>;
+			reg-names = "stm-base", "stm-stimulus-base";
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					stm_out: endpoint {
+						remote-endpoint = <&funnel_in0_in>;
+					};
+				};
+			};
+		};
+
+		cti0: cti@8010000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08010000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti1: cti@8011000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08011000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti2: cti@8012000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08012000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti3: cti@8013000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08013000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti4: cti@8014000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08014000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti5: cti@8015000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08015000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti6: cti@8016000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08016000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti7: cti@8017000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08017000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti8: cti@8018000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08018000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti9: cti@8019000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x08019000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti10: cti@801a000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801a000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti11: cti@801b000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801b000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti12: cti@801c000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801c000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti13: cti@801d000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801d000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti14: cti@801e000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801e000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		cti15: cti@801f000 {
+			compatible = "arm,coresight-cti", "arm,primecell";
+			reg = <0x0801f000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+		};
+
+		replicator@8046000 {
+			compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+			reg = <0x08046000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					replicator_out: endpoint {
+						remote-endpoint = <&etr_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					replicator_in: endpoint {
+						remote-endpoint = <&etf_out>;
+					};
+				};
+			};
+		};
+
+		etf@8047000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x08047000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			in-ports {
+				port {
+					etf_in: endpoint {
+						remote-endpoint = <&merge_funnel_out>;
+					};
+				};
+			};
+
+			out-ports {
+				port {
+					etf_out: endpoint {
+						remote-endpoint = <&replicator_in>;
+					};
+				};
+			};
+		};
+
+		etr@8048000 {
+			compatible = "arm,coresight-tmc", "arm,primecell";
+			reg = <0x08048000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out>;
+					};
+				};
+			};
+		};
+
+		funnel@8041000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08041000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_in0_out: endpoint {
+						remote-endpoint = <&merge_funnel_in0>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_in0_in: endpoint {
+						remote-endpoint = <&stm_out>;
+					};
+				};
+			};
+		};
+
+		funnel@8042000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08042000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_in1_out: endpoint {
+						remote-endpoint = <&merge_funnel_in1>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_in1_in: endpoint {
+						remote-endpoint = <&funnel_apss1_out>;
+					};
+				};
+			};
+		};
+
+		funnel@8045000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x08045000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					merge_funnel_out: endpoint {
+						remote-endpoint = <&etf_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					merge_funnel_in0: endpoint {
+						remote-endpoint = <&funnel_in0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					merge_funnel_in1: endpoint {
+						remote-endpoint = <&funnel_in1_out>;
+					};
+				};
+			};
+		};
+
+		etm@9040000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09040000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU0>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in0>;
+					};
+				};
+			};
+		};
+
+		etm@9140000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09140000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU1>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in1>;
+					};
+				};
+			};
+		};
+
+		etm@9240000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09240000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU2>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in2>;
+					};
+				};
+			};
+		};
+
+		etm@9340000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09340000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU3>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in3>;
+					};
+				};
+			};
+		};
+
+		etm@9440000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09440000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU4>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm4_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in4>;
+					};
+				};
+			};
+		};
+
+		etm@9540000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09540000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU5>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm5_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in5>;
+					};
+				};
+			};
+		};
+
+		etm@9640000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09640000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU6>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm6_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in6>;
+					};
+				};
+			};
+		};
+
+		etm@9740000 {
+			compatible = "arm,coresight-etm4x", "arm,primecell";
+			reg = <0x09740000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+			arm,coresight-loses-context-with-cpu;
+
+			cpu = <&CPU7>;
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					etm7_out: endpoint {
+						remote-endpoint = <&funnel_apss0_in7>;
+					};
+				};
+			};
+		};
+
+		funnel@9800000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x09800000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_apss0_out: endpoint {
+						remote-endpoint = <&funnel_apss1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					funnel_apss0_in0: endpoint {
+						remote-endpoint = <&etm0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					funnel_apss0_in1: endpoint {
+						remote-endpoint = <&etm1_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+					funnel_apss0_in2: endpoint {
+						remote-endpoint = <&etm2_out>;
+					};
+				};
+
+				port@3 {
+					reg = <3>;
+					funnel_apss0_in3: endpoint {
+						remote-endpoint = <&etm3_out>;
+					};
+				};
+
+				port@4 {
+					reg = <4>;
+					funnel_apss0_in4: endpoint {
+						remote-endpoint = <&etm4_out>;
+					};
+				};
+
+				port@5 {
+					reg = <5>;
+					funnel_apss0_in5: endpoint {
+						remote-endpoint = <&etm5_out>;
+					};
+				};
+
+				port@6 {
+					reg = <6>;
+					funnel_apss0_in6: endpoint {
+						remote-endpoint = <&etm6_out>;
+					};
+				};
+
+				port@7 {
+					reg = <7>;
+					funnel_apss0_in7: endpoint {
+						remote-endpoint = <&etm7_out>;
+					};
+				};
+			};
+		};
+
+		funnel@9810000 {
+			compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+			reg = <0x09810000 0x1000>;
+
+			clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
+			clock-names = "apb_pclk";
+
+			status = "disabled";
+
+			out-ports {
+				port {
+					funnel_apss1_out: endpoint {
+						remote-endpoint = <&funnel_in1_in>;
+					};
+				};
+			};
+
+			in-ports {
+				port {
+					funnel_apss1_in: endpoint {
+						remote-endpoint = <&funnel_apss0_out>;
+					};
+				};
+			};
+		};
+
 		apps_smmu: iommu@c600000 {
 			compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
 			reg = <0x0c600000 0x80000>;
-- 
2.38.1

