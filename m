Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07B7415C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjF1PzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:55:03 -0400
Received: from mail.tuxedocomputers.com ([157.90.84.7]:53170 "EHLO
        mail.tuxedocomputers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjF1Py6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:54:58 -0400
Received: from wse.fritz.box (host-212-18-30-247.customer.m-online.net [212.18.30.247])
        (Authenticated sender: wse@tuxedocomputers.com)
        by mail.tuxedocomputers.com (Postfix) with ESMTPA id 032642FC0010;
        Wed, 28 Jun 2023 17:54:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1687967695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Z4GhpMhowjI3adn6KRB6QmTOLCrGLZf4EOxggAh6oR0=;
        b=Uor1KIlMDCtNMMJXWiMP18vfMHqkxIkJvORHx7fVF00qCebzszSIJxQtX/Ffo5bAwkLoWG
        ntgyyfksXM3BCqtW3jcwPm+65LEKRa/C7S4NdWF91UZC+rbI4uEsX1sCm02wQnJ8+YiAP0
        dLlq+sqqyndC9DezG9XEohph60LNvVU=
Authentication-Results: mail.tuxedocomputers.com;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From:   Werner Sembach <wse@tuxedocomputers.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Werner Sembach <wse@tuxedocomputers.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Clevo NPx0SNx
Date:   Wed, 28 Jun 2023 17:54:34 +0200
Message-Id: <20230628155434.584159-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This applies a SND_PCI_QUIRK(...) to the Clevo NPx0SNx barebones fixing the
microphone not being detected on the headset combo port.

Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f595a250fab33..d2ac56398d554 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9642,6 +9642,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x971d, "Clevo N970T[CDF]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa500, "Clevo NL5[03]RU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa600, "Clevo NL50NU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0xa650, "Clevo NP[567]0SN[CD]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xa671, "Clevo NP70SN[CDE]", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb018, "Clevo NP50D[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0xb019, "Clevo NH77D[BE]Q", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.34.1

