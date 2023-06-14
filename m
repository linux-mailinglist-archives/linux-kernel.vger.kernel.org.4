Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E3472F5CF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242879AbjFNHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243454AbjFNHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:26 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92101FD6;
        Wed, 14 Jun 2023 00:16:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726977; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yd6xFIrgt8oo8FWpH6sxmqxA584pYs5ODxxpmfnI9tFV5sIpQrHm6yISEow5XN8YCE
    Nm4agIipW5oSKtqPjnoWqq5IxEAu4BdA8IYvsSMmLbXDOsUQMS7kzuM0YkLd7Fx04CYD
    2oG8VSdfi8miHfncDfUZItubr8CQTsnNwqXQg1Qy2gqGunsTOaJPULZLgTnzM3PpRPpE
    B8MK402aL+aMEA1Y7r1YkGnwlaaP5UHLedSKNbjnTf7G9w9h7eePKCBiFIh9sURXEmam
    uINZvCirSYiDEyECm5sG9BdB02YwYDYc9mSEudCYY+VcNblEWZu+DyQEkl7YDCnTs8vQ
    pGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=SnuT9mNjf2+O/dYCq7swKzDbiqXYWdUY1V2NxdDwNUs=;
    b=I1p1qNLwM1rjiZ+y8a6hwKE60oh3fzs17CTbNbI/Drh0ABHcq6mA6aXVE0rsvq+fim
    E8rZypr1S5iI2fKGm0kl1U2adWYQUw/fMjeBulEx90Z5sXHTeF9DnhsjTNUYaQO5lA48
    R1TUgetnQ3dcxzD/hdDbH+cvoAUrOVuMSTpYdkyBR6qf/Eu7VgYaLJL9pHz5XqoNKcLO
    EIDl5+rHa2rwOj3+0Qw5twoeR6vcPDXqeuCgvHgNSupHXn7JKQ4HfaDgLm+H9XDTmZ92
    MmSsTObPGz2Ro1dcmDpbYN940FGmGSebrqFJ+oQ3rTiRNw2qviYYPC2/XNi1HMA3apUH
    Ry2Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=SnuT9mNjf2+O/dYCq7swKzDbiqXYWdUY1V2NxdDwNUs=;
    b=PbUKfGwzVpPoLtoRM9dAxBYinZRYGLpxBuKEHdvmFEoGDnnpxt6lnU/W+nXJ6POGHv
    8T+VPzGa7+n4+Hdka5bEbIpNJiyHSHBBkIHmtJAujZY4XDUyycWL9utjRgylRoR8++pE
    7XUUg2VT2w3gFXRFAe76helMAJc+tpM+nlHhL+f4yHU8RmNSIncOIdKBFw9/UJ/OXzv8
    1aHNk3y7r4z4q2SjXwfKTXBHMX7IY8vawGQmS4Nzs2PHzHe2VFFZJHfnLIxPJEOKrtLb
    fCzl7CNFUoqG1OXaNEioihy1F+7VlwvCRd5LTJhILeukbhBMI7Iv/U+FDxNLxy+VHlMz
    Y9QQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726977;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=SnuT9mNjf2+O/dYCq7swKzDbiqXYWdUY1V2NxdDwNUs=;
    b=DXiqCf05kcnSTsXUqiAnt/u7OhnpoC2IxAIC547HFddf7OSzWccliUP0vHublmDppi
    xYHlOCoyVXUYrpE/VpAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GHb2c
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:17 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:15:59 +0200
Subject: [PATCH 1/8] arm64: dts: qcom: msm8939-pm8916: Add missing
 pm8916_codec supplies
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-1-a3c3ac833567@gerhold.net>
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
In-Reply-To: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update for recent changes to pm8916.dtsi in commit 38218822a72f
("arm64: dts: qcom: pm8916: Move default regulator "-supply"s")
and add the now missing pm8916_codec supplies to msm8939-pm8916.dtsi
as well.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index 33e02f42f5e4..503c2dd5fe47 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -25,6 +25,12 @@ &mpss {
 	pll-supply = <&pm8916_l7>;
 };
 
+&pm8916_codec {
+	vdd-cdc-io-supply = <&pm8916_l5>;
+	vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	vdd-micbias-supply = <&pm8916_l13>;
+};
+
 &rpm_requests {
 	smd_rpm_regulators: regulators {
 		compatible = "qcom,rpm-pm8916-regulators";

-- 
2.40.1

