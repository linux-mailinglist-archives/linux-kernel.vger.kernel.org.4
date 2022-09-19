Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642B05BC5B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiISJpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiISJpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93BEE02;
        Mon, 19 Sep 2022 02:45:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC16B80A26;
        Mon, 19 Sep 2022 09:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C903C433D7;
        Mon, 19 Sep 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580707;
        bh=Ye+EQy2nQUkjwwPpLSgurC7cPORoqOPdsdDAaDT8wCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rnnnMnXHZtSb1K0XmqrzuHC7p3iIEQC7/zvcRziS+0YFOqtva0EMai+h/luCAdMWH
         C2wLgzdPYuPa4ylztdlmo6xoB8K1VOUxWrNbZ3uFfyph/yiYtBY6kqx6IZwDtABitv
         t1FKNZC6nHXhZJWUAkwAYG/xSYVNL74oJqef3ccXyyVtKRs/fHbE00p/Md9wtfbKon
         N117UKpEUVlip5SVVr1olYYWy3zJMSf2/94bgJ/+/y6/cE7/C2uiRA9zQyJEU6zIB3
         iQ6/90nkFCpOLg3rg31IqgCq+ByoEU++8LhuuEbFW5UQGhIlwWbOUjl9eSHFzef9gW
         D911gzjEV/jzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDKx-0000Po-Ug; Mon, 19 Sep 2022 11:45:11 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/4] arm64: dts: qcom: sc8280xp: fix USB0 PHY PCS_MISC registers
Date:   Mon, 19 Sep 2022 11:44:51 +0200
Message-Id: <20220919094454.1574-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919094454.1574-1-johan+linaro@kernel.org>
References: <20220919094454.1574-1-johan+linaro@kernel.org>
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

The USB0 SS PHY node had the PCS_MISC register block (0x1200) replaced
with PCS_USB (0x1700).

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 49ea8b5612fc..e8905445ca19 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1184,7 +1184,7 @@ usb_0_ssphy: usb3-phy@88eb400 {
 				      <0 0x088ec400 0 0x1f0>,
 				      <0 0x088eba00 0 0x100>,
 				      <0 0x088ebc00 0 0x3ec>,
-				      <0 0x088ec700 0 0x64>;
+				      <0 0x088ec200 0 0x18>;
 				#phy-cells = <0>;
 				#clock-cells = <0>;
 				clocks = <&gcc GCC_USB3_PRIM_PHY_PIPE_CLK>;
-- 
2.35.1

