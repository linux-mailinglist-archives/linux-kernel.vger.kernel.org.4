Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE966A0415
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjBWInn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbjBWInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:43:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A49E2B29C;
        Thu, 23 Feb 2023 00:43:30 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E638666021FF;
        Thu, 23 Feb 2023 08:43:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677141809;
        bh=ULUS8juqT9D663UOmoNu1JrQcrXe/fPV+74I8cFGkeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TENpdt+t0Yvr5vcNTBdb6dDKeDJ1cVNmxMmvwatqCMDmgbo25cy72ILeeU5hSW525
         UdO1JjXjA6SXeIwMeeD0QrWD6nSWlEAVObTOnXWV50MFnAgpQ/q0ImuichQYL0AXl6
         HwVZu2KMUupiqgZlyd3dHBZNOEEA59IfH22ssoGaCtgPFI+Ugdu8Gk6O+pnZdwI+FX
         o+n6hV6ZvJswdbmOnJah4jmbKB8GEYJDowjmwAHydmPCAbuNstj3lrWozHRyjEk/Sg
         uS8dQ1apLrWMaquTiI0VriBwMbUI38JCohGXhfYHTNBrzum33KLTDIaPI1Se254LxX
         k4R3KaPvHXpJQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 4/4] ASoC: dt-bindings: cirrus,cs35l41: Document CS35l41 shared boost
Date:   Thu, 23 Feb 2023 08:43:24 +0000
Message-Id: <20230223084324.9076-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223084324.9076-1-lucas.tanure@collabora.com>
References: <20230223084324.9076-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the properties used for shared boost configuration.
Based on David Rhodes shared boost patches.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/cirrus,cs35l41.yaml      | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 18fb471aa891..14dea1feefc5 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -85,11 +85,19 @@ properties:
       boost-cap-microfarad.
       External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
       enable boost voltage.
+      Shared boost allows two amplifiers to share a single boost circuit by
+      communicating on the MDSYNC bus. The active amplifier controls the boost
+      circuit using combined data from both amplifiers. GPIO1 should be
+      configured for Sync when shared boost is used. Shared boost is not
+      compatible with External boost. Active amplifier requires
+      boost-peak-milliamp, boost-ind-nanohenry and boost-cap-microfarad.
       0 = Internal Boost
       1 = External Boost
+      2 = Shared Boost Active
+      3 = Shared Boost Passive
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-    maximum: 1
+    maximum: 3
 
   cirrus,gpio1-polarity-invert:
     description:
-- 
2.39.2

