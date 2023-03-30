Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD86D0BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjC3QyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjC3Qx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:53:56 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBB7171B;
        Thu, 30 Mar 2023 09:53:46 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PnTyb3T7Cz9sbY;
        Thu, 30 Mar 2023 18:53:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680195223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKSbFG5DGVwvXJCZEdfm9iFVOlxnj2KKA0SRmRRz/mM=;
        b=Xm03N916cgtDouzhEd8joAt0pt+gaeuj/NgdpBsez7EMQ9sj0HPDPOvxoaBOQcNGZOyDW+
        ie164UorDGWtFMz3PsdbD/iROaatkYHsytzsLlU2KxeXFCkdipuFo7+RT/PEBt1MUf6B/X
        kHYFfDV+vW182mDdv1bwba68sfzOUN6fB2g8Su9UoNsFyxLIDx9NnNlDPIz1dZvUjOKK2G
        u+xzeV2yJwUqN6MvLle1GuoUv+UGyJYJ/rqdc2x2ThOGq2F4m8VvoiOlUR4KhrC0ksIv29
        2VhCRHuw4YCL4T/jE8aBFhSvoEF/7jGl8YVGyKNnVVvr3my5GSa4InE7fFZ6tQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 4/4] dts: arm64: qcom: sdm845-shift-axolotl: enable SLPI
Date:   Thu, 30 Mar 2023 18:53:22 +0200
Message-Id: <20230330165322.118279-5-me@dylanvanassche.be>
In-Reply-To: <20230330165322.118279-1-me@dylanvanassche.be>
References: <20230330165322.118279-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SLPI DSP on the SHIFTPHONES SHIFT6mq phone with a
Qualcomm SDM845 SoC.

Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index b54e304abf71..bd9571a258cf 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -572,6 +572,11 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
+&slpi_pas {
+	firmware-name = "qcom/sdm845/axolotl/slpi.mbn";
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
 
-- 
2.39.2

