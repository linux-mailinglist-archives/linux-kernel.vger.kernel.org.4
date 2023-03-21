Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C86C2DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 10:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCUJS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCUJS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 05:18:26 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157319C46;
        Tue, 21 Mar 2023 02:18:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k37so5291331lfv.0;
        Tue, 21 Mar 2023 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679390303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0T3oq9djYzOJnwp3xYk8Woh65ZLlWo8BcwxC1O4wO6I=;
        b=pcT91DR3FOOn50KYI9YhEVeD3PMycMs8J/Skd0dq10eyt6x6vgzEFJQaj7WM6CFI7J
         Pbe48kUruJX+Cm7FoVwc/jNKBagUdKX3QIK6xbPR+1AmCpRWTnlNerDsl49GkSvsdMCW
         JJiVx3PiVmE+hiC0bTUL5WQHk5KiJTzc7KssKjxwi0j06bxqALyalBeEFO4jX4l0kPwM
         TgbyDFzmHcrwq4nBDFDena+rB27ZWJKk0Aehilq2VVr7RlPYxfgEqLvjC8/6OR7QoVZj
         mhlF6piUTKBHr/FbwBI342yiimP0ExE5hjC4tv9qe+YCLh0NBL+LWzvx+GgF1stszItr
         iulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679390303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0T3oq9djYzOJnwp3xYk8Woh65ZLlWo8BcwxC1O4wO6I=;
        b=4QWDCY0n9VSNruqXiBahxVR24Z/aRDmD7bvh2v8KJP+YLV6LEPv61+pyZ9MoSVrAGo
         wPdSr/vX4AbbZhYpr0zvu+lT9Xk714CVXh2qO0cYGwoBHgZI29T8o4E9qhBC4cdVMU6O
         okyQKNBJgNoUnGV7gqqb65gDqTtxE2sDvGMCJ0NnegB5k2sgLVOHyRYMssOmtDIIaPX7
         +G8GAw+5T94JZaOSU268JLjG1Bd8gG0Mx6GETuq6zma2lytBaM8SRDthcCCmU1PyiRnd
         h98RYmOjwWBWhPjsJZGPyieHa8acIhR5guSsJStVbg5PfzRUxKEOhURcdLXZtKZxW+6G
         CRXg==
X-Gm-Message-State: AO0yUKUcRZwn+ac6VciMVIbvJNjfTWEafskSZD1TnKANkJbRN32+q1Dq
        GgmnrC3YszfK+cMRaJ41M6A=
X-Google-Smtp-Source: AK7set9BqmXUpPpRKRNPHGy6vUlKy57a6Mwwq6mWn4txFyDQe3KZrWmki6FUYXDqbSFk9fXKvCUXdA==
X-Received: by 2002:a19:ee16:0:b0:4e1:fa71:f187 with SMTP id g22-20020a19ee16000000b004e1fa71f187mr610057lfb.3.1679390302767;
        Tue, 21 Mar 2023 02:18:22 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id y17-20020ac24211000000b004ddaea30ba6sm2079096lfh.235.2023.03.21.02.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 02:18:22 -0700 (PDT)
Message-ID: <ae2dd341-c22c-7f93-6e35-1538ff4e137a@gmail.com>
Date:   Tue, 21 Mar 2023 11:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv3 13/14] power: supply: generic-adc-battery: improve error
 message
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230317225707.1552512-1-sre@kernel.org>
 <20230317225707.1552512-14-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230317225707.1552512-14-sre@kernel.org>
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

On 3/18/23 00:57, Sebastian Reichel wrote:
> Add device context and error code to the error messages to make it
> useful.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/power/supply/generic-adc-battery.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
> index df1c0a1c6b52..2fa946c93fb4 100644
> --- a/drivers/power/supply/generic-adc-battery.c
> +++ b/drivers/power/supply/generic-adc-battery.c
> @@ -92,7 +92,7 @@ static int read_channel(struct gab *adc_bat, enum gab_chan_type channel,
>   
>   	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
>   	if (ret < 0)
> -		pr_err("read channel error\n");
> +		dev_err(&adc_bat->psy->dev, "read channel error: %d\n", ret);
>   	else
>   		*result *= 1000;
>   

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

