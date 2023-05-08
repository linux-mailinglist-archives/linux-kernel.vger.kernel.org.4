Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F4D6FB5E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbjEHRYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjEHRYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:24:52 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com (sonic314-26.consmr.mail.ne1.yahoo.com [66.163.189.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018125243
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683566690; bh=W47C2Am1ASDpCiBJiSpeDsiHDjaCuY8JMXwH1J8T4uQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=qZ1Z/5xpc6q+ZzMITc6QKwS1dA86zkwdUKLLGMXwfGPGHNEqkUF9FNslgwbE1NX9/w2S1YvfhwpO3PTlPuYJFmScV7W2zofLw1wFUpETFNS034ZV9oZXepk3NbS6tUDCaDL3H2sbtEQMY5AQuJhmm5quS3Lz6s4khQ5bF0JT4aWkXtdmFgYkelUm8LnlQFfuShtX01hv7srnYv8Z+KEWtOvSK7Q7blP/wu2plhCAYX7aJpRAgLqWT8TO6cRI5U/aQpo9bINEk7PY4e3mMdTZ064P+Pxr5rUhnvsejrJNYb5p95EvgvKTcjTVEUgJa01JPpBNCG8oTTNktfA9pwcoyQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683566690; bh=r7s1S+IuTN5a5zaCQ4yEeLm9SRVgtDyCtgVNqwW4YFi=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=JFo2j/jaPXzOoU5W1l0V3jAnqbHsVz9mzJ7BBcXyGg64uY3UylrD5AZukipFe8VwiHGK42jwBK2nkqO6m4MnWBVAXcvG2+jfJZKSmKrAgUks6W+nNIAJ/WoC7KqAaWEmyTaKkiDuqezvbiEGvyrZ1aGReJ5GKQvQOV6rA/LpDOlIfQWiJgtqpqrULh2QKWQ7C1QvuJTKoC6kzX/Al0PPMopSk91cL1+bPMC3G31amg0YuTb54rnlnkpsii/AysoyDt7Ws4LSEcLdLZjB0ytxEcNuaKMvp/5ib1Dsv+lOeMq+nb+1Xq/bSsnZdq+1GMsvC1uBa47ARf3jhDkoD88RHQ==
X-YMail-OSG: b9bomroVM1nnoXuVUhrJmulhFsXUZmDllzLu.hlGYUs49GZAxyLNBdPrDg5jcWG
 .Tnbtae1QPy95Fg1AnC6sMHFy1BCge0QPUx22Php9efG7jnigTiaFS6MUIaf_4YOYrFORr2fnSpX
 Q02knVJ_W578_ga7vdZfi4C3z4wPTC901ofyNbB.rQ0S9OgmSnEW_VPS_9u7jKVbkYAp7ARY3Hih
 0k8o3Ld.ZU7nHaEZVFfqfJF7eeAbHsjk9jNFpCc0Yg3hfwq19aoIuneZnv4c2HMBcZ2f7RqjX61q
 IGtKcNSsOLLIlLw5pZw4NeL8J2U4jX7caB28gDZ4BIJj_SVCkxq3sDE3i4p2TJJXeE5fyl5Y3b5Z
 EOrestSNmXEC1L8xxKCrZx4sJpLw6Wsr4BZjS74FMZ8TIwtNUw.Y2pyvaixiPant026XaC8U0RY9
 H2rB7wg890zJ0xUxHLhVXcC3z8Pei50NWNtpbkbDRraRiZmFdyrzqcFO2YaS_Nnj3uzXpJkwNdtZ
 ZZAsJeHhVfUtqsjuxFz3n0OsMB0EuCW7hBWnXZFaF1KhTEq24K1J0t5pro76WWRzksU2mfRxj9R2
 dADeLa0dRUw.0Z.D8MuterhiiWoa4vMHiX3pbmF0DSQdVPM9L8KyFNUA8huT.8HMNW2FNpLBqs39
 Pbx7PH7N6iDISFQgXOWEvwA3CAc.q_mZKsDS86BRqswRTHB7y.DjwNNv3c1SvYazFoJtOmDWFftr
 4mcbHKiIqWhYtrqHpK1CbyDzKrApHmG9eViTvftsgBUXoQLdhynK0pUUWzoL8M_Va0ccIUHPrvBB
 onqG2vTB8HAs_EEwpuxZUOnDiey8BLGfaPqutg.xar_xpo.VSpgVGY1yluRxD.adCPYZjs7ZorXM
 QCJltyRTK9TIeF0VGGPwHmBAesVhkPDlnP0J7FHS7.4Q8UX5fTU467yXmsJgnWgPtYEoAUiXWMR5
 3RF_fIgbcyFcV4XxMOFY0bnuS3BnqY2vp9ralzF_85wXkz_Ci4fvfIHiapkh3fbAM.7ltXlQ4JwJ
 6dA6LY1.xlfJEtXnrylHC_yoZJNwjoRHLD7C1ylGoQOacZJJp7skuFRt7RJURAZvARwLBQG.3OSO
 QO39eSvkJhECob0pH_mR32.HsTQnYwdyP1yrmMfQ8Gxo43m.xY.xrOq2WAes63Ylkx2reyAvlG2t
 MGIUxfXIpaeNhktn0ChPykfC49hn3oSxLWJJrspeIPu7X9GURBSnB0b65NDNfWr1DbrUOLEqieMH
 07A0Mhe8VFQPFcWorIWWVtNVaXh.q3cAXbUWRMI7lg3P.D2qug3Mcx4O7xTms7E54ax2Wq_1tmLd
 ta3_glkvL5pmc4Wp9QsZe6.fCTK0cQDHQZBHdpI48LcHGg6hSOx5siI.RcdPRwgSU5GSvj2WIYp3
 RYCELc5qxawEiHEYiJ30U9gxLjF6g0lF9dMYV9nfBI2E92w7B7W4HBvVU5DvtEzdZ0leP98PYXJI
 nVvmQ1dDy_m7Tzj3bIJ0nLHsyKObrhD5bjhIA28LxLHXhU8F9LfjRQYej69mvmzbosyfidaFKEPp
 zFI66HRrd9L6qBpX7pbXXIkmW4av2rdK.3.IGteXzpB1DQoPd7Zk.5tCJAdQBllQx1hSTtspsYW_
 Ru2SN7B1faHNwZEo9C9dy86Al8tlqkG91uCqnKPE7sjGGVtYc4eGoG3jJzaBFlWWsAVnVBPbVMlC
 lBK8U4UBTRMyVsr.eiCgYbGSUA_cVTth.fiDCkHaEJGLYbjbgRhFywUOv.hi0uNCix7PpodPOK2i
 QMHhd9TCpXXbbQ1WAgPG_O_4pBFArZJd6JfLYTlqEOFo4AIN447vH.pB0adJ4QsKdZt0Q91XhQxB
 JHTAUZbowubLpUTeJuDH7moyCjzYMrNLNH818iqL.TF4BqBNPD1.zHxX6LaCwGLKalMyRl_N9ETb
 G3.GCfZ1KNCnS9PLNQGLRzOGZ0GSXUx_Q14E7kV3q7Wi.RuAnuZxSJn3Kp59xL8ckCgrrjSe8uVv
 hN0nazNMaIGNUjFetv7vXdWnItEwb73SR5dflFe6ohSFxT8o.VX1Tv4.j7iJEXrYI_eliH5HRWVn
 uXMKWUiPGwwGf9tc7LNFYxpv.Qbnmv3Yh5tpzvRxPHFGk5RRogS5qoNiTmWHxdOcGd0Pd4syXDMr
 9.2Y0PE6gaITOCey0q2DBIm9vUOfKXN4r4t0q2xeJeejgetP7KIvOvp7QhsCEd5SzU3Oogdvd5gh
 JYldzOmtD03YU143SjpXTSsZO1h5_.GnsGFCtyA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9dff67b1-6bf2-4781-85fe-dfe7e6f4485d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Mon, 8 May 2023 17:24:50 +0000
Received: by hermes--production-bf1-5f9df5c5c4-wvm2h (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 94c432530f44b25806002d2ec2a8c8da;
          Mon, 08 May 2023 17:24:46 +0000 (UTC)
Message-ID: <84e400ac-fb52-4305-e3c4-204e2c2b91b8@schaufler-ca.com>
Date:   Mon, 8 May 2023 10:24:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
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
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
> Enhance smack_inode_getsecurity() to retrieve the value for
> SMACK64TRANSMUTE from the inode security blob, similarly to SMACK64.
>
> This helps to display accurate values in the situation where the security
> labels come from mount options and not from xattrs.

I will kick the tires on these patches. They look good at first glance.

>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
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
