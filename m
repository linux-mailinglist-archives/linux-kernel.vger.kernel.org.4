Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2365B5063
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 19:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIKRuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiIKRtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 13:49:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EE738B9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:44 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id e17so9719156edc.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=y24/RvSJFD8cj8h+YiCKjB2PoZPXleU4CbfhX08+KNs=;
        b=IHMNQxrt+rOP0k2us6CAbp0ky7uq7haAPtxhLdt9gQ4ZNiXxC5zP6WhGPiuC8tFmn+
         6wPNfbkYBb/F71//EvB37wJSC+kYuvbI2rGBP2Nu8VBn/BbqvpeX27dFJ1KqoKKBSDtD
         F3l+t+vRuuar3aHEqKWoRZzP0k2zh9baghBW9+Mpyc+zmhXgKns/rjuxgDjOdecFDfbE
         +YL/w0M/Jgygh48txfZ+OYnL2B32GhmFDBF9SSEbYAg5ZgYYOjM3HwG4qyOra6poVvPq
         wqTHUa7ZKau4q0DFnJxLg+fmQoem1wA4sd/2yexlXcP4kOak3aBgjLZPPjP+rkVgaPIH
         uVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=y24/RvSJFD8cj8h+YiCKjB2PoZPXleU4CbfhX08+KNs=;
        b=RWayT5xA7gsAfYpUOTi7ipcqmCMEaW4AVhvnjyiT/fxgL6KdWsin8DkmTQpx++RMCh
         tSzZy4RUSxyRAtsjWV6nBlTKNAT//ycAfjBptz6MOIp4VoliTHNGg5bSZmma2LVnvnWK
         S6j2bZ+e+SLRC4cQkB+JzfdowVUEkxWr8BofJvDW1EWlq6YXIISHiw+GLLozucQKuU3K
         l6z7MvcptvYcWSrDePcGhb1PIIFpU2NMfj1Z8AjIpXDG41yW1bU0/c/XVGyMwpU6/AxQ
         JR1fGwnq9QSv+6CN5tZSgkK7JllX7qwpEh+CGzNw/Nz0mrgzLVib4aZa2DQfSAnWorM/
         xJzw==
X-Gm-Message-State: ACgBeo3x/uDC4JeKnH0jZs9oDFlLhyiGUBQI6fTDuKu2TruSTj6L+iAT
        YKGmjLtI/TrCkkF9bVgHW5w=
X-Google-Smtp-Source: AA6agR4P6WLavtNycwITioe3FMpiPSN01ZSqAggy6dj6KfJMhggxJZjKGevExPsx0QU3OiyyHXUWpg==
X-Received: by 2002:aa7:d34e:0:b0:44e:8d4b:6e02 with SMTP id m14-20020aa7d34e000000b0044e8d4b6e02mr19887131edr.306.1662918582972;
        Sun, 11 Sep 2022 10:49:42 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb6b.dynamic.kabel-deutschland.de. [95.90.187.107])
        by smtp.gmail.com with ESMTPSA id u5-20020a1709063b8500b007336c3f05bdsm3265393ejf.178.2022.09.11.10.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 10:49:42 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/3] staging: r8188eu: remove unused prototypes from recv_osdep.h
Date:   Sun, 11 Sep 2022 19:49:32 +0200
Message-Id: <20220911174933.3784-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911174933.3784-1-straube.linux@gmail.com>
References: <20220911174933.3784-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function prototypes rtw_recv_returnpacket(), rtw_init_recv_priv()
and rtw_free_recv_priv() are not used. Remove them.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/recv_osdep.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index c01943f4f845..437880629a25 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -11,10 +11,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
 void _rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 s32  rtw_recv_entry(struct recv_frame *precv_frame);
-void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
-
-int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
-void rtw_free_recv_priv(struct recv_priv *precvpriv);
 
 int netdev_open(struct net_device *pnetdev);
 int netdev_close(struct net_device *pnetdev);
-- 
2.37.3

