Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251E36BB4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjCONn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjCONmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:42:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CD18EA3B;
        Wed, 15 Mar 2023 06:42:50 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 57D2740009;
        Wed, 15 Mar 2023 13:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678887768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DV4CC5O5iyRa+8OQdtxcgwDs8G2cCnQDmrmdt77V24E=;
        b=UCbgN/TTtdKV/9x8toXtsODqKW0O040mbJ9e/phujjg/Qc+3nYDRI99siod/Tu9ZcK8hZD
        iYBqUY7ePJgaGyROhbCesrw0CsU0DG9qZt3XyONF+/6KkCVI7hegBXoS4seKuiphZc8zqr
        VJi2j9xVRYyRYeM8sBX7GHyUFj7bdBoLBz65A/RvAx13Uzn9/Ahbu89I163QhpxxQ4YaN5
        3CUm0DvwoFocoKE8yCgpIWbN+vnqHmW6JaM4VUEuZrGRhrN8VEbFVD6Zgy6Qlh2LZ44jkA
        vl937cZXH16OQLXz6RvyWU7dF3I8AQvBf5Fykoa0/Fjc8uTZxvxzuTCakr7R+Q==
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
Subject: [PATCH 7/7] MAINTAINERS: Add the Lantiq PEF2256 ASoC codec entry
Date:   Wed, 15 Mar 2023 14:42:31 +0100
Message-Id: <20230315134231.233193-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315134231.233193-1-herve.codina@bootlin.com>
References: <20230315134231.233193-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

