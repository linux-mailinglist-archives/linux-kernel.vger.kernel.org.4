Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4471665CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbjAKNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjAKNt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:49:28 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39E2661;
        Wed, 11 Jan 2023 05:49:27 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9E34AFF802;
        Wed, 11 Jan 2023 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673444966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c9EnZLjG+M9U2ONqhUBGVZCcyMyK2X5wHaN45jR1ceg=;
        b=ByaSXOKvk4XEECyLn27Tk4Ldxvxm05KVnKRViSa66Hk/L1mzTW0KAhZ6+m64s+qGIQCqM+
        elsDF/epIy4V/u2A0zVBt2P49YhXxtnhz/EEMQw12FAkQSf4MOWbu/lZ0NpdyLMDXALo0U
        c87+3x9imIyZz+9/2Ul+WphA2uyg/+LOVsQCfjMHB0TDWuz2vUdZxvSQFcz0UELsZjq2np
        uO8GxdPQ1RhJFZGENK9PdGKov9nFqu+XwcT/Hl8sFe9TfkWs2gCdFGP5aXLT6cA//M1k3v
        vwKzbAx661jtzhKC/OV1y/HvrRMlRTofhyIAdU3iD/U/PtWLVNVDjTYVkTd8KA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 3/3] MAINTAINERS: add the Renesas IDT821034 codec entry
Date:   Wed, 11 Jan 2023 14:49:05 +0100
Message-Id: <20230111134905.248305-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230111134905.248305-1-herve.codina@bootlin.com>
References: <20230111134905.248305-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After contributing the driver, add myself as the maintainer
for the Renesas IDT821034 codec.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9dcfadec5aa3..31115a7e01c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17809,6 +17809,13 @@ F:	Documentation/devicetree/bindings/net/renesas,*.yaml
 F:	drivers/net/ethernet/renesas/
 F:	include/linux/sh_eth.h
 
+RENESAS IDT821034 ASoC CODEC
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/renesas,idt821034.yaml
+F:	sound/soc/codecs/idt821034.c
+
 RENESAS R-CAR GYROADC DRIVER
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-iio@vger.kernel.org
-- 
2.38.1

