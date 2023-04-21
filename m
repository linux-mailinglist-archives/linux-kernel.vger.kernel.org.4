Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE60C6EB29A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjDUT6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjDUT55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:57:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC62704
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:57:55 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b52ad6311so3193083b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682107075; x=1684699075;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx18nHSJIT6YTejaoMDMaghVJiSPK38ed5EvUiUooPk=;
        b=eYOCc3rWyLZfWAACadaSK+RREmAGeExFcR9MvLGVP4lL6+9vVdgxtUW8eJrfbY8bix
         gVJz1Ge/Wac5WY2cpeza7o/0aY72Wv6RjLKN7MeODAKQo5Rb2vVef9P2me0QAy06SkNF
         jeA9mKnEDG6piX0pobuRWKHhNtsXFQTwTwyDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107075; x=1684699075;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cx18nHSJIT6YTejaoMDMaghVJiSPK38ed5EvUiUooPk=;
        b=Ui63zyKgmTB/4Ya5bkmn7DJb7Zc0qf2/UX1v5ctWKn6p7taHNYhJUe5a2KVp5uVEqK
         hYnjo2AvFm0dNgoH+MaVSXe5VtSLCD463VT8JO/kssiRqhwHvTzWguylRJSorHWQl9V8
         Y2j/nvBuFY1OGm8eZAU73vhGHTYCMC1Dm6vGQ13gQdUhIwrjAAfqLXMrwJz8NzmGk/5/
         dB1Qsk59cEHD7QChS49W1XCsrt/UCfTXKBdkk/qnOGbhwm4J7+MULkV97ZSYbt7wlyKz
         Fcnkr9DqNmqJemS1DShgS4JcCgaV9Xqb0dDX3WYcjtSfcTyuWCcDWEkd0MYzg2s40ajv
         PPmQ==
X-Gm-Message-State: AAQBX9cj1KbsezjfW0K1oyo8xlSUslzZzWIgBwHtJJTk4wB5E3W+2g7U
        dJ+/ihQ0516yLtCSww8x28Vj+A==
X-Google-Smtp-Source: AKy350b/naghdBkf07KBVl4rNdfdthHeasp8tMv1YQdXo2X1mkY4cdMVd7IfC/y5itKNe/nwUI5AOQ==
X-Received: by 2002:a05:6a21:8dc5:b0:f0:e3ed:469a with SMTP id ti5-20020a056a218dc500b000f0e3ed469amr5487714pzb.55.1682107074920;
        Fri, 21 Apr 2023 12:57:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i3-20020a63d443000000b0051b5d0fe708sm2924550pgj.43.2023.04.21.12.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:57:54 -0700 (PDT)
Message-ID: <6442eac2.630a0220.2cd08.62cb@mx.google.com>
X-Google-Original-Message-ID: <202304211256.@keescook>
Date:   Fri, 21 Apr 2023 12:57:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, selinux@vger.kernel.org
Subject: Re: [PATCH v9 10/11] SELinux: Add selfattr hooks
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-11-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421174259.2458-11-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:58AM -0700, Casey Schaufler wrote:
> Add hooks for setselfattr and getselfattr. These hooks are not very
> different from their setprocattr and getprocattr equivalents, and
> much of the code is shared.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c | 153 +++++++++++++++++++++++++++++++--------
>  1 file changed, 123 insertions(+), 30 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 9403aee75981..9bc6206fb1ef 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6348,8 +6348,8 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
>  		inode_doinit_with_dentry(inode, dentry);
>  }
>  
> -static int selinux_getprocattr(struct task_struct *p,
> -			       const char *name, char **value)
> +static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
> +			       char **value)
>  {
>  	const struct task_security_struct *__tsec;
>  	u32 sid;
> @@ -6367,20 +6367,27 @@ static int selinux_getprocattr(struct task_struct *p,
>  			goto bad;
>  	}
>  
> -	if (!strcmp(name, "current"))
> +	switch (attr) {
> +	case LSM_ATTR_CURRENT:
>  		sid = __tsec->sid;
> -	else if (!strcmp(name, "prev"))
> +		break;
> +	case LSM_ATTR_PREV:
>  		sid = __tsec->osid;
> -	else if (!strcmp(name, "exec"))
> +		break;
> +	case LSM_ATTR_EXEC:
>  		sid = __tsec->exec_sid;
> -	else if (!strcmp(name, "fscreate"))
> +		break;
> +	case LSM_ATTR_FSCREATE:
>  		sid = __tsec->create_sid;
> -	else if (!strcmp(name, "keycreate"))
> +		break;
> +	case LSM_ATTR_KEYCREATE:
>  		sid = __tsec->keycreate_sid;
> -	else if (!strcmp(name, "sockcreate"))
> +		break;
> +	case LSM_ATTR_SOCKCREATE:
>  		sid = __tsec->sockcreate_sid;
> -	else {
> -		error = -EINVAL;
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
>  		goto bad;
>  	}
>  	rcu_read_unlock();
> @@ -6398,7 +6405,7 @@ static int selinux_getprocattr(struct task_struct *p,
>  	return error;
>  }
>  
> -static int selinux_setprocattr(const char *name, void *value, size_t size)
> +static int selinux_lsm_setattr(u64 attr, void *value, size_t size)
>  {
>  	struct task_security_struct *tsec;
>  	struct cred *new;
> @@ -6409,28 +6416,36 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	/*
>  	 * Basic control over ability to set these attributes at all.
>  	 */
> -	if (!strcmp(name, "exec"))
> +	switch (attr) {
> +	case LSM_ATTR_CURRENT:
> +		error = avc_has_perm(&selinux_state,
> +				     mysid, mysid, SECCLASS_PROCESS,
> +				     PROCESS__SETCURRENT, NULL);
> +		break;
> +	case LSM_ATTR_EXEC:
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETEXEC, NULL);
> -	else if (!strcmp(name, "fscreate"))
> +		break;
> +	case LSM_ATTR_FSCREATE:
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETFSCREATE, NULL);
> -	else if (!strcmp(name, "keycreate"))
> +		break;
> +	case LSM_ATTR_KEYCREATE:
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETKEYCREATE, NULL);
> -	else if (!strcmp(name, "sockcreate"))
> +		break;
> +	case LSM_ATTR_SOCKCREATE:
>  		error = avc_has_perm(&selinux_state,
>  				     mysid, mysid, SECCLASS_PROCESS,
>  				     PROCESS__SETSOCKCREATE, NULL);
> -	else if (!strcmp(name, "current"))
> -		error = avc_has_perm(&selinux_state,
> -				     mysid, mysid, SECCLASS_PROCESS,
> -				     PROCESS__SETCURRENT, NULL);
> -	else
> -		error = -EINVAL;
> +		break;
> +	default:
> +		error = -EOPNOTSUPP;
> +		break;
> +	}
>  	if (error)
>  		return error;
>  
> @@ -6442,13 +6457,14 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  		}
>  		error = security_context_to_sid(&selinux_state, value, size,
>  						&sid, GFP_KERNEL);
> -		if (error == -EINVAL && !strcmp(name, "fscreate")) {
> +		if (error == -EINVAL && attr == LSM_ATTR_FSCREATE) {
>  			if (!has_cap_mac_admin(true)) {
>  				struct audit_buffer *ab;
>  				size_t audit_size;
>  
> -				/* We strip a nul only if it is at the end, otherwise the
> -				 * context contains a nul and we should audit that */
> +				/* We strip a nul only if it is at the end,
> +				 * otherwise the context contains a nul and
> +				 * we should audit that */
>  				if (str[size - 1] == '\0')
>  					audit_size = size - 1;
>  				else
> @@ -6459,7 +6475,8 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  				if (!ab)
>  					return error;
>  				audit_log_format(ab, "op=fscreate invalid_context=");
> -				audit_log_n_untrustedstring(ab, value, audit_size);
> +				audit_log_n_untrustedstring(ab, value,
> +							    audit_size);
>  				audit_log_end(ab);
>  
>  				return error;
> @@ -6483,11 +6500,11 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	   checks and may_create for the file creation checks. The
>  	   operation will then fail if the context is not permitted. */
>  	tsec = selinux_cred(new);
> -	if (!strcmp(name, "exec")) {
> +	if (attr == LSM_ATTR_EXEC) {
>  		tsec->exec_sid = sid;
> -	} else if (!strcmp(name, "fscreate")) {
> +	} else if (attr == LSM_ATTR_FSCREATE) {
>  		tsec->create_sid = sid;
> -	} else if (!strcmp(name, "keycreate")) {
> +	} else if (attr == LSM_ATTR_KEYCREATE) {
>  		if (sid) {
>  			error = avc_has_perm(&selinux_state, mysid, sid,
>  					     SECCLASS_KEY, KEY__CREATE, NULL);
> @@ -6495,9 +6512,9 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  				goto abort_change;
>  		}
>  		tsec->keycreate_sid = sid;
> -	} else if (!strcmp(name, "sockcreate")) {
> +	} else if (attr == LSM_ATTR_SOCKCREATE) {
>  		tsec->sockcreate_sid = sid;
> -	} else if (!strcmp(name, "current")) {
> +	} else if (attr == LSM_ATTR_CURRENT) {
>  		error = -EINVAL;
>  		if (sid == 0)
>  			goto abort_change;
> @@ -6542,6 +6559,80 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
>  	return error;
>  }
>  
> +static int selinux_getselfattr(unsigned int __user attr,
> +			       struct lsm_ctx __user *ctx, size_t *size,
> +			       u32 __user flags)
> +{
> +	char *value;
> +	size_t total_len;
> +	int len;
> +	int rc = 1;
> +
> +	len = selinux_lsm_getattr(attr, current, &value);
> +	if (len < 0)
> +		return len;
> +
> +	total_len = ALIGN(len + sizeof(*ctx), 8);

struct_size(ctx, ctx, len)

> +
> +	if (total_len > *size)
> +		rc = -E2BIG;
> +	else
> +		lsm_fill_user_ctx(ctx, value, len, LSM_ID_SELINUX, 0);
> +
> +	*size = total_len;
> +	return rc;
> +}
> +
> +static int selinux_setselfattr(unsigned int __user attr,
> +			       struct lsm_ctx __user *ctx, size_t __user size,
> +			       u32 __user flags)
> +{
> +	struct lsm_ctx *lctx;
> +	void *context;
> +	int rc;
> +
> +	context = kmalloc(size, GFP_KERNEL);
> +	if (context == NULL)
> +		return -ENOMEM;
> +
> +	lctx = (struct lsm_ctx *)context;
> +	if (copy_from_user(context, ctx, size))
> +		rc = -EFAULT;
> +	else if (lctx->ctx_len > size)
> +		rc = -EINVAL;
> +	else
> +		rc = selinux_lsm_setattr(attr, lctx + 1, lctx->ctx_len);

Same nits as before:
	- "context" isn't needed
	- lctx + 1 doesn't exist: lctx->ctx does
	- "u32 __user" isn't a sane type

> +
> +	kfree(context);
> +	if (rc > 0)
> +		return 0;
> +	return rc;
> +}
> +
> +static int selinux_getprocattr(struct task_struct *p,
> +			       const char *name, char **value)
> +{
> +	unsigned int attr = lsm_name_to_attr(name);
> +	int rc;
> +
> +	if (attr) {
> +		rc = selinux_lsm_getattr(attr, p, value);
> +		if (rc != -EOPNOTSUPP)
> +			return rc;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int selinux_setprocattr(const char *name, void *value, size_t size)
> +{
> +	int attr = lsm_name_to_attr(name);
> +
> +	if (attr)
> +		return selinux_lsm_setattr(attr, value, size);
> +	return -EINVAL;
> +}
> +
>  static int selinux_ismaclabel(const char *name)
>  {
>  	return (strcmp(name, XATTR_SELINUX_SUFFIX) == 0);
> @@ -7183,6 +7274,8 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>  
>  	LSM_HOOK_INIT(d_instantiate, selinux_d_instantiate),
>  
> +	LSM_HOOK_INIT(getselfattr, selinux_getselfattr),
> +	LSM_HOOK_INIT(setselfattr, selinux_setselfattr),
>  	LSM_HOOK_INIT(getprocattr, selinux_getprocattr),
>  	LSM_HOOK_INIT(setprocattr, selinux_setprocattr),
>  
> -- 
> 2.39.2
> 

-- 
Kees Cook
