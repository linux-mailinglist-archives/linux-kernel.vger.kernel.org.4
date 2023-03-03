Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2E06A974C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCCMdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjCCMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:33:19 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885E13D72
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:33:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az36so1486610wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 04:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Avma0LmG3fMmIscRMsl03VxGDuG4kqyX0ebqajTjKu4=;
        b=op6CjDXgDJ8a3+SDEW4qqMibSd2A7N87rbpRy0+ig5Ka2OsHB58hCe9vIdPQNmI3iC
         tqGR9j+dXu95LJYj7a39UPGPMnW2jXsN1htZ4XH4ww8B7u4jDfj9NH4jp1KSG0PAhxEj
         2YBkjgbmVYy3/1Q2ODMkrp6ghd8lEZTdyR4z7W0HyBmB9CQ80av8pPk6EvriYfWa/Oc+
         liiFN7UtGEhsZdhGJLCekO7uuhBEG7Fzu2PykVstObcy0FrnLcuu1cNcM+33ILxOzreT
         ehtEpoKXAabODtiDvCieyMfxU1ISOz6VE7niJuQThx5Hlg1FL4YymwtPvonXcneMwh4R
         lOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avma0LmG3fMmIscRMsl03VxGDuG4kqyX0ebqajTjKu4=;
        b=y1LxCbYCvmqGC1VP1oycPdcSkHH3t3s1wAJOuWuU4YAQhkV5hobt6c4pPJGCYdnpUl
         xGyscAPvd3BTQSya6CHgyvh2fy00ogqT77mQdKve4XN75vA2Uotx8Qfi4EH8ke5d23xI
         RwfszJY1JZJrAAIua6TjcegIkOlAQ0bjKBIa4p9DITEdTL8e7k7ST8Cj9cGXDhfwxA8r
         hkUhSZ8ySPDqBHg1buIKFxgJIiBINZbS6s43ki731kLQXRYObf3a67klghyX6yQVfGo3
         QGs4hlTBTdTX48XKfpyDzlas2A9Bfd4t+RBeE7ew/eYZR0iWnzZD1+F3bpImKWISENkt
         MyEA==
X-Gm-Message-State: AO0yUKUFazBBoCAXWQdsphki8SMy+CG1d5RUC2IANf/juOhL9PBrDnmO
        1rbSsPC2taAWendgKU66Dmwaaf7BqiVQtw==
X-Google-Smtp-Source: AK7set/VvJ0ig87ojREiKZi3IdQswYQr5HOSJLhyb99jMuarDimDTnncr/lSElyahvpK/qQE9qMubg==
X-Received: by 2002:a05:600c:4f90:b0:3ea:d620:57a0 with SMTP id n16-20020a05600c4f9000b003ead62057a0mr1430142wmq.3.1677846796891;
        Fri, 03 Mar 2023 04:33:16 -0800 (PST)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c42c600b003eb192787bfsm2258437wme.25.2023.03.03.04.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 04:33:16 -0800 (PST)
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
Subject: [PATCH v2] drm/meson: fix 1px pink line on GXM when scaling video overlay
Date:   Fri,  3 Mar 2023 12:33:12 +0000
Message-Id: <20230303123312.155164-1-christianshewitt@gmail.com>
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
line on the bottom of the scaled overlay. Comparing with the downstream
vendor driver revealed VPP_DUMMY_DATA not being set [0].

Setting VPP_DUMMY_DATA prevents the 1px pink line from being seen.

[0] https://github.com/endlessm/linux-s905x/blob/master/drivers/amlogic/amports/video.c#L7869

Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Change since v1:
This time I sent the right patch from the correct branch; the wording in
v1 is incorrect and the change to meson_registers.h is not required.

 drivers/gpu/drm/meson/meson_vpp.c | 2 ++
 1 file changed, 2 insertions(+)

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

