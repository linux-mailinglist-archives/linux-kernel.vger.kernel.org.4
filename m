Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DA681938
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238285AbjA3Sbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbjA3SbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:31:24 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AD746D45;
        Mon, 30 Jan 2023 10:30:26 -0800 (PST)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AA6D8CD174;
        Mon, 30 Jan 2023 18:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675102888; bh=0Dr8kzc+XRr5dNSVrvnHxckyOzuvWhj6XIseX8RubjA=;
        h=From:Date:Subject:To:Cc;
        b=D16azt9T9bLignTgJ07fiBAdLPEaULiLYbb6+IuLW2/P2qErB6JI0Y5BbMXfTO+HO
         F7Y5/osagMJuNkmzjYwDyTVMcX902ioocpmf7lRDjpbP3/c7azwjLkAal+SLGGkVVO
         4XCRrwZo8zoDACifGj67PCLcaQsChRiwAwiic9CA=
From:   luca@z3ntu.xyz
Date:   Mon, 30 Jan 2023 19:20:56 +0100
Subject: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAIcK2GMC/zWNQQ7CIBAAv9Ls2W2AGmz9SuMBcLEcoLBEo2n6d
 6mJx0lmMhtU4kAVrt0GTK9Qw5oayFMHbjHpQRjujUEJNQg5CIw1jtPljMVnXiNqOTlBo1eaLLT
 Imkpo2SS3HFlxzfknupf9B11+eqZyyJnJh/fvPt/2/QvdljUxjQAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1418; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=xTrlk6QIwUDPatxqOUyG7LEgj/mkoRl+FjSk+cr9SJQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBj2AqjW0MExW5rjkpzFW2ONlWKbjwUW2lGAD0Q/zk/
 gnuUBFqJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCY9gKowAKCRBy2EO4nU3XVg5XD/
 4oonBTUFx+3ZyGh7WBhSUZ7X/FDrA1fL1E6sTEkh2ZWoH4f/Qzq1RrPGP06pD8ouFB68Fwjclnmp93
 otp8tWOlx/Q1WSWlpIOtNRRvtvbTfSruouPg84KE8wSHx63tNYJmAdX+4FVjgNhv8QJ1PjDywKoxAI
 rkfeCUkWLFyZCBr3YST1c6SdH9N4C8Aw8l419DrVjZWA+McDFmEPg/3zd5r5Szrw0hJgf/qLmv91Rs
 DOdCgFIhn35Py1GrLddrwYepTvnHdZ5+7XLGrX4ICQlTooO+ZB18wCvA1xY6zmasHg73XNJQg0Mtx0
 j407N9RixlM7c+aTSZup2t1xrPkluU1o+ylNUgMCPHeHkf+POHNdMkgoxyVFatv+kId+bhPdvn/hnP
 5xpBxhOUpadz84Q0afT5zAQmU1CTtd4U3U3xcwI9UpGqZcBrXo93KeUUw+eebEYlUUzRhsHbBtT5DD
 5x0x8I9KY6ABFjIAfAH7j1o8mEIk3u+cfOMDqfOPcqx6p+wQzCIUSSHvl9/Pp4NDm2MSkN6BLuuH91
 BlJnIDgT2K4L7879EbGGilxvuRrWVAxufu+71HvJJ9loapVgBmV31C2KcqvqegwnojvywXdlyZrFq9
 BfRJhdSYmU2fKEotq07Rse/luA7FpH9IVdlCV3Yoia8ziTLOwW22nVabLOpw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Craig Tatlor <ctatlor97@gmail.com>

The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
defined previously. Adjust the tsens offsets accordingly.

[luca@z3ntu.xyz: extract to standalone patch]

Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and qfprom nodes")
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 8d216a3c0851..922d235c6065 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1132,16 +1132,16 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		qfprom: qfprom@fc4bc000 {
+		qfprom: qfprom@fc4b8000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
-			reg = <0xfc4bc000 0x1000>;
+			reg = <0xfc4b8000 0x7000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			tsens_calib: calib@d0 {
-				reg = <0xd0 0x18>;
+			tsens_calib: calib@40d0 {
+				reg = <0x40d0 0x18>;
 			};
-			tsens_backup: backup@440 {
-				reg = <0x440 0x10>;
+			tsens_backup: backup@4440 {
+				reg = <0x4440 0x10>;
 			};
 		};
 

---
base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
change-id: 20230130-msm8974-qfprom-619c0e8f26eb

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

