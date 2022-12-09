Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326A064808C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiLIKAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIKAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:00:00 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763CC3D90B;
        Fri,  9 Dec 2022 01:59:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id d20so2481519edn.0;
        Fri, 09 Dec 2022 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uV6wgLLBJq+5PmPft7u7+V4YEJPvc3umfQt0xK4OsN4=;
        b=Sr0b5P0r6WV8j9QfllEgNWYMdbyORZX9LDzGOued1mvnVNaz84U+JWTDP13ZDZ4JcK
         iFNDGKKZqX9klGBP8ba3/3vqFBrVv05jXbU/sW07X7GhZkznwt7GM0S3PGzxqeF17GU0
         8Ywkcvwp4OK34DzwOTmA4xp+w6BTNLXOhR7S8vxO5gD5NDvnVMOFiYAF9WE4RUorBo1q
         wGLTTLAGt95Rpwiw07chOrweuYcKLGVQP5ZFdqOWA4EoGpFkJZTLY6yZkhgsdqBsALOg
         i3whDws+6YA6URMuDH49bIPbrBku0LccK/ECTnybUEG0M6hcjvEEH9z0xl5tkjtBsGFO
         TqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uV6wgLLBJq+5PmPft7u7+V4YEJPvc3umfQt0xK4OsN4=;
        b=vWOagpRUQaJVXsOkyr/JrsN75HEVS3RidQjwQ2Ooxq38Q/5x8D0tAfdMxjdx7HpfI5
         w/OQFaDj0vmfnO9F4+0+iWZT9TkVHhVc8mNCtkwSlbZ+iZtMbNiekRJdKW8eqzvYZQzL
         KTh/NXQDGJ53aL/0wbJpFBjf5sQ+85cTrD2lHCVBK9duyM6UuMu/bp6zstyJwmhStrVE
         ozM8GShKdBoIdvh3yxqZFRikWv8BJ98A+Pk6VmjohqnPiIePP5kp8XMXu9tRzjimzRin
         DzCBGCYfO1SwGpLzdHNh+Vzr5VXu7Pzg4PcDjNQunvQBy2u/h3DpfSggL/dWsOREkbC7
         93+A==
X-Gm-Message-State: ANoB5pl4U+Ei4BTXEQM0DlzYkQReyNg1nPnifvskPYmT7PpBAdzwS4dH
        YZBbu9ysHBeloUJ6r3xhpmQbU+/P7gw=
X-Google-Smtp-Source: AA0mqf6J/oH42DT3d9Mda8adYRV2Kqcr5cWYXHtAYgSBKt+zP95FdUIdqjsGVskC+Cy1mbSAi4Tr0Q==
X-Received: by 2002:a05:6402:5299:b0:461:7c4e:c437 with SMTP id en25-20020a056402529900b004617c4ec437mr4188667edb.1.1670579997645;
        Fri, 09 Dec 2022 01:59:57 -0800 (PST)
Received: from felia.fritz.box (200116b826756500611a29889499a521.dip.versatel-1u1.de. [2001:16b8:2675:6500:611a:2988:9499:a521])
        by smtp.gmail.com with ESMTPSA id f5-20020aa7d845000000b00461a6997c5dsm426890eds.83.2022.12.09.01.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 01:59:57 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] wireless: ti: remove obsolete lines in the Makefile
Date:   Fri,  9 Dec 2022 10:59:37 +0100
Message-Id: <20221209095937.17773-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 06463f6e98df ("wifi: wl1251: drop support for platform data")
removes TI WiLink platform data, but leaves some dead lines in the
Makefile.

Remove these obsolete lines in the Makefile.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/net/wireless/ti/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ti/Makefile b/drivers/net/wireless/ti/Makefile
index 0530dd744275..05ee016594f8 100644
--- a/drivers/net/wireless/ti/Makefile
+++ b/drivers/net/wireless/ti/Makefile
@@ -3,6 +3,3 @@ obj-$(CONFIG_WLCORE)			+= wlcore/
 obj-$(CONFIG_WL12XX)			+= wl12xx/
 obj-$(CONFIG_WL1251)			+= wl1251/
 obj-$(CONFIG_WL18XX)			+= wl18xx/
-
-# small builtin driver bit
-obj-$(CONFIG_WILINK_PLATFORM_DATA)	+= wilink_platform_data.o
-- 
2.17.1

