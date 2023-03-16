Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201EA6BCF75
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 13:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjCPM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 08:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjCPM2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 08:28:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5A0C0812;
        Thu, 16 Mar 2023 05:28:09 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 2DBBA1BF20B;
        Thu, 16 Mar 2023 12:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678969687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DV4CC5O5iyRa+8OQdtxcgwDs8G2cCnQDmrmdt77V24E=;
        b=W9X0VEUTnKlIqDMIQhKIIklbmTh83DTK5aI7TJxCI9EaaYxcRQPF/+zHObVTAuaPycXCLu
        Br7j/H6/YAKyoGPkmyVcCdOEI6BF7cvDZ8JH47BlDES/o5e2fvt06tnWCyvo6mhaQ2TVFB
        iqPPIF3lx4MTvoig1qfHCfecccARmSiC93pv0Px96lS9UdUUOsWudqXQNQlcRq9yMaaFwk
        HtMisZsmDSIvOsLsw6aVruKG11UElfDN6UFwFHFKzaVocXkJaU5X/tBaMwpp4uv9J/ewfy
        Eg4Kd9tMlD1uY/cdCHMMCX9LJ1wcCCxYyweaY3ywaEDvW3DU5Oq7du5AWsQugA==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 7/7] MAINTAINERS: Add the Lantiq PEF2256 ASoC codec entry
Date:   Thu, 16 Mar 2023 13:27:41 +0100
Message-Id: <20230316122741.577663-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316122741.577663-1-herve.codina@bootlin.com>
References: <20230316122741.577663-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After contributing the codec, add myself as the maintainer for the
Lantiq PEF2256 codec.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b258498aa8ac..81c17580b402 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11651,6 +11651,13 @@ S:	Maintained
 F:	arch/mips/lantiq
 F:	drivers/soc/lantiq
 
+LANTIQ PEF2256 ASoC CODEC
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/lantiq,pef2256-codec.yaml
+F:	sound/soc/codecs/pef2256-codec.c
+
 LANTIQ PEF2256 DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 S:	Maintained
-- 
2.39.2

