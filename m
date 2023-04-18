Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21D6E6F68
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 00:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjDRWeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjDRWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 18:34:18 -0400
Received: from sonic307-16.consmr.mail.ne1.yahoo.com (sonic307-16.consmr.mail.ne1.yahoo.com [66.163.190.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3326525C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 15:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681857255; bh=JGyo6apYPiGSMudiokyK9sWE7nWevsztQxXGHF+lHd4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=tTkBViITtOunQ7sPoIGZb7w5/W/A6Lg/6iIrMoJpj4BPvQujVyMdxrnJxugJsbAYy9Dez1pHBV2oGwCR+I6Qzs2MXPHLmc20xBI2dY81SbB0RZ286csdN1QNMa1kD4jMBtxahmjaI/hmRHivp5AoWu/pao/4Ddn/ldB3Ue3PQA7DQM5xQ20wSXjKDS5R+ltZj+RtStVzlwHVY2Lr9cvir9zhL6HO5fXvEeJ7hGYmSVcLQ9Z9ZGa+RK5tz4tQuxn7Zv00mJff0JvuPseqITbHOXuAxCvaxPEF0i7QkWeUQBZU68g1xq7SFJGeV/MaTLBHaIrkSnxqMO3p1Bp/MZOJiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1681857255; bh=Hc4eMqTDSPFU7QKxQEO+rukFDu1y2dIm99jZIwfF3I3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JYJMS1ReqzCWu6lO0D1RLdDBn5QiGJxxYAk610JHwTxZafWAkwjx++VczR1VQInh2/6E/rZaVX5L+yxoYMRggY0pFvBySEsZhrN4zXClRdU0PudEOnrv0xQiyJYbTs8Ve4t9g2dENp+TGnghuc7kGG+rStTmk/l1yvaoayU11rRrBeNuNe16B/Zk7mPlmjEC5NXK9nXCNeOSxoNHH6jfVMjpijMI+ZgraLYxKq+QsYuNcW5VlksX1eV87dkv7Z//f3Z8/v5uPixGe56P2mA+FrwdkcOpcTdZ0kGu1aiAFAwME934oogssj080IpeBWsxiLI2bzSZJBgOBfsNrjd5WA==
X-YMail-OSG: yg6JgrYVM1lQdNBszxHPQr77pat9lNhnrJSVYxOmJAHfNOrS1Svx95yKDYqs1Nx
 srM4RBCvXHSayFf6MVmucjsyIjb4deMestmLO10N4jmf7Jetl7ydlXMvBbZB.XxA6aUaKBFFO.jI
 xdtQ.WOcQ.EbqFlEe_4_GPWPvbUHDowYAMp0afI5sUD7fxTWNm9duNTVxYgaPmqveei.XIDuEg5u
 IejEcCCBS6izOkTZbZXea8sKsA53w8x1T6JUTPeCUa7wExhcppm7qyodjSJFu7RFpEYhcRNDmttK
 fvDrqpR9EVa2TUYynIxLy5w_wfYjP5eKudVAISefJrDQITD_piSN52VGAb62Z2iHv.F7G23A0swv
 d.1mwT_Ue_Dh3iw0fJkhsMSlJsa5VxFQdMufkqkW1iO0o34fpOU7pTkYJWd791b_LGChUxqMDRiD
 XlfC2U3FDowIX8KNMDjEwI4uG_s2Ct6AZxtscarEm7vrSGzIhbpFbzus_SiP42Yd9FHSfKzqx6dx
 v1h7qHun82VlGzQmv7Ga5MNi0Q.wIPOr8vDY7nh0OnvKyHIltgm9b0rObahHRoqmPrJYlsQjsCdM
 nZmby6NKa1PiyfJYFSUDQtuG0tAYLicGqIHmqMdICtailFll5xq_9QEtzOQT3HVCTLOYpKJ2ue8v
 9G_NVLE6zVpAvCHpl3LYjzswHpRxKoz3sQEuaNAI6AI0_d0yBArBtm8e8W6vgqiT0603L.XkvJCc
 9oaUIZJLBfoy9ktBPzPAW4qIzP2aANSOMRku4GG4SBQ5KpVVcbUVV3pDUqJRCk6pvmWyAc4w02vX
 PgRPiA4u5E.LS800mxE_f2CTuj2T4uEg.b3AHbhRfEJmZrxFbqeGVUzNE3Z8uUzw8fybMT.gW.6N
 D33m3FFJRk_k4cyIPjwOJeYTEFehsZZfceagDVG_XRd8uCmLltUV70yfJ1pIORdI2ysikkSyNu9l
 gVkZ8WOh.sNCrG9iYjnXabE1WwXGeRrIkM01rj8b4RClUWt9RW65EaALL.7.D0tG7zfqNW.ZZYMW
 lfS2RImaRbwPIt6Ef6Q68vaAu_VW1b85rQfbN72_qc88WsKtKfTCzz_c4LuMXChg0iQdtD5ReRN2
 6MohyP..u8D8QiJnS0ZkPSCQTo0kH3zoQbfXJ3JNGDkp.uyqZRNcHQ.UobREDoy1SPF9cZv1FvdL
 BaTNujpoQvvwqGyVrCSi6U7X7ctSqK_FrGkqcsvWjPxNY2AQ75Okoo5iStbsJgEPAf_zIXcL8S_b
 XMuYaEXQXGaeiOjDquubYvWeaaZGCmVKdCadGRpELeuX9H1wjkEDZyDN1PF3c0T.wvZO5D.3FOW.
 UAko5gq_v0J51jCCSV8Rqg3SKODIaIoVGVic_Eyw6YApA6u1crkMZQzns.x1bZAh4uKk_5.D0XzY
 F7P8PF_AnrGBi2jDhu8sxRLuMCSVW0HOnMVwhkGZkylNeyGTn4waCCFbK841zm4MATYktjNvZXR5
 8gtr_wEXYS2dKMGdhjFRll2nckTLfJcNqndNXzvLuUgrlNi0eW8cof2oCP4FlbimB7Hb_aI8lTFA
 lrq.12ifYENz2i2e_maXroX1Qd2SWm7.UaTioB.TSVyOndkEF_0a6ug3EXyf_6bTc5.TyFtWCv_Q
 nu0orMheE6sZQ_Eitj.d2RYzYmAd6VSG.hGHD0esD2vKC3eq5KFzIu.y.ykKQG0uIR1tOTQxgaw5
 Opj2QJR.UWL5.29yqGLZkvfbiMv08yo_P0dN0jB9JjcO7WMvacV0rI4EbAXmo3GAys7ABWiOne__
 izcLksqLehRBAf3ebPD2ZhN3u1MzuRF8Duan33_WFQWn3fZPVP0NOdBDuKslpJxfOQy2KccmiSm2
 m9yPkgg8YUKlHygL109NOHQYrumh.B4USLKNWnzMwlU9Yir6giuic6PaI9BSCKjCJ9eUr7N.w4gI
 0pX1J1k1sKc6woU_mko_ydrFQdZVF8ws003Tbrb5tUPp6EPmjjr7hsnrxwJk7wlpVGsbRJ.t2LYQ
 ntUrDVL2Y6KgjUfBCNz_rKIUahYSIb9oX.UasfttlyLNZNnuQg.gQxJkXLmEGQlese3cjAI9LeVK
 DT4sUFmikS4YxwS8yOjVJZiLi1q4oqARmvhcvrRrMztQTK2eUno_pFwIyHC0kTx2YXLip0JHHgB9
 M0RMMS4AMisVGVHvQuSbeAKQxYyzGgHrjNGNaUEgKj2p2xYmglvy4EnuMM0.jZvFFREYMghaecCy
 dr.e6mOAILBwR5PmnNGiWF0Bf0sjtkwZTDpSsXgo7Jbvc2SdbKoi53FE8HbjcjGsoMUyGRXBO.Ul
 QjdV2ZPo31A--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: bf72be51-c9d6-4989-9fc1-077dae8489aa
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Apr 2023 22:34:15 +0000
Received: by hermes--production-bf1-5f9df5c5c4-5d8pl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8df9cfeaa30a726e1a994a50b769cc8a;
          Tue, 18 Apr 2023 22:34:10 +0000 (UTC)
Message-ID: <5f7ee090-1708-c5ac-d194-1cc5c69487a6@schaufler-ca.com>
Date:   Tue, 18 Apr 2023 15:34:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 04/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20230411155921.14716-1-casey@schaufler-ca.com>
 <20230411155921.14716-5-casey@schaufler-ca.com>
 <CAHC9VhQHxEzv9bQJQzTiSQZvGiMO86+HizRtaR=2LW=KwsDvfg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQHxEzv9bQJQzTiSQZvGiMO86+HizRtaR=2LW=KwsDvfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 2:49 PM, Paul Moore wrote:

> On Tue, Apr 11, 2023 at 12:01 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call lsm_get_self_attr() to provide the security
>> module maintained attributes of the current process.
>> Create a system call lsm_set_self_attr() to set a security
>> module maintained attribute of the current process.
>> Historically these attributes have been exposed to user space via
>> entries in procfs under /proc/self/attr.
>>
>> The attribute value is provided in a lsm_ctx structure. The structure
>> identifies the size of the attribute, and the attribute value. The format
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
>>  include/uapi/linux/lsm.h            | 30 +++++++++
>>  kernel/sys_ni.c                     |  4 ++
>>  security/Makefile                   |  1 +
>>  security/lsm_syscalls.c             | 55 ++++++++++++++++
>>  security/security.c                 | 98 +++++++++++++++++++++++++++++
>>  10 files changed, 240 insertions(+)
>>  create mode 100644 security/lsm_syscalls.c
> ..
>
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 33a0ee3bcb2e..97487d66dca9 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -71,6 +71,7 @@ struct clone_args;
>>  struct open_how;
>>  struct mount_attr;
>>  struct landlock_ruleset_attr;
>> +struct lsm_ctx;
>>  enum landlock_rule_type;
>>
>>  #include <linux/types.h>
>> @@ -1058,6 +1059,10 @@ asmlinkage long sys_memfd_secret(unsigned int flags);
>>  asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
>>                                             unsigned long home_node,
>>                                             unsigned long flags);
>> +asmlinkage long sys_lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>> +                                     size_t *size, __u32 flags);
>> +asmlinkage long sys_lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
>> +                                     __u32 flags);
> As pointed out by the kernel test robot, the above declaration is
> missing the @size parameter.

Yup.

>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> index f27c9a9cc376..b10dfab8a4d9 100644
>> --- a/include/uapi/linux/lsm.h
>> +++ b/include/uapi/linux/lsm.h
>> @@ -9,6 +9,36 @@
>> #ifndef _UAPI_LINUX_LSM_H
>> #define _UAPI_LINUX_LSM_H
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
> Sorry, style nitpick since this needs to be respun anyway for the
> syscalls.h fix at the very least ... I *really* dislike when variable
> declarations, and field declarations in the case composite variables,
> are aligned with the vertically neighboring declarations; just use a
> single space please:

I'll do it, but the tab after type has been accepted for forever.
As an aside, I pulled out my 1978 K&R to prove my point and discovered
that it isn't consistent regarding this style.

>   struct lsm_ctx {
>   <tab>__u64 id;
>   <tab>__u64 flags;
>   <tab>__u64 len;
>   <tab>__u64 ctx_len;
>   <tab>__u8 ctx[];
>   }
>
>> diff --git a/security/security.c b/security/security.c
>> index 38ca0e646cac..bfe9a1a426b2 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2167,6 +2167,104 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
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
>> +       u8 __user *base = (u8 __user *)ctx;
>> +       size_t total = 0;
>> +       size_t entrysize;
>> +       size_t left;
>> +       bool toobig = false;
>> +       int count = 0;
>> +       int rc;
>> +
>> +       if (attr == 0)
>> +               return -EINVAL;
>> +       if (flags)
>> +               return -EINVAL;
> I like Mickaël's idea of supporting a flag (LSM_FLG_SINGLE?) which
> allows one to request a single LSM's attribute.

I don't, but I'll incorporate it.

>   I don't think that
> support has to be part of this initial patchset, but I do think it
> would be good to have it in the same PR that goes up to Linus during
> the merge window.

As this patch set is intended to be what goes to Linus (isn't it?)
I'll put it in.

>   If that's not something you want to do, let me know
> and I'll write up a quick patch on top of this patchset.
>
>> +       if (size == NULL)
>> +               return -EINVAL;
>> +       if (get_user(left, size))
>> +               return -EFAULT;
>> +
>> +       hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +               entrysize = left;
>> +               if (base)
>> +                       ctx = (struct lsm_ctx __user *)(base + total);
>> +               rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
>> +               if (rc == -EOPNOTSUPP) {
>> +                       rc = 0;
>> +                       continue;
>> +               }
>> +               if (rc == -E2BIG) {
>> +                       toobig = true;
>> +                       left = 0;
>> +                       break;
> It just occurred to me while reading this that we stop calculating the
> potential lsm_ctx size after we hit the first LSM where we go beyond
> the size given, `rc == -E2BIG`.  I realize that the required size may
> change between calls to lsm_get_self_attr(2), but it seems like we
> should at least run through all the LSMs and total up the required
> buffer size, no?

The "break" should be a "continue". Artifact of an earlier version
that had a switch statement. Fix forthcoming.

>
> I may have missed something in the snippet below, but I think the code
> change should be pretty minor:
>
>   if (rc == -EOPNOTSUPP) {
>     rc = 0;
>     continue;
>   } else if (rc == -E2BIG) {
>     toobig = true;
>     base = NULL;
>   } else if (rc < 0) {
>     return rc;
>   }
>   left = (toobig ? 0 : left - entrysize);
>   total += entrysize;
>
>   count += rc;
>
>> +               }
>> +               if (rc < 0)
>> +                       return rc;
>> +
>> +               left -= entrysize;
>> +               total += entrysize;
>> +               count += rc;
>> +       }
>> +       if (count == 0)
>> +               return LSM_RET_DEFAULT(getselfattr);
>> +       if (put_user(total, size))
>> +               return -EFAULT;
>> +       if (toobig)
>> +               return -E2BIG;
>> +       return count;
>> +}
> --
> paul-moore.com
