Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7E86E359E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjDPHUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjDPHUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:20:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92093C01
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-2f44739a2afso407187f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629601; x=1684221601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=90mE4vdn9DzTlSbEbDUJ0ZvC16lpbnbcfCKswzbdsYs=;
        b=VSdKfd6tV+8i05h89Gqj1/SH4zXlr3DvwA7iTIRF3rbn0aSxn7thUq4cJNwm4a/nDP
         viD1eCUNbN/SwsZwS6SbnljvK0WLZVu0x9kpv/6LkJNzRgqvi6IIpHftz8efjIubOJvR
         +JcupzZiYw8X0HNjGoTh/nxDMq/JP6Tgyi38p8RnaicRp0YrqMra6uP/OkevglzP9QF2
         3OqTWTmhi/xu/s9iHs7c+HfbOrPJG57tbTo3gPZMhuHrodS/WbAsr2zZulFTnGHpILNH
         otGQh1JxICB4TiNMaVGgP/6Yna9VBdCYmHYbapv7x2UiS6Hryn4gN0v7eHxa/xMpI1hT
         KCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629601; x=1684221601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90mE4vdn9DzTlSbEbDUJ0ZvC16lpbnbcfCKswzbdsYs=;
        b=ByMpDvJf+I+A+Sp46KYgTsOAi/3AYMSUBgmahec99zAFInnLDpruo+FpD229X63d/P
         YdGOxqhC+8Z0RQa/+3lNnWnthjNJx+TxBn0Cf1tOEVMIMrU3ceqeNn4Y+1eVJwjSE2gJ
         V/ZptaiUChrdVgBWUSMkPQpuLe6t1zBuwG2DVMeKZOGR2ApB05adi2z0r0P2bgfiWWCM
         Y2vTStmRt/JOs5tXuHA0Yij/pXWLgFGw1yPXYdXO/bNL7VXIq2WYxu8AJuyQJYR1QojU
         /Vd1rv4UrbmFkK65Wy118+P5DjuqOBkA8sNMqDPP7vkg4EF4Vfjo92hQroLTqD9985dK
         Apig==
X-Gm-Message-State: AAQBX9c8R0Rh1VXLowbn6mx5w5QSqljsqYThyy2t0E6zoGQBw2uPK9Zq
        AfWPdJIoatqhvFthZsg0pWI=
X-Google-Smtp-Source: AKy350a4IN4nnH5XTOwrfTuJMdHp0biWw11GVr9plvTPUzlCsevkSGG8ElTmF0/m7+UA5g4YDCZa7w==
X-Received: by 2002:a5d:6d4c:0:b0:2f7:dc6a:9468 with SMTP id k12-20020a5d6d4c000000b002f7dc6a9468mr3384392wri.3.1681629600725;
        Sun, 16 Apr 2023 00:20:00 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id s15-20020adfea8f000000b002d1801018e2sm7388202wrm.63.2023.04.16.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:20:00 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:19:58 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] staging: rtl8192e: Remove second initialization of
 bActuallySet
Message-ID: <ebf51fbd56bad4f8fd7fb51fe031f376c3ab6d2c.1681627603.git.philipp.g.hortmann@gmail.com>
References: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681627603.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove second initialization of bActuallySet to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index 93504d5a8578..7342ef591169 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1539,8 +1539,6 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 	enum rt_rf_power_state rf_power_state_to_set;
 	bool bActuallySet = false;
 
-	bActuallySet = false;
-
 	if ((priv->up_first_time == 1) || (priv->being_init_adapter))
 		return;
 
-- 
2.40.0

