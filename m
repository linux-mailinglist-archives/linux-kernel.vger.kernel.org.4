Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF3E743D73
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjF3O1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjF3O1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43E135AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BF5A61763
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB908C433CA;
        Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688135238;
        bh=PQzafQPINWzNCKfU5qAbB7q39zv1fe5dtlRulHQmlWU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EEH5d8nmZCFHaRW8Qfwvrw5eNUf+1b2fNeJWl2yEjsEaYvYJH0AzcfYcAfP2rHAe7
         sBLFMDTvsOaXYOYCudL0iFFfRwKwwgEXgrlXqC4nG23beyJK+aJUOXQInbZy20Tle5
         3YUWnL39h1Q68uJzcvO+S1WxjG+0y392YKXRo15u8y2hZOIFBW06lIlUlIb2LG2IQ9
         W66LzIPVxrsK2xDEh2qvjNdaP89h+TF+u9CzC9JRo7aRyQS0XBnFMVTYed/WyuGWvY
         z+I1c8vDDYWSksfECI0r9E/HS6Sk+9WKQ4ZbhU2M8AVAK243u3Gkw4DgxlGC3YjOaz
         uQ4eGCn4tJXjw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFF5p-0001OQ-BJ; Fri, 30 Jun 2023 16:27:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/5] ASoC: codecs: wcd938x: drop inline keywords
Date:   Fri, 30 Jun 2023 16:27:14 +0200
Message-Id: <20230630142717.5314-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler is generally better at deciding what functions should be
inlined than driver authors are.

Drop the bogus inline keyword from two functions that were neither very
small or used in a single place.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 sound/soc/codecs/wcd938x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index b8a52a1a63d5..5ce15b622a91 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2124,7 +2124,7 @@ static int wcd938x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *compon
 	return wcd938x_mbhc_micb_adjust_voltage(component, micb_mv, MIC_BIAS_2);
 }
 
-static inline void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
+static void wcd938x_mbhc_get_result_params(struct wcd938x_priv *wcd938x,
 						s16 *d1_a, u16 noff,
 						int32_t *zdet)
 {
@@ -2231,8 +2231,8 @@ static void wcd938x_mbhc_zdet_ramp(struct snd_soc_component *component,
 	*zr = zdet;
 }
 
-static inline void wcd938x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
-					      int32_t *z_val, int flag_l_r)
+static void wcd938x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
+					int32_t *z_val, int flag_l_r)
 {
 	s16 q1;
 	int q1_cal;
-- 
2.39.3

