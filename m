Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151AD734185
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbjFQN5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbjFQN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:57:18 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBE12733
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:07 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-97ea801b0d0so44269266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687010225; x=1689602225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIMmJZNKdVJKf5s/fQBJd8OR0Xg5vYUmJ8kETjtUHz4=;
        b=cox+Vqu8nJZ5nWmzdZdQEcb36U8lsTv/JEyisY0eRjSPBywqVIw8ULjuq1/zUFjizj
         ezIg6K+uSmumSfuSHhon+O9bdGIggoswOhqdNqRajDP7Rlo3FjTYpTlQJ4KMLlZpoqjv
         Soi2wmHhC25RIqu0EA7VijJ5xFbLzVs+/BFA2ivdiQ3Oh7lUptCLj1o3gB+vx7cYVyNf
         c23m5R4v25a19iKFnCnoUGoyzeQzCzF4s332oQTPj3usEh9fzpkt+xThCNyt8JkumGSa
         PaZ5OIToXt0T6li1uVRhuCzMKhxgwp7o1JYxNIx0UHESeMny65RniVg/EJTjO16y6yfQ
         tAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687010225; x=1689602225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIMmJZNKdVJKf5s/fQBJd8OR0Xg5vYUmJ8kETjtUHz4=;
        b=SX2b2W4y9OCPakVxcp7O/C3Uuq+DGas2urKW5yTF2sUg367lFRSb0CEpd3xgWKh0M4
         kJTvlY0ehSf2NWKvpNg5Xrwavz31DGzFY+sdyMsyFZv7RiUmRfT7bH2nzPuM8qHhYiPg
         Uqx/8sFrlj+xLzv0KHCDOB41oj90RSzDBFTFqZxHHVWjMzEsvvAaL4uCU6IhH4vJPBXw
         9HZy9nMfmA/kgqPtSv1VkNFoPoXZl3ry6+kqNVtPYLq9KEe7Ak6oBIEzou+knfkAfmnl
         2n180l9ZUVOdQmaJoBf1sWdmcIoqUgYCDb0ypPP2Cb5D+82utuVuBxkDYG3CTrIycpcg
         CE9g==
X-Gm-Message-State: AC+VfDx+htMaF68HupEfZinxV5uBjEMoFKh2xvSVIPM8OXX0QqALnkIJ
        RRLqGz6ScKTGy1QrRGCi384=
X-Google-Smtp-Source: ACHHUZ5WRJHmfUMmbZnPVqpPM5d5eA51k47FXLE6awSUrPA6tELQ3r3QOA/6qGIlS216KNoTTL7lHg==
X-Received: by 2002:a17:906:6493:b0:987:6960:36c5 with SMTP id e19-20020a170906649300b00987696036c5mr1352113ejm.6.1687010225451;
        Sat, 17 Jun 2023 06:57:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906258300b00977d194bf42sm11993601ejb.161.2023.06.17.06.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 06:57:04 -0700 (PDT)
Date:   Sat, 17 Jun 2023 15:57:02 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: rtl8192e: Remove unused enum led_ctl_mode
Message-ID: <554729dba4d9358bdd6146ebd8fa17a0f525702e.1687007788.git.philipp.g.hortmann@gmail.com>
References: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687007788.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused enum led_ctl_mode to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 99a6501f615a..2ebacd6720f1 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -420,17 +420,6 @@ enum init_gain_op_type {
 	IG_Max
 };
 
-enum led_ctl_mode {
-	LED_CTL_POWER_ON = 1,
-	LED_CTL_LINK = 2,
-	LED_CTL_NO_LINK = 3,
-	LED_CTL_TX = 4,
-	LED_CTL_RX = 5,
-	LED_CTL_SITE_SURVEY = 6,
-	LED_CTL_POWER_OFF = 7,
-	LED_CTL_START_TO_LINK = 8,
-};
-
 enum wireless_mode {
 	WIRELESS_MODE_UNKNOWN = 0x00,
 	WIRELESS_MODE_A = 0x01,
-- 
2.40.1

