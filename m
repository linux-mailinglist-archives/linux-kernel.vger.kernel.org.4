Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0CF72F5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjFNHRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbjFNHQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:16:30 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E80E1FE2;
        Wed, 14 Jun 2023 00:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686726979; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LSOXVt9xjPH3jOL8WmwYhWJAt7aSQnLL7b4yjO22ZqqhfY5KRll5pWRn6xlQ0X8MRJ
    Py6gk/2EkKJRRT80N8RQyF8wa+MHE99fmmmOZCcSaVUhwk2bwcyQmh7ZEd+mSgCTId4M
    s3rG5PT9zGr3uWgUCA+h2mCBGV1jGw5OCLpeFbKvBLbpFcoafSgTQEn/RZimUPjMNFvM
    vx6OZO0+D4WrNw+V+z0ciAA3iX1uymwhe8gP1+YgzcOhVpWDqKuvUT5X1QuFH5nt7nMC
    u4WaMm6MvKOs0w24NUkNEP3H1cHcoNfIBs8if+MRnTqVgHtCm9AJLSZKPhouOuJ/skzk
    nzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Z643LN4iyCKvjK5j6XP9XQLu7ScuQMBkvKKX5tWCT6A=;
    b=tDGOzK21aTpQxVJr3j3riKw4EvjFpKhK/YJptAmQ8KFtaivVxOnFv6sdVRgyRcHxg+
    /FEo5vD1jgI+tYOcWeLcXxVljwwXMUMrDHH/H74/kNMw0rkGMtVkS5KIYzbrBIFjUX85
    xhgN3pgmmlhL55T4zXam0swrUmbf+PNs9KTb35cOQIZoAk60TaNLbCyDYs68K9SFs9Er
    lWqzUeNGxq1puNfCRNV/VtfKm9OhIEYGBrCAPIz8xujXEDi8GzVZUgqBMxZN4Tex85oZ
    gaYFrl9vWr5i4Hb8zzMf5N1ob+FLfowgDqYKrdE2yJrRvRhKy0YwXizAUCx7EuYaJfWJ
    2ofA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Z643LN4iyCKvjK5j6XP9XQLu7ScuQMBkvKKX5tWCT6A=;
    b=cH+nJlxRgvHSKumxuBlpsSvDelba44hrefij7yPtZ9SiJzVDYBRjzvpqs/KNx0bUbu
    4U3I9TCyzSyAzWQ5PEAbzUvaDYGhCHwlGLfrBSqGsTHJcyQ6K6Ne97n+iVug1X2eDwje
    GTtu9IT2PGY4dSkfJJEF9D3OxIfZvMKckVenEuWZWBMAuaPgZMWPUmknINht4QkFcRTt
    HMmxXyaWYKn4lVkZ7d2tSs8WtELo5GtzwEw8J0MECGXtljN5WL5NR5qF4OEriRpjyWDI
    xZglsKpj7RoAzqrcSaRxGkPFm105uTBlNipeBUKOGZPCVcYwVyWl6iM4kc75fUDeMWqu
    E4qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686726979;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Z643LN4iyCKvjK5j6XP9XQLu7ScuQMBkvKKX5tWCT6A=;
    b=Zc8HuGxtaeZi2LX/FBGgscgGvRRizrvppB8RTvCOlGXZqdq6jdIs0HPKqN+FJV/mJO
    0omNxlBwnpdGt5asuNBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5E7GJb2j
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 09:16:19 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 09:16:06 +0200
Subject: [PATCH 8/8] arm64: dts: qcom: msm8939-pm8916: Mark always-on
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230530-msm8939-regulators-v1-8-a3c3ac833567@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

The same changes was already made for MSM8916 in commit 8bbd35771f90
("arm64: dts: qcom: msm8916-pm8916: Mark always-on regulators").

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
index 12538211bc72..adb96cd8d643 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939-pm8916.dtsi
@@ -51,10 +51,12 @@ pm8916_rpm_regulators: regulators {
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
@@ -71,6 +73,7 @@ pm8916_s4: s4 {
 		pm8916_l2: l2 {
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
+			regulator-always-on; /* Needed for LPDDR RAM */
 		};
 
 		/* pm8916_l3 is managed by rpmpd (MSM8939_VDDMX) */
@@ -80,6 +83,7 @@ pm8916_l2: l2 {
 		pm8916_l5: l5 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for most digital I/O */
 		};
 
 		pm8916_l6: l6 {
@@ -90,6 +94,7 @@ pm8916_l6: l6 {
 		pm8916_l7: l7 {
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-always-on; /* Needed for CPU PLL */
 		};
 
 		pm8916_l8: l8 {

-- 
2.40.1

