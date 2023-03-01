Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914B36A766E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 22:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjCAVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 16:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 16:54:46 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E8C18A8B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 13:54:45 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eg37so59685328edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 13:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677707684;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b0zJx89rfTELdYNbGB67wBjBgKXyCkkaq+sJ4qdy1og=;
        b=jswc3DMkk0426qSQmx5Zjjzc994E/G+dahV+f75JwdlXAV98BmkOA8LQ5/AsVGU+Hy
         6fEGkqqE83vGKSiMrKxXveIe/u3vEj2xkzlPzVZjBGqmoUGBp/iDOxnZ3+el+Ii0pjmv
         HTB6ES5nU7yMYH9NFqx+aczOmdp57LNhQHjZ20uhh4l64DQh+kKcsi85kNB6JphOaana
         SZT0l3hWePyXO1+XykacVV0E4wAY9ju7+G6NnBNVIdNz2jVGJ55YvqXj0y/NL5LYWP1Q
         1XzxScP2P7gp3osHOvWp8O7FejLdmKOFodXmaGlUyQgK4zsV4Rnj3/ghl2FN1yTUBBKz
         a5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707684;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0zJx89rfTELdYNbGB67wBjBgKXyCkkaq+sJ4qdy1og=;
        b=GeyKjpLFj6ABPJAzfNQqoDCweAOuDzlSBng0ufQHMhuq48b48XUCknhylI9NN7Xnkf
         G4GNxwcdTkVRbNRZFwU1b9rKz5s5FTNcIb3NF7qjW0J5ur6q8kYLgKHiM8jQq0ChVjY0
         oruzEfr7rGqkMwvV3Y+ThPH4UwG/kvBBfONzuUN7oRvQTXv34FGQvdpsUiQri0SbiPQc
         5wj88JDb7wZKb28uAmEhOuhWcLoHy8eyIFRVRoUmPz/X6qb0Q0rizWTpB7ZzRB/3g8Rb
         8yBM2UaqskWZSV7On1Pre0u7yXtNPNgp8VbhQftSYilf1HP+0rkPOHD7FUTwjJp1oDBD
         HJjg==
X-Gm-Message-State: AO0yUKUCY+WAvvQN7/qYQnbH043moDa2n5qP1RVOSl7t+nx49aEVEWiz
        dkhQtnVPGcYy4icjcu44spQ=
X-Google-Smtp-Source: AK7set/5eYdTMz7sAdBJfM/DXo+o39OJnj9v29w//m67DhEG7gaIfwDXGNpArRQFaJEcIgOtJJWw4g==
X-Received: by 2002:a17:906:3f44:b0:88f:1255:59c with SMTP id f4-20020a1709063f4400b0088f1255059cmr8232235ejj.1.1677707683785;
        Wed, 01 Mar 2023 13:54:43 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906340f00b008e7916f0bdesm6282232ejb.138.2023.03.01.13.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 13:54:43 -0800 (PST)
Date:   Wed, 1 Mar 2023 22:54:41 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Remove call_usermodehelper starting
 RadioPower.sh
Message-ID: <20230301215441.GA14049@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove call_usermodehelper starting /etc/acpi/events/RadioPower.sh that
is not available. This script is not part of the kernel and it is not
officially available on the www. The result is that this lines are just
dead code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
I found a hint in this blog about the content of the script:
https://github.com/Dekadencee/rtl8187-Linux-Driver/blob/master/ReadMe

If you know more about the purpose and the need for this script please
respond.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
index c04eb15c4044..d8408acfc763 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
@@ -1637,10 +1637,6 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 	u8 tmp1byte;
 	enum rt_rf_power_state rf_power_state_to_set;
 	bool bActuallySet = false;
-	char *argv[3];
-	static const char RadioPowerPath[] = "/etc/acpi/events/RadioPower.sh";
-	static char *envp[] = {"HOME=/", "TERM=linux", "PATH=/usr/bin:/bin",
-			       NULL};
 
 	bActuallySet = false;
 
@@ -1670,14 +1666,6 @@ static void _rtl92e_dm_check_rf_ctrl_gpio(void *data)
 		mdelay(1000);
 		priv->hw_rf_off_action = 1;
 		rtl92e_set_rf_state(dev, rf_power_state_to_set, RF_CHANGE_BY_HW);
-		if (priv->hw_radio_off)
-			argv[1] = "RFOFF";
-		else
-			argv[1] = "RFON";
-
-		argv[0] = (char *)RadioPowerPath;
-		argv[2] = NULL;
-		call_usermodehelper(RadioPowerPath, argv, envp, UMH_WAIT_PROC);
 	}
 }
 
-- 
2.39.2

