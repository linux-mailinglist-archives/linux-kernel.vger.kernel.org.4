Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0826B510F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 20:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCJTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 14:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCJTki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 14:40:38 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8960F8E72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:40:36 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso4177687wmp.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678477235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hIVM9gDEt50e3uY9K91rrf6A4MD0eVPqdDEqNDoPjx0=;
        b=Af7JO7HxSOsGysQU2nQpndk//csoYcKGBL4rZwe2nN407kJAQPmjKfXEFVRhXMEVNZ
         ikk5tm3pAxtPM2b0fQFjy7Cio6kRgg620dAkNUa+zbgAgP/U4Np0VSLP5obKSYj28w6Z
         Rlq3qqrIZFsiNbuZzjQFJFVuaIeSMMFVho++ESu8t02hi9IhbmcEo85kvl8ngm/p7ccI
         wzIr//rPJb6Hnys6s6/TLrTxjF8exKUkOB4NQrGMAfbipv1vOCVI91eEi7SAh/YSRwic
         DsyBBT0D/8vR0Yt0zd6yTtBmKPAAwbWxI7nJY9jH/qiauQQv885WXlEPACEmxWnqmSGN
         41gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678477235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIVM9gDEt50e3uY9K91rrf6A4MD0eVPqdDEqNDoPjx0=;
        b=xErDDeEhUBNYhCmr7u/6E+OvdYxpZf3BwTDuSTs8nYdV1LW9vfafgTxJ55440fP8fC
         QIKiiyTrhBlKjEacX6fAUPl5GGUIM87TW45qzSQs8IwVfs+iVikkyOtcOm6RG+uyCElh
         W3B30TtWRyw8rkce1sB4W3F6x5F1zGdNG3E8t4TnKLqjcdIReuaO61cGcuyMc91vPvvs
         ZYqz0cESs0amSKTD7a9XtsgIC1ftMTpt22TZhNRNeuCDAPgIeiAYJKiGBcqK0vtemobG
         vYr0BiqwAnfer2wSdreCspwruwFvGmPRHscg72f0gwB5mCiMGoFaZBQdGoFBAVu+w+lI
         N+MQ==
X-Gm-Message-State: AO0yUKULI/AhW4flRLD5/asnOuJrL8TPBZlChaDLghGIzKKqOVEvgeDX
        vouM90beAmeMazu0wI4eQvt2raFyuYuYow==
X-Google-Smtp-Source: AK7set9066pNFYOHzB+Q22vNE9iBk4JmLORV4Yc2gkxfEkMoebK5w//tiGEoY8OZ+zx+nNOcp+LjGw==
X-Received: by 2002:a05:600c:154a:b0:3e7:95ba:e1c7 with SMTP id f10-20020a05600c154a00b003e795bae1c7mr3836812wmg.32.1678477235162;
        Fri, 10 Mar 2023 11:40:35 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bce10000000b003eaee9e0d22sm718524wmc.33.2023.03.10.11.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 11:40:34 -0800 (PST)
Date:   Fri, 10 Mar 2023 22:40:29 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix exceeds line length
Message-ID: <eb7475da-7548-4820-a2b6-ff0f6cf4be71@kili.mountain>
References: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAtkW6g6DwPg/pDp@khadija-virtual-machine>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 10:09:47PM +0500, Khadija Kamran wrote:
> Length of line 182 exceeds 100 columns in file
> drivers/staging/grebus/arche-platform.c, fix by removing tabs from the
> line.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index fcbd5f71eff2..0f0fbc263f8a 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -179,7 +179,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
>  				if (arche_pdata->wake_detect_state !=
>  						WD_STATE_COLDBOOT_START) {
>  					arche_platform_set_wake_detect_state(arche_pdata,
> -									     WD_STATE_COLDBOOT_TRIG);
> +						WD_STATE_COLDBOOT_TRIG);

The original line was done deliberately so that it lines up.  If we
apply your patch and re-run checkpatch -f on the file then it has a new
warning:

CHECK: Alignment should match open parenthesis
#182: FILE: drivers/staging/greybus/arche-platform.c:182:
+                                       arche_platform_set_wake_detect_state(arche_pdata,
+                                               WD_STATE_COLDBOOT_TRIG);

Always try to think about the bigger picture.  Why did the original
author do it that way?  The change makes checkpatch happy, but does it
make the code more readable?  Is there a more important readability
improvement to be done here?

For example, you could re-arrange the if statements like this and pull
everything in a few tabs.  Don't necessarily do that.  Just think about
doing it.  I write quite a few cleanup patches that I don't send because
the next day I just decide it's not worth it.

When I look at this file, the style is not bad at all.  But at the start
of the file there is #if IS_ENABLED(CONFIG_USB_HSIC_USB3613).  What is
that?  The CONFIG doesn't exist and the header doesn't exits.  Probably
it can be deleted.

But that raises a new question.  Lukas Bulwahn is always looking for
CONFIG_ entries which don't exist.  I would have expected him to find
this already.

Anyway, we can write our own scripts to make a list of stuff inside
IS_ENABLED():

git grep IS_ENABLED | \
	perl -ne 'if (/IS_ENABLED\((.+?)\)/){ print "$1\n"}' | \
	sort -u | tee CONFIG_list

Then we can go through the CONFIG_list file and see which other stuff
doesn't exist.

for i in $(grep ^CONFIG CONFIG_list  | cut -d '_' -f 2-) ; do \
	grep -q -w "config $i$" $(find -name Kconfig) || echo $i ; \
done | tee CONFIG_not_found

I have never done this before so I don't know what you'll find.  But
everywhere you look if you just look closer then it raises questions
which raise more questions.  So it's interesting to explore.  Anyway,
look closely at each line in the file and follow the rabbit holes until
you find something interesting to work on.

regards,
dan carpenter

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index fcbd5f71eff2..2d9e0c41b5e3 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -165,43 +165,39 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
 		 * 30msec, then standby boot sequence is initiated, which is not
 		 * supported/implemented as of now. So ignore it.
 		 */
-		if (arche_pdata->wake_detect_state == WD_STATE_BOOT_INIT) {
-			if (time_before(jiffies,
-					arche_pdata->wake_detect_start +
-					msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
-				arche_platform_set_wake_detect_state(arche_pdata,
-								     WD_STATE_IDLE);
-			} else {
-				/*
-				 * Check we are not in middle of irq thread
-				 * already
-				 */
-				if (arche_pdata->wake_detect_state !=
-						WD_STATE_COLDBOOT_START) {
-					arche_platform_set_wake_detect_state(arche_pdata,
-									     WD_STATE_COLDBOOT_TRIG);
-					spin_unlock_irqrestore(&arche_pdata->wake_lock,
-							       flags);
-					return IRQ_WAKE_THREAD;
-				}
-			}
-		}
-	} else {
-		/* wake/detect falling */
-		if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
-			arche_pdata->wake_detect_start = jiffies;
+		if (arche_pdata->wake_detect_state != WD_STATE_BOOT_INIT)
+			goto out_unlock;
+
+		if (time_before(jiffies,
+				arche_pdata->wake_detect_start +
+				msecs_to_jiffies(WD_COLDBOOT_PULSE_WIDTH_MS))) {
+			arche_platform_set_wake_detect_state(arche_pdata,
+							     WD_STATE_IDLE);
+		} else if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
 			/*
-			 * In the beginning, when wake/detect goes low
-			 * (first time), we assume it is meant for coldboot
-			 * and set the flag. If wake/detect line stays low
-			 * beyond 30msec, then it is coldboot else fallback
-			 * to standby boot.
+			 * Check we are not in middle of irq thread
+			 * already
 			 */
 			arche_platform_set_wake_detect_state(arche_pdata,
-							     WD_STATE_BOOT_INIT);
+							     WD_STATE_COLDBOOT_TRIG);
+			spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
+			return IRQ_WAKE_THREAD;
 		}
+	} else if (arche_pdata->wake_detect_state == WD_STATE_IDLE) {
+		/* wake/detect falling */
+		arche_pdata->wake_detect_start = jiffies;
+		/*
+		 * In the beginning, when wake/detect goes low
+		 * (first time), we assume it is meant for coldboot
+		 * and set the flag. If wake/detect line stays low
+		 * beyond 30msec, then it is coldboot else fallback
+		 * to standby boot.
+		 */
+		arche_platform_set_wake_detect_state(arche_pdata,
+						     WD_STATE_BOOT_INIT);
 	}
 
+out_unlock:
 	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
 
 	return IRQ_HANDLED;
