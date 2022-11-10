Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980226238DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiKJBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKJBcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:32:17 -0500
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A112529C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668043935; bh=82risKr1ABVgEIC/TFr/dxbrSsLNA0ppt4j/jfUc/NE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=exdts7G6uoTLGaWeIrMM83JTmeB/Wk9JJ8woh/P/rppoSaRR46jgA2rVQK6HXjoGvxGOZHjWs4Kv1PGNMLi9j8u1qiGEd5kSkM/yicIK2BOD/iuKvPL4qTlo2zJhRqKddmVkki1Oss8VsVU4oYX5pKvORX4WjnAlKXTpDdfhxdjdsP7gP7Bvon7dgrm9nzJyzX0xNaKnpYrktUqLbZx4kSam9C3d6Ad00KkfCk6Ntow+03ds4Fm1OYomnLRhqsCd4ITzw+C+qXp5nN7F5N+myEe6ETofacAE8Vfx3/Cm0QVcPWRdsB2jzo9+yEtWDWjhxUz09XheCerzXZpFewxjCA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668043935; bh=CO2r51dSSeD9Z8/LJRQADlWyH75E+QJVgKsKGp8P7nw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=m5zJo/XbMQmSMOHnmAbB1YE/1kD/sEyZrS8UTzuqDfqwZgcnGwThi9fzzMlPjMefLsBTbgwvfvmnx7dgXD8cC35oEnTTFOsNmNxsIkDH+xpN/iNvz8t6yI4iBVUrcCzNzLuCrEiNxFpBj9tl7aJiTRedxy7opEDu6cuPGLZbMIo1vN4XfCvXrfK+fCurkgJn9D9vFSWFg/wMfOCu6/KXsaDAmVDQa3s1zENSuUiUhmRK17qzTqZ+OHPEzOydNbl5nFjarotk9jjEPjl5iq0EbuRw/KhN22eHOujp99MlPnfiWiukTnFL49tzclKYJXlyXDG69fbkcFSxEKk9Ulz9eQ==
X-YMail-OSG: o1WjAm0VM1nbq24Gq5RarEi7r9tBMaVa4xviRWdbGj2dUn.j.n3Pvw.SLWKdgFD
 rKOosdie97XL07_2269Hy2YRu3O8wG58SI49YuU4ihNe_q59_NsX_i1ePzX_6.tu4X9.c4Axyx.V
 buHnPXNswep2tOm64.LsUdGm3.P7QTn2NGOoQ1AZhTJ7Mk9LS.cp6Rlo0aPQi4mUIb6IHU2JATV.
 eKhO3FlNeq2tlajkIsA8qA4vp_lZa.848ZjfLAePtfAhePQe8EDs2JD5zkpUx.VulEb3tNaHOS4W
 OU.Aj.43f4hmgY5RUIZAPGhQCs2aHkz_qTLuSyuDMGfs.GYK1y4gbhgT2pnYf1qGiTjUfdsbJY9Z
 tom8LX5xNwuL2yez1e1Xlc0aMvNUSiktW0X6Vm8DU4KMErEl2pxIu8HVU0t3nuPcVGzENJi_1LCe
 UnnL8nbqICyR8jETG7TJQ4Atblrff7v0ZdeLy8S4yVCtKNGWuNUcXWO6kmkMaBbdCmAfxVH8x6DS
 ExZuDI79WvBl4C8XuoT3zOYPLovhMJ72VDevAg5PNnUsSKi1ZTMP_1QH75ctZnOPAjLyqMCUOW1B
 eYeQqH7ySPPLlJ59eho_0JeTk3GtVQDd5WczBI1B.IuAAU_Y.PKpEojvpYo16zVPGiMk_96T.Tve
 j.ZC0ZEYveaVly5jeuPaxwSTwD78FWCiN44r6dTfJ3kuFQ.g1fUtJ.qSh352yAbDHBcPn7BjsgHE
 6U9xV5O8Wyu2a9_4AD017EeVOmima3Plxx59OFjH5EJ4R.yaCzfy1OUzvltTZVzHueXDZu.bjdW.
 33OQDueYKbGTh4mFsehv1RcAcmaN1LeUqB6EDSE_G9PdDCn9IRurHWNTe6TbGVFDHXe7MZzntjhA
 KzyvYustZXACxY.ibW_CaaF_WkIAIY1BPiou.jNRstcDl6AkimjYmpc1nqXIEyEJ0Kk2MpA49n4_
 kBKM0cCEj_sgZgs0Zc.23vO.ZjXeQPBTzI1vmtltIqp3TuuQUL52Sq1oGlsPw8UYxSR1YQxDoLko
 lAQbQSht9Un0_37bOW_O7uZaN0n.v0C1ntQBkGVd6hMNPM6p2PPzT4zNzr60SCcwxYL42y0jFBIq
 9j07avIy4hiiP_6Wquq8KcGcTc.wrfgFmLgD.AHn8Vx5KaxB4sHTdOL5iqNJIzq290OAEK_Dplfx
 NOdUQYkx5bsiqrdUReS9eTKWyGgtqz62WozVUntGi_2xX5SpdsS4ZO9zuCo_UKSairQGDnfrtpb6
 UbrSX8fwv3NaaNz4re9cBXjsnRq0c57DC6yygjKSL1_AAQlTOyE8EBq_a9eMF7pMUYxcPhri7cPv
 BM5CGouufbT1JzbCntmSLxKDW4oOk.LnURtvteAItUMnBZ5MPH7QaZ_UE0Z_niO5D69YTW5vSIKj
 akTCDyTSo2ON.4N4EkOwAW.hHZVfbiKiK8faNAYotTSyakzhEfwbwHWmZppqKERYanxOqHXVyiDE
 9gkXs3meYCFhPjZDYrnQpsuxAhV6DN1kzk0lUu8xDo4tAmc67lysHstRhCp4XbPOuIaSlskxyWP8
 UkGWzDA2bWghFUgGsPPKnbl.cEBsHqGZ_EusQLxhnf2UDzr4MjBsodZmDNPl6hJBi_7GMqQDX86T
 1yX3T3M2jyd9UYozLTYdVsLk1SYGepfbKCES19a0MDIs_HrenqUsArDxNkG4jCQ60GfJDMRac2Fz
 3gYyyF7v.nFwX9.1H9A_hB_8iA1gEX8mHnaqcjsQjfKKF_vEpJgWwY5bT5KlMytX0LR3BAZLEWZW
 QZAXHDtf4CK9t4smo3mQ4XgIDNEgt1ZTFAlGyLFJYiYq1_2I5ryj9H64FnE7yesX_oTSbNHlm6xx
 U7F8pBXnFX_KFyI1ujxDev27CqRM1JNxJnyIYckp.Uy8sD_IJJYQcgzA8Gv8bwOyi2poI.rrQprx
 RI8t8HTJ0y8Nj2gD3ONtFFXeYAnk9s29GtQFGJ8lnnCqNsCVDGbMzA8UvXuFyAWCBdxx4lSEtC7d
 ZhmLZhCD.yLkNiXjW347bOkr606zA0Kyd783FqHTV6B5EadwE1agr79bhpNAPWxlThR97DQumJa4
 ER92tRmWIcy0W3g.S510oHifV6SmGbPibgIxwGNpndTrZCdvQmyCG3VwXzZfMHgQigTXdtjK7KhN
 onM25uD0rQxRvgJYIy6RNkLtrP_wU9vO2G0oHR64Nr_OnkbeO4wInfbk3hmzOT9jicEdHFYGdiXa
 bswX2GX.iEr2KsIbvGvBi_5ZmGwdWPg--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Nov 2022 01:32:15 +0000
Received: by hermes--production-bf1-5878955b5f-kkjj4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f5220e4d093175c46b9110e0c7413802;
          Thu, 10 Nov 2022 01:32:11 +0000 (UTC)
Message-ID: <25913838-c116-ed14-bdc0-3dcc0ce7f67f@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 17:32:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 6/8] LSM: lsm_self_attr syscall for LSM self attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-7-casey@schaufler-ca.com>
 <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ039=X+0edudy64-fpw4C2SwWV_MucbYfXwFKduwnbWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/2022 3:34 PM, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call lsm_self_attr() to provide the security
>> module maintained attributes of the current process. Historically
>> these attributes have been exposed to user space via entries in
>> procfs under /proc/self/attr.
>>
>> Attributes are provided as a collection of lsm_ctx structures
>> which are placed into a user supplied buffer. Each structure
>> identifys the security module providing the attribute, which
>> of the possible attributes is provided, the size of the
>> attribute, and finally the attribute value. The format of the
>> attribute value is defined by the security module, but will
>> always be \0 terminated. The ctx_len value will be larger than
>> strlen(ctx).
>>
>>         ------------------------------
>>         | unsigned int id            |
>>         ------------------------------
>>         | unsigned int flags         |
>>         ------------------------------
>>         | __kernel_size_t ctx_len    |
>>         ------------------------------
>>         | unsigned char ctx[ctx_len] |
>>         ------------------------------
>>         | unsigned int id            |
>>         ------------------------------
>>         | unsigned int flags         |
>>         ------------------------------
>>         | __kernel_size_t ctx_len    |
>>         ------------------------------
>>         | unsigned char ctx[ctx_len] |
>>         ------------------------------
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/syscalls.h |   2 +
>>  include/uapi/linux/lsm.h |  21 ++++++
>>  kernel/sys_ni.c          |   3 +
>>  security/Makefile        |   1 +
>>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
>>  5 files changed, 183 insertions(+)
>>  create mode 100644 security/lsm_syscalls.c
> ..
>
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index 61e13b1b9ece..1d27fb5b7746 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -9,6 +9,27 @@
>>  #ifndef _UAPI_LINUX_LSM_H
>>  #define _UAPI_LINUX_LSM_H
>>
>> +#include <linux/types.h>
>> +#include <linux/unistd.h>
>> +
>> +/**
>> + * struct lsm_ctx - LSM context
>> + * @id: the LSM id number, see LSM_ID_XXX
>> + * @flags: context specifier and LSM specific flags
>> + * @ctx_len: the size of @ctx
>> + * @ctx: the LSM context, a nul terminated string
>> + *
>> + * @ctx in a nul terminated string.
>> + *     (strlen(@ctx) < @ctx_len) is always true.
>> + *     (strlen(@ctx) == @ctx_len + 1) is not guaranteed.
>> + */
> We can do better than this, or rather we *should* do better than this.
> One of the big advantages of creating a new API is we can fix some of
> the silly things we have had to do in the past, including the
> "sometimes" NUL terminator on strings.  For this LSM syscalls let's
> make a promise that all human readable strings will be properly NUL
> terminated;

It requires effort and buffer management to ensure that ctx_len == strlen(ctx)+1,
but if you think it's important, sure.

>  currently this includes all LSM contexts, and likely will
> remain that way forever for various reasons, but let's leave the door
> open for arbitrary blobs (see the "special" LSM ID discussion from
> earlier in the patchset).  With that in mind I might suggest the
> following:
>
>   /**
>    * struct lsm_ctx - LSM context
>    * @id: the LSM id number, see LSM_ID_XXX
>    * @flags: context specifier and LSM specific flags
>    * @ctx_len: the size of @ctx
>    * @ctx: the LSM context, see description
>    *
>    * For LSMs which provide human readable contexts @ctx will be a nul
>    * terminated string and @ctx_len will include the size of the string
>    * and the nul terminator, e.g. 'ctx_len == strlen(ctx) + 1'.  For LSMs
>    * which provide binary-only contexts @cts will be a binary blob with
>    * @ctx_len being the exact value of the blob.  The type of the @ctx,
>    * human readable string or binary, can be determined by inspecting
>    * both @id and @flags.

I'd go a touch further, defining LSM_ATTR_BINARY as a flag and demanding
that any attribute that isn't a nul terminated string be thus identified,
even if it is always binary. Thus, LSM_ATTR_CURRENT and LSM_ATTR_BINARY
together would be an error.

>    *
>    * If a given LSM @id does not define a set of values for use in the
>    * @flags field, @flags MUST be set to zero.
>    */
>   struct lsm_ctx {
>     __u32 id;
>     __U32 flags;
>     __kernel_size_t ctx_len;
>     __u8 ctx[];
>   };
>
>> +struct lsm_ctx {
>> +       unsigned int            id;
>> +       unsigned int            flags;
>> +       __kernel_size_t         ctx_len;
>> +       unsigned char           ctx[];
>> +};
> I agree with Greg, we should be explicit about variable sizing, let's
> make sure everything in the UAPI header is defined in terms of
> __uXX/__sXX.  This includes strings as __u8 arrays.
>
> Also, I sorta despite the 'let's line all the struct fields up
> horizontally!' approach in struct/variable definitions.

Kids. Got no respect for tradition.

>   I personally
> think it looks horrible and it clutters up future patches.  Please
> don't do this unless the individual file already does it, and since we
> are creating this new please don't :)
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> new file mode 100644
>> index 000000000000..da0fab7065e2
>> --- /dev/null
>> +++ b/security/lsm_syscalls.c
>> @@ -0,0 +1,156 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * System calls implementing the Linux Security Module API.
>> + *
>> + *  Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + *  Copyright (C) Intel Corporation
>> + */
>> +
>> +#include <asm/current.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/security.h>
>> +#include <linux/stddef.h>
>> +#include <linux/syscalls.h>
>> +#include <linux/types.h>
>> +#include <linux/lsm_hooks.h>
>> +#include <uapi/linux/lsm.h>
>> +
>> +struct feature_map {
>> +       char *name;
>> +       int feature;
>> +};
>> +
>> +static const struct feature_map lsm_attr_names[] = {
>> +       { .name = "current",    .feature = LSM_ATTR_CURRENT, },
>> +       { .name = "exec",       .feature = LSM_ATTR_EXEC, },
>> +       { .name = "fscreate",   .feature = LSM_ATTR_FSCREATE, },
>> +       { .name = "keycreate",  .feature = LSM_ATTR_KEYCREATE, },
>> +       { .name = "prev",       .feature = LSM_ATTR_PREV, },
>> +       { .name = "sockcreate", .feature = LSM_ATTR_SOCKCREATE, },
>> +};
>> +
>> +/**
>> + * lsm_self_attr - Return current task's security module attributes
>> + * @ctx: the LSM contexts
>> + * @size: size of @ctx, updated on return
>> + * @flags: reserved for future use, must be zero
>> + *
>> + * Returns the calling task's LSM contexts. On success this
>> + * function returns the number of @ctx array elements. This value
>> + * may be zero if there are no LSM contexts assigned. If @size is
>> + * insufficient to contain the return data -E2BIG is returned and
>> + * @size is set to the minimum required size. In all other cases
>> + * a negative value indicating the error is returned.
>> + */
>> +SYSCALL_DEFINE3(lsm_self_attr,
>> +              struct lsm_ctx __user *, ctx,
>> +              size_t __user *, size,
>> +              int, flags)
> See my comments above about UAPI types, let's change this to something
> like this:
>
> [NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]
>
>   SYSCALL_DEFINE3(lsm_self_attr,
>                  struct lsm_ctx __user *, ctx,
>                  __kernel_size_t __user *, size,
>                  __u32, flags)
>
>> +{
>> +       struct lsm_ctx *final = NULL;
>> +       struct lsm_ctx *interum;
>> +       struct lsm_ctx *ip;
>> +       void *curr;
>> +       char **interum_ctx;
>> +       char *cp;
>> +       size_t total_size = 0;
>> +       int count = 0;
>> +       int attr;
>> +       int len;
>> +       int rc = 0;
>> +       int i;
> Ungh, reverse christmas trees ... I kinda hate it from a style
> perspective, enough to mention it here, but I'm not going to be petty
> enough to say "change it".

I really don't care. Last I saw reverse christmas tree was the officially
recommended style. I don't care one way or the other.

>
> However, if you did want to flip it upside down (normal christmas
> tree?) during the respin I would be grateful ;)
>
> --
> paul-moore.com
