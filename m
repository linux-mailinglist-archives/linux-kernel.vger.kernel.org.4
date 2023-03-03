Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0658E6A9C9D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 18:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCCRCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 12:02:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCCRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 12:02:47 -0500
Received: from sonic317-38.consmr.mail.ne1.yahoo.com (sonic317-38.consmr.mail.ne1.yahoo.com [66.163.184.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7421A22
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 09:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677862964; bh=GCzhVXUz4jF5ksde50eL4tPq1dvyiv+gX1mzNrMCLcM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lAmnu9IfE7WtfU7LMRsy4/ONSQ+1dLSB2bn5F0DuL6+3c7ZzAiyZ6nmNFRem8Frjqg/F9qHiTE7BkUw/UrYkF4nBPkoj9Ff4BAdrFySMFw7F4tvlRRaDvNNrcofsUEQfjK3edzEVKqZ0/xOVK9qWPNjry/4fOPclFWQZXlFZuAu6r/SpStvZYMFBT6jMDwfgOx2M2bIwb7HlovowGQr7oQfFahCU9LApcLccobJSCcjIfD6u8/o8BrKmkF64FEA5G+QvFHivDaYZ48b4DJysUt38eqaDJCTD18bVG1c2ihF37e8KK5RJb1To/Mcv8bG+tOb891LU2CR4TXofVwl3XQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1677862964; bh=i20PlHGrjk05qZ4s4EdDpGKqz8ETFTlud1/cD+i7I6r=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tphxxei1ckW+7ZOZFZ/gojRJv8sccMikzUiwAnQj1avdNT/gP/1prpRn7DuIEJdl/BACXwfoD3VrdUbBOR6Lmo/98ouCbutlXDBBHYhrrRJcv4DmKeAfUZiZVGS3yC0cAifIh2QGGykB1fIAGvDNDu/kzgpI2p8Z+L5351ZiShRUMLT2Oawq+U3mZ48jLJPhl27zIjUz9z5K6Rn2zsc5P1auGN37kosVWAjJsW719SjWzneiQSjPsvuFcqccISNgx9j2ysqi8g4D9b9qpVOcP+oEdfuxGYr/PQE0IygneLZOak4sSx0d7HvAaEkyFbZ+76XQ6N7eWNK040JXf4254A==
X-YMail-OSG: 3sK.Gg8VM1n9A840XATdBnm9T._HZs1j.Shh7q1sDZN27n_F3W05oq970YkBblt
 Xyo7b54r4KImlZuOlH6II1AgMUiKjTriaLHX0m50oil..mo1e9C95SOfHRuv3wceSnJYfz4de9b3
 slumAj6yHYtEEsCRFoJNa3i5CTyKiD64yStHX_qBRXmdnC9GRzqSLP7HG.99hs38kgnUSBz_vPLb
 zk0y7VngZyKxH4yDjJxD.vRHX3GY8DHu9Q0YA15__R6cH3k7SHMqveK41ZfQM_U.bsksxMqiZQ4u
 ojUsAkF4qQHBfhexk56fuCvLB4Wx2Zl72dc.8JIxvUOTwUp6Euec10jgkFPx913cV3DLimCo.roB
 mJkaKNQgogOH4jle6XRfdeyun4AgSgMc3WoFFQ3VHuSWU2NgeNdbtTCrLKYs12nunahqhedhpOzP
 3prso9LhPkw_7YIoghnX7CdFXM3QhYYDB578m3kYj5BHKTfSwGZmIeREd0IfzmPeyKtl6rJPWytQ
 qPi4h5Xoc7z9gJhC0NmKMj6cm9hKH7a8FPCyWYWyonj.sbCEdQ4MSo9UlDJtx_7y3t.HVdiRDgY0
 nbm3D8.qMXetU6r37Foi1nnOv8P4N8xsK.WPKKw3508s3iUlYVx9SyXXK5c173zEqskHXLeuc8lc
 yZcD1ClPiTcGqu4VNcg4u_j_6Y627Hv6SHqVP_qxCHERP89EcHIiQsDdm00BPvee.el3D8mWB2Aw
 uha7N8X0rnXJYTW4TuNqasWa_gW1XRrZWVoAwav8NabNQZ_JkNy0Aem76KREAaZrdxJMfddy8lsI
 5c7xMsxXNqucPwNqIYtPZA30vXk7aax.Z.hVDab7ZbLT_0WKbgYJVvm_2fNi_zKb7w.u26vRzogN
 ld_l74fF3plUddy_YHiFywS3IBKeJDy.Ywy2ekwrtV18xJFfhZDPsOl3uwv03WE2F3TZku_OfZkj
 J7LCmQqCXNyD3nFGEVS1EQpEZ4xmHW_MXaU9589iVXDOAe2hRzLzlYA851u_sIp4L_1bqJGTdpz3
 3tdExTzteblKaP0bthn29KB5TY2tSotkAjV7O5SXEfRLfzpzrWr2w6jVIMDpEtK.b1IdVXco.aSC
 yUDfoK3OY7jN9plv98rQl85UMsBq8kGiozDOLKa44mAmDs_CqZJb2bgGjp8rG2pTiWoYGZe_zrCY
 aUoiumF4eg3JueIGYMXCKm8txNzrIl35Wk87JTq_9cSIa4FZlEo4gN10kQm4OUCAPP8k7492GtaN
 y9r6G_LNxHkY6CPHh4BLz6Q4zcFVrjF5olYKDqqsh4QPORRGX8C_OFME.h7Orb8f8I1Rj.htY7lA
 XKzPp.uM0esEYKkJCkKCs.GyhvXQ_w2uDDFn2dfMsstBVfGHmkPXvZSxicRSURXWxYGt3gn4r9Tk
 zmF6ytJF6rZ.F.eHNEbPCGMOK2L3wxTT9WB810CO5St0e8HpFIdN5DG72MtGzQsbaxUXxj2QbFyS
 QcQsjFTAhZTjqxJujteLitQrKfmvDJXPCgH09afES8IP118vAOMQOXjOZTT.0no4X.Ah7N..mhVc
 d2Aqq1kalWl08R1dBRn389E21_bEMHNGfy0n3zmd.i8fr9wub9bJ8YmUkrF2EMDD8hJfahDFG8Nw
 xeLEz52KDHOUozBzjqepl8msMgPcyYEQQrj1QS3l_AI.nMb8SMMExPj2eMhzRao5Wvs2GuoxX2um
 Is9pR0ZWHReMYoGymVGKx890upRpcaQOU6ZoyVkF0qzNYyA8U5npvrL4wXC6K7misXQhjWjA.M3l
 d_9qSzorFjH_9BSO1QBoAV4iLxmPQmd0STMQsZWmpX4NFGN1UzivHEa10QQac86A8NFtCuxS0nvE
 CtUS.4hLdjDhbeLHELedfKaxjoxzxJJ_j_D8dh2cdDO7ABqr2SmEjU6_94omeQCvo7HHwe44J4Xy
 .T0fYJbhCAeOVz3NOIzdlVqwnYFZZwPJe7.XAEFFRp.sXfHy4nDzjnCFZ7wEVA0kWjvokC_rzCui
 K66M_QzeFC9PZfIcyYPq09zdDDho_aI04fYl_oTOxRzzwRG.KrFojwn0Z_d2AhdwGcFsf8Q08cCW
 2sVbxSX17SMbMHFKR__L8xKE3H0_rFvV08R30Ba3aZUgUraWyjZuRAFMd2EsBsC4qo_lhoyu0jR0
 4zlY6RkLonGYYK2l3taf96D.rbKGm4s.4AZfDCTO87.Sp1P.CFw5YRwbQ9syM4CL0argymD2Ifer
 nddpWp9sznS2843nsWWzrg.onXBcOFQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 3 Mar 2023 17:02:44 +0000
Received: by hermes--production-bf1-777648578f-wvft9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0866191a97a404250aa1a9ba4b9ea781;
          Fri, 03 Mar 2023 16:52:09 +0000 (UTC)
Message-ID: <0776a8b5-360b-6da5-fbd2-205b82b24010@schaufler-ca.com>
Date:   Fri, 3 Mar 2023 08:52:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v38 01/39] LSM: Identify modules by more than name
Content-Language: en-US
To:     Georgia Garcia <georgia.garcia@canonical.com>,
        casey.schaufler@intel.com, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     linux-audit@redhat.com, jmorris@namei.org, selinux@vger.kernel.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20220927195421.14713-1-casey@schaufler-ca.com>
 <20220927195421.14713-2-casey@schaufler-ca.com>
 <00324ebf28f25ed18f81bb602d7f28fff2b4b7ec.camel@canonical.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <00324ebf28f25ed18f81bb602d7f28fff2b4b7ec.camel@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/2023 7:17 AM, Georgia Garcia wrote:
> Hi!
>
> On Tue, 2022-09-27 at 12:53 -0700, Casey Schaufler wrote:
>> Create a struct lsm_id to contain identifying information
>> about Linux Security Modules (LSMs). At inception this contains
>> a single member, which is the name of the module. Change the
>> security_add_hooks() interface to use this structure. Change
>> the individual modules to maintain their own struct lsm_id and
>> pass it to security_add_hooks().
>>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h    | 11 +++++++++--
>>  security/apparmor/lsm.c      |  6 +++++-
>>  security/bpf/hooks.c         | 11 ++++++++++-
>>  security/commoncap.c         |  6 +++++-
>>  security/landlock/cred.c     |  2 +-
>>  security/landlock/fs.c       |  2 +-
>>  security/landlock/ptrace.c   |  2 +-
>>  security/landlock/setup.c    |  4 ++++
>>  security/landlock/setup.h    |  1 +
>>  security/loadpin/loadpin.c   |  7 ++++++-
>>  security/lockdown/lockdown.c |  6 +++++-
>>  security/safesetid/lsm.c     |  7 ++++++-
>>  security/security.c          | 12 ++++++------
>>  security/selinux/hooks.c     |  7 ++++++-
>>  security/smack/smack_lsm.c   |  6 +++++-
>>  security/tomoyo/tomoyo.c     |  7 ++++++-
>>  security/yama/yama_lsm.c     |  6 +++++-
>>  17 files changed, 82 insertions(+), 21 deletions(-)
>>
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index 3aa6030302f5..23054881eb08 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -1598,6 +1598,13 @@ struct security_hook_heads {
>>  	#undef LSM_HOOK
>>  } __randomize_layout;
>>  
>> +/*
>> + * Information that identifies a security module.
>> + */
>> +struct lsm_id {
>> +	const char	*lsm;		/* Name of the LSM */
>> +};
>> +
>>  /*
>>   * Security module hook list structure.
>>   * For use with generic list macros for common operations.
>> @@ -1606,7 +1613,7 @@ struct security_hook_list {
>>  	struct hlist_node		list;
>>  	struct hlist_head		*head;
>>  	union security_list_options	hook;
>> -	const char			*lsm;
>> +	struct lsm_id			*lsmid;
>>  } __randomize_layout;
>>  
>>  /*
>> @@ -1641,7 +1648,7 @@ extern struct security_hook_heads security_hook_heads;
>>  extern char *lsm_names;
>>  
>>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>> -				const char *lsm);
>> +			       struct lsm_id *lsmid);
>>  
>>  #define LSM_FLAG_LEGACY_MAJOR	BIT(0)
>>  #define LSM_FLAG_EXCLUSIVE	BIT(1)
>> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
>> index e29cade7b662..b71f7d4159d7 100644
>> --- a/security/apparmor/lsm.c
>> +++ b/security/apparmor/lsm.c
>> @@ -1202,6 +1202,10 @@ struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
>>  	.lbs_task = sizeof(struct aa_task_ctx),
>>  };
>>  
>> +static struct lsm_id apparmor_lsmid __lsm_ro_after_init = {
>> +	.lsm      = "apparmor",
>> +};
>> +
>>  static struct security_hook_list apparmor_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(ptrace_access_check, apparmor_ptrace_access_check),
>>  	LSM_HOOK_INIT(ptrace_traceme, apparmor_ptrace_traceme),
>> @@ -1897,7 +1901,7 @@ static int __init apparmor_init(void)
>>  		goto buffers_out;
>>  	}
>>  	security_add_hooks(apparmor_hooks, ARRAY_SIZE(apparmor_hooks),
>> -				"apparmor");
>> +				&apparmor_lsmid);
>>  
>>  	/* Report that AppArmor successfully initialized */
>>  	apparmor_initialized = 1;
>> diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
>> index e5971fa74fd7..e50de3abfde2 100644
>> --- a/security/bpf/hooks.c
>> +++ b/security/bpf/hooks.c
>> @@ -15,9 +15,18 @@ static struct security_hook_list bpf_lsm_hooks[] __lsm_ro_after_init = {
>>  	LSM_HOOK_INIT(task_free, bpf_task_storage_free),
>>  };
>>  
>> +/*
>> + * slot has to be LSMBLOB_NEEDED because some of the hooks
>> + * supplied by this module require a slot.
>> + */
>> +struct lsm_id bpf_lsmid __lsm_ro_after_init = {
>> +	.lsm      = "bpf",
>> +};
> Can bpf_lsmid be static too?

Yes. Thank you for the review.

>
>> +
>>  static int __init bpf_lsm_init(void)
>>  {
>> -	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks), "bpf");
>> +	security_add_hooks(bpf_lsm_hooks, ARRAY_SIZE(bpf_lsm_hooks),
>> +			   &bpf_lsmid);
>>  	pr_info("LSM support for eBPF active\n");
>>  	return 0;
>>  }
> Thanks
