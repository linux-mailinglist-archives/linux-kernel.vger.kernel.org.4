Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9574F6FF82E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbjEKRM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 13:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238878AbjEKRMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 13:12:55 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA46A6E94
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683825173; bh=6sP18BGDn9Rhj6efdS3FlKIM/wPiOLuvkuLDyhkTuDs=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=imwxkmKYe643ZXnVJGMDm0W5gmftuTU/RMRatqH73XeKgjhMnMb76SXzUO1tzEQxVrAn13V1wWrUFS23BDA/Cn7hamRA3uITmLmrsvGSNLiuJU/PdXI62tFsvi+KwMT8Vm6RvEUgAiO5LV4KzoN89/we0smwiD2d8u/EYKVs7XuC+ITXaouZ/DOeTI6fPIEIez5DGfNq9MdxmTWfskfWJqahNybHdmsn5qfTJas4NTrOwEEsiI1O64ZlLlpwz0/eXAvynCP/0iYsL/DnHMJB501B+xJ4pW/uwjZXDR8rTZftb3UK9XXs1JXXgP46EV4CUxUiEKjqZBUrrFrbS0SkHQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683825173; bh=o5/r+ELgVWYP+OnVTmtw7tzsDF8cMtqmW7kfuXkV4Tv=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bSlcjd7Sl5ntAOuRBVpSBBE2rdR2kKqzaL7DUYAShJyt/guLQnt+wFfe7x0F2gFdhhRElKnIctLHdOSJXu8tG4dAkkgXdzyX0b5f1NNS4WTmHHEh6XmciJuS+Degbi1z6sFS87Lp/qtUbm55QcKzX+XagRu95wuxvcg7smUdHoE7f0nSu/jqgYIrvCeqfRDKua97GLlvVEPB158txIO8uP20+TRrO8jwmDAsYu6pt/MsnBrjaYRRQh6VI+J+TGKxZ+7hkMj1nGaTtB1FkpERjbT95ozR+3oG8HKoRVmJutH10Q/D9KRkbJHreNLFMLFjasYR4VUyfDfKBoVYLrpPEQ==
X-YMail-OSG: U4dGrcYVM1nSzm31IK_bWO0n9aIFI43z6Bo7MSMxI1MKyiXHxCZYnv7V6V4ZceY
 NCpVmq2B6shuuJCDAAdZKN94ZipJf77CWe2HmQWemtp8w2Bn87_iG6JpKrC6CCMAuFeBAQ0fuM5f
 FZUoJ03e7BttAydhjlHU0zdXGBvB7I.bXDbB.BFmlXpx_DwxLD4apLwTEzk7A7I_FYhlWWOpgIbz
 aBg0opT597hypz_V2bklcPQ1Qwl5GvcMZm1zXCW6rjvJgKylRaIPBtzOfppUMj_ZDEEiNkyFDPFZ
 xzwOGqB_L.QUkxR9p3OGW1Yb6hGUwv8csNzg59fA9i0r49DlWXki5K6x6lsndjBJl3pceEOQePXQ
 4EJgwF1LPWxdQrB9KzGH.DJHcVzXxNVqcZnW4LbaLb37_afLuwrjtNmXLwBU0F7xlQPGtPE8CV8y
 Sx53DuqcI8aUMAswZhK6rdPdFGHbUNKItoeNWnUXngn4JQn5M21vmtLRXcqQyV2A9nyArlHBD4Hu
 Wq4f78meT.v7KI2TUVjImaeH3DBbLQqBFVSVv1rrab9ndjhxWJRy.ah0DgoR9M7k7zS0pO7M1Lg5
 D7nxC0ZPdpPGZvvVBneimDRRGEsA3R.e10luJNIfz6IR3lEigOLmP93hs_wvn_5U.mEHYUCVEUpd
 7RBvWeXkYMm3.3HSw0YMTKZGSkzzPGawxMcFT4WC978uPNT4xBIExMM07FVOsmx1XML_EP6j8WU2
 tivuhMw0VvS35W.HXT3RE5yJfdhJT1x5MwAr43CESiir3x3UZupBRZ7GZAUKqUEZDXzPhRxV0tAM
 ut8NfHdMxjcn8npT1s8zg_M332.aChKIb6wlySIi1xCW7azVH03NGiwbCB3QKwVEa6psmGNPRwBN
 RpfnHCi78IvZmskcBFhDiw0VfqDsJjkKQhpBrN6pkDNwQAG5ux7OaAknmy6GhZqAEf40ABXreqv1
 Xv.ZNdN5jH.rekwFDi4y17K_tGJ_.CnLxKp_jivWOx69_NxA.zeNjxdDY6I6oVTMnN.0T5VFvtBE
 7RZt4Xr4VQzlyGHkMDRgkrq.M73BhcjKEKMsqmopiyQsDDEaQ9nfKj8uiVrDRbWC9UqniBi5_2hf
 RYzEj84ISXkWdXnmr_Q3FNrpY.NkgNu7iQwCKGZJydMt0Pyc_.BNAkzDKrcJqKNS5cJSI52Ad4G6
 KzGg87DKP1vQM1vioNpXmmCJkbfzzE_72KcTyM4q5g0nMHQliGyrvX6G6FY1oY8NWbNJr_dd8h89
 oM_vQjMmb4wOB8AuULDG8VnoLrqgaqXWw9ykp9cRFxc53sEZ3KbCHqzNnfojQAtHj8T0_KVK4h.H
 BX9hXvis7NK1tn3TzkQXAhK5b.moYNwpYHkbePeoIKTyphSZRsMRJHM7buHQoP3fJU3mDwursc.U
 kpUpUp.XpYKVhSkk3yyJS584tfHgvh8Jsg91OAbmJCl3P0cEdaeM9D9gmUmDfZTcIcg9c2C8isZL
 9vvMD03SPZiPAXWVjSDnqA4NUpl623AFY5W4WpI22X2YX4CiHlOFYh4JDC_0xj9EIKvbFQa9h770
 ja43Zpp1LOVxyqy7Eo3Xgm9tgF.33t268RXPAPBN25QbU66QyC7i7RJhkXTBrUa.51Dh4KfDF9Wt
 CbUqGsPPYbk9sK0yflqdKFGA3w82EE9.kwmiXWxELq21niUHSSfo1hgUG5LLGpREf16g6YEs0mmf
 MmRpWwVVHxaFYwEsFTTIUH.4zYgvVphnKkv3bhYXvxkJeId3KUwkZfQphp.seWMN.himHJffqyNh
 anUQdqvr8aYkT1J8NMR5Zm3qo6O9VBHwtoDMaZfrf8gxjEuVoe3gyn37MCfwXCxidFGbR0WIxaIB
 BVrYUHzJUVAZc95hOO2ciUT._O_p7PmkiP66Hiv32nWHrrpKrqAvUlPkCWZYT9Wq9SgJ6p5bxzTh
 HfOm1BhdOEHlWTl5EGnRZofqs0y.6lG3e06cFcMpIOQ.i2lqNnOIRhFhmphfS7jgFLQsRFHDr.Vb
 YhTx1zK1t7HVcX7N_rve0PWYstIWYQA2UdJUscl4uRS8wlC4lnnGQ683gwtfOeJMkKVYrPwQIBj.
 C5lLZI9rA0V4UNi9gP_O9s2TvKlASZ2M1DXB72nOoA3cIEcQEfJnGoiSRXnFICX6xl1hJEHN5.V2
 BZLswkpRbOJDgh8z5Cz2r3lu4V9I7DsP3UvzeqMJyNIXtovopMlaxfH2QCf7pY2oE9M7eW27r6_E
 T3xuPPEEullwhU4QuXY24GdEhRFYhuuQzL_6txVyPgPl5AjC776TRDv4O3IqPC6KiywU6dvRdQIY
 78EL9wKukdC0NGLDKSFbRqw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 872e19d1-a67f-4eb4-b4aa-ea2c3552d5e6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Thu, 11 May 2023 17:12:53 +0000
Received: by hermes--production-ne1-574d4b7954-q7frw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID febe671d59fdf6b915a22e0f8817eaa2;
          Thu, 11 May 2023 17:12:51 +0000 (UTC)
Message-ID: <b0a4fa15-df54-46df-afe7-2af03c3d56df@schaufler-ca.com>
Date:   Thu, 11 May 2023 10:12:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [RFC][PATCH 1/2] smack: Retrieve transmuting information in
 smack_inode_getsecurity()
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230508170234.3595105-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/2023 10:02 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Enhance smack_inode_getsecurity() to retrieve the value for
> SMACK64TRANSMUTE from the inode security blob, similarly to SMACK64.
>
> This helps to display accurate values in the situation where the security
> labels come from mount options and not from xattrs.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Looks good. I have added to smack next.

> ---
>  security/smack/smack_lsm.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 7a3e9ab137d..c7e37ed2799 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1463,10 +1463,19 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>  	struct super_block *sbp;
>  	struct inode *ip = inode;
>  	struct smack_known *isp;
> +	struct inode_smack *ispp;
> +	size_t label_len;
> +	char *label = NULL;
>  
> -	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
> +	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
>  		isp = smk_of_inode(inode);
> -	else {
> +	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
> +		ispp = smack_inode(inode);
> +		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
> +			label = TRANS_TRUE;
> +		else
> +			label = "";
> +	} else {
>  		/*
>  		 * The rest of the Smack xattrs are only on sockets.
>  		 */
> @@ -1488,13 +1497,18 @@ static int smack_inode_getsecurity(struct mnt_idmap *idmap,
>  			return -EOPNOTSUPP;
>  	}
>  
> +	if (!label)
> +		label = isp->smk_known;
> +
> +	label_len = strlen(label);
> +
>  	if (alloc) {
> -		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
> +		*buffer = kstrdup(label, GFP_KERNEL);
>  		if (*buffer == NULL)
>  			return -ENOMEM;
>  	}
>  
> -	return strlen(isp->smk_known);
> +	return label_len;
>  }
>  
>  
