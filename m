Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA45D5EC5F2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiI0OZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiI0OZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:25:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D98A44C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:25:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id iw17so9276576plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=s7UXhn1OHBpTnoRBs65qVQMoD7Wdw4hn+2v85nEMspc=;
        b=Bkcyjr+TNuaEo5pWk2xD8VgNUzHPg7FbLvcwSS+njnQHDsGE52HFocnL90rE0S9YsJ
         cdtznxKuHh/yntAuoxJ2P7IwQv7b2mFzIUrbJf30D7hja0L7HQXTPTeGise7KGVzTBRS
         17K5BcFp/u0UN6P0LxgJgw05AKmRdwUh3L4KE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=s7UXhn1OHBpTnoRBs65qVQMoD7Wdw4hn+2v85nEMspc=;
        b=qsuaYa7NOIj0cFU9xPLt4mJMbGgYBH+NVNzjkRe2n6Xy7o0W2Otif2U4cmlH3WuYeZ
         3K5+svDzJvCEfc2Ul0A4f5SotTCDKufo1ZOqqSI96VbqYL1pAhZ1W1ajTKmbGF7xSjgY
         KagHsnd0+KCe2XVDp3MxrTx3SlFdr8XDFQXbt7DTC3N/xuY4lC9/caYpjCtggPGwWtW5
         XtFi7G1dKyxbfcIhFc8AxxpLOhkwYI8b6wBAHyKj/mqXwGRcDnQILEutK2ykfpG+InVS
         jLOy7pytnbLOzWwNSA9uvZq9a8Nk5KXl+rr7eKNK1ark5gD56V9TnZ4HWukL4tCeczS4
         RESA==
X-Gm-Message-State: ACrzQf0Ftp2Dov4GyOoy3qpqYrNKZBfHpre12aJDhFpTuWwx5/LsqDk/
        8qqCmH+BfSjVrPmtBo7+BzkH8w==
X-Google-Smtp-Source: AMsMyM4jMadirtG6qASSncJf48j9q/X2DZHJUoeqlIEA3HvDFrcGQp5R5ibZRyZhqARUrn08ou+xwQ==
X-Received: by 2002:a17:902:f689:b0:179:fdac:c4e2 with SMTP id l9-20020a170902f68900b00179fdacc4e2mr519260plg.119.1664288728309;
        Tue, 27 Sep 2022 07:25:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902710100b00176dee43e0dsm1569735pll.285.2022.09.27.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 07:25:27 -0700 (PDT)
Date:   Tue, 27 Sep 2022 07:25:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] utsname: contribute changes to RNG
Message-ID: <202209270724.04D0A68@keescook>
References: <20220927094039.1563219-1-Jason@zx2c4.com>
 <20220927095354.1564465-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927095354.1564465-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 11:53:54AM +0200, Jason A. Donenfeld wrote:
> On some small machines with little entropy, a quasi-unique hostname is
> sometimes a relevant factor. I've seen, for example, 8 character
> alpha-numeric serial numbers. In addition, the time at which the hostname
> is set is usually a decent measurement of how long early boot took. So,
> call add_device_randomness() on new hostnames, which feeds its arguments
> to the RNG in addition to a fresh cycle counter.
> 
> Low cost hooks like this never hurt and can only ever help, and since
> this costs basically nothing for an operation that is never a fast path,
> this is an overall easy win.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  kernel/sys.c            | 2 ++
>  kernel/utsname_sysctl.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/sys.c b/kernel/sys.c
> index b911fa6d81ab..b4b40ccf0949 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -25,6 +25,7 @@
>  #include <linux/times.h>
>  #include <linux/posix-timers.h>
>  #include <linux/security.h>
> +#include <linux/random.h>
>  #include <linux/suspend.h>
>  #include <linux/tty.h>
>  #include <linux/signal.h>
> @@ -1366,6 +1367,7 @@ SYSCALL_DEFINE2(sethostname, char __user *, name, int, len)
>  	if (!copy_from_user(tmp, name, len)) {
>  		struct new_utsname *u;
>  
> +		add_device_randomness(tmp, len);
>  		down_write(&uts_sem);
>  		u = utsname();
>  		memcpy(u->nodename, tmp, len);
> diff --git a/kernel/utsname_sysctl.c b/kernel/utsname_sysctl.c
> index 4ca61d49885b..de16bcf14b03 100644
> --- a/kernel/utsname_sysctl.c
> +++ b/kernel/utsname_sysctl.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/uts.h>
>  #include <linux/utsname.h>
> +#include <linux/random.h>
>  #include <linux/sysctl.h>
>  #include <linux/wait.h>
>  #include <linux/rwsem.h>
> @@ -57,6 +58,7 @@ static int proc_do_uts_string(struct ctl_table *table, int write,
>  		 * theoretically be incorrect if there are two parallel writes
>  		 * at non-zero offsets to the same sysctl.
>  		 */
> +		add_device_randomness(tmp_data, sizeof(tmp_data));

Does this matter that we're dumping the same same trailing bytes into
the RNG? (i.e. only min(lenp, table->maxlen) has changed.)

If that's okay (and maybe a comment should be added):

Reviewed-by: Kees Cook <keescook@chromium.org>


>  		down_write(&uts_sem);
>  		memcpy(get_uts(table), tmp_data, sizeof(tmp_data));
>  		up_write(&uts_sem);
> -- 
> 2.37.3
> 

-- 
Kees Cook
