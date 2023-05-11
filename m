Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6356FF831
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbjEKRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjEKRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:13:33 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3186A4B
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683825212; bh=XwTqLvfFpoiQj0Gp65/QYOjCCB/ypC160naWa0MqDKY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UsZO5tXzWej8MOoZRJA+TE1VnjHNhpdGnZhA4rw/GezzrCDYE9mxvzaKCaKp8N2L5VzsjZe464Kw6E6o+uJs1jYTwsxacx+N7nsXuvZISOW6oeVKJQiX12JejpKRzOZzhRVsHAXiPaVin2qwOLjTgwKeu7NSn9ceVvlPSo504zbnoLmKRpr1r0zbmSugfkaYjoOIPNK3lQyXeAAIBnHNRQdvrQSoTbC1SGCXMaA12gqMrz+5AI2pUUZmmcYsuuSf0MF/sBKOTnm8q9OiIXHpAykeAGELcmfv07SR7gkDcGQY2G4jIP9lhvfXm9X80FMbcKOH+1Tw1DSU8+xjEkIhaA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683825212; bh=uswXiFMgyaoX06a9OHq3XpCkJcbdUNyj52aTnjmVbzn=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=dlY258DEzRubsUwtsZqH9LKQHyJU2B2BFUIGJlUHnH1/8KooSUP/u2kqeWkMBTSE6ApwXUqZQr8tNr5I9Kf/VWs7v3e4DGxqslh/tzyC+WJOoTgY/aQq4CxCXfMLnuybL6MM75roIEAGmR9XmImtWM+XOx2MowRiFW7pwHDhS6zkVAIYMwuxAOySavv2q5sCukcaCuVNx1JgMki3utSitp9mpMBCDCm8V7HKT+0BZJqGRcRs+JWEFKZatssqaK4C8zOhYjCd8oJDffmTnW91L/2Xil+zVUxSHKcG6IWp32fN2ZIxdYchxQZNz3TZOUXfxt2f61TSa9fXonHcOLxa3A==
X-YMail-OSG: sWu4Bm8VM1m7y_yIqsw3xNDbYflBYkAtj0gNLXyLBXQrXi3RdkYZBMZ.Ha7Ts2g
 wlteNB8LXYHypI8tj7vrO2Qg_nkxkyfqZ5rLIcfhUSkpQKt.5DxrgRmenDYoRqPorBcG39DnKCKR
 xa6xwE7G0sX7oEMlrwfjbK5iH_Xo9RAhLuT_XchN1YdCdTDH6VQzZUYgICASsEt3FF99Wm6xFfOT
 rQje7IKUpLg.bhz2c8wgTTNxampyKAH9.efPKFjmxwn1eX12fVqwbSnB3tp5WWaxbsgs6ZXsJG5n
 t2QbAJsmS3Qt1aWBR1TEoTgj42zdNLTdNHirEu0lEzvXbvEbGE4.IMXKGFb5HSIhXZZhpy15IcCg
 U9Tk2Iebuq7.d47vUK2NK0yKNYPvqOnGUgz.qEydmQEaxKLwV6JUk7REt9LdD.BM1UhhCVKHA3zi
 J.y..Nzxdsj0HsTotQmURdbqeHsN5LMjeuB7W06eEOqthcaM4nRTw5XwKaB54.WqH00MxuuUYCus
 50GlgwaLWfw5BWNXCBCAxDtWVmCYPKiHYGrTxowUbf2L4x0IGDTG63NYhHz4iDxApYAK.OcjZCGS
 AEjmqFVAOPNrVkIFUHqsn9E1M3Xke2g6KTkl0CR486YoQeytroqxiVOXaIqJjtzUK9vDnB_FZEi9
 d5WELsg2EzMxcx7Q7UUGs4p5h.89qH5NQP5GYTcCWWmx_pufaDb6OvAhRLmaCfDsuxQw6A6YoA3V
 VnXGyoMcLA4oFQfivjfOJ487ypNkCdAp0T_CpbKbcv6xOpVQmpkXypn0Rc4bvZ2_fZ9L.g6xQoMV
 HQ2.zYPHGEQhAAGAthzlIEFEq_h1w6N2RtfA0e5C4wdwzMA_kENxAxGPuOT3zj7ehoiz9jOhVmM_
 HUWNFKleiO75rr7ge7jWP9Rq6UOnCGAbZM6kV32_pc9x.x4COlSDFKkJl9r5oeQwQ0lj5pC9DTQx
 WNAObv7b3CdaxmwZzba_2kVo4I1G07nKFRpzh8DOXm.g0bVdPafDBFYuF8HX2EpNZU1emPLpF2_9
 cvXhZZ3eO55ejax27AkUscBB2U8mARLOKu6SH46DHwugam5bHHes2JlMPKez_4T77L8g6UdxOTup
 J2YHZnMou3NdLfNrOEqgKAzF2tX7uBr._l2zpr69Qq7vkoso9qfapGDadkeaCNbGkFUVQeZsPPjH
 xxBABKRpkH5SInEo4Hh3DqCgscuAg80HAaeKEH7bLEv_9p5NCqovQfwvL44Ds48z7prFonz8v8Ni
 5Gg5hMNSWXLdHqIkwmBJZIciB3f9XKe0wV.a.M9qHa802_rNTFoRjrCrtOhHXSjFr.u4ON_5gpMm
 dauY_W7RBeYKNavLuuhnz2xT_k7aUVgh.iEW7s4K8tjq_Ko9b4t9Ao7K_6Yg4LdNWsTbdBJnktsi
 e2jYx7LyqvIAxr1jGZxn_0_2_o7RocHPRN4ubjBc7Jnge84OG3bc2Zuz2wmPxpUkl9jhNJu.aK0M
 ZxQG9kfsZiwVCK76A2apzMnU7909B3_Tspzk9l3vQhECW_457zXQsL3ruPzhJdgqWcJJDCQLLhb4
 sLJh86y1QeELFqSHTfWaE4JOONt5fqcQK511xvZHT_z4naPp9gIiDIv8J9anaCLAQ65ecrMeIoJJ
 4JTkC7ejFhPEEp79rUXdelakq_JuHR0vhaqSuObL0jWgk90ZWO8d7owf7VCJQAj7MYE_O5ZzF2aP
 HxkZXPeOFn4rGiWUCJLCy5t8619MWbydF2u.JfFy0bOd9FxsSDeF7hmbpZnq9eFwVOYMkcfQiJ9T
 ytyh7uJAdt.ZupFlVI30ujykhL.5ASnPA.0YfDwk8Hhav5OxpBQaTwCGLSmc3xpyOjny1DLl1WvC
 BtnGV2ANAXidP9JxbK3v7gprnsU6fhhD2y_6r3lP7B1Sg.XkggPVPzSFBu86MDQbVaN456lGSIni
 WFn4GWHBpv4dz5KSA_0fDLYrx8jnxmZ8clrN9r3NSAafZdBZN_eiYljtm0iWKJ_z10MvoT8GI22V
 Mv2pkQlaX_Zvd9eR7qsPv578LG__Ji.LuaDqHD.295UftlEllHtu7VUB5w0cPn9uDYQtkroBCu2R
 SZVRRc7cnsSXLpOj9qYQKNgpu7aVQ1cVHe9XuVXKlHUbuOcZ7iqh7.icujskSwXciJW7fRdlw.s0
 .v65UZX33Nn4dhi9QNw13m0RSYchmrocYcUSSDRe_ftsh62FISrMCMj7Uc02EZzFhT44IdBTm56H
 xpsCGiJ4039nZ3j_7SZNlqWZCALqbfxcqvhzudQUzuV_0B4T_Mw8sbEV8Vxnc3NRkuzkRtGqCMi1
 mQsiScYH0fkpfUEoT0Ql.
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a2334326-d205-4429-af7d-039e61659341
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 May 2023 17:13:32 +0000
Received: by hermes--production-ne1-574d4b7954-cm564 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 52f8ec37ed19c72de77510c59ad3e499;
          Thu, 11 May 2023 17:13:28 +0000 (UTC)
Message-ID: <25462ba8-ca34-e4cf-cdd2-cdd417f323ff@schaufler-ca.com>
Date:   Thu, 11 May 2023 10:13:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC][PATCH 2/2] smack: Record transmuting in smk_transmuted
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        yoonjaeh@amazon.com, kamatam@amazon.com, mengcc@amazon.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20230508170234.3595105-1-roberto.sassu@huaweicloud.com>
 <20230508170234.3595105-2-roberto.sassu@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230508170234.3595105-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 10:02 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> smack_dentry_create_files_as() determines whether transmuting should occur
> based on the label of the parent directory the new inode will be added to,
> and not the label of the directory where it is created.
>
> This helps for example to do transmuting on overlayfs, since the latter
> first creates the inode in the working directory, and then moves it to the
> correct destination.
>
> However, despite smack_dentry_create_files_as() provides the correct label,
> smack_inode_init_security() does not know from passed information whether
> or not transmuting occurred. Without this information,
> smack_inode_init_security() cannot set SMK_INODE_CHANGED in smk_flags,
> which will result in the SMACK64TRANSMUTE xattr not being set in
> smack_d_instantiate().
>
> Thus, add the smk_transmuted field to the task_smack structure, and set it
> in smack_dentry_create_files_as() to smk_task if transmuting occurred. If
> smk_task is equal to smk_transmuted in smack_inode_init_security(), act as
> if transmuting was successful but without taking the label from the parent
> directory (the inode label was already set correctly from the current
> credentials in smack_inode_alloc_security()).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Added to smack next.

> ---
>  security/smack/smack.h     |  1 +
>  security/smack/smack_lsm.c | 41 +++++++++++++++++++++++++++-----------
>  2 files changed, 30 insertions(+), 12 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index e2239be7bd6..aa15ff56ed6 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -120,6 +120,7 @@ struct inode_smack {
>  struct task_smack {
>  	struct smack_known	*smk_task;	/* label for access control */
>  	struct smack_known	*smk_forked;	/* label when forked */
> +	struct smack_known	*smk_transmuted;/* label when transmuted */
>  	struct list_head	smk_rules;	/* per task access rules */
>  	struct mutex		smk_rules_lock;	/* lock for the rules */
>  	struct list_head	smk_relabel;	/* transit allowed labels */
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index c7e37ed2799..6e270cf3fd3 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -933,8 +933,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  				     const struct qstr *qstr, const char **name,
>  				     void **value, size_t *len)
>  {
> +	struct task_smack *tsp = smack_cred(current_cred());
>  	struct inode_smack *issp = smack_inode(inode);
> -	struct smack_known *skp = smk_of_current();
> +	struct smack_known *skp = smk_of_task(tsp);
>  	struct smack_known *isp = smk_of_inode(inode);
>  	struct smack_known *dsp = smk_of_inode(dir);
>  	int may;
> @@ -943,20 +944,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
>  		*name = XATTR_SMACK_SUFFIX;
>  
>  	if (value && len) {
> -		rcu_read_lock();
> -		may = smk_access_entry(skp->smk_known, dsp->smk_known,
> -				       &skp->smk_rules);
> -		rcu_read_unlock();
> +		/*
> +		 * If equal, transmuting already occurred in
> +		 * smack_dentry_create_files_as(). No need to check again.
> +		 */
> +		if (tsp->smk_task != tsp->smk_transmuted) {
> +			rcu_read_lock();
> +			may = smk_access_entry(skp->smk_known, dsp->smk_known,
> +					       &skp->smk_rules);
> +			rcu_read_unlock();
> +		}
>  
>  		/*
> -		 * If the access rule allows transmutation and
> -		 * the directory requests transmutation then
> -		 * by all means transmute.
> +		 * In addition to having smk_task equal to smk_transmuted,
> +		 * if the access rule allows transmutation and the directory
> +		 * requests transmutation then by all means transmute.
>  		 * Mark the inode as changed.
>  		 */
> -		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> -		    smk_inode_transmutable(dir)) {
> -			isp = dsp;
> +		if ((tsp->smk_task == tsp->smk_transmuted) ||
> +		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
> +		     smk_inode_transmutable(dir))) {
> +			/*
> +			 * The caller of smack_dentry_create_files_as()
> +			 * should have overridden the current cred, so the
> +			 * inode label was already set correctly in
> +			 * smack_inode_alloc_security().
> +			 */
> +			if (tsp->smk_task != tsp->smk_transmuted)
> +				isp = dsp;
>  			issp->smk_flags |= SMK_INODE_CHANGED;
>  		}
>  
> @@ -4767,8 +4782,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
>  		 * providing access is transmuting use the containing
>  		 * directory label instead of the process label.
>  		 */
> -		if (may > 0 && (may & MAY_TRANSMUTE))
> +		if (may > 0 && (may & MAY_TRANSMUTE)) {
>  			ntsp->smk_task = isp->smk_inode;
> +			ntsp->smk_transmuted = ntsp->smk_task;
> +		}
>  	}
>  	return 0;
>  }
