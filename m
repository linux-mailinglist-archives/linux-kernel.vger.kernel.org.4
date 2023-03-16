Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51886BCD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCPK5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCPK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7881A14987;
        Thu, 16 Mar 2023 03:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13FA061FD4;
        Thu, 16 Mar 2023 10:57:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EDF5C4339C;
        Thu, 16 Mar 2023 10:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678964250;
        bh=xjzQr8LKE0yzsI8rxZWZ3vKP5CJ5x4ggIHwEWSA0jIo=;
        h=From:To:Cc:Subject:Date:From;
        b=nPXX63MDWCEtPp3v2RGNRhGcMnfuvBsCmGlipNu1WKBZ4Z4c9smgAEslpBJy/MWXl
         02UXbWmu9BtXovvlB6VExtIfkS5sv9ZDwwoDhJyfwkSiUBBJmedS3Vpkoxpg98VRcF
         dYEcYM2wIHRDj1Di/vlnxORocUf/08niFbiKHsoMgF0Eyeanze/Rn6gahitMxpdt7U
         HtJwIPgb/eS+TEeYVpGYLbCnR02dYkWz9Xq2zpDMBCOxVfyFqrLZgn8ZQdlF5T1zlT
         q1ai/NxkBJh6tUauvFDNy68eCHZVZ2mgRh7+m47K6BddZ4RqnWUD1zQAuq8PfRB3Bx
         wAnu0JNu+OU3w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pclJf-0004so-Ey; Thu, 16 Mar 2023 11:58:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow 'bias-bus-hold'
Date:   Thu, 16 Mar 2023 11:58:00 +0100
Message-Id: <20230316105800.18751-1-johan+linaro@kernel.org>
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

The controller supports 'bias-bus-hold' so add it to the binding.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

Linus, this is based on how the current driver (and sc7280) works, but
without access to documentation I have no way of confirming this.

If Bjorn or anyone else with access to the docs could ack this before
applying that would be good.

Johan


 .../devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
index 97b27d6835e9..4ae39fc7894a 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
@@ -104,6 +104,7 @@ $defs:
                 usb1_phy, usb1_sbrx, usb1_sbtx, usb1_usb4, usb2phy_ac,
                 vsense_trigger ]
 
+      bias-bus-hold: true
       bias-disable: true
       bias-pull-down: true
       bias-pull-up: true
-- 
2.39.2

