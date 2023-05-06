Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861B96F8E0B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjEFC1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEFC1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:27:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8391FC4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:27:10 -0700 (PDT)
X-UUID: 1b0396f14be747d7ab10c651639d7cbc-20230506
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.22,REQID:598fa335-b95e-4456-8747-c87e07d1ef21,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:8
X-CID-INFO: VERSION:1.1.22,REQID:598fa335-b95e-4456-8747-c87e07d1ef21,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:8,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:8
X-CID-META: VersionHash:120426c,CLOUDID:39cbe730-6935-4eab-a959-f84f8da15543,B
        ulkID:230506102704XXE5XP8C,BulkQuantity:0,Recheck:0,SF:38|24|16|19|44|102,
        TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 1b0396f14be747d7ab10c651639d7cbc-20230506
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1713182569; Sat, 06 May 2023 10:27:03 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com,
        tcrawford@system76.com, andy.chi@canonical.com,
        tangmeng@uniontech.com, luke@ljones.dev, yangyuchi66@gmail.com,
        p.jungkamp@gmx.net, kasper93@gmail.com, gabriele.mzt@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for HP EliteDesk 805
Date:   Sat,  6 May 2023 10:26:53 +0800
Message-Id: <20230506022653.2074343-1-aichao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a quirk for HP EliteDesk 805 to fixup ALC3867 headset MIC no sound.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 068ce0db9562..cbb3c3f6d502 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11662,6 +11662,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x1632, "HP RP5800", ALC662_FIXUP_HP_RP5800),
 	SND_PCI_QUIRK(0x103c, 0x870c, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
+	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
-- 
2.25.1

