Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A006A9A78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCCPSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjCCPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:18:25 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E5213D60
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 07:18:00 -0800 (PST)
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C54A43F22C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677856675;
        bh=NoY182W3N/YgLN3GY7Mhnayi2HZrUWXw9KonFzXNONs=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=Rcrc0D7bF9hkTK/6C6dLaCKZevlGWuz9LaxZL/JJo+6CwFr2wPlHmdsKlNtx1mue3
         SBUkljXfghQZ2rekaJPsrKXBTzOcwZEvvcVReQz132fW+o1Elaf1NnkAWqq/Hhk5+t
         kQrw1okJznF3oDT5IcxX01KoF8I4Mua1MvQneKzgp8zQ9J//r+3r1z/lIIv626I98N
         V5Lgp2PWNdxxWVCEy6IR3oTh9YdB6D1bfOxhuVZmw3Jb2AIMscAmvdNrVXmPyKJ436
         9mBsE9ZSWONEtH8YGcqV+tGe1yzBs82yb14SydTcVF1i8PdOmukr5Zwcvg9xgRMChO
         epU+jmCmUC2tA==
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-172b1468431so1650766fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 07:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856674;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NoY182W3N/YgLN3GY7Mhnayi2HZrUWXw9KonFzXNONs=;
        b=xGl9WOsw7f5TeTKKK6itFgJLHDLLBODCe6OAAzUOK4Br86uNIY6MB0I2tLmAI/kkyy
         2NvHe1YOIK5Icdv7FeWK+iVgl3QgEUMqc32xPxh69W/fNhqHi9FaKHzaUQSyP3zNFSWp
         RwVgrIwPwRB5tFSWFuKZwDuTlD6BgswpOjw9yzIgFRHI8qUldDLX5RYyJDvNA8/xCwAh
         89rGUoZKZkkzNULgqCpFD2XI/7M994bz7uKoTzkyeGkVQRXQHUBzqLb5imfLpRvw9Ifc
         fFR8DAisYEEydV/ubQ5Xjrb6cxmc0jYcBYChb8zw0d99Z1sEs0QRBZ1dITsvNSiEr46G
         a6uw==
X-Gm-Message-State: AO0yUKVnrR9h/RhUSedUE5QglfUctuGY0TSwXeIvevinop5nUcyHHxaK
        rZIFfZ+ICb1yirMaIDAupCvuB/Md9ueQ0MkIPNbauj0r+vTjvQkwTMemSt/m9wJzxsnqocW6mZ/
        fRKQFrw079OJLr4UiL5FnX80EGI3Um6yva/GT/ewqmg==
X-Received: by 2002:a05:6830:3141:b0:693:c3bb:863f with SMTP id c1-20020a056830314100b00693c3bb863fmr737156ots.36.1677856674744;
        Fri, 03 Mar 2023 07:17:54 -0800 (PST)
X-Google-Smtp-Source: AK7set/PKQ83eK9URlt2QCwkSOPgRVeT6tF04LtR0PS2UtGf9jWhQeI7XWeAL0pcz0dYcTO+HxSELg==
X-Received: by 2002:a05:6830:3141:b0:693:c3bb:863f with SMTP id c1-20020a056830314100b00693c3bb863fmr737133ots.36.1677856674422;
        Fri, 03 Mar 2023 07:17:54 -0800 (PST)
Received: from ?IPv6:2804:1b3:a7c3:d46d:73b6:f440:93a4:30? ([2804:1b3:a7c3:d46d:73b6:f440:93a4:30])
        by smtp.gmail.com with ESMTPSA id i12-20020a9d610c000000b0068664355604sm1170156otj.22.2023.03.03.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:17:54 -0800 (PST)
Message-ID: <00324ebf28f25ed18f81bb602d7f28fff2b4b7ec.camel@canonical.com>
Subject: Re: [PATCH v38 01/39] LSM: Identify modules by more than name
From:   Georgia Garcia <georgia.garcia@canonical.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Mar 2023 12:17:49 -0300
In-Reply-To: <20220927195421.14713-2-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
         <20220927195421.14713-2-casey@schaufler-ca.com>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, 2022-09-27 at 12:53 -0700, Casey Schaufler wrote:
> Create a struct lsm_id to contain identifying information
> about Linux Security Modules (LSMs). At inception this contains
> a single member, which is the name of the module. Change the
> security_add_hooks() interface to use this structure. Change
> the individual modules to maintain their own struct lsm_id and
> pass it to security_add_hooks().
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
> =C2=A0include/linux/lsm_hooks.h=C2=A0=C2=A0=C2=A0 | 11 +++++++++--
> =C2=A0security/apparmor/lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++=
++-
> =C2=A0security/bpf/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 11 ++++++++++-
> =C2=A0security/commoncap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++++-
> =C2=A0security/landlock/cred.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0security/landlock/fs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-
> =C2=A0security/landlock/ptrace.c=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0security/landlock/setup.c=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> =C2=A0security/landlock/setup.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> =C2=A0security/loadpin/loadpin.c=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> =C2=A0security/lockdown/lockdown.c |=C2=A0 6 +++++-
> =C2=A0security/safesetid/lsm.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> =C2=A0security/security.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 12 ++++++------
> =C2=A0security/selinux/hooks.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> =C2=A0security/smack/smack_lsm.c=C2=A0=C2=A0 |=C2=A0 6 +++++-
> =C2=A0security/tomoyo/tomoyo.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 ++++++-
> =C2=A0security/yama/yama_lsm.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++++-
> =C2=A017 files changed, 82 insertions(+), 21 deletions(-)
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 3aa6030302f5..23054881eb08 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1598,6 +1598,13 @@ struct security_hook_heads {
> =C2=A0	#undef LSM_HOOK
> =C2=A0} __randomize_layout;
> =C2=A0
> +/*
> + * Information that identifies a security module.
> + */
> +struct lsm_id {
> +	const char	*lsm;		/* Name of the LSM */
> +};
> +
> =C2=A0/*
> =C2=A0 * Security module hook list structure.
> =C2=A0 * For use with generic list macros for common operations.
> @@ -1606,7 +1613,7 @@ struct security_hook_list {
> =C2=A0	struct hlist_node		list;
> =C2=A0	struct hlist_head		*head;
> =C2=A0	union security_list_options	hook;
> -	const char			*lsm;
> +	struct lsm_id			*lsmid;
> =C2=A0} __randomize_layout;
> =C2=A0
> =C2=A0/*
> @@ -1641,7 +1648,7 @@ extern struct security_hook_heads security_hook_hea=
ds;
> =C2=A0extern char *lsm_names;
> =C2=A0
> =C2=A0extern void security_add_hooks(struct security_hook_list *hooks, in=
t count,
> -				const char *lsm);
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct lsm_id *lsmid);
> =C2=A0
> =C2=A0#define LSM_FLAG_LEGACY_MAJOR	BIT(0)
> =C2=A0#define LSM_FLAG_EXCLUSIVE	BIT(1)
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index e29cade7b662..b71f7d4159d7 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1202,6 +1202,10 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro=
_after_init =3D {
> =C2=A0	.lbs_task =3D sizeof(struct aa_task_ctx),
> =C2=A0};
> =C2=A0
> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init =3D {
> +	.lsm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "apparmor",
> +};
> +
> =C2=A0static struct security_hook_list apparmor_hooks[] __lsm_ro_after_in=
it =3D {
> =C2=A0	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
> =C2=A0	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
> @@ -1897,7 +1901,7 @@ static int __init apparmor_init(void)
> =C2=A0		goto buffers_out;
> =C2=A0	}
> =C2=A0	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
> -				"apparmor");
> +				&apparmor_lsmid);
> =C2=A0
> =C2=A0	/* Report that AppArmor successfully initialized */
> =C2=A0	apparmor_initialized =3D 1;
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e5971fa74fd7..e50de3abfde2 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -15,9 +15,18 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm=
_ro_after_init =3D {
> =C2=A0	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
> =C2=A0};
> =C2=A0
> +/*
> + * slot has to be LSMBLOB_NEEDED because some of the hooks
> + * supplied by this module require a slot.
> + */
> +struct lsm_id bpf_lsmid __lsm_ro_after_init =3D {
> +	.lsm=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "bpf",
> +};

Can bpf_lsmid be static too?

> +
> =C2=A0static int __init bpf_lsm_init(void)
> =C2=A0{
> -	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
> +			=C2=A0=C2=A0 &bpf_lsmid);
> =C2=A0	pr_info("LSM support for eBPF active\n");
> =C2=A0	return 0;
> =C2=A0}

Thanks
