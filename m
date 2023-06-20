Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201D6737775
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjFTW1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFTW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:27:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B681985
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:27:50 -0700 (PDT)
Received: from localhost (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D31576606F5C;
        Tue, 20 Jun 2023 23:27:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687300069;
        bh=pMukWB0Dc/yW8XeN7gZs3fKsPLiPAntaM6BWAC5s3ZI=;
        h=From:To:Cc:Subject:Date:From;
        b=VaulE6xZq8PG0Q2I2jrEKrBsPSG46Sr1cnARHj08qnwGyG1VVilmE+1ruQ0E3U7h6
         I2x0VPpvtag6a73EWOiZE0x04qC/mayOpWtQoC+5tj7uwERkcLHogohfZF/VF2ZzdP
         3MiM9DO5q+fRIW54u5dCMTfEUrsUYD1EQRK+JkqoZ+mAZgOSvHABqLJ4BIMOowPzvO
         +8DHy3nImcICOCiY1jr5tw97vsMgAzfei2WbdUXeyB3yyI4SDJCKA6BOKi+nN+xtBI
         +WXRRVrdq2s/TEw/LkpSrdj9Cb+FRpe0208oZKeDWf+/2CHDLz/YDqlo54WQ6lik16
         MyhH0mYD4tBvQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH 0/2] AMD Vangogh support for NAU8821/MAX98388
Date:   Wed, 21 Jun 2023 01:27:41 +0300
Message-ID: <20230620222743.274432-1-cristian.ciocaltea@collabora.com>
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

This patch series extends the Vangogh machine driver to support a variant based
on the Nuvoton NAU88L21 Codec and the Analog Devices MAX98388 Speaker Amplifier.

Cristian Ciocaltea (2):
  ASoC: amd: vangogh: Add ACPI probe support
  ASoC: amd: vangogh: Add support for NAU8821/MAX98388 variant

 sound/soc/amd/Kconfig              |   5 +-
 sound/soc/amd/vangogh/acp5x-mach.c | 155 ++++++++++++++++++++++++-----
 sound/soc/amd/vangogh/acp5x.h      |   2 +-
 sound/soc/amd/vangogh/pci-acp5x.c  |   3 -
 4 files changed, 134 insertions(+), 31 deletions(-)

-- 
2.41.0

