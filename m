Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17BF3699161
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBPKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjBPKds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:33:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348664DBFE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:33:17 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BBC01660087C;
        Thu, 16 Feb 2023 10:33:15 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676543596;
        bh=bK0Y7TabcwBh5BhbefahWr62u6QwIrNoSLywiOTb1E8=;
        h=From:To:Cc:Subject:Date:From;
        b=WoGjTDIcjHbz6QR37ZypbCE0JttQj5M7mowncgwKOjvxhY4WzLq0U+fjXqwoFUBuM
         MzVG21m03wQ8CHXstLcU2uUWn2I7G7BF0kAenT+w//ZWiqw1c2QRePucwlzsyB3vih
         fY7ZRjFJ2EGlNu8OLK/0nhGI/0ChC2hIxibSkhpVIrLuiLt2/hLtQtkq8VK4tL2uIA
         pKoGdSw/CC4yjAjmt82Zzc4HLoEQ6wUPS4+I+mFyZiwQxFGM4V8/dAJ7I6560xpQaK
         eHTaeaO5SrEznV1ygmwJF3MgmDlSJZmc0QR65EmHyB5IIYoGHN3WWQWL9FTm/jZ0PU
         CLtY+4e92oNIQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH 0/9] Refactor Vangogh acp5x machine driver
Date:   Thu, 16 Feb 2023 10:32:51 +0000
Message-Id: <20230216103300.360016-1-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
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

Provide small fixes and refactor the code for easier insertion of a new
platform using the same acp5x machine driver.

Lucas Tanure (9):
  ASoC: amd: vangogh: Remove unnecessary init function
  ASoC: amd: vangogh: Update code indentation
  ASoC: amd: vangogh: use sizeof of variable instead of struct type
  ASoC: amd: vangogh: remove unnecessarily included headers
  ASoC: amd: vangogh: use for_each_rtd_components instead of for
  ASoC: amd: vangogh: Check Bit Clock rate before snd_soc_dai_set_pll
  ASoC: amd: vangogh: Move nau8821 and CPU side code up for future
    platform
  ASoC: amd: vangogh: Centralize strings definition
  ASoC: amd: vangogh: Include cs35l41 in structs names

 sound/soc/amd/vangogh/acp5x-mach.c | 313 +++++++++++++----------------
 1 file changed, 141 insertions(+), 172 deletions(-)

-- 
2.39.2

