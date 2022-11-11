Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C5B624EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiKKAga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiKKAg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:36:28 -0500
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172532DE5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668126986; bh=a08TN5Vw9C/iQTWDJIvfwZTOQLSJnvSm70/FrlpvjTE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=BaIleDF7OCAmQ7Uv4DjRqZMqNZLXUV0l1a5rQnBZr/shujZQAWti87J/iwwV0SHU0TJ1GMUkJqEN6jrVcwoh+kNvnyrGbwS0BF0l7i6Itv2fu8rJCayu+LSrTLoHkSGY2YZIFmaAex+jgrRYY3i4ropBYneSY7roaGqjSWNvJnC0M8Tp3Jzi1aUDZN8CkwDJDVUjm/MpK7TLkuq9IjbsELiUvOT5MYzWs1VrmxT1MZ7m1QFmlYMTZ4ERvizHlwJL43/nDZgoMoA36lPU+6t31uv0QCnSV2xrfCLQceXk0Cz+Ph2CEmMZa9eFRWTq2Y0fk3b2uSXM6/atUMd1phFGGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668126986; bh=bPT70eTxEpEYVQxqbFaSJaCOXRM0S3jD0n4Pyrl6+nr=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=RMgy+WwYre6zGt/N/JTJz7XqH73mCvyaEOxA7TQn5yftlnr/suxXwY7qc2D2NZOh2o9D49MBS37Fc73F8XGKOqiJ7Fa2xsAQA/pCkzh6oZmKeuwb7l6BOYbrEDyOFmru2iuTLzwdRRTzuIA+1S18jrlVsLnbMW6kqjUZtgGmDr3260xeEXzzk0LCE43Q59rXue9AxQWRjKM5vSejpBpN9XUa8J84vpOUCPpkIF2eI0G3fQSmOqQ7AohXzJGWymi9BAb4a1uKeXt3fJhS+1hlKIkO6hRMXnMsiTTwbpQ2DLFyOG0HBSN1sofat0zsa4o+o7B4KJoFyLja/dM3pZWReA==
X-YMail-OSG: 84Oj0Q4VM1kBPNBJqE0Y7xGEO6zCulykA2vRMHMek9Z5Bl5NFKJ1QbQR4SUALcv
 MksdscxAiQmmq.We3togYm7pZ.HuMi.Qxcmfw.7DnCXHA7C7OIwH1RZTeOD1UyJPMOuz0v_IigPX
 hZrue2EjMuY86xAl.nmss0EWc16bByoVNDdXx9gkIrhbbHTMC.RKHmnoTGbcdFOfQj_AknDcbm3u
 4HLBJUvNI4qgxgqHciafLURAixUrbAEdEIoiclxqypiamcDJNYQCz7xeCF3iHHx37N2DLv.EGTRz
 EUX3PYJ4Z1Whb5JqPwkDGoX7jyz713kdBWZSH9cQ294T9kByJ6A2w4ojK1ddOp32LUQzpaKjlKPT
 9szEWz5hsoJM_0sQBPvcRF4j7fnkNT0EfxVXB0gfrelSryrCyy_CIHMvq15NeG4wO3z9J5jicSdh
 _pIEoaT4.HP4Sa6qd5JhlpafxZ6pJDcK4kfeHpyvl4h7uErPd2rNxf0mFCC7MKlMKqllNHEjiJvI
 ddWkQl6JI8K3yjIOo6E5Rltj5tbv2SXPUiWxIm1lo.cuboQCzgI6ZHoQhi_Ho1WlSHr2ND3LA3WO
 KuxwlNSP_FQTf6q448vFF9zvtUKhaqznSMewpDEV2No4HvAGL41UpqB09O0aM0tySD9OpMs1h47a
 pYsxmAb5dUjJ9Bue.sLnHeX4RMP.mEMOvLy6AY5TdIeqfkeVDnpPCGUMNBkXb0_t1U2KpoGmfvYA
 dt.QPvIJI8MJ5vBhJ2gLf2wc6BH4hoGqvg_rYfuaf9QdaEJPEXp1gPHTDEe._XfP0QCutyuvOTRL
 j4gcjWU5FXz0mqdkxDc1HCxwB4rM1hqOMhLSVS3aeNJKq.T6Kxc7XF1fE619G8eWy1nr78aRej2M
 VMweSdyC9oAKwbpBBVsegCER1hRRlRRUJrh_lH9dcTpb3LDG5ls3snZcIpI8VYpstK8ZGjAVpMzU
 LVgTIuj0nfnfnh23lTSZjgPy1gL3AXaArBuvvrRpkCTnpvFRVt6emGlyQOH47KxlKKw6LXhmQLJY
 5pbBX7lzJzQZAmx4Hm5JVZd_bDN7x7yYmGlwbD5ZZk7qYLMXWc1kZARKpdKzMSlbfSx.O7hXA5Cr
 3Pz6gouJoYgIMtoG9uKpRQ6M1JpUUX9i4OZVxU_kJ43PYshfOlYJt_0O.FLNDt7zTMDYY.0tPjV3
 L3suceaTowERlqZ.kY2xYcwWsGHNjrV_SR3j3xKbnn51zkb.G.H5WweeP3Fo9abmuRSJcV8bmMLH
 ZZQw5Y5mB7St702U2bBhLX9ORfS_4.vQNrWZUNAZVjhRNZ1bX6TCWxO5dSJXDUBnPZoEiWhQ7LL6
 ElyD9.UMIedF0z7eOisQYJ95dXP2pSCYFnPcX166CkZtdpoHKxVbWmRNbiElPx6cfACxadvdMWeM
 yuBB0iv8BfLaovwfy5PdhhIVNoTTGYFJ.pqMeex3cT2ocgXvpFOX9q3revDXpgqz2kOhsGGpSAPG
 bTvQRPzpeYiv767wqEhpuI5v0PSP.n1F84fka26ApOR5rpOi3RTSDKDAsSC0c7oINlyN.sKHz7s9
 DeknJGz9M8ZFT5vRQjjTIo.Up14AoAN99ymC0CoPF_LyiruIvwbW9A3uk9m_VetyKqA2ZGcQbITC
 nzYfV7SOAvAyJxLutSGy1ozxOzqKxLw6UTGhqTVUt9ti_gC5X.U0xpvN_dJjXw1EI_KRCtG.etEc
 YcCz9iLH6333VS4iN.h1bRKCrRMBmT.P60cAkQhevvg7ypLTEkthHsq2D7RuPgggxxQlxlQDvE2U
 pd8nn5gDE4VwPHyjSvllm0mGXiQAzRhQ1ISuzuu05H5so_mHXwaT7M5Sc9BlL14hvXSMGaTPKx2u
 dTjUp21G0m4._ufvYPX_3yEX63CO6TgrHwNfXxztSCkiVD.dsot9ISOrcrOTq75Rdbbg7vSDA8LU
 1jZ0D_h6R79a4aysACj5C16JIoQS6K85M46_MoqaYg.gmLsvh6UjE1ugEUAqL2TyCgImPH9N91K0
 1OKbjMOeFlW_r8LWKG_NFwAGSfcA8WonEDRdTzHYcAo5Id44ml_mYUwWPrIk.9CysXTYFrNfFoV5
 IB9QVMT4bmxdN3p3zkASyH8aKO1lle8hrM4qFqxCKJpaj.J9xVzEfdgw0AbpEJklNCKOJ2Qz5ifM
 7DUCfcZjNmEBi8GhL1OcNa81._Bnfi6GuZgI28p2ULXXm4RiVteHdv_eGGpRK5IrkSfMIunKUYZI
 SgfuEEzR61r9vOnvgZODFhmrI
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Fri, 11 Nov 2022 00:36:26 +0000
Received: by hermes--production-bf1-5878955b5f-d26fx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3b3b6096e13b0eaea7cc1a4f700ef0c6;
          Fri, 11 Nov 2022 00:36:22 +0000 (UTC)
Message-ID: <94874c5f-5222-aab1-3fbf-5cacd15a2fdf@schaufler-ca.com>
Date:   Thu, 10 Nov 2022 16:36:20 -0800
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
 <CAHC9VhSCAM+xdKf_f210-M-ZFY9KBVgpK84nbuCcVF9Z3qs2eA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhSCAM+xdKf_f210-M-ZFY9KBVgpK84nbuCcVF9Z3qs2eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 3:36 PM, Paul Moore wrote:
> On Wed, Nov 9, 2022 at 6:34 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> Create a system call lsm_self_attr() to provide the security
>>> module maintained attributes of the current process. Historically
>>> these attributes have been exposed to user space via entries in
>>> procfs under /proc/self/attr.
>>>
>>> Attributes are provided as a collection of lsm_ctx structures
>>> which are placed into a user supplied buffer. Each structure
>>> identifys the security module providing the attribute, which
>>> of the possible attributes is provided, the size of the
>>> attribute, and finally the attribute value. The format of the
>>> attribute value is defined by the security module, but will
>>> always be \0 terminated. The ctx_len value will be larger than
>>> strlen(ctx).
>>>
>>>         ------------------------------
>>>         | unsigned int id            |
>>>         ------------------------------
>>>         | unsigned int flags         |
>>>         ------------------------------
>>>         | __kernel_size_t ctx_len    |
>>>         ------------------------------
>>>         | unsigned char ctx[ctx_len] |
>>>         ------------------------------
>>>         | unsigned int id            |
>>>         ------------------------------
>>>         | unsigned int flags         |
>>>         ------------------------------
>>>         | __kernel_size_t ctx_len    |
>>>         ------------------------------
>>>         | unsigned char ctx[ctx_len] |
>>>         ------------------------------
>>>
>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>> ---
>>>  include/linux/syscalls.h |   2 +
>>>  include/uapi/linux/lsm.h |  21 ++++++
>>>  kernel/sys_ni.c          |   3 +
>>>  security/Makefile        |   1 +
>>>  security/lsm_syscalls.c  | 156 +++++++++++++++++++++++++++++++++++++++
>>>  5 files changed, 183 insertions(+)
>>>  create mode 100644 security/lsm_syscalls.c
> ..
>
>>> +/**
>>> + * lsm_self_attr - Return current task's security module attributes
>>> + * @ctx: the LSM contexts
>>> + * @size: size of @ctx, updated on return
>>> + * @flags: reserved for future use, must be zero
>>> + *
>>> + * Returns the calling task's LSM contexts. On success this
>>> + * function returns the number of @ctx array elements. This value
>>> + * may be zero if there are no LSM contexts assigned. If @size is
>>> + * insufficient to contain the return data -E2BIG is returned and
>>> + * @size is set to the minimum required size. In all other cases
>>> + * a negative value indicating the error is returned.
>>> + */
>>> +SYSCALL_DEFINE3(lsm_self_attr,
>>> +              struct lsm_ctx __user *, ctx,
>>> +              size_t __user *, size,
>>> +              int, flags)
>> See my comments above about UAPI types, let's change this to something
>> like this:
>>
>> [NOTE: I'm assuming it is safe to use __XXX types in syscall declarations?]
>>
>>   SYSCALL_DEFINE3(lsm_self_attr,
>>                  struct lsm_ctx __user *, ctx,
>>                  __kernel_size_t __user *, size,
>>                  __u32, flags)
>>
> I wanted to clarify how I originally envisioned this syscall/API, as
> it looks like it behaves a bit differently than I originally intended.

That's why we're having a review cycle.

> My thought was that this syscall would be used to fetch one LSM
> attribute context at a time, returning an array of lsm_ctx structs,
> with one, and only one, for each LSM that supports that particular
> attribute.

My thought with the interface I proposed is that we don't want a
separate syscall for each attribute: e.g. lsm_get_current(), lsm_get_prev(),
and we don't want a separate syscall for each LSM, e.g. lsm_get_selinux().
We can either specify which attribute is desired or which have been returned.
In either case we need an attribute identifier.

>   If the LSM does not support that attribute, it must not
> enter an entry to the array.  Requesting more than one attribute
> context per invocation is not allowed.

Why? That seems like an unnecessary and inconvenient restriction
for the program that wants to see more than one attribute. A service
that wants to check its fscreate, sockcreate and keycreate to see if
they're appropriate for the container it's running in, for example.

>   The idea was to closely
> resemble the familiar open("/proc/self/attr/current")/read()/close()
> result without relying on procfs and supporting multiple LSMs with an
> easy(ish) API.

	rc = lsm_get_self_attr(struct lsm_ctx *ctx, size, attr_id, flags);

This looks like what you're asking for. It's what I had proposed but with
the attr_id specified in the call rather than returned in the lsm_ctx.

>   The new, single syscall should also be faster,
> although none of this should be happening in a performance critical
> section anyway.

Yes.

> In addition, the lsm_ctx::flags field is intended to convey
> information specific to the given LSM, i.e. it should not repeat any
> of the flag information specified in the syscall parameters.  I don't
> believe any of the currently in-tree LSMs would require any special
> flags for their contexts, so this should always be zero/clear in this
> initial patchset, but it is something to keep in mind for the future.
>
> Thoughts?

I don't have any problem with *what I think* you're suggesting.
To make sure, I'll send a new patch. I'll also address lsm_set_self_attr().
Thank you for the feedback. Let's see if we can converge.

>
> --
> paul-moore.com
