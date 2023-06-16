Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A5C732E61
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 12:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345091AbjFPKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 06:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345152AbjFPKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 06:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249BB4EFB;
        Fri, 16 Jun 2023 03:27:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E45662DD8;
        Fri, 16 Jun 2023 10:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5BCC433C8;
        Fri, 16 Jun 2023 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686911220;
        bh=i57qNS+2sh3gzyzCZQ7Cbft8IG32I1yrZjtydsa4q1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LdcqmpaJeAd/CgE60f3NJg9pbHcCwFagCfrHpu9ZgXlyQpUK7HRnQIrdao5HymXO6
         24qUbNc2N/GiLKBdMTP91NZYok7uK71hXhSduFqFTmEJDTH8DVscB2J8IbetFMpPPL
         ZN16qfDHO1sk5TADeC+84kCMsannyNhThFtrg/5Qggjv8RJvyZ3RhdO94CRt22DGYO
         dsE5beFmddyi8B90/6cFW/uMYqd7dpSML3sCMoAoZ+6eMJeRs1Nem8S7vM5IBMzhMz
         zq/0TITKNK10p8tPWy2Va4db8h3OWJbwFQJhwvdh4vKrQGC/cgj6fc2VYyhT8hgIqk
         7kpVFQR6LwEKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Sayed, Karimuddin" <karimuddin.sayed@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sayed@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com,
        tcrawford@system76.com, tangmeng@uniontech.com, luke@ljones.dev,
        andy.chi@canonical.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        yangyuchi66@gmail.com, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.1 16/26] ALSA: hda/realtek: Add "Intel Reference board" and "NUC 13" SSID in the ALC256
Date:   Fri, 16 Jun 2023 06:26:13 -0400
Message-Id: <20230616102625.673454-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Sayed, Karimuddin" <karimuddin.sayed@intel.com>

[ Upstream commit 1a93f10c5b12bd766a537b24a50fca5373467303 ]

Add "Intel Reference boad" and "Intel NUC 13" SSID in the alc256.
  Enable jack headset volume buttons

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Sayed, Karimuddin <karimuddin.sayed@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20230602193812.66768-1-pierre-louis.bossart@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7b5f194513c7b..42bd8ae5892b6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9588,6 +9588,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -9807,6 +9808,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
+	SND_PCI_QUIRK(0x8086, 0x3038, "Intel NUC 13", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
-- 
2.39.2

