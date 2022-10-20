Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627D606596
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiJTQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJTQTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:19:34 -0400
Received: from sonic301-38.consmr.mail.ne1.yahoo.com (sonic301-38.consmr.mail.ne1.yahoo.com [66.163.184.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFFB19C20
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666282769; bh=p+GVUKYMePPx6satGPTLb5wyX8HaL22BCYjKoY89P/Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=g5tGTJo5OJLvlXZD+MJ1YzTDhkdylimkizWgB+N0VI6wfncopVBQEtmXeTqVW3hqKZKlwcRlA5q2VNF+3DWG+GOfH8Wopq1PYNke9t0IGME225767ah6OCcHtmBa3f5P/XR7ta8s51Q2CN+5OOUxJiIs2Uy33O1c/D4XUunimS0s2jQHl4ogx6G/oLCJpggbcSIlXsYAk66RmxBdLZ8BvRDvDBVQK6ht4nrrXOG09baz6xo+eW1CEfjZQTQpEdcZV7MMl0ZNjwRD/sTm1w+DlGnmFRHHY2hqr2mF56XuP6hRse3gosaLo+Krex6iAuiFH6oPYrisrgb0uqwqMxjeMA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666282769; bh=tQdNYP+VRSnihi0D9f85sTW1dXzvyzuE8tizoGZ5KF0=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=mA77rGswYhsnu8ky8A6ZOkWXpT2OrEK9hz/zOdwNxaUkFs9KGkw3HDpyacLPIi8bdsJeBV8KSR/z/05+pM3zdff21Arx+v1EXIyr53t0tkpEhQXd+c9s46/4rEgjqjAqd6hNmG69wGb1K+BwYe55TKLzOnWpCrG+KKlZIiaANaSfSPUXUKm8sjYSLxI+Y8owbCwJm0FtTJu9xJDOe88BcCgr2oKvhoZnoAHmbpE3TaKx7P14omBEtIYWYcfezL8FWJ13bOdTUp+Exe5E8M/Nr9Om0db4eabGknzckTTGbtOl6vF0LvvGMXdrzn59hr9aakJtQ6Qk46lLbuS6tqGTpQ==
X-YMail-OSG: C7Bk8vYVM1nAjbWif9Dg1TyLOC9lX2Nr9OW9h0tlvMhtGESvHJzspCUckcyPNzU
 bkYJnPz1UwLsAJfwijYUTnVdYTwuKiNRgUKYieq_i5kWns_X3QQ9v4NljsJ6UzkbXlmh60eTC.2x
 yOC0ZQSIBSwy_0AnJih1cGkM.WB6AOZENe_kzVBbab6JY0WeuLWhZ..4rdoynkVaDofGHZUjcnnn
 v2GrpmZZFCkHGdiSM84a4mkgNffnXarHGTFGpiVxeqAZwbc3TkwDwJ5JQMWyXqSDwE10hPF6IQ57
 sNcD9TvQIwhGlDvuGtixgK1.bWU8qpcZas928ZD8bG3SC4WD.hRe2t668S1rNFruPBZ_N6oEOSGP
 ZGcIF2gm.STHDpQeMfIL8ysN4c6E7hL.YwL5k2EBqIMN6Z7vmXgbKVx4HRfkaNnkHTygNH8EyAho
 0NWmsA8hICnvACHc_0B4J3hOhVNE0dm1_KS3eGt3zAZCg_HyFX_66Tg9ceaVKtNsDxggsHP0td78
 JygbznFjvo1huiXbQY0HTOP7R3wceaNOTkhK3gDy5euHAmIvv0it9.PYdb6tMJPgu9uuXsLohBQd
 mOdjsDd6DPVdrJ82RCKlxLNMUwBv6EZD14hpA0Efl8gUrqZnpw7kK8z1j_uf9HH0SWx4F3nSDhx1
 UAp7Lgq8chG4HZLlUOaIfLc9MJ8VFA1MMahX4ew._CpnOPVLoEAJq60mBxUZsFR4.zH5.FgEKrdc
 Y9yovF9dXMxIFbXGiZ4C3ODT1OSGv5TLVjghw_8hC.OTevqPlGSbhxmxh.GUaNAezjVZ_yd7g4uE
 EOK1bKywXxKQnanHynOIqXxrjlibKC3I12IwtLGhrn0LtreLV8KYXXMbub_DyAx1heATiY0fVXaX
 0Xdr5cOm48payQOXPE5sWotTXG2CHibXhTyFVufJUW4qT67O27iRt2tHmZwpFIIMb9ky08_Hi0vk
 0XyeRLK0rsANz3l6XrIm6OWNQsTNw1r15JqmYsCcXzRKjgh584I9kGy1SCIVAB3fSFAbMFr6zH9h
 j8M0MJLYuaUNEBFVNfQFweuKDioz1OWkZC9bSYtXwN7Lww63EupTSUlLR8qlm.RwXuEsHG1BC9Ay
 RsP17iEJ4BKlsxpMmCg4Bq1kujrtwXLGZWkIlnZndnODqJyC5uYM_joJJeLRiRFNnrc7Ewb9zbEi
 lfA0Q4PLeUQRatuJCXe3PTVMlCA9nkJZCSz1iy3d_YYINhqGcYYP5dDsBjWLKy7DN_CLxi63e_Uj
 fyNwMWYUDOOdgpPkItqiTda7AFhBTDIY2jw3xdYUDsIk1LmPuH99QU0Tth_EmsPtz.mutKiNejKE
 ZeentkR1L_g4nt3jwPrGYMi0JfkGhWiF6_acE4ApGbGvYvvMmapoOoh_.TXioila2NanKuECi922
 N_7wPOXGpG64ahHWXRFkR5HEkesZbmO_4c5B58wKO2FEb_nWo6kdGEib4WQjpV7hxzie1unVRqfG
 JbBdgfuPatmqI2HPBb224GBg7tgiayx1Q6ZJ9dVmOwlqC0ngkjkpPcSSdMzmKJ7UpuLjkUYQhAk5
 m6byEOa8Cg71c4FbfAY2PdVaRx6Yx7I0zRFORKWhz57Cby9y_SDgcCv.fRpQqTq7Cc2ob_tpzSEE
 UavLgeiq_VXh0RuXVOs4bqSweRc1kfFsBd2JqHbb3QjltEFjuiS6AKdYjBm4A25wj1m16KpIwj0R
 i5X7TkL8zbkuRPoO.JY7w5WMLMM56yUN2oPAq2IA.CTiGkj1xl04SR2LmmcRP0cHzlvqFxaw_HnN
 Ld7MerSl3BxsQ0G_VCzWXXONJyf6K5pL0vSWtT_gRLZppVhZWmVuwyRrHThlZSZr0wSHowlI4AAO
 9QnkNMOSMrPMjwNBZBAzhKzww11W7DUQXMdwoAgFSRsWD_05yj0jYEMeXlhO4P7kii.8xSH5KkpO
 nWCQCbok96bNcINFCyy_dPSNhPgjnrCXf.hC0jta7dGofDJlIot7cszRs1mW0Wxvpc6yaL3eXGW4
 sENGEhh0W8ev7KcpzZzRYQGUu9nPSlopBxr5sSobvfYogOh8kfUo8q_qBO5MLESaZGnHEINNwd3n
 qp204tP.76Vn9iSZOKya1zZHj89m82SwVKJidPeVO.kCyPXQRbq5xJYk55I2Ljg7toSPf0ueSlOk
 ZR1V2ZHCPA4XYBczfgls_ixcNo1eWkQkdH98hsGUs0Hb88Law8K4v_CCtxVkdP79iCwlBHJL5XSa
 THw73lbhsoCQaI4xy1SzGkrxbukVkY5rw0LQctCS5umdGxw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 20 Oct 2022 16:19:29 +0000
Received: by hermes--production-gq1-754cb59848-xxkcq (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 13752a79cf0c8a793a905a301e0cc8b6;
          Thu, 20 Oct 2022 16:19:23 +0000 (UTC)
Message-ID: <0775c82b-d890-c4fb-6e3d-0c9a8ff5cfd0@schaufler-ca.com>
Date:   Thu, 20 Oct 2022 09:19:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 cschaufler
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        linux-security-module@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        casey@schaufler-ca.com
References: <20221013214637.30807-1-palmer@rivosinc.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221013214637.30807-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/2022 2:46 PM, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Do you want to apply this to your tree, or would you like me to
take it by the Smack tree? I'm fine either way.

> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index daadd0de77a9..019cdb48e254 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18723,7 +18723,7 @@ M:	Casey Schaufler <casey@schaufler-ca.com>
>  L:	linux-security-module@vger.kernel.org
>  S:	Maintained
>  W:	http://schaufler-ca.com
> -T:	git git://github.com/cschaufler/smack-next
> +T:	git https://github.com/cschaufler/smack-next
>  F:	Documentation/admin-guide/LSM/Smack.rst
>  F:	security/smack/
>  
