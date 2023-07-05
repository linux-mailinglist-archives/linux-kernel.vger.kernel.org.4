Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCF1748542
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjGENnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 09:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGENns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 09:43:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D041ABA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 06:43:47 -0700 (PDT)
Received: from localhost (unknown [188.24.137.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E18C766020F5;
        Wed,  5 Jul 2023 14:43:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688564626;
        bh=5bjQOEUku2okttevc3PZVpNPoxW8myAeEIowZbKzBIU=;
        h=From:To:Cc:Subject:Date:From;
        b=gwDn4hyIXaJbyClgM1YhDa4/fU1uqKrOviP1psPa+4LrL1wjZHA4ROIzF9LACNKaH
         vX2Y8tw4GWgXzyj/nZQPTXz7HSMAoVTRiBtquILhZDFSFw9SmHYhfpNKaWxbdp5mtH
         HlM73JCEOguZzO4W6HVR7Vn/ado3CZPPfuQlN9gK0EC4XKs2EMrSQhAY5RKmv5pFD+
         lV8BnFfSAfJoXJ35FyzBcF8KPsckZhpr3ZlyXoLmni2BXJXJGj8YtgIj1mpSIhc66a
         SJjW0GO51MlXAxFrcG8XUUZN3tYcQdAEk05/Db6JkZqQKfaM22wb8lS6jHj1pkWxKH
         oWBsXkBj5hp6g==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v2 0/3] AMD Vangogh support for NAU8821/MAX98388
Date:   Wed,  5 Jul 2023 16:43:38 +0300
Message-ID: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series extends the Vangogh machine driver to support a variant
based on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 
Speaker Amplifier.

Changes in v2:
 * Reworked series to ensure the existing devices based on the CS35L41 
   codec continue to work fine
 * Rebased onto next-20230703

Cristian Ciocaltea (3):
  ASoC: amd: vangogh: Make use of DRV_NAME
  ASoC: amd: vangogh: Use dmi_first_match() for DMI quirk handling
  ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant

 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 167 +++++++++++++++++++++++++----
 2 files changed, 149 insertions(+), 23 deletions(-)

-- 
2.41.0

