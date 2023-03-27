Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F466CA42B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjC0MdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjC0MdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:33:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102993C04;
        Mon, 27 Mar 2023 05:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 525C1B80DA6;
        Mon, 27 Mar 2023 12:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A9EC433D2;
        Mon, 27 Mar 2023 12:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679920378;
        bh=ZNwBA2NAAA+1rgyfUbyfokfIEOLrB3/fDda0MLnXviw=;
        h=From:To:Cc:Subject:Date:From;
        b=lIu503uWNSm8wf3zxwSQ9IH9xcffa90LwGPDnjf7I6JcZ/aWSh64cVCiUjaM7zeU+
         Pw97SdfmQCMqmhLqz87M7JiD2uCUyfR/a9lyyT7w6qcibV0LQWoT1Qh4rCK3Thziha
         5VHHQrU22vDQAngOG9WOFDXRL8QpoeqaDEigvU2Re71fp0oYEE2VUcPfqpKU9DiBtq
         ln8wFqQ74aXbSifka2Daq1wD7smuS3bhHO33ttifoABgN7uWdv8vqstTF/aGD/lbOy
         B56YvFVplApO7SExZo8FasYbt8+sZbS5rkPGyTByZ1B0Mjog4H5GM4hjOstI83fQkM
         5CeunoSaGfCuA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pgm28-0001BF-4a; Mon, 27 Mar 2023 14:33:08 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] arm64: dts: qcom: sc8280xp-x13s: drop bogus 'input-enable'
Date:   Mon, 27 Mar 2023 14:32:43 +0200
Message-Id: <20230327123243.4527-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sc8280xp pin controller does not have a way to enable or disable the
input buffer so drop the unnecessary 'input-enable' property which is
about to be deprecated.

Link: https://lore.kernel.org/lkml/20230323102605.6.I291ce0ba2c6ea80b341659c4f75a567a76dd7ca6@changeid
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index d827005f1375..2591b492d5d8 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1274,7 +1274,6 @@ edp_reg_en: edp-reg-en-state {
 	hall_int_n_default: hall-int-n-state {
 		pins = "gpio107";
 		function = "gpio";
-		input-enable;
 		bias-disable;
 	};
 
-- 
2.39.2

