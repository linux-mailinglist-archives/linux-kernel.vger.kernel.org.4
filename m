Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B36A9CF5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjCCRPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjCCRPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:15:03 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE540C640
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:15:01 -0800 (PST)
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E751D4168E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 17:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677863699;
        bh=DgYuLHBDbdAWqdmpPBV0ZgLbsqK4fpD+XI7eYMml57w=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=SPmUGVNOFwiQdeEAbDg5WQZzJ4jWiEqzx4JpuIuLMVcwHarnEokPoX802Cv3WNmDQ
         SeddEg/Z8OdaQV6FSoqWbfEuwBd6Rr7Yj01Aov227vhZMAwfaCUxLms9ZSTchQ/Et4
         a8NKUjVulr6jtfozA9mkbpRQg4WTOXxuHcGCHW6IUDy9SEM3uOkG3I9YcYxZ8XHBZc
         VQOiOcWBNBIaQNaoOLVf9P3WSzvfwrkoCaLi9cddg7fwtjuoDRBssubbkLbzrLF5RV
         M7eCqStdlrF9XX14gqQ9E/4h5mFUOUyNraXyb+YUY7JzaV9ufj6lxXLj4SdRUl/tpO
         b2mxFX292oS4g==
Received: by mail-ot1-f69.google.com with SMTP id x23-20020a05683000d700b0069438ae848cso1470803oto.21
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 09:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863698;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgYuLHBDbdAWqdmpPBV0ZgLbsqK4fpD+XI7eYMml57w=;
        b=LzoCDwOTxcAWc+WZOrSmu2eBNISamwwpZFLVAjsFHr35QLGqrWEk2tlzgsG5V3ti1k
         OtyMhPWV/5/w4aKhGVsNJPGi19zHvn18cJzftOp8po/c3NP0DfZWliCMOIi7KluT+w2o
         VtROzL6fK3dZ0fs6ED+6L26u9L2hRuTvewSKT/vpnNTlIuUZmt9ZJk/zuEtQaG9g4rX4
         7wE9jmlEnm/nPiCjd+b2PG8FS03R/oazbqd3CT97Iz6q07BA0mT/aE0tFtZ21OnvG5DV
         x/ah/nM+aA92oueZH8KsU4S0DCniasctREbVy3NSMeZi5bxRhJzxnxI1/uIc9syQSbZg
         JgQQ==
X-Gm-Message-State: AO0yUKUa1PdqGrCb08q2Zu5nDQ5JB3GHo7jHSrrZTMuYIDqA2fWz0h62
        nQd+Ft6MDZUjr7/JzybbGiXHPmJYM/ePfP3A8HvWc/Bus1g/AG9ewlFRYDy9MsMZIhH1wzQ8QF3
        p7bHCnmlF1RFm84l+eodHVbDLeAioeIGpHzAe3CZvvQ==
X-Received: by 2002:a05:6808:2da:b0:383:f572:2646 with SMTP id a26-20020a05680802da00b00383f5722646mr1024913oid.5.1677863698246;
        Fri, 03 Mar 2023 09:14:58 -0800 (PST)
X-Google-Smtp-Source: AK7set91nMG7k4hO2azPicxGrh/XawJFU9THxqJLa8ekYeoTNuviyDUD4h3iG2EGjdO8YhglzEJxMg==
X-Received: by 2002:a05:6808:2da:b0:383:f572:2646 with SMTP id a26-20020a05680802da00b00383f5722646mr1024907oid.5.1677863697929;
        Fri, 03 Mar 2023 09:14:57 -0800 (PST)
Received: from ?IPv6:2804:1b3:a7c3:d46d:73b6:f440:93a4:30? ([2804:1b3:a7c3:d46d:73b6:f440:93a4:30])
        by smtp.gmail.com with ESMTPSA id bb16-20020a056808169000b00383ebc74edasm1122650oib.7.2023.03.03.09.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:14:57 -0800 (PST)
Message-ID: <d04cf3d047712ff7f705c3f895ea5a09b9a81211.camel@canonical.com>
Subject: Re: [PATCH v38 02/39] LSM: Add an LSM identifier for external use
From:   Georgia Garcia <georgia.garcia@canonical.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Mar 2023 14:14:52 -0300
In-Reply-To: <20220927195421.14713-3-casey@schaufler-ca.com>
References: <20220927195421.14713-1-casey@schaufler-ca.com>
         <20220927195421.14713-3-casey@schaufler-ca.com>
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

On Tue, 2022-09-27 at 12:53 -0700, Casey Schaufler wrote:
> Add an integer member "id" to the struct lsm_id. This value is
> a unique identifier associated with each security module. The
> values are defined in a new UAPI header file. Each existing LSM
> has been updated to include it's LSMID in the lsm_id.
>=20
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

> ---
>  include/linux/lsm_hooks.h    |  1 +
>  include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>  security/apparmor/lsm.c      |  2 ++
>  security/bpf/hooks.c         |  2 ++
>  security/commoncap.c         |  2 ++
>  security/landlock/setup.c    |  2 ++
>  security/loadpin/loadpin.c   |  2 ++
>  security/lockdown/lockdown.c |  4 +++-
>  security/safesetid/lsm.c     |  2 ++
>  security/selinux/hooks.c     |  2 ++
>  security/smack/smack_lsm.c   |  2 ++
>  security/tomoyo/tomoyo.c     |  2 ++
>  security/yama/yama_lsm.c     |  2 ++
>  13 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 include/uapi/linux/lsm.h
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 23054881eb08..407f57aaa6ef 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -1603,6 +1603,7 @@ struct security_hook_heads {
>   */
>  struct lsm_id {
>  	const char	*lsm;		/* Name of the LSM */
> +	int		id;		/* LSM ID */
>  };
> =20
>  /*
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> new file mode 100644
> index 000000000000..5647c3e220c0
> --- /dev/null
> +++ b/include/uapi/linux/lsm.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Linus Security Modules (LSM) - User space API
> + *
> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) Intel Corporation
> + */
> +
> +#ifndef _UAPI_LINUX_LSM_H
> +#define _UAPI_LINUX_LSM_H
> +
> +/*
> + * ID values to identify security modules.
> + * A system may use more than one security module.
> + *
> + * LSM_ID_XXX values 32 and below are reserved for future use
> + */
> +#define LSM_ID_INVALID		-1
> +#define LSM_ID_SELINUX		33
> +#define LSM_ID_SMACK		34
> +#define LSM_ID_TOMOYO		35
> +#define LSM_ID_IMA		36
> +#define LSM_ID_APPARMOR		37
> +#define LSM_ID_YAMA		38
> +#define LSM_ID_LOADPIN		39
> +#define LSM_ID_SAFESETID	40
> +#define LSM_ID_LOCKDOWN		41
> +#define LSM_ID_BPF		42
> +#define LSM_ID_LANDLOCK		43
> +#define LSM_ID_CAPABILITY	44
> +
> +#endif /* _UAPI_LINUX_LSM_H */
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index b71f7d4159d7..fb6c7edd5393 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -24,6 +24,7 @@
>  #include <linux/zlib.h>
>  #include <net/sock.h>
>  #include <uapi/linux/mount.h>
> +#include <uapi/linux/lsm.h>
> =20
>  #include "include/apparmor.h"
>  #include "include/apparmorfs.h"
> @@ -1204,6 +1205,7 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_=
after_init =3D {
> =20
>  static struct lsm_id apparmor_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "apparmor",
> +	.id       =3D LSM_ID_APPARMOR,
>  };
> =20
>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init =
=3D {
> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> index e50de3abfde2..c462fc41dd57 100644
> --- a/security/bpf/hooks.c
> +++ b/security/bpf/hooks.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
> +#include <uapi/linux/lsm.h>
> =20
>  static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init =3D=
 {
>  	#define LSM_HOOK(RET, DEFAULT, NAME, ...) \
> @@ -21,6 +22,7 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_=
ro_after_init =3D {
>   */
>  struct lsm_id bpf_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "bpf",
> +	.id       =3D LSM_ID_BPF,
>  };
> =20
>  static int __init bpf_lsm_init(void)
> diff --git a/security/commoncap.c b/security/commoncap.c
> index dab1b5f5e6aa..4e9b140159d8 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -25,6 +25,7 @@
>  #include <linux/binfmts.h>
>  #include <linux/personality.h>
>  #include <linux/mnt_idmapping.h>
> +#include <uapi/linux/lsm.h>
> =20
>  /*
>   * If a non-root user executes a setuid-root binary in
> @@ -1448,6 +1449,7 @@ int cap_mmap_file(struct file *file, unsigned long =
reqprot,
> =20
>  static struct lsm_id capability_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "capability",
> +	.id       =3D LSM_ID_CAPABILITY,
>  };
> =20
>  static struct security_hook_list capability_hooks[] __lsm_ro_after_init =
=3D {
> diff --git a/security/landlock/setup.c b/security/landlock/setup.c
> index fc7b69c5839e..1242c61c9de4 100644
> --- a/security/landlock/setup.c
> +++ b/security/landlock/setup.c
> @@ -8,6 +8,7 @@
> =20
>  #include <linux/init.h>
>  #include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> =20
>  #include "common.h"
>  #include "cred.h"
> @@ -25,6 +26,7 @@ struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_afte=
r_init =3D {
> =20
>  struct lsm_id landlock_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D LANDLOCK_NAME,
> +	.id       =3D LSM_ID_LANDLOCK,
>  };
> =20
>  static int __init landlock_init(void)
> diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
> index 7e5c897ccbb2..276c8a7cd6fe 100644
> --- a/security/loadpin/loadpin.c
> +++ b/security/loadpin/loadpin.c
> @@ -20,6 +20,7 @@
>  #include <linux/string_helpers.h>
>  #include <linux/dm-verity-loadpin.h>
>  #include <uapi/linux/loadpin.h>
> +#include <uapi/linux/lsm.h>
> =20
>  static void report_load(const char *origin, struct file *file, char *ope=
ration)
>  {
> @@ -197,6 +198,7 @@ static int loadpin_load_data(enum kernel_load_data_id=
 id, bool contents)
> =20
>  static struct lsm_id loadpin_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "loadpin",
> +	.id       =3D LSM_ID_LOADPIN,
>  };
> =20
>  static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init =3D=
 {
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 2af4bff8d101..3d3347f3dbd1 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -13,6 +13,7 @@
>  #include <linux/security.h>
>  #include <linux/export.h>
>  #include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
> =20
>  static enum lockdown_reason kernel_locked_down;
> =20
> @@ -76,7 +77,8 @@ static struct security_hook_list lockdown_hooks[] __lsm=
_ro_after_init =3D {
>  };
> =20
>  static struct lsm_id lockdown_lsmid __lsm_ro_after_init =3D {
> -	.lsm     =3D "lockdown",
> +	.lsm      =3D "lockdown",
> +	.id       =3D LSM_ID_LOCKDOWN,
>  };
> =20
>  static int __init lockdown_lsm_init(void)
> diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
> index 3a94103f3c5b..88002731e603 100644
> --- a/security/safesetid/lsm.c
> +++ b/security/safesetid/lsm.c
> @@ -19,6 +19,7 @@
>  #include <linux/ptrace.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/security.h>
> +#include <uapi/linux/lsm.h>
>  #include "lsm.h"
> =20
>  /* Flag indicating whether initialization completed */
> @@ -263,6 +264,7 @@ static int safesetid_task_fix_setgroups(struct cred *=
new, const struct cred *old
> =20
>  static struct lsm_id safesetid_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "safesetid",
> +	.id       =3D LSM_ID_SAFESETID,
>  };
> =20
>  static struct security_hook_list safesetid_security_hooks[] =3D {
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 5e4938f3ce11..9803bbbc6747 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -92,6 +92,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/fanotify.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/lsm.h>
> =20
>  #include "avc.h"
>  #include "objsec.h"
> @@ -7014,6 +7015,7 @@ static int selinux_uring_cmd(struct io_uring_cmd *i=
oucmd)
> =20
>  static struct lsm_id selinux_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "selinux",
> +	.id       =3D LSM_ID_SELINUX,
>  };
> =20
>  /*
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5d8bc13feb09..2a88b4e7669e 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -43,6 +43,7 @@
>  #include <linux/fs_parser.h>
>  #include <linux/watch_queue.h>
>  #include <linux/io_uring.h>
> +#include <uapi/linux/lsm.h>
>  #include "smack.h"
> =20
>  #define TRANS_TRUE	"TRUE"
> @@ -4776,6 +4777,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_aft=
er_init =3D {
> =20
>  static struct lsm_id smack_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "smack",
> +	.id       =3D LSM_ID_SMACK,
>  };
> =20
>  static struct security_hook_list smack_hooks[] __lsm_ro_after_init =3D {
> diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
> index 38342c1fa4bc..71eab206ba6e 100644
> --- a/security/tomoyo/tomoyo.c
> +++ b/security/tomoyo/tomoyo.c
> @@ -6,6 +6,7 @@
>   */
> =20
>  #include <linux/lsm_hooks.h>
> +#include <uapi/linux/lsm.h>
>  #include "common.h"
> =20
>  /**
> @@ -532,6 +533,7 @@ static void tomoyo_task_free(struct task_struct *task=
)
> =20
>  static struct lsm_id tomoyo_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "tomoyo",
> +	.id       =3D LSM_ID_TOMOYO,
>  };
> =20
>  /*
> diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
> index ed6d45e62e0d..b178d74bb00b 100644
> --- a/security/yama/yama_lsm.c
> +++ b/security/yama/yama_lsm.c
> @@ -18,6 +18,7 @@
>  #include <linux/task_work.h>
>  #include <linux/sched.h>
>  #include <linux/spinlock.h>
> +#include <uapi/linux/lsm.h>
> =20
>  #define YAMA_SCOPE_DISABLED	0
>  #define YAMA_SCOPE_RELATIONAL	1
> @@ -423,6 +424,7 @@ static int yama_ptrace_traceme(struct task_struct *pa=
rent)
> =20
>  static struct lsm_id yama_lsmid __lsm_ro_after_init =3D {
>  	.lsm      =3D "yama",
> +	.id       =3D LSM_ID_YAMA,
>  };
> =20
>  static struct security_hook_list yama_hooks[] __lsm_ro_after_init =3D {

