Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931675B5EBC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiILRAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiILRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:00:50 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C88E2CE0B
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663002045; bh=ckBjboIVh0Q6F+6MBN6ivt6Hs6U64FQ9jBkEGYilDW8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=odx5qo06fvrtHyzydca/AWkJ1R6UV2wFH4jl2IJjgegXwW/fU1UmerXcs8h2ccF9Gj4lCVLVo8YnKOzHPkco/v56hnThyEGeIHA1ja6qDz6eUSzU3lgjvjOHzA/oNnmt7+HykElPXmIaY3S4kdkcnZ1GcFvlGLFw3/CMJI5+on0HQyT1PEP2ybCwYU9+rVoVXYbCKyx/ZCSMtkKg6hr32/l1M7FRaGFHZ8hsoBuq5YQ5LqVvAI0Hknt7+4gc12O2jfz8J4o+qw6IhxnAFNqzj2wFYUMZ+65s638aGwBFFk210+PrTM3WF09io6GL+L0LeHUWW2bqAqOSHVqyToFPMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663002045; bh=aG6rhbGYPe0YFvAkpDSh3kf6mgyLWoypelj6mWT1T1n=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fTTjVCU36IRBN/O+qJkkqS/pKYk0lIDxa9vJ8g3WrIlDt9Q3g3zvKa9LXFHCkQ0c4WKxN6MlVNlM4eMIgV4DTKprHAHrfZ+LOpHHNRBkz0NwacNdZj4XntxpAxJFcEJHa0oWsD/W7IJ3TXWUUdnQM4EZuCxwRqgIkE/6M018ieh/MhYjcqEHMp6NTS8yNgO/dUo7agtEWOpSCQVm36vgZLkyI7U1YcDaqaRbaVF8rz2cLN2uHgoHkJcerENdORs/fykL4LqqgsmjKugLs2RqakZ23JZuw1s+rDhQ2Fkx/pSZ8BkANgs6HOVo1Q6GKFvpVxBja7SUnbf/fGqbdAtAvQ==
X-YMail-OSG: PCsNdiYVM1lrIDVLvZPkzaT2.9_QyUlvFzSVAd_z6nfN0yG_95FtyZAQAYlbtGb
 XYZGBKSvMe68DntkPDlbADUDYwyhT6nnhu3u8ETBO6T2i2ALctWXRdt.rKTH2hb1n4ajPc2ND6Zd
 3TW8mMW3MAQecR_Wu2CLc0PzVXNdt4Hr.KLsdmrHrB1EdlxymY013gMdaibgplrBhrmr_DywCSos
 hdRtXsu5B2kaK2wuZosPUtBnbk6JL2zKdHLSFcBZPROofTQWLBBXq4Q3YocvKTtwwORkCY6_9LD6
 RLLXLCYbwmAk7yysfcghMcY.0eTcW.InniK.7Nvk74G8kJML4zsYZLXbIPWFjH85941ticoIjm1o
 zFuKt1Y41r2kul5Kq0dY6uRvvNtFoTYpEv44vpWjs.KMynha2ei.Ex1P8Xwdi1nwgY4UK2HJSG7i
 SG0DnUTv.wbcnxvOcmmL4rfBEdq8sDn5CYq4IzrXNMRtncZ4ZgO1KRDryEzhv93j2vVv6135wBTQ
 boO4ncKSRe61RC7YWGlscvLmG6AVDWE1lx4k7x_0PFcvoNKso1mLUCdYAEZj17_MUHApy6fMLs2m
 VV4GQ8GfzeFa5Rf7WIt0aasbwv14W9o8Hp4_Utee4joPxHK85Jz9rcGND3ubKCOa59dnUAVyBPgJ
 VNl93h0c32lDz7LndnawckJXdD0_BdwrR.VxXs0SdnIhCA3SvDlvmdmyOQgMqMij7MqVqUqiWXHh
 viogDz6UiHAcqBiSmVhveuzsmaOLmj9kYMpBhg5Jrpoq3SWaW6VT5pX1yGBPWgN7H6LO6sGF5s2R
 AswO5Wkp_ZH23VrzdTjlfAJFd_i6mwYSYe7yWSfvH7Zik00j5B2skBQb_LDnwaDtUhWbW2w_.hdO
 gJxxhhcxhEuLrdDWKOT6Gt2sddDmZaYGuHQ4diKa3BdQVQfY7SHnhuWSPkabhdPatgy.P3jT2.gK
 89tKgvtTZ5CcR1E4h9MEAMoR1BEieQj37KYsDskNaISwtqsT6uez2rbTxTx5WtF4Sr8_MB1.LFNN
 hreyaw9SR5PQgq3Ly2COxbTx4OUrB.3Og1TfZa21NGgeAJFqGWt.nB8piDhQgvyJf5eOBj5gtGcW
 CRtfp7obP9sVznJYN9454g1d98eFfjmV4OxJjmrdm5Od3z9IZcMivHUhvZ1cmAFwhTs_9fIzXAKi
 cZoMLvkgoPG5vxFPkChE3Zf0F2JmujPkrSqC4V8.Gdjdo.cD14qJjjuBlpjyNDJww9alAc8wV2jz
 DBLPmFsJvzD19Qle7ioLIXD3AJdyPfcWLjV2mFm6d5VcJSNdqzgsFw1EHQehB6CclYdMar7RNQ6L
 NWDp1zXkJYVSRgyYFHeJCp7QV3hYRJ6sV1uLbK6_uwXrwfJsscpHvEokuEyNwPWNfTYjdc3a3hd2
 v6Bf0NHgSRgM1ZqHozTeFL.gj74SY6dpiVbFdQH.PW9abywsnOkQ9ytwz1M4puE67CCL7RD4cI3G
 9vwu7d4u6RNsrmf77es8QsPXdM36oPwCXUt0L5yTtI1v0bQwpSv2jrj8p40TE7sJU_WU5eLu.jnx
 1OQW.6Z3jVudcth81LELVQe.kjHUaZmE7zK9HyhMvFgfahLV4AkWm9MtqIBEI5zbJFbxLlmccGTw
 LDEx_0WKbceTuvPhYWF0e6H49wC0TWnFc1.zObwJucnHOMenkGAACr0OzbKeCCXyU_FoqtZra40R
 oALeB1XC3UM6colHNMqRicWLoPHo7ruBkDbyveoFi9myVz0HorD.WjcXN4kwZtN9L90VNi7CBTSu
 cipuxVBge.f46fI1c.nJ6QUH4pF_VABl6WY_fDSTZ_E7DxADpW.E_c83xDK0v.eXLFqlHqhNYbLw
 00vEkoO9JJxs3rB36lEK8GdfPwVAAgg5p2pVR9g_qa3oRZPB4kzb3VXvgeKC7D5tjSGQHcvQ133E
 4sVm5t8h31rsOdFXIBB4Jq.1mWjOa.4FPXBGn146nrUXaGVTUgQB2C7rpAecY3tvMvszCXvnFVl.
 AwLdDdbujU9qYs_cib.GaLCbGZsMU5EB9Vl5qV_PdptzRWl9_5mQ1m.tUb8X18mGMl7d_Jlh1fYs
 fsgpe680_F9eau_V5FPvZVRqV6VfAYMUtE2tpEtlKIPWhEYmco7qBKvT9zau.YiG.ZaL84eDgo6m
 Fnf7U.pL3XibwJRT8ek6tjY12FV9e22UXkjh0n34d0sOka56jBjG4U7REiXXTyFC24aEfn5L_R0Y
 _F5YkTbdwDNeVirzoodWaJpErusYO7vNcWc9L9g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 12 Sep 2022 17:00:45 +0000
Received: by hermes--production-gq1-5499fdd576-49dgt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 76ca5a0e9518c55aee3f067fe815d5c1;
          Mon, 12 Sep 2022 17:00:42 +0000 (UTC)
Message-ID: <17db01f1-0e53-fd25-d5ca-622003ddd42c@schaufler-ca.com>
Date:   Mon, 12 Sep 2022 10:00:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH -next] smack: cleanup obsolete mount option flags
Content-Language: en-US
To:     Xiu Jianfeng <xiujianfeng@huawei.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, casey@schaufler-ca.com
References: <20220908103543.194119-1-xiujianfeng@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20220908103543.194119-1-xiujianfeng@huawei.com>
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

On 9/8/2022 3:35 AM, Xiu Jianfeng wrote:
> These mount option flags are obsolete since commit 12085b14a444 ("smack:
> switch to private smack_mnt_opts"), remove them.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Added to https://github.com/cschaufler/smack-next#next.
Thank you.

> ---
>  security/smack/smack.h | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index fc837dcebf96..e2239be7bd60 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -180,15 +180,6 @@ struct smack_known_list_elem {
>  	struct smack_known	*smk_label;
>  };
>  
> -/* Super block security struct flags for mount options */
> -#define FSDEFAULT_MNT	0x01
> -#define FSFLOOR_MNT	0x02
> -#define FSHAT_MNT	0x04
> -#define FSROOT_MNT	0x08
> -#define FSTRANS_MNT	0x10
> -
> -#define NUM_SMK_MNT_OPTS	5
> -
>  enum {
>  	Opt_error = -1,
>  	Opt_fsdefault = 0,
