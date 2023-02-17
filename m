Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B869A9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjBQLKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBQLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:10:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B57566CE4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:09:35 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFEDB660212E;
        Fri, 17 Feb 2023 11:09:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676632174;
        bh=2EN/utsOcccxHsG8Ua9etBSupDjzX48yoJ+ybSvNK94=;
        h=From:To:Cc:Subject:Date:From;
        b=hBG26YnzPlGdkTQORH6zGjRvl6FmBicptS+a8P4xEA1kzV6MoQ90iRgKnQFMNL/D5
         Zmb9GlPwJiKWuzSdc8J2rTKJvMzjCjjaW3QVtOwavxMuub2QZysbyP7c/E1Qvgg/vZ
         ZF7auZXnf4vbBLCuZKFnOW1LWY4mBtasYteGGPYlP1wGp1TFsVH9P5O/N2kCUboyvW
         5baqQS/KH8WphRkkaOekCl9/BJRaAC/nZFS3eiUYTY50yfpFMWtPkUjXA2lJjRUczD
         Epav0chkx+XbpjU55xeuTNiEEbpARIWA+M0BED+4dpTBbZ7Xy3e8YOYtq6Oro+K0Yz
         HvBjnkl10CpMQ==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>, kernel@collabora.com
Subject: [PATCH v2 0/9] Refactor Vangogh acp5x machine driver
Date:   Fri, 17 Feb 2023 11:08:41 +0000
Message-Id: <20230217110850.1045250-1-lucas.tanure@collabora.com>
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

Changes since V1:
 - Don't use smaller variable names
 - Don't use 100 limit for all lines
 - Use component prefixes to avoid collisions
 - Improved commit messages

Lucas Tanure (9):
  ASoC: amd: vangogh: Remove unnecessary init function
  ASoC: amd: vangogh: Small code refactor
  ASoC: amd: vangogh: use sizeof of variable instead of struct type
  ASoC: amd: vangogh: remove unnecessarily included headers
  ASoC: amd: vangogh: use for_each_rtd_components instead of for
  ASoC: amd: vangogh: Check Bit Clock rate before snd_soc_dai_set_pll
  ASoC: amd: vangogh: Move nau8821 and CPU side code up for future
    platform
  ASoC: amd: vangogh: Centralize strings definition
  ASoC: amd: vangogh: Add components prefix in structs and function
    names

 sound/soc/amd/vangogh/acp5x-mach.c | 297 ++++++++++++++---------------
 1 file changed, 144 insertions(+), 153 deletions(-)

-- 
2.39.2

