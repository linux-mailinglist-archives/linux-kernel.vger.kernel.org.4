Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3161FE87
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiKGTZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiKGTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:25:41 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131F72AC5F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:25:40 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q1so11299567pgl.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L09sSFj8jMYHB7Rrkwmq2jVe4IQP4EfD+P4chmHfa1c=;
        b=OWgy2XCuTwEHKHQUOym0SdS7JXGlumeU5fbSbQCQlkJlGCO/CYiWC5r23Lgbcebq/M
         OystifHIjNkmznGfP3BXu7Fi3M7y+CXstGUwdCKk/diK5IKVXP2ngraPRmeD4Xc2JEaP
         Kjtr0OFih7SU9Neuw+fed2X2OMGrVQrzK/7cqKhgrF0JD9piEuZ+Sc82mJ5fD50Rd8JP
         VTTvbE92+swpK4CmA3mFwg1UuZazjGTByOBc/sgx0gIHyyJzg94+0aRNonUrAT+gxqTs
         LFNLPfzHrkVg5NHJ1o7IxGarHxhqxj0PaJWnkLE90UzuUkmTRYAe5WG5g8Yqx1ImZGhx
         4VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L09sSFj8jMYHB7Rrkwmq2jVe4IQP4EfD+P4chmHfa1c=;
        b=lwM2t7hlaKMtS++37FIlOekTeHJbaU/ZBm6EdD2u8hXPRFLstj1zf9bn9IYlOx5YTo
         GMzJVJyCLhCw4Pb0QP4E77hBnDaEu/IAKrjbVZV5alwQQbm08TKiwb4d2LpkQevnhLnn
         lcfCSGf7qhv5gH2FwsR2c1AUwkQRzgk7VKbZwIjYUoWl834RqOmC7+n/mZ9TqAD6rlAq
         cevvLee1t1YIkZPw/iFdJYH/U3RIR1Yk5qqgUq8z8/FngdXcPRrDlZOiTX2p5uT8ePfm
         ShxAJovscZ++U3uaQaVAheMVFrU4QPorODbfCiwe9ZaX14V+kwuKJDepwxBn8FGT2vjy
         Jwwg==
X-Gm-Message-State: ACrzQf3V9xNZY/RE80WAsqKSR+2tadksz+ewfheErpfUx8BM24jlLTdQ
        J/9MapOIjl9CXn27LJNS9BdOVwRLGe8oGg==
X-Google-Smtp-Source: AMsMyM4jFQowb8tpJJ02tbtrHi5AjK/wODZDnaxvLQl43T4gl2P7ncSnlJmSXopBWIRCZORFIkCCag==
X-Received: by 2002:a63:7f1a:0:b0:46f:8464:3019 with SMTP id a26-20020a637f1a000000b0046f84643019mr43703997pgd.450.1667849139569;
        Mon, 07 Nov 2022 11:25:39 -0800 (PST)
Received: from thinbox ([12.231.191.170])
        by smtp.gmail.com with ESMTPSA id n190-20020a6227c7000000b0056cea9530b6sm4837304pfn.202.2022.11.07.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:25:39 -0800 (PST)
Date:   Mon, 7 Nov 2022 11:25:37 -0800
From:   Maurycy Z <10maurycy10@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Trival: Fix spelling error in Kconfig help.
Message-ID: <Y2lbsfOhXicqvC2A@thinbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a few places in Kconfig files, 'system' is spelled as 'ststem'.
This patch changes them to the intended 'system'.

Signed-off-by: Maurycy Zalweski <10maurycy10@gmail.com>
---
 sound/soc/fsl/Kconfig     | 2 +-
 sound/soc/generic/Kconfig | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 614eceda6..c7fe12fbd 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -366,7 +366,7 @@ config SND_SOC_IMX_CARD
 	help
 	  This option enables audio sound card support for i.MX boards
 	  with OF-graph DT bindings.
-	  It also support DPCM of single CPU multi Codec ststem.
+	  It also support DPCM of single CPU multi Codec system.
 
 endif # SND_IMX_SOC
 
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index b6df4e26b..955ac8d3f 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -7,7 +7,7 @@ config SND_SIMPLE_CARD
 	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables generic simple sound card support
-	  It also support DPCM of multi CPU single Codec ststem.
+	  It also support DPCM of multi CPU single Codec system.
 
 config SND_AUDIO_GRAPH_CARD
 	tristate "ASoC Audio Graph sound card support"
@@ -16,7 +16,7 @@ config SND_AUDIO_GRAPH_CARD
 	help
 	  This option enables generic simple sound card support
 	  with OF-graph DT bindings.
-	  It also support DPCM of multi CPU single Codec ststem.
+	  It also support DPCM of multi CPU single Codec system.
 
 config SND_AUDIO_GRAPH_CARD2
 	tristate "ASoC Audio Graph sound card2 support"
-- 
2.38.1

