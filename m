Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD3F68C07C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbjBFOtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjBFOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:49:34 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B82125E25;
        Mon,  6 Feb 2023 06:49:29 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 11B9360011;
        Mon,  6 Feb 2023 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675694967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCdYyqkSk91FGT2k2pmAC91uCq4Q0ikwYZO1U2uUWbc=;
        b=OP2hH2uBf0k0FjW+qDpKsiyI4NEqaiPGXNjF0y8inO3q50Fg4X6ThDa7XY3yPVx1vTcpIz
        EHUtbquhVj0NRMMgQRH88N7CQrbbjhjPS1MvSTtoSgYIHhORRbF1vBJPz9bCc4xaOTLBFY
        txCPHhwfRQMj6ggpQv4fSNvstpp62MkeIbEZNR/Exf3/HBb5Tfp6b6uSB5CHo3bBlZKfF8
        wSfB9VnEbMIrHZVxTu5dXQLhNavJ3li5UQo2xIC3LhchZwR0+a/ksk9fcp/F2TKzEm/tWl
        jn2iiUxbDiNrUTO2uoQOxaLKykF8xhw7D25rt22Jt6ff+l13iu4iO2MzKU0vCg==
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
Subject: [PATCH 3/3] MAINTAINERS: add the Infineon PEB2466 codec entry
Date:   Mon,  6 Feb 2023 15:49:04 +0100
Message-Id: <20230206144904.91078-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206144904.91078-1-herve.codina@bootlin.com>
References: <20230206144904.91078-1-herve.codina@bootlin.com>
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

After contributing the driver, add myself as the maintainer for the
Infineon PEB2466 codec.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd22e8e06561..0cd8a4d1f7b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10184,6 +10184,13 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/pressure/dps310.c
 
+INFINEON PEB2466 ASoC CODEC
+M:	Herve Codina <herve.codina@bootlin.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
+F:	sound/soc/codecs/peb2466.c
+
 INFINIBAND SUBSYSTEM
 M:	Jason Gunthorpe <jgg@nvidia.com>
 M:	Leon Romanovsky <leonro@nvidia.com>
-- 
2.39.1

