Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640656225E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiKIIxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiKIIxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:53:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BDCA1A6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:53:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z14so24684670wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DHcT+Y2+Evz3/8OMKTYcOlVO9N2ompFadCy9jc0xdc=;
        b=C1ayd+PfAXcBibE0GRYzIWMnweoIvV4AeXXNReB9Slc5N5Xfctpkdp90jTkFDuEjdb
         PxoSdZEbj3HcRPTZDnG+hfMJD8XpTS1wV5qRqp3taNSZ4zLzGbOlbXlXBNqSqAMCzrVG
         Th4SFnZ9F4Kk6H8RgjP7Lqy43B2DrNijSWfQYp4STSspdDi4UZN0AVzmVtYocSaxG0R4
         VLxw1+8td7zhBnhSxKJrW34HvrHrpdqywpyCORWKBsBI7ixbsGWrD5VJmFAF5rL5OzXM
         m6SLKgr+Zbt+JfI9/4VQD51YgFYXIXlWbP23WiYRvW7B9/1qYJGeYZDnt0uYqK7FrIc5
         W/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DHcT+Y2+Evz3/8OMKTYcOlVO9N2ompFadCy9jc0xdc=;
        b=R6iZNDy/YCB3AqU8XjWeRFUom8DX/wA3O3AFO7Y701oq6N/BUkLcND5RccCjVPNY6Q
         3LcACMvRVZ4+oDtOfzKPqnsZImU/Qu4fDdg+nf9dF958toK6jj5kCrAe6av5RGfhUgsZ
         uZK/vk03fH+I6jirQ/AsTGFHfJ8L3b2EqYxUgCVmCxtECgcadMkuy4pgzky06U4IBCxa
         46LKx23zCHbGP/YvImewrpMvTeW6Q+ks9kfkK+7IKnvClKG5WiXGOEtacPrqW8FOJv9C
         OQ0JV9apWVWDtKKOuU3uMpubEas+2dJAs/1ByWSQp1c3YdxQCCB4JKPQXczaWu6SNAxl
         VjKQ==
X-Gm-Message-State: ACrzQf0aB8pyVDCtWKAB6b91anBIbK8eLJne4zpV3/H77r/hFm1oxOhL
        e9kpf5Q44IbajzPbdpo8/6XB8A==
X-Google-Smtp-Source: AMsMyM5w8NGS+4HLk/Hvm9+leAF0TAcvPzz63+wBmJDLaVT9nbGoxmGT+y0AiJRrHiCXNGi5PIk3+Q==
X-Received: by 2002:a5d:544b:0:b0:236:68dc:8f54 with SMTP id w11-20020a5d544b000000b0023668dc8f54mr35791522wrv.504.1667984007881;
        Wed, 09 Nov 2022 00:53:27 -0800 (PST)
Received: from ash.lan ([167.98.0.196])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d6409000000b00228d67db06esm12541214wru.21.2022.11.09.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:53:27 -0800 (PST)
Date:   Wed, 9 Nov 2022 08:53:25 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v3 15/40] kdb: use srcu console list iterator
Message-ID: <20221109085325.wiub564iqnewvczb@ash.lan>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-16-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-16-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:22:13PM +0106, John Ogness wrote:
> Guarantee safe iteration of the console list by using SRCU.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/debug/kdb/kdb_io.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 550fe8b456ec..ed8289ce4fcb 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -545,6 +545,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  {
>  	struct console *c;
>  	const char *cp;
> +	int cookie;
>  	int len;
>
>  	if (msg_len == 0)
> @@ -558,7 +559,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		cp++;
>  	}
>
> -	for_each_console(c) {
> +	/*
> +	 * The console_srcu_read_lock() only provides safe console list
> +	 * traversal. The use of the ->write() callback relies on all other
> +	 * CPUs being stopped at the moment and console drivers being able to
> +	 * handle reentrance when @oops_in_progress is set. (Note that there
> +	 * is no guarantee for either criteria.)
> +	 */

The debugger entry protocol does ensure that other CPUs are either
stopped or unresponsive. In the case where the other CPU is unresponsive
(e.g. timed out after being asked to stop) then there is a "real" printk()
issued prior to any of the above interference with the console system to
the developer driving the debugger gets as much clue as we can offer them
about what is going on (typically this is emitted from regular interrupt
context).

Given this comment is part of the debugger code then for the
oops_in_progress hack it might be more helpful to describe what
the developer in front the debugger needs to do to have the most
reliable debug session possible.

  There is no guarantee that every console drivers can handle reentrance
  in this way; the developer deploying the debugger is responsible for
  ensuring that the console drivers they have selected handle reentrance
  appropriately.


Daniel.


> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(c) {
>  		if (!console_is_enabled(c))
>  			continue;
>  		if (c == dbg_io_ops->cons)
> @@ -577,6 +586,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  		--oops_in_progress;
>  		touch_nmi_watchdog();
>  	}
> +	console_srcu_read_unlock(cookie);
>  }
>
>  int vkdb_printf(enum kdb_msgsrc src, const char *fmt, va_list ap)
> --
> 2.30.2
>
