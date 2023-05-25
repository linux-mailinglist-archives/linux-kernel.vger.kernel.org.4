Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4D27115F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbjEYStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242852AbjEYSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:45:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752C2724;
        Thu, 25 May 2023 11:41:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9231360B99;
        Thu, 25 May 2023 18:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03E5C433D2;
        Thu, 25 May 2023 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040075;
        bh=zTVBAGe5IpiTOsxoBwjhOZjvANq6Q6hCmX75jrclXZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3kD33758JB1zLOVRMJC70SC0CPI+dpgkK2vsvlgGv6Yayfc5EoUAIfQcucdntAoP
         CfZ6ckuDyXNwP3VKbZSm//s7t4/VWPlIWHUQXaZkbPY3NhsdLlKiTSeRIBAuwGOvZX
         MJvMfpc5WOr7EfValW8onZNk5dD6tvC5cExFm9ZFuuFUkX0iCKIhbzc0ntu4n10AHe
         WZvQShMvjjB8iU4NVDXFZ67YZJEO79nDtsG5hINUpVatujG8PiCvV8HFRPQkhU+ZJZ
         dcB3yfuP5CRrD+YLZsbH8jtRQNt6587suISpQnjMJG921wd0dJSCYXPkX4tqx/V5CO
         jMpxXifSJaNSQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, afd@ti.com,
        shifu0704@thundersoft.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 04/31] ASoC: dt-bindings: Adjust #sound-dai-cells on TI's single-DAI codecs
Date:   Thu, 25 May 2023 14:40:35 -0400
Message-Id: <20230525184105.1909399-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Povišer <povik+lin@cutebit.org>

[ Upstream commit efb2bfd7b3d210c479b9361c176d7426e5eb8663 ]

A bunch of TI's codecs have binding schemas which force #sound-dai-cells
to one despite those codecs only having a single DAI. Allow for bindings
with zero DAI cells and deprecate the former non-zero value.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org
Link: https://lore.kernel.org/r/20230509153412.62847-1-povik+lin@cutebit.org
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2562.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas2764.yaml | 6 ++++--
 Documentation/devicetree/bindings/sound/tas2770.yaml | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index 27f7132ba2ef0..6ccb346d4a4d5 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -50,7 +50,9 @@ properties:
     description: TDM TX current sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -67,7 +69,7 @@ examples:
      codec: codec@4c {
        compatible = "ti,tas2562";
        reg = <0x4c>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        shutdown-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2764.yaml b/Documentation/devicetree/bindings/sound/tas2764.yaml
index 5bf8c76ecda11..1ffe1a01668fe 100644
--- a/Documentation/devicetree/bindings/sound/tas2764.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2764.yaml
@@ -46,7 +46,9 @@ properties:
     description: TDM TX voltage sense time slot.
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -63,7 +65,7 @@ examples:
      codec: codec@38 {
        compatible = "ti,tas2764";
        reg = <0x38>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpios = <&gpio1 15 0>;
diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 07e7f9951d2ed..f3d0ca067bea4 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -52,7 +52,9 @@ properties:
       - 1 # Falling edge
 
   '#sound-dai-cells':
-    const: 1
+    # The codec has a single DAI, the #sound-dai-cells=<1>; case is left in for backward
+    # compatibility but is deprecated.
+    enum: [0, 1]
 
 required:
   - compatible
@@ -69,7 +71,7 @@ examples:
      codec: codec@41 {
        compatible = "ti,tas2770";
        reg = <0x41>;
-       #sound-dai-cells = <1>;
+       #sound-dai-cells = <0>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
-- 
2.39.2

