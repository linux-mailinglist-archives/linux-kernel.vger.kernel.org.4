Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19229745A87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjGCKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGCKph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:45:37 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3B1BE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:45:36 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb77f21c63so6562729e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688381134; x=1690973134;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjB4NrZ8c1eZ9wy4QI2AE/NjqgqmbEKhUEDFiJq2p7w=;
        b=TlPlfKd45KP7mISMhVaeiaYfkpfmTNgF7KccfXk+4B4VuulSLbBaWWPcSMwqdC2soB
         BJoetbNMePM0Tc9tDcUnyS3SI+OwygQJM+RiVhGVYX0Q+of9bG/Nj6NAmcRqlzaezfD8
         KQ4/m7Hw7Hygn4Flz4GkltdfFc60TLm8jCeV3r7gu9CCqLcgNIh4jR6FJoXlbQRnA0ps
         E+4VbirLGmsQSR9vWmexTAdehyGU26fRyvVLMWFmGJJjfpQ1JZlKBGxAAsRlJVuKv6yu
         TKYa4ZWrblOl1v8nXiMrMnNf+XrHZ/Mzciu4doSUZYINaWYh/HT2ZqX+m0AeCHclbvjW
         mSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688381134; x=1690973134;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjB4NrZ8c1eZ9wy4QI2AE/NjqgqmbEKhUEDFiJq2p7w=;
        b=LYazQVbNljKUpfdQbDtz+tRsyP3Xxbhs5o0fVO9SzMQo6Xgw94bmeBtoMbBJLWi38n
         +4ddJD0J6F3yVvBByRCfIKI4INqw09ArlfAu1pO8R2Nw8jY4fKKSSu90pp9UBPxNvdqR
         Xgwn5bTFPpa2W4OaML/ieMAXlo/niSB8QM0m9jK35w9YGfctOqXaAmqFW24XFMrB1i15
         UZim5N2nQQaiChoOfIQNg64UebvNMIKYz1YHlESNRsTeIde1+ZjhTeU/f3DrYIzLpqnO
         Zhrid46nD1UNp7KlDqSRqWmkxgFfLCY3MJsWmzRp2ngMYfYTgGFpxCCcF+e2QYh1fQel
         Y2hg==
X-Gm-Message-State: ABy/qLaWLD/9/homLfGK8Wg+7VZQSDl1ydy29Xbtnd/4+YfAyPEjGN6F
        8K8NJxcIsGTt6V/AfLrRTsc=
X-Google-Smtp-Source: APBJJlEdD3+MpWyjlMnR33XMPkiQKoNR53E6ADQXg0f5HxT8WEgff3flHClRTK0IjQCzfBp4fnQ68w==
X-Received: by 2002:a05:6512:3a8e:b0:4fb:987b:ec3c with SMTP id q14-20020a0565123a8e00b004fb987bec3cmr7896326lfu.56.1688381134305;
        Mon, 03 Jul 2023 03:45:34 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id n1-20020a195501000000b004fbb6dd7ad1sm138068lfe.288.2023.07.03.03.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:45:34 -0700 (PDT)
Message-ID: <4eeaa617-202b-a69e-9a91-0c955144b36a@gmail.com>
Date:   Mon, 3 Jul 2023 13:45:33 +0300
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
 <20230419-dynamic-vmon-v4-10-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH RFC v4 10/13] regulator: implement
 mon_disable_reg_set_{higher,lower}
In-Reply-To: <20230419-dynamic-vmon-v4-10-4d3734e62ada@skidata.com>
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

On 6/20/23 23:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The mon_disable_reg_set_{higher,lower} properties disable all dt-enabled
> monitors when the value of the regulator is changed to a higher or lower
> one.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/core.c | 41 +++++++++++++++++++++++++++++++++++++----
>   1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index b37dcafff407..74b9c12d38e9 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -3643,6 +3643,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
>   				       int min_uV, int max_uV,
>   				       unsigned *selector)
>   {
> +	const struct regulator_desc *desc = rdev->desc;
>   	struct pre_voltage_change_data data;
>   	int ret;
>   
> @@ -3654,7 +3655,18 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
>   	if (ret & NOTIFY_STOP_MASK)
>   		return -EINVAL;
>   
> -	ret = rdev->desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
> +	if (min_uV > data.old_uV || max_uV > data.old_uV) {
> +		ret = monitors_disable(rdev, desc->mon_disable_reg_set_higher);
> +		if (ret)
> +			return ret;

Here, as per comments to previous patches, the logic would be more 
obvious for me if this was:
	if (desc->mon_disable_reg_set_higher &&
	   (min_uV > data.old_uV || max_uV > data.old_uV)) {
		ret = monitors_disable(...)

> +	}
> +	if (min_uV < data.old_uV || max_uV < data.old_uV) {
> +		ret = monitors_disable(rdev, desc->mon_disable_reg_set_lower);
> +		if (ret)
> +			return ret;
> +	}

I guess you guess what I think of the above by now :)

> +
> +	ret = desc->ops->set_voltage(rdev, min_uV, max_uV, selector);
>   	if (ret >= 0)
>   		return ret;
>   
> @@ -3667,6 +3679,7 @@ static int _regulator_call_set_voltage(struct regulator_dev *rdev,
>   static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
>   					   int uV, unsigned selector)
>   {
> +	const struct regulator_desc *desc = rdev->desc;
>   	struct pre_voltage_change_data data;
>   	int ret;
>   
> @@ -3678,7 +3691,18 @@ static int _regulator_call_set_voltage_sel(struct regulator_dev *rdev,
>   	if (ret & NOTIFY_STOP_MASK)
>   		return -EINVAL;
>   
> -	ret = rdev->desc->ops->set_voltage_sel(rdev, selector);
> +	if (uV > data.old_uV) {
> +		ret = monitors_disable(rdev, desc->mon_disable_reg_set_higher);
> +		if (ret)
> +			return ret;
> +	}
> +	if (uV < data.old_uV) {
> +		ret = monitors_disable(rdev, desc->mon_disable_reg_set_lower);
> +		if (ret)
> +			return ret;
> +	}

Here I would also pull the check from monitors_disable() to these 
callers just to explicitly show the logic.

> +
> +	ret = desc->ops->set_voltage_sel(rdev, selector);
>   	if (ret >= 0)
>   		return ret;
>   
> @@ -3780,7 +3804,8 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
>   	int best_val = 0;
>   	unsigned int selector;
>   	int old_selector = -1;
> -	const struct regulator_ops *ops = rdev->desc->ops;
> +	const struct regulator_desc *desc = rdev->desc;
> +	const struct regulator_ops *ops = desc->ops;
>   	int old_uV = regulator_get_voltage_rdev(rdev);
>   
>   	trace_regulator_set_voltage(rdev_get_name(rdev), min_uV, max_uV);
> @@ -3819,7 +3844,7 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
>   				selector = ret;
>   				if (old_selector == selector)
>   					ret = 0;
> -				else if (rdev->desc->vsel_step)
> +				else if (desc->vsel_step)
>   					ret = _regulator_set_voltage_sel_step(
>   						rdev, best_val, selector);
>   				else
> @@ -3874,6 +3899,14 @@ static int _regulator_do_set_voltage(struct regulator_dev *rdev,
>   out:
>   	trace_regulator_set_voltage_complete(rdev_get_name(rdev), best_val);
>   
> +	/* if setting voltage failed, ignore monitoring error. */
> +	if (ret)
> +		monitors_reenable(rdev, desc->mon_disable_reg_set_higher |
> +					desc->mon_disable_reg_set_lower);
> +	else
> +		ret = monitors_reenable(rdev, desc->mon_disable_reg_set_higher |
> +					      desc->mon_disable_reg_set_lower);

Here as well.

> +
>   	return ret;
>   }

Well, pulling the check from monitors_*() to callers will increase line 
count quite a bit. Still, my personal take on this is that the logic is 
easier to follow that way. I, however, am fine also with the way it is 
done in these patches if you think the line count matters more.

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

