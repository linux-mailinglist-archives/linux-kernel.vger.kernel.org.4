Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478DD73C710
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjFXGGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjFXGFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:05:34 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F542D61
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:05:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso3876985e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586696; x=1690178696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tet128yKFRAGmSck7VlR0R9HJycI8gkXHzRpAiz+cp4=;
        b=XfHsYRrLcYvqHbX5mezvMVFndkXXC8t3V60vN4rVd2S9FF4ERl+n/SESuVPhz6xE47
         cKxcdjuq6csWg/Kg7tPwZRDn39A5TY3mlGMSD+Q9guhvByGPSlcyTvLrEH3Ij2rXSAz8
         o3Jv8WEazYUFg3mt64C/Y+hRsbVJJmFiUdwq1oKXA58Mev1oTalYG3wuvWkwxNtjAvSt
         InyTT2idm4xMeg9XEGg+Y7DkOUKkmhYOEPvFiq2H6giwr7OyuwTu6IQuN+uUA25imLf7
         SraojVtfkSHZXs2KwPE+5hPqqZ/oesb0th0qPCXHWSl9auPjXyAmgwqqlyuvoEmgoD55
         WszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586696; x=1690178696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tet128yKFRAGmSck7VlR0R9HJycI8gkXHzRpAiz+cp4=;
        b=Dxk1MT86qrAis4qyAwW6Z1d9VWAr9YNnDpkRvGvZTzFj35MX8g1cZt/Dt9AjcJto6Q
         b9aKRo604Hb6xvYPpNzcd9ba8u73nr1AWYebCLp8wsXut8wOPHzzSpFvwTg4CDyslnBe
         KFY18441/lfFzshzSlX5h349nbJO9aDWV6UQDcbCSZVZYhflp3EZ/3I3K+kPNaFFNizg
         FSj7+/kjkjN1rRf3nSJb+Sak3assOVC+hA56InANeqQF4tPLTJmCcH9fI9NOOXhK2ToT
         I66v9jDy9CuPvGGtLq/QUDR9SxaGCzxu/iWM1jo9gFu5Owlcybjbi75U0G3KuPBkKJNZ
         OpAg==
X-Gm-Message-State: AC+VfDzfEasW8Ao911HQ1fkttjFqiSSERp2Esas2C9COfqsR0f08Vv0A
        1wKrtgAGCKkXex3papiWtFF6RYMJuzo=
X-Google-Smtp-Source: ACHHUZ4eBS7OlQqScAhFpM4221U82I1snsSK/VLUX/ku9G/PMGOJnrVE3ffTabuNO72GZ0sAbIMBQg==
X-Received: by 2002:a05:6402:2787:b0:516:463d:8a10 with SMTP id b7-20020a056402278700b00516463d8a10mr16811642ede.3.1687586674935;
        Fri, 23 Jun 2023 23:04:34 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b0051beb873d98sm311422edw.27.2023.06.23.23.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:04:31 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:04:27 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] staging: rtl8192e: Remove variable card_type
Message-ID: <f0f40f574ac4837bd2be3b6384ae42d9aabf1832.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove variable card_type as it is initialized but never unused.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 2 --
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 2f504a4838a8..e9eb55c6e6d8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -807,8 +807,6 @@ static void _rtl92e_init_priv_variable(struct net_device *dev)
 
 	priv->rtllib->fts = DEFAULT_FRAG_THRESHOLD;
 
-	priv->card_type = PCI;
-
 	priv->fw_info = vzalloc(sizeof(struct rt_firmware));
 	if (!priv->fw_info)
 		netdev_err(dev,
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index ec9e454299a8..1cb68d53a17e 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -259,12 +259,6 @@ struct r8192_priv {
 	u8		polling_timer_on;
 
 	/**********************************************************/
-
-	enum card_type {
-		PCI, MINIPCI,
-		CARDBUS, USB
-	} card_type;
-
 	struct work_struct qos_activate;
 
 	short	promisc;
-- 
2.41.0

