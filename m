Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4676B3EFF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 13:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjCJMS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 07:18:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJMS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 07:18:27 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F55591D0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:18:25 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id s22so6312289lfi.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 04:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678450704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J0qIBavQvCE6UcJYU5B5vFYsQGNnMzPGwVWysAj/n8A=;
        b=Vz44vEYeb40jFle48nBxsOAfOSXfV/73vmnKtFNg4kKQZNSig5lv3c3xTQbNnE5q7E
         NKhx7AQ31SVf7wFlKehpifKHWzW/PQcN8OsHgmSyw6BEcSAg+Oyq03W3E30RWTlOlzRh
         bUZoRP4wV+7ORGt1Szw2Lw7oURYb6FtToPqkqyPOCSmHh4RB9L065figaLkPu/i8zluD
         XjpC0mwzc+41Rwev2oZ7nQGT+W9Wb3MIvHpVkbVm0F1vgvq8Df0DjJk+J93piDQRTk4W
         EhhM8l5663nkR9vQG2hq3RgFt4ZoRK76By7leKp5lWdVs+yNZ7QTHuEOVb0cmI2rn2h7
         7Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0qIBavQvCE6UcJYU5B5vFYsQGNnMzPGwVWysAj/n8A=;
        b=Veuw5JPPWoXdytpBcXZSUs9jnErinKZ1a4MGhb1XLT8hhQfNRc2yjcrym0O1zc9LYi
         KQevZ4E5hpc5De3VYqsVdzDxoc8HzGBDGDYtakHN/oQNPSJA6J8PLZEvqj+lMJj9buJy
         DEs7CQt6KYEc42ZSWAaJTGiAOGPFV6gs7jZO1gqhuF5x+GFswpfQ5LmSK2o3UdpQAw6U
         zl9i8OHqXDZFT9d9v7brWqSXOPAd9vYbU/vjUhFG8P5t8YbuiyAFkj03NtPKRkLCM3ZP
         kwQKm7wVF1fhty+fVzWDp1zV5JLQWdipvwRNpSCFQF9HEI5Hy1BPa5cnwtY0zGxQRk2t
         6GaQ==
X-Gm-Message-State: AO0yUKWYKzcnQqsN71IpawkH9n1jRDzQIZJP7FZhCJkNrgOVKDMyyCK1
        rb68zcrdvpXiwiwONXh6xUSwkA==
X-Google-Smtp-Source: AK7set/jqxxNve93tdP/7NeHqO3Ez4ShpHWnW33ibJ0SD9S9dapr8c25RQn6pmC6ETRZEATEdqNJBQ==
X-Received: by 2002:ac2:5095:0:b0:4cc:597b:583e with SMTP id f21-20020ac25095000000b004cc597b583emr7040799lfm.55.1678450704309;
        Fri, 10 Mar 2023 04:18:24 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id w15-20020ac2598f000000b004cafa2bfb7dsm222990lfn.133.2023.03.10.04.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 04:18:23 -0800 (PST)
Message-ID: <c5bc74dc-4926-9830-069a-fb30fbaf3189@linaro.org>
Date:   Fri, 10 Mar 2023 14:18:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Revert "Add a secondary AT
 port to Telit FN990"
Content-Language: en-GB
To:     Slark Xiao <slark_xiao@163.com>, mani@kernel.org,
        loic.poulain@linaro.org, fabio.porcedda@gmail.com
Cc:     mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310101715.69209-1-slark_xiao@163.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230310101715.69209-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 12:17, Slark Xiao wrote:
> This reverts commit 2d5253a096c6057bbf7caa5520856dcdf7eca8bb.
> There are 2 commits with commit message "Add a secondary AT
> port to Telit FN990". But the last one 2d5253a096 was added
> on Foxconn devices. Actually the second AT port of Foxconn
> devices doesn't work in PCIe mode. And the commit message
> mismatch with the changes. So we need to remove it.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Probably also:

Fixes: 2d5253a096c6 ("bus: mhi: host: pci_generic: Add a secondary AT 
port to Telit FN990")

> ---
>   drivers/bus/mhi/host/pci_generic.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 6e13c43a84d1..91d02f84ba21 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -343,8 +343,6 @@ static const struct mhi_channel_config mhi_foxconn_sdx55_channels[] = {
>   	MHI_CHANNEL_CONFIG_DL(13, "MBIM", 32, 0),
>   	MHI_CHANNEL_CONFIG_UL(32, "DUN", 32, 0),
>   	MHI_CHANNEL_CONFIG_DL(33, "DUN", 32, 0),
> -	MHI_CHANNEL_CONFIG_UL(92, "DUN2", 32, 1),
> -	MHI_CHANNEL_CONFIG_DL(93, "DUN2", 32, 1),
>   	MHI_CHANNEL_CONFIG_HW_UL(100, "IP_HW0_MBIM", 128, 2),
>   	MHI_CHANNEL_CONFIG_HW_DL(101, "IP_HW0_MBIM", 128, 3),
>   };

-- 
With best wishes
Dmitry

