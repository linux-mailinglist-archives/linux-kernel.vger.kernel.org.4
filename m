Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750D7621763
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbiKHOwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiKHOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:51:58 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5676917E15
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:51:56 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f27so39279859eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 06:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VVlX3J2MRZ0bpfrT1wqBoqQdfnyP5OOMorGU3/AIj0Q=;
        b=DllhMH06vFb0iqFtU7VRO052SlqXm8Z5AGV9+tP2ZnQvMeg2KBNVP6W3A1knrBmPXo
         SIx7QgrIoLoZ4AEqPlLYr/EP8d19OJWuDAwsuSQ8NS/YKwU4rZ3VcE9Fs94u9padDnCA
         rZNXxOYyGAF7ddYtlQ/xI0kCZkirfDQHdRcLEK9FyVGpp5VHw0fQ3Uzuj5B+gBl7Cr7Z
         8WnYNJxxBDlfP309F2Is9muUjao4/x5LrON4aHMZSRSb6DD2XiBy0LlpPvHOsH+FqM5A
         HxTdlwOcIRe/sq0aNfZHcs4UMo9gsVAQ3hrha/WSp/Ib9A2Boqx1JCAwxDKNKBGVkRy0
         zikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VVlX3J2MRZ0bpfrT1wqBoqQdfnyP5OOMorGU3/AIj0Q=;
        b=opSk+jLJdNTFsY2IutsRhN44P2SfQjBu4Zo9GgmHxUHCUl+uGQFpIINR55shezHF7i
         GtfQhNVgGCb21sdYawKp6pCWxNw36TY/Je3HtD1PECisAWKA7dfGEmzTbUtSZmUOiQZQ
         YjN9I5VD2i8dilF1bYSk+YiN13I48WSbk6FmdfMyYdUPt60v5oZTx8tvRGumK7qJsKpX
         AkJjfEGQm1FLvIZBKpJ+KlkSIvy3OYfWckO4JHAnKDD0W9h+qt1xPfm0YwnV6TyxKfO6
         iRtxywbJ1p9/3ztE90gaXe6UKFHbhnR1nBn/2itiD4V6lR1PmWcvKXr6XTMb9EcCjv68
         5Vog==
X-Gm-Message-State: ACrzQf3W7khuGbOIjyfe3ZbEGRhp3Wr5lXCBJxRKS70oKKQp7x3HqE8E
        TavY+ojxtJcaWhW5Of8M80U=
X-Google-Smtp-Source: AMsMyM5lBicYYShK82H77NBIMdHdrcaJuLKtsrgoguKRMcBe5j9fGhygFlfXYP9tHF1v92hrcjZ5/A==
X-Received: by 2002:a17:906:195b:b0:7ae:108:9729 with SMTP id b27-20020a170906195b00b007ae01089729mr33254321eje.604.1667919114796;
        Tue, 08 Nov 2022 06:51:54 -0800 (PST)
Received: from [147.251.42.107] (nbbroz2.fi.muni.cz. [147.251.42.107])
        by smtp.gmail.com with ESMTPSA id s18-20020aa7c552000000b00461c1804cdasm5663142edr.3.2022.11.08.06.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 06:51:53 -0800 (PST)
Message-ID: <31526702-6b27-b1e1-be80-4ffb7b42647a@gmail.com>
Date:   Tue, 8 Nov 2022 15:51:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [dm-devel] [PATCH] dm-crypt: fix incorrect use of strcmp when
 telling if there is no key
Content-Language: en-US
To:     Coiby Xu <coxu@redhat.com>, dm-devel@redhat.com
Cc:     Mike Snitzer <snitzer@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>
References: <20221107122233.261096-1-coxu@redhat.com>
From:   Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20221107122233.261096-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/22 13:22, Coiby Xu wrote:
> strcmp returns 0 when two strings are equal.
> 
> Fixes: 69a8cfcda210 ("dm crypt: set key size early")
> Signed-off-by: Coiby Xu <coxu@redhat.com>
> ---
>   drivers/md/dm-crypt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> index 159c6806c19b..cfefe0f18150 100644
> --- a/drivers/md/dm-crypt.c
> +++ b/drivers/md/dm-crypt.c
> @@ -2590,7 +2590,7 @@ static int crypt_set_key(struct crypt_config *cc, char *key)
>   	int key_string_len = strlen(key);
>   
>   	/* Hyphen (which gives a key_size of zero) means there is no key. */
> -	if (!cc->key_size && strcmp(key, "-"))
> +	if (!cc->key_size && !strcmp(key, "-"))
>   		goto out;

NACK. The code is correct.

The comment is a little bit misleading - it actually says that "-" is valid here.

If key_size is 0 (see above: key_size = strlen(key) >> 1;)  and key
is NOT "-" (empty key) return error.

Key "-" is a valid key, means no key used (used for null cipher).

Try this with and without your patch (it uses null cipher that takes no key):

dmsetup create test --table "0 8 crypt cipher_null-ecb - 0 /dev/sdb 0"

With your patch it no longer works.

Please, run cryptsetup testsuite before sending patches, tests/mode-tests fails
immediately with your patch!

Thanks,
Milan
