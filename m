Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F624666BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbjALHqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjALHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:46:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E27D4BD46;
        Wed, 11 Jan 2023 23:45:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D0661F7A;
        Thu, 12 Jan 2023 07:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47346C433D2;
        Thu, 12 Jan 2023 07:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673509533;
        bh=EWBwBnYK0xV+Glxx6Z/EVTFLlwix0VJtnazOnfUdeT4=;
        h=From:To:Cc:Subject:Date:From;
        b=png2WOfLLGAoQpqEDt0S1ahBd/UXNg2eTnPhqBrr3UFBw0pUuIpbz8PDj8dHTzk7M
         hDh1Hc5sqKnyoL0m/XyHVCSUID+usEJn0HFDrSLFYJPRJQPq8nIP3MgJteS47Z+nQ6
         n5YhtLTM1L1VdpvRAgxkTQo00qqbxf76Uos+/H6tH4rBY2Dx/eF/oGKGy5v6VHqMHR
         QMMgEziJ1bFKC5EB7JkO+F87e1ju44YA12X9VL4m72kHBcoIt/Hi+ItrZJfd64MdTx
         gWeqd6ukyh0i7S93LQh3CNRwFFH9O5q9evm0Ijgxhh6I2wb0y4JecGQ32jOeh+PZaV
         z+ucHcpXizerA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pFsHL-0003Bl-Hm; Thu, 12 Jan 2023 08:45:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-crd: allow vreg_l3b to be disabled
Date:   Thu, 12 Jan 2023 08:45:03 +0100
Message-Id: <20230112074503.12185-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.38.2
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

The vreg_l3b supply is used by the eDP, UFS and USB1 PHYs which are now
described by the devicetree so that the regulator no longer needs to be
marked always-on.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index db12d8678861..e5e75cc2c670 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -150,7 +150,6 @@ vreg_l3b: ldo3 {
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 			regulator-boot-on;
-			regulator-always-on;
 		};
 
 		vreg_l4b: ldo4 {
-- 
2.38.2

