Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7069F045
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBVIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjBVIdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:33:14 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4AF211CB;
        Wed, 22 Feb 2023 00:33:08 -0800 (PST)
Received: (Authenticated sender: kamel.bouhara@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C5F7424000C;
        Wed, 22 Feb 2023 08:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677054787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KDE/BWKPpbi7naSnpEy52iXA2Q0Af4JEQcVomPlwwZU=;
        b=DvlQdk8HPLbfmm9jbmwikEJa9eR7qqMPpXNbN0XO3XcCLwq/00ZetbU/VRqz3Nb439t4C1
        EVIBrhHy0eq1A86VHhSue/9hYp41qxASWyjQMH03r0au3metRF+xMJ5OGDD7sHq2s5yRFI
        02KpsCng/uwcD+QfOBUB0AVZTcjGjZDZ2YSVWZVMpUTXE473cxr2AsbVPEIqtlpDEZsXR3
        aUW+kMr7QWyizEDsPTPl2D3kGk6rgdioBmXPXw9VjZtBReTSOWZz7Of4rfO/aFpIuq/x2f
        G2QZ83aAfmHI/yjNszl/SK1rnAWrziasT3JTlNm4ZyEYi2fOMlDNGrJEvjx3TA==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Cernekee <cernekee@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Crt Mori <cmo@melexis.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH 1/2] ASoC: tas571x: add tas5733 compatible
Date:   Wed, 22 Feb 2023 09:32:59 +0100
Message-Id: <20230222083300.218523-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
References: <20230222083300.218523-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the tas5733 to the TAS571X binding.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
---
 Documentation/devicetree/bindings/sound/tas571x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
index 7c8fd37c2f9e..1addc75989d5 100644
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -12,6 +12,7 @@ Required properties:
   - "ti,tas5717",
   - "ti,tas5719",
   - "ti,tas5721"
+  - "ti,tas5733"
 - reg: The I2C address of the device
 - #sound-dai-cells: must be equal to 0
 
-- 
2.35.1

