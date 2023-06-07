Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94377272EB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjFGX02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjFGX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:26:25 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com (sonic313-15.consmr.mail.ne1.yahoo.com [66.163.185.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD86212E
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 16:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686180382; bh=58+OuVBGiwtTJ7F0rUcvXahP+dPB+lPXSghR/JOMQMk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GyYa26gbfmfLEYAW/IllP7QoIzdsuPMNS07RjUO4ly5qW+iorM1VJHN5QSf+cbzHxj/sCC9HOEQKQTUWqURwxGeyXzYQgtK0gONeIIdIFS+DvbeA3qNN9SvBF5EkT2xSDlXqK7s6ke5el978j7DHXg1XgSJHsmlIpnAhgmMykqqz0t4vvtUQnYsire/X3fugxnIioX2d1qChcARqpt3FtQ8MZ+ML0xDzlJ2aN1QXFf9kc5mxoYSbQmegySvO4ujOpVh7NLzmXJ02Ar5hhlCQBxNePOQKy2/GJyANLhrJRJvs3kJJ4aZgoYBGC4ixCpcAdgdRUyJH1jRkZVw3jq5jXQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1686180382; bh=yaOeF+/Ktx3bC/EH2m2ouMRRG2bAxJ5nzK6RPpk0Ckv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Zh2y0JyLkUfrlSXeQCMUxB98lb9y9mdmmUQatSciH6GvBbTgdd2YKs6plqPN88VT+JGxl0b8yRxzcGpUBAeGHK2AQJpDWfxvpjH3M7s0rKxSJNhBWF+3WeIQ2OL3uUJsy2ASr2YOYMsINSQK03/jsMDbQnlbanhSdVumeJT+6CtiD8P8EfxcWgFS/vvPQAqWNS9mPmIZfYjNGRoTyN5e6ATjdPuHKpaHyeaeHMEMGrtE5kdTALctKLacrRq2GLOR9qcrYqPEtjycXO3X04JYKh4KHf9hT+5f+Cce16q39bypjLmP9Th7YkHhJjtG/5jLfwP8kqPiE2VAZV8iyzz5xQ==
X-YMail-OSG: V5gBNFUVM1lVYHsUBze84NItyB9mdHskGnLvW9ywe86H.Ml4F3CcJKFHU7X9xfC
 MAVXCjApcg0jURNyY4PCTR0IpfKQCTcE2.UI1VsyVbzbdomud5Z378TD7782cvs2sAxM.0lwUbaO
 1Pxg7xAM8_P.Eg9cjXNP2yQH3AEfZLHCP12t7reCNtsbWZPciGLUkp57Y_5QXsFrdr7yuznySovY
 qouqLz9Ttkppg.sBnDi.PmtCXKFkZrJOUI8KjlgCCOPG.JVXtd67LLmdSMx9XB9qR1lAmA5bVV_l
 Q_gmmwK8IbDAlxA_dKm23TWsZC13kz0TNDqv_UqxHIp_X7mO4yVjt58L2K7uF1JRjFkj5.d7wSaP
 3dg4VXQnmF9RQKSSJW868d4gJpVSMQeM09rK2Nn2nNpNHQ9HsTurqss9eI881YckaYkgUmkglV8g
 .r2sRXmKlzxVaxQNUK9eCS_nFc13Hciln8MRIYZmFpE0D7h4CG7_7A14XHisVLRsIMoEDGAAXYTi
 NTb45lDVHijGhPPlM4CQ8wYlakb50vGPrzJTbItMVh4b2rSWGQ3xjVZcNyxAyHjzymsqTooyFH3c
 yI3TYwUfXEgjkLnxIBIrD.uL847vICIWjtt1oz.mbPaOV.Bw2qUDf7FeBlrhb50j7AWYMuWaJkiH
 THMCaA5L76fMGoT9n8YTVWmjQTPRk9o2fvw4J2heLQd015lF6MhmTeA11MRVsN6LeVi8SxTtQ1hc
 y7fCXypA8d5zw94rePJGb9T8pAOVDHP4pLAYo5YJ79eG.kNmAJ0TbCjY1mTO6GjcKqm22IMxOiIp
 a9JdtfekQ7XhClieBYhl1fJjhkSk_x.nRz1nlDHANC6bP5DyQ7HlBukr_oKr_wlDhCPGNgP6dASd
 _dvfqjVS1AzGh6si2G4SYr5eEWqg9QnegY2YX9T55piCq6ZR3Gp4UvGQfqQAng9bf4M5nADnEACx
 t7D7jsD8MRg9jw_CcZHFr0pupKSw0lf87fYxYvanqdsjJfmftDbnJb82B_ZajO61v4EdQU0JoiZj
 TaJMK5RsWWIAOOmk6MY3_yesHE8HTGzPlPyMbw2XoamkeK63f9T4oTWGshFzT0Z0vA79t5Oi3SU5
 M6gxe.KOiutiUQ3yWOnzGN7ljrX3VcmJQ.UOMFw0n09CY5IyviLBLXbwNSbsGEWApqz9.2ax3D1_
 fqiSKLqy08VGQq7m6XqMvJaMkWZu82BndpRP82OX7fhxx5C4uaTZvaQa.RlwK_I9kd3hjNs1teXt
 gs9DQQ_XXWHsqXHyyX5LMbzX60qLZOciy_UYfN4Q_RyrN1BEGRQ3WXudycdxAr3t9UI7ci6sZPY2
 p5N9YQxj3dyEKq4apRl.v2SbhNnFEvn_0Km2jlL9vGZOB7.DKGafQyhAdar3Phxj3VyxJV0YEmCk
 8i2G0LNIflaB.WttimvnpMdi.W7HibwcJss3cRiJOV1rwcSoP_Q58HDO6VRFgnps5vx4fEYa10g0
 mBIPFre98i76fEMs6qMgHJiiB_7WkY8ejo2A49iyWCKR4EHMlx9qtJ_wGloAOE6EG65UTw6Ez35V
 pH6Y6UOOEctuIF1_x.8DHJIe269DTSCHHRprWqQPCIFNfvWpiK_GVGjEPn8dkKf0999ksNHQQX6W
 TDMwwezq8rXfmHduu9rGtjm.jpDaCA8X_omnB3919zEgUjqpCgJwO1tmdpGxVJ769WIUSCpfJnOU
 joeiwHb_Cy7t.hmWYcgxr2QdBn6BmU8IZCyKC27vuvce6aKI1F7_7MHT4qnEg2189zHISLzfbsHH
 AQA.fEIMtN9tN9oVvBj88ZYjFHc49EcjHc.Jde3RUIdbQEzPmBKGkpsrcAkFbMaRK7tcfEv7lkGL
 L6nqyOcioVqlajrAHJRKX_V83R1XZ8qYnRMLhfKSvCmzsrDUYmywYbjADGs53HbGdz6zDGMV_q.e
 KTESSneY1C_YkdPHucoyIU7Ejho7aPQ2bCL0_3G4Pfc8UiCbolaAoxrZgMAUxb15nUv83fySfKyf
 sS6K9AyethHLbtf2RcRue7en8leJdgAE3lrnBwrz4Vx0YGD4OE0Z.a3_2YekK9..n04zk_o14K7f
 715fj13Pacvbw.sV2W.QKk2irAGWeDogg_JCWMwhDm99wdkhYe8uAoKpgkJMf5Q2dc2rOqtgv.mN
 Pxi_pjx3CskfvDiBxPk1ynWPnbHx9ndjRHb_fjxvCkpaQkwS6j2aZJCHchs4Sqb7tR4vn8PVPXn7
 Fvx_W_Xy2KpjLcMsqYeSrtFdOFv.tNg7u1gtsXpu1h3JHwd7Y7wfEMaMojeRaeNfcKjYZ.x54.cb
 NVu6UfYKBVw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 29693f2b-bcc3-483c-9f56-9e08dd086dc5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Wed, 7 Jun 2023 23:26:22 +0000
Received: by hermes--production-ne1-574d4b7954-wtfnl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ca6bf50bc6b7ef6d3ef9b0aa6c9b35aa;
          Wed, 07 Jun 2023 23:26:19 +0000 (UTC)
Message-ID: <c00759ec-52a9-2fb7-e7b7-683257a5c25b@schaufler-ca.com>
Date:   Wed, 7 Jun 2023 16:26:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 4/11] LSM: syscalls for current process attributes
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230428203417.159874-5-casey@schaufler-ca.com>
 <76f37cf7b20b8c63cf78d4ddca5a7375.paul@paul-moore.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <76f37cf7b20b8c63cf78d4ddca5a7375.paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21516 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2023 3:32 PM, Paul Moore wrote:
> On Apr 28, 2023 Casey Schaufler <casey@schaufler-ca.com> wrote:
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
>>         __u64 id;
>>         __u64 flags;
>>         __u64 len;
>>         __u64 ctx_len;
>>         __u8 ctx[];
>> };
>>
>> Two new LSM hooks are used to interface with the LSMs.
>> security_getselfattr() collects the lsm_ctx values from the
>> LSMs that support the hook, accounting for space requirements.
>> security_setselfattr() identifies which LSM the attribute is
>> intended for and passes it along.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> ---
>>  Documentation/userspace-api/lsm.rst |  15 ++++
>>  include/linux/lsm_hook_defs.h       |   4 +
>>  include/linux/lsm_hooks.h           |   9 +++
>>  include/linux/security.h            |  19 +++++
>>  include/linux/syscalls.h            |   5 ++
>>  include/uapi/linux/lsm.h            |  36 +++++++++
>>  kernel/sys_ni.c                     |   4 +
>>  security/Makefile                   |   1 +
>>  security/lsm_syscalls.c             |  55 ++++++++++++++
>>  security/security.c                 | 112 ++++++++++++++++++++++++++++
>>  10 files changed, 260 insertions(+)
>>  create mode 100644 security/lsm_syscalls.c
> ..
>
>> diff --git a/security/security.c b/security/security.c
>> index 5a48b1b539e5..94b78bfd06b9 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -2176,6 +2176,118 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
>>  }
>>  EXPORT_SYMBOL(security_d_instantiate);
>>  
>> +/**
>> + * security_getselfattr - Read an LSM attribute of the current process.
>> + * @attr: which attribute to return
>> + * @ctx: the user-space destination for the information, or NULL
>> + * @size: the size of space available to receive the data
>> + * @flags: special handling options. LSM_FLAG_SINGLE indicates that only
>> + * attributes associated with the LSM identified in the passed @ctx be
>> + * reported
>> + *
>> + * Returns the number of attributes found on success, negative value
>> + * on error. @size is reset to the total size of the data.
>> + * If @size is insufficient to contain the data -E2BIG is returned.
>> + */
>> +int security_getselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			 size_t __user *size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx lctx = { .id = LSM_ID_UNDEF, };
>> +	u8 __user *base = (u8 __user *)ctx;
>> +	size_t total = 0;
>> +	size_t entrysize;
>> +	size_t left;
>> +	bool toobig = false;
>> +	int count = 0;
>> +	int rc;
>> +
>> +	if (attr == 0)
>> +		return -EINVAL;
>> +	if (size == NULL)
>> +		return -EINVAL;
>> +	if (get_user(left, size))
>> +		return -EFAULT;
>> +
>> +	if ((flags & LSM_FLAG_SINGLE) == LSM_FLAG_SINGLE) {
>> +		if (!ctx)
>> +			return -EINVAL;
>> +		if (copy_struct_from_user(&lctx, sizeof(lctx), ctx, left))
>> +			return -EFAULT;
>> +		if (lctx.id == LSM_ID_UNDEF)
>> +			return -EINVAL;
>> +	} else if (flags) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.getselfattr, list) {
>> +		if (lctx.id != LSM_ID_UNDEF && lctx.id != hp->lsmid->id)
>> +			continue;
> I think we're missing a copy_struct_from_user() call somewhere; how
> does @lctx get populated in the non-LSM_FLAG_SINGLE case?  How does
> it move to the next entry in the buffer?

@lctx.id is initialized to LSM_ID_UNDEF in the declaration. In the
non-LSM_FLAG_SINGLE case the lsmctx.id != LSM_ID_UNDEF test will always
fail, thus avoiding the continue. It is only necessary to do the
copy_struct_from_user() call in the LSM_FLAG_SINGLE case.

> Am I missing something obvious?

Yes.

>   Was this code tested?

Yes. See patch 11/11.

>
>> +		entrysize = left;
>> +		if (base)
>> +			ctx = (struct lsm_ctx __user *)(base + total);
>> +		rc = hp->hook.getselfattr(attr, ctx, &entrysize, flags);
>> +		if (rc == -EOPNOTSUPP) {
>> +			rc = 0;
>> +			continue;
>> +		}
>> +		if (rc == -E2BIG) {
>> +			toobig = true;
>> +			left = 0;
>> +			continue;
>> +		}
>> +		if (rc < 0)
>> +			return rc;
>> +
>> +		left -= entrysize;
>> +		total += entrysize;
>> +		count += rc;
>> +	}
>> +	if (put_user(total, size))
>> +		return -EFAULT;
>> +	if (toobig)
>> +		return -E2BIG;
>> +	if (count == 0)
>> +		return LSM_RET_DEFAULT(getselfattr);
>> +	return count;
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
>> + * Returns 0 on success, -EINVAL if the input is inconsistent, -EFAULT
>> + * if the user buffer is inaccessible or an LSM specific failure.
>> + */
>> +int security_setselfattr(unsigned int attr, struct lsm_ctx __user *ctx,
>> +			 size_t size, u32 flags)
>> +{
>> +	struct security_hook_list *hp;
>> +	struct lsm_ctx lctx;
>> +
>> +	if (flags)
>> +		return -EINVAL;
> Once again, I don't see a reasonable way to support setting an
> attribute across multiple LSMs, but for the sake of consistency
> across both the getselfattr and setselfattr syscalls, what do
> people think about *requiring* the LSM_FLAG_SINGLE flag here in
> the setselfattr syscalls since it can only operate on a single
> LSM at a time?  A zero flag value would return -EINVAL.

Requiring a pointless flag seems like an API no-no to me.

>
>> +	if (size < sizeof(*ctx))
>> +		return -EINVAL;
>> +	if (copy_from_user(&lctx, ctx, sizeof(*ctx)))
>> +		return -EFAULT;
>> +	if (size < lctx.len || size < lctx.ctx_len + sizeof(ctx) ||
>> +	    lctx.len < lctx.ctx_len + sizeof(ctx))
>> +		return -EINVAL;
>> +
>> +	hlist_for_each_entry(hp, &security_hook_heads.setselfattr, list)
>> +		if ((hp->lsmid->id) == lctx.id)
>> +			return hp->hook.setselfattr(attr, ctx, size, flags);
>> +
>> +	return LSM_RET_DEFAULT(setselfattr);
>> +}
>> +
>>  int security_getprocattr(struct task_struct *p, int lsmid, const char *name,
>>  			 char **value)
>>  {
>> -- 
>> 2.39.2
> --
> paul-moore.com
