Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD3170160E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbjEMKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjEMKM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:12:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673F2738
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:12:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-64389a44895so8712309b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 03:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683972746; x=1686564746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHwu0DxgpIB80pv88TW8Dso6+AGWiv24hvrqwgEqHjA=;
        b=XVyTmzTf5rXbhKsCjh1WtQSbdmKYJyxcLQwGxd5+RMKcFhBIbGT8LDCBvwcniA25vZ
         DsHGro07Iv0PH8SXMduU+5cxeY4CuLd0ijDYzGMZ0r4aFVqRnPSnbLiKKWXuTIgOBk/D
         QuPV94WV/noyDx12wkg8kXkNOqI5BnupMuzz8/tTxlwh7VAO/fyfWABZfzOLYFgXRxoF
         YUq+u/Sj9WX6SRNljUgyJ+rs+iyFmed0qrVyzEL4MrAtHeHfZl9IfW1zwy16UA/u1ZZS
         Sm2JXn410KcREP7cv19yXDkW0kw8mkY/EEU+D3hwIp8z04zWcbrp/VmJPPSJafKYqWcN
         pT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683972746; x=1686564746;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHwu0DxgpIB80pv88TW8Dso6+AGWiv24hvrqwgEqHjA=;
        b=fbRxEA2AaX0eEAK2NEf4OFo9oflmv0ylPsP5y3o6NFLg2uJPSD7zT2Iwi/G3C8Dbgw
         zl9LWFsbc4VW0lZfQdpcJ14GqXzpQdcS+N2p+Zm8MT0zmYXvGRdb829sa81jJpZ4UHLT
         0kNhA4iXuxMUW134hktHMLcCf8sReg6o6LCbUenY5WHribMLuRZ7tEWsKBnxlxrDZurH
         Y/1bAkw/28RRtYBdgO0JPd52ueD6VfJK/zYptvF4J8DkU9jxyRC9KDEBNC+PeiDsZYim
         GtLYnCQaIdu/igrDU+zGb/05ORc5H4XPyTNNqFAZkLRT50jL5Ec5FPzy1fWAebKCVR82
         PyPw==
X-Gm-Message-State: AC+VfDzbjfGXd6azaum4DyJxuNGp/5T41z6a8lDR2t5B7mWnZV2CBqGr
        mMv7P8WyFWPerVwu5DE1TR4=
X-Google-Smtp-Source: ACHHUZ7Xtl06MmK5GFgU1BKJpGGf3ZGDlO1Oejf6LXr526hxRYdZpANf6qKDQKVkuyQcrRwLKDUcmQ==
X-Received: by 2002:a05:6a00:1ad1:b0:648:fcfa:cc14 with SMTP id f17-20020a056a001ad100b00648fcfacc14mr13599419pfv.21.1683972746164;
        Sat, 13 May 2023 03:12:26 -0700 (PDT)
Received: from yoga ([2400:1f00:13:e6d6:5993:330d:5f44:6315])
        by smtp.gmail.com with ESMTPSA id 19-20020aa79213000000b00640df8c536csm8681463pfo.12.2023.05.13.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 03:12:25 -0700 (PDT)
Date:   Sat, 13 May 2023 15:42:17 +0530
From:   Anup Sharma <anupnewsmail@gmail.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     anupnewsmail@gmail.com
Subject: [PATCH] gpu: drm: bridge: No need to set device_driver owner
Message-ID: <ZF9igb/nvL6GRBsq@yoga>
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

There is no need to exclusively set the .owner member of the struct
device_driver when defining the platform_driver struct. The Linux core
takes care of setting the .owner member as part of the call to
module_platform_driver() helper function.

Issue identified using the platform_no_drv_owner.cocci Coccinelle
semantic patch as:
drivers/gpu/drm/bridge/samsung-dsim.c:1957:6-11: No need to set .owner here.
The core will do it.

No functional changes are intended.

Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index e0a402a85787..10dc3315e69e 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1954,7 +1954,6 @@ static struct platform_driver samsung_dsim_driver = {
 	.remove = samsung_dsim_remove,
 	.driver = {
 		   .name = "samsung-dsim",
-		   .owner = THIS_MODULE,
 		   .pm = &samsung_dsim_pm_ops,
 		   .of_match_table = samsung_dsim_of_match,
 	},
-- 
2.34.1

