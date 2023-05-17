Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4664A707120
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjEQStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjEQStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:16 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [81.169.146.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B97171A;
        Wed, 17 May 2023 11:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349341; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=sujEGaU2LtqwQEXig1SJPnzwVZjlI4/HdAf+ckkD4+gxIpLQlrbxeZEfsnqCcSDZhN
    LH2f9ZE0BL769WqPCBCDHdxcHRzu1FyUUPbRq9buW+XR2YuQq1iSjdM2zW2cbcsDjEFG
    L2KTElS2NdfJpmTle4jBfwZFp+pBDpJvr+XSWRkyYmOMMtKGF8dksg1+4rlEVPOnyNJ+
    rj2ax/prsoglzYAcLbcfW8pn0QcxCaQtys2QQD6Tl56jp9EVE0MWjVc7fQs0ftX5FNPD
    2DBNxJOqol1wFdwXZEJpxuKamqPoxZEKi9XcK2Bkt/qGjtqJ5uE2LSpPEEfdAusoX8zb
    U/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wA5JA5aTgG5tPkRsBk2d9ad8ys2Ecjc8lpm75dE5DTs=;
    b=S2G5G8siY9AKNYAOkcZtMY9AKStklC8iuNxd56tkNJ1zNcpD8t5gevtLTOx5DcGRz9
    9DFGenh2rL5f6ica+cU0LftGLWtrAnD5oGqC1pGgmV6Got3mz5RmV7sGUs3adwFL/kCe
    K1GUPZu/mwDLMo9zfTLcODbpBRA/K2MIqaFGmQaGoJ7OChfuuxzU3DBRiBrdxMz94YO8
    VdXrwqaFfHCsueoHy3mpjpacXPj//TkMiaPLCNS+j+UOne0kOpOxc5PzA2VZGLcjZQBz
    YRpsQtkcOWFBop0CMvIQYels9gdgkcVq3nDFJ9jQw5xMJixLIi6TKlY8/RMxNLdo8bq+
    gJVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wA5JA5aTgG5tPkRsBk2d9ad8ys2Ecjc8lpm75dE5DTs=;
    b=D/eh1UHOAi5S5ZulIwBZQR48JzrncAOA+eHiIcttyuQ4139i4tY2CYNdYVpRoogOVn
    lmaAak3GI8YT7qoXinFizlWSJp9qGxQSxzPk3JvFTml0A9eCPBgwxruGNBvj0XfocCMU
    QwZKi/XT03pl6x1q/yms71c6stEFf+dVF0YBYl5ffzSSXFml5JPzkZKkCejlqB0FsUO+
    wfP/sQ02tBCVPhZPQrTDNY9uZ44+ls3JI3SYyxJDhNbU/XUvFZj2nkDs3B4HeMKJJzqy
    Z/AFKJbZXlGnyzt8mrpphj7bhR0kHaJjRMHholU8wjejnvEkdIsDMOzpS+KligkDG1Vj
    3ylA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349341;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=wA5JA5aTgG5tPkRsBk2d9ad8ys2Ecjc8lpm75dE5DTs=;
    b=ABjxH+PkY/l5iS5ggLe/bNvhiAANxTd0N9RI+iccSlJw96s33oboyVfH9b1krr9f64
    dtSx8ctBnhVDkKDc/WBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HIn1BIN
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:49:01 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:47 +0200
Subject: [PATCH 8/8] arm64: dts: qcom: msm8916-pm8916: Mark always-on
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-8-54d4960a05fc@gerhold.net>
References: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
In-Reply-To: <20230510-msm8916-regulators-v1-0-54d4960a05fc@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the regulators must be always-on to ensure correct operation of
the system, e.g. PM8916 L2 for the LPDDR RAM, L5 for most digital I/O
and L7 for the CPU PLL (strictly speaking the CPU PLL might only need
an active-only vote but this is not supported for regulators in
mainline currently).

The RPM firmware seems to enforce that internally, these supplies stay
on even if we vote for them to power off (and there is no other
processor running). This means it's pointless to keep sending
enable/disable requests because they will just be ignored.
Also, drivers are much more likely to get a wrong impression of the
regulator status, because regulator_is_enabled() will return false when
there are no users, even though the regulator is always on.

Describe this properly by marking the regulators as always-on.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts     | 5 -----
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index ab8dfd858025..1c5d55854893 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -358,11 +358,6 @@ pm8916_l17: l17 {
 	};
 };
 
-&pm8916_s4 {
-	regulator-always-on;
-	regulator-boot-on;
-};
-
 &sdhc_1 {
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index b38eecbd6253..64d7228bee07 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -72,11 +72,13 @@ pm8916_rpm_regulators: regulators {
 		pm8916_s3: s3 {
 			regulator-min-microvolt = <1250000>;
 			regulator-max-microvolt = <1350000>;
+			regulator-always-on; /* Needed for L2 */
 		};
 
 		pm8916_s4: s4 {
 			regulator-min-microvolt = <1850000>;
 			regulator-max-microvolt = <2150000>;
+			regulator-always-on; /* Needed for L5/L7 */
 		};
 
 		/*
@@ -93,6 +95,7 @@ pm8916_s4: s4 {
 		pm8916_l2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-always-on; /* Needed for LPDDR RAM */
 		};
 
 		/* pm8916_l3 is managed by rpmpd (MSM8916_VDDMX) */
@@ -102,6 +105,7 @@ pm8916_l2: l2 {
 		pm8916_l5: l5 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for most digital I/O */
 		};
 
 		pm8916_l6: l6 {
@@ -112,6 +116,7 @@ pm8916_l6: l6 {
 		pm8916_l7: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for CPU PLL */
 		};
 
 		pm8916_l8: l8 {

-- 
2.40.1

