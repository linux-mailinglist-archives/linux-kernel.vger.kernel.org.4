Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741DF6428D9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiLEM7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiLEM7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:59:01 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEFE028
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:59:00 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id d2so8091278qvp.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP/5WQh/mEOzVxXR0lIeI+bfQ61vrivbOH56tMcNgoQ=;
        b=ju9s2yD6a403lPEu4ffTSPmB4P9koV8V6cAedPYQgNfH9BTrk3FmI6kgK1i0E9bMz9
         SEfSXQ9s5bMx0rneD7jQ+p+H6Az/1zPrxgFmbqZioBTKuTHT2kiV/1t8z5jC8l19AdOL
         HWeKJfsiTKTeY4NWDhq0i4QNz2Mg+Yxtku9+iCnIEunZxcig8dXEY5l0hb/Er7Bq7+dL
         M7SNsiHhZqepAtLg4aShVpXIiH6C/rfCPYbVn5CH9zZY4DXJFjnkkWa5xg/f4+Lmaxw6
         3B9tamuLB4ZvDHXtxfwnx/fDvgasxYtVtljYRhSFRGZ9rJQ8ndwte3tfKNWfwpHdlXvr
         lbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KP/5WQh/mEOzVxXR0lIeI+bfQ61vrivbOH56tMcNgoQ=;
        b=ST5w3yIH1Buub/CE/7orgZFWujoUR1/4Bq3rqM4GNmXyrd8BGqLw04Wr7Dfn8AEda/
         278cSNnkTq8/JwlZpuOv7d9dl09+NSPPekrQMiykf7v8KyX1gsGTQBWldSCwnUPqYcpO
         oCOcN9mZAB7Xo8gby7qmxYJ8hQeEeL5bzNedvRBOtoSxg275WR04zkLfOtOVo7biZwYG
         eZ1r7KMN38YSOYD8yaoWi1DFvmAQlXpvdfHWcmqsWJouDF6yfgpC+o9BQ/zELerkhU6T
         PQf9vRMDEyYveq6toKlp4w5tu1PxMqc5bTacVvsoYM6hcZjgGZCQbRdmcEcF582N+ViY
         lQuw==
X-Gm-Message-State: ANoB5pm0TGeCBwSUev5Ba4one8RYP+1QHTzVnSZcmJo1NbUVIDdZamXg
        AaZj2jiX4TSK6BHBHEW3dkIP2YVytw==
X-Google-Smtp-Source: AA0mqf6yWjA1bmajIfMwjJqwDtlJuLoQ3+KFzDF3AFDcI3IYNk2ik9OadyMf4zAY2goalZLMVXaEmA==
X-Received: by 2002:a05:6214:5587:b0:4c7:50d9:ec0b with SMTP id mi7-20020a056214558700b004c750d9ec0bmr9681209qvb.59.1670245139269;
        Mon, 05 Dec 2022 04:58:59 -0800 (PST)
Received: from serve.minyard.net ([47.184.139.94])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006feba101f85sm2998505qkn.13.2022.12.05.04.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 04:58:57 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:42e8:b9a0:e0aa:8ed4])
        by serve.minyard.net (Postfix) with ESMTPSA id 764901800D9;
        Mon,  5 Dec 2022 12:58:55 +0000 (UTC)
Date:   Mon, 5 Dec 2022 06:58:54 -0600
From:   Corey Minyard <minyard@acm.org>
To:     yang.yang29@zte.com.cn
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] ipmi/watchdog: use strscpy() to instead of
 strncpy()
Message-ID: <Y43rDpYejtOcne3+@minyard.net>
Reply-To: minyard@acm.org
References: <202212051936400309332@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212051936400309332@zte.com.cn>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 07:36:40PM +0800, yang.yang29@zte.com.cn wrote:
> Xu Panda <xu.panda@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> That's now the recommended way to copy NUL terminated strings.

This looks right.  Applied, thanks.

-corey

> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> ---
>  drivers/char/ipmi/ipmi_watchdog.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> index 47365150e431..0d4a8dcacfd4 100644
> --- a/drivers/char/ipmi/ipmi_watchdog.c
> +++ b/drivers/char/ipmi/ipmi_watchdog.c
> @@ -213,8 +213,7 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
>  	char       valcp[16];
>  	char       *s;
> 
> -	strncpy(valcp, val, 15);
> -	valcp[15] = '\0';
> +	strscpy(valcp, val, 16);
> 
>  	s = strstrip(valcp);
> 
> -- 
> 2.15.2
