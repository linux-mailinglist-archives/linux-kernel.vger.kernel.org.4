Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D6D737232
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFTQ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjFTQ73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:59:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF6E42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:59:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30adc51b65cso5085057f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1687280366; x=1689872366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFGev71zOSbUwc9Ipdme/ZAxUB7isGkByEQJ4BO7RuU=;
        b=csYtTXyre+3fJAdfsJmH5x4q253rZjhqSL6nkUR9EbWvn0z4eQn99DEpJcvyMz/N2B
         xvG4xNctd5VW6P54WYaxari2Ksw/Ave6KKjVIMOXWEjYwEp4EAgNGjbI2i4/r1VBbRkj
         XG2G6E50aTAUO1Y4YwUKTkNyDt7N3bTtRJzVzkoN/Fu0OYTxCfnna5U9lKomemVvAKqx
         2iJAdKjqb5jcsva8gs+2WF9d4HVAcC6DdkSDx051c+yZRtucnwVj+2KL1P+A/FyU7uzA
         U8zci+DmIAG6SJMR1QdzgOcLgS5VjIf4SXO0+XMjNhliHWaFN92HkwPt+gKTDJ1QnyfB
         VUmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280366; x=1689872366;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iFGev71zOSbUwc9Ipdme/ZAxUB7isGkByEQJ4BO7RuU=;
        b=P1o7U3vM5JKfIJXdvqKFBYVI1Jw2agDN3HuSzbYxSuRYSGdPhiHsFT1T5VXDx4RaDo
         XSxVk9apwI5Dh/v2CY1Gc8vA5UthH6wm/Xcfk71z7BXofPsO9B4gur2fGd4LizJ0VdDG
         P5R+ElMp4FDe8mwT5vVu0O6MUt+n7DBTzTINUHj8OqfRWo5oUqtbyoHxZ3oBV4mqLp44
         e9UDdNuzIQa/Hrao4ghrpj/ykK0DS0QR+rmkivXdUBTbENi3Os9nBh451TcR6OKT4wf7
         7mOhe2zHh65D9SFExCI+oXj7cQRY5TaGAMgDEM8bKEDr84BQr8S0H3e4YmkBIqSJVsA/
         zTbQ==
X-Gm-Message-State: AC+VfDw7B3BOV9B/M4EXqa1LPAvNI2mfnwRiBecjucjsJIlO9RMTq0RT
        eiDEbAdSLQaDJltnLaU55vxOWQ==
X-Google-Smtp-Source: ACHHUZ4Od9jnD8B4wGHwa48B70g3JbHTkdUhQakX8BFWBVnF3ui5jOimXG0SRMmf1h+Z4StEnd5Prw==
X-Received: by 2002:adf:e848:0:b0:311:15ae:2cd2 with SMTP id d8-20020adfe848000000b0031115ae2cd2mr12172066wrn.15.1687280366354;
        Tue, 20 Jun 2023 09:59:26 -0700 (PDT)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t13-20020adff60d000000b003119633ecb5sm2364328wrp.88.2023.06.20.09.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 09:59:25 -0700 (PDT)
Message-ID: <973f8619-15ff-608e-250b-356f5c140a2a@arista.com>
Date:   Tue, 20 Jun 2023 17:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [v2 PATCH] crypto: api - Add __crypto_alloc_tfmgfp
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Bob Gilligan <gilligan@arista.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        linux-crypto@vger.kernel.org
References: <20230614174643.3836590-1-dima@arista.com>
 <20230614174643.3836590-3-dima@arista.com>
 <ZIrTQ1tN5LMuRB/5@gondor.apana.org.au>
 <6aa4521f-e5d2-ed12-ab49-1132409ab358@arista.com>
From:   Dmitry Safonov <dima@arista.com>
In-Reply-To: <6aa4521f-e5d2-ed12-ab49-1132409ab358@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On 6/15/23 17:19, Dmitry Safonov wrote:
> On 6/15/23 10:00, Herbert Xu wrote:
> [..]
>>
>> Good catch.  Though I'd rather add the gfp argument to a separate
>> function because I'm in the process of replacing ciphers with
>> something that uses the new crypto_types API.
>>
>> Once that happens ciphers will switch over to the normal cloning
>> call and this can be removed.
> 
> LGTM, thanks!

Would you prefer me to resend this v2 or you're happy to apply with your
proposed changes?

>> ---8<---
>> Use it straight away in crypto_clone_cipher(), as that is not meant to
>> sleep.
>>
>> Fixes: 51d8d6d0f4be ("crypto: cipher - Add crypto_clone_cipher")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>>
>> diff --git a/crypto/api.c b/crypto/api.c
> [..]

Thanks,
          Dmitry

