Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364A470F627
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjEXMW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjEXMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:22:25 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620389C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:22:22 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:59b9:3473:f0ae:e2b7])
        by michel.telenet-ops.be with bizsmtp
        id 0cNL2A00M5NiV2706cNLJv; Wed, 24 May 2023 14:22:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1nVF-002xw8-Ac;
        Wed, 24 May 2023 14:22:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1q1nVU-00DPC7-AZ;
        Wed, 24 May 2023 14:22:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Osama Muhammad <osmtendev@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] regulator: core: Fix error checking and messages
Date:   Wed, 24 May 2023 14:22:16 +0200
Message-Id: <cover.1684930647.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series corrects an error check, fixes error messages when
debugfs is not enabled, and improves debugfs error handling in the
regulator core.

Changes compared to v1:
  - Split in two patches,
  - Improve rationale.

Thanks for your comments!

Geert Uytterhoeven (2):
  regulator: core: Fix more error checking for debugfs_create_dir()
  regulator: core: Streamline debugfs operations

 drivers/regulator/core.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
