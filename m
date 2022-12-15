Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED0964D72E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiLOHTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:19:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiLOHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:19:12 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7084DCEB;
        Wed, 14 Dec 2022 23:19:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so1827886pjo.3;
        Wed, 14 Dec 2022 23:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNNEXVu8wt2zuNH1k1KAp/j5xACVIRsF33hCTFu+i90=;
        b=ke0PMAQli34KzagT/iZlwE1G+uKztUSLuFSo0o7cOv4AecrTSxBF0OO4UpjcehSj/K
         GWr83LJSbCF0siXy0+Tsc2J/2grwXzEZKtYThtuyh7cQb7Vls/Lr8TiwN81ocJrvHxdO
         er59dswgGOeFX51hSVWXvbvh5mYpqSYRSUPnzk2BMSWktH+7E+ih+OXq0uXwIfNSVRDO
         u31QH8N0sDTDQIfnKM0vxnH177cIRN1Dj6DUdVv3MX9vKqCYtj6D/2+Eq4CKs2TU0Y2F
         Wme02BGLglHiiGcCjNkAnh9XF/SvGLNwXji90UU+BdWKxVzrGs2kWBpszuBQIPAmwKnj
         FO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNNEXVu8wt2zuNH1k1KAp/j5xACVIRsF33hCTFu+i90=;
        b=eoPf0NoUlnTQ8k9XVcUgJy8SiImM8E2PWKiCHyrp8qBRUBuycqivCUJRX8zLeXviQO
         9FODsDndcp6lnkJPS2gIFOJ8GM3u4CXp0g7+YT5USP1BYrB+Zo8XVnmzjC8+0n18yNAJ
         EAed2mPHVd8J+dtgTxb/5lXNjykvl47Ul9TvQJWNMeqvNK7NKKpGkwoehuPqkfbdD1rO
         nIlEfGH8mDQdy5mDDrA0/6fT6JfwiBSxcA7sx9BTYbeTGiyo1YmBL+K2NGikHgsBDo8w
         1iSOM09kYPlIIeKi3szPSk4X0+9moKrANx0caf/IrWYbAO5MPx6ZdvOJc1E2wzl7cNFD
         COeg==
X-Gm-Message-State: ANoB5pku9RKdfkB4iAveQQoXM91zPLzKSgwMBps0k8Lqry+6dZy5l7BJ
        6Lrbr9YZYAnwQxgHwPenq5o=
X-Google-Smtp-Source: AA0mqf7MmXmaf/L+wigAXaOlCY44BwYrdpA2K+M67FvUPZ85+eGbZGssAOusmVHwWAkIDEiiIKdAcg==
X-Received: by 2002:a17:903:24e:b0:188:8745:35af with SMTP id j14-20020a170903024e00b00188874535afmr49943612plh.63.1671088750984;
        Wed, 14 Dec 2022 23:19:10 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id j14-20020a170903024e00b001897bfc9802sm3046141plh.93.2022.12.14.23.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 23:19:10 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] backlight: backlight: Fix doc for backlight_device_get_by_name
Date:   Thu, 15 Dec 2022 11:19:01 +0400
Message-Id: <20221215071902.424005-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight_put() has been dropped, we should call put_device() to drop
the reference taken by backlight_device_get_by_name().

Fixes: 0f6a3256fd81 ("backlight: backlight: Drop backlight_put()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/video/backlight/backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index b788ff3d0f45..6eea72aa8dbf 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -501,7 +501,7 @@ EXPORT_SYMBOL(backlight_device_get_by_type);
  *
  * This function looks up a backlight device by its name. It obtains a reference
  * on the backlight device and it is the caller's responsibility to drop the
- * reference by calling backlight_put().
+ * reference by calling put_device().
  *
  * Returns:
  * A pointer to the backlight device if found, otherwise NULL.
-- 
2.25.1

