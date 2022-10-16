Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519D75FFE59
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 11:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJPJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 05:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJPJB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 05:01:27 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061B236BE2;
        Sun, 16 Oct 2022 02:01:22 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (31-151-115-246.dynamic.upc.nl [31.151.115.246])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 74F67CABFC;
        Sun, 16 Oct 2022 09:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1665910880; bh=ZRzgGM6FaGeNgofL75oSwWaWnuKQ+8EJz2oNrm/h4kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=IxANp4Bzght9Oc+es9F8DsFAhtN4madfVh6ER0zVC1ZGzXm58PF5pZfABU9EvTkb6
         pl+rrmeBHuheneH84YzGFsmqVlvgm+OqkWfo7y+9Ta/YIahAmj0oIf5XD51xB7hdQy
         ig1y/6dWPaOItCMZARGot6lHkChcm38BmADgYAgw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sc7280: Fix cpufreq-epss compatible
Date:   Sun, 16 Oct 2022 11:00:31 +0200
Message-Id: <20221016090035.565350-2-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221016090035.565350-1-luca@z3ntu.xyz>
References: <20221016090035.565350-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings require a SoC-specific compatible to be used next to
qcom,cpufreq-epss. Add it to make dtbs_check happy.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 212580316d3e..af15c71c5745 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5321,7 +5321,7 @@ epss_l3: interconnect@18590000 {
 		};
 
 		cpufreq_hw: cpufreq@18591000 {
-			compatible = "qcom,cpufreq-epss";
+			compatible = "qcom,sc7280-cpufreq-epss", "qcom,cpufreq-epss";
 			reg = <0 0x18591000 0 0x1000>,
 			      <0 0x18592000 0 0x1000>,
 			      <0 0x18593000 0 0x1000>;
-- 
2.38.0

