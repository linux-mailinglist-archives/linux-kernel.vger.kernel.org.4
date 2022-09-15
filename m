Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE865B95F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiIOIKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiIOIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:09:49 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B70186FF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:09:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 167A93200B73;
        Thu, 15 Sep 2022 04:09:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Sep 2022 04:09:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ljones.dev; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1663229386; x=1663315786; bh=0Q
        04mFgRD7edEsHcym+fN9UcJx2DHyn2Ew32bsA9ExQ=; b=Luzsp/ba1qz1kBcZ3m
        t87N6zIxxrDhm2MvOVnj+ZgtpcPD7ve40DbxQHrGdAzPCJ/1b4/cHbnpKtNXBqmk
        +miEadMKEmYUPj3iOCbaAvzVonBbZjIS0ePprqsmb72lWNVbZX2SshXcVZzOZx9b
        iIO0ny3uVedfix/LAMzMzYQHxmZqtWw1Tlg+5tamgxy3fyOof06/H/dPA1Rm7qHx
        52OVZTIj8EhutFiYuA9zQUUoW/1/cVRjmqo24Nq5Zx41Xo5w6v9mM54AaWmJ4i50
        U3e6LjJsjt6hSyKOEpp5x5DdSmUxcIFO74Ji+h9yDIV0epsltf7nqgTVkaWqaoZg
        sdgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1663229386; x=1663315786; bh=0Q04mFgRD7edE
        sHcym+fN9UcJx2DHyn2Ew32bsA9ExQ=; b=EP2EFni2DQQWxuZh6jWnRfT2WB+z8
        t3DDaxhzIgAG1LXYCkj2j1nQbUhnFmqnKEj5RKg6X5jpLxaFfwJWSH6iEPEUq8ta
        dL4xyS2vylwZb/sXl/HPXHCX3qxZgpGENSHmAhYrp3zIbzTKVf2GaaJtK36CIdn0
        9cQP1xQI1c6fALolle+2xFc4OjnvHlD+067huWJYeGFXmMKckyJw8rw/uVa41n2T
        CvQv9DDDVklLuyxjlxSjIXNnDIwcyME1dZaylB5EICzOUm3w1qV9Ku7NS7bfRthP
        D2etX6ln/G1L7eilnKITMRzmOQhCFnwlvvwMhrG5hirLrlSY3gUunjN1w==
X-ME-Sender: <xms:yt0iY9cZPhTkSGIxk7e0YiTiDhWUM9aMMu9rFRtIg7FJKHYKPziNJA>
    <xme:yt0iY7NG0vUvCKezU3mr2lWuDuWbMpha5ayrAgx2MrdAZJEMdS5KCn2ILWMbUkYUu
    RNg01216AoP5JR-h9s>
X-ME-Received: <xmr:yt0iY2hEcfT6NTwj27wPQwozdVH_iaaLx6w02ANy-e2-wnE1Wu4PJvfTWTal>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpedfnfhukhgvucffrdculfhonhgvshdfuceolhhukhgvsehl
    jhhonhgvshdruggvvheqnecuggftrfgrthhtvghrnhepgfetfedugfetudeuheetjefhue
    fggfelleetvdevtefhueeujeefvdegleevhefgnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheplhhukhgvsehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:yt0iY2_8clyP5Z7kVrMf4zkLVFkVhp3FaHOqOh8Z4vOI8XfpGO34pA>
    <xmx:yt0iY5v5WOCi6sV0Vu9Ezai_EMaQR-39umNDnRNEett7WkeQA4MO1w>
    <xmx:yt0iY1El7nuug-pFavGj2OLffYG8fgHr7QWE0sW25dqchKae84Ytiw>
    <xmx:yt0iYy5_sUM4WJogGFc3e7hQmjlpyB6S0qk_LyyXohmiRct2OtEYKw>
Feedback-ID: i5ec1447f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Sep 2022 04:09:44 -0400 (EDT)
From:   "Luke D. Jones" <luke@ljones.dev>
To:     tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        perex@perex.cz, "Luke D. Jones" <luke@ljones.dev>
Subject: [PATCH v2 3/3] sound: realtek: Add quirk for ASUS GA503R laptop
Date:   Thu, 15 Sep 2022 20:09:21 +1200
Message-Id: <20220915080921.35563-4-luke@ljones.dev>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220915080921.35563-1-luke@ljones.dev>
References: <20220915080921.35563-1-luke@ljones.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS G15 2022 (GA503R) series laptop has the same node-to-DAC pairs
as early models and the G14, this includes bass speakers which are by
default mapped incorrectly to the 0x06 node.

Add a quirk to use the same DAC pairs as the G14.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a44a55619144..52eb31f4166c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9332,6 +9332,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1e11, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA502),
 	SND_PCI_QUIRK(0x1043, 0x1e51, "ASUS Zephyrus M15", ALC294_FIXUP_ASUS_GU502_PINS),
 	SND_PCI_QUIRK(0x1043, 0x1e8e, "ASUS Zephyrus G15", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x1c52, "ASUS Zephyrus G15 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1e5e, "ASUS ROG Strix G513", ALC294_FIXUP_ASUS_G513_PINS),
-- 
2.37.3

