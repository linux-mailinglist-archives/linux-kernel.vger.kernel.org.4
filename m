Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B106B7721
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCMME2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCMME0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:04:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F92278C;
        Mon, 13 Mar 2023 05:04:22 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso4676881wms.3;
        Mon, 13 Mar 2023 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678709060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUw2u/Y7kDzwzZt6uPCbf88aAz40Zj+acDXK8Geow0g=;
        b=C8rU7QnH0pCSlwf8ifBd/MWyhZTyDRQaFggusZLkg/h44AGkd7ZXqFLA6OXyH4ktpD
         K5glRd63mfofVR8VLx3Rt9Cr5b9VNEqmRaeiMaK1h5b81s/jGkpVBtv0bODmRlh2q1Zm
         QSsZpCsvjM8KuG7T6yKJxoeKbp5I6UTw2HMNDZab/NtYaCcFL7T2WGsM68J1XoiYUl8T
         lF2CrK1oiSaSarYnJApm0XJbOCgp0byfZJqJ7j9rrTkwfUVmeuwvI6rq0ybIrtVNHXMi
         yL2sJmPRCrEdRgJg9Zoz6H/6ek/6nPlDOp7pJVVr/pRfI8xLUkmxJ+ntUUjPftXrEZp3
         AhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678709060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUw2u/Y7kDzwzZt6uPCbf88aAz40Zj+acDXK8Geow0g=;
        b=n/bAFZA9JSWojWzw/bnfvGW78YItmMTkVMDbTsXUXFbz2c9eH5qmFLD+fhmr7dwHNv
         UAtqQ8pGomHK689ZJ3t/+lhYQC3USpozSq5xKz7+s+F6snkf/vnG5tTfMKh4fzBJPewo
         2z8J5RZTSs9Ps4ATl9wTzzYMqoHtXmpuz4nbMybUwnHG23x2N/ZPJyelKqsKAeSpGq41
         zEr5+TkYW4HZI0tENam3N36CbL0aLF+o1u5PcoKZECA9VBbiIf7PDJiuQ530fPsJYu+Q
         KHnb6fmMT6BItTHrjS0ms4Sw5EI8Z/YTWzbAIXdTf+iLwQu6Hs53eZXR/12bwxjqE1pz
         zkHg==
X-Gm-Message-State: AO0yUKWWoDd7LEqs/wbc6Yfyv5/AZ0ildnFG9EVNVMfX6metqXG82JWC
        mV4yVPksaeeuvDfKxq952k8=
X-Google-Smtp-Source: AK7set/SMUN3e32guFzTBcmKPb9TnERBOGBI+XpWKGzsj0mZ+6Q2f4cD/OYx8QFrrZ4Lw++QPx7U5A==
X-Received: by 2002:a05:600c:b8a:b0:3eb:578d:ded3 with SMTP id fl10-20020a05600c0b8a00b003eb578dded3mr10525365wmb.35.1678709060380;
        Mon, 13 Mar 2023 05:04:20 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id h9-20020a05600c2ca900b003daf7721bb3sm8170665wmc.12.2023.03.13.05.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 05:04:19 -0700 (PDT)
Message-ID: <edd15759-e753-5a6b-814d-e2289a324e56@gmail.com>
Date:   Mon, 13 Mar 2023 12:04:18 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] stress-module: stress finit_module() and delete_module()
To:     Luis Chamberlain <mcgrof@kernel.org>, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org
References: <20230313103439.1235909-1-mcgrof@kernel.org>
Content-Language: en-US
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <20230313103439.1235909-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Many thanks for this patch, I've added some comments. In principle this 
is a great idea, I think we have a few more iterations to get this fully 
in shape.

Colin

On 13/03/2023 10:34, Luis Chamberlain wrote:
> There are different ways to test loading modules:
> 
>    * modprobe calls
>    * kernel module autoloader
> 
> To stress tests modprobe we can simply run modprobe in a loop. To stress
> test the kernel module autoloader we can stress tests using the upstream
> kernel tools/testing/selftests/kmod/kmod.sh. This ends up calling
> modprobe in the end, and it has its own caps built-in to self protect
> the kernel from too many requests at the same time.
> 
> The userspace modprobe call will also prevent calls if the same module
> exists already.
> 
> This stress-ng modules stressor is designed to help stress test the
> finit_module() system call even if the module is already loaded, letting
> us tests things which are hard to reproduce.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> This is a patch for stress-ng to help stress module races with
> finit_module() and system memory pressure when userspace is being
> raced to see if a module is present and it fails to see the module
> already loaded, so stresses the system memory.
> 
> We can later add support to make the default module be saught after
> using uname and the /lib/modules/$(uname -r)/kernel/lib/$hello.ko.
> 
> But this should be enough to get us playing ball.
> 
>   Makefile         |   1 +
>   core-shim.c      |  35 ++++++++++
>   core-stressors.h |   1 +
>   stress-module.c  | 168 +++++++++++++++++++++++++++++++++++++++++++++++
>   stress-ng.1      |  27 ++++++++
>   stress-ng.c      |   6 ++
>   stress-ng.h      |   9 +++
>   syscalls.txt     |   2 +-
>   8 files changed, 248 insertions(+), 1 deletion(-)
>   create mode 100644 stress-module.c
> 
> diff --git a/Makefile b/Makefile
> index be46f656..f4ac7b63 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -316,6 +316,7 @@ STRESS_SRC = \
>   	stress-mmapfork.c \
>   	stress-mmaphuge.c \
>   	stress-mmapmany.c \
> +	stress-module.c \
>   	stress-mprotect.c \
>   	stress-mq.c \
>   	stress-mremap.c \
> diff --git a/core-shim.c b/core-shim.c
> index 4ef97a1e..262883e8 100644
> --- a/core-shim.c
> +++ b/core-shim.c
> @@ -95,6 +95,41 @@ UNEXPECTED
>   #define shim_rusage_who_t	int
>   #endif
>   

> +#ifdef HAVE_LINUX_MODULE_H

Where is HAVE_LINUX_MODULE_H defined? See notes below

> +#include <linux/module.h>
> +#endif
> +
> +#ifndef HAVE_FINIT_MODULE


Where is HAVE_FINIT_MODULE defined?

> +#include <errno.h>
> +#endif
> +
> +#ifndef __NR_finit_module
> +# define __NR_finit_module -1
> +#endif

.. see notes on shim_finit_module() ..
> +
> +int shim_finit_module(int fd, const char *uargs, int flags)
> +{
> +#ifdef HAVE_FINIT_MODULE


Where is HAVE_FINIT_MODULE defined? Normally this is defined in the 
Makefile.config stage and there are helper tests in tests/* to check and 
set these at the config stage of the build.

> +	return finit_module(fd, uargs, flags);
> +#else
> +	if (__NR_finit_module == -1) {
> +		errno = ENOSYS;
> +		return -1;
> +	}
> +
> +	return syscall(__NR_finit_module, fd, uargs, flags);
> +#endif
> +}

I'd prefer it if this is kept to the coding style of shim_*.c, e.g, how 
about the following to ensure all cases of the system call are handled:

int shim_finit_module(int fd, const char *uargs, int flags)
{
#if defined(HAVE_FINIT_MODULE)
	return finit_module(fd, uargs, flags);
#elif defined(__NR_finit_module)
	return __NR_finit_module, fd, uargs, flags);
#else
	return shim_enosys(0, fd, uargs, flags);
#endif
}


> +
> +int shim_delete_module(const char *name, unsigned int flags)
> +{
> +#ifdef HAVE_DELETE_MODULE


Where is HAVE_DELETE_MODULE defined?

> +	return delete_module(name, flags);
> +#else
> +	return syscall(__NR_delete_module, name, flags);
> +#endif
> +}

..and this is preferred:

int shim_delete_module(const char *name, unsigned int flags)
{
#if defined(HAVE_DELETE_MODULE)
	return delete_module(name, flags);
#elif defined(__NR_delete_module)
	return syscall(__NR_delete_module, name, flags);
#else
	return shim_enosys(0, name, flags);
#endif
}


> +
>   #if defined(__sun__)
>   #if defined(HAVE_GETDOMAINNAME)
>   extern int getdomainname(char *name, size_t len);
> diff --git a/core-stressors.h b/core-stressors.h
> index fe5ac70a..d22ef7f2 100644
> --- a/core-stressors.h
> +++ b/core-stressors.h
> @@ -166,6 +166,7 @@
>   	MACRO(mmapfork)		\
>   	MACRO(mmaphuge)		\
>   	MACRO(mmapmany)		\
> +	MACRO(module)		\
>   	MACRO(mprotect)		\
>   	MACRO(mq)		\
>   	MACRO(mremap)		\
> diff --git a/stress-module.c b/stress-module.c
> new file mode 100644
> index 00000000..f9cab300
> --- /dev/null
> +++ b/stress-module.c
> @@ -0,0 +1,168 @@
> +/*
> + * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
> + *
> + */
> +#include "stress-ng.h"
> +
> +#if defined(HAVE_LINUX_MODULE_H)
> +#include <linux/module.h>
> +#else
> +UNEXPECTED
> +#endif
> +
> +#if defined(HAVE_LIBGEN_H)
> +#include <libgen.h>
> +#endif
> +
> +#ifndef MODULE_INIT_IGNORE_MODVERSIONS
> +# define MODULE_INIT_IGNORE_MODVERSIONS 1
> +#endif
> +
> +#ifndef MODULE_INIT_IGNORE_VERMAGIC
> +# define MODULE_INIT_IGNORE_VERMAGIC 2
> +#endif
> +
> +static const stress_help_t help[] = {
> +	{ NULL,	"module N",	    "start N workers performing module requests" },
> +	{ NULL,	"module-path F",    "use the specified module name F to load." },
> +	{ NULL,	"module-unload",    "unload the module after module load" },

I think the semantics of module-unload should be the default, that is, 
we load and unload the module during the test cycle as the default 
stressing mechanism.  At the end of the stress test the module should be 
either unloaded (if it was not loaded in the first place before the test 
was run), or kept loaded (if the module was already loaded before the 
test was run).  Stress-ng by default should try to leave a system in the 
same state at the end of a test as it was in before the test.


> +	{ NULL,	"module-nomodver",  "ignore symbol version hashes" },
> +	{ NULL,	"module-novermag",  "ignore kernel version magic" },
> +	{ NULL,	"module-ops N",     "stop after N module bogo operations" },
> +	{ NULL,	NULL,		NULL }
> +};
> +
> +static int stress_set_module_unload(const char *opt)
> +{
> +	return stress_set_setting_true("module-unload", opt);
> +}
> +
> +static int stress_set_module_nomodver(const char *opt)
> +{
> +	return stress_set_setting_true("module-nomodver", opt);
> +}
> +
> +static int stress_set_module_novermag(const char *opt)
> +{
> +	return stress_set_setting_true("module-novermag", opt);
> +}
> +
> +static int stress_set_module_path(const char *name)
> +{
> +	return stress_set_setting("module-path", TYPE_ID_STR, name);
> +}
> +
> +/*
> + *  stress_module
> + *	stress by heavy module ops
> + */
> +static int stress_module(const stress_args_t *args)
> +{
> +	int fd;
> +	bool module_unload = false;
> +	bool ignore_vermagic = false;
> +	bool ignore_modversions = false;
> +	char *module_path = NULL;
> +	char *module_name;
> +	char *default_module = "hello";
> +	const char *finit_args1 = "";
> +	unsigned int kernel_flags = 0;
> +	const pid_t mypid = getpid();
> +	struct stat statbuf;
> +
> +	(void)stress_get_setting("module-path", &module_path);
> +	(void)stress_get_setting("module-novermag", &ignore_vermagic);
> +	(void)stress_get_setting("module-nomodver", &ignore_modversions);
> +	(void)stress_get_setting("module-unload", &module_unload);
> +
> +	if (ignore_vermagic)
> +		kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
> +	if (ignore_modversions)
> +		kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
> +
> +	if (!module_path)
> +		module_path = default_module;
> +
> +	if (stat(module_path, &statbuf) < 0)
> +		return EXIT_FAILURE;

if something does not exist, it's preferable to report this with a 
EXIT_RESOURCE message, e.g.
	if (stat(module_path, &statbuf) < 0) {
		pr_inf_skip("%s: cannot access '%s', skipping stressor\n",
			args->name, module_path);
		return EXIT_NO_RESOURCE);
	}

> +	if (!S_ISREG(statbuf.st_mode))
> +		return EXIT_FAILURE;

..and do the same with the st_mode return too, report it's not the 
expected mode and return with EXIT_NO_RESOURCE and an appropriate 
pr_inf_skip message.

> +
> +	module_name = basename(module_path);



> +
> +	stress_set_proc_state(args->name, STRESS_STATE_RUN);
> +
> +	do {
> +		int ret;
> +
> +		if (!keep_stressing(args)) {
> +			if (mypid > 1)
> +				(void)kill(mypid, SIGKILL);

killing a stressor with SIGILL is harsh, see notes below

> +			goto out;
> +		}
> +
> +		fd = open(module_path, O_RDONLY|O_CLOEXEC);

Minor style nitpick, I'd prefer spaces between between the | operator

> +
> +		if (fd < 0) {
> +			/* Check if we hit the open file limit */
> +			if ((errno == EMFILE) || (errno == ENFILE)) {
> +				if (mypid > 1)
> +					(void)kill(mypid, SIGKILL);

killing the stressor using SIGKILL is a bit too harsh, it is preferred 
to clean up any resources used and terminate either with an error return 
e.g. EXIT_FAILURE, EXIT_NO_RESOURCE (as in this case) or EXIT_SUCCESS.

> +				goto out;
> +			}
> +			/* Ignore other errors */
> +			continue;
> +		}
> +
> +		if (module_unload)
> +			shim_delete_module(module_name, 0);
> +		ret = shim_finit_module(fd, finit_args1, kernel_flags);
> +		if (ret == 0) {
> +			if (module_unload)
> +				shim_delete_module(module_name, 0);
> +		}
> +		(void)close(fd);
> +
> +out:

gcc version 10.2.1 20210110 (Debian 10.2.1-6) throws an error:

stress-module.c:140:1: error: label at end of compound statement
   140 | out:


> +	} while (keep_stressing(args));
> +
> +	stress_set_proc_state(args->name, STRESS_STATE_DEINIT);
> +
> +	if (mypid > 1) {
> +		int status;
> +
> +		(void)kill(mypid, SIGKILL);

Again, see notes about about a stressor killing itself.

> +		(void)waitpid(mypid, &status, 0);

This is redundant, if a process kills itself it can't wait on itself.

> +	}
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static const stress_opt_set_func_t opt_set_funcs[] = {
> +	{ OPT_module_path,	stress_set_module_path },
> +	{ OPT_module_nomodver,	stress_set_module_nomodver },
> +	{ OPT_module_novermag,	stress_set_module_novermag },
> +	{ OPT_module_unload,	stress_set_module_unload },
> +	{ 0,					NULL }
> +};
> +
> +stressor_info_t stress_module_info = {
> +	.stressor = stress_module,
> +	.class = CLASS_OS | CLASS_FILESYSTEM | CLASS_MEMORY,
> +	.opt_set_funcs = opt_set_funcs,
> +	.help = help
> +};
> diff --git a/stress-ng.1 b/stress-ng.1
> index 959649a8..24dc5783 100644
> --- a/stress-ng.1
> +++ b/stress-ng.1
> @@ -3402,6 +3402,33 @@ the maximum allowed mappings or a maximum of 262144 mappings are made.
>   .B \-\-mmapmany\-ops N
>   stop after N mmapmany bogo operations
>   .TP
> +.B \-\-module N
> +start N workers that will use finit_module() to load the module specified
> +or the hello test module, if you've compiled that. There are different ways
> +to test loading modules. Using modprobe calls in a loop, using the kernel
> +kernel module autoloader, and this stress-ng module stressor. To stress tests
> +modprobe we can simply run the userspace modprobe program in a loop. To stress
> +test the kernel module autoloader we can stress tests using the upstream
> +kernel tools/testing/selftests/kmod/kmod.sh. This ends up calling modprobe
> +in the end, and it has its own caps built-in to self protect the kernel from
> +too many requests at the same time. The userspace modprobe call will also
> +prevent calls if the same module exists already. The stress-ng modules
> +stressor is designed to help stress test the finit_module() system call
> +even if the module is already loaded, letting us tests races which are
> +otherwise hard to reproduce.
> +.TP
> +.B \-\-module\-path PATH
> +PATH of the module to use. You must use a full path.
> +.TP
> +.B \-\-module\-ignore\-modversions
> +Ignore module modversions when using finit_module().
> +.TP
> +.B \-\-module\-ignore\-vermagic
> +Ignore module versions when using finit_module().
> +.TP
> +.B \-\-module\-unload
> +Unload the module right after loading it with finit_module().
> +.TP
>   .B \-\-mprotect N
>   start N workers that exercise changing page protection settings and access
>   memory after each change. 8 processes per worker contend with each other
> diff --git a/stress-ng.c b/stress-ng.c
> index 034d7440..1fe65011 100644
> --- a/stress-ng.c
> +++ b/stress-ng.c
> @@ -686,6 +686,12 @@ static const struct option long_options[] = {
>   	{ "mmaphuge-ops",	1,	0,	OPT_mmaphuge_ops },
>   	{ "mmapmany",		1,	0,	OPT_mmapmany },
>   	{ "mmapmany-ops",	1,	0,	OPT_mmapmany_ops },
> +	{ "module",		1,	0,	OPT_module},
> +	{ "module-ops",		1,	0,	OPT_module_ops },
> +	{ "module-path",	1,	0,	OPT_module_path},
> +	{ "module-nomodver",	1,	0,	OPT_module_nomodver},
> +	{ "module-novermag",	1,	0,	OPT_module_novermag,},
> +	{ "module-unload",	0,	0,	OPT_module_unload},
>   	{ "mprotect",		1,	0,	OPT_mprotect },
>   	{ "mprotect-ops",	1,	0,	OPT_mprotect_ops },
>   	{ "mq",			1,	0,	OPT_mq },
> diff --git a/stress-ng.h b/stress-ng.h
> index c93654ac..be89cdba 100644
> --- a/stress-ng.h
> +++ b/stress-ng.h
> @@ -1614,6 +1614,13 @@ typedef enum {
>   	OPT_mmapmany,
>   	OPT_mmapmany_ops,
>   
> +	OPT_module,
> +	OPT_module_path,
> +	OPT_module_nomodver,
> +	OPT_module_novermag,
> +	OPT_module_unload,
> +	OPT_module_ops,
> +
>   	OPT_mprotect,
>   	OPT_mprotect_ops,
>   
> @@ -2914,6 +2921,7 @@ extern int shim_clone3(struct shim_clone_args *cl_args, size_t size);
>   extern int shim_close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
>   extern ssize_t shim_copy_file_range(int fd_in, shim_loff_t *off_in,
>   	int fd_out, shim_loff_t *off_out, size_t len, unsigned int flags);
> +extern int shim_delete_module(const char *name, unsigned int flags);
>   extern int shim_dup3(int oldfd, int newfd, int flags);
>   extern int shim_execveat(int dir_fd, const char *pathname, char *const argv[],
>   	char *const envp[], int flags);
> @@ -2921,6 +2929,7 @@ extern void shim_exit_group(int status);
>   extern int shim_fallocate(int fd, int mode, off_t offset, off_t len);
>   extern int shim_fdatasync(int fd);
>   extern ssize_t shim_fgetxattr(int fd, const char *name, void *value, size_t size);
> +extern int shim_finit_module(int fd, const char *uargs, int flags);
>   extern ssize_t shim_flistxattr(int fd, char *list, size_t size);
>   extern int shim_fsconfig(int fd, unsigned int cmd, const char *key,
>   	const void *value, int aux);
> diff --git a/syscalls.txt b/syscalls.txt
> index 2952a46c..69471a9f 100644
> --- a/syscalls.txt
> +++ b/syscalls.txt
> @@ -82,7 +82,7 @@ fchownat			close
>   fcntl				open, lockf, fcntl
>   fdatasync			hdd
>   fgetxattr			xattr
> -finit_module
> +finit_module			module
>   flistxattr			xattr
>   flock				flock
>   fork				fork

When exercising this I get:

./stress-ng --module 1
stress-ng: info:  [3471055] defaulting to a 86400 second (1 day, 0.00 
secs) run per stressor
stress-ng: info:  [3471055] dispatching hogs: 1 module
stress-ng: error: [3471055] process [3471056] (module) terminated with 
an error, exit status=2 (stressor failed)
stress-ng: info:  [3471055] unsuccessful run completed in 0.00s

sudo ./stress-ng --module 1
stress-ng: info:  [3471098] defaulting to a 86400 second (1 day, 0.00 
secs) run per stressor
stress-ng: info:  [3471098] dispatching hogs: 1 module
stress-ng: error: [3471098] process [3471099] (module) terminated with 
an error, exit status=2 (stressor failed)
stress-ng: info:  [3471098] unsuccessful run completed in 0.00s

These errors don't describe why it fails, so more useful error messages 
to explain why they fail would be useful.


