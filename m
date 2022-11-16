Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7E62B7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbiKPKWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbiKPKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:21:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C44240BF;
        Wed, 16 Nov 2022 02:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39764B81CCA;
        Wed, 16 Nov 2022 10:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A44C43145;
        Wed, 16 Nov 2022 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668594114;
        bh=ugvhCklLNB/eG2EpZG3wQ6qVR1H08DlzqYrlDFFo75M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=urL+qQ7BaLDjG0I3bwUZoM1sNyNLC+/HFQD4DVNzqJfl6/3qkiyN3bscXhgKQo5l+
         ptmRJwLBIjEbMHkU6e663cCYH3iSXMqqpbxS44ZwTOgvW8kgIm/yyji+dZPzya0HL5
         YIn9Wl6u1FwZALyQlIRX/9zZ/gBzV/oDFiPbTqayNtTw4SDmDtRYwMeB2PzLnTFwkt
         LVghAQLzBzqfOCWMwoFZ0ASex3PfQtaYjgKvYbKVytsL8mxJdLjGAIjaAD/VSKALJT
         8m2T0i2uv6NJFGd5AK4zSuqm3xVx97de14Z91o+/QeQEZLUsvghDCWby3JtkyHPoOU
         sI6LDwLdZCWVg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1ovFXo-0001Em-ND; Wed, 16 Nov 2022 11:21:24 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Parikshit Pareek <quic_ppareek@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 1/2] regulator: dt-bindings: qcom,rpmh: clean up example indentation
Date:   Wed, 16 Nov 2022 11:20:53 +0100
Message-Id: <20221116102054.4673-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221116102054.4673-1-johan+linaro@kernel.org>
References: <20221116102054.4673-1-johan+linaro@kernel.org>
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

Remove a line break and increase indentation of the continuation line
to avoid having the 'regulator-allowed-modes' example be reproduced
verbatim with four-spaces indentation (instead of a tab, which is still
too little) in devicetree sources.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 .../bindings/regulator/qcom,rpmh-regulator.yaml        | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 90c3bda31c23..7ff51b558702 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -412,9 +412,8 @@ examples:
             regulator-min-microvolt = <1800000>;
             regulator-max-microvolt = <1800000>;
             regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-            regulator-allowed-modes =
-                <RPMH_REGULATOR_MODE_LPM
-                 RPMH_REGULATOR_MODE_HPM>;
+            regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+                                       RPMH_REGULATOR_MODE_HPM>;
             regulator-allow-set-load;
         };
 
@@ -431,9 +430,8 @@ examples:
         bob {
             regulator-min-microvolt = <3312000>;
             regulator-max-microvolt = <3600000>;
-            regulator-allowed-modes =
-                <RPMH_REGULATOR_MODE_AUTO
-                 RPMH_REGULATOR_MODE_HPM>;
+            regulator-allowed-modes = <RPMH_REGULATOR_MODE_AUTO
+                                       RPMH_REGULATOR_MODE_HPM>;
             regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
         };
     };
-- 
2.37.4

