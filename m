Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4597681801
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjA3RsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbjA3RsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:48:06 -0500
Received: from sonic305-27.consmr.mail.ne1.yahoo.com (sonic305-27.consmr.mail.ne1.yahoo.com [66.163.185.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF593BD9A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 09:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675100884; bh=moAPiiVybO80wdbNQN6df55vtTM4eGnDIXPikO4ozG8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IuwOsJfc8MR1mH/8c+Z9QaCmUc3/V6TFETzArHGFBnhPMzoA+9BoK2cF/M4iZFNkw5yJw5bdi3J6RHNoJXYJqop0/hv+jUTyXIjT27/vKhWW1qOeqKmHkzPrWJHCwHK32jElwPu3kZsyLJUQJbsedHSrQGLyPzFojpX7ikhgrzgpXaU80+PU+PsuseWu4AEFOR/LNj2umfeABmZBjqukjJ0jYdPLasSRlrAwMSAknhPBse4FGd6Iam7KCeIo73j/KENeJ/nlNap2zf/ZX66So4ptwVia1Pq2yl8EnN+jB3FSRuXeZyu70CC7aZTLOEMIoferMdr55MHNVodXgJMYUA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1675100884; bh=km2ndC9GLa1L59ROKmqZFeGfjCNHrvx77Ntna7ni2Cs=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W3Ii1yze3v1B1YxIbIRWnqMEBtuzHz5Z1e9nDKn3hqpgEEgDRjjQb6M1UELL12kHuCXgxG0F8riqNJKyMfgm9Zfes1Ee3TsdZS6XlI65iejYQWICYuuCxa1js4Q+Lpp+exr8JveWP/25q0KJMLyEhVraA0sUNfn7/C1hUfnTazGEUl2Dyjzj+JQ896XcZ1UU7SzkYtX0XAIJCSm2vDILC97P+E576luGHMXLKUcOYJumpoFdE5akQT3IOgovYSytnx45x8E5KaWxIwCygjjHORcQWOJw0PkE7U1BDmkolmgWS/8ULHxxL92CO0DjONBhCGGaIbYSsjcAwqXeTqS1bw==
X-YMail-OSG: gpgP09kVM1l58mr.TaNQy9b2L2shsPQ.j_72nz6O3JvxFJOWH8IHNRKonMnyjmx
 4ovL3Ye1d4qoeRbCpgIaC1vp7gRmjZplA4melq4lYKjSgt4x4.qSvWDVMJuoQaJbDuO0h.DHD4Gy
 GqxLz6qcnngIgvgVHowhV0h_21X6Ho9wv.W_3XT1AO9N_JSXGAY.Hggg.fvv5wWFrYP6Egx61JNW
 XE3eD2G80iv8anPXXZQEIaP9QZgGqiSmK7HafQ.dJGalNgo.rP0b4bFbwdX_8NIMykYwhXAaKwCs
 WBkIazYLEvLPkeTNfhhc4_rt56a8.1PSgbRCrAxOtg3XdwfXOvTGw.PCyieGOTD_t.JOKo1AQW.6
 snhMcy9Hs.GDXvvLkZWdOllevzQnCwCNsSRZ9kWjCgRfhNoJz8cODcLdV8Xn_.lWrUTWd2EuUPBN
 xsFaV7iAPirH_ezkWXVP3LPM5tDNlaakzt4g9xOTfw1I.a5xoqaBmukDQFh6iPkp4kWjAz8MSHou
 3L4GgQTWZvsk7x0lbyrKrS3l0OXNQVrs4tgIYM4feFzZZ6Na.Mk2j5uzrUuX9C1icN2NF6s6qT5C
 ebevLFcxejPEE9R4qR0bdXahlL5skt2kyW1C92y49RKYwub3rw2MTba9gW5mYsBUp._SDsAx3QIV
 8zwwDymil71XFGDPUr.7NIRFyQLqFxTWVjXrJ.z9mGkTFT3uub04zudbxCQPe1QECvVQnnpXFl4b
 aklvcSuY8USeiZKxDctI3MLWGenXBYOS8SN1oaSdPPqZsWmXjS33pvMtiTRgcawcg4LHIKtvGJI2
 s3jPc0sn3iADBrraFGw5QDOzLc4fO1G6Ll.3P.KBtkAlgBwaHTd7cFU8RtKU7maLg01tsHPX3Tld
 CaiNRMlFazt_QJQ6RMhFHmQtZdfKlprU0eNkLhepaxbYJ3fB0FlVj2HnHLoWleq0MI6OiqMwaODm
 qu_R7_7F5dU0RkoBlOnmOLm1WhJ90IYI9q5Ek2KW06XH2QMR3B4mL_N6b229reCaFl5VENZb_YzY
 qKtKUxrSHG_8Dgl2TgVI84ri.Pt1cPhIWjxvXUGcMxlRy1kemNcMMedubelQGU6ikPdoGl8pnEf7
 CwYJybh2lbgSy.KAUm._jXLj_46capGSp.vO6uO6tmG22z3ZnEZsOGa08ftjqVGmXDwiatFkIjmn
 G9UpycQcj7s2RoY8URw0CYff0zDeg5qPQENNpXBOHMtcbEcIZssUPwWTVpS0kColKXq8Jbg9XCOB
 cDEjLwx7dJCdNHIoBKSw5.FJuZCIw2QBRx0rqWYiwj80hD4zkCxvJqoQ94eIxAH9hvAlrCqaHWM1
 EUKmPAjDlujP4CqQg30ltH3cT0RKY2DOH2ACDZ58a5VZ_jMgL4CIVTT826EXUQQN67bjQWj.Dd0F
 EL7iroPmmgUu_HFYr.lmdCZ43lK1HGhZeDdG_Oqap.rtHcf4n4nxqo8QingYR_6Nob.2bGi0w5Yq
 QoEdaH5bgRyQU7MyWe61OQ9pb6nhzIT3Jrph25iGQF6JAm8Fyde9ij3krkimlp3uvRK7u_1Kj5uA
 oDr9YGheZNrNamTKkq1kmcs31szedH15D8XUQi1THkdQtShTVIsU5_6y05seLK5rPr4Ejw0wzf..
 C4oO24bdeWUmLlnRKV.ZBCgxDnellReJgKtd7S5XECOvZJigBivdXZEzFUZaqc5cnLoV89cQjKl3
 lqT4TDsrxKgX2iJtn3Nv3s0CL5EffFFBmDVLW_8zRGgWXi35AwJT7tQWc97g0WqG8LQdXlOk_boP
 .lCQchlqIrm8Lw1XGC9_b62_MbTHBwGWKoaKafXBxqoCjr2b2voRRWxL0rOiN8QXdRuLkysShIVS
 YlZgEEcKXvX84NkoklI7Jz09_zXfSM85IoPvnk9xRBGDoGaCfs8g7Yen5NOZFq52yFhAzXdLU6Du
 kzWsNdqQpwSOgCUikf1TXLPxvu7LCIETCd4Zi2Q2ipSYOrMoV1xflqdjtCyIVSnCQWZSSl3SxS5D
 19Dem1P5Lh6gJeE18sAoX5ycf93wBt9qoyK.B9v_0zfmW20rOl8PYMq0wvnYxRQEf16_gB75K4Gu
 5q171Dec.57Z2tj9RnancMBgG7Kyz5nfPqMESpKv83n4LRO_qxR4zc.EQpHUXSP1EYsRx9c2v2g3
 eEmY05YWq.AI8hzgLIRGR_nVKD1SPtr50VxarrxICJqMUTVy4qeIRBct0PsEjuZsN_BBaYgH6Hxb
 i9KLq1cU40.zX.SQ2lT48FA54Eczzjhvcm_2W2meQwL8h7T1Job0w5JwYCigkvytc45ZtFJzBSSp
 i
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ne1.yahoo.com with HTTP; Mon, 30 Jan 2023 17:48:04 +0000
Received: by hermes--production-bf1-57c96c66f6-d255s (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ccd982ac571b4ac95305b7af7091a009;
          Mon, 30 Jan 2023 17:37:29 +0000 (UTC)
Message-ID: <d0bff7d8-5d29-8841-908e-6b83932a4968@schaufler-ca.com>
Date:   Mon, 30 Jan 2023 09:37:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] smackfs: Added check catlen
Content-Language: en-US
To:     Denis Arefev <arefev@swemel.ru>
Cc:     Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, trufanov@swemel.ru, vfh@swemel.ru,
        casey@schaufler-ca.com
References: <20230124105037.23108-1-arefev@swemel.ru>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230124105037.23108-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21123 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/2023 2:50 AM, Denis Arefev wrote:
>   If the catlen is 0, the memory for the netlbl_lsm_catmap
>   structure must be allocated anyway, otherwise the check of
>   such rules is not completed correctly.
>
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Added to smack-next. Thank you.

> ---
>  security/smack/smackfs.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index 4b58526450d4..d45f4395a6ce 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -830,7 +830,7 @@ static int smk_open_cipso(struct inode *inode, struct file *file)
>  static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  				size_t count, loff_t *ppos, int format)
>  {
> -	struct netlbl_lsm_catmap *old_cat;
> +	struct netlbl_lsm_catmap *old_cat, *new_cat = NULL;
>  	struct smack_known *skp;
>  	struct netlbl_lsm_secattr ncats;
>  	char mapcatset[SMK_CIPSOLEN];
> @@ -917,8 +917,19 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
>  
>  		smack_catset_bit(cat, mapcatset);
>  	}
> -
> -	rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
> +	ncats.flags = 0;
> +	if (catlen == 0) {
> +		ncats.attr.mls.cat = NULL;
> +		ncats.attr.mls.lvl = maplevel;
> +		new_cat = netlbl_catmap_alloc(GFP_ATOMIC);
> +		if (new_cat)
> +			new_cat->next = ncats.attr.mls.cat;
> +		ncats.attr.mls.cat = new_cat;
> +		skp->smk_netlabel.flags &= ~(1U << 3);
> +		rc = 0;
> +	} else {
> +		rc = smk_netlbl_mls(maplevel, mapcatset, &ncats, SMK_CIPSOLEN);
> +	}
>  	if (rc >= 0) {
>  		old_cat = skp->smk_netlabel.attr.mls.cat;
>  		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
