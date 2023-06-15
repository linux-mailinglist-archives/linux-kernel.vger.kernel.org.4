Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2A731FE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFOSSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjFOSSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:18:06 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142BB1BF8;
        Thu, 15 Jun 2023 11:18:05 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 01090CE6AF;
        Thu, 15 Jun 2023 18:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1686853053; bh=ugMipXK+nPc+Xd0ZaX7mPO2A2Ca+rG1kX4NQoi4EwMU=;
        h=From:Date:Subject:To:Cc;
        b=Uj8RyxvN70jrrEHAuk2KK9V0OuGn6s831dQ0WoGRgG8wRr/lS6QBvWx+fC77B5oE4
         S7s6BSOSNTvThYvB8Idbbz6XYUieym7uL/Elki7k6/LLmZ2nORFl6NDQigh0hVhHeK
         YDzPYoqbGdFIg8gLdL2xOTGr7TcHO7DYE2og5w1M=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Thu, 15 Jun 2023 20:17:12 +0200
Subject: [PATCH v2] ARM: dts: qcom: msm8974: correct qfprom node size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-msm8974-qfprom-v2-1-3839cf41d9ee@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAKdVi2QC/3WOOQ6DMBREr4Jc5yMvYUuVe0QUxvkOLjDGBsQi7
 h6DlDLlG83TzE4CeoOBPJKdeJxNML2NwG8JUa20HwTzjkw45YIyQaELXVkVdxi0830HOasUxVL
 zHBsSpUYGhMZLq9pTG1Ts/JQ8ZekKyk3a43CWnUdtlmv9VUduTRh7v15nZnamf3dnBgyqIpOSY
 oa0FM9N2HFKl3Uj9XEcX5LdFmbZAAAA
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=CEB4c/s6J/pZAcxWuRvn233hJFsOJA018x2AsQ+Iqjw=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBki1W60QkmzyTC110njYohlKqolQLQCLjeMCCui
 Z8scKBL2yWJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZItVugAKCRBy2EO4nU3X
 VhmOEADR5SRR416eXnGqX21q7pqrOIjGCMkg+sG82eO0rF/W/c5xD6Zh3n2Rw+/MNZDxBbOGDxI
 fhdNVfdWPeDSySSGJWhJlu+jWeA7VI1rp/5Poy4wwq617qSatFhnfT/wuj1+GdnHM+XQ+qlq0s3
 uj7GUOxEwufePdMFhW1es2caQqCH/jhlNL9e2ArscNK68KwEZyrsrjXjkHuZuEW3u0UYMTvlJDS
 WNDbfZiNLm/gnxBlh2Kpuuhs9HriBSDWF2599eRoWMWx+cRayV4a7TkC8AeIyBhlcAIQwD5Mn1I
 ZYPN4x8CQ8A9umfN7c5+Aj/KRZc6CmFGAxcwL8W9RSP0Fkp1MvgqQ7b7Jro2WSWh4xgJgvEytDy
 kODWBFDE4AyhrgNFHLcS+vYtN35iXoYkj5KGW2PlnNDV84MINWT1f5EKOxMdcJinrTG6r3S1HLC
 EUmn3qFA3nwobuIxiEZJzGMtZYuXXYYDTPaHngzUgknaWXGaR0+YvS+HBbAXCTgO7tBvQvB/u/A
 yZ5TbEHDZMB4yeyLWsLNnklADTSIXifXGyuClvbqeLTd5RGq6KWEXE1wVd5sWrDUXH12iyPnjLw
 hlEEqQHbhuI3K0aN3Mi1BKeKfgbQ6wrARFkchmPdoujiYpoITe3oLmTiu1XcAeA+66KmeNkNOUt
 VEYYLnQcpk6g3nA==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Craig Tatlor <ctatlor97@gmail.com>

The qfprom actually has size 0x3000, so adjust the reg.

Note that the non-ECC-corrected qfprom can be found at 0xfc4b8000
(-0x4000). The current reg points to the ECC-corrected qfprom block
which should have equivalent values at all offsets compared to the
non-corrected version.

[luca@z3ntu.xyz: extract to standalone patch and adjust for review
comments]

Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- Keep base offset but expand reg from 0x1000 to 0x3000 (Konrad)
- Link to v1: https://lore.kernel.org/r/20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 7ed0d925a4e9..3156fe25967f 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1194,7 +1194,7 @@ restart@fc4ab000 {
 
 		qfprom: qfprom@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4bc000 0x3000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 

---
base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
change-id: 20230130-msm8974-qfprom-619c0e8f26eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

