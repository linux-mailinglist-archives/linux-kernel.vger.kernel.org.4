Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D885743398
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 06:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjF3Ebi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 00:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjF3Ebc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 00:31:32 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C92D78
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:31:31 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E6CF632007F9;
        Fri, 30 Jun 2023 00:31:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 30 Jun 2023 00:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688099489; x=
        1688185889; bh=Q64xPEy+iwbg0p9qPUFnYa3X3kv5WuO+YEFt9NA2p98=; b=b
        DxnBbak+dDSQpYUvRE6BUGvW9Qv1/y0gufEzS7Ik0XxaeBImMbux6KqHdTsycYnG
        iOlhPK6F2iuH7tTm+j8trUnhgOTH2rqsbcTAuGhPtRxkgvm5FPd+T3BZa9JHyHIf
        7YSmjU5/6P7mK5RCA99ytLqyuYLu4zZdXGFndeQBQfGVJPhpwKa9f/HQydD9hFEU
        sa+/ek25PCnYVVTZ/cVZEOORd8w39oznoPwkQKj0a0LoKg7IlxC5ZwIsSZZVjOuN
        xCFy+1/coahs4BuGtFLo9XGlzAkuzgaOFBhQmjZEyShLx+jxDk3TJFtilTeWnzzu
        v0xfadTruu0RrrYaQ01kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688099489; x=
        1688185889; bh=Q64xPEy+iwbg0p9qPUFnYa3X3kv5WuO+YEFt9NA2p98=; b=f
        AxpZtIApHcQdJ1RmxDNHBOKp3mGS0GvfidjX7wVwpWc+P0Of6eUYxtpiAWRoOWLz
        QMn5odcBjqVryXjgs840Z5uvZldJA1imIEl/k83Wqh7xf3iiliEteBNgqAPLfbe9
        KWd02q8K+anDdzTEbSjYAleJDhBRVEim6XLvo4l4tj1HghqYcafSyo/tD4iscmji
        D/P9gK4uzGsdmoo3Fr6khSc4Tzsv8WG73c3KiipxkLb6XYMwZX6SBNcH8QLJji7a
        9WaDCUI1RCZxqri4LDNP184LqPf/6L5sS7EAX1FJWd8HKbZvMQCxyuoma8tKWrgK
        2BxmeuGgDrKXAp+Zl0UhA==
X-ME-Sender: <xms:oFqeZAJKyWZU10V_KTj88t8MnFrbS0Q4TeqdnxEsXfQ0JIh6ABPEew>
    <xme:oFqeZAJrANoLjI6ZNHaWZZPussedeQ05lRFBzuzsVMEhCQWSyEZuyDrQ1O-kFMC1Y
    TLl37TH_yYucOyfMhE>
X-ME-Received: <xmr:oFqeZAu0iYtsOrIoxlc-WskOBooiQZgroCKiYJxiozE2x_Sl65Mv8VRwMzX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdehgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepfdfnuhhkvgcuffdrucflohhnvghsfdcuoehluhhkvgeslhhj
    ohhnvghsrdguvghvqeenucggtffrrghtthgvrhhnpefgteefudfgteduueehteejhfeugf
    fgleeltedvveethfeuueejfedvgeelveehgfenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehluhhkvgeslhhjohhnvghsrdguvghv
X-ME-Proxy: <xmx:oVqeZNb2aupFgglUdH14aQpuvSA-Z5CcZQyHD498Cfab_fv6gRadRg>
    <xmx:oVqeZHYh20ZY7MSmRJVFsCHZFM5gAAv0pZyOmj-93R5lDXjNk2xYgA>
    <xmx:oVqeZJDfC7mVrmJttlSrd2Pi3f889BRKGsw-mWV9k3UVESDbMvi3gQ>
    <xmx:oVqeZCyQbo94Svc8sC7PGxyJN_ar9rusu1BF0wk-SydbcfxR66T21w>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jun 2023 00:31:26 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     perex@perex.cz, sbinding@opensource.cirrus.com,
        andy.chi@canonical.com, tangmeng@uniontech.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH 2/2] ALSA: hda/realtek: Add quirk for ASUS ROG GA402X
Date:   Fri, 30 Jun 2023 16:31:06 +1200
Message-ID: <20230630043106.914724-3-luke@ljones.dev>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630043106.914724-1-luke@ljones.dev>
References: <20230630043106.914724-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the required quirk to enable the Cirrus amp and correct pins
on the ASUS ROG GV601V series.

While this works if the related _DSD properties are made available, these
aren't included in the ACPI of these laptops (yet).

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1c26f24b1246..5b7df324e8b4 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9544,6 +9544,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
 	SND_PCI_QUIRK(0x1043, 0x1433, "ASUS GX650P", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1463, "Asus GA402X", ALC285_FIXUP_ASUS_I2C_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1473, "ASUS GU604V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1483, "ASUS GU603V", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1493, "ASUS GV601V", ALC285_FIXUP_ASUS_HEADSET_MIC),
-- 
2.41.0

