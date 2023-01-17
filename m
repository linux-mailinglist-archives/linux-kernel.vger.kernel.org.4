Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C234D66DD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 13:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjAQMCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 07:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236590AbjAQMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 07:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C9367FE;
        Tue, 17 Jan 2023 04:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4AA7612FA;
        Tue, 17 Jan 2023 12:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6EAC433F2;
        Tue, 17 Jan 2023 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673956954;
        bh=+Mmt7JDeLyWJF/zymxG1lOMckzw5H7Yj1D+CR+uParw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWN1FhuzUlc0Acx4UA9z0dzAs4DftQbFLVIwagkih24eXlO7qYCc9aOIC6mleDu/m
         vrRaaHDpkn7UmVPdemhrPuPm5MzJIpHEsVk8TiUgPA0zkE3Wh4ufwLbwvaj3hCVkmW
         bxfA4yCOefR/g0zQKIoO7jYoyFXlJo/BpthkRSdBT+yTgejeb0ARD5zJnzRSDUi1yN
         hmvd6v4QOrKLXQaqqZ6tkLD/o4mBv9/ppRlXEZwVavvcVORdhcsRrk7AHQGP7lYeA4
         NkXccrdSALRHr4a1zr0fSD6CORcqpYES/Vlk9aLJ7bLfZ6XHC/b3HIenKnZ5ef+t6H
         AyvskoDbBx8DQ==
From:   rfoss@kernel.org
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1 2/3] arm64: dts: qcom: sm8350-hdk: Enable display & dsi nodes
Date:   Tue, 17 Jan 2023 13:02:22 +0100
Message-Id: <20230117120223.1055225-3-rfoss@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230117120223.1055225-1-rfoss@kernel.org>
References: <20230117120223.1055225-1-rfoss@kernel.org>
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

From: Robert Foss <robert.foss@linaro.org>

Enable the display subsystem and the dsi0 output for
the sm8350-hdk board.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 26a608144886..7878f42e9378 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -221,10 +221,32 @@ &cdsp {
 	firmware-name = "qcom/sm8350/cdsp.mbn";
 };
 
+&dispcc {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l6b_1p2>;
+	status = "okay";
+};
+
+&mdss_dsi0_phy  {
+	vdds-supply = <&vreg_l5b_0p88>;
+	status = "okay";
+};
+
 &gpi_dma1 {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &mpss {
 	status = "okay";
 	firmware-name = "qcom/sm8350/modem.mbn";
-- 
2.34.1

