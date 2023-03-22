Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311836C4945
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCVLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjCVLcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:32:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF58A5ADE9;
        Wed, 22 Mar 2023 04:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AA0EB81C4D;
        Wed, 22 Mar 2023 11:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38436C433A0;
        Wed, 22 Mar 2023 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679484768;
        bh=rbznbEaYWjVRE7b0o62igvsq7AgRkoVuxUrn1yLctEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8sTAuVpRUpkaFPFZiRnC135gVrrrFBuRP6dqB7m+z1A3/4bNnybbB4uMtMektIVv
         vbU8wE6sUdHyggdIH9Hq/7YEDA0x1HW6HWlM2YM4hMkIne95IbPyyMR4zPacsFzldb
         FFLXuXyP/9eawFIR4KE792hxO80NeOcgnTS5at84dQNaNcb1oP1e3MLR1uvayamXTr
         48dko9gd5wExsGKQUf0nqciZqlNVe5+V9VxMdIAg+8T+PGkCHxvU0u7eB7pobFSZKq
         zvBV270NPvejKvunAEKFhbLk0QLdatm0FAyon/PBzoZ7FlFaV6055HVj9DP2uLj/cc
         1jHNGjvelExzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pewjP-0004fX-3g; Wed, 22 Mar 2023 12:34:15 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 6/6] arm64: dts: qcom: sc8280xp-x13s: add hid 1.8V supplies
Date:   Wed, 22 Mar 2023 12:33:18 +0100
Message-Id: <20230322113318.17908-7-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322113318.17908-1-johan+linaro@kernel.org>
References: <20230322113318.17908-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the input devices use s10b as 1.8V supply.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 14e8d0a78b60..43b7f63b79a2 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -622,6 +622,7 @@ touchscreen@10 {
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+		vddl-supply = <&vreg_s10b>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&ts0_default>;
@@ -643,6 +644,7 @@ touchpad@15 {
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+		vddl-supply = <&vreg_s10b>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&tpad_default>;
@@ -659,6 +661,7 @@ touchpad@2c {
 		hid-descr-addr = <0x20>;
 		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+		vddl-supply = <&vreg_s10b>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&tpad_default>;
@@ -673,6 +676,7 @@ keyboard@68 {
 		hid-descr-addr = <0x1>;
 		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
 		vdd-supply = <&vreg_misc_3p3>;
+		vddl-supply = <&vreg_s10b>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&kybd_default>;
-- 
2.39.2

