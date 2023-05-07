Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D633D6F97EB
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjEGJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjEGJNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:13:07 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E13192;
        Sun,  7 May 2023 02:13:06 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id E953CCED46;
        Sun,  7 May 2023 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683450783; bh=N+w7jq7XeEONyTDg1iFjOZ+41A3wQL7SjMniFaAAMjs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=GHogfyBMCuCtPytpym6kxvbfXYmQXgXanqBqynOJVkWth/f4zfqNZbdwzsCG0vjow
         YrAPawq8dO4j58PRmrEOZ+UiNIwSj8DHMU32w5dnCpsuBzh4wBltuw1eQlWrfjH5hB
         r8HStf/Y9IB8WR8WerI3QEgxzWAcfHYb5dvbtS/Y=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 07 May 2023 11:12:23 +0200
Subject: [PATCH 6/6] ARM: dts: qcom: msm8226: Add ocmem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230506-msm8226-ocmem-v1-6-3e24e2724f01@z3ntu.xyz>
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
In-Reply-To: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=N+w7jq7XeEONyTDg1iFjOZ+41A3wQL7SjMniFaAAMjs=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkV2ucx1260XKj8iQgsWYL36Tvoz+ZL22ms9O5o
 rVY2Mfy/hKJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZFdrnAAKCRBy2EO4nU3X
 Vn5FD/0fq/DQTw7hQB267BiTXJXPrsDu27z82VephJ8RV7XK0yP8uaNrk81MYLqxVa+pZD3cjY6
 /GdYfgwJ4+rRROyDQZGuEie11ZXeBePhmSosg3yFPwouuHuUJ9HKXjWRXGf1mbU86Ha2zydygMZ
 4dcRd+Qzf+saRnIWFJYL8/SlQ7sdsp+ce5LcT53wN/3UwAzvuNl2zf+hyAvKKkhaB7pPw3uxsVr
 HC3fSWoFpQax3xLuHLDnMfEDfzwn76NPBHLhVCAI3zbT2CW77jB62Yc49SXt7EuoHeGYWvROaPj
 m+J0haDtJ/tE955gAEpnJ4OlauK4fCcBLf8OR9XP0N2z7JXordyg0zS2QKgnJG6YRs4HbRzPcD6
 SPNxUXS6m7IkdcNd1HEHs5/xDI+F+tPrZdyYlh+aEm+e3pJN5BWbkbIKJGxM7+DyJpYjRdMCERX
 B/C0pVErf0tNi8Lx7U3Q6GXFtpyXDXFRYco7ZbNphr0zwh8/pHDArX5Uo28RzPtZKzJ2/rD6Kbd
 csMDRV6p+gENv0qs22YWy0y3xnhUK/h6qefY+zmkV67KrWMzzcMrtu1EN5R/mzRKbAIny/QpP3W
 rXp9bCZZya4WDcAG0I1HMMMpJbufUIhSGLXjMOVN/IWsZdNLxC7vfefwkq8zrQHzDDCQcmhzw/O
 IEjF8MF8I9YufMg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the ocmem found on msm8226. It contains one region, used
as gmu_ram.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index 42acb9ddb8cc..7ad073eb85c8 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -636,6 +636,23 @@ smd-edge {
 				label = "lpass";
 			};
 		};
+
+		sram@fdd00000 {
+			compatible = "qcom,msm8226-ocmem";
+			reg = <0xfdd00000 0x2000>,
+			      <0xfec00000 0x20000>;
+			reg-names = "ctrl", "mem";
+			ranges = <0 0xfec00000 0x20000>;
+			clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>;
+			clock-names = "core";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			gmu_sram: gmu-sram@0 {
+				reg = <0x0 0x20000>;
+			};
+		};
 	};
 
 	timer {

-- 
2.40.1

