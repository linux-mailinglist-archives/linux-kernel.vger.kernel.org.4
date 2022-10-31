Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2543613C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbiJaRpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiJaRpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:45:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4564813D24
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:45:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a14so17024219wru.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 10:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYtKmfNhvFP9fjeZBd6sjzcvYV43BjS3uEVltPLZXlo=;
        b=CP/OPsDiOO5oiXwe+KdK/PBb5uKYx61OOfMaWRqa2Bgcl5FaBr0wIhSH1k2qT+j+3o
         I2fpPy74CcLqE0MkXZ5CSQ/FkQna5kXNaeWLKThePjZMvHB7ybbv9i/Fp9ZLndGFzdkc
         tLzotgErj5cws74IhfXObgInf/HozgI3A8ZW57wHBV3KCs/SlzEcUQ3t2EdCq5EK8hh8
         LPOeP3dbJ3rTAhx44cbgciknRC7gTGg8hymj1sqY5TsGgEugfXkySiRNpZq7rLyFHTGN
         eUbUGGiuaZabCocIXsle5jbamXCjiWo0zN8yl5Dn5O3Pu2gh/S00xae3rZofqRKQNdXn
         mVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYtKmfNhvFP9fjeZBd6sjzcvYV43BjS3uEVltPLZXlo=;
        b=HWiGs/8I/IhnCrPs1Zuyj2SKYqwJROdWPH7t+H+guTaBxuPejDF7Jd3kqiw62M36vE
         3Kl9PlgJFS3ZKq56GKnL+3YUfv1uTN2NRFQDIy0G3Sc8PBUVYNeNzByjvySEWKb4lz4n
         vWedMdD4O64bi9EjdEOxgDtN2yPE2YzPD4e3C9oMhLx8tQy1oDhkNk4vbI0R8vn2Toms
         IT221/tc5u4peppVJQjLnzKodbOkh0Ydxxx5iH7teJsZOpA4rtKTyeimGiEg0vz8OQM4
         CitY+PBZN05fYtRHez2suELfVub9lYalus36hY9oHGZkTkoJkoInr+QoXVGRqs02EexK
         LrWw==
X-Gm-Message-State: ACrzQf0dOHAlNdaTYTRuJH+FuZdY5+QDI5al+7biFuMgsq8qkzVPT7OU
        DU9keT6D7Qc6RzHHXxTpkI0jNw==
X-Google-Smtp-Source: AMsMyM6LetfHCHnCEKA7eJHWyMthDihLQrGyAsqKozRudXi0o9xFBAFBq46R3WXtUvbxrKq9NDPndg==
X-Received: by 2002:a05:6000:18a2:b0:22e:72fd:c5d0 with SMTP id b2-20020a05600018a200b0022e72fdc5d0mr8866232wri.682.1667238298855;
        Mon, 31 Oct 2022 10:44:58 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id bg37-20020a05600c3ca500b003b477532e66sm25983788wmb.2.2022.10.31.10.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:44:58 -0700 (PDT)
Message-ID: <bb2c0e45-e1cf-6105-a6ea-20a6085f6c89@linaro.org>
Date:   Mon, 31 Oct 2022 17:44:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmem: stm32: fix spelling typo in comment
Content-Language: en-US
To:     Jiangshan Yi <13667453960@163.com>, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
References: <20221009082819.2662964-1-13667453960@163.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20221009082819.2662964-1-13667453960@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/10/2022 09:28, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Applied thanks,

--srini
> ---
>   drivers/nvmem/stm32-romem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/stm32-romem.c b/drivers/nvmem/stm32-romem.c
> index 354be526897f..0c206ad05be7 100644
> --- a/drivers/nvmem/stm32-romem.c
> +++ b/drivers/nvmem/stm32-romem.c
> @@ -19,7 +19,7 @@
>   #define STM32_SMC_WRITE_SHADOW		0x03
>   #define STM32_SMC_READ_OTP		0x04
>   
> -/* shadow registers offest */
> +/* shadow registers offset */
>   #define STM32MP15_BSEC_DATA0		0x200
>   
>   /* 32 (x 32-bits) lower shadow registers */
