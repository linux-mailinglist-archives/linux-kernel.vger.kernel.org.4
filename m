Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305306CC82B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjC1QiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjC1QiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:38:06 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39428A5ED;
        Tue, 28 Mar 2023 09:38:05 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id bm2so9414092oib.4;
        Tue, 28 Mar 2023 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680021484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=niOaMmcIQ5d6RJO0Nt//2UemR0Oz+K87wev3NK3rfMQ=;
        b=jkTuM+CQqAeO8bX9TzOHI21lyclB9scMYdN8tSfYa75MraBBijfBAPFRJMNZpTbOrm
         aDyYodh/Fk1KOP0wpunN1Xk2BeX0GUooQJNqu5Pq4kJpceTu8J+j/hhyF3CBWy1CQUjf
         PKz7BtvKP8yMxuA29vV0SPH1Qrfk2bVT8DwexDlptWKB5U/QYQH6fg1h/DXDP0uHtzgp
         cDSA8BbId9Hk/DsEtVpsnH9bvmWJvz6oPGgqtx+FYU5/VXji5IcyWYm086fSh53BP3q3
         e0cOdmY1aEn745q//reTzMguQ6TN/fCRo0H7MMKAWKGRtFUQALyzxtPCpf54sqNEec5t
         CIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niOaMmcIQ5d6RJO0Nt//2UemR0Oz+K87wev3NK3rfMQ=;
        b=UXhKa/wQcCbVICcGgGGpZDyakHVR0pLeE/eaIuV2hrvdOTNWPcYhTodvRYJ6ZHp53F
         eYlpDEiJebXIklFS9zeXI4O4IsZUL37BBiunMGFcGk/IAgSWBnMq9UJBCLO1QoNY5e3W
         Q1m0eIC+9bxnNDMYR4sqYi9YDB7KN2ex3UXpDDDNWTh+8ReVJgZU67Hsdh40S13t/Hnx
         NTruW7juUFub87nVETpqVavSyhmrnmA5F84ELsOkvznLRkgEP2WN2UGjK7kk0VtKUKqr
         2QH+jzHA2J0PfD9UIszy9JWf0jNA8F8z99BlYXuxnfZAQQ4YIlbTwvVyE+KOAqoC0IPH
         0kkQ==
X-Gm-Message-State: AO0yUKUf+EVAVry9geGMgzaS1Q5Pfk1hLTNV8rO0nksZ4MxqYPYiyzLH
        muvE1OIenXGPuOBCCG7iLrQG213ekho=
X-Google-Smtp-Source: AK7set8W1b/wz4mopvo80l7uNrpbLdNFAWq7m1XHTmBMJMSFvcPGlJxVbQTMWpts3yrFEYE155E/Cw==
X-Received: by 2002:a05:6808:179a:b0:378:c02:bd51 with SMTP id bg26-20020a056808179a00b003780c02bd51mr7113342oib.33.1680021484435;
        Tue, 28 Mar 2023 09:38:04 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:2c78:b015:8039:f06c? (2603-8081-140c-1a00-2c78-b015-8039-f06c.res6.spectrum.com. [2603:8081:140c:1a00:2c78:b015:8039:f06c])
        by smtp.gmail.com with ESMTPSA id e17-20020a544f11000000b0038778d9d8efsm5453819oiy.56.2023.03.28.09.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:38:04 -0700 (PDT)
Message-ID: <4fd06223-e307-50e6-f4ec-40ca34fc1a4b@gmail.com>
Date:   Tue, 28 Mar 2023 11:38:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: linux-next: manual merge of the rcu tree with the rdma tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230328121609.68105dd5@canb.auug.org.au>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230328121609.68105dd5@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/23 20:16, Stephen Rothwell wrote:
> Hi all,
> 
> FIXME: Add owner of second tree to To:
>        Add author(s)/SOB of conflicting commits.
> 
> Today's linux-next merge of the rcu tree got a conflict in:
> 
>   drivers/infiniband/sw/rxe/rxe_mr.c
> 
> between commit:
> 
>   5bf944f24129 ("RDMA/rxe: Add error messages")
> 
> from the rdma tree and commit:
> 
>   330f72b82ab0 ("RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()")
> 
> from the rcu tree.
> 
> I fixed it up (the code modified by the latter was moved by the former,
> so I used this files from the former and applied the following merge fix
> patch) and can carry the fix as necessary. This is now fixed as far as
> linux-next is concerned, but any non trivial conflicts should be mentioned
> to your upstream maintainer when your tree is submitted for merging.
> You may also want to consider cooperating with the maintainer of the
> conflicting tree to minimise any particularly complex conflicts.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 28 Mar 2023 12:12:24 +1100
> Subject: [PATCH] fixup for "RDMA/rxe: Add error messages"
> 
> interacting with "RDMA/rxe: Rename kfree_rcu() to kvfree_rcu_mightsleep()"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 84b53c070fc5..bbdfbff5c752 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1341,7 +1341,7 @@ static int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  	if (cleanup_err)
>  		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
>  
> -	kfree_rcu(mr);
> +	kfree(mr);
>  	return 0;
>  
>  err_out:

Thanks, I thought we had already done this. If not then we should. This is the correct fix
for that rcu mightsleep business.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

