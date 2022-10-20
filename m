Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5096060D8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiJTNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJTNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:02:00 -0400
Received: from sonic301-37.consmr.mail.ne1.yahoo.com (sonic301-37.consmr.mail.ne1.yahoo.com [66.163.184.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B55805A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666270914; bh=rP286mmtk9KIbfA1DBkXxmhjA87S2nuEH0V1KSBdLHc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fBBdnSiYKZbAx/eNkoYxsq9Sya7x9bXJtAma05mPHMWeT6jrstlVbPeTM5q6+yGR9cps2hpv0egoUaTS1o8yUsW4BzdhgGT2TvzDtmSQMiz6v8iuuKmWj5kyg6DUMIChJIwoHb5h//zxYZGN2lvZlr1wTXBNvDsKt8uQU3gxjxRDxbFn+n1C2NLy/YNfMFiD2FAEtW9rqguAYmGbVQHZwLYuVjHPayaDZZXeE8tmyqE5UgxSZxYNwj7+Vp6w7Z4DIPTcCveUFAsB+PeZNK0ErxrBK5uszQk1oY5YZpk6VlHXB+YoeP6mqMpowSICU3eCnDlkw9oJ4xp8D+RmCimirA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666270914; bh=RFNSL0oFl5VpMn57bqyG2/geTNY3ZQSki2Qe0IqKdkj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HTXvASF22muFMLPVz60rs0py2gCxz6Ky7imSmklo2t4q1xlZvI4w/30oWP2w322iAdfknLDlp5jBOS2e3rtctef+MSiEwth1hUCfMcEZZM+CimC69mj2u65Yb5YZBanwprSfA77mvB8z0OmlYg2bg85LBiLJH+TFWZZ7X/fLG+yh8hkjeGvF3L8FdM/wLK/DUjVmVVBYJ9GgPj0PRMOsx3TJwUDpacDjYbT7gGgjUs1i8qmloAFMbOtctHVZAp1kJvgsdUSWYBGw6XMn47DAMMnfv4geQ1Vt+CeRR1JyaM4OmEQiflw5AGZSaSJm8PF0YxAuSSPO0tc4aJmYVik8gQ==
X-YMail-OSG: uq0VG2cVM1kEwNPECXe79JUAzh_4wAtstRNCFtQDLEBbYYXl_c.ZZh2oaoFNJ8q
 jud5mWSG5kxyFyBhWKuwZ4Q8FRgg0HFZBKDCdbGbs79KmhljWD9TsPqlHp7l0r3PKlyOl6ap8Pgl
 a4Xq0vaESI_.n9JU.wHeP_q9emEEJRTxGN3e0dc8rfcSwQSRjfmsG2q0jMdOBrJEDSSG.R3DnFNo
 X_lifO.8I54RmldhThvMJBh2rtgdFgRIZxHAH4gl6Fode9ZV3wSguTW9kO9gclLR2E_kXkdEioq5
 cjePubZGzUoooameO7LdXst4naaeg_GSHDFfkxm3Gdsd8nD957wc5x3SK9dsNHZuxH4_B3o0DuCz
 T2xhKauTRVzoh4I.dV8RQszT4tKuPWEvQazj9kZ7QWakcx4wl.6JPFOodmDspY7Utl3ZTVXimft6
 8qGMtAq0DEwzCew5hhAxz63NEF1hHSvA118IzyMO49CJ5aC0faN3Klsd9HeDVVqg759znz45hePo
 B9qu5WanjSF7pfaVCa2TUNUx.NEFXjAyJcZm3AUFWSDmcuSUfcWlzWNd6PYSOPILJnlKCpWu5jBZ
 YpjyLSiQ2hQuoniT7TwSwEhx9H6Ld5Jxea39rYiWQQCNGrWpmZ050cBKrlYuJSsaKZLKUJn__4ba
 FuERvIzuhXcpo5k6ak6ZeNNFJ1KDr4mdmOcs1lV_ptHa8h2h64y9_5y.0StKudSOG1Tc5UEZRZWL
 ncvX2xtw7.3bxrdclYoutViw_ApPwuU_xfMZpgsQa4PgagdiBK1vlrRtfohe1sKz05LKv1OPIeXA
 bYZD3Qs7aezsAJTVjvJ_17HTREbAto_1xqc01IubFsTvQrIVTRnZXpwEiLyk3H_pDRZi7aLhi1qp
 EZUctLwF7fJB4Otz9iEKHzqRweJ2Hu6byOfEjXfHFtlpS6briX9Nhzchsh5.ouhJoHRZZ6Ea6t1u
 2YipdX3x1mDicurpb5UGyznRbngm_oCCpZiR336LU8_qQoUA.NreF9dr_l_yX4f.lSbTtQQ2H58A
 CD7Sy1P8UuBNkVEbYU8seDxk7Nb5gmPDAgs13xXyFZBMdCoGRMylBwVauNKXHacKoS3hMn6HaHeI
 _fLryb0c1TKyDMuxm7SvLK82renc_w32PymglM5rRGfN6IIURiMGlGFIVRBM6DSuQg0Wl297BQgW
 d2dEvFRtsbDMXXQSMhXIMN7DfAAL0r4WpqOz4CjKUnAJJPOr.PSkuKUNyTfFrzsE9OsGpQZgeZO5
 _dsfmutRDtYZ79YW20aer_hmTzDKRKP0NmIfOtDYHTE5LTj1EdRHKoZWshv4VSLR6_uzUyCXyHqJ
 GGhAijW8eOOOqaGF0WUOw5v.WSvj.rtnrlnaYvP9Ofjm56XcIIDZ1e9k8kWXsk4lzUIW1ry.6F92
 7gP.nTIhdBk8_xUyvD04SCmxQeqCshWKhbGnhRVFf0_idKxfj.k8YKXIilOhGCasGRLjIePQz5dR
 2x4iioAoZZ8fDOhEISCjtBqPSI1KSg._Brd5coehYHv3A_ujurp7tLt7D.8VJDQmIZAuROmxG_iF
 1Peh9XWaE.vfnUeUJSab_t5cLgkBpgMZjAo90WizAZlPwAKeK4kk1jYbFbDk04Gxwuw6RZOIfW36
 PXGxMLG8JJ6Sloz_qo71YADhlJz7_17iWvKSrlMPDc_1enKdoZFxvOZYkzNGKMhgoWbkwwOaNafb
 P0dudM4TrmUn4Ant_cmFF.QB3Vt43EnNmye0D5XnkAB.jOAbBKglbd6KV41rOHR8l_Nn2UJZISt1
 z9_lwL0WxLa9w1m2O7MIhDdaYZk_i9MtlJgHkMvqkDF5zcLIOHLUGFM9DMNUykF2c9_30OebsGu7
 gm2jmvNHaGkf.yn3eo9q.bMeN0puayp68xEroEjeGedk3PSLKkrtqIpZbLrZALHo09igcWAg_lDL
 5Ib3Pxr26ANFpWIreg2esdFgA7k1kpj1G_y4YF1pKwg9hAb9Lh7fcRB6EL25RXVlbk84TYDRrTEc
 2kXUuePGH9EMPGjo4FcQjROCDVfPSr6.Knjq8H7qEfmDoWZ2pX6tVacUmAvUfQT1WznjOXuXZ4hB
 poZSCtImWR53JT6oQ2k0RbZPoo9dR5oRvieuUCRCzipDR.Uw8g78oZMC7Hum8LmsMAyxNlsyTnWD
 dRBc_1xgxLJUZJQs4kycnRAntkhsExa11hzP5S7tbhcGnvqA3o7M5Hq7YlUeSSqg_O6iSf5qSYp1
 278.z95bbBcEscMOJ_1Ukti04qACo.aMPNggpKQj_oSg51M54nBKBZy7GlszifA1NT0BBzheggJe
 uypOFGzoqaGSO
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 13:01:54 +0000
Received: by hermes--production-gq1-754cb59848-vz6ds (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0de3fc44211939ffe7978027b212fee6;
          Thu, 20 Oct 2022 13:01:52 +0000 (UTC)
Message-ID: <35af7779-d28c-27af-1038-b6bb4cf953d2@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 06:01:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] apparmor: Use pointer to struct aa_label for lbs_cred
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        keescook@chromium.org
Cc:     apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20221020023621.223121-1-xiujianfeng@huawei.com>
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221020023621.223121-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/2022 7:36 PM, Xiu Jianfeng wrote:
> According to the implementations of cred_label and set_cred_label, we
> should use pointer to struct aa_label for lbs_cred instead of struct
> aa_task_ctx, this patch fix it.
>
> Fixes: bbd3662a8348 ("Infrastructure management of the cred security blob")
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index f56070270c69..fd2f57972a17 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1197,7 +1197,7 @@ static int apparmor_inet_conn_request(const struct sock *sk, struct sk_buff *skb
>   * The cred blob is a pointer to, not an instance of, an aa_task_ctx.

If your premise is true you'll want to fix this comment as well as the code.

>   */
>  struct lsm_blob_sizes apparmor_blob_sizes __lsm_ro_after_init = {
> -	.lbs_cred = sizeof(struct aa_task_ctx *),
> +	.lbs_cred = sizeof(struct aa_label *),
>  	.lbs_file = sizeof(struct aa_file_ctx),
>  	.lbs_task = sizeof(struct aa_task_ctx),
>  };
