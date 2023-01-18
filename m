Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8476728DF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjART7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjART7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:59:18 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AAD5A817
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id q10-20020a1cf30a000000b003db0edfdb74so1716553wmq.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6Bdv7nTejW0X4oYcoZpe18GPl2p/Zqclu64+iodiD8=;
        b=CYVT5Rppani6wxwY8+voluYiPSOsncCvGa+9pYIBABQO8FxN6ytHC1WoU8lTwWHT3w
         V5mDrRk2t9+TMd0VmG2rX5cufRRP3IgKhHLV6AyfPj6GhswQ1fvVJOoBklO7WKrfPpjk
         gbAHGglQccmMoF1oskhLNOLNk9zt1WOwUU9ZClWevBf2+HBFG62iA8fO7JhOh3k2qxZY
         2cUP+eiug7qSpj3M8xKYo8r859zNo2GkORY+xWfGF36AA7FI8e6vVUglferv+ByYHQiV
         jfxj6J8hvtQ/w9+HDIjf7dXHySMl+UQH5QrbMaGTehEMYAkoIDCnyIu1FTjWb9eQv2CF
         m/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6Bdv7nTejW0X4oYcoZpe18GPl2p/Zqclu64+iodiD8=;
        b=u4AHp0IwJJ2ixnQpqggXZYoYEZVMuY8Vj1R7ymQ6XLkve4OJnDK3p+lFLkPLDPHmh8
         GeBZHCHN9SERVl1ZpbblU0csiN9YNuVfVXUcCJjj1AbLDMAFeopOX4MRcWm7jLjv6Ckz
         tReAHGduQV0IsYEdVMSx0Ab1UNcuuV1EH3wgap55+5YNjJgHp6MIKKkyDHdwVkxvLtGQ
         pqmLFBFdGhg5jgGPkQOxt4kY24TE4PNcMtiKiMqsz8MkZU5aJyGsnhEeS/nXf8QWbmw4
         Qdm4ZJALBBPg6DiY+hlwafM0D6y6Yn873Pkwvw8HABQYW5IyM7fh+XauRh8s3EW9rpj/
         KJhA==
X-Gm-Message-State: AFqh2kr01jmg4LoGbfYHxosuCoabdyyZsY2zysbEuFWeQrFZWkKMhjr/
        sNO4EJ7hvlWUQLlLqqvdmBc=
X-Google-Smtp-Source: AMrXdXtobt3huvs1MBdSTFnIWy+NxrYZPYk/TmDvlu0QH1DBBkkRMDIJeJTLmHUqK0Yqs3up4JBrfg==
X-Received: by 2002:a05:600c:5107:b0:3da:272a:bcf3 with SMTP id o7-20020a05600c510700b003da272abcf3mr2150925wms.3.1674071955666;
        Wed, 18 Jan 2023 11:59:15 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id o2-20020a05600c4fc200b003cf894dbc4fsm3023595wmq.25.2023.01.18.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:59:15 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:59:13 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: rtl8192e: Remove unused variable SifsTime
Message-ID: <40234d0b1ab1eff23c71d96e8b0f1f0085e2bbac.1674071236.git.philipp.g.hortmann@gmail.com>
References: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674071236.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SifsTime is written and then never evaluated. Remove resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index f7865d0c787a..ed27bdbb8fb9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -581,7 +581,6 @@ void rtl92e_get_tx_power(struct net_device *dev)
 
 	priv->framesync = rtl92e_readb(dev, rOFDM0_RxDetector3);
 	priv->framesyncC34 = rtl92e_readl(dev, rOFDM0_RxDetector2);
-	priv->SifsTime = rtl92e_readw(dev, SIFS);
 }
 
 void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index cbafbecb5ca5..feb48ee35110 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -412,7 +412,6 @@ struct r8192_priv {
 	u8 short_preamble;
 	u8 dot11_current_preamble_mode;
 	u8 slot_time;
-	u16 SifsTime;
 
 	bool autoload_fail_flag;
 
-- 
2.39.0

