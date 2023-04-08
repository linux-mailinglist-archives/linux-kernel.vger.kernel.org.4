Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7D06DBC4E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 19:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDHRSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 13:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDHRSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 13:18:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B05F974E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 10:18:11 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bp17-20020a17090b0c1100b0023f187954acso1138034pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Apr 2023 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680974290;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EP0xHsBJuGQ8+LLXtPS0+w3ttj9z4w16bhu80ACSGOk=;
        b=O+SylsnpuMNH6HnC5Jme0ln//6knJgePalkuF79wOu/ALcbq6z40JvVyUy05RNVO8G
         mxtPOt/qBujPn/wFHAMKBtlldwivvRzs0EI2yVqP8ogciBMUtdofB1MogM0AFXoOYxsB
         16rNpvSEH8oUGjQ9MFmYocgdOH8C7kK0mzHm4KUdNPdIbMuliWYRKIGVN5nEubVLYa75
         GYSLG+xDsW+lahjzo+ibEjIMDY2CrEm7N+PeqAZwDQJmaKDibCQBS+XmDb6T1w/ghsaK
         7SIuVWdTGb+yZ8HHzDmV/r7orD29mwB8Mc9FWafhMLv8d9gOMneAUOB7Y/lYf+f4ZAQx
         5EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680974290;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EP0xHsBJuGQ8+LLXtPS0+w3ttj9z4w16bhu80ACSGOk=;
        b=rU3w0X5REz1KkXLSQWHm/4QgmPFs7DoxffaZoah4ld5k0Ppvup+EJ1ZBYuSJnheKWE
         nuXMRY8tIISUzgZKjI16obor41m8qedRoX5ihzWG/akiyyx0g7EWyfjXPyami+saELVc
         PoTSa5Heyp90Nj665HCb3t7orl1MYCz+lamQGanFImKw5FWtM/lcM5rKyVy6+CbqJZnu
         Bc7Q/o6oyeObrwzkf5a27R/kOXcVWL6ZkpbQSpwOJFctpJQkuhRTUW/w7owWxxWcdSBd
         oulE9pgLNVC8X92aW0QTGJMyIji/10z00DBBc3Df2dpmXbaGF5IV5R55iQdjbBzas7GA
         wYPw==
X-Gm-Message-State: AAQBX9c5tIuv06mQzV7U7fmtqiuTB3PpzgJM1I7PKaVnrQLvT9u/nJLc
        nCW10MhrJxZ/+wsS9KT4DnUHnmkAQ+VrGQ==
X-Google-Smtp-Source: AKy350b0iFKnWt9b+S7PUE1tvOtQQDFxnoSrY2EuGsYnKtN3Twh/DDfSRGWG1W4158J1SdY9f9KXyA==
X-Received: by 2002:a17:902:ea03:b0:19d:1a8e:836f with SMTP id s3-20020a170902ea0300b0019d1a8e836fmr3215037plg.27.1680974290532;
        Sat, 08 Apr 2023 10:18:10 -0700 (PDT)
Received: from sumitra.com ([117.207.136.97])
        by smtp.gmail.com with ESMTPSA id y3-20020a170902864300b001960706141fsm4766560plt.149.2023.04.08.10.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 10:18:09 -0700 (PDT)
Date:   Sat, 8 Apr 2023 10:18:03 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fix logical operator continuations
Message-ID: <20230408171803.GA262580@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix logical operator continuation as suggested by Linux kernel
coding-style. Check reported by checkpatch:

CHECK: Logical continuations should be on the previous line

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 5a1cd22f5e25..58ed394202ae 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -209,8 +209,8 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 					&priv->rtllib->pwr_save_ctrl;
 
 	if (!((priv->rtllib->iw_mode == IW_MODE_INFRA) &&
-	    (priv->rtllib->state == RTLLIB_LINKED))
-	    || (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
+	    (priv->rtllib->state == RTLLIB_LINKED)) ||
+	    (priv->rtllib->iw_mode == IW_MODE_ADHOC) ||
 	    (priv->rtllib->iw_mode == IW_MODE_MASTER))
 		return;
 
-- 
2.25.1

