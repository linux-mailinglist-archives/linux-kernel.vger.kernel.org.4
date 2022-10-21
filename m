Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18A607022
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 08:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJUGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 02:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiJUGfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 02:35:06 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3FA27B1F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:35:01 -0700 (PDT)
X-QQ-mid: bizesmtpipv602t1666334073tg8l
Received: from [127.0.0.1] ( [255.102.133.9])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 21 Oct 2022 14:34:32 +0800 (CST)
X-QQ-SSF: 01000000000000B0O000000A0000000
X-QQ-FEAT: wReDU7nm/Q2cX418S7HgcoF6AC1h4+/48kLxk6q0wPna4z/8BeGsMjegOnN6Q
        xpeZP2AcOu5Rawh1IrIeh6uCyHJWIvOdGaaCWoqFBNQuUjt1QUrA/jXbU0DlKrWwX6ewgvY
        0yJbkgsLZ5vrMMLbIEqaOcQ8NasGnEBNzyoYR5wGGFqBrJrvYGu1HNeYuIyyQv75p4v0Ksm
        M3pvf6gXGUfqmWU/qkE8JgBM9B0IAGlKKUr5ZYIhXedZHC7YzZfU7/zysEbLass1pBMPZq4
        ukfTGE7FQRkMQhJgxwOdxfnipGj4vEYpG6eCchAGu0HpXjdhuxTLjpKk54UVi40Jt44/59x
        cUFFAufuuFND3UP9m1TtpekTpVYPw==
X-QQ-GoodBg: 0
Message-ID: <26B141B486BEF706+313d1732-e00c-ea41-3123-0d048d40ebb6@leohearts.com>
Date:   Fri, 21 Oct 2022 14:34:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
From:   Leohearts <leohearts@leohearts.com>
Subject: [PATCH] ASoC: amd: yc: Add Lenovo Thinkbook 14+ 2022 21D0 to quirks
 table
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:leohearts.com:qybglogicsvr:qybglogicsvr5
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        RCVD_ILLEGAL_IP,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lenovo Thinkbook 14+ 2022 (ThinkBook 14 G4+ ARA) uses Ryzen
6000 processor, and has the same microphone problem as other
ThinkPads with AMD Ryzen 6000 series CPUs, which has been
listed in https://bugzilla.kernel.org/show_bug.cgi?id=216267.

Adding 21D0 to quirks table solves this microphone problem
for ThinkBook 14 G4+ ARA.

Signed-off-by: Taroe Leohearts <leohearts@leohearts.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2cb50d5cf..c8df5c25e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,6 +45,13 @@ static struct snd_soc_card acp6x_card = {
 };
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21D0"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.37.2


