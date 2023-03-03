Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E716A96FA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCCMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCCMGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:06:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020743A853
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:06:32 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so2041432wrw.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o4CVRkT00wDN2Fa83DiSDIePRGANN40JJ2ghpdtVgiE=;
        b=BIap55OlfFhERihj3vwiNDmo4umMdp82nwwLz8QsFoCnVYscUzxcBKiKGiS7wOBtNS
         Dr2iyyZz9h1GPzd1Fu/wTlnr/O1p0gQqlNIHun82LTkTmOkqrucXkQmt4aP3vGR4WJnH
         NHs5Q83GG+21uJKTP5vHgEbIlShJa2W9pmBUO9o736WWz/bH08e+I3EJipvToi4ZJXv6
         ojd1zvXUAsUHoS/YwMZNYvy2oL2WbHujiYOFsxYROk24t7qf9e6peOhLl3JuJYGeq5DS
         47EMnayvN+edKGykqK+br1n9AUn2SkblOs+x1701MCj84+FVpkm5tKUvZPyOo7PSjaNX
         00VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o4CVRkT00wDN2Fa83DiSDIePRGANN40JJ2ghpdtVgiE=;
        b=4kGJRjL9fuShfmKhQca5UgqJuA2ai7ZjcUlDXANIvk1K+FUWJX7F2Mo9gmRm+cTH/X
         039JBNWVVWh75Hl7XQB42iTxazxlJy7A1VptlT0fvglFYxw608m1VDh23dtTftbUmDz6
         wjVbSWoQmVpXWq/RIkBCrRY52PfopVPCRWfNL7+jcOYfYpRcGYOSDf3vMp2mivs9L2LZ
         Yq3jxAUSCwWy9NyL0tznp2jO9L6sjYoH6mqQ5G4rdCP51ueB16UXzba1C6v0vTdjOXR/
         R9LTPBDfdYy4J4sSX0cyoloxc9fMiXKFR3C/MFmmcMbHibxgmHA3or9jmxstieykjrCb
         eoKA==
X-Gm-Message-State: AO0yUKXEnV6kJP7mogmVohr2RClwRtxl3qGeNBc7JjJNubZL8rK5ShA0
        x7K+xpXs71BbjdPsGdZeyQokCldBqwe9sg==
X-Google-Smtp-Source: AK7set9vuTqZGxAGpdazzvzEOD3vfnTS3TDJdUdtJ0rfP/eI2tCbGtxxFPZiAd+Zc4NqumSjWhajBg==
X-Received: by 2002:adf:fdcf:0:b0:2c7:17dd:ed6a with SMTP id i15-20020adffdcf000000b002c717dded6amr1085313wrs.33.1677845190360;
        Fri, 03 Mar 2023 04:06:30 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id n18-20020adfe352000000b002c567881dbcsm2030068wrj.48.2023.03.03.04.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:06:30 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] drm/meson: fix 1px pink line on GXM when scaling video overlay
Date:   Fri,  3 Mar 2023 12:06:26 +0000
Message-Id: <20230303120626.3281-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Playing media with a resolution smaller than the crtc size requires the
video overlay to be scaled for output and GXM boards display a 1px pink
line on the bottom of the scaled overlay. Comparing registers with the
downstream vendor driver revealed some differences:

- The vendor driver sets BIT(17) | BIT(13) for VPP_DOLBY_CTRL
- The vendor driver sets VPP_DUMMY_DATA

Setting those values prevents the 1px pink line from being seen.

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 drivers/gpu/drm/meson/meson_registers.h | 2 +-
 drivers/gpu/drm/meson/meson_vpp.c       | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_registers.h b/drivers/gpu/drm/meson/meson_registers.h
index 0f3cafab8860..e4af333fd839 100644
--- a/drivers/gpu/drm/meson/meson_registers.h
+++ b/drivers/gpu/drm/meson/meson_registers.h
@@ -534,7 +534,7 @@
 #define VPP_PEAKING_VGAIN 0x1d92
 #define VPP_PEAKING_NLP_1 0x1d93
 #define VPP_DOLBY_CTRL 0x1d93
-#define VPP_PPS_DUMMY_DATA_MODE (1 << 17)
+#define VPP_PPS_DUMMY_DATA_MODE (1 << 17 | 1 << 13)
 #define VPP_PEAKING_NLP_2 0x1d94
 #define VPP_PEAKING_NLP_3 0x1d95
 #define VPP_PEAKING_NLP_4 0x1d96
diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index 154837688ab0..5df1957c8e41 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -100,6 +100,8 @@ void meson_vpp_init(struct meson_drm *priv)
 			       priv->io_base + _REG(VPP_DOLBY_CTRL));
 		writel_relaxed(0x1020080,
 				priv->io_base + _REG(VPP_DUMMY_DATA1));
+		writel_relaxed(0x42020,
+				priv->io_base + _REG(VPP_DUMMY_DATA));
 	} else if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_G12A))
 		writel_relaxed(0xf, priv->io_base + _REG(DOLBY_PATH_CTRL));
 
-- 
2.34.1

