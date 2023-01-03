Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681A965BE34
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbjACKby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbjACKbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:31:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE2A18D;
        Tue,  3 Jan 2023 02:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DCE1B80E91;
        Tue,  3 Jan 2023 10:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A76CC43396;
        Tue,  3 Jan 2023 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672741896;
        bh=8cU14J4fNQ860AwDHJzhxOG7AJPdC23m/QS0H0H09yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgGqYJxVwg4LNpVQ0S2kS0Dzx0r5f287PyRJjq25qzcbC+jHwhat1P3ZqnIzyAVjo
         lVu36YhKP3IznvKM7/5RTIUvya/bmRMnBoDA2Jll0soLzhKrqhSWrIF2hJnoFr7cIl
         eln0dPZTp80TZQvRXPWwxK+ACCgg1/hYfQURJCoirEmnXTEQdlUncujIkk3cLEcIVt
         STOPWglHXBibas7GOEFnUa9zPO9xdFoVc1aKI6yvZ1Ke2dr7VZygsXLwiHlF0kSbxI
         eGeVmhnSufqXfIiA2urYehHD2IeekSnfVb1CV6Z4IM7X0NrqLxV7uPw7meU9ax7a0/
         nXYFjsqDUVknA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pCeaJ-00047S-Qq; Tue, 03 Jan 2023 11:31:55 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 3/6] arm64: dts: qcom: sc8280xp: clean up tx-macro node
Date:   Tue,  3 Jan 2023 11:31:38 +0100
Message-Id: <20230103103141.15807-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230103103141.15807-1-johan+linaro@kernel.org>
References: <20230103103141.15807-1-johan+linaro@kernel.org>
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

Drop the bogus address and size-cells properties from the tx-macro node,
which do not have any child nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c1ce2d7b3675..11e3d560c627 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1784,8 +1784,6 @@ txmacro: txmacro@3220000 {
 			clock-output-names = "mclk";
 
 			#clock-cells = <0>;
-			#address-cells = <2>;
-			#size-cells = <2>;
 			#sound-dai-cells = <1>;
 
 			status = "disabled";
-- 
2.37.4

