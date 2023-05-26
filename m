Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B8714197
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 03:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjE2BMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 21:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE2BMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 21:12:44 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95444A6
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 18:12:41 -0700 (PDT)
X-UUID: a8c21dbc527b4ec29d5502ff0c6f1419-20230529
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:aaac015e-6813-4205-a2be-fc0ae4df922e,IP:5,U
        RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:20
X-CID-INFO: VERSION:1.1.22,REQID:aaac015e-6813-4205-a2be-fc0ae4df922e,IP:5,URL
        :0,TC:0,Content:-5,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:20
X-CID-META: VersionHash:120426c,CLOUDID:1983ce3c-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230529091219DBX1WCOU,BulkQuantity:0,Recheck:0,SF:38|24|17|19|44|102,
        TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: a8c21dbc527b4ec29d5502ff0c6f1419-20230529
X-User: aichao@kylinos.cn
Received: from localhost.localdomain [(112.64.161.44)] by mailgw
        (envelope-from <aichao@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 944487003; Mon, 29 May 2023 09:12:18 +0800
From:   Ai Chao <aichao@kylinos.cn>
To:     perex@perex.cz, tiwai@suse.com, sbinding@opensource.cirrus.com,
        tcrawford@system76.com, andy.chi@canonical.com,
        tangmeng@uniontech.com, luke@ljones.dev, p.jungkamp@gmx.net,
        kasper93@gmail.com, yangyuchi66@gmail.com, yangyingliang@huawei.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Ai Chao <aichao@kylinos.cn>
Subject: [PATCH] ALSA: hda/realtek: Add a quirk for HP Slim Desktop S01
Date:   Fri, 26 May 2023 17:47:04 +0800
Message-Id: <20230526094704.14597-1-aichao@kylinos.cn>
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

Add a quirk for HP Slim Desktop S01 to fixup headset MIC no presence.

Signed-off-by: Ai Chao <aichao@kylinos.cn>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a7e4765eff80..70b1e4b91521 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11694,6 +11694,7 @@ static const struct snd_pci_quirk alc662_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8719, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x872b, "HP", ALC897_FIXUP_HP_HSMIC_VERB),
 	SND_PCI_QUIRK(0x103c, 0x873e, "HP", ALC671_FIXUP_HP_HEADSET_MIC2),
+	SND_PCI_QUIRK(0x103c, 0x8768, "HP Slim Desktop S01", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x877e, "HP 288 Pro G6", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x103c, 0x885f, "HP 288 Pro G8", ALC671_FIXUP_HP_HEADSET_MIC2),
 	SND_PCI_QUIRK(0x1043, 0x1080, "Asus UX501VW", ALC668_FIXUP_HEADSET_MODE),
-- 
2.25.1

