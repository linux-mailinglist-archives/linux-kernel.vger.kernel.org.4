Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29316728E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjART7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjART71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:59:27 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEE6539BC
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so12307955wrw.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 11:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gL1FkEaorEI3622tNzniLT0WZMhnZ6o6rTarBUJjzLE=;
        b=IdJGfjvtx9jkeYj6ysFX/AYke3km1XDMH2XmccyjMDhQhnvhIrkNgm7/rd0DrfbLJ3
         rBdIANhozdVkIcM4Tc7CRNQjEuujpoNrmBNwRlRYLjc50UgE5vADHeoqcgemUeVf/l88
         7FMwaHSk5qmaxM9REC+0Tya9xw7XMPBF5YCW96eXIkGdllLHBqDowFifin/iH+CJg3El
         2ip8hBUtXQAcxms/Uz6QvY901W4Xnx2GizIHiSK0x9R9Xl5mGyvrpSYngehofTs1BLKz
         efmL2uV7D/Dr46mC12zYP+MKcQOZKC0GyaJTPenmcOn5rgoHmOmJrQerc7yB8qtU9qFd
         blAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gL1FkEaorEI3622tNzniLT0WZMhnZ6o6rTarBUJjzLE=;
        b=i1bqhpMs7W87/fW0kA0HAAn4xMvm+KZ9b4CQSRfbYKU5GVw4V4CTZz2WMpzmhJmPEa
         +5XnlEF/AxBNq3zFK2AUIhuGqjcZeCZvnMwpnQ+5JZnDs40xXlipLq1iofBSFfOdjCNV
         i8pPlmm7rtpyVhszSxbaSDXdvxLcEW9feyU39xHlAUrRChgYP+Z4xfcJiZF6zupA7yLw
         buakMkQe3WpNchi8YIJ5b45niMDcGvRjXab9+sIC2UtavDi3AkcYXhljpBzS//ZzlSFi
         8FjV9zCOufbp/pJS2LciePcAHpp9e+hlIYhc/IvXJVaoBmxmET18Ar3Guxw7XbKBZyTb
         +tfA==
X-Gm-Message-State: AFqh2kq78RFQO8Pd57KF5n7DqNTWqGvJ4+V+CSGufRjbko6qR3Cs4sTO
        y6B1MEbwYChmI0/D8V4HzOs=
X-Google-Smtp-Source: AMrXdXvDmPzN4UrOogPUAFH0CxrWLe7guNnTBNpBV1/tfUDZ5nX4DJojhor1KyUakXs14ri9w2FExg==
X-Received: by 2002:adf:dec3:0:b0:2be:110d:5d4d with SMTP id i3-20020adfdec3000000b002be110d5d4dmr1387304wrn.7.1674071964123;
        Wed, 18 Jan 2023 11:59:24 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm37913858wrs.0.2023.01.18.11.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:59:23 -0800 (PST)
Date:   Wed, 18 Jan 2023 20:59:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] staging: rtl8192e: Remove unused variable framesyncC34
Message-ID: <e641717f1b89dd9bba99a0f14fc2c24996cb6bd7.1674071236.git.philipp.g.hortmann@gmail.com>
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

framesyncC34 is written and then never evaluated. Remove resulting dead
code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
index ed27bdbb8fb9..aafe39e50bd9 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
@@ -580,7 +580,6 @@ void rtl92e_get_tx_power(struct net_device *dev)
 	priv->def_initial_gain[3] = rtl92e_readb(dev, rOFDM0_XDAGCCore1);
 
 	priv->framesync = rtl92e_readb(dev, rOFDM0_RxDetector3);
-	priv->framesyncC34 = rtl92e_readl(dev, rOFDM0_RxDetector2);
 }
 
 void rtl92e_set_tx_power(struct net_device *dev, u8 channel)
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index feb48ee35110..626a2bc48969 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -513,7 +513,6 @@ struct r8192_priv {
 	u32		continue_diff_count;
 	bool		bswitch_fsync;
 	u8		framesync;
-	u32		framesyncC34;
 	u8		frame_sync_monitor;
 
 	u32		reset_count;
-- 
2.39.0

