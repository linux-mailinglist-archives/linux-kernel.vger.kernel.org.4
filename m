Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370AB5B5EB1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiILRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiILRAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:00:08 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28890DF5D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663002006; bh=66J1fNK0sXY52O7nedBCC9IIs1jy9eMRcGcxQ2S+brc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=T6xgQDNDSqBsXPH935mIIWsRCRn/4EY5IljL9Xy4mLKKoOew94HtDPF/Dq5m33qB2jHeEcaFikWgAmMly5aNhp9RDn9i/TbqB+ZAumLPAlCSAZm+vQiMaGiUak8RR0RSzKsH+oypHnjBj+d8hu0oo1mDcqTxUt0AbjAi1ex0qAcxxPRt+ZKpgX4G/Ak6f8RkkUxwjs32yGsx5paH+6uxyHBgw5pZlHIjYddpCPRJpxQWofFK7eq9GQBG19BwpSs1qJKub0xOx/cj4zkKXMjloZ7an7cYe0oS9dEHw+y7pnDW1IS+kEpj5NM7hrSD5qNtURDdpWuivW1ZGK4/7qn4MQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663002006; bh=lKDl45kQPks3UdTqJKmMp7PvQXsrY6kbNR6CaDY9PaK=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Wx4QWcCBXJ+9AKxdDT+vrRL6QZg74hLN4PuylEIHIOaVY7ZDdoebgzfUHk6nhN2p0HQOhYZY9zDA2GAIG/Ch69xLPyTBcjLZhivjNc1V6jEh3Z5NsF5dhql4YsdpfMetimtJ+kZuCODF7KHPqo4U+FqYZr6rFBbLDiL7/s7AjCgyWIpz8zcad95abT9RHp1jefgzrM5dUaSTiFBAOPtgiBZsVcwj7CXtK4nn5wagN22IixGiB1CD9zyzTt79UvFasAlW+hjv6vM1If0XrNqa3+TQFdaqWWPjpR7oee5KzwcIaTjsxl4IgQODzbXl9dk+E9RrHH0bGtM52jN50v/qAA==
X-YMail-OSG: QZzvfBQVM1n2b9dzFzRp9qsRiWRmRIUoEmAle_qTp2dJPqorUjloYcqlC_kQhbH
 v_Ft2cxz82oHJ7C28S7FN7HXnCtAD2_GWpp4LRvTKxIEKpMaWYN.M5aaUJyDNA8X23wLS8LuoCmM
 HYhVHvXFJPO7cG5HoFTJIFdAbCEoqbNAzlI.5Nqo1C2qVVpFogry.ALmD5kVFKOMaY532Gz8SC6U
 xZgEmdRutN.sTw7VCmyfDN7b0F5LHNxrytBYgfx27HEU39MIhHlqeAwTGErhZ_ERVXdkiY5ZWK8L
 g_zX3JvcSwBFu5n3Ej7Gxw.Y.GC6Io6rXWN7NAG8tr9uXhNXOzUuTOnHCf1RzmtgBB4b.SStv7X7
 FaWqRNsUdaRhyKRYaj7K334XQY9ZgZFaLbJ0Htf.iz1wVk6W_iCsSUU5Fk3OuDMpAgFdr5ORaQHP
 N0BqyqM3a865zCoBqF3a3sAmrjjOwpjkzR0vOS9lmnsgGskRoEU2tNa5.3EMx4zeZit3T.LDvf_i
 iPHlTfj2RmfZ28j6qRuDnpwgBDWj6h5rRhCDC0U4la5RPjkwtTdSedBYcloAuAxS6Kmhx0yu7lVa
 foWkz_mnFl9KlpYTyYaoGaUJqkfrvfUyhnzWsTxZP64njd_.VGYxvQ7mcgU0o9.is75e4TvZ0VGk
 MO7G2KY0Z2XhIuVpKnqq4d.KmmZJPioEFNLgZna0hIrv.2M3EztDmNg43clJFRa3ekKe7t2yOrGM
 NUgrvy_qq8ZjH7UsGi8n3VK0z4zS0LanGNG.XBPp9O2wbvfxhT49vqR1Z1QVqZuD6wPFsahYCerN
 NQxIgt1kQn4ZcFdzbP8kQMVoRu8cUhlFCk3_wOp9zF9SCq4PJb10.dMgPBNFygm_pu6VMPzAL5mr
 JK9Rb4esGxceTl2c926iYRLSjBq4IruHcA6lqxXOvQ1rTITijlyoKJYbzo0VK6F1ffOjcOEQG3WP
 vVFwUiSMxz1PhEoSQBMqYB2Ed2F_AzwsTClGa2zElohtYk8IpNXXtaQKv2QX2gcbDfekmElW0EII
 kGSnRO2p9eeoubs_n0hzt3i4KS_D2HiLU7BINLShWHCHwNVW__MHK1bPC4MHF_cKmrWm_kYDEGea
 6BmuKZz4IZDnfN703teu.Bfbr0a9AmHdD79rNHXyI66J9kO2IsTLdi2k6PX5YSWupsmZV9_QG23G
 7bsOa18CCI1Zw5xpUWiJtjU9.aiH52DwLZb5lwOCQg_lnYydtZWElHbaMVeKSMTJkN.SHYM3NNst
 3.cd3zPEQuXp.MFcN7IjLfB1Tkzg9umhogIwmPCX2XtRq1dU700GBcifHSyT59qbunZtVAl9G6gA
 mpVIAz33O7_jCJXkYbGcnIVEPAr2FR8LrOR17ljyjJUtfEynV4veFiB_TqIe3JztOjMAoFxpU2FE
 x.n2h6TMZwxa2R1YDR3rgDxZALvEzyOJp0STB1wUax0t.LniL7leb9aj2IyurfnyFLHnF6LPKZda
 d6s5vg0M2ehkjvS3kfU6.AXodYuznbn2AyeZbu25tWOaE.2Dx1X9BUGiNiaiUUHw4A6OPeUCqnns
 CXtTgM4N65asNciWMg6CdVd2iMxhUjcqrmH1cKLJOcMlf6n3nIettqRk66UI1WMRV.c0Nrd3ClBl
 OtolPntnieGD2R5beM8TJS8YsL7a.UunI115bnmcDstMzRsViR68suDuVblmiW.VJQNqtXOk8RJU
 SDuRrtwS8UWXf.OhzMqtOISWY5dDBwoZX5NLOuAYeqcTrz7JhHy3BMpFcVDvvN..sLyVZZlfqyJM
 z5T.uwRlic_dz.NNNnZz.P8mLkKvVr_CTirs_FQvgL9MFxj5ZCihabG66nTllYTxOYMLWBbDHTna
 p_ki0QFu657cEOKjLT33kLlP4VQroNl9.pwG_wH7Ovo255Y9W8hSILvB6oMHz13TVvEFYsVeRzFQ
 eh0Jyu_LG7jLMpzcqxf6DCtYpVfCz7GhClNi_d0eYljAKyQCRRHRJTkE2D96900CHkgRM_khUa6w
 zrG6NaipGtyuiEl3oYX6WI_eWIoaw1HOnHa61JyD_pKTr0KNXBoj1loWnmBYBBU9ycIX81CB0Js3
 KyZmeAWc2Qh5f2k7_vERvwMeZ4.gJyHbu__uA4M5Dvytofbd8R_RrX7qbyF6u0Q2pFL0e0T3Flsn
 8BzGJ0q3Vbm4DZ_BEboP2._Tf4lKiNkm38LYMlGgoa4httgEWI7UdrMbBkzEEnSzEHpSGWPo.iyn
 JnQ9RsqhDedNsi1P1GX5lxmOaKuVJsTEpMxORXjiQkTtIP7CCKyyUcZjSSfhdCFFg312boVpLtna
 lRWdibHIkFQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Sep 2022 17:00:06 +0000
Received: by hermes--production-gq1-5499fdd576-dlgnq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 70b580c9c7f5073724570de758dcb345;
          Mon, 12 Sep 2022 17:00:04 +0000 (UTC)
Message-ID: <48dd3c0e-f652-798f-9cb9-a53aaae6dcb9@schaufler-ca.com>
Date:   Mon, 12 Sep 2022 10:00:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH linux-next] smack: lsm: remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, casey@schaufler-ca.com
References: <20220912100535.18125-1-xu.panda@zte.com.cn>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220912100535.18125-1-xu.panda@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2022 3:05 AM, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
>
> Return the value smk_ptrace_rule_check() directly instead of storing it
> in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>

Added to https://github.com/cschaufler/smack-next#next.
Thank you.

> ---
>  security/smack/smack_lsm.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 16e24a6cdc7c..b6306d71c908 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -497,13 +497,11 @@ static int smack_ptrace_access_check(struct task_struct *ctp, unsigned int mode)
>   */
>  static int smack_ptrace_traceme(struct task_struct *ptp)
>  {
> -       int rc;
>         struct smack_known *skp;
>
>         skp = smk_of_task(smack_cred(current_cred()));
>
> -       rc = smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
> -       return rc;
> +       return smk_ptrace_rule_check(ptp, skp, PTRACE_MODE_ATTACH, __func__);
>  }
>
>  /**
