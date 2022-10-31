Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C71613D55
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJaS27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiJaS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:28:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67912D3C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:49 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bk15so17133949wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h35T5Hic3J51sigkp5EEtU4mlYTV/OS/n5zLOUZsiBY=;
        b=uucY1kmELif0QSAUGxuI8Yjx3mwszezx/Fennu3ZAWQiSGO2sHVyH/YvYxKgMmS6h7
         vPH8+bvyZ+Vc09UECMLNNkIz2KpJg1uWrgxOKgFzMPMB4WS6uqM0krDsoNQla/CtbrhC
         9j9wkTcgRgW2KE1wqTakIVtQL50ztUnocTifn5/A0yZU+nW+GKQ7oaBts1Vkp9sSze3V
         qG189t6fzdmurZrrlIM9u6E2lxKJPWSCw9wMovOeXBAvmujdyhq/UoJnRoGwnHGFGqCa
         6FFmEK8E/68XCk5obB8iewNKLRXx77unWVcwRJdJzuqfD1vGoplhk3X4cCptRpcNJPpt
         q/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h35T5Hic3J51sigkp5EEtU4mlYTV/OS/n5zLOUZsiBY=;
        b=leaByt6i+EiTASfDMrP4uUv0fdZ4KplQ9BxpbOTpSlrWS8WkFJLhoj8Zgw8Tgly41r
         hQCk+eKc0iNXlt/GvKa2WOwz2q8feZIzskwnUUhJTPIJu7jLmQ/9JZURoCmlz8z8p036
         TR9IN9+LHJog+VbwZ0fG9mbxP42w5bPemxzPc6DkczU08DLNNNLrXsWU4kjpuDieMaib
         3ULoPOKwRBOhSE59mK21iZWEFU1MU10GcqWjPZdzFoHrnyv+hlS975jkeTS69SpAXFZd
         ZY/tLHikDaMdb5Q1mccTpRXkymLHc0xVro3FZavDrh0JZsxxT9J2OpX9fUsRKKZLVYmT
         QT9A==
X-Gm-Message-State: ACrzQf3UzaZmBgW6OX9YQhM6AVvgIGIHaQc0sy5dLaoixLPjcJj4Xi3r
        qyFTufdnkhMZeQriz300rA6gsQ==
X-Google-Smtp-Source: AMsMyM7JAFvWx7qbxwPIobW+LKAz0wDyr7j6fO5Z1wVLD/dNkgD//E6e01YKgWoDNyb/xA4agSqrHA==
X-Received: by 2002:adf:f447:0:b0:236:5840:1c72 with SMTP id f7-20020adff447000000b0023658401c72mr8685031wrp.686.1667240928422;
        Mon, 31 Oct 2022 11:28:48 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j3-20020a05600c1c0300b003b4ff30e566sm26812630wms.3.2022.10.31.11.28.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:28:47 -0700 (PDT)
Message-ID: <35a3097e-ecb6-78ff-5a34-ed89a1fed362@linaro.org>
Date:   Mon, 31 Oct 2022 18:28:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] slimbus: stream: correct presence rate frequencies
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20220929165202.410937-1-krzysztof.kozlowski@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220929165202.410937-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/09/2022 17:52, Krzysztof Kozlowski wrote:
> Correct few frequencies in presence rate table - multiplied by 10
> (110250 instead of 11025 Hz).
> 
Good catch,

Applied thanks,
-srini
> Fixes: abb9c9b8b51b ("slimbus: stream: add stream support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/slimbus/stream.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
> index f7da72ab504c..a476fa6549cc 100644
> --- a/drivers/slimbus/stream.c
> +++ b/drivers/slimbus/stream.c
> @@ -67,10 +67,10 @@ static const int slim_presence_rate_table[] = {
>   	384000,
>   	768000,
>   	0, /* Reserved */
> -	110250,
> -	220500,
> -	441000,
> -	882000,
> +	11025,
> +	22050,
> +	44100,
> +	88200,
>   	176400,
>   	352800,
>   	705600,
