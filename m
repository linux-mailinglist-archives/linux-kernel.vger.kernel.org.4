Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FED6CB888
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjC1HsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC1Hr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:47:59 -0400
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E15422A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 00:47:47 -0700 (PDT)
X-QQ-mid: bizesmtp63t1679989626tk9po50m
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 28 Mar 2023 15:47:05 +0800 (CST)
X-QQ-SSF: 01400000002000C0U000B00A0000000
X-QQ-FEAT: TLc+rbMvNaE+nE3SnZ+3+7es3kKdIQBtKVQX21T6pNfaatXG4vTua8qg1dTZX
        K/P7NUDGKVVASzpQJ5/HcjUuyJ1VOI+1xI+wbND0fARl0Q2DbYVCWxGc9F6Au+rffDiZ0h/
        6imfCFSjCGpRqXhd9z7XZJ3Ov+WtTG6vq0O2W7z6MwAz/R3gGhHk3ocVgC0uiAOZPzhZOq9
        JWgZ1ZAI9Nt8Fq2TGwHh8xv/l4X8BCkzo06zJOoKBP2p3BV9uiR1m1wYc0FNd4ysNAn+j46
        +GgPEbfqYZ6IJLusGSLOsHzQ9Ml0TalleSE930rHywEVYQ8rg+B00rtQXHkvTpkj4sn5sY5
        5oC7tVxu1lb54tquG4fjqHQ/G8WX+uDCj60ewNWWnGZlrBhBzEiegWj3JsDUQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6170109501948158026
From:   huangwenhui <huangwenhuia@uniontech.com>
To:     tiwai@suse.com, perex@perex.cz
Cc:     jeremy.szu@canonical.com, hui.wang@canonical.com,
        wse@tuxedocomputers.com, cam@neo-zeon.de, kailang@realtek.com,
        tanureal@opensource.cirrus.com, sami@loone.fi,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        huangwenhui <huangwenhuia@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo ZhaoYang CF4620Z
Date:   Tue, 28 Mar 2023 15:46:44 +0800
Message-Id: <20230328074644.30142-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix headset microphone detection on Lenovo ZhaoYang CF4620Z.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
Change-Id: I89d3f4d1d18193418f74d0095b0e4daaf24c839f
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e8b7f6bbfc59..a8810231a5b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7137,6 +7137,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x17aa, 0x9e56, "Lenovo ZhaoYang CF4620Z", ALC286_FIXUP_SONY_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
-- 
2.20.1

