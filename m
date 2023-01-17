Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055E66DC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjAQLYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjAQLYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:24:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD99212F;
        Tue, 17 Jan 2023 03:24:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD0B2B8159D;
        Tue, 17 Jan 2023 11:24:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30908C433EF;
        Tue, 17 Jan 2023 11:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673954671;
        bh=KHuQBxrZomd1HoV6c2nGjKewKn6fSQrzgb2IdRr240A=;
        h=From:To:Cc:Subject:Date:From;
        b=abt/+p72P5FPhU9X5LDA/egyEwZ3d3J5BEo09kYvxXcw7igq7gUwcqoXLOk2Ll3lg
         Yw0/XoxfHuy5iPcubATuqszGmyX3PASB4Pbohk8MEJNcp+wOQeF8la6u0VK5QEO9Co
         GvP0KLsDDMQjWad4U/KIlzQylhO4hWxs6GEa7boyp/5cqkxrVYyT0uElLZxnlfN7xj
         /yw30qUPbP8MUxa0rJZSByapm3dxxq76El1WshvxyPvWzNNGU98P9w3TTRFAjIhFF0
         OxyOyIQX2OcS+5WOw+jDDQxpP6d1PQeJSPZqBzl76B+06JbPUpBc+ShWa90BycYY34
         YllJyWRVbvjnQ==
From:   rfoss@kernel.org
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] arm64: dts: qcom: sm8350: Remove mmxc power-domain-name
Date:   Tue, 17 Jan 2023 12:24:15 +0100
Message-Id: <20230117112415.1015538-1-rfoss@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Foss <robert.foss@linaro.org>

The mmxc power-domain-name is not required, and is not
used by either earlier or later SoC versions (sm8250 / sm8450).

Signed-off-by: Robert Foss <robert.foss@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index fafd92edc855..75723dd06d21 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2642,7 +2642,6 @@ dispcc: clock-controller@af00000 {
 			#power-domain-cells = <1>;
 
 			power-domains = <&rpmhpd SM8350_MMCX>;
-			power-domain-names = "mmcx";
 		};
 
 		adsp: remoteproc@17300000 {
-- 
2.34.1

