Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A45F8A09
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJIHtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJIHtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:49:03 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EF7E31EF2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 00:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lzHsQ
        7uRE+Ob5IFFnxNujLW+JYw21myg9+tk4e/ZuAE=; b=EUZdAIYq5yYcAo9B3YYso
        +9E9cdA6IGsSaFM/58vOakxP5F4Dv2FVHhLX6KgnH0QWNlq7D2ED2nTQRTTKMWpc
        7ilHNxxHUJqunTt0V8+qTSUFPrsZCGYKlK/m8/F/vMHZD8KSJ9VAhzV4eM9Ep5FR
        OatTLHv2pwxcuOKQvfxNGY=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgBX2mvHfEJj6n2Gjw--.45155S2;
        Sun, 09 Oct 2022 15:48:24 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] ASoC: cx2072x: fix spelling typo in comment
Date:   Sun,  9 Oct 2022 15:48:16 +0800
Message-Id: <20221009074816.2641162-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBX2mvHfEJj6n2Gjw--.45155S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Jw48urykKrg_yoW3ZrX_Ww
        18W3y5Z3yqqFWSkr1jyrWjyF4Fv3Z5Cry8Crn5tr4UA3y5uayYyayvyF13C3W5Gr4vgasx
        XanxKr1aq34kKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1Tmh3UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbiyAiV+1p7H8T2DwAAst
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 sound/soc/codecs/cx2072x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.h b/sound/soc/codecs/cx2072x.h
index ebdd567fa225..09e3a92b184f 100644
--- a/sound/soc/codecs/cx2072x.h
+++ b/sound/soc/codecs/cx2072x.h
@@ -177,7 +177,7 @@
 #define CX2072X_PLBK_DRC_PARM_LEN	9
 #define CX2072X_CLASSD_AMP_LEN		6
 
-/* DAI interfae type */
+/* DAI interface type */
 #define CX2072X_DAI_HIFI	1
 #define CX2072X_DAI_DSP		2
 #define CX2072X_DAI_DSP_PWM	3 /* 4 ch, including mic and AEC */
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

