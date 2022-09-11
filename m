Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFF5B4F84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIKO5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIKO5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:57:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4082AE24
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:57:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i26so10857496lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=eAQ7pZ3gOqppStIbzWQfQ4sG+iuDRIjLuat0vE00Rkw=;
        b=i/f4nXEJosWajMhzlcgxo2AeRYy8/SU8YuJsy/YUexGUSfmdHSfyaXFHg67uwCzsZb
         CR/VJbhPFE3qG02Dz87HQ9kq3KyWDatY6+wb99maWe+95+TNU45rKgTiCOv+VSP/9V1V
         vguqDDgMyaJ1D8i7P6UXyIX41SjYzJx6HmUoG126H/Q+EzuVmAZ7DYCLqVHx3IapunVh
         v1m5TVQdblRjU6beiAIxjsWfs76gCfl3dAqV45FHzMxtddBYYRobhEMYXGHeotwh+sXv
         1Rq2SavvkmaOgsDp+osvWjbzAHvUIG/Vop9j/gtmGReUBz7NqGju/T7zQxZKpe2oyA2a
         xvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=eAQ7pZ3gOqppStIbzWQfQ4sG+iuDRIjLuat0vE00Rkw=;
        b=FMQrlfskIntVHROykE08/sSP5TFtppvQx41HI5FZ+FzMqZ4FirZs8yoMQRcPcFwHAn
         tNfaBxsgKsSAQC6/BCphPUoT4JjHLtWg5I1q50IZSBgiAxQvJcMIiZv8oonm0XhMnM3t
         VmpANa6XrAjyvK67tDv/AfXCjokW+uK1FzGwe6V3XM7c3GjrcEUBpzcE7XUg+WhRvoTF
         PNzFxVGzLS19YQ9sQHeLPY5VpetbljVEpbPr8oj0DifFl+pesWppH2BjYXVugGHwN/ic
         7i0vd0JkaozgzN+8ZVzjDlG2m97BO0frtVFkQuMHxmJW4/Ong98LcZYZ6TztfnhstEG0
         Oy3Q==
X-Gm-Message-State: ACgBeo25VdRkQCKGKWDIX5FG4iFdMFm3Ju6yd/7KX+6RL8jagHkZd/Er
        GJq1CytoPq5TgTaKoNHQHso=
X-Google-Smtp-Source: AA6agR4dOV0r3KZlPBj/fj8prupK0Ya8fCrBCJbZOIV671RYwn5zSNIK6JfGj+HSnJYrgcAzn07meQ==
X-Received: by 2002:a05:6512:3090:b0:48b:6e1:1b55 with SMTP id z16-20020a056512309000b0048b06e11b55mr8106591lfd.535.1662908248930;
        Sun, 11 Sep 2022 07:57:28 -0700 (PDT)
Received: from localhost (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id k5-20020a2e9205000000b0026181f65600sm675817ljg.136.2022.09.11.07.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 07:57:28 -0700 (PDT)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: sunxi: sun4i-codec: silence misleading error in probe
Date:   Sun, 11 Sep 2022 17:57:11 +0300
Message-Id: <20220911145713.55199-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case when a codec device is probed before codec analog
controls, snd_soc_register_card() returns -EPROBE_DEFER, resulting in
a misleading error message

    sun4i-codec 1c22c00.codec: Failed to register our card

even if the device is probed successfully later. Use dev_err_probe()
to demote the above error to a debug message.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 sound/soc/sunxi/sun4i-codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 60712f24ade5..01b461c64d68 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -1825,7 +1825,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
-		dev_err(&pdev->dev, "Failed to register our card\n");
+		dev_err_probe(&pdev->dev, ret, "Failed to register our card\n");
 		goto err_assert_reset;
 	}
 
-- 
2.37.3

