Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15E1648131
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLIK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiLIK4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:56:55 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9150B3AC11;
        Fri,  9 Dec 2022 02:56:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F3475C014D;
        Fri,  9 Dec 2022 05:56:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 09 Dec 2022 05:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1670583411; x=1670669811; bh=fyLU8xYiAeULVFgJU8sDsWfUH
        1eKtsFQGNyrvSP5PtI=; b=IyS8ktqGXkJqL7QiV37I1mOwF0isJZNbtkdMAS2l6
        F9ztlcwv0GwCO9al4Xa8oekT08+M7xO4RMxiIE7ekLgv0Dk0bQBjSjR/EQs8VR4C
        dQkEWSQlnaOcb0+T8gnqGDn1NcoJ819klZSeirycTsoskQXtdETTt5IgdhAUiASF
        gf6DnafDx1Y5XKmG1VkJjob5E5L5k+FWPDVsb/SAEpG1sv1B59KRPXvGUBqI8Uw2
        YggAStcc5hCTuobQwTj1imDQ7YMuHHY9tVmKloJq0yFmnITEdmG8ZLrHw5kTAayP
        wVJ6CuUWL1hb5C4KFzXnn8Pny43s4ML5cVTbtU085zxxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1670583411; x=1670669811; bh=fyLU8xYiAeULVFgJU8sDsWfUH1eKtsFQGNy
        rvSP5PtI=; b=Syq+bW60z/juVlF7X+mcXY8dVgQHdoJV48AEPhvKYDgefMI3DzV
        1HJ31g3jpifSfX4yF1RnNbZVeE2RZwmB19Lw2LN3LRIsrzZaJiz2ywwRw6xioHVp
        FZipjsrNrOnhg+HRFDEadQ2oxuYaL08CpvOcV05r5x7TSixdeyOKDDRC4x6QUQoA
        HsTvKiYr2SmNH7flFbHLDrrzcuUDQL8EsxM+vDy4yRkTagkR5WgehuoYA9fWdR7t
        SbEurAJS3h2MuyEVVEqtwssJvqUFsTB4c/qXMeor5WWlAh+xDX4TZlRyGMFeRdx6
        DHd7ubA0lHONDk2szBkNgwfbNv1jKN3caLg==
X-ME-Sender: <xms:chSTYzx-pj3KiN4GFvBFfEhSLeRqaz2RLt0N9g_ClM_P3XbB33LZBw>
    <xme:chSTY7TDk4Rj9LRB3Dpi3emTwWKzilE2DJJyunc97IzPEXNCzGiv8d_Qrmfd3hjZn
    HwzC4GQnM4fuPLM-jE>
X-ME-Received: <xmr:chSTY9VjDq7Q_0c2Vsof0xpPFYhtde413O8Bt-ZN7JBvTT5kngcmGD4LOWEcQQjK9LqY3T4wt2BPE-pW42GDdYCCgq10oneo-3J_sLDIKMligS2FOT8oVqYegw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghrrhgrhhcu
    ifhoshgsvghllhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecuggftrfgrth
    htvghrnhepjeeuvefgjeefgefhhfefhedvffelteehkeekvdefheeiteeutdehveeghfeg
    kefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkh
    gvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:chSTY9hLEQ3DGB18eR3TzyabX4CHlEL1qP8mYI7JBczcMm6PZ9iynA>
    <xmx:chSTY1Af5ZHA6DMjZahBtCaw6AaIxyiF4kuSpDIIRC47yTXPW-bDng>
    <xmx:chSTY2LRVrfZVO-S0rak1GjCvix0MoVI5mWSLYdEFKZlBQbeS38xRA>
    <xmx:cxSTY53roaKfPypmM97fyWKzNeYNk_O13wLMyhEw28W6LETqkgfzvg>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Dec 2022 05:56:47 -0500 (EST)
From:   Jarrah Gosbell <kernel@undef.tools>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH 1/2] ASoC: rt5640: Allow configuration of LOUT to mono differential mode
Date:   Fri,  9 Dec 2022 10:56:20 +0000
Message-Id: <20221209105621.39237-1-kernel@undef.tools>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

LOUT output can produce either single-ended stereo signals, or mono
differential signal. Some applications are wired to use LOUT in mono
differential mode. Allow to configure it via device property.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 sound/soc/codecs/rt5640.c | 4 ++++
 sound/soc/codecs/rt5640.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 0f8e6dd214b0..18e01949f20e 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -2717,6 +2717,10 @@ static int rt5640_probe(struct snd_soc_component *component)
 		snd_soc_component_update_bits(component, RT5640_IN1_IN2,
 					      RT5640_IN_DF2, RT5640_IN_DF2);
 
+	if (device_property_read_bool(component->dev, "realtek,lout-differential"))
+		snd_soc_component_update_bits(component, RT5640_DUMMY1,
+					      RT5640_EN_LOUT_DF, RT5640_EN_LOUT_DF);
+
 	if (device_property_read_u32(component->dev, "realtek,dmic1-data-pin",
 				     &val) == 0 && val) {
 		dmic1_data_pin = val - 1;
diff --git a/sound/soc/codecs/rt5640.h b/sound/soc/codecs/rt5640.h
index f58b88e3325b..9847a1ae01f4 100644
--- a/sound/soc/codecs/rt5640.h
+++ b/sound/soc/codecs/rt5640.h
@@ -1978,6 +1978,8 @@
 #define RT5640_ZCD_HP_EN			(0x1 << 15)
 
 /* General Control 1 (0xfa) */
+#define RT5640_EN_LOUT_DF			(0x1 << 14)
+#define RT5640_EN_LOUT_DF_SFT			14
 #define RT5640_M_MONO_ADC_L			(0x1 << 13)
 #define RT5640_M_MONO_ADC_L_SFT			13
 #define RT5640_M_MONO_ADC_R			(0x1 << 12)
-- 
2.35.1

