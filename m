Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A1272C286
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbjFLLJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbjFLLIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:08:47 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A551B3ABB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:57:31 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so28755725e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686567450; x=1689159450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W3kmvUAfNo3YbORL99wyB9d/VkxQG+CDQISNkS7AYFY=;
        b=LbtlzcSpmCCuP4cm7gDwerVL1WTk9KNh06oHq9A0mwZTE4G+ZpxLqhwilrdo/3hoo3
         QsUrFkAy/k/STcQupiaxgaWtgyIMwXENuCeVNBBnp+k+W5tGENmphRRzKVgZx7C3okm5
         T4EfzBjd40y5kX4ueOq4j1qRqqJmz+tKshdmXy1KaYIfecHsq9EpUpIUj7HKheeRngPw
         sdMu/QClAIkcDd6hzSAdtFk3MLofcdiUtQvVd47tgEuRU8z2vbyyKm21EleT/OEidl64
         Yxdi9vCi7wltWFQfSolkQYjGOmeqxT1OoCStSey2VhEsxB2fyZu7F6cmjSe2fvngWv0K
         5Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686567450; x=1689159450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W3kmvUAfNo3YbORL99wyB9d/VkxQG+CDQISNkS7AYFY=;
        b=U1wkL6LRJs/qHc6lpqLIuUIB4S4aL+jnlYUczL2ZTwuX0EOPY5bgsyuOb9NyF0vbe4
         vHqkOG+9cCprr9MyaUt6S69Zzm2PkBYJ+eeLIzRuxspRCLrzgRbpuyoo9xz7LEur1AIm
         L6YIBbyTtGCSH8GxlhH/YhGnyTapHhUzXxjxFWt1aDncnhTfa6buTU82uQxMPXJCmUOf
         LX73uuwpRsQLRDuVwnFsHY66A8O/2GMe3Lh9HULiRmHbEuNhdB+Tfpn3IyYgxgxpDNps
         XS15w7JtNfS05P/EjbT0RBQlKkxOr7+ZPAT1aYPXi+sf0Fdn0B5yVFAWmf8RzPHWzBXq
         PBcg==
X-Gm-Message-State: AC+VfDwBp0HiB88A20qxGRDrvOgKe9FsR6W80TEvNNO3BKBE3CkoJH3D
        N6XB+EfaX9NbVeAh9KnvusZFug==
X-Google-Smtp-Source: ACHHUZ66P2FM5CekuhNr41io1xfJ2KVdwDqa0FLk9jJsHmsoS/bE3S3iqKRvLRp1yuUtDYfNOlpO/g==
X-Received: by 2002:a1c:f718:0:b0:3f7:3526:d96f with SMTP id v24-20020a1cf718000000b003f73526d96fmr5775811wmh.27.1686567450090;
        Mon, 12 Jun 2023 03:57:30 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id gy15-20020a05600c880f00b003f7f475c3bcsm14697856wmb.1.2023.06.12.03.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 03:57:29 -0700 (PDT)
Message-ID: <b65f4d0b-cc2a-f4d6-5d9d-a14e6a9cc444@linaro.org>
Date:   Mon, 12 Jun 2023 11:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] misc: fastrpc: Fix double free of 'buf' in error path
Content-Language: en-US
To:     Sukrut Bellary <sukrut.bellary@linux.com>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230602113602.1271695-1-sukrut.bellary@linux.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230602113602.1271695-1-sukrut.bellary@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/06/2023 12:36, Sukrut Bellary wrote:
> smatch warning:
> drivers/misc/fastrpc.c:1926 fastrpc_req_mmap() error: double free of 'buf'
> 
> In fastrpc_req_mmap() error path, the fastrpc buffer is freed in
> fastrpc_req_munmap_impl() if unmap is successful.
> 
> But in the end, there is an unconditional call to fastrpc_buf_free().
> So the above case triggers the double free of fastrpc buf.
> 
> Fixes: 72fa6f7820c4 ("misc: fastrpc: Rework fastrpc_req_munmap")
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Not sure how was this reviewed-by picked up on this patch.

Suggested-by will be a right choice here.

Will manually edit before applying it.

--srini

> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---
> This is based on static analysis. Compilation tested.
> ---
> Changes in v2:
> - Fixed the commit message.
> - Addressed the review comment about deleting buf from the list
>    before freeing.
> - Link to v1: https://lore.kernel.org/all/20230518100829.515143-1-sukrut.bellary@linux.com/
> ---
>   drivers/misc/fastrpc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f48466960f1b..b3b520fcfb75 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1882,7 +1882,8 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   				      &args[0]);
>   	if (err) {
>   		dev_err(dev, "mmap error (len 0x%08llx)\n", buf->size);
> -		goto err_invoke;
> +		fastrpc_buf_free(buf);
> +		return err;
>   	}
>   
>   	/* update the buffer to be able to deallocate the memory on the DSP */
> @@ -1922,8 +1923,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   
>   err_assign:
>   	fastrpc_req_munmap_impl(fl, buf);
> -err_invoke:
> -	fastrpc_buf_free(buf);
>   
>   	return err;
>   }
