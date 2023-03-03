Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAB86A95D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjCCLJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCCLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:09:45 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECD366A6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 03:09:43 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so1015294wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677841781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HRuUsY599cR2G3g87A1hA1R+KpstdBGupNid0gsfv8o=;
        b=jFc5tvRAg2/+TRgQpv+pmM7WSde08FknwT90ZldTRrHjIzJ0U5bP/u3Hh1gCO9JBJN
         tOpJT7cucokbe7tTWsG2sCAYpW/SlNZsjB+WZV4AWhh0CbIzIobJIm+jSRTqO5j4pEtm
         oPvB7SOKUcBcD3YoHlNKt79qfrQ9zjkXkHWDfCVuwWmDbw/D0HVLhIVhexbmm1fHdoNP
         cLo7l6f1MFYNtJCOaE4kYeckHhNJEd+oLazXon3lXcD0azy5nY/z1JxSioHwcgeCiUGu
         GdiCu5Vm84CP8sjanottCn7TDQ+SKthSM/oHZirRyE5jfALl1P7hZrk+TNDQ7ywaYA6n
         ao+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677841781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRuUsY599cR2G3g87A1hA1R+KpstdBGupNid0gsfv8o=;
        b=1BTU70b9LVOycvwNKaVul0oqwG8jwI5xR5oeAhlQUXmEzZneMB3SAtUdC5URAHuDlu
         0MdR7y+iH4ZVtuWS14uhN6WmrHS6tz2YjoFs+5bZjPnNuETCipK0xM/3gbklhgZSW1H5
         +4NkM+5mfe038+YDgWQH48cidofdAyukt5xfNVTvfjiABDhF8StKLz7hLM8sv5lcekfw
         F12J11mqWZppzptiR+92H6Sfr6fOJhNIWfnZee0NRxukzlTTXIzNjV7xxiQOVbiJxs8l
         9AWV1QaFmBjTH6QVU6BTpcBJCwBHWchfEAYqs71ZgAPXs4Ar2BG5OkGQ659T9QzWSNwZ
         IsDA==
X-Gm-Message-State: AO0yUKWlIoEgU0ybu1HM7Zj33RNAR4yc4eGXPJ8GmmjJe7RGMqRPajE0
        q09F51eaR2hECbq4D88DCbZ0JA==
X-Google-Smtp-Source: AK7set/P6avZfs71OHdHeVxwvZWHsBJ+8keXMJ0BS3bn8k58cYhy7k5/8IY+Zdl1gaLQg5XSIDQYKQ==
X-Received: by 2002:a05:600c:45c8:b0:3ea:ed4d:38fc with SMTP id s8-20020a05600c45c800b003eaed4d38fcmr1285618wmo.31.1677841781110;
        Fri, 03 Mar 2023 03:09:41 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j22-20020a05600c485600b003e203681b26sm2033422wmo.29.2023.03.03.03.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 03:09:40 -0800 (PST)
Message-ID: <515d5fed-2083-c1fd-eea5-148d9e1c45bd@linaro.org>
Date:   Fri, 3 Mar 2023 11:09:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 RESEND] nvmem: core: return -ENOENT if nvmem cell is
 not found
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     linux-kernel@vger.kernel.org
References: <20230227085207.85381-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230227085207.85381-1-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/02/2023 08:52, Michael Walle wrote:
> Prior to commit 5d8e6e6c10a3 ("nvmem: core: add an index parameter to
> the cell") of_nvmem_cell_get() would return -ENOENT if the cell wasn't
> found. Particularly, if of_property_match_string() returned -EINVAL,
> that return code was passed as the index to of_parse_phandle(), which
> then detected it as invalid and returned NULL. That led to an return
> code of -ENOENT.
> 
> With the new code, the negative index will lead to an -EINVAL of
> of_parse_phandle_with_optional_args() which pass straight to the
> caller and break those who expect an -ENOENT.
> 
> Fix it by always returning -ENOENT.
> 
> Fixes: 5d8e6e6c10a3 ("nvmem: core: add an index parameter to the cell")
> Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Link: https://lore.kernel.org/r/2143916.GUh0CODmnK@steina-w/
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---

Applied thanks,

--srini
> Updated the commit ids as they are in Linus' tree. Added the link
> to the report.
> 
>   drivers/nvmem/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 174ef3574e07..22024b830788 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1231,7 +1231,7 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node *np, const char *id)
>   						  "#nvmem-cell-cells",
>   						  index, &cell_spec);
>   	if (ret)
> -		return ERR_PTR(ret);
> +		return ERR_PTR(-ENOENT);
>   
>   	if (cell_spec.args_count > 1)
>   		return ERR_PTR(-EINVAL);
