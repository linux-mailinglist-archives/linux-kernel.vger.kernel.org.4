Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7AF743D75
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 16:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjF3O1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 10:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF3O1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 10:27:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37593AAE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 07:27:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60EC961764
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 14:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB87AC433C9;
        Fri, 30 Jun 2023 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688135238;
        bh=lrVbd0JoMGVuCAGlTtBwHS0krlYpo5gW52m7Wo7fi6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYqZFelz3wt7y/0/q3o7bAsYRDLYrKrsMemIk08HP9xdO/MwqGzw09bWbTrSyYu8c
         KNNrYRnbad1Z5fuRBL2+xKFmpTirqeRQeexighNf8Whe3vS0ogxc1O86yFCD1VWbbB
         Ft5KD1t8MCf3RnPvebkrKv3PXpfcc5ntWi158pa6b6T1CfuFviR4KsRLEWbCWPpwgg
         8whZvA/RiPAuV1j9Vo+85OxGwWa1QrLo4K86BSDV1ZmFXEoQOYuzuoHH8vr46aA2aO
         Zt91COgZM3Fovf1l0SK8cZzoX/YsQQ6KQnEN2v230F4nPMlXMds6q3A0tdRc4Tkz9i
         Hwvsy/8BSTC5Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qFF5p-0001OY-Iu; Fri, 30 Jun 2023 16:27:25 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 5/5] ASoC: codecs: wcd934x: drop inline keywords
Date:   Fri, 30 Jun 2023 16:27:17 +0200
Message-Id: <20230630142717.5314-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230630142717.5314-1-johan+linaro@kernel.org>
References: <20230630142717.5314-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
 sound/soc/codecs/wcd934x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 9d724b5710f7..a17cd75b969b 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2642,7 +2642,7 @@ static int wcd934x_mbhc_micb_ctrl_threshold_mic(struct snd_soc_component *compon
 	return rc;
 }
 
-static inline void wcd934x_mbhc_get_result_params(struct wcd934x_codec *wcd934x,
+static void wcd934x_mbhc_get_result_params(struct wcd934x_codec *wcd934x,
 						s16 *d1_a, u16 noff,
 						int32_t *zdet)
 {
@@ -2740,8 +2740,8 @@ static void wcd934x_mbhc_zdet_ramp(struct snd_soc_component *component,
 	*zr = zdet;
 }
 
-static inline void wcd934x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
-					      int32_t *z_val, int flag_l_r)
+static void wcd934x_wcd_mbhc_qfuse_cal(struct snd_soc_component *component,
+					int32_t *z_val, int flag_l_r)
 {
 	s16 q1;
 	int q1_cal;
-- 
2.39.3

