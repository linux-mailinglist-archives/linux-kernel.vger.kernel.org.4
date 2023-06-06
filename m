Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F2D723F3D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbjFFKVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjFFKVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:21:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73778E42;
        Tue,  6 Jun 2023 03:21:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256d1b5f7c0so4413874a91.1;
        Tue, 06 Jun 2023 03:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686046888; x=1688638888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86esAuV3rhpT10J6tH2DReVxyiryzcCN4UKCqr3CPfA=;
        b=JOvJlRzmVD5S2lz08oqLtvPP7i7Srg3FQB7e8cTnnUWNNN68vLQrXxr0rt/15FrcEi
         SbBEQJdbTUh3QHU+C771cJwaxPanKsSuyymzWgOP4fTKZvJqHMoRYsvvQTvq+th4GaiF
         lZ36X1RxLZu7jf3BQ6R8VFkL7Nt1fqObp+ulm1+O58mJFfd3YLBbeJ9ezcD5h+AspliA
         VYmgGka4YRtBsakSMO5gLbgLy5vL77IPpTxgjoRzxPbi1Zrb+mlNvy96rKZTGzEKzZlV
         1QzhvSAkwTECJeAolgKmd7xMrP2/2ufSWJB1ImXjPdL87d6yF7/CInXsudmvB09kWzTG
         YGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046888; x=1688638888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=86esAuV3rhpT10J6tH2DReVxyiryzcCN4UKCqr3CPfA=;
        b=EGtO0V36pMBlYEGIxd+wg4ohsNP2EGYAkRhBs2xczzeuigWwD3YXRxkPVU/mGgBzXn
         SuekjD+1b5Ql9+IMpl9zFgA9gS/KIHV2iJ1ACEVncx6eMTDsCdoXQNx2RrQuf8RS+Ges
         JwmhOuFds17EIA8WTTdZJLx4DBWKuNljHQ7EiZ7rRmlGjQ5WhdS+DUIxmzLwwHjzmxk8
         svzTIJJdFd4ZnyV7z5LEcG5mkWI9WyvGtXaORB1TbHBxyXdleR02cBMj5UsILLxeLUUm
         pKq7yUw6dfrz/tbyAZMpCyHEhHTupu466fgzK3z9oCjfq+QE8T9fdGV97QphV4t+Jo1h
         00Bw==
X-Gm-Message-State: AC+VfDwWn61XHzFMWTBBS4nzZz/hCfoyCWOB4y0sK5sjZsDZ0WiKr1pk
        9W6jG0GgrKTN4hTPt+oS4Glprjm+KOD2gQ==
X-Google-Smtp-Source: ACHHUZ5SIeu076h7qmuM7hlMuuZ0Z3oBf2EPCiW5UFLA0qsOHgKTHc0MzIc4kmbYB7R4DjdHYozCZA==
X-Received: by 2002:a17:90a:5604:b0:256:3191:640f with SMTP id r4-20020a17090a560400b002563191640fmr11448526pjf.4.1686046887721;
        Tue, 06 Jun 2023 03:21:27 -0700 (PDT)
Received: from devbox.. ([103.165.115.136])
        by smtp.gmail.com with ESMTPSA id l30-20020a63571e000000b0053fb37fb626sm7067917pgb.43.2023.06.06.03.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 03:21:27 -0700 (PDT)
From:   Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
To:     b-liu@ti.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Subject: [PATCH] drivers: usb: musb: musb_gadget: Removed unneeded code
Date:   Tue,  6 Jun 2023 15:50:58 +0530
Message-Id: <20230606102058.1010324-1-neelchakrabortykernelwork@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the static int musb_gadget_vbus_session function as it was
doing nothing.It has reduced 13 lines of code

Signed-off-by: Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
---
 drivers/usb/musb/musb_gadget.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 31c44325e828..3cb7fc4c84ed 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1612,19 +1612,6 @@ static void musb_pullup(struct musb *musb, int is_on)
 	musb_writeb(musb->mregs, MUSB_POWER, power);
 }
 
-#if 0
-static int musb_gadget_vbus_session(struct usb_gadget *gadget, int is_active)
-{
-	musb_dbg(musb, "<= %s =>\n", __func__);
-
-	/*
-	 * FIXME iff driver's softconnect flag is set (as it is during probe,
-	 * though that can clear it), just musb_pullup().
-	 */
-
-	return -EINVAL;
-}
-#endif
 
 static int musb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
-- 
2.40.1

