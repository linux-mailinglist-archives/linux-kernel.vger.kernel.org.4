Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6275B677F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 07:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIMFuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 01:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiIMFt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 01:49:59 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B823CB86F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 22:49:55 -0700 (PDT)
X-QQ-mid: bizesmtp74t1663047985tcen11ia
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 13 Sep 2022 13:46:24 +0800 (CST)
X-QQ-SSF: 01400000000000B0O000000A0000000
X-QQ-FEAT: o819FCS+0JRTPs05EElOJLI/CrQekINZ5/Hjm1KQ/EL6h5TQThaZsY6LFGoUt
        +qv3N3nacqJCsisTE6OSwfshzRwU53qT0P1RiljUvtZBZrFao8IhgJhIjPAe7VRONr3BlwO
        APiBRYPU7Lz4hSvWnQAHGEAxdfIWdCGUTb5BgtVGJYYoCRZ2oUt58IfwYIS0VR/jEsGPnj5
        xAhVoiZyk2RuoF4eEH6X2lreVCxVbeIMb4x2RLQU20noRep/C4v4TH9Uw8hf6asFOjXWy/6
        +UPmNfBY+rVMKTHsdLY0DmeKwxTnSLKYzIsS2wA2zXP+n+jgHX+aehWsl0PMjbXokd3ir3Z
        3vPBKF/axenJ79CRD+4P9UwR5c1AlEwRPhg4RTibm0ycrOM6gucSdPOJAWt0jaWA8e0QKV/
X-QQ-GoodBg: 1
From:   huangwenhui <huangwenhuia@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     jeremy.szu@canonical.com, hui.wang@canonical.com,
        wse@tuxedocomputers.com, cam@neo-zeon.de, kailang@realtek.com,
        tanureal@opensource.cirrus.com, sami@loone.fi,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        huangwenhui <huangwenhuia@uniontech.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Huawei WRT-WX9
Date:   Tue, 13 Sep 2022 13:46:22 +0800
Message-Id: <20220913054622.15979-1-huangwenhuia@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes headphone and headset microphone detection on Huawei WRT-WX9.

Signed-off-by: huangwenhui <huangwenhuia@uniontech.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 38930cf5aace..0996a8fd008c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9569,6 +9569,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
 	SND_PCI_QUIRK(0x1b35, 0x1236, "CZC TMI", ALC269_FIXUP_CZC_TMI),
 	SND_PCI_QUIRK(0x1b35, 0x1237, "CZC L101", ALC269_FIXUP_CZC_L101),
-- 
2.20.1

