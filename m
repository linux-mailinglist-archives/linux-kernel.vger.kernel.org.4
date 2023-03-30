Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AD66D0F95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjC3UA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC3UAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:00:24 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6EE10252
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680206412; bh=u3QrSZL9GD+I3EK2EiLGx3xYjxMky3iipWsag5yff+U=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=XiwZ98fyTkFQTEGz/Cn5qa8LO6cYpMFuTmbxGabdn3IhbdnDXFyOj0Sc7L8qcIbypu726Vt/z78xD+G/2OWTkK9XoWGqHkLcidQdmOCVcG5rlBKUL7L+Q5v4CKUf09pQYhskIfezugpZ8HDTmcg7zhgYTyNZiOLZjm4WB3bizFTIAZm7K5fOlutTTKSrUjrk1u+hfP9DH3CtAmMSOTzJdUTUH6Nxe9xAz2+RMQ2EI64EAtO1knzPemv/cYv2LcH1kyZCJGUXJoqn2NE4CREQCGkpruA0HD+Fvgfm/n0RLbTCTYEqqv1og9xqBc84AgVLMN5mCI/LGBZVbCz8X2WyEg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1680206412; bh=UbCDl79TExKYofKVQMiEGKemz+dxzI1dVaATmWR9xql=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=F5vffjLsEUfK3bL3cYzdAuWjU3S152kQ4wOJIyIhnFVYf3eDUX7rg0whAlCjDzgbrtyg6Jps5MCtKQkYOtkl1AqDTGtNd+Yskc/ep6Oqk1nbOKI/guIQivaQMGWUnIHjj8ZtXqYz+gAYy3ZopvP1zPDUFSQ7SIYtAjbsF3b37+6BrGridIMofWH6MAS0PRY8YgSNlvHJUmSC+r0o1Xqd+fr4XKd9lF+zC9zltnayDSY3kdxA8orhispjlZT5WcPc8VsLA6ga/zlIxYHrliU51wVBLxWw9zT8jhAbUplm/kW00vr8OrUWhlM5ZnA8LxEYZ/tGCFNAG/EJbNephl00QA==
X-YMail-OSG: UHCvQ_gVM1nzjp5qD6GjdqQ0u5XRPBbgOYUf7RRUGHjmNJPDlBe0AYTAvnRzbkM
 ku3cACi9KB_bvbkGN7XJ_IGPUMDXVoBs6PGPoTJ_eyCNklEgeChsz5xAyitu.DLuL1smt1H_4hIn
 TEW.R3seKGD5xGxsdz_XlGBUdYpewZUhpv1TvgwburNjJfIuYSsS3p9nQTQ.tBBgqEb7mdgiBau7
 ZZmdVJza4yNtEjVq086DwU1ppb7v8uyw26hmZV2W2z8KIZcpQK8yPK.uqoxYpmrqT9zIMj2Faj6G
 m7NvaIXZrJ4.CDH1FOJkdFTf5paVvq7wNiZGypiRpkMkoYDrzscXJkj2LfRdpi9xlNssAPnuypMS
 AbJ03MmCCxqEbDL9vgpPywZZ14eAn3qVcBcYVlYuTlE0uzd8SYXJfDhIiZYJ4R5in1Iilr7HeLDp
 rVz.HvMhqLFOYksM6uWTOFfaKuj39sOxNiWFTJDQVyK7ZmMfhqvwp8PSvLhW.1sqMCrASzCsFCaG
 3vGdeEc2yhc9_z5HZcktt.dGZvqt1eSg7VRTJv9F2YWNsweKQWlAvZkAy7nf3aZjNPFWtJ1zmIPx
 Cpt11GjfCa8Vl5EpoX.lvn4vqyEVNBW3U1HpEnMOw98WYLsQJWPogEcNSPVmXQeU3hXSpSuN9EU.
 9BUb2Y4zjczQu8IioH8dBax_pmjhDDAcOaet0sJa1mt7EuUm2f3Dqsq0BEgB8VtIgxzNOFa1Em2Y
 9_y1xy6QtLGOgKMfnyKtrCBnMJXaGsSsI0i5XdNgYXZdwLr0tlfH53PkuOPgXHvKMIu8WmTeV5rs
 uzdyHuWRZLErbNdq0j59rXM1R1qus629zPARjerrp_gjg6TFjaru7HJLR.3WpKXYavOAAcgUn2ZJ
 MEkZDk_OeBjFGhOead9UuJtLBR9f8DFNmU55Jzocsm4NJFeBR7rprjyddfXRnLslLNarM7ogPMza
 waDSTS9AQ61i5C4RXmC04w3frQCeYxWHoYTZDRdVKPPazgBer.ZGFNMB6O8sY0oHZW0avV83fCWS
 QTxNbLuVuTXkKlCsGBCQNvoIgN55D2WKurXz0IiEC_j5K3AVtihMj9s2VX_AmCzLdhJYmmp9LT3E
 KZMUP4B88c3t92SsWS7xVb6EZ1ThapSGPcSgoXfBxjdhgHnq9Aow9.YpGz7CKFbpPZOdP3JPbdxV
 SbqIb1l0SY8Zhp7a1eozeEVdfiw.AWHouNSkGaMuS9BtB57PtZ_6Nr59I1gxoBUnZTJbG1kCmQLM
 AKiuinAEDO_GNqxnWmgQmqtoWqtcN1mWfkMpboHtrY7n0GKiTYe6gBsIH5OwtKFO4fxjKkKdEzio
 m6wb.0Wc4CV0tWgyVni1dW36KAW5a9yaEmlhwH2PJ8O21a5bHzkfIvFaJ2c3AzQo_c94tyVuhtjC
 eKvjjUGIg0K3XO5urV6kIyGkUgHvZ0uqPBhUQENvIMF17k7Z4NCYlZrsZqvhztTFpDo6jNfb43Yj
 kLOteXh9pjeJJPkDekVRSSJrSEmyG8cOlrJ8M56B.rIha42jB0TK0VwStE2aLH2yzdb21wdWRquM
 q0UDKSlJhnL2DKk0aFIM7jrjFT8blFt1oL2nFtHUrHVNA6_ywzp.oKCFWEzNfYwXwtpZ79_YaSQ0
 S8DHcpchQciCLfZEnJ9m9wxAwPbI5.KyIEfrlSoqDigaZC_n4E73wN3TX03z17Gg0qjO0eKux6ee
 BUPJdhYWx0oRCsvRYn.7AYgY8G0LAKLPhlo.7UUv2C7kdQMd.14Ee.egHY5lZHRra..sDwYENOCv
 CmR_WJvqD7Wb4yAs6YN6uwN2TGZCTzNZbQQq9uJz1.Zd_h3xCpWzH3SCKlEJsyxmafg0AWK0J.Ks
 1NLzmEeHD51I93M8NNif9rqMLSxPYkpa9BoY0tDScTLvteTelWFDspD6N5L3lbfDv6WqjcfbS1XZ
 CG5_nlD7r8rtmrGedDVwDG42T5X9z4oxwlFKts4KVlPQUyFfEHi51lWK4bBa.QmOpdYBUksSemB5
 4Y_5iF.Ev7Hl8qvJZ_ap4zvMHKZngu8_GgqCVbDfoW8kVV0cH7aa2KNsD7AOPLUsJ4pEA.J4xpyG
 9i.iykZq.WqAWUznToJp0cFS.wyemz7A7u..5OUIXfYSXy1f5L_UI2uu09NWlpDthsJUVom4rHOC
 UCJ3NhX5umLMZKHJgEQI7HRlFJX5CVzVibXTiw9gBojW5hvnRZydMK6q73WRXsp1Lj5NyerO4oXu
 vuCtq3HHmuJb2T2ostjHIYwUrqv9BpQUB2yfGkS6vAdYyNa.MVbJV6hrnzQLK9h9ao5uuzca0k6m
 iTcMuDZY-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 31fe1430-440c-4cf2-84a6-0cfb46e4bdf4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 30 Mar 2023 20:00:12 +0000
Received: by hermes--production-bf1-5f9df5c5c4-84ds6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 142d9d5fc61c35bfe36f490518e2974b;
          Thu, 30 Mar 2023 20:00:11 +0000 (UTC)
Message-ID: <6cbbe6eb-d808-7a99-9ca9-43f816b99833@schaufler-ca.com>
Date:   Thu, 30 Mar 2023 13:00:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v7 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230315224704.2672-1-casey@schaufler-ca.com>
 <20230315224704.2672-5-casey@schaufler-ca.com>
 <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRuKqaYD=WCzuuk4=+qFSvCjCEMEsPjAh9pQe-=LyMthA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2023 6:12 PM, Paul Moore wrote:
> On Wed, Mar 15, 2023 at 6:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifys the size of the attribute, and the attribute value. The format
> "identifies"
>
>> of the attribute value is defined by the security module. A flags field
>> is included for LSM specific information. It is currently unused and must
>> be 0. The total size of the data, including the lsm_ctx structure and any
>> padding, is maintained as well.
>>
>> struct lsm_ctx {
>>         __u64   id;
>>         __u64   flags;
>>         __u64   len;
>>         __u64   ctx_len;
>>         __u8    ctx[];
>> };
>>
>> Two new LSM hooks are used to interface with the LSMs.
>> security_getselfattr() collects the lsm_ctx values from the
>> LSMs that support the hook, accounting for space requirements.
>> security_setselfattr() identifies which LSM the attribute is
>> intended for and passes it along.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  Documentation/userspace-api/lsm.rst | 15 +++++
>>  include/linux/lsm_hook_defs.h       |  4 ++
>>  include/linux/lsm_hooks.h           |  9 +++
>>  include/linux/security.h            | 19 ++++++
>>  include/linux/syscalls.h            |  5 ++
>>  include/uapi/linux/lsm.h            | 33 ++++++++++
>>  kernel/sys_ni.c                     |  4 ++
>>  security/Makefile                   |  1 +
>>  security/lsm_syscalls.c             | 55 ++++++++++++++++
>>  security/security.c                 | 97 +++++++++++++++++++++++++++++
>>  10 files changed, 242 insertions(+)
>>  create mode 100644 security/lsm_syscalls.c
> ..
>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 32285ce65419..3c2c4916bd53 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -503,6 +504,14 @@
>>   *     and writing the xattrs as this hook is merely a filter.
>>   * @d_instantiate:
>>   *     Fill in @inode security information for a @dentry if allowed.
>> + * @getselfattr:
>> + *     Read attribute @attr for the current process and store it into @ctx.
>> + *     Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
>> + *     or another negative value otherwise.
>> + * @setselfattr:
>> + *     Set attribute @attr for the current process.
>> + *     Return 0 on success, -EOPNOTSUPP if the attribute is not supported,
>> + *     or another negative value otherwise.
>>   * @getprocattr:
>>   *     Read attribute @name for process @p and store it into @value if allowed.
>>   *     Return the length of @value on success, a negative value otherwise.
> I'm sure you're already aware of this, but the above will need to be
> moved to security.c due to the changes in the lsm/next branch.  That
> said, if you're basing on Linus' tree that's fine too, I'll fix it up
> during the merge; thankfully it's not a significant merge conflict.

I'm based on Linus' tree.

>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 8faed81fc3b4..329cd9d2be50 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -1343,6 +1348,20 @@ static inline void security_d_instantiate(struct dentry *dentry,
>>                                           struct inode *inode)
>>  { }
>>
>> +static inline int security_getselfattr(unsigned int __user attr,
>> +                                      struct lsm_ctx __user *ctx,
>> +                                      size_t __user *size, u32 __user flags)
>> +{
>> +       return -EINVAL;
>> +}
>> +
>> +static inline int security_setselfattr(unsigned int __user attr,
>> +                                      struct lsm_ctx __user *ctx,
>> +                                      size_t __user size, u32 __user flags)
>> +{
>> +       return -EINVAL;
>> +}
> It seems like EOPNOTSUPP might be more appropriate than EINVAL for
> both of these dummy implementations.

Sure.

>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 33a0ee3bcb2e..3feca00cb0c1 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>>                                             unsigned long home_node,
>>                                             unsigned long flags);
>> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>> +                                     size_t *size, __u64 flags);
>> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>> +                                     __u64 flags);
> As the kernel test robot already pointed out, the above needs to be updated.
>
>>  /*
>>   * Architecture-specific system calls
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index aa3e01867739..adfb55dce2fd 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -9,6 +9,39 @@
>>  #ifndef _UAPI_LINUX_LSM_H
>>  #define _UAPI_LINUX_LSM_H
>>
>> +#include <linux/types.h>
>> +#include <linux/unistd.h>
>> +
>> +/**
>> + * struct lsm_ctx - LSM context information
>> + * @id: the LSM id number, see LSM_ID_XXX
>> + * @flags: LSM specific flags
>> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
>> + * @ctx_len: the size of @ctx
>> + * @ctx: the LSM context value
>> + *
>> + * The @len field MUST be equal to the size of the lsm_ctx struct
>> + * plus any additional padding and/or data placed after @ctx.
>> + *
>> + * In all cases @ctx_len MUST be equal to the length of @ctx.
>> + * If @ctx is a string value it should be nul terminated with
>> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
>> + * supported.
>> + *
>> + * The @flags and @ctx fields SHOULD only be interpreted by the
>> + * LSM specified by @id; they MUST be set to zero/0 when not used.
>> + */
>> +struct lsm_ctx {
>> +       __u64   id;
>> +       __u64   flags;
>> +       __u64   len;
>> +       __u64   ctx_len;
>> +       __u8    ctx[];
>> +};
>> +
>> +#include <linux/types.h>
>> +#include <linux/unistd.h>
> I'm pretty sure the repeated #includes are a typo, right?  Or is there
> some uapi trick I'm missing ...

An artifact of patch (mis)management. Thanks for noticing.

>> diff --git a/security/security.c b/security/security.c
>> index 87c8796c3c46..2c57fe28c4f7 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2168,6 +2168,103 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>>  }
>>  EXPORT_SYMBOL(security_d_instantiate);
>>
>> +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space destination for the information, or NULL
>> + * @size: the size of space available to receive the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
>> +                        size_t __user *size, u32 __user flags)
>> +{
>> +       struct security_hook_list *hp;
>> +       void __user *base = (void *)ctx;
> The casting seems wrong for a couple of reasons: I don't believe you
> need to cast the right side when the left side is a void pointer, and
> the right side cast drops the '__user' attribute when the left side is
> also a '__user' pointer value.
>
> That said, I think we may want @base to be 'u8 __user *base', more on
> that below ...
>
>> +       size_t total = 0;
>> +       size_t this;
> Naming is hard, but 'this'?  You can do better ...

It seemed like a good idea at the time, but a rose by any other
name still has thorns. I'll come up with something "better".


>> +       size_t left;
>> +       bool istoobig = false;
> Sorry, more naming nits and since it looks like you need to respin
> anyway ... please rename @istoobig to @toobig or something else.  The
> phrases-as-variable-names has always grated on me.

Sure.

>> +       int count = 0;
>> +       int rc;
>> +
>> +       if (attr == 0)
>> +               return -EINVAL;
>> +       if (flags != 0)
>> +               return -EINVAL;
>> +       if (size == NULL)
>> +               return -EINVAL;
>> +       if (get_user(left, size))
>> +               return -EFAULT;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +               this = left;
>> +               if (base)
>> +                       ctx = (struct lsm_ctx __user *)(base + total);
> Pointer math on void pointers always makes me nervous.  Why not set
> @base's type to a 'u8' just to remove any concerns?

I can do that. I made it a void pointer to reflect the notion that
the attributes aren't necessarily strings. Making it a u8 may suggest that
the data is a string to some developers.

>> +               rc = hp->hook.getselfattr(attr, ctx, &this, flags);
>> +               switch (rc) {
>> +               case -EOPNOTSUPP:
>> +                       rc = 0;
>> +                       continue;
>> +               case -E2BIG:
>> +                       istoobig = true;
>> +                       left = 0;
>> +                       break;
>> +               case 0:
>> +                       left -= this;
>> +                       break;
>> +               default:
>> +                       return rc;
> I think the @getselfattr hook should behave similarly to the
> associated syscall, returning a non-negative number should indicate
> that @rc entries have been added to the @ctx array.  Right now all the
> LSMs would just be adding one entry to the array, but we might as well
> code this up to be flexible.

Yes, some LSM may decide to have multiple "contexts".

>> +               }
>> +               total += this;
>> +               count++;
>> +       }
>> +       if (count == 0)
>> +               return LSM_RET_DEFAULT(getselfattr);
>> +       if (put_user(total, size))
>> +               return -EFAULT;
>> +       if (rc)
>> +               return rc;
> Is the 'if (rc)' check needed here?  Shouldn't the switch-statement
> after the hook catch everything that this check would catch?

It's necessary because of BPF, which doesn't follow the LSM rules.

>> +       if (istoobig)
>> +               return -E2BIG;
>> +       return count;
>> +}
>> +
>> +/**
>> + * security_setselfattr - Set an LSM attribute on the current process.
>> + * @attr: which attribute to set
>> + * @ctx: the user-space source for the information
>> + * @size: the size of the data
>> + * @flags: reserved for future use, must be 0
>> + *
>> + * Set an LSM attribute for the current process. The LSM, attribute
>> + * and new value are included in @ctx.
>> + *
>> + * Returns 0 on success, an LSM specific value on failure.
>> + */
>> +int security_setselfattr(unsigned int __user attr, struct lsm_ctx __user *ctx,
>> +                        size_t __user size, u32 __user flags)
>> +{
>> +       struct security_hook_list *hp;
>> +       struct lsm_ctx lctx;
> Shouldn't we check @attr for valid values and return -EINVAL if bogus?

Sure.

>> +       if (flags != 0)
>> +               return -EINVAL;
>> +       if (size < sizeof(*ctx))
>> +               return -EINVAL;
> If we're only going to support on 'lsm_ctx' entry in this function we
> should verify that the 'len' and 'ctx_len' fields are sane.  Although
> more on this below ...

The LSM is going to have to do its own version of sanity checking. Having
sanity checking here as well seems excessive.

>> +       if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> +               return -EFAULT;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +               if ((hp->lsmid->id) == lctx.id)
>> +                       return hp->hook.setselfattr(attr, ctx, size, flags);
> Can anyone think of any good reason why we shouldn't support setting
> multiple LSMs in one call, similar to what we do with
> security_getselfattr()?  It seems like it might be a nice thing to
> have ...

If you're setting the context for multiple LSMs and one fails the recovery
process is horrendous. Putting values you've already changed back to their
previous state may not even be possible. We could have a two pass scheme, one
to verify that the request would succeed and a second to do the work. That
doesn't address all the issues, including how to report which attribute failed.
I had planned to do multiple settings, but the weight of the mechanism to
deal with the failure case is considerable for a "nice to have".

>> +       return LSM_RET_DEFAULT(setselfattr);
>> +}
>> +
>>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>>                          char **value)
>>  {
>> --
>> 2.39.2
> --
> paul-moore.com
