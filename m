Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD074686D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjGDEqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjGDEqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:46:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F39133
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 21:46:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B4F715C0299;
        Tue,  4 Jul 2023 00:46:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 00:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688446004; x=
        1688532404; bh=jb2n+5UKA8F+ONcy+bqS08w50jdjpmZx/ZLehjCOwE4=; b=b
        ur6XIeY1sGZCXS69ZsSeNBI87TlDUvM9ZXxRPYxBdgugYyQFwUcBMs5nCCo7RObw
        ZZJBAfhtcmlyStyNu7zLSqwbRujD+HI7Wzp3W22qwZTKl+CKXYUnPpufjIrunDmt
        ryRFf2Kb7C8zZZYjRI+6bctpHKiwYBIiQ+wgt82XUJFyPRP6e2zYMfpp5VvV9zt5
        +pNwKjmKxkqLty5AardfEnb4ixe7W5F5YDgwH7z/NjfZyp1wcIwD37Jt+pnRsbPn
        r1EOflvaClwW5Irxldft0/eTQ7c0Z9sKVwoIEhTzgzqDHbg4ARaO90qCD9MKcyZB
        ofgKVPIfWHSdrOASRazKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688446004; x=
        1688532404; bh=jb2n+5UKA8F+ONcy+bqS08w50jdjpmZx/ZLehjCOwE4=; b=A
        TgcIOiXtRssanSmuBSlGT0ksYPxZ69PdhcBw4/ZFtLrKjO5u3z+KIZP07R/F7lF+
        klPeK24qDv7JvPJR+vdlVKBy+N99jIgnUyORowipH/q4xzhsK221Ik0/nW87glh8
        gfn1NxshqNWUV3TIJAQNVl/kB7DF+N1r9pRjLFUkbcpJ9ezRg5PYFlSYBh/SbV2R
        p+VLDa1e9FJOHVlhPMoJNB5zPH1HND7DFeDPvGJIMRyx2uu+Zna7n+WrKuni1StY
        jWGttR2CwPANpHpqy7bSmAFeiIg/rpeBvQjn/PNitCyCPIY7JR0nD8KICBeJaCF4
        GHyB2K8vg7PnmWBYcjVvg==
X-ME-Sender: <xms:NKSjZB-Sg9jtneFxkWyUdYuWwgj5tzLp7V48jakS771bpHG68Aii0A>
    <xme:NKSjZFst10MYJmpF0EZivN0z5YNMbIntBxkVsw4c4G1uabY5oem_iO1kxeKltbEW3
    dJhf4AidpG-esrge-s>
X-ME-Received: <xmr:NKSjZPBpoub5V4YSynJtuehwFVBhTH-WyQPI8UWAJnHCB-71xE7Teq7KyZh7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedunecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:NKSjZFcneCy-eplZ1rtt7VjNHx4-oqITbnnrJe3VxxhguWHVySvWfw>
    <xmx:NKSjZGOu-NTUPH9gaFf90aUDFDioLqSJpTtVJei1hFR2qgf0q7ku5Q>
    <xmx:NKSjZHnOuTgBPCMiLM3CMyRtFAtoyt--YpznmXvXGV4MORXUGv6UZQ>
    <xmx:NKSjZHlxNAi1VipEWOW75yFAI4eYIitUd4PP9h7XsoNMsOUNmRQUEQ>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jul 2023 00:46:40 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tcrawford@system76.com,
        tangmeng@uniontech.com, p.jungkamp@gmx.net, kasper93@gmail.com,
        ruinairas1992@gmail.com, yangyuchi66@gmail.com,
        yangyingliang@huawei.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/5] ALSA: hda/realtek: Amend G634 quirk to enable rear speakers
Date:   Tue,  4 Jul 2023 16:46:17 +1200
Message-ID: <20230704044619.19343-4-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704044619.19343-1-luke@ljones.dev>
References: <20230704044619.19343-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amends the last quirk for the G634 with 0x1caf subsys to enable the rear
speakers via pincfg.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1fae8e8b1234..50becdc86daa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7068,6 +7068,7 @@ enum {
 	ALC285_FIXUP_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_HEADSET_MIC,
+	ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS,
 	ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_I2C_HEADSET_MIC,
 	ALC280_FIXUP_HP_HEADSET_MIC,
@@ -8060,6 +8061,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1
 	},
+	[ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170120 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_ASUS_HEADSET_MIC
+	},
 	[ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_speaker2_to_dac1,
@@ -9622,7 +9632,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
-	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d4e, "ASUS TM420", ALC256_FIXUP_ASUS_HPE),
-- 
2.41.0

