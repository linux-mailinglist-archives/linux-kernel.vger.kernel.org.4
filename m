Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B256605D8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjAFRnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjAFRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:43:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C43B76EEC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:43:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so1570616wmo.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91SF8VEv5OWfr7BVQVJeS0qUaBJRLWmE1paTtWSlkNk=;
        b=F5S5LtEkn6UpgyK4ZdRqG7PREzFRkWFR9ntEYFZEYkYrWO19F3t1G1UkA1mfzFV3+1
         ZNHtbDmVCdb8JLPvY4KgNQkYtM/vKK/FiseLqJnecrhGdyYNUkr9hR6elGwZUv/rOVDr
         uZGA75rjYhoa7IAsBRIa4gB/l5/iceCceQUNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91SF8VEv5OWfr7BVQVJeS0qUaBJRLWmE1paTtWSlkNk=;
        b=fq6tjZ1kWcjhBOfbkf3gMQhCugYX9CQ4I2H652T2KXlwwld/VqZkPoAYVjNXE0562G
         3BRwYD1jWejURi+d75RP1cIMX4c7gvWan5hYFdTlaGW9WdNothm9N4SvPw8OmCkC7PE7
         bgvs4aVqFc5niEIo72U0GtWBiLQyVMGWIPJxM31t3OwB9HB/iE0pmCWD8Jr6Z6XIvSdO
         o3SSQhtdRM7+IAK0I9afAKjcxOvlyqHZI2aYr35lVs4uKeqR1ieqfRPj1MtXIk1T9sgE
         XcmhjROtOV+DbGVG7Ohm1IrGzS6eLWQZAeG97CKRgpJ/S5MHZc60VbrkflVAJ/jFDLnm
         jejA==
X-Gm-Message-State: AFqh2kraUZqxQvemJaFqLJHNc8IPxKanymW3AOdaq9O3Jj+ao1KZd9ry
        oDc63AMtKqC0mJrCcfMHJTqt9Q==
X-Google-Smtp-Source: AMrXdXtSD1W10kYYcsrjXwJcPhNZEFjWcjAy7xGKIyGWPq4m1U5ZvRhIKWL3HO3EVrZrvCXXngfYEA==
X-Received: by 2002:a05:600c:1d03:b0:3d3:4aa6:4fe6 with SMTP id l3-20020a05600c1d0300b003d34aa64fe6mr38928152wms.3.1673027019752;
        Fri, 06 Jan 2023 09:43:39 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b003d99469ece1sm7543346wmo.24.2023.01.06.09.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:43:38 -0800 (PST)
Date:   Fri, 6 Jan 2023 18:43:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y7hdyPAKBYv+gAzf@phenom.ffwll.local>
Mail-Followup-To: Stephen Kitt <steve@sk2.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
References: <20230106164856.1453819-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-2-steve@sk2.org>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:52PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Lee/Daniel, will you pick these up, or should I smash them all into
drm-misc-next for 6.3?

Stephen, I see to be missing 3/4 here, but maybe it'll show up.
-Daniel

> ---
>  drivers/video/backlight/aat2870_bl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
> index a7af9adafad6..1cbb303e9c88 100644
> --- a/drivers/video/backlight/aat2870_bl.c
> +++ b/drivers/video/backlight/aat2870_bl.c
> @@ -59,7 +59,7 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
>  	struct aat2870_bl_driver_data *aat2870_bl = bl_get_data(bd);
>  	struct aat2870_data *aat2870 =
>  			dev_get_drvdata(aat2870_bl->pdev->dev.parent);
> -	int brightness = bd->props.brightness;
> +	int brightness = backlight_get_brightness(bd);
>  	int ret;
>  
>  	if ((brightness < 0) || (bd->props.max_brightness < brightness)) {
> @@ -70,11 +70,6 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
>  	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
>  		 bd->props.brightness, bd->props.power, bd->props.state);
>  
> -	if ((bd->props.power != FB_BLANK_UNBLANK) ||
> -			(bd->props.state & BL_CORE_FBBLANK) ||
> -			(bd->props.state & BL_CORE_SUSPENDED))
> -		brightness = 0;
> -
>  	ret = aat2870->write(aat2870, AAT2870_BLM,
>  			     (u8)aat2870_brightness(aat2870_bl, brightness));
>  	if (ret < 0)
> -- 
> 2.30.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
