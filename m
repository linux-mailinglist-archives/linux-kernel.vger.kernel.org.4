Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29E26CAFC8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjC0UTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjC0UTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:19:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59D3592
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:18:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d17so10019112wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679948336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aE3c1+YhOpnk0+VqylK2i+T0h1qRBhBBnQ1pB7UIS9k=;
        b=pvpwGINoN7998DOLexrD/+Pee8XDqStCqWkT78+tvmaQ/q27xkiAGP8onBoufpE21N
         UL6N+PoxzlaIudePqUMCN6Kai2+CQ4uVp7JsPGNE3UvXYPs9xQt7ES6zJv+moleEotWn
         4vIrncoNr6dLY3Sel9hKOyR17ajZ9iRAThkQq0AmQyQWUv/ai9AGu0R01IyGdC1H9A0q
         BZYYrwZVLXdGkB0HYRHReo8zIXima+fwnCOa94LrliclLGwadiSknL3hSY00ZTaHzhop
         gby3aQmiTxNrGRUlLt/R+Hw+7QkAyFA+aKavuQN6eqoweow9w/QDRvmzhOGO+YXJ79/O
         ntUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948336;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aE3c1+YhOpnk0+VqylK2i+T0h1qRBhBBnQ1pB7UIS9k=;
        b=DY0zD0MMe5m0TN3zAP7NDU2E/EWjteKWXfuTiTMs1rnC+VFI/AE4V9u234BGk6wgyO
         naBhnnWn3GvWczku3AByQ76caUsrQsS0jOELTXhqDww8HYHBGtQLyg6XVZ5zG5Zer/Ug
         XipHX8LiCiliq486/Co8V9zwnvpXTLeUehwvUJJf6XcC0HMwnc+mTK/+aFqJRuJ97oSj
         8vC0RlGgRvlx1lLS2msv86MJcga8vC9Wmitu1VsKiOMuWZA6v9TmXmWyCT+6gF9YRwn4
         dkrQEubzFKoSxYch6t3SrJMufMreC1xZXFNSSs5G7NwgF8ABxsAAkqtr0xqB1xBkcc3a
         3XBw==
X-Gm-Message-State: AAQBX9cALyrFi5Py3/OVvWTAdtblzIAiulcMIuFIERdn278ydpo/G0Nw
        mL9WofvqZO0Qw3njFrEXSaDOEPGSSPqBR13JPQc=
X-Google-Smtp-Source: AKy350bWRrrFK/UWbIJj+A6sdJi9RcyEXWj3uELwAgv0zHzNsL0/kY6uaIKblmDOEyU/cEgGyveztA==
X-Received: by 2002:adf:cf12:0:b0:2d7:4c98:78fe with SMTP id o18-20020adfcf12000000b002d74c9878femr9996122wrj.34.1679948336309;
        Mon, 27 Mar 2023 13:18:56 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id v13-20020a5d6b0d000000b002daf0b52598sm12725301wrw.18.2023.03.27.13.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:18:55 -0700 (PDT)
Date:   Tue, 28 Mar 2023 01:18:53 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: refactor arche_platform_wd_irq() function
Message-ID: <ZCH6LV5XU0FBlW7Y@khadija-virtual-machine>
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

Refactor function by adding goto statement. This reduces the
indentation and fixes the issue reported by checkpatch.pl script.

"CHECK: line length of 101 exceeds 100 columns"

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..c7d3b6f7368f 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -178,11 +178,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 				 */
 				if (arche_pdata->wake_detect_state !=
 						WD_STATE_COLDBOOT_START) {
-					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
-					return IRQ_WAKE_THREAD;
+					goto out;
 				}
 			}
 		}
@@ -205,6 +201,11 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 
 	return IRQ_HANDLED;
+
+out:
+	arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
+	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
+	return IRQ_WAKE_THREAD;
 }
 
 /*
-- 
2.34.1

