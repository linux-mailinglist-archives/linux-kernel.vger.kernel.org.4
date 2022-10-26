Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF01960E912
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiJZTgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234763AbiJZTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:36:45 -0400
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F77A814DA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666813001; bh=fgyo2ISY3OAsGAQIUHFMsA2y9yvPMn9uSWbL47QxgxA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uTw2h70iE/0PCD7KKMkxLHTtgAoTGrE5zsq+ZBQoedItywpfJrL6SYgLxfpBnLMw6Thl7JKq/8LntfQ/knJv4LUxgmH5qH/GmusYgjflF0lJzLndr9BvY6oGucrYSbKEUongwy7WDWjcK6kbYn7H+MXyQ6NBSt6+r/+m1wRf8i+h0XI9qHg/VRQCSKqLcDlhWiP3h1jgZZDe9dqDTm35r5COaPClVY5PgL5f6yoYNGe3/u4PhcaVSfd5HP5lfODx3aaxZC2ykOI8jWWaC+zl6enoYKUArFdWbgwxBex/tRotca/Jd+/vdsWfFuFxEDjO+Up0SiwtEbhvxE+DmlZ40g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666813001; bh=XORoNFgByCE8mTnxUG6iFHtoEpoZrKyHEA68/kkIPxD=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=t+zIjAP5vbgQdmLR2xrDnQkEJUj0Kwf0b+TRGgingAkT4bIT3hIlObTYOxHD9XbBAudtOoj8HocP+d8IOIS7wTTMC+sSeUNP47a5fln6hIP4mUDUUKPxLwKoDZQAfjjeyip8amyQsY41fEioz/h/Orrmr6KxPF7JZUsBTYqdrhHhDbdyXvWYmMNvYam0yLZl4bHYMLJxImjtcQqvmRKH+5iyJjeu03GjQ9JxJcfeHi9LW1S7p7ta1vDvgrGz4UKHCxN6L0UjFtAKdUhGP1lxD+iUC2r+f4iAGln0TyX0miEpGNMPaCwbsmD1NvYuIsoKtyWBoJoVcOs/JOigSm4ENw==
X-YMail-OSG: AcF0dHUVM1lbkt5gX5hDUE0dbPop16EuKUO5obC9.AaQT86FBILl_UN.TYJlbMs
 Kg4LKXY6YVinaHUb6rNs5uCL5NOgnWTqB5NdbQVNx.dAq0wWQAoavhotUfkGuu4PvI5oys6x2odX
 jBgBBeq96ApUNFgN.J1radWcIcVhlafkzHOCZ5vypQRUQR9IXxjPLhXiTKoB98uIukk4pwBPM11L
 wM4FP.G8tTDjB2O3bzlyc4gU.Dy0M0f5rvrRPELdbKDC6H3WAEuxuIiOad3RErKIlcwiqHnl5yPY
 ze_C5bcx8xvub34zLiNmPfMLIfEdqI1qqjDH0VF9rN4YGeaywh6zczKjF3Q45CsAGHtDZFVWWvK9
 gZvCMV76q7e4poDnE_32_jmRiuas1SbzmsszNZEBcV_OmV.jWHchwpLWoFuQ8oMhHqL7Ijrt9qeq
 NtnMo5SoSAi2luDso5Q4GOEft4VWJZPlRDLSqSHz9dHPKXF_iU_9wj.c41lofn5c.S7IpPUs85MF
 dH52bxflrFcJckAgAqcyi0EPXsqE6Ef6yZh69bvnsfGFvuSlp8Qip731OdZLZTOogZ5xKc0Botbs
 g622dUa1R1imzIPWc3m5IAysMqqIS5_dis1mD9rcdQEcOECa4T03Sks06Jj367.68_Qv_jREySIZ
 VvBOxlYQyVwwUiTF2CrShAebQs4MU8XVhlZESCwqi57kgsyD7JUU7cbOmv0.QPyMDmizLlTE1Eq7
 n4C36xKuNMYcvIQqmGHLB_PIJwQzLrO61DbmdhODARGSomz5DrpZzL7qUzww.ErhwGb64kavx1qh
 JL4d5kkiWpuL4RRPaumNitlU5Altz9dAUgyD.FRV0A2s5wYZe0wcLfpvJWhyN3hJFXe2sRPUaZDm
 1pfAFFtF9jlyj91VJk3V6CwltC4QuKoY5odMPenTIpY3yS4U9ps_8Cw9QeouY11AugCq6BRI1Or1
 F0jI8zPe63.PC5PQSW_cLPyaGHGCv3O0Ssu3J1FslFFWD5gP.Y82eLV_hoEHVAxIrIomf9iudzWy
 OGh969pMXfzWubO3m_KCM30PZ.pc64U7GZTu8I8Prht8SSH557zuimExq8n_KR0ScMHy70qKlrqW
 AbeT9_tvzmraVmwYhKWgvr8oABCNe7blBUaamLigtl1fC2Ke.AoIBWA7H.StNuwDApwQPXoPqYoY
 2xTwohVP6ZK9l65GyMboLkt_si2hYk7FvQzZY9ouYhd0B3zASgV6QGsQN6AtSRpnivgZQuyJ.a_R
 jh79r9znqnoUeURIi2TafsZNraM7AFqNCXFq6OOOn6ROHYaCI09KM.zwz_qmSqQxHeOk4BXf54VK
 hnNMX0UuaK5UfgKuEusXi6rA_K7muRmgHqBVhdYWkL6QfQZNE6.EKBPOgfjLLkCd7JVS2T9moDQC
 HPsgbnzwtBatLd2MdvatoUVeY58j0cNTHzCv2llF9KbKHRh1qwOwrJti8sKDqqbqjanbNVxsgvMS
 .a4jGzBiqEbzifzmtJsmKDvFK14QlEDBaMOLd4VXSm06cxrQIH19OmjAyg7VuzUA3X1AajSIanbv
 G5MCIOT_ElyD3Q19lW0Z9eontYl4KrbPydKxQ_QRt8jPGdDg3u9.BjJDcV_k_ySDlGtQV1heEezX
 mlcv1vc0bHQjMtvVtcHANhu_N5XqOCZYuN8jn.NtwD8dzaSEDaHLFAD.VGVJQJ6lgNWYV0W_OC10
 4txovE9J7jYYE2QOfeEoO6q9WhwSuqAUNbPt90ljYQg6UAPQ3dsuobuU2Xxu0lIif6BE27sCp3Gz
 dXQz8FKu.k2kugWEZhQ6NU3J5NpKzeHAlZHdT.qmlF6T25M0elvCZPmOK26MhzJZST.fj2NfSTkF
 OcDrmYtoR_8P8H8RTGHIQWeLK6rVp3aJFKGlofbnsoGaUhswkhR8M4IWflm43H1oy_mIiwQPi31t
 sVRB6CUDJXdzQk2nDWZOOeM9OR3zDla_eSPuNIsTk8VCbOt423SlrMpSj5M3hBdYKYjruuFIuDBl
 tnTBNyHsQuJr5Cz4uz277KY.KQ0M5lczjEGWnmMmfu8gF8CmZjPE9UPfPP2CJX2.UG5glrSsQBvl
 zSrCqCbzaLiYq.8pjEUb0la6LdTKDDT4_8kWtngRJUmite4xbPh_YRQjitGKgZ0hnKcx.GNgWvCZ
 TCJ0teB7SLKXxIVv9wc7y8.g9D.L0k9A90F4HIMunjd9_fLAiGk31Gndk_mNPmccmPFxkGtBdUWe
 gKvlQ2qdRBY_5KRZsW.N0O4n5i23_yNbPkSzsx9cd
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 26 Oct 2022 19:36:41 +0000
Received: by hermes--production-bf1-64dccd5d47-k9w9h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0c5d151e36f47c5c39f843a98a5bcf91;
          Wed, 26 Oct 2022 19:36:36 +0000 (UTC)
Message-ID: <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com>
Date:   Wed, 26 Oct 2022 12:36:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net, casey@schaufler-ca.com
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <Y1jMeWl0oV4/2zyE@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20783 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/2022 10:58 PM, Greg KH wrote:
> On Tue, Oct 25, 2022 at 11:45:13AM -0700, Casey Schaufler wrote:
>> Add an integer member "id" to the struct lsm_id. This value is
>> a unique identifier associated with each security module. The
>> values are defined in a new UAPI header file. Each existing LSM
>> has been updated to include it's LSMID in the lsm_id.
>>
>> The LSM ID values are sequential, with the oldest module
>> LSM_ID_CAPABILITY being the lowest value and the existing
>> modules numbered in the order they were included in the
>> main line kernel. The first 32 values (0 - 31) are reserved
>> for some as yet unknown but important use.
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h    |  1 +
>>  include/uapi/linux/lsm.h     | 32 ++++++++++++++++++++++++++++++++
>>  security/apparmor/lsm.c      |  2 ++
>>  security/bpf/hooks.c         |  2 ++
>>  security/commoncap.c         |  2 ++
>>  security/landlock/setup.c    |  2 ++
>>  security/loadpin/loadpin.c   |  2 ++
>>  security/lockdown/lockdown.c |  2 ++
>>  security/safesetid/lsm.c     |  2 ++
>>  security/selinux/hooks.c     |  2 ++
>>  security/smack/smack_lsm.c   |  2 ++
>>  security/tomoyo/tomoyo.c     |  2 ++
>>  security/yama/yama_lsm.c     |  2 ++
>>  13 files changed, 55 insertions(+)
>>  create mode 100644 include/uapi/linux/lsm.h
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index e383e468f742..dd4b4d95a172 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1607,6 +1607,7 @@ struct security_hook_heads {
>>   */
>>  struct lsm_id {
>>  	const char	*lsm;		/* Name of the LSM */
>> +	int		id;		/* LSM ID */
> Again, kerneldoc.
>
> And if this crosses the user/kernel boundry, please make it __u64.  Or
> __s32?  Something explicit please.

Will do.


>>  };
>>  
>>  /*
>> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
>> new file mode 100644
>> index 000000000000..d5bcbb9375df
>> --- /dev/null
>> +++ b/include/uapi/linux/lsm.h
>> @@ -0,0 +1,32 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Linus Security Modules (LSM) - User space API
> s/Linus/Linux/.

Whoops.

>
>
>> + *
>> + * Copyright (C) 2022 Casey Schaufler <casey@schaufler-ca.com>
>> + * Copyright (C) Intel Corporation
> No date for Intel?

The latest guidance I have received is that Intel does not want a date.

>> + */
>> +
>> +#ifndef _UAPI_LINUX_LSM_H
>> +#define _UAPI_LINUX_LSM_H
>> +
>> +/*
>> + * ID values to identify security modules.
>> + * A system may use more than one security module.
>> + *
>> + * LSM_ID_XXX values 0 - 31 are reserved for future use
> Reserved for what?  Why?

You're not the first person to ask. I'll remove the reserved values
for the next version. The invalid value has to change as the id field
is going to be unsigned.

>
> thanks,
>
> greg k-h
