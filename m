Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEC368DDE5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbjBGQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBGQZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:25:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CFE3B0D0;
        Tue,  7 Feb 2023 08:25:40 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C913666020C4;
        Tue,  7 Feb 2023 16:25:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675787139;
        bh=npqt0IMTyKKxWj2IKLUrG7ISyOoM5z/+NANPBGIZ2jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H21yTG4elW4u0ZyA7SwQw9QsMj3uBHskO0cyzPEEcU+/6Aijaf/FJD1r8oRqKCxAC
         8mdajuWMvalXapr3+i5KAJmZ5DrBFZwkf9VAPTZfoCvG+7BHXRXqPO5p3GzDzoJa9H
         6zO4C3hK7QlAn66jFCVrEKSlFmqP3HvUzlvc6eEbfkLTlpLW21T+rHxff+RCSUX3PP
         MQBiLKFZntNir3QoUITDVKY1/gz/NgwT9WjMsrMte25kFwOMAM1r5MEH1aWOpIZtLz
         osLvlxqYWBZ9USZ6vvKkMeDsk8sDlxjP30VB3Eprz1fjDiDyUFxvuZ+ZV5vYQCYSfO
         2Q30PUBU7czGA==
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
        kernel@collabora.com, Lucas Tanure <lucas.tanure@collabora.com>
Subject: [PATCH v2 4/5] ASoC: cs35l41: Document CS35l41 external boost without VSPK
Date:   Tue,  7 Feb 2023 16:25:25 +0000
Message-Id: <20230207162526.1024286-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207162526.1024286-1-lucas.tanure@collabora.com>
References: <20230207162526.1024286-1-lucas.tanure@collabora.com>
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

External Boost without GPIO1 as VSPK switch
is no longer supported, but there is laptop
models using this feature.

Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
index 18fb471aa891..8465623bbd96 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs35l41.yaml
@@ -85,11 +85,13 @@ properties:
       boost-cap-microfarad.
       External Boost must have GPIO1 as GPIO output. GPIO1 will be set high to
       enable boost voltage.
+      External Boost without GPIO1 as VSPK switch is no longer supported.
       0 = Internal Boost
       1 = External Boost
+      2 = External Boost without VPSK switch (Do not use in new systems)
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 0
-    maximum: 1
+    maximum: 2
 
   cirrus,gpio1-polarity-invert:
     description:
-- 
2.39.1

