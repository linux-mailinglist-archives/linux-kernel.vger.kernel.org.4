Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC236C4942
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCVLc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjCVLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:32:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B394D5ADE4;
        Wed, 22 Mar 2023 04:32:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B9CB81C0E;
        Wed, 22 Mar 2023 11:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2780EC433D2;
        Wed, 22 Mar 2023 11:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679484768;
        bh=K0EI/TVG1t+eImsGBQzIgPOhGwu6kr9ZIVmBxZ9hkYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZefD2SeCeJs2+R1k0YTJVQODkRNmm013NgUHkviS1EmrryMAGQE+Zx71L7zwVUGcN
         yyu96DxRKqxHFfSAFIOD0FFuBvp9fUSVbvG0/PgtJJkLIzHCzIM8svclQLMe5Qln7R
         hJ9GR2UiTBg3M2owtafaxIsQERSmeDDZB0za2Qls535eE3jXL+hFwHohPu9naGdBK8
         f5o1d5E87MzOCI+mPCk1PnwbNp21q0sbEiKbMSI8KhiCpIKThvjB4yAYiKFshVc8mc
         93VdiRO/9MAo9aTkjlpiCaGangyVje2SkLCh1LQ5j1fKTWzgCFg2ZcTzcLEVdWdr2+
         Pj1e/kILz/qhw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pewjO-0004fT-Us; Wed, 22 Mar 2023 12:34:14 +0100
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
Subject: [PATCH 4/6] arm64: dts: qcom: sc8280xp-x13s: mark bob regulator as always-on
Date:   Wed, 22 Mar 2023 12:33:16 +0100
Message-Id: <20230322113318.17908-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322113318.17908-1-johan+linaro@kernel.org>
References: <20230322113318.17908-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bob supply is used by several pmic regulators and components which
are not (yet fully) described in the devicetree.

Mark the regulator as always-on for now.

Fixes: f29077d86652 ("arm64: dts: qcom: sc8280xp-x13s: Add soundcard support")
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index cdd2791576e2..44cf93ddc1b9 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -453,6 +453,7 @@ vreg_bob: bob {
 			regulator-min-microvolt = <3008000>;
 			regulator-max-microvolt = <3960000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-always-on;
 		};
 	};
 
-- 
2.39.2

