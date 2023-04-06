Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9C76D9BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbjDFPGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 11:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239577AbjDFPGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:06:41 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991BAA246
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:06:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id by26so2138713ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680793597; x=1683385597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5T0UiBH8DISDoFRKB709hQFeGJr3JsBuuEYGSQpde9c=;
        b=BJzxdcn9OpK4VROJmWDyFngYiWYJw61q+0CYvybyICYz4m+ATHkzWY1swrHCukMlzT
         BrG8ctmrJA0FGtsNx8sJM+d8BHmQk1lWqnIw9plUJZtwc9yikHWCoSV0Av9H9xbYRB6S
         NmGSPAk9ly0gC2SIddyj8zNLSIUjs4goPuoMBglStpdbDFtSSggJfgrEGldV60LN7wOk
         hZTEfjF95a3lIJFyZP7SWh3qfXA8zGCwON8WyCJvqy3+5GtJMQfm7jJemnZg/69tv0c/
         hSxUxMxGdInzKGO8ECrJBcoP/IZOPYGXnoOl4B5Ggq1CIkSvd5zwUr76FqEuNeEEI6kd
         VREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680793597; x=1683385597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5T0UiBH8DISDoFRKB709hQFeGJr3JsBuuEYGSQpde9c=;
        b=3M1Cm2YXww+trXSeNfhLG5HP13xFSwfx9cG4gbopWOJ6CbWUbRlMPLBHlxgoXcTyLv
         xK8MVE9W2glxZ1i2cX2C6s3sWvy1fCULjyB0lL+jTCrTXu2SOk+jkd6/efbdnu88Ot8Q
         qXpZ/xrhWeXYVLpf61E3bsyO4W3cORzM3+82BRfZHFUtqwOZlwvwd47mj+zwOtDoCp3V
         mfZTIsjRVmq5+rLMxrJJe/bBIWNkvGlcQgIKQSo14FYhByk1SO0TmCk0h/6oSPFFPfZO
         cBuEPhhj/aMT9mUEXGP6wgpEKm81+wyQ5dpVo4IWA9ONLc6f/6qi4kxa/Apx6TsrzIS4
         h2WQ==
X-Gm-Message-State: AAQBX9clLJeYvCSpQkiGWpSc+Vl+Oqofaw2wdPkKUBfPln9FsYIMEdz9
        VILN/a8EpmMFNHArQQ4AneU=
X-Google-Smtp-Source: AKy350Y3tOEfHxwSiUHXaDOPCFpeS65Kf1F94RWAc8MK3RPHPJRalnERXkxJyPkBf+948ZBbDba7sA==
X-Received: by 2002:a17:906:3f86:b0:929:e5a8:63f7 with SMTP id b6-20020a1709063f8600b00929e5a863f7mr5406203ejj.28.1680793597085;
        Thu, 06 Apr 2023 08:06:37 -0700 (PDT)
Received: from localhost (h130e.n1.ips.mtn.co.ug. [41.210.147.14])
        by smtp.gmail.com with ESMTPSA id gn23-20020a1709070d1700b009476efd5244sm929456ejc.172.2023.04.06.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 08:06:36 -0700 (PDT)
Date:   Thu, 6 Apr 2023 17:04:19 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3 1/2] test_firmware: Fix some racing conditions in
 test_fw_config locking.
Message-ID: <eb117a50-79ad-4f5a-8ad9-73247107469e@kili.mountain>
References: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406015315.31505-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 03:53:17AM +0200, Mirsad Goran Todorovac wrote:
> Some functions were called both from locked and unlocked context, so the lock
> was dropped prematurely, introducing a race condition when deadlock was avoided.
> 
> Having two locks wouldn't assure a race-proof mutual exclusion.
> 
> test_dev_config_update_bool_unlocked(), test_dev_config_update_u8_unlocked()
> and test_dev_config_update_size_t_unlocked() versions of the functions were
> introduced to be called from the locked contexts as a workaround without
> releasing the main driver's lock and causing a race condition, much like putc()
> and putc_unlocked() in stdio glibc library.
> 
> This should guarantee mutual exclusion and prevent any race conditions.
> 

Thanks for figuring this out!  It seems like a good approach to me.
However, I feel like PATCH 1/1 needs some style changes.

The question you seem to be dealing with is how consistent to be and how
much infrastructure to create.  Don't think about that.  Just fix the
bug in the most minimal way possible and don't worry about being
consistent.

(Probably the best way to make this consistent is to change the
 test_dev_config_update_XXX functions into a single macro that calls the
 correct kstroXXX function.  Then create a second macro that takes the
 lock and calls the first macro.  But that is a clean up patch and
 unrelated to this bug.)

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Cc: Luis Chamberlain <mcgrof@kernel.org> 
> Cc: Russ Weight <russell.h.weight@intel.com> 
> Cc: Tianfei zhang <tianfei.zhang@intel.com> 
> Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr> 
> Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr> 
> Cc: Zhengchao Shao <shaozhengchao@huawei.com> 
> Cc: Colin Ian King <colin.i.king@gmail.com> 
> Cc: linux-kernel@vger.kernel.org 
> Cc: Takashi Iwai <tiwai@suse.de>
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
>  lib/test_firmware.c | 52 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/test_firmware.c b/lib/test_firmware.c
> index 05ed84c2fc4c..272af8dc54b0 100644
> --- a/lib/test_firmware.c
> +++ b/lib/test_firmware.c
> @@ -353,16 +353,26 @@ static ssize_t config_test_show_str(char *dst,
>  	return len;
>  }
>  
> -static int test_dev_config_update_bool(const char *buf, size_t size,
> +static inline int test_dev_config_update_bool_unlocked(const char *buf, size_t size,
>  				       bool *cfg)
>  {
>  	int ret;
>  
> -	mutex_lock(&test_fw_mutex);
>  	if (kstrtobool(buf, cfg) < 0)
>  		ret = -EINVAL;
>  	else
>  		ret = size;
> +
> +	return ret;
> +}

This change can be left out completely.

> +
> +static int test_dev_config_update_bool(const char *buf, size_t size,
> +				       bool *cfg)
> +{
> +	int ret;
> +
> +	mutex_lock(&test_fw_mutex);
> +	ret = test_dev_config_update_bool_unlocked(buf, size, cfg);
>  	mutex_unlock(&test_fw_mutex);
>  
>  	return ret;
> @@ -373,7 +383,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> -static int test_dev_config_update_size_t(const char *buf,
> +static int test_dev_config_update_size_t_unlocked(
> +					 const char *buf,
>  					 size_t size,
>  					 size_t *cfg)
>  {

Do not rename this function.  Just add a comment that the mutext must be
held.  Or a WARN_ONCE().

	WARN_ON_ONCE(!mutex_is_locked(&test_fw_mutex));


> @@ -384,9 +395,7 @@ static int test_dev_config_update_size_t(const char *buf,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&test_fw_mutex);
>  	*(size_t *)cfg = new;
> -	mutex_unlock(&test_fw_mutex);
>  
>  	/* Always return full write size even if we didn't consume all */
>  	return size;
> @@ -402,6 +411,21 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
>  	return snprintf(buf, PAGE_SIZE, "%d\n", val);
>  }
>  
> +static int test_dev_config_update_u8_unlocked(const char *buf, size_t size, u8 *cfg)
> +{
> +	u8 val;
> +	int ret;
> +
> +	ret = kstrtou8(buf, 10, &val);
> +	if (ret)
> +		return ret;
> +
> +	*(u8 *)cfg = val;
> +
> +	/* Always return full write size even if we didn't consume all */
> +	return size;
> +}
> +

Just change the test_dev_config_update_u8() to not take the lock.
Add the comment that the lock must be held.  Change both callers to take
the lock.


Otherwise we end up creating too much duplicate code.

>  static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
>  {
>  	u8 val;

regards,
dan carpenter

