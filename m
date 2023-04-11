Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A6B6DD274
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDKGKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDKGKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:10:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768F61704
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:10:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so12246728pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681193437;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dkAjXSbInJqpK+AYc3d/JTbngjvRoOz7ZrebCZ3Qty8=;
        b=Cq+C1T1mKjadyzRrmUi7YZr+1GwwK9zT2NdxFEBImGXebuTjB81i64Obyilk+jpUsb
         98mTqc4iHqgU7ZyXys6ZXQ659/ifXQ9nNG1JKRhH+bebbYzUfamDCEMyNGfyM7Am1bOB
         c5iKP4psRGYi5nCPFdZ+yvvOSp7BBmd+610XUzXupPqWLGChkHS5DvB03fu6S/IdjhuE
         FLi0R3A5bdsRwxdLOdyP3yXqpDV/cEhjK6B8Gv39dSjAxOSfCbl1WmeBwg6Semcmf6sR
         Bx93unBSUdjLL76QB0aRi0tgM7pfYidEyPK79ATA3mkNzQVnfe15CyN/xE9oJqeYaPMP
         RAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681193437;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkAjXSbInJqpK+AYc3d/JTbngjvRoOz7ZrebCZ3Qty8=;
        b=yf1+iCcEN+C3ZRE2zRCBlF6Zrs/d+Uu4LFeWFLkpBOfqxTLha49FtFw/gTwU1q45j6
         TmhNZIQFJCfX8EIi1sAjxK5YO5msGV5uJq6DxpOEVFnssIre1Ye7mmn9wsBcG9+J//Wu
         Qy6l7bHWrES6Qag2dTT+WDhHwAHV5Y/ftyUq8VTR+vRhpATYXmLPuyxEZS4pzkBMdZ0W
         cvPqHqGbJRFmsBRfeFhbh3MmrDmmApk5o1DaHyOuzdXZ35gKnyN/BpMCQnUZmNvSM8zw
         9EPUogHSEswQKv/ykErWq1KPQ/fkYGJ+e92ZXA5yR4h2kuqqJ5/RVcT2El2R7hxcRC9W
         D5Lg==
X-Gm-Message-State: AAQBX9cod10JFh9u8Acw82YpaXqZKg+jFyIPnZVAS+R4uCWvg3t5yBt2
        R1ZCQXIxS8VvLLn8QydrXFkeHvNepdHxEQ==
X-Google-Smtp-Source: AKy350a8JFT2RNuf4juC0oFeBWrPRMCjw/qVCOsvKbwrvnqLx20P2GC0fu66AA4AUiKdwkNp/udOdA==
X-Received: by 2002:a17:902:e803:b0:1a0:6a47:184e with SMTP id u3-20020a170902e80300b001a06a47184emr16859960plg.42.1681193436916;
        Mon, 10 Apr 2023 23:10:36 -0700 (PDT)
Received: from sumitra.com ([59.95.151.140])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902fe1800b0019aa5e0aadesm6471086plj.110.2023.04.10.23.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:10:36 -0700 (PDT)
Date:   Mon, 10 Apr 2023 23:10:32 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: Move logical operator to previous line
Message-ID: <20230411061032.GA265761@sumitra.com>
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

v2: Change commit message, sugested by
Alison Schofield <alison.schofield@intel.com>

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

