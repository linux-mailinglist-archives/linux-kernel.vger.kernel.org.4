Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2756153CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 22:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiKAVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKAVNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:13:07 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07693A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667337182; bh=y7evtBZqilyLoR6Rin60Y0gr4OxBOwwInD/K7bd7ScQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lccOpcJ49zCDjnl/56ZW2giq6XTj3ZJrgF7XwM5gJmlHQBXjZF2y8sNxY3L3V3nFW9fmGQqkmZDsAMeqdyfaEo0vBMsusK94bC4gW0ll8cAaEMaPV1skNayhFMUY/QUTs5Qe/aNAwEMF6fVAz1hvwfGcL+PM+yzuvrPXjpkIq+nGyuebynFIviNKXux7JXlV4+RF5lDbkkJQzGVC64/QmmLZQR4jp6b/Bo73eC9cBaE/sANa8CV/+zHsrJ/3mUoBLqU0jZ1u+ILmXTjr9P0NIMtToZC05w1zsNk23RFZkY6RYzs0u5WMka274qWXAQ43rCo2sjyyQw6B9UVZrv1/7A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667337182; bh=YrcFPzAa2fW+ipk41vAUMpy3Tg8Sza8yCxD3i7oIQOH=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=iU3uYlYAsnE3zRPtW4S+RHVKg2RraZZVm7B0/pwuY8sIRj2NH1CIUpVs8UJHtWWjCn8CGBl+3bmW1lcY2f7QdxWyi1L9vJKfW2bASZgQ+yx4c4G6yIAxL38UX+n1ms408LtgSfJPGwx2umOxTn+31WGFZt3XkhmtO72Pgu2lZjdu6Mm7R1kbUpxkPo0WJr2rTSztsx+ATs4O67FR2AA1nGc/kNJAGOwo1VLgpSI1mrXSYgT4L1V7gDrTVOS59ooQfBWDDd3R2x0q7kiHzb3BgC289V0c6pyulKZJKIepnFbJUbZSpVWSgJfNmvjRfaGyXci7bnfXRMBapMAC4Tt26g==
X-YMail-OSG: 6zZTxlcVM1mSuS.TYWtqXVMKdep.LJcuqs12kpwGzSRReOEFtOwacjeqx9d4PXE
 YqMv6cxulz2mxDQKwXVlDxF4w0tFdDpCWCsigNXXGsN6Ku.doP0LL0RAMiW9bKIV3PBXMxMF51xF
 CguQIdDsyNTiVuFb.g9IFqiduke8k26lj0JOt2GVHvQS5EF9.Sl3EOQ2ghAbNMObUJRbcI2LaX2z
 GdwMwcMUcJdnmgjUG5weqdEciPQFPPyMxaW5ysztkKJH4Zo2PCZIq8JNkuiIIeSKz_TkNYueo0Z0
 9GnCwsXH6jNsuQIEh1PcOTQ_vc5vgp_ZPsazqcKE6YERsVulkhdMOlYrh6vsq5iBohn21u4xvZk6
 j0rk6zVwYUyV66YJBicn_wwoWPdEvXFoPkJLPuZu7ndQ_gnIQFbxU6UrzTVU1nuhgNJhe.Vg_X8k
 dUdTBmsk_XZgYOgmagM27oWrZU33dNbuyrZ1abAaW_wM9qNVmeHeZhuszuRrhZEAT1i8cv6OmogV
 1enf_iIcSeP3AYywFUJcuvYVSV9sZB3aG0CJ.gDWsFBdp4S8rD55EMLrxQPL3F.Jyb7G4rU7d0__
 vJDtSotLU1whKFn0H_65d7uaIdYSodJNY6Uuk.2D4B5kLcBE0unecaGdjQ2S_yGNAiDRHsjAtc03
 D3qGHUObNEQ3OSScgxwVwx5Fx6MZO2zINvnJC9_qq2HFWvS_OcQK8WI.kQ8WxZi5FoV2ZxF1uGEc
 pGU9F9PGzGHzMepfLo42TwjWiqeWL09udUc2xFOheoIgXVKSkl3nTARkZBOWrWGgitC4bNqKROP1
 j7cLIXm4NpAb9I3ZdPtF9OitY8VL8P9K2mFF8dhNWnwFkijloJcdI3QH.pq04PEzR3123GBH.4.i
 7fYY6R.EGVhngG6GUv8lrEyRwPbkflQbIJSFc9N2AvL0ReiOQCZJGoTpY9LTgoaes7ND2633m_Vu
 GRagfswqBd69UD85MGdeAO6RMtsxiirtXvvg30jWiqStfkCV5LJoE8GWptp6pF3Mu0dpq394veHr
 ewjKqzkrtDQ.KgWUbwRjLG2hX0G.1.xX4LHiYML.i6DVHjnfL6pe4RnrrBFiPn.Zq3BM_Airzy_i
 pa7Wmo65z52piKt6RyjIOEMMFc_NMSnvUrLMV4kJjybJ0JdaKf7pTUxYo2GiuHPDw6jzRpPC5fr9
 h0BcjPP8zLzA.7yej2zTjxec1VCgc06_BH.IDaVbnY1zWy3huWIvLgSTpJcjvFHcackoMG4EMSUe
 JpgyWqoMM0rOF7f7Rlcj2zlyYV3R9olLiemMjMIXCbHdf8nnreGuWryy8l.uYfcuAfw_oCXiEbYH
 F_ojJXSx0yc2beCsnaEoi.mx.5UP_fefgB1hCsKtEJvwvdjHGZXBlDpFujSAi.8XmuxVs1Z2TrIx
 zIyo1QGfM.w9zSfWi1n09bAaSnEG507j9guVuSYqFyPSPPOJV.6pD0qtN7eX347eU52Ba6Rbjcz8
 FLPCXGjFr7GWMTnPgLcH6D36OH4pEx8WUi7Tyk.rATVibPj_IrDAxCJ7ZhADM5aXa3E0Sjq1q35I
 qTJNNTv1CoyfRQUQCVGHfHc0kGNsiTc2qFvPxavTZujRGStSOgI4_Y6LZlB4bi9cjzVDcoGzXELv
 8MOn5HfZGMr1Ss8Maqf.qe9jreSr5errM5tF6lZQuW4hIuNxKqvsLSkWZ.cKlQsfmWoGCHYNYIPf
 MjPAlgTiVUffPhK5.qDbmuAmV61gydatQvs8WlUU8B8NyLwXI0w7XkvCX3gRZJM.c4o0Cv5oUvtp
 T7vKzCr2pZ5OmFzO4qGFHBN2KMOVfHJLL4nijPoKsPxq3gFaGOyaR7P7eTxPTsIUSjXFz9quloYz
 KsetymQg89eg5rw6NEr64Te.8paoGrZdeNZTtGxXD4iy3Nh72Ei2n7IFz6k9D6.Vp6MjhodD5rOS
 jvsW_5FQG.RH0IeC7GHIw7toz159.uGe.1mqAyk7vMPftamMdA8jUYrE68KqddGOeyiTFRcPVmxS
 Wa4Bcr0PlXPFLXArTkyCtSbFcAx5EFAMrEtlkHd_Ljk1jSIn46fuBQPPDWMUlsCsF4d_haYTwv83
 xCUYjOd4SgGyvrFIHt6fLnhpMr_b9kQF_FlmvYXWoueII_Z8_AmXiLQJNtC2agG.OW0RfgB1qf5y
 CGJ2C4Cg681fT7TVgPuwqSSCkarinDBNKN3dUqgwTSSxAIeI44nuO60_K4xW_OIMuXWerTBmpAw5
 kxDiDD7GxBDjPstb8qcTICgkllZzFIqGXLss-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 1 Nov 2022 21:13:02 +0000
Received: by hermes--production-bf1-5878955b5f-d26fx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 02dbd698678bd0a8986b376377bc8d93;
          Tue, 01 Nov 2022 21:12:58 +0000 (UTC)
Message-ID: <4929fc7f-eb31-6ee4-0365-1b0f61ad5946@schaufler-ca.com>
Date:   Tue, 1 Nov 2022 14:12:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/1] smack_lsm: remove unnecessary type casting
Content-Language: en-US
To:     XU pengfei <xupengfei@nfschina.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20221026082923.3400-1-xupengfei@nfschina.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221026082923.3400-1-xupengfei@nfschina.com>
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

On 10/26/2022 1:29 AM, XU pengfei wrote:
> Remove unnecessary type casting.
> The type of inode variable is struct inode *, so no type casting required.
>
> Signed-off-by: XU pengfei <xupengfei@nfschina.com>

Thank you. Added to smack-next:
	https://github.com/cschaufler/smack-next.git#next

> ---
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index b6306d71c908..853c6878edc0 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -1409,7 +1409,7 @@ static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
>  	struct socket_smack *ssp;
>  	struct socket *sock;
>  	struct super_block *sbp;
> -	struct inode *ip = (struct inode *)inode;
> +	struct inode *ip = inode;
>  	struct smack_known *isp;
>  
>  	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
