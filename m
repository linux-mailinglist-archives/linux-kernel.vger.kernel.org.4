Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488C566A77F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 01:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjANAb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 19:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjANAbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:31:24 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5D46C06F;
        Fri, 13 Jan 2023 16:31:22 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 140455C00A7;
        Fri, 13 Jan 2023 19:31:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 13 Jan 2023 19:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=undef.tools; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1673656279; x=1673742679; bh=06oSer/hbIX+e8ixGpELbsOVt
        s3pi8H+tRTjkc7QSco=; b=d2NkJzL1JwBETuvfrCBMhHNw91k9PEmBfKLJc81Gn
        qZBJ/dTpzWX1uNkywAsErH1obEYD6+W3XSqpb0SjEQ0Re87mW2jYm3HKyRARU6XR
        DLsVNRsz6Lr8fsIGxuILrXSShPJ+3XoJ7I4pvTtY+A46Xrkzd3TibguPUoEerSAu
        6nw80dJmRNexmL6rg3TJndYhU0eE/OK3MSLjZ+gaw8T03AjcHKLKfyUt/sXMICkc
        9O252C5oFKxYQg1l0HH0ADUg7NaS/l7YINW6WRPUJHfpS8bG+83999h1vjMQzjaq
        UKON3SmPXQgiqT9hwnVCcngTvQx6gxLj/e5iXm350gvvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1673656279; x=1673742679; bh=06oSer/hbIX+e8ixGpELbsOVts3pi8H+tRT
        jkc7QSco=; b=OgLKE3xTvIREhVSDtMWTJj5enSFDb9I41shZnityxl7dkfv+vao
        9KNQr8Y7gP/O2mJwSuoE4qsfrOBtZGVjVx/9cb4iUu1G0eAQRx1AfpQI3lBLov5D
        ynETmT3m1ZHdsCtNED6wYkfReHJ+OQ26uZc6t3Q7pVjjHtWm8uVN8WxTCyZl0rMr
        tdDa5y3ZlqKpjYyecAZbKo5mczg6d4MJRC9LdwmL2HGNEiRdA0MAGDi7ecgGYiKu
        E8TahxaMd4uFYBGqJ+J8yXVHU+fA+3uzibiGf4P+GZc1Kg4MRjo3xnytaxXsL5iI
        mLYUsvgrra2J3Byfkt4pREX7lvLn4yaXUow==
X-ME-Sender: <xms:1ffBY5GekTrmQNbnKtYZiHgyjnvNBR9vUiN8PI_3MX2PuBTycpYBHw>
    <xme:1ffBY-XlGPiC-fOHc9PWgHhcxXmfTkakFnzQ1WZrpVS0vgWDGeaq-xCzEF5eiaWEG
    zwis_AVunJGYSC81H0>
X-ME-Received: <xmr:1ffBY7L4oX1LS7QU59v-Arro1fp1phsHQEuGk4opMqihtEkf0p8Fb9mrmH4j_DiXWbXCXDGFsFtN2hLn_tPJ3BXBJfoaq1VvdmSKjAMcspKP2VHk3gAlzD-Lfg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflrghrrhgrhhcu
    ifhoshgsvghllhcuoehkvghrnhgvlhesuhhnuggvfhdrthhoohhlsheqnecuggftrfgrth
    htvghrnhepjeeuvefgjeefgefhhfefhedvffelteehkeekvdefheeiteeutdehveeghfeg
    kefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkh
    gvrhhnvghlsehunhguvghfrdhtohholhhs
X-ME-Proxy: <xmx:1ffBY_E7Yui-m0Qql0NNBgfk59W7rops_-ItwjoFJyKNq8ifiKKrIQ>
    <xmx:1ffBY_XPHbC453p9rAmA4QVkK6PCh2-o40NE9Ccew8lcaiMkihYGgA>
    <xmx:1ffBY6NFSnL3O8AIuuI6xnA2XjXRj_o4TJKC-iBrjwRlJDVXjBXx2w>
    <xmx:1_fBY7pxaNJxadzhpnd7UrlFjHR1ccmRI8mDgv6JPFaDI7iZalfyvA>
Feedback-ID: id76147eb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jan 2023 19:31:14 -0500 (EST)
From:   Jarrah Gosbell <kernel@undef.tools>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>,
        Jarrah Gosbell <kernel@undef.tools>
Subject: [PATCH] ASoC: codec: rt5640: Resolve failure to set DMIC clock after playback
Date:   Sat, 14 Jan 2023 00:30:54 +0000
Message-Id: <20230114003053.401274-1-kernel@undef.tools>
X-Mailer: git-send-email 2.39.0
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

rt5640_set_dai_sysclk is called with freq == 0 when playback stops. This
causes DMIC setup code to fail. I2S interface doesn't need to be active
for codec to work, so don't clear rt5640->sysclk after
rt5640_set_dai_sysclk is called with freq == 0.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
Signed-off-by: Jarrah Gosbell <kernel@undef.tools>
---
 sound/soc/codecs/rt5640.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
index 18e01949f20e..054de41ceccb 100644
--- a/sound/soc/codecs/rt5640.c
+++ b/sound/soc/codecs/rt5640.c
@@ -1839,6 +1839,9 @@ static int rt5640_set_dai_sysclk(struct snd_soc_dai *dai,
 	unsigned int reg_val = 0;
 	unsigned int pll_bit = 0;
 
+	if (freq == 0)
+		return 0;
+
 	switch (clk_id) {
 	case RT5640_SCLK_S_MCLK:
 		reg_val |= RT5640_SCLK_SRC_MCLK;
-- 
2.39.0

