Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DA06CB054
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbjC0VDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjC0VD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:03:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B530E9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so41627918edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679950994; x=1682542994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MT5t4boQulRjetg/3fnrhsk3Dnqce+x2uebcAL0xAiQ=;
        b=DjL8IAwBgRhT+yLu9O+NFfgVv9qXEMHhSzS0s08MvjmM1H0XRfsEtkhLVa4gbu2YEf
         D+XEvSC4B8htimvnk/N1uYCV5uLfnmPDTtKtjDjW+Vh2HWi+9i1LLaWefvWZ8E2Ng4SA
         lviD35xdItNHgDDRMsVqfSxXsDqUxuN9TCrKfCr8xleY0WPT7G15KY0+r66lWNVqS7sx
         NjxYQYch1yZKW26uSuDzURokkMyS1YDz1r+tNosW5LjwiWGwea9YQO6+iZi8cN8lNoN0
         9ULmaOXW/+vEcud+uMzB/LkmF++PyoqNXPmMhliX6LS2DNID/3is4YdIaqLfwvQYjfnQ
         7CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679950994; x=1682542994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MT5t4boQulRjetg/3fnrhsk3Dnqce+x2uebcAL0xAiQ=;
        b=e6M/YTXkWrgIvGeflt7UK9boMUTCx3cYecXl1aPAfMytOADwj8K5Mz0RNu8jOQUpCk
         uN0NiI1sEdAW5EnSOB0fIZWVGAKGTTtWjvJu1dug3Fik3WCW9OZsS4szaoPTTVAyoRc2
         oUsrbzJZGBguS+hJWk1/wv9FZC9MqumqKu/1cwX1uif+KcFoXwTqtDqXluHGm9W2+/D7
         +Jg5tr4z13kHRIev3WGxZmnGLOKOU+KBc18Z5Ik6icRqUZcq/xxxvGs5j8p09Gfjf+2b
         Abs/eLqAbfRL6WSPU09LdTQKqo3g683g/G1vEaykdtMgeMxMtIQwRjr11oOsS1q+MKa2
         GsmA==
X-Gm-Message-State: AAQBX9f5+bba3YVuSq3DNKKwQwksEQ5e7fJ3T5lZyezXzO/VPx+ndqw/
        aniDW7LIo+5rRgXPBZQ2If8=
X-Google-Smtp-Source: AKy350axgeXrDsMz7i3yaU0RAi1gc+voidVnK36WqZSdfbvFpue+fo0Aw3nOH50MqHOvV3CiPP5KWA==
X-Received: by 2002:a05:6402:4402:b0:502:367:d5b8 with SMTP id y2-20020a056402440200b005020367d5b8mr17397382eda.4.1679950993703;
        Mon, 27 Mar 2023 14:03:13 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id p25-20020a50cd99000000b004bf76fdfdb3sm14962347edi.26.2023.03.27.14.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 14:03:04 -0700 (PDT)
Date:   Mon, 27 Mar 2023 23:02:51 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] staging: rtl8192e: Remove unused if clauses in
 rtl92e_set_wireless_mode
Message-ID: <359ed203ab08afe5c2f449f40d2958868b4e55b4.1679949171.git.philipp.g.hortmann@gmail.com>
References: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1679949171.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Equation (support_mode & WIRELESS_MODE_N_24G) will always be true. Remove
resulting dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 21 ++------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index c03978353a90..689a5e16eb4d 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -598,25 +598,8 @@ void rtl92e_set_wireless_mode(struct net_device *dev, u8 wireless_mode)
 	struct r8192_priv *priv = rtllib_priv(dev);
 	u8 support_mode = (WIRELESS_MODE_N_24G | WIRELESS_MODE_G | WIRELESS_MODE_B);
 
-	if ((wireless_mode == WIRELESS_MODE_AUTO) ||
-	    ((wireless_mode & support_mode) == 0)) {
-		if (support_mode & WIRELESS_MODE_N_24G) {
-			wireless_mode = WIRELESS_MODE_N_24G;
-		} else if (support_mode & WIRELESS_MODE_N_5G) {
-			wireless_mode = WIRELESS_MODE_N_5G;
-		} else if ((support_mode & WIRELESS_MODE_A)) {
-			wireless_mode = WIRELESS_MODE_A;
-		} else if ((support_mode & WIRELESS_MODE_G)) {
-			wireless_mode = WIRELESS_MODE_G;
-		} else if ((support_mode & WIRELESS_MODE_B)) {
-			wireless_mode = WIRELESS_MODE_B;
-		} else {
-			netdev_info(dev,
-				    "%s(): Unsupported mode requested. Fallback to 802.11b\n",
-				    __func__);
-			wireless_mode = WIRELESS_MODE_B;
-		}
-	}
+	if ((wireless_mode == WIRELESS_MODE_AUTO) || ((wireless_mode & support_mode) == 0))
+		wireless_mode = WIRELESS_MODE_N_24G;
 
 	if ((wireless_mode & (WIRELESS_MODE_B | WIRELESS_MODE_G)) ==
 	    (WIRELESS_MODE_G | WIRELESS_MODE_B))
-- 
2.39.2

