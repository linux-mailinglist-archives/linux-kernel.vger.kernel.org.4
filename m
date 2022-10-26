Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01060DAE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJZGCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJZGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:02:45 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01FC275CD;
        Tue, 25 Oct 2022 23:02:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id B31E22B069B3;
        Wed, 26 Oct 2022 02:02:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 26 Oct 2022 02:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666764158; x=1666771358; bh=cryDf7Y+3M
        9CLK5RxWlMrIwqHBGNcJC7X2dE+tQcf5E=; b=pJOk1vKHpOJjlwckSNd9BRxqwa
        A++tLXue4elCDJEs/FwhFCMA4mlybL7/bcnREkCUYMUIfOlEJG3da8STDZkqY5hs
        SzuYbmSPt3X9XBdPlwqHAwj/lEH9DzXUvPd8zyPxZYn7scRy2QpLPW9tSD1ZCkIm
        +Y9DmMBJ7crSaYzz2SnCH2FHvBVd/nrLtRvVcKXzrQpfQMJckENGGGKPVAyRhzXH
        s8Kgkj89i/YsXOkOt2tBxqI6ANLymIEZIitF+w4jgNRdAULBTSEDbv5MrAM7EUp1
        5DS+GdYHY6d/uOhz4L8q2f3jwCuGANSKcpVd1P1vfwzmim7NR18JivkiT/Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666764158; x=1666771358; bh=cryDf7Y+3M9CLK5RxWlMrIwqHBGN
        cJC7X2dE+tQcf5E=; b=M1A9P7x2QBOIYwjVzraKyNNSyTnArE+R0obaDKXkbaXk
        jdvk38VQWdNIpESdexhUNmHWkjVWE1z19E1lHwMP9yYTjvbzj7ndxqyk64e2orYe
        aeJ3doMIL9SQoHWrH30m79wnCxBzh0ppZTgDdjrJeVEZxBTyyw/evNeDjl2j7IDE
        3GY+vViS7j1D6T27qbCCMix12Th5LtnKw+EbC9mOz0L+jAtmOlPJqIZdmkMva6g7
        ISidOO8ARUK+jHyO++wVu1Kj3+1JC/gkpKKObBQooHD6KdPbPAecQjitmUOosAUL
        o2lzTPqt0Ro+20Rlq4G1/rZydnY3UdFSbzXj5QpXEw==
X-ME-Sender: <xms:fM1YY2c1NYGtJCfjRWE-ToSRYcbyVqg-Te1wW4d1KJ-MDdtTWMlh8Q>
    <xme:fM1YYwNjjKadQYtR5DoFs4Qym5182WubtY1YJH9WObzvqCyiHfg5CacFF3U9WmK0h
    V371zw47KMQIQ>
X-ME-Received: <xmr:fM1YY3gy3-KwsyTJIJlWe1VNMfccifUiNFIEPFULxLtA-WjfOIlAiWmVUGTBuGEDjWUjYd-059_OiYsv12vUZDLjdVRd_Wkx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtddugddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:fM1YYz-54_vwyb9t0PZecaZDG4fQrAzECh54C8whDimfPakdew-L6Q>
    <xmx:fM1YYys-vHzNQexTeSKfI4XK8T-PhxiriQ6AltoXY8u5x76V8QuZzw>
    <xmx:fM1YY6G2i1bxlBKKydESUNZKPAZScYO87oI6u9BuwX9phs0EvgRJkA>
    <xmx:fs1YYycPTIb2K9XyvlQx1x_rr2qI3mYVH8NmDF8Ka49z9KUnPokAvXLcxOc>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Oct 2022 02:02:36 -0400 (EDT)
Date:   Wed, 26 Oct 2022 08:03:29 +0200
From:   Greg KH <greg@kroah.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
Message-ID: <Y1jNsT0F7NKBi17h@kroah.com>
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-7-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025184519.13231-7-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:45:17AM -0700, Casey Schaufler wrote:
> Create a system call lsm_self_attr() to provide the security
> module maintained attributes of the current process. Historically
> these attributes have been exposed to user space via entries in
> procfs under /proc/self/attr.
> 
> Attributes are provided as a collection of lsm_ctx structures
> which are placed into a user supplied buffer. Each structure
> identifys the security module providing the attribute, which
> of the possible attributes is provided, the size of the
> attribute, and finally the attribute value. The format of the
> attribute value is defined by the security module, but will
> always be \0 terminated. The ctx_len value will be larger than
> strlen(ctx).
> 
>         ------------------------------
>         | unsigned int id            |
>         ------------------------------
>         | unsigned int flags         |
>         ------------------------------
>         | __kernel_size_t ctx_len    |
>         ------------------------------
>         | unsigned char ctx[ctx_len] |
>         ------------------------------
>         | unsigned int id            |
>         ------------------------------
>         | unsigned int flags         |
>         ------------------------------
>         | __kernel_size_t ctx_len    |
>         ------------------------------
>         | unsigned char ctx[ctx_len] |
>         ------------------------------
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/syscalls.h |   2 +
>  include/uapi/linux/lsm.h |  21 ++++++
>  kernel/sys_ni.c          |   3 +
>  security/Makefile        |   1 +
>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 183 insertions(+)
>  create mode 100644 security/lsm_syscalls.c
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index a34b0f9a9972..2d9033e9e5a0 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -71,6 +71,7 @@ struct clone_args;
>  struct open_how;
>  struct mount_attr;
>  struct landlock_ruleset_attr;
> +struct lsm_cxt;
>  enum landlock_rule_type;
>  
>  #include <linux/types.h>
> @@ -1056,6 +1057,7 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>  					    unsigned long home_node,
>  					    unsigned long flags);
> +asmlinkage long sys_lsm_self_attr(struct lsm_ctx *ctx, size_t *size, int flags);
>  
>  /*
>   * Architecture-specific system calls
> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> index 61e13b1b9ece..1d27fb5b7746 100644
> --- a/include/uapi/linux/lsm.h
> +++ b/include/uapi/linux/lsm.h
> @@ -9,6 +9,27 @@
>  #ifndef _UAPI_LINUX_LSM_H
>  #define _UAPI_LINUX_LSM_H
>  
> +#include <linux/types.h>
> +#include <linux/unistd.h>
> +
> +/**
> + * struct lsm_ctx - LSM context
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: context specifier and LSM specific flags
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context, a nul terminated string
> + *
> + * @ctx in a nul terminated string.
> + *	(strlen(@ctx) < @ctx_len) is always true.
> + *	(strlen(@ctx) == @ctx_len + 1) is not guaranteed.
> + */
> +struct lsm_ctx {
> +	unsigned int		id;
> +	unsigned int		flags;
> +	__kernel_size_t		ctx_len;
> +	unsigned char		ctx[];

Please use data types that are allowed to cross the user/kernel boundry
in a safe way.  That would mean this would use __u64 instead of unsigned
int, and __u8 instead of unsigned char.

thanks,

greg k-h
