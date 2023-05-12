Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8E5700F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238990AbjELT0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237012AbjELT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 15:26:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8911D
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:26:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aad55244b7so79595305ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683919581; x=1686511581;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yz4DYKSNmBeEVN5VVceILj1aZ1bLp7+YNm7+Yoele00=;
        b=GdGO7tJ4IIUXweKlz+dCEQNC4Jf9giqrZ6IQWsiG1yctoFoJUmWBZf1pDY+NSPN5EF
         8QHk5X08ZDhLvo1aTU9OeDLX7TNJt7TYJiZn3Ddz38fWq//zCdSzINTj/mdDUd0ryo43
         kpyAnVNpeI6uFrEAFnQkIrmNluVRMi8FDSTuho8UK8nD02zBM1GLG78rAVDqdqzhvlBj
         TTlB554DoFhi6MzAJYNLUUDhY9H6/IoYnPKa1GwkYcZteDq0Ae0iVRqpkkyOLY2cYk1c
         hjH8FdKRI9UuLEhJPsWUzT/CmUi0ThL8rox40SCNkRv4N87OV8bbNKARNFVU0A3Mb77a
         lllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683919581; x=1686511581;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz4DYKSNmBeEVN5VVceILj1aZ1bLp7+YNm7+Yoele00=;
        b=D7Pyh6x3h5rCMeTfUtvogN46p7if1yTNGeexH5laMwgMZplS11p1+5gqNw8WDNhMu3
         hm5tzO2OoUmSxTdGvLSInOMBzrC6kzgwjCyxMW/mhTakzlXioVyd59hQoJLkkTf66IyM
         wH10XJyUE8QwVYEdpMRDwqbLJVnrq/2oV75EUJ4UyV+HV73VxWTYZ5+bWPHQxnoJ2HwM
         hjg5gDWd9NJHPVYVIFDPO2qtGYVWlcFWUy3H0KkdpRLzoHbaZ1/dHs+WvHacpZK+/TfL
         OCyoMeUQXGdeup135QQibjZu0b6QuyQRrmfrkuVnZd6eUqHG0MX40DQE0qH8rLd/Qveu
         lY6A==
X-Gm-Message-State: AC+VfDz0TNbu2TIZsPKksHPM9HDZETBMrKJLdtdYl/AmioIYWVFqOe6I
        4wyb/rEnAwrFrTdEI2L4y1vIN+oAMhFLESZN
X-Google-Smtp-Source: ACHHUZ4oAT/GxHasWc1+hnu5yWxpHeEJ05uQYZwgtlcpevP5ZF9ks5XZ87fIDTRvaTXgidAuos4Pww==
X-Received: by 2002:a17:902:e54b:b0:1ac:712d:2032 with SMTP id n11-20020a170902e54b00b001ac712d2032mr25367398plf.50.1683919580676;
        Fri, 12 May 2023 12:26:20 -0700 (PDT)
Received: from yoga ([2400:1f00:13:5d8c:29b4:3ace:81ca:10f])
        by smtp.gmail.com with ESMTPSA id x1-20020a63f701000000b0051b8172fa68sm7171336pgh.38.2023.05.12.12.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 12:26:20 -0700 (PDT)
Date:   Sat, 13 May 2023 00:56:13 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: drm: nouveau: nvkm: engine: gr: Remove Unneeded
 semicolon
Message-ID: <ZF6S1bg2AzuBjhxW@yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the extra semicolon at end. Issue identified using
semicolon.cocci Coccinelle semantic patch.
Warning:
drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:423:31-32: Unneeded semicolon

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
index 5f20079c3660..204516891ece 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c
@@ -420,7 +420,7 @@ gf100_gr_chan_new(struct nvkm_gr *base, struct nvkm_fifo_chan *fifoch,
 			return ret;
 	} else {
 		ret = nvkm_memory_map(gr->attrib_cb, 0, chan->vmm, chan->attrib_cb,
-				      &args, sizeof(args));;
+				      &args, sizeof(args));
 		if (ret)
 			return ret;
 	}
-- 
2.34.1

