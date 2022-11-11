Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC46260A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiKKRrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKKRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:47:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE97517AA4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:47:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o30so3340263wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 09:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+saLVqM/fnIWIr9Ea/ihNQ+7nIW3anNoKrm4qCDmKMg=;
        b=Ewn46U7qxJPqBmUF2N/wsX6HsORClEFyvX3TLHvP39U1SulJSoF6RXhkG6sbCCujy3
         9HZQ//BgzduOFsj7uwxb4l+pIAuqnzzPyn9koMcbbKTIssuW7z1Pd0WlubhKo2vmiGil
         3kYKv3jTpfqXAQ73lZmOO8Ciz4yApJ3qByRMuyibRzWbNZCFqzdWyBzVi1OV3bv9j4Uc
         VF/Zw3puQtZldVeoOXml8p5gK9U7eAfUeofiSSmQwH+B1UTZF0z2tAYL08WUi0G7o+Fz
         7f6g+jgAHhM413DNiU3pc0KXdpGakCNd45SGAnhZEPwBaVGOHBC9w/JmwTySLfVjKZtB
         21pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+saLVqM/fnIWIr9Ea/ihNQ+7nIW3anNoKrm4qCDmKMg=;
        b=nHEBmfUkjBKCUztn6F4dahjVenA/iAFdaf4BdYQhrmdEJFD9w9IYc0JHEO4iDg+H7e
         gOCMi98i47SA9FUMJiGZKnzH3BKSse7ldC+idWrvuUUs4xHwh+6CCKHFEgzKtD++F1Ii
         Zyfj7E2DsneYPp/f54djiEP6pw5nsC0zwi1VKALT1Hhz+i9Ekc3HeAnEdJtnF7B9tlFZ
         3DWsTTiVVquNjmMT+iTtY+UVoP3xXETOAsLHsQg/EsbnzQYKjEhgYG+2C4zhW7DDNd3b
         dIinWm2fvP0Yu8+RPsTyRNsuhk36gqN626u996VsM3ssA77ZyDFQ9YmA2LGRW5fMn81y
         P42w==
X-Gm-Message-State: ANoB5pkIsunTvytD83CYO5O+US+PfADmTLFm4PmCUVGiyG2J1cZMTrbt
        pw1A5fxvs/JVCml+VYT5/WRbvQ==
X-Google-Smtp-Source: AA0mqf5d8jHAULujcx/8Is4mVaaHTXaC5lO+QD97/21xnFroPd6V1l2ejQOP332YA580igqET1SgAw==
X-Received: by 2002:a05:600c:4ba9:b0:3cf:6f5f:da0e with SMTP id e41-20020a05600c4ba900b003cf6f5fda0emr1995590wmp.19.1668188838553;
        Fri, 11 Nov 2022 09:47:18 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r7-20020a05600c458700b003c7087f6c9asm9714592wmo.32.2022.11.11.09.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 09:47:17 -0800 (PST)
Message-ID: <74694fa7-e3e6-986b-7bf3-ce2ec9ab3992@linaro.org>
Date:   Fri, 11 Nov 2022 17:47:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmem: lan9662-otp: Change return type of
 lan9662_otp_wait_flag_clear()
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20220927205916.511556-1-horatiu.vultur@microchip.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220927205916.511556-1-horatiu.vultur@microchip.com>
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



On 27/09/2022 21:59, Horatiu Vultur wrote:
> The blamed commit introduced the following smatch warning in the
> function lan9662_otp_wait_flag_clear:
> drivers/nvmem/lan9662-otpc.c:43 lan9662_otp_wait_flag_clear() warn: signedness bug returning '(-110)'
> 
> Fix this by changing the return type of the function
> lan9662_otp_wait_flag_clear() to be int instead of bool.
> 
> Fixes: 9e8f208ad5229d ("nvmem: lan9662-otp: add support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---

Applied thanks,
--srini
>   drivers/nvmem/lan9662-otpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/lan9662-otpc.c b/drivers/nvmem/lan9662-otpc.c
> index f6732fd216d80..f4348c97f6e59 100644
> --- a/drivers/nvmem/lan9662-otpc.c
> +++ b/drivers/nvmem/lan9662-otpc.c
> @@ -36,7 +36,7 @@ struct lan9662_otp {
>   	void __iomem *base;
>   };
>   
> -static bool lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
> +static int lan9662_otp_wait_flag_clear(void __iomem *reg, u32 flag)
>   {
>   	u32 val;
>   
