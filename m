Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275536BD1DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCPOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCPOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:12:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C18A4EF5;
        Thu, 16 Mar 2023 07:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04B91B821F6;
        Thu, 16 Mar 2023 14:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE99BC433D2;
        Thu, 16 Mar 2023 14:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678975935;
        bh=l43c5Oorz7qzJHYLJzxD/oe9udZzFiC3uwd2HHmTnKY=;
        h=From:To:Cc:Subject:Date:From;
        b=Ogq7uP1YDlrPSZMbs4G4mfoI8zau4H+Ro+8ufdQDZT8eCrDozpyy2TaXUrg6REaYu
         36Tfpwq9aMQz4IbG4raRiTN7gufK5k6CrUI8BX+DCx7ojVXNtcwluH+EN++1ft8+mh
         QW2Ugnc57tTcjJvUwW09DPtWQJ8p8rowXs80e4Xl2xEdyKAhMB+05OEJO8C37sNpGi
         rw5XglIR0HGZHWhxHeySHZCDuPoq7BHN6U3t+vr9swom1rw5sc70SYHOKaa/vKJDpm
         ZVWlqzbZ+53PZJYV8JkqMvzaY7tyS7Jo7HkzlF6uNKQjPkW48w2IHcmldvFdeywUAb
         sfKWkP8FC6FZQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pcoM8-0000dm-Hw; Thu, 16 Mar 2023 15:13:25 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp: fix external display power domain
Date:   Thu, 16 Mar 2023 15:12:52 +0100
Message-Id: <20230316141252.2436-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Fix the external display controller nodes which erroneously described
the controllers as belonging to CX rather than MMCX.

Fixes: 19d3bb90754f ("arm64: dts: qcom: sc8280xp: Add USB-C-related DP blocks")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index c6898f557e6a..becc6e469a1e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3272,7 +3272,7 @@ mdss0_dp0: displayport-controller@ae90000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp0_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				status = "disabled";
 
@@ -3350,7 +3350,7 @@ mdss0_dp1: displayport-controller@ae98000 {
 				#sound-dai-cells = <0>;
 
 				operating-points-v2 = <&mdss0_dp1_opp_table>;
-				power-domains = <&rpmhpd SC8280XP_CX>;
+				power-domains = <&rpmhpd SC8280XP_MMCX>;
 
 				status = "disabled";
 
-- 
2.39.2

