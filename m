Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C370745A50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGCKb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjGCKbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:31:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B391701
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:31:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6540605e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688380268; x=1690972268;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5aHiMqeNwdRrIjrmly1Zksbp1f1u+TFx+QFqvTQY5Mk=;
        b=ixcq3ymoWBv21duiK7vy++TnPoU+krPGflT7m1UMEqzA1Sw2fM3SmiG2tCBJhcjFTe
         EzKazb7Dh1mSUTnPQzMZqf+CO+1/IcERiOUB40JrPyIOfwIYHC4YjFEunM9iO8e6c0Bd
         p97ltq9pd7pJAzAn/2nsKWa8TSEYPBRpRDaDWBYtUf36525FjPRsxr/v/pfYQr4pgzAY
         9yl7Hi3xpLmG/HQx2RuIx7h4+MJiImV9qjHYb5tnDzd0KQMjmwPpLzzJ/SXfuS3PsZ76
         FDzezRjeT/ER4XYtcOAecPMYVE2bnyG5c7oOe9gmyf1guK6rKaf4YONs5w1RcWK8vIZB
         jVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380268; x=1690972268;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aHiMqeNwdRrIjrmly1Zksbp1f1u+TFx+QFqvTQY5Mk=;
        b=Ae33aq6WMSaHsMrOPsRC90p2+CdZEzPsttMw+rnmpjICgfSV701ZIzpWKKPDZTWlgc
         4yTA+re/T+aNXX7mE37yH3xmForrto0GYJ2x6eQl/qwAU9gaW950QzREODUFsDh6s7Vn
         VYdDzm7Pqs2RX7oW6LhqzfW/TZZxc7+W3Kwu3w11FhEl6f1Sf5jo27p/Sv9yFxp9RpFd
         CTn+blgnPP+77idkLC0C3lSrrZQbbMU2azVHMBvWWhEDT91pP0EJY7jQpFNfNX7yAfZj
         XEM8GaFbYP2Mf4WgZx5ddFNHHsdFXRbgfqt9TafylmE4veLI0nPhf3bfkgNx2EA3tMCy
         5l/w==
X-Gm-Message-State: ABy/qLYVgnD/PfEsHuaCoUqeMCCbb7Jucj9rpo9Gdi6DNj+AWMvPztbP
        K1ZChdVslO+DSvbj6JfRGuw=
X-Google-Smtp-Source: APBJJlFKGIgUdsaNoz6+Vr01c8TTmvOh0UZe0sc4WJYCOGhYWR53PKHAYzImu+dyUyTNaujN/sdOUA==
X-Received: by 2002:ac2:5e2f:0:b0:4f9:5ac3:4133 with SMTP id o15-20020ac25e2f000000b004f95ac34133mr5997009lfg.25.1688380267330;
        Mon, 03 Jul 2023 03:31:07 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id x14-20020a19f60e000000b004fbb3c92ffcsm487949lfe.262.2023.07.03.03.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:31:07 -0700 (PDT)
Message-ID: <7097865e-d31b-099a-8b53-9e7264c64cd2@gmail.com>
Date:   Mon, 3 Jul 2023 13:31:05 +0300
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
 <20230419-dynamic-vmon-v4-9-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v4 09/13] regulator: implement
 mon_disable_reg_disabled
In-Reply-To: <20230419-dynamic-vmon-v4-9-4d3734e62ada@skidata.com>
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

Hi deeee Ho Benjamin,

I hope your train back to home was not delayed too much ;)

On 6/20/23 23:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The mon_disable_reg_disabled

The name of this always makes me to scratch my head a bit. (or, maybe it 
is just the sunburns at my bald).

Do you think making it:
mon_disable_at_reg_disable or mon_disable_when_reg_disabled would be too 
long?

> property disables all dt-enabled monitors
> before a regulator is disabled. If an error occurs while disabling the
> regulator, the monitors are enabled again.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/core.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 873e53633698..b37dcafff407 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -2965,7 +2965,7 @@ static int _regulator_do_enable(struct regulator_dev *rdev)
>   
>   	trace_regulator_enable_complete(rdev_get_name(rdev));
>   
> -	return 0;
> +	return monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);

As I wrote in my comment to previous patch, I might find the logic a bit 
more clear if the condition check was done here. Eg:

	if (rdev->desc->mon_disable_when_reg_disabled)
		return monitors_reenable(...);

	return 0;

>   }
>   
>   /**
> @@ -3124,8 +3124,13 @@ EXPORT_SYMBOL_GPL(regulator_enable);
>   
>   static int _regulator_do_disable(struct regulator_dev *rdev)
>   {
> +	const struct regulator_desc *desc = rdev->desc;
>   	int ret;
>   
> +	ret = monitors_disable(rdev, desc->mon_disable_reg_disabled);
> +	if (ret)
> +		return ret;

Similarly, for me the logic would be easier to follow if this was:

	if (desc->mon_disable_when_reg_disabled)
		monitors_disable(...);

> +
>   	trace_regulator_disable(rdev_get_name(rdev));
>   
>   	if (rdev->ena_pin) {
> @@ -3136,13 +3141,13 @@ static int _regulator_do_disable(struct regulator_dev *rdev)
>   			rdev->ena_gpio_state = 0;
>   		}
>   
> -	} else if (rdev->desc->ops->disable) {
> -		ret = rdev->desc->ops->disable(rdev);
> +	} else if (desc->ops->disable) {
> +		ret = desc->ops->disable(rdev);
>   		if (ret != 0)
>   			return ret;
>   	}
>   
> -	if (rdev->desc->off_on_delay)
> +	if (desc->off_on_delay)
>   		rdev->last_off = ktime_get_boottime();
>   
>   	trace_regulator_disable_complete(rdev_get_name(rdev));
> @@ -3180,6 +3185,7 @@ static int _regulator_disable(struct regulator *regulator)
>   				_notifier_call_chain(rdev,
>   						REGULATOR_EVENT_ABORT_DISABLE,
>   						NULL);
> +				monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);

same here,

>   				return ret;
>   			}
>   			_notifier_call_chain(rdev, REGULATOR_EVENT_DISABLE,
> @@ -3246,6 +3252,7 @@ static int _regulator_force_disable(struct regulator_dev *rdev)
>   		rdev_err(rdev, "failed to force disable: %pe\n", ERR_PTR(ret));
>   		_notifier_call_chain(rdev, REGULATOR_EVENT_FORCE_DISABLE |
>   				REGULATOR_EVENT_ABORT_DISABLE, NULL);
> +		monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);

here...

>   		return ret;
>   	}
>   
> @@ -6422,8 +6429,10 @@ static int regulator_late_cleanup(struct device *dev, void *data)
>   		 */
>   		rdev_info(rdev, "disabling\n");
>   		ret = _regulator_do_disable(rdev);
> -		if (ret != 0)
> +		if (ret != 0) {
>   			rdev_err(rdev, "couldn't disable: %pe\n", ERR_PTR(ret));
> +			monitors_reenable(rdev, rdev->desc->mon_disable_reg_disabled);

... and here.
> +		}
>   	} else {
>   		/* The intention is that in future we will
>   		 * assume that full constraints are provided
> 

These were just very minor things. Mostly looks good for me.


Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

