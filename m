Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C3960571D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJTGFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJTGFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:05:14 -0400
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FECFF8F0;
        Wed, 19 Oct 2022 23:05:09 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id y14so44855268ejd.9;
        Wed, 19 Oct 2022 23:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kwjSEOpe7mHzthxwfuxysqsqwQDWl1d/LvKM1CZaM5E=;
        b=NPQPTNcPkgffEVvjvKo0lEWk4DgMOnAos6WnlJnqYEoEedHxgJZZXjMsLNbq+jWauv
         ptfwHLb/U4+lVYGCW0/Ip6OA/ve7JlAnTfvqJNz7hWJmPJDfystBwQ39fVwoZt8Mu4D4
         LBq79nO21U5gFt15THaqVU4PD5Zw3QPk2XgsOrphbA+9m01wP3g/nmrz6/GXAE/1w2jI
         IT6iak7VOrUrk9f1PnYESIHo9+eFUVWU24o8GuU6MIj9diu454Gj4XNvgD/4gohzXq63
         kb1MTUjCRUfAunUMjxpWLWituqwpeacg2x1xuibxmU17aAmVduW1xGgtSpDaMrGXnIjP
         9y5Q==
X-Gm-Message-State: ACrzQf0UsS7wRl7D41pqjZgoyltZSmhqo6X9YVGExYZsuScxcpqmfFhJ
        4OTwY8Lomim3bOKPmVZwTuU=
X-Google-Smtp-Source: AMsMyM6fBZH7SpXjJCw6/NgFHYk5wCZmfPXBL/j0ctZfLaLQpWxqyBOxcZxali/zTvw5wAKFeU7RYQ==
X-Received: by 2002:a17:907:7da5:b0:78e:2c3b:55a2 with SMTP id oz37-20020a1709077da500b0078e2c3b55a2mr9475916ejc.96.1666245907470;
        Wed, 19 Oct 2022 23:05:07 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b0045c76120e61sm11493268edy.54.2022.10.19.23.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:05:06 -0700 (PDT)
Message-ID: <0be4e5da-fca4-ffd2-e4d0-65f8e5c35acf@kernel.org>
Date:   Thu, 20 Oct 2022 08:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Simon Brand <simon.brand@postadigitale.de>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221015064222.gonna.435-kees@kernel.org>
 <20221015064517.1554119-2-keescook@chromium.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 2/2] tty: Allow TIOCSTI to be disabled
In-Reply-To: <20221015064517.1554119-2-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15. 10. 22, 8:45, Kees Cook wrote:
> TIOCSTI continues its long history of being used in privilege escalation
> attacks[1]. Prior attempts to provide a mechanism to disable this have
> devolved into discussions around creating full-blown LSMs to provide
> arbitrary ioctl filtering, which is hugely over-engineered -- only
> TIOCSTI is being used this way. 3 years ago OpenBSD entirely removed
> TIOCSTI[2], Android has had it filtered for longer[3], and the tools that
> had historically used TIOCSTI either do not need it, are not commonly
> built with it, or have had its use removed.
> 
> Provide a simple CONFIG and global sysctl to disable this for the system
> builders who have wanted this functionality for literally decades now,
> much like the ldisc_autoload CONFIG and sysctl.
> 
> [1] https://lore.kernel.org/linux-hardening/Y0m9l52AKmw6Yxi1@hostpad
> [2] https://undeadly.org/cgi?action=article;sid=20170701132619
> [3] https://lore.kernel.org/lkml/CAFJ0LnFGRuEEn1tCLhoki8ZyWrKfktbF+rwwN7WzyC_kBFoQVA@mail.gmail.com/
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Simon Brand <simon.brand@postadigitale.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>
...
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -2275,11 +2275,15 @@ static int tty_fasync(int fd, struct file *filp, int on)
>    *  * Called functions take tty_ldiscs_lock
>    *  * current->signal->tty check is safe without locks
>    */
> +static int tty_legacy_tiocsti __read_mostly = IS_BUILTIN(CONFIG_LEGACY_TIOCSTI);

This can be bool, right? And IS_ENABLED() sounds more appropriate here.

>   static int tiocsti(struct tty_struct *tty, char __user *p)
>   {
>   	char ch, mbz = 0;
>   	struct tty_ldisc *ld;
>   
> +	if (!tty_legacy_tiocsti)
> +		return -EIO;
> +
>   	if ((current->signal->tty != tty) && !capable(CAP_SYS_ADMIN))
>   		return -EPERM;
>   	if (get_user(ch, p))
> @@ -3582,6 +3586,15 @@ void console_sysfs_notify(void)
>   }
>   
>   static struct ctl_table tty_table[] = {
> +	{
> +		.procname	= "legacy_tiocsti",
> +		.data		= &tty_legacy_tiocsti,
> +		.maxlen		= sizeof(tty_legacy_tiocsti),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,

Then this becomes just proc_dobool without extras.

Or we can leave it as int, allow 0, 1, and 2. 2 would log_limited the 
caller's comm before EIO. Just thinking loudly. Maybe the EIO is enough 
for users to notice. Likely…

thanks,
-- 
js
suse labs

