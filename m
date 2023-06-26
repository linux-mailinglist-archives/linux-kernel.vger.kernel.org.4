Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5573E0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjFZNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjFZNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:43:54 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD569134
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:43:52 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so7900930a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787031; x=1690379031;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzDlve5/NsqkSu1s/yZ2DWXi6Pe8+asZ2Rh+Bil9dzw=;
        b=JgY4p5ULOGzMOwNQ7O8imoMdUpnnTJbfdEr5WH9ME5Sai+sfTK8TxrfPR+kFKKdJyq
         rhdFNsac8YWGWNi3Fzurt2FQeBdrrJ6U5ZC70879a2Ftv+BHb8MUd3gY1khX07mAIGkH
         s8Jw/DzTwwbEfDRwo1c2V53myhIAOYtWalhTJ0cPDi5lWdRlhbWUL2cHUgldRAklvxnD
         29xs6Jhs/FGQmgbnZbI5uLWQfwm4HqDFPCwDR0Go/fYhNsx8kT/YZHjlc+pMSlNWX+O+
         YBdZvz3nayILgpU5YUkA3ln/HLVGAltTRoMoMa23PIlPPJ5z1yDknpzxK14sh35FdmYD
         5Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787031; x=1690379031;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dzDlve5/NsqkSu1s/yZ2DWXi6Pe8+asZ2Rh+Bil9dzw=;
        b=TkqrZpP334FpHgWafiaJXb5pjfmmsGUFQ43nRbdOM9/PosUSndNkb1ELEDaqG5HX4N
         mQYpH9m2WOgGzMFgQQu1vyVQw1eHfNSfOU50bkjML0Na6ifZ4luLa1PFNlwLFNKTSiKR
         jTtRNgIjMudinGWcCA4wduffVkJNjKYtdolpThLMOPWdxIGfZnVplUE0nMYHYe7nE4GH
         9iPITYAyCsYsRGrYObGh1C07Y8csnb+tfbdW1c72Lcbbk45iL5Xz5K6ahk5eQWjm7ncd
         9VeFbByOv4qvDv21ZV7GDpnQh8BrFQMRu4cPNRf63UMXUOq3vwojucTxFxBGLxGfJXAs
         k+zw==
X-Gm-Message-State: AC+VfDyl7GrF4lmNk1NH0xmA6r+AXuCqhn+gRY3MtrgKbxwRxezbmM7x
        srgn1QJuZXDswNtL3FaeTAo=
X-Google-Smtp-Source: ACHHUZ7wQ1Bo/MO+jR9+iG7p3x3tdDILQY13qvw0E/DuElDnrW0i28Jr9DaQx4N6ZP1ig6ZtZ60Flg==
X-Received: by 2002:a05:6402:5112:b0:514:387c:930 with SMTP id m18-20020a056402511200b00514387c0930mr34023894edd.5.1687787031013;
        Mon, 26 Jun 2023 06:43:51 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7d80e000000b0051a59d81c4dsm2878520edq.3.2023.06.26.06.43.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:43:50 -0700 (PDT)
Message-ID: <4a71b08e-0c0d-a378-7a3a-0cd12912d4d4@gmail.com>
Date:   Mon, 26 Jun 2023 16:43:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-2-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v4 02/13] regulator: add getter for active monitors
In-Reply-To: <20230419-dynamic-vmon-v4-2-4d3734e62ada@skidata.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/23 23:02, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Add an op to get all active monitors of a regulator. This is useful to
> find out if any monitor is turned on, of which the device-tree is not
> aware of (e.g. by bootloader or OTP).
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Just a couple of minor remarks. Feel free to change those if you end up 
respinning.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   include/linux/regulator/driver.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
> index d3b4a3d4514a..9a9163cae769 100644
> --- a/include/linux/regulator/driver.h
> +++ b/include/linux/regulator/driver.h
> @@ -25,6 +25,13 @@ struct regulator_config;
>   struct regulator_init_data;
>   struct regulator_enable_gpio;
>   
> +#define REGULATOR_MONITOR_NONE 0x0
> +#define REGULATOR_MONITOR_OVER_CURRENT 0x1
> +#define REGULATOR_MONITOR_OVER_VOLTAGE 0x2
> +#define REGULATOR_MONITOR_UNDER_VOLTAGE 0x4
> +#define REGULATOR_MONITOR_OVER_TEMPERATURE 0x8
> +#define REGULATOR_MONITOR_ALL 0xF

Not a big thing but maybe use BIT() to underline this is a bitmask?

> +
>   enum regulator_status {
>   	REGULATOR_STATUS_OFF,
>   	REGULATOR_STATUS_ON,
> @@ -112,6 +119,8 @@ enum regulator_detection_severity {
>    * @set_thermal_protection: Support enabling of and setting limits for over
>    *	temperature situation detection.Detection can be configured for same
>    *	severities as over current protection. Units of degree Kelvin.
> + * @get_active_protections: Get all enabled monitors of a regulator. OR'ed val
> + *	of REGULATOR_MONITOR_*.

I think it wouldn't hurt to have doc stating in which case populating 
this call-back is needed? I haven't read rest of the patches yet but I 
guess this callback is going to be used internally by the regulator core 
and maybe it is not obvious for driver author that this is needed by 
core to be able to support automatic protection handling.

>    *
>    * @set_active_discharge: Set active discharge enable/disable of regulators.
>    *
> @@ -183,6 +192,7 @@ struct regulator_ops {
>   					    int severity, bool enable);
>   	int (*set_thermal_protection)(struct regulator_dev *, int lim,
>   				      int severity, bool enable);
> +	int (*get_active_protections)(struct regulator_dev *dev, unsigned int *state);
>   	int (*set_active_discharge)(struct regulator_dev *, bool enable);
>   
>   	/* enable/disable regulator */
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

