Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1545BC5B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiISJpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiISJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:45:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CBEE0C3;
        Mon, 19 Sep 2022 02:45:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B8DF60EF8;
        Mon, 19 Sep 2022 09:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787BDC4347C;
        Mon, 19 Sep 2022 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663580707;
        bh=d1sW83zQAn+g1g6/CERF4nHo6pWaZsqOjzZ4b2sA9Yg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKj3v1W6KgkihYXMv6DC85tHIGQEFpOd40DjhoweYEiBtOOenfpMFyUP39GrfMi+n
         5eLIdGuO7xjp92F2PW/U+iqd4K22Wkmepj9vfqVASzABRM377b1tFDzMhSKN8OB2dG
         b77lgtErseOB6BlJnWkGuimpy5Ue5kIIFCuXEBNVOj56kf/SS6NQzREH+BJZiuUzwk
         orNOQ9+Uy/2nJejBMvsKRS2J8Q1IJxIld79z1OW3sAeWz3wU9YRWfFXo2MdlkxqhwG
         CwwR+SBZRpIZkyQsTs+LFciW6hKSDWVULeXpgj1+1hJFkt/Fz6UDqZn9SeaLVvpjPc
         bh0brBcgfF0ig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1oaDKy-0000Ps-4Z; Mon, 19 Sep 2022 11:45:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 3/4] arm64: dts: qcom: sc8280xp: fix USB PHY PCS registers
Date:   Mon, 19 Sep 2022 11:44:53 +0200
Message-Id: <20220919094454.1574-4-johan+linaro@kernel.org>
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

With the current binding, the PCS register block (0x1400) needs to
include the PCS_USB registers (0x1700).

Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 9667eb1b7c61..c734cac84719 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -1181,7 +1181,7 @@ usb_0_qmpphy: phy-wrapper@88ec000 {
 			usb_0_ssphy: usb3-phy@88eb400 {
 				reg = <0 0x088eb400 0 0x100>,
 				      <0 0x088eb600 0 0x3ec>,
-				      <0 0x088ec400 0 0x1f0>,
+				      <0 0x088ec400 0 0x364>,
 				      <0 0x088eba00 0 0x100>,
 				      <0 0x088ebc00 0 0x3ec>,
 				      <0 0x088ec200 0 0x18>;
@@ -1243,7 +1243,7 @@ usb_1_qmpphy: phy-wrapper@8904000 {
 			usb_1_ssphy: usb3-phy@8903400 {
 				reg = <0 0x08903400 0 0x100>,
 				      <0 0x08903600 0 0x3ec>,
-				      <0 0x08904400 0 0x1f0>,
+				      <0 0x08904400 0 0x364>,
 				      <0 0x08903a00 0 0x100>,
 				      <0 0x08903c00 0 0x3ec>,
 				      <0 0x08904200 0 0x18>;
-- 
2.35.1

