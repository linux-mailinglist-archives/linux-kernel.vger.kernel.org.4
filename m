Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90845707121
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjEQStR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEQStP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:49:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38C37ED0;
        Wed, 17 May 2023 11:49:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1684349340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Kb9ATq8cgnXihHjfx6fsgp545NsgOhevt6NK59jICYosRWQQjB+oDeaBgAmz3YUv/F
    rrJ8ifUUyy2h54Tezj6E4bHCJjOLzmXo+jY6feM20gIT32XhHCeRJUkIFbgYW5W8DeRI
    38rfd7gd4ErtLAw19pDdIlu23Ix89Vjv2ODY/vjCSLgqT3CjY2WtNFZpnIoonVBSh2NI
    MJiO+jGC2kdAudWYUQEoXHvtr4rUcVyvsLrE8cDx9BnLsQzn+KgBr7rrRxn2igF2RBqA
    PfsW1p/hy3ri5CQA/sC3V3F0caRCgeulqD9KSrw1bcm14QKOLu7OgvWJI+ZnESWZGj9f
    VsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hk0tnh+hTFfXKNgIR8FDn7Sblt76hroYTDj/mKNNR1U=;
    b=IbhyqwmZB+GRWuBmqxUHV6/7KvrYehwnlSoA5//qh2md76i1LMDu7xIzwW+BRkfA8H
    VsWFasmTnijAkS/gZP97S4yX8iq8CX7NRoR01EkMsDiK0276OvDQLFySLhkAk4fd8BxQ
    5Q2WpGllRLcFEzq9y8SRlHes7AMYcyS/58oIEakNXNdqBQ1XSpnczzaMZUIfyXIy40Uh
    4cARroRRv1Xu1oc/DS0VI+c+JPgY3wjUqGxf7LRz7k3Pmnl9oQquuHDlEPyMz5zLmu8t
    GZHhSghQDrlOyK4zy6IAkVxa/65Ef46V6a6p1PkSOa3K2YfXQb0BA5SxiRBCl2IALmPh
    6X2w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hk0tnh+hTFfXKNgIR8FDn7Sblt76hroYTDj/mKNNR1U=;
    b=FuMhPSALi43p29a5Ao0/R+2Qd+Ai31Wx8Fz40DqN7O6lgcFt4FczM5bT5WPWT5WTOd
    r0apNc0tWpOjoQgQiEIxF5hMtcV12Iy1WZt/K1Na4sw4EYg6d0UWZhWwXzR7sG8y17lz
    DXgDzIkdVP22cE32kPO1qAMvfUkwyoFxse4g37uan/NxWz83agwKE0FgvHeULk1o07HZ
    Nj3vt+YI+tZq8B/gtmKbQkP3YpDYI1VAsUS+wI3MGhsif/jglB3jVjdK3pMNYfe8oEGQ
    ImvzfA//Si4Y2PRekd4F2oBuU3mDuPFJ4uSpsm1/66wIW0Q1J9SErapdcIL105Cip5yZ
    CIRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1684349340;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hk0tnh+hTFfXKNgIR8FDn7Sblt76hroYTDj/mKNNR1U=;
    b=T6KLFs+R/4k17oV4zYUqxypHzQbT+n7RhhsR86eGWBtiyqRPJsdSx2m4/NFlXpDJ04
    uCifT7ErmnAAuOojcLCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4HIn0BIK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 17 May 2023 20:49:00 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 17 May 2023 20:48:44 +0200
Subject: [PATCH 5/8] arm64: dts: qcom: pm8916: Move default regulator
 "-supply"s
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230510-msm8916-regulators-v1-5-54d4960a05fc@gerhold.net>
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

Some of the power supplies for the analog audio codec in PM8916 are
wired externally. While most boards use the regulators currently
specified in pm8916.dtsi, in theory it could be connected differently.

We already have msm8916-pm8916.dtsi that models that standard setup
used by most devices so move the -supply properties there and keep
the base pm8916.dtsi independent.

Currently all MSM8916 boards in mainline make use of
msm8916-pm8916.dtsi, so it is not necessary to adjust any other boards.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi | 6 ++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi         | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
index 6eb5e0a39510..5b3ed7137e1f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-pm8916.dtsi
@@ -35,6 +35,12 @@ &usb_hs_phy {
 	v3p3-supply = <&pm8916_l13>;
 };
 
+&wcd_codec {
+	vdd-cdc-io-supply = <&pm8916_l5>;
+	vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+	vdd-micbias-supply = <&pm8916_l13>;
+};
+
 &wcnss {
 	vddpx-supply = <&pm8916_l7>;
 };
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 33ca1002fb75..864bb1cd68db 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -174,9 +174,6 @@ wcd_codec: audio-codec@f000 {
 					  "cdc_ear_cnp_int",
 					  "cdc_hphr_cnp_int",
 					  "cdc_hphl_cnp_int";
-			vdd-cdc-io-supply = <&pm8916_l5>;
-			vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-			vdd-micbias-supply = <&pm8916_l13>;
 			#sound-dai-cells = <1>;
 			status = "disabled";
 		};

-- 
2.40.1

