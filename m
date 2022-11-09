Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA74622FC3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKIQJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiKIQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:09:36 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B414460F9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 08:09:35 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso19351682fac.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 08:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+ciU0sT4u08NPKcl9DaTETZGeZkMHiw1jZdMv7xqPA=;
        b=Nhzsx/MXbsrcTW6OPRS65Q2x1pW8SkzzX0qe0CPMwyqh6lMJioVuYKk8cZdhlyiHk5
         CDd/Zbz3ZfSElh9nXrQMGB6+EVviYtfJ4SVTgn2HBHJg/8WsM6ksrNbTju4Q8oavP7oN
         NcWCXx+6+8hGQY+KIoezMKuC2y3IltPSnMnx45tQs4APRne1Yqzb/aZhAxueIKRJ2V/X
         YoekutVytnKf47rkRISok7hKDpCsG5WO5ogvDr7tnfsioxiWmlvpmZIvF7Gs7SwuoIPZ
         csK8/CkNPB6caBjEUdrOSGFl5OEis/wIDi0VXBGJIw3gfoyQ50cayCbq+6MAYqdRMLLT
         krtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+ciU0sT4u08NPKcl9DaTETZGeZkMHiw1jZdMv7xqPA=;
        b=XglWNv2132vP4jncLz+nMJUY8v4kZFuonmBb3HMkQZO9DYdiGwB0BNiU/3+akDVeDj
         3ZtRTVnlstR8j+t7CKRHJNn/TZA8Nc/4HVoK8Zj3wEMEQZZtoSgpeYCJEjTfe7Tbcmit
         FGWaH0VX67zl7MxB6p/NEA4ktGCYKudBF2wKfYLKfrvODgJjSuwJ7wHBT9GBYD27mpqH
         6cz/3iRkqqAUQVoBBnlryMW4VJz+wI+sifAquY1hEjBRdXsDOxsT/NeGEQsbI/5aR7MP
         xDwIJ+gbgFGDLt2aRARSIcIEDkPKbk5YHtEZgLNQbnvqTAfsZn6+yeCye5TiFkrcBDrM
         3Llw==
X-Gm-Message-State: ACrzQf3F+JG2sQtF3YQnm4iFZQkHauhf4va3wG5jlZFVKRMFd5+hsp6U
        kQUl81Ejf+10Dw9LNChvFx8=
X-Google-Smtp-Source: AMsMyM6wwbn6xwC/Fg/sKQ455dcLPp7rGKAYrAwqHjIU7B0a7G/zSF7QfASMHfrCtAWW1JzmgUwR/w==
X-Received: by 2002:a05:6870:610d:b0:13c:3fc4:4e9d with SMTP id s13-20020a056870610d00b0013c3fc44e9dmr43974657oae.156.1668010174847;
        Wed, 09 Nov 2022 08:09:34 -0800 (PST)
Received: from x-VJFE44F11X-XXXXXX.cardume.local ([177.134.206.108])
        by smtp.gmail.com with ESMTPSA id u16-20020a4ad0d0000000b0049ea9654facsm4273704oor.32.2022.11.09.08.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:09:34 -0800 (PST)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, tcrawford@system76.com,
        sbinding@opensource.cirrus.com, kai.heng.feng@canonical.com,
        tangmeng@uniontech.com, tanureal@opensource.cirrus.com,
        p.jungkamp@gmx.net, wse@tuxedocomputers.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Add Positivo C6300 model quirk
Date:   Wed,  9 Nov 2022 12:09:09 -0400
Message-Id: <20221109160909.4578-1-edson.drosdeck@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Positivo Master C6300 (1849:a233) require quirk for anabling headset-mic

Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 701a72ec5629..ad2987888966 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9608,6 +9608,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
+	SND_PCI_QUIRK(0x1849, 0xa233, "Positivo Master C6300", ALC233_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
-- 
2.37.2

