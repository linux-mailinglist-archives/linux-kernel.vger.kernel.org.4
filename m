Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9AC73E102
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjFZNt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjFZNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:49:50 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23D106
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:49:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so1440769a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687787388; x=1690379388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlOpr6CFcofR/OtisGeiHYQyUSZ+cCPo7y63qj/Di68=;
        b=YD9pM5Dp8yx5VNsRdse2GTcQH6I9q+pNLKL0CIIcFmseaAKIiaQqZJMIUE1kvnUPws
         8Sbi+WfeewWWPTeW2T2jmBKlU7zzVfap5Wvweom5ditiltALT98GdjdEwyfrzHPi5Rxs
         vZAnqKOi/LhFYlZpZ46OAgBO7/+d/QzxSSFTReqycTnXP47+x+MaORT9JCaA8f25/nqr
         80fCyEzB8z4YMA/luKhM5r76ihdGHyFlgWujGqobsFRIlrTR0/kuI3XMtK8zdblf5AVP
         MPuP+G9L+F91J7DzBcx1RmF7pwl/0wsuHPdsBVWsfFUIbdYhoPjYciY8/KRvkdXn35SS
         91og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687787388; x=1690379388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlOpr6CFcofR/OtisGeiHYQyUSZ+cCPo7y63qj/Di68=;
        b=W39Qp984JYqg19wzqZF/+A6btb9dfGaKFBexqL1S/AT57PgvrF2XOJYmTLv7zKfFdj
         LOYu4ZzIk5VXLpMLuOtzYNDZQBaK4tt83F8p/yKWpY03qGZaQ2tr7wjVoJjgX9RG7YPm
         2uh8loR8AU7eF++h/FVjKmlGLccJARukSwMXRE24u5ATBbMF6T/wfrMLiJyLc4MaO+j5
         PfRdsWJzkWzLm0vlhoH5lluI4AAzvuOPthEqovEvbrEWgTnWqahgVCRVaqQFTB3hwo1x
         YC7CSH7QmkYvDgubu0ZD5FxNkhVB2kP+pMbpN/bql99pBtH8ok00qwUMQcI5HD+TdWnU
         bOEg==
X-Gm-Message-State: AC+VfDw2+Yui13wBDdSVbBbxdM3AnghQgjwiY9i7Yi92uZvfJ4byDZTD
        xOXsawpZZAefyP3EAbASaeA=
X-Google-Smtp-Source: ACHHUZ73qVn2KMGO3A5dGjG+8KzBVHr5zTtnx8X6UkGy2vsFGzG1Xhvo6RiikHPoN3hzGQAZ+zm8JA==
X-Received: by 2002:a05:6402:3c5:b0:51d:a4a1:f8a4 with SMTP id t5-20020a05640203c500b0051da4a1f8a4mr274479edw.10.1687787387725;
        Mon, 26 Jun 2023 06:49:47 -0700 (PDT)
Received: from [10.100.102.18] ([83.136.201.74])
        by smtp.gmail.com with ESMTPSA id j13-20020aa7de8d000000b0051a2c7f5b0fsm2932937edv.88.2023.06.26.06.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 06:49:47 -0700 (PDT)
Message-ID: <41239c2c-3599-3f0d-59d3-a8eb32814c58@gmail.com>
Date:   Mon, 26 Jun 2023 16:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 06/13] regulator: set required ops for monitoring
 workarounds
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
 <20230419-dynamic-vmon-v4-6-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230419-dynamic-vmon-v4-6-4d3734e62ada@skidata.com>
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
> If the core should be able to handle the monitoring workarounds, certain
> regulator ops are required:
> - is_enabled() to decide whether a monitor should be turned off or not.
> - get_active_protections() to find out if the device-tree is missing
>    active protections.
> - get_mode() if the regulator is in a mode where monitoring is not
>    supported.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/regulator/core.c | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index dc741ac156c3..ca5d6ba889dc 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5540,6 +5540,40 @@ regulator_register(struct device *dev,
>   		goto rinse;
>   	}
>   
> +	/* monitor workaround properties require ops to ensure functionality. */
> +	if (regulator_desc->mon_disable_reg_disabled ||
> +	    regulator_desc->mon_disable_reg_set_higher ||
> +	    regulator_desc->mon_disable_reg_set_lower ||
> +	    regulator_desc->mon_unsupported_reg_modes) {
> +		/*
> +		 * is_enabled() to make sure the monitors aren't disabled on
> +		 * disabled regulators.
> +		 */
> +		if (!regulator_desc->ops->is_enabled) {
> +			ret = -EINVAL;
> +			goto rinse;
> +		}
> +
> +		/*
> +		 * get_active_protections() to know if a regulator is monitored
> +		 * without the device-tree being aware of it.
> +		 */
> +		if (!regulator_desc->ops->get_active_protections) {
> +			ret = -EINVAL;
> +			goto rinse;
> +		}
> +
> +		/*
> +		 * mon_unsupported_reg_modes property requires get_mode() to get
> +		 * the old state in case a state switch is failing.
> +		 */
> +		if (regulator_desc->mon_unsupported_reg_modes &&
> +		    !regulator_desc->ops->get_mode) {
> +			ret = -EINVAL;
> +			goto rinse;
> +		}
> +	}
> +
>   	rdev = kzalloc(sizeof(struct regulator_dev), GFP_KERNEL);
>   	if (rdev == NULL) {
>   		ret = -ENOMEM;
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

