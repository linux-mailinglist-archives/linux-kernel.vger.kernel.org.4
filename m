Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA0160EEE2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiJ0EEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiJ0EEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:04:41 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA7B2B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:04:25 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1322d768ba7so462985fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=O4zxOHr5pL/tZbv/Lney9NNoy+V8TXoApZzVW+UpE9c=;
        b=djdp3vBObrtKXk5iR2I5mQ+gUxa3qFdrLVOfoGTRZRKq0CjbUBqUL47z3HYzO5ZEvS
         xUP1b7enKhRqRrp9dPgJSFx0sBgq1QzRSBLZ/PvFJrNtaaWNkd4MxBHUHpf/FBxYBHEn
         tvO6HWb7/j3VZ2LClPg+V9COXkNFTcAi0L3LHy96UTepRVVwmc+NpZuuEIRdbqNbPdTF
         rSgGpzGBj0vrOz9t85G5yvbSfrPMejBFPNCX3i34fArLuTe8xDissBOe4KZm/0he5yB4
         y44Dvn/DvwnXa5zEKJgnNjqMf+50N4Zj+pQIVq3klkWlzE+pO/ZyNQO2hXSeVoww78s4
         FjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4zxOHr5pL/tZbv/Lney9NNoy+V8TXoApZzVW+UpE9c=;
        b=bK19EHPmCjf2N/igPkkkYoy+NTeabaMIReUQMTT7d9BrDq+VFsWMXqpYTFKvUUwr9D
         W39/++NptVFhX+CPCoM5/vLVZbq/8T6UY7MyOugZmBaYY7aPlSI5CGfTAMonOsPfIQGn
         XeUr+hLY98MXwX+BZj/6i0VowGyc91pc9n6m0ebLWuozR28vaXd7SbfIMnvB00abPaz/
         rLHU54XEW91Bzs4LG+zUCHLVnw9MC9XMkCowxrRtyc1goVdJtst8+oi5BxJBx0N7zAUP
         fGpCE52HCxP0Jkf1MNtVtTbHVs/S9L+1lJcKw8Nb/1RizartYiMTf3My5j5lJXGKNJbA
         /Aqg==
X-Gm-Message-State: ACrzQf0cLjlEqdxEfdNZEcKXNZ+GwTvUUzz4rAJ8orD9FO8C5Ln+5Ek+
        kjHSonueDiClX9spZlG1vLU=
X-Google-Smtp-Source: AMsMyM7jk2gdeNDOiu2o8p6WCnnUCNOLAYix7ph4jJIVEGB/+VOj7vRGrGyD1yt/IGRHpLJ+hzO0FA==
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id l18-20020a056870205200b0013207b22fe6mr4473033oad.98.1666843464841;
        Wed, 26 Oct 2022 21:04:24 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r5-20020aca5d05000000b0035956747d07sm44594oib.17.2022.10.26.21.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 21:04:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9330bab0-1fbf-95a7-8d97-af522762f470@roeck-us.net>
Date:   Wed, 26 Oct 2022 21:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] ALSA: Use del_timer_sync() before freeing timer
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20221026231236.6834b551@gandalf.local.home>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221026231236.6834b551@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 20:12, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The current code for freeing the emux timer is extremely dangerous:
> 
>    CPU0				CPU1
>    ----				----
> snd_emux_timer_callback()
> 			    snd_emux_free()
> 			      spin_lock(&emu->voice_lock)
> 			      del_timer(&emu->tlist); <-- returns immediately
> 			      spin_unlock(&emu->voice_lock);
> 			      [..]
> 			      kfree(emu);
> 
>    spin_lock(&emu->voice_lock);
> 
>   [BOOM!]
> 
> Instead just use del_timer_sync() which will wait for the timer to finish
> before continuing. No need to check if the timer is active or not when
> doing so.
> 
> This doesn't fix the race of a possible re-arming of the timer, but at
> least it won't use the data that has just been freed.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   sound/synth/emux/emux.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/sound/synth/emux/emux.c b/sound/synth/emux/emux.c
> index 5ed8e36d2e04..a2ee78809cfb 100644
> --- a/sound/synth/emux/emux.c
> +++ b/sound/synth/emux/emux.c
> @@ -131,10 +131,7 @@ int snd_emux_free(struct snd_emux *emu)
>   	if (! emu)
>   		return -EINVAL;
>   
> -	spin_lock_irqsave(&emu->voice_lock, flags);
> -	if (emu->timer_active)
> -		del_timer(&emu->tlist);
> -	spin_unlock_irqrestore(&emu->voice_lock, flags);
> +	del_timer_sync(&emu->tlist);
>   
>   	snd_emux_proc_free(emu);
>   	snd_emux_delete_virmidi(emu);

