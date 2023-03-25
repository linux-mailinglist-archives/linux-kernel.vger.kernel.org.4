Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A956C8E21
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCYM0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjCYMZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:25:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805615CA9;
        Sat, 25 Mar 2023 05:25:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65CACB8075F;
        Sat, 25 Mar 2023 12:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493FBC4339E;
        Sat, 25 Mar 2023 12:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679747126;
        bh=JxFVzegMNbrMEaNKuwuM42THwTNnJ2goDp5n3iKU3MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u2zO1noPu2nP6wd+u/GUxQPeBFt5bI5fizyUjgYI3jVo2aU398hD55Nwfq3sdHv7Q
         XT/4G3mvp9ZfT3vtFY4Qr7ifbZW/i/LE+ryNHz925xYvTbU8HWNCVgpXIGC1Zat9l4
         iRPWjnMoYUm0ja0gx0sV8Ly2AwHVSOJMw8VsnFVyzy/r6BNvdF5ruIncBrQgge/rxn
         kjkRaMAAjssKV61ab546SRBWmhl/JRPBk7+fSXJ4LcUN6RlMtT4vP7dcHMBcx9y60g
         USobQk8+FETblasRp97XPcrf6e08lurWbrX99IEJpCIhOt37x4XPJijsq8A5QqZmNe
         gOOHTEC28BB4g==
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 08/12] regulator: dt-bindings: qcom,rpmh: Add compatible for PMC8180
Date:   Sat, 25 Mar 2023 17:54:40 +0530
Message-Id: <20230325122444.249507-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230325122444.249507-1-vkoul@kernel.org>
References: <20230325122444.249507-1-vkoul@kernel.org>
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

Commit 71ca776a8885 ("regulator: qcom-rpmh: Add pmc8180 and pmc8180c")
introduced these compatible's but the yaml conversion commit
7255f98d08c7 ("regulator: Convert RPMh regulator bindings to YAML")
seems to have dropped it

So bring it back!

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 .../devicetree/bindings/regulator/qcom,rpmh-regulator.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index 297a75069f60..44f49b153076 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -75,6 +75,8 @@ properties:
       - qcom,pm8550ve-rpmh-regulators
       - qcom,pm8550vs-rpmh-regulators
       - qcom,pm8998-rpmh-regulators
+      - qcom,pmc8180-rpmh-regulators
+      - qcom,pmc8180c-rpmh-regulators
       - qcom,pmg1110-rpmh-regulators
       - qcom,pmi8998-rpmh-regulators
       - qcom,pmm8155au-rpmh-regulators
@@ -232,6 +234,7 @@ allOf:
         compatible:
           enum:
             - qcom,pm8150-rpmh-regulators
+            - qcom,pmc8180-rpmh-regulators
             - qcom,pmm8155au-rpmh-regulators
     then:
       properties:
@@ -249,6 +252,7 @@ allOf:
         compatible:
           enum:
             - qcom,pm8150l-rpmh-regulators
+            - qcom,pmc8180c-rpmh-regulators
     then:
       properties:
         vdd-bob-supply:
-- 
2.39.2

