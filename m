Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5A64E1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 20:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiLOTRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 14:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLOTQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 14:16:39 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4279396E6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:16:38 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id d13so51537qvj.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 11:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE5AiYbjoXxjhp/dT4YTX1b07rKLInDn4mR5Q8j9/1E=;
        b=AR0s6ZMZCeRr1r6ByqFjtlB79qWCgAeqP35BblLNndDOjmfYJgbTTWqaLYcnnD86dh
         MqiTkP1LKCC62jCFlMorKlrr0nCmY1bb9K+wQi+a6QQS1GJZ6BiLMBMPZ2hv/GZV+13+
         745jRcBD4I043jxlH6sG1zn6kKP/veSy6SETg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE5AiYbjoXxjhp/dT4YTX1b07rKLInDn4mR5Q8j9/1E=;
        b=TBdEtiHOMrBHY4H7K6rCGpuTnIxha47KX+eqFqxywes931UQW89QpzEkvNXUxbUtja
         LO+dHhlS9VZCeX67ZGKE8kBjQ9i5+K4Hfsa+RqSkd5ps8Ybfn2oVtfq9Vp986larC2aM
         xVuIa2PEkQmGaCCNRvGfT1aiC1rpdnoctHVgG52EJdNMRNaWTLRbF1yGKodI4Avvx2kL
         3B00Nk0XiNROMWepZa1EtD42y52ZB+2rxBp//rLMQ2lN/6l4SRwapqGGUMqAvEj8sktA
         EllVxxnt0WDBoef8GHY99GuyiOsUrtj5M3rH+g+BcBf2UmaBCMxPz2UKMXyjj6yELDXV
         EtXQ==
X-Gm-Message-State: ANoB5pkcZ9fjdxnrZ2g1q/UJpvgzKsuXUK1jhKO+dNtWoOCemNFQnHhQ
        SQEzG6WReU5cWSJkMtzfYjTFGA==
X-Google-Smtp-Source: AA0mqf5HcSBSdogbFu720gosspg6P8uKchPqUxXt5Wa7rhZRk0WTOJY4gaQ40PiPwMq2wZRgtOv7FQ==
X-Received: by 2002:a05:6214:5018:b0:4c7:595c:993b with SMTP id jo24-20020a056214501800b004c7595c993bmr57562445qvb.40.1671131797715;
        Thu, 15 Dec 2022 11:16:37 -0800 (PST)
Received: from localhost (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id bp12-20020a05620a458c00b006fef61300fesm13055118qkb.16.2022.12.15.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 11:16:36 -0800 (PST)
Date:   Thu, 15 Dec 2022 19:16:36 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        kexec@lists.infradead.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ross Zwisler <zwisler@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kexec: Introduce paramters load_limit_reboot and
 load_limit_panic
Message-ID: <Y5tylKOaIO8Df8pu@google.com>
References: <20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org>
 <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v2-3-c498313c1bb5@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

On Thu, Dec 08, 2022 at 05:38:02PM +0100, Ricardo Ribalda wrote:
> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> The sysadmin can set different limits for kexec panic and kexec reboot
> kernels.
> 
> The value can be modified at runtime via sysfs, but only with a value
> smaller than the current one (except -1).
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 14 ++++
>  include/linux/kexec.h                           |  2 +-
>  kernel/kexec.c                                  |  2 +-
>  kernel/kexec_core.c                             | 91 ++++++++++++++++++++++++-
>  kernel/kexec_file.c                             |  2 +-
>  5 files changed, 106 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 42af9ca0127e..2b37d6a20747 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2374,6 +2374,20 @@
>  			for Movable pages.  "nn[KMGTPE]", "nn%", and "mirror"
>  			are exclusive, so you cannot specify multiple forms.
>  
> +	kexec_core.load_limit_reboot=
> +	kexec_core.load_limit_panic=
> +			[KNL]
> +			This parameter specifies a limit to the number of times
> +			a kexec kernel can be loaded.
> +			Format: <int>
> +			-1  = Unlimited.
> +			int = Number of times kexec can be called.
> +
> +			During runtime, this parameter can be modified with a
> +			value smaller than the current one (but not -1).
> +
> +			Default: -1
> +
>  	kgdbdbgp=	[KGDB,HW] kgdb over EHCI usb debug port.
>  			Format: <Controller#>[,poll interval]
>  			The controller # is the number of the ehci usb debug
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index e9e1ab5e8006..3d7d10f7187a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -407,7 +407,7 @@ extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
>  extern struct kimage *kexec_image;
>  extern struct kimage *kexec_crash_image;
>  
> -bool kexec_load_permited(void);
> +bool kexec_load_permited(bool crash_image);
>  
>  #ifndef kexec_flush_icache_page
>  #define kexec_flush_icache_page(page)
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index d83fc9093aff..2b0856e83fe1 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -193,7 +193,7 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	int result;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permited())
> +	if (!kexec_load_permited(flags & KEXEC_ON_CRASH))

nit: permitted.

>  		return -EPERM;
>  
>  	/* Permit LSMs and IMA to fail the kexec */
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 18bd90ca9c99..7f9d5288b24b 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -952,13 +952,100 @@ static int __init kexec_core_sysctl_init(void)
>  late_initcall(kexec_core_sysctl_init);
>  #endif
>  
> -bool kexec_load_permited(void)
> +struct kexec_load_limit {
> +	/* Mutex protects the limit count. */
> +	struct mutex mutex;
> +	int limit;

Can you not just use atomic ops for limit, and get rid of the mutex?

That will simplify the code as well.

> +};
> +
> +struct kexec_load_limit load_limit_reboot = {
> +	.mutex = __MUTEX_INITIALIZER(load_limit_reboot.mutex),
> +	.limit = -1,
> +};
> +
> +struct kexec_load_limit load_limit_panic = {
> +	.mutex = __MUTEX_INITIALIZER(load_limit_panic.mutex),
> +	.limit = -1,
> +};
> +
> +static int param_get_limit(char *buffer, const struct kernel_param *kp)
>  {
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;
> +
> +	mutex_lock(&limit->mutex);
> +	ret = scnprintf(buffer, PAGE_SIZE, "%i\n", limit->limit);
> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static int param_set_limit(const char *buffer, const struct kernel_param *kp)
> +{
> +	int ret;
> +	struct kexec_load_limit *limit = kp->arg;
> +	int new_val;
> +
> +	ret = kstrtoint(buffer, 0, &new_val);
> +	if (ret)
> +		return ret;
> +
> +	new_val = max(-1, new_val);
> +
> +	mutex_lock(&limit->mutex);
> +
> +	if (new_val == -1 && limit->limit != -1) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	if (limit->limit != -1 && new_val > limit->limit) {
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	limit->limit = new_val;
> +
> +done:
> +	mutex_unlock(&limit->mutex);
> +
> +	return ret;
> +}
> +
> +static const struct kernel_param_ops load_limit_ops = {
> +	.get = param_get_limit,
> +	.set = param_set_limit,
> +};
> +
> +module_param_cb(load_limit_reboot, &load_limit_ops, &load_limit_reboot, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec reboot kernel");
> +
> +module_param_cb(load_limit_panic, &load_limit_ops, &load_limit_panic, 0644);
> +MODULE_PARM_DESC(load_limit_reboot, "Maximum attempts to load a kexec panic kernel");
> +
> +bool kexec_load_permited(bool crash_image)

nit: permitted.

> +{
> +	struct kexec_load_limit *limit;
> +
>  	/*
>  	 * Only the superuser can use the kexec syscall and if it has not
>  	 * been disabled.
>  	 */
> -	return capable(CAP_SYS_BOOT) && !kexec_load_disabled;
> +	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
> +		return false;
> +
> +	/* Check limit counter and decrease it.*/
> +	limit = crash_image ? &load_limit_panic : &load_limit_reboot;
> +	mutex_lock(&limit->mutex);
> +	if (!limit->limit) {
> +		mutex_unlock(&limit->mutex);
> +		return false;
> +	}
> +	if (limit->limit != -1)
> +		limit->limit--;
> +	mutex_unlock(&limit->mutex);
> +
> +	return true;

IMO, patch 2/3 can be squashed with 3/3 but no strong preference.

thanks,

 - Joel



>  }
>  
>  /*
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 701147c118d4..61212a9252a6 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -330,7 +330,7 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	struct kimage **dest_image, *image;
>  
>  	/* We only trust the superuser with rebooting the system. */
> -	if (!kexec_load_permited())
> +	if (!kexec_load_permited(flags & KEXEC_FILE_FLAGS))
>  		return -EPERM;
>  
>  	/* Make sure we have a legal set of flags */
> 
> -- 
> 2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
