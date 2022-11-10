Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A198D624007
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiKJKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiKJKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:38:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472446BDD8;
        Thu, 10 Nov 2022 02:38:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C84466124A;
        Thu, 10 Nov 2022 10:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B89C433B5;
        Thu, 10 Nov 2022 10:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668076698;
        bh=A+0Hs74iYp1t+FZuZbchlIpqvox9Kc3+0WOmPBRSrvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bbajhkuKoBCAUnsj1mUrT4+zwRyT+fhArgQQvxEbdyAqN68eUd0Cl8WR3E1uzEcRJ
         gxP0s8hUZB1O/tUYcW1TpLs+4H7CCn7umm7LW74UERMzm/bWMxA5ao98GdF1zxcqwG
         uaczdk0/0Kmub0OUen/qojS95Lz/hoMUClU/lg17DEAUmfTD2F8vbv1H7jbfKV13my
         +I8a436HDmEaTv5xSe7HF/IaU6xhy1atTZfJ44lmVqLgZkWOMe3L8pIAXhKYmN783n
         oZHrIinxKkCzK3gH1kOm8dOw01b0uEWDCJ5aYae+WqAKlAohQQMKZRaHuOPA8WvOhk
         IOq1mSQF9C11w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ot4wQ-0003LT-Vb; Thu, 10 Nov 2022 11:37:51 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/9] arm64: dts: qcom: sc8280xp-crd: rename backlight and misc regulators
Date:   Thu, 10 Nov 2022 11:35:52 +0100
Message-Id: <20221110103558.12690-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221110103558.12690-1-johan+linaro@kernel.org>
References: <20221110103558.12690-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the backlight and misc regulators according to the net names.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index a2027f1d1d04..0801bd8c44fb 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -37,7 +37,7 @@ chosen {
 	vreg_edp_bl: regulator-edp-bl {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VREG_EDP_BL";
+		regulator-name = "VBL9";
 		regulator-min-microvolt = <3600000>;
 		regulator-max-microvolt = <3600000>;
 
@@ -53,7 +53,7 @@ vreg_edp_bl: regulator-edp-bl {
 	vreg_misc_3p3: regulator-misc-3p3 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "VREG_MISC_3P3";
+		regulator-name = "VCC3B";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-- 
2.37.4

