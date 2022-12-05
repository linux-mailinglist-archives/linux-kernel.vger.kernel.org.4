Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64806427C4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLELoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiLELoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:44:01 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B440FB7CB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 03:44:00 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id s7so10533691plk.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 03:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=y5IIAaK5GHpJZ5+16Lx4zcAJ1Wy5UCihf6KWPQXtanQ=;
        b=JtdZf54xBzD3314emrXQNCLSqGuo0iRVwzKHGdQqkvkj6x8/QczJrMkyZSzPSt5yEV
         1aQsG5IyzGUnat5KpBwmolzw3iMT7SKrUMJo8H5jKpXVuYbGrW0/i5o/BZo6AX29J5Mu
         E4IEaeCFVqLG9+uJgfuiez/gIBvbU2iBtszMvuuJdx9OPY7DXb1M71/ioq5jyYh0lqv3
         7xLxqq3hq2uBl2QzLh+Awk4YkD2XAfipBmp85iLyw79r+SHahRgYD6Ih+PTIYq2cJPil
         e5zYOOcsO/5/wpMcc4jpwWP6hvUX/k6oLKOMMsnG0XNY+XoEuszBo/+AHIZxpwx2qtQ9
         /9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5IIAaK5GHpJZ5+16Lx4zcAJ1Wy5UCihf6KWPQXtanQ=;
        b=4v4r+WE9DCLbJUVbHK3Dhqlk6pUUpvCkhhv82TV8RGeuivNriciwQBpbNAazNTnmBi
         wLhREDcnNlUK4+L8sKQzmmgjZrCNsSQmVjXnv4VXH7btm8eKyvPfNR8iOWK9zYHmT0AA
         ip1KEqQwMubIbBqM3Hl1ub9BnIFPgYPrRakAZogQtfHlHzC8WupDd7Zp7uMs2Vr1d7Ul
         J6boy/M89DPcwgxjlEU2liGHnpvhVwTT1V28c/EgOsVoRCMIXK4Bs4k6lHUi5PHd/23x
         RtbedIYwtsofXHcW+VTgOzekymsUTrvboWoh9HZFpWFt0C+wDBt5sGcd2GiQibgWZgjq
         3FKA==
X-Gm-Message-State: ANoB5pmNsOzgLkAUCEuyuakJB9/mkR2Ygs23sNNSmfxLfhp7dcV26J+Z
        O832nkY6AtjjQMj4A9U12vs=
X-Google-Smtp-Source: AA0mqf43Zkg6yA4JdTvwEwMbx80qL3N6dFYGvsziwkd0xKHeADcqdJiU0WpRB3fJdKxMxpQBjSonQg==
X-Received: by 2002:a17:90b:2d82:b0:219:c8d5:27d7 with SMTP id sj2-20020a17090b2d8200b00219c8d527d7mr6343913pjb.141.1670240640152;
        Mon, 05 Dec 2022 03:44:00 -0800 (PST)
Received: from MBP ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id a24-20020aa795b8000000b00575d06e53edsm8521233pfk.149.2022.12.05.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:43:57 -0800 (PST)
References: <20221115140233.21981-1-schspa@gmail.com>
User-agent: mu4e 1.8.10; emacs 28.2
From:   Schspa Shi <schspa@gmail.com>
To:     mcgrof@kernel.org
Cc:     linux-kernel@vger.kernel.org, Schspa Shi <schspa@gmail.com>,
        syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com,
        syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com,
        syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
Subject: Re: [PATCH] umh: fix UAF when the process is being killed
Date:   Mon, 05 Dec 2022 19:38:21 +0800
In-reply-to: <20221115140233.21981-1-schspa@gmail.com>
Message-ID: <m2zgc2vzwx.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Schspa Shi <schspa@gmail.com> writes:

> When the process is killed, wait_for_completion_state will return with
> -ERESTARTSYS, and the completion variable in the stack will be freed.
> If the user-mode thread is complete at the same time, there will be a UAF.
>
> Please refer to the following scenarios.
>             T1                                  T2
> ------------------------------------------------------------------
> call_usermodehelper_exec
>                                    call_usermodehelper_exec_async
>                                    << do something >>
>                                    umh_complete(sub_info);
>                                    comp = xchg(&sub_info->complete, NULL);
>                                    /* we got the completion */
>                                    << context switch >>
>
>     << Being killed >>
> 	retval = wait_for_completion_state(sub_info->complete, state);
> 	if (!retval)
> 		goto wait_done;
>
> 	if (wait & UMH_KILLABLE) {
> 		/* umh_complete() will see NULL and free sub_info */
> 		if (xchg(&sub_info->complete, NULL))
> 			goto unlock;
>         << we can't got the completion >>
> 	}
> 	....
> unlock:
> 	helper_unlock();
> 	return retval;
> }
>
> /**
>  * the completion variable in stack is end of life cycle.
>  * and maybe freed due to process is recycled.
>  */
>                                    --------UAF here----------
>                                    if (comp)
>                                        complete(comp);
>
> To fix it, we can put the completion variable in the subprocess_info
> variable.
>
> Reported-by: syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com
> Reported-by: syzbot+70d5d5d83d03db2c813d@syzkaller.appspotmail.com
> Reported-by: syzbot+83cb0411d0fcf0a30fc1@syzkaller.appspotmail.com
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  include/linux/umh.h | 1 +
>  kernel/umh.c        | 6 +++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/umh.h b/include/linux/umh.h
> index 5d1f6129b847..801f7efbc825 100644
> --- a/include/linux/umh.h
> +++ b/include/linux/umh.h
> @@ -20,6 +20,7 @@ struct file;
>  struct subprocess_info {
>  	struct work_struct work;
>  	struct completion *complete;
> +	struct completion done;
>  	const char *path;
>  	char **argv;
>  	char **envp;
> diff --git a/kernel/umh.c b/kernel/umh.c
> index 850631518665..3ed39956c777 100644
> --- a/kernel/umh.c
> +++ b/kernel/umh.c
> @@ -380,6 +380,7 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
>  	sub_info->cleanup = cleanup;
>  	sub_info->init = init;
>  	sub_info->data = data;
> +	init_completion(&sub_info->done);
>    out:
>  	return sub_info;
>  }
> @@ -405,7 +406,6 @@ EXPORT_SYMBOL(call_usermodehelper_setup);
>  int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  {
>  	unsigned int state = TASK_UNINTERRUPTIBLE;
> -	DECLARE_COMPLETION_ONSTACK(done);
>  	int retval = 0;
>  
>  	if (!sub_info->path) {
> @@ -431,7 +431,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  	 * This makes it possible to use umh_complete to free
>  	 * the data structure in case of UMH_NO_WAIT.
>  	 */
> -	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &done;
> +	sub_info->complete = (wait == UMH_NO_WAIT) ? NULL : &sub_info->done;
>  	sub_info->wait = wait;
>  
>  	queue_work(system_unbound_wq, &sub_info->work);
> @@ -444,7 +444,7 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
>  	if (wait & UMH_FREEZABLE)
>  		state |= TASK_FREEZABLE;
>  
> -	retval = wait_for_completion_state(&done, state);
> +	retval = wait_for_completion_state(sub_info->complete, state);
>  	if (!retval)
>  		goto wait_done;

Hi Luis Chamberlain:

Could you help to review this patch? I'm not sure why we define the
amount of completion here on the stack. But this UAF can be fixed by
moving the completion variable to the heap.

-- 
BRs
Schspa Shi
