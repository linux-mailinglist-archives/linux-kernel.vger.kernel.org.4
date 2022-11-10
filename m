Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E29A6238F5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiKJBhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiKJBhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:37:21 -0500
Received: from sonic317-39.consmr.mail.ne1.yahoo.com (sonic317-39.consmr.mail.ne1.yahoo.com [66.163.184.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEBB26ADF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668044239; bh=LJCSwMNKftyO9ucc9JDF4Pz9lX34xM1yQFYF+i+GufA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ZMDTSwvT4lJSoRjAr7GGFZkRs9cOgYaxTyyf+Dealt0ntTp0UnxrOdN+DKC7xkPFPo/JVhYjv2sNj8lq58vru9ca10y2yxMXYNnjjgtd5ipe/k4YVt6MTlqM/iqSlygRXAHYdcYzW5nxIhEKywO7GIYm9QJ2LmL9lOSUJ95LvkUPe8sUUtiZotsVUwDfeSQStzMQzSlMGZqPHzxv3SP9bJOO9McL/jM/E12aglbHii6cIP7WIGJ8LybrtZQDiiSBJfEvZ/Tv/QnTca2oKSR+gJ3cTl/gMP2t5zXC9PIN2RX9WbSVp73ph/3IAiCwBE+SQ9ropuNBdu9+Zq+x8Y35xA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668044239; bh=jtC0rMVoqTK7JdeVfkcVHQTivK8kc7vfermot8UbXZZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=DaOgYP3gSrBcqN+c3MU8WrFGnPurpgRD10eLGkPC/9EU7BgtEVDneNkX4RaS6f+DG3eLxkl42j3Er9UHyqx5cvVKV+46S+yxqtCWMQASxlWW9U6tbkFxgK4I5sOszeHqZ41c4CdWv5AaAUyWkq2OS+STKTQxrPsqc1jLdGXwkJHlHa4dSiS3AgYHlIevRYYUBiUfvI49vKNBC6fqMsxcutoEOrPnlSB8FbY2JRywP5nGAM0xqkwo8FpvUbS7qQJ9bBczsPuXs0nI+e2wz+VlQJjI11tpdNwiWUklrzFUI6ybQP7d6I9qfEtTGmy1IRiVL5fsLcLVyXQEdYwDvOCalw==
X-YMail-OSG: 1mXZuJUVM1mntvDOji2aqL3aQ.iRL.bKgZ_X3Bb3zMyUWawZsNwhRvoFILDbIqy
 Bp1QuMU6uOJzj5XJ7SBQDv4mGvX6FMyTV1DPFpGOGBH9BvhB7IcAQvY_UTT0DpSH1rbkeUo.Ce9Q
 gxWEv_hjnJ5FSYjUs1g3v7CjQPA7BRKuWExl955HXPQtX6PFq23XTMb1pDpQrDBo6_JuqNtGafVZ
 BphUIRRLWggCMDi1dlZ9OSk3a7LnaFCVxQw9OsXpupQUVbwrLAno9d85NAr4ilNKJmUD4tlqYwcS
 sJ83GJq3N2xvqPDsvn1czhSOimCYG9A.QJM6rGUuhfJmczxkUF_Z7y3inJNNuFQCkFOQls3_qcT6
 GWXSpX11uoEnUP8cLxyz8W_6bDDM5sTk7rFZ4zW2nOnoNcr2F0kT.sP.NziTO_N99PE2NZ.uPl4F
 dtc5OrjKkieGXHZHPCq9eeELeC.EUfMIQ2.vIOzHMxgw62kOvKEO9W32KuSFt8rLhmC7cNXmAy2r
 FZDwB.owM5NueQkp8mYa7tFLBA8goIKKQj_70UV9tf25zWVOUeqWXNwXOIuzHevXrvVH1SGjoQ5k
 UOy_Ys_EIVKxoPWhyiKjbF0WpH7SN.05FbdaOmuPrHkxH5nZT5MQn7Vneu_CNNGU3cTNpvbE8hSK
 HtwEbYy.yhCVYK56y.7QfkdZVP_g30IfPt0wwx_h7VI4yiVzhnB7OGrjOYCyoUFwqZ29YIAAlZ92
 4uDU4COv1.D.qWCSsjCHfQu7Rx9SuLRirblog.kl1BYdbazzGUUdx0FCzYD1TTV6K5CnBX3K0D.Q
 _L1rnJivMy.eV_DfNRLVqhzkzCKXFspPNdC0L1JjPRC8.kLoV9hw.Skdrm0Awwssuwe0N157JO66
 6PxxXVog9MwMMVrkXZ0nZTqX8xCVA1fzhQDZGuZK5zrZX9gc.nrjF61OhY_L_6XCdE_s5THiGMua
 d_F1BBW_zZA8.5SwjCWcivDoIEuR5Pvm00saAcbAMecG8Z6lEGbmJVz8belgSLU_eFQml8BFMWNw
 9SSsfZ9VnNg9Xck8_y1JXV7d6DAFLd.Qe_lkEnSotMsSOEbFKTvjddXlQ6Hlhp6OTnbhOqAiXUV0
 W0AvRIzPWe38fD7GU5ePSO8DhkDLSMtc70cetuq2p8gMdWJi19IkTu1.5mRFXI8hha7H3HKtJWNi
 meupjqkJffkkhMp5iCj4zwcf8hGIqEAo._P3uy5F_XzsfRYY_rCGg1qLwE75WuJtHXZ3AeQo8YLf
 bJ.Zqe11CNfAx_D3H4z9ZUBA.gNK2WTr473Th7mVqBeNlPsxKlPosnKxwgGH_F51ZoFVp9y_Ba.X
 LK7FsRHUrwkapOP4f2SE5MmMXKV8VFUNxUR265t67lg.6iYKj1ZGTH0xZZBIturzqmmvgCgrTIUI
 g9lPCYYMnCxIfpjHDR1wHJJfOGItQUhk9gXbTiAJFZSEqU6tgBO1e8aBtSDP8QzuU8JuTTIx5Bhs
 WCmjkFbx6ENsPQdhhdxG6xZENmgCiqF5ifmLlujyd7UgWU9XYpsyiaa_D_9WiE51.8BVTuD4XkYF
 ipHCOFTJgJbKtI0iDz1hcC_FLe0mqnsmj3.PvA.WBF.hAC9PjTAEDLbHHLb6njPiGZpk4DvuGRCV
 Rhl.P4buWbbXnO4wy_UWnojeBa5kC47DrgV1t2_D6lwmjaVckBxVwsjBTquodpNnA7f7PHKVOKeb
 LmXhK2x2p77RcECyYzNKnTMrav2_iy5pANsG0_BghbFGh.B8GAK4hK7Z7nLnawuleevMqzk2t2WV
 HLUYf8teZ.5HM3HU1RBnp9jukEUwLl0p8x4whvdqM_OmFxJ_1D5_7VfnKBTMimqX8FCnQUWJ77fq
 LNnHk5bZPZB0o8IJ.hnnS1VwjRGn5gDyvruJUN39ZD78YE_lI06QR_mGTiuJl1r23RETU6w.ZzB1
 K79F1370K2WqbBJZh6h3zXOMiW0rnNE5K17SSZXoRM0BVuzJ8fg4fz7XoBevWST9iVFDzkFkytjJ
 .s9lmdewGGHFoUiZ0zbD7QGe1kHKATpQseQkm2.Iq2jRMYXl4l1rctpLSc2BKvMVsWyr2q30Fmu6
 T6ZyrewOsakEC3429dTmNzdAOjNRQwXAl63tKfKQXy31LSy5spxELsa0ni0nDGKw5PnI6gQZpu_L
 ToaNZ2Rt5voQC0bxHYcJ5NUvZ9J_Z7agpbodyK6OW9cYVj_wCqFn7r5o5JDVQK2ptWajLNKgquPn
 bFqE_Jfb603KUhe7afzuxU168upYG
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Thu, 10 Nov 2022 01:37:19 +0000
Received: by hermes--production-bf1-5878955b5f-tg9fx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 531384ef438ad64b797b020e20564acd;
          Thu, 10 Nov 2022 01:37:16 +0000 (UTC)
Message-ID: <ea927e49-0099-df0a-d263-400782486b35@schaufler-ca.com>
Date:   Wed, 9 Nov 2022 17:37:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 7/8] LSM: Create lsm_module_list system call
Content-Language: en-US
To:     Paul Moore <paul@paul-moore.com>
Cc:     casey.schaufler@intel.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-8-casey@schaufler-ca.com>
 <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhQ5Jrt3Ns+m7DFZ+_pP81AWqSx588HMZR+7MUuMfSZoig@mail.gmail.com>
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

On 11/9/2022 3:35 PM, Paul Moore wrote:
> On Tue, Oct 25, 2022 at 2:48 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Create a system call to report the list of Linux Security Modules
>> that are active on the system. The list is provided as an array
>> of LSM ID numbers.
>>
>> The calling application can use this list determine what LSM
>> specific actions it might take. That might include chosing an
>> output format, determining required privilege or bypassing
>> security module specific behavior.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/syscalls.h |  1 +
>>  kernel/sys_ni.c          |  1 +
>>  security/lsm_syscalls.c  | 38 ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 40 insertions(+)
> ..
>
>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>> index da0fab7065e2..cd5db370b974 100644
>> --- a/security/lsm_syscalls.c
>> +++ b/security/lsm_syscalls.c
>> @@ -154,3 +154,41 @@ SYSCALL_DEFINE3(lsm_self_attr,
>>         kfree(final);
>>         return rc;
>>  }
>> +
>> +/**
>> + * lsm_module_list - Return a list of the active security modules
>> + * @ids: the LSM module ids
>> + * @size: size of @ids, updated on return
>> + * @flags: reserved for future use, must be zero
>> + *
>> + * Returns a list of the active LSM ids. On success this function
>> + * returns the number of @ids array elements. This value may be zero
>> + * if there are no LSMs active. If @size is insufficient to contain
>> + * the return data -E2BIG is returned and @size is set to the minimum
>> + * required size. In all other cases a negative value indicating the
>> + * error is returned.
>> + */
> Let's make a promise that for this syscall we will order the LSM IDs
> in the array in the same order as which they are configured/executed.

Sure. Order registered, which can vary, as opposed to LSM ID order,
which cannot. That could be important to ensure that applications
that enforce the same policy as the kernel will hit the checks in
the same order as the kernel. That's how it is coded. It needs to
be documented. 

> I'm doubtful that only a *very* small number of applications will care
> about this (if any), but this is something we can do so let's do it
> now while we can.
>
>> +SYSCALL_DEFINE3(lsm_module_list,
>> +               unsigned int __user *, ids,
>> +               size_t __user *, size,
>> +               unsigned int, flags)
> --
> paul-moore.com
