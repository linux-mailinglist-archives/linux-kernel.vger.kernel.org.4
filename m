Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E085749AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 13:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGFLmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 07:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbjGFLme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:42:34 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C641FD6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:42:11 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5979:7b6f:39a:b9cb])
        by michel.telenet-ops.be with bizsmtp
        id Hni62A00245Xpxs06ni621; Thu, 06 Jul 2023 13:42:08 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN3-000far-HA;
        Thu, 06 Jul 2023 13:42:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qHNN7-000QkC-Qh;
        Thu, 06 Jul 2023 13:42:05 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/3] regmap: Fix REGMAP selections
Date:   Thu,  6 Jul 2023 13:42:01 +0200
Message-Id: <cover.1688643442.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes several missing selects related to REGMAP.

The first patch fixes a serious thinko I made when making the regmap
KUnit test depend on REGMAP.

The last two patches fix missing selects I discovered when diving deeper
into the REGMAP_* => REGMAP logic.

Thanks for your comments!

Geert Uytterhoeven (3):
  regmap: Replace "default y if" by select
  regmap: REGMAP_SLIMBUS should select REGMAP
  ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ

 drivers/base/regmap/Kconfig | 16 +++++++++++++++-
 drivers/mfd/Kconfig         |  1 -
 sound/soc/codecs/Kconfig    |  1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
