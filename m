Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E1F623139
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKIRSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiKIRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:18:08 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B5BE0A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 09:18:08 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id b124so19489300oia.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YnbAgRc0SG1is4s9YE7B1B7B3OnFjSAdcO6sCa2yLhk=;
        b=NOT09UVJK5f0mTzSZl8ZOPwyuPGXRWjmBVrVvfniY7Vt0gyJKBcHiwKfYkhfLeKmtj
         OI3DaOYheHrS3CZvaW2gWokRkcJAZd70Ha+jybu39TSrG7q1qR6o6IwVOaek3tfS5eP4
         rZZ9jKSAPO1phT0S1aj/kql08aCdsCcpM4ieDUiUP5WjfA+wn3YrUYyID2hUto44AH+w
         iXEQolL+iQQBIK4nu3+Ekmbnyqpl4rhTzOZzZmtfXDcnfJKyHvLalhN5AXbTMX9Rvlxo
         2gOxAVPYXbw3Y3elFa0Tmw7Ie6n1hVNO8Nuk1t+TLqPoX4NfWZQWlmVLGOk+hCgyh5h2
         0uNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YnbAgRc0SG1is4s9YE7B1B7B3OnFjSAdcO6sCa2yLhk=;
        b=DMuk9tIbg8WQO7hJUT2PlopiIYlr/HtEtBdedTTIrZuQb1+LuO8eLIGPjLIAydLku6
         +6HkKCiRYsSuIJX4u3swmU+vkHbobYqLuciaNbiE2FEGTDf7b7W4y8kKoasYRxqrsivJ
         qoKr76UW9xwLTFnAHUSY8kP8RvDZ+phKPWSv4DZ2aqk95HYpyS8U2/CeTMmFw2vda5Ua
         u0Q/oc/oDg6nfLyHME7sYEU0KFyCpqGNpJftVRv0c+L2U0ssQd1WEtmhgMSO9OmRE3K1
         6dx0jAN853VUPY7Vr7YkTJnJwHuny3Sn1FkjFQXJ6ymGl/qqN07qpIw0YtORDaaFuNPa
         tr/w==
X-Gm-Message-State: ACrzQf2Q5MK27JkefsVwTfdcaCIABacjFTWiL+U4s1kExtaWfMhzJU6K
        kmHwoax2h9iz1SWZ1Mbv7nk=
X-Google-Smtp-Source: AMsMyM7LBsKqFCrAhqRYjQytYpTyHbWZMCi2oiu7E5nfZFygmwpCSzk2lQddELwc+dRT799FEp9apg==
X-Received: by 2002:aca:ac82:0:b0:359:d662:5bfb with SMTP id v124-20020acaac82000000b00359d6625bfbmr33911565oie.218.1668014287353;
        Wed, 09 Nov 2022 09:18:07 -0800 (PST)
Received: from x-VJFE44F11X-XXXXXX.cardume.local ([177.134.206.108])
        by smtp.gmail.com with ESMTPSA id q5-20020a9d6645000000b0066c15490a55sm5471674otm.19.2022.11.09.09.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 09:18:06 -0800 (PST)
From:   Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, tcrawford@system76.com,
        sbinding@opensource.cirrus.com, kai.heng.feng@canonical.com,
        tangmeng@uniontech.com, tanureal@opensource.cirrus.com,
        p.jungkamp@gmx.net, wse@tuxedocomputers.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        edson.drosdeck@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Add Positivo C6300 model quirk
Date:   Wed,  9 Nov 2022 13:17:32 -0400
Message-Id: <20221109171732.5417-1-edson.drosdeck@gmail.com>
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
index 701a72ec5629..7875566d6183 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9608,6 +9608,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1849, 0x1233, "ASRock NUC Box 1100", ALC233_FIXUP_NO_AUDIO_JACK),
+	SND_PCI_QUIRK(0x1849, 0xa233, "Positivo Master C6300", ALC269_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
 	SND_PCI_QUIRK(0x19e5, 0x320f, "Huawei WRT-WX9 ", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1b35, 0x1235, "CZC B20", ALC269_FIXUP_CZC_B20),
-- 
2.37.2

