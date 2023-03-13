Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079E76B7557
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjCMLIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCMLIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:08:09 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CCB144B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x11so12468966pln.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705686;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZKQHH1NqiqVu/uJ9+RQ9EYLbAdxR/9leu7yZnrMCyGQ=;
        b=ePJo6sJ/9xp8Cwup1q1C2yiAeNBk1Pyzube6rzvojdC6VOXJb7CABktct5VYMgvacK
         nIg4xR5a4T1wIQtnEwd62WGLnJGDL5ghLOm7GYNvdW8pwM2A+T3NykuZqZtcK2NNQmIa
         AJ2jvC7j+CJjRS1R4MmEeF8G/Ie9cUy36MD/GG1bnl8KkKSb+FskYqhqVorM/MBbL8nF
         QiV9gGlLfjEzUZBi4yiajkJp2Tssa6fNqPTDZajyMyLL8UuWjYG1drGwPbMkb5I59L8k
         Ed7a43iUsT9MgOVSlhOsvut76N54oFKlPYW2Mnt/EAiQj/f54yJ4/maRdc6lRxfFE6SX
         VF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705686;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKQHH1NqiqVu/uJ9+RQ9EYLbAdxR/9leu7yZnrMCyGQ=;
        b=rVhvL8MCkzy/0Qmm/XpHBjMUscWGepZoPwYVql36rTwyJiAYoZOt9Nmh42NLQYpU0R
         6/C6J0OWv/A3lp8PF7z9yEb0jezp/EUcwqsKKNEWBxZ3rJE1oIBn3hs6jfKP/qw5Z2e5
         U1W/90jfDTksc1TEOYD7pzz5l3fUvZGqXeWbHxbvWzfqCYvvjJDbOirjMSUpeGQmt8vn
         MXd8XVn35aLPiBJmXSY6ftYCTYwVFIH8ftHE5Ed0EOclmHaZ7ESkDJHEdtPooK5XbQRp
         OGWcU4ItQLqWCRoMS4nAYgO9D0FlTJdKV9HnY1qd7lgGLaoik6nq8U+FMOXsOgUg35x4
         0lRA==
X-Gm-Message-State: AO0yUKW293HxEZAFfIshNrPJzB29UDQ/4lwUyxt3ggI+R0tW+InWEXQZ
        kaIvzbVzQp/ifP7KYEXzYwg=
X-Google-Smtp-Source: AK7set+NSzS60ltGLEeTV1A07YFe/lHE9eA1ZbUly+NiBaxgNdHs3RID1ZI1znFCjq3yyuyEor9Sew==
X-Received: by 2002:a17:903:247:b0:19e:6ffd:a310 with SMTP id j7-20020a170903024700b0019e6ffda310mr42467705plh.48.1678705686456;
        Mon, 13 Mar 2023 04:08:06 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id la7-20020a170902fa0700b001a04f0ec697sm1429004plb.65.2023.03.13.04.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:08:06 -0700 (PDT)
Message-ID: <92268d7b-2f71-c200-b600-742424ae0455@gmail.com>
Date:   Mon, 13 Mar 2023 20:08:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 3/4] extcon: Added extcon_alloc_muex to simplify extcon
 register function
Content-Language: en-US
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20230302090143.46678-1-bw365.lee@samsung.com>
 <CGME20230302090149epcas1p31a7f99d83947be1d6f06141b352ce041@epcas1p3.samsung.com>
 <20230302090143.46678-4-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230302090143.46678-4-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 2. 18:01, Bumwoo Lee wrote:
> The mutual exclusive part is functionalized from extcon_dev_register.
> 
> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 106 ++++++++++++++++++++++------------------
>  1 file changed, 58 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 49605e96bedd..321988231806 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1127,6 +1127,60 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
>  	return 0;
>  }
>  
> +/**
> + * extcon_alloc_muex() - alloc the mutual exclusive for extcon device
> + * @edev:	extcon device
> + *
> + * Returns 0 if success or error number if fail.
> + */
> +static int extcon_alloc_muex(struct extcon_dev *edev)
> +{
> +	char *name;
> +	int index;
> +

ditto.

	if (!edev)
		return -EINVAL;

> +	if (!(edev->max_supported && edev->mutually_exclusive))
> +		return 0;
> +
> +	/* Count the size of mutually_exclusive array */
> +	for (index = 0; edev->mutually_exclusive[index]; index++)
> +		;
> +
> +	edev->attrs_muex = kcalloc(index + 1,
> +				   sizeof(struct attribute *),
> +				   GFP_KERNEL);
> +	if (!edev->attrs_muex)
> +		return -ENOMEM;
> +
> +	edev->d_attrs_muex = kcalloc(index,
> +				     sizeof(struct device_attribute),
> +				     GFP_KERNEL);
> +	if (!edev->d_attrs_muex) {
> +		kfree(edev->attrs_muex);
> +		return -ENOMEM;
> +	}
> +
> +	for (index = 0; edev->mutually_exclusive[index]; index++) {
> +		name = kasprintf(GFP_KERNEL, "0x%x",
> +				 edev->mutually_exclusive[index]);
> +		if (!name) {
> +			for (index--; index >= 0; index--)
> +				kfree(edev->d_attrs_muex[index].attr.name);
> +
> +			kfree(edev->d_attrs_muex);
> +			kfree(edev->attrs_muex);
> +			return -ENOMEM;
> +		}
> +		sysfs_attr_init(&edev->d_attrs_muex[index].attr);
> +		edev->d_attrs_muex[index].attr.name = name;
> +		edev->d_attrs_muex[index].attr.mode = 0000;
> +		edev->attrs_muex[index] = &edev->d_attrs_muex[index].attr;
> +	}
> +	edev->attr_g_muex.name = muex_name;
> +	edev->attr_g_muex.attrs = edev->attrs_muex;
> +
> +	return 0;
> +}
> +
>  /**
>   * extcon_dev_register() - Register an new extcon device
>   * @edev:	the extcon device to be registered
> @@ -1178,53 +1232,9 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	if (ret < 0)
>  		goto err_alloc_cables;
>  
> -	if (edev->max_supported && edev->mutually_exclusive) {
> -		char *name;
> -
> -		/* Count the size of mutually_exclusive array */
> -		for (index = 0; edev->mutually_exclusive[index]; index++)
> -			;
> -
> -		edev->attrs_muex = kcalloc(index + 1,
> -					   sizeof(struct attribute *),
> -					   GFP_KERNEL);
> -		if (!edev->attrs_muex) {
> -			ret = -ENOMEM;
> -			goto err_muex;
> -		}
> -
> -		edev->d_attrs_muex = kcalloc(index,
> -					     sizeof(struct device_attribute),
> -					     GFP_KERNEL);
> -		if (!edev->d_attrs_muex) {
> -			ret = -ENOMEM;
> -			kfree(edev->attrs_muex);
> -			goto err_muex;
> -		}
> -
> -		for (index = 0; edev->mutually_exclusive[index]; index++) {
> -			name = kasprintf(GFP_KERNEL, "0x%x",
> -					 edev->mutually_exclusive[index]);
> -			if (!name) {
> -				for (index--; index >= 0; index--) {
> -					kfree(edev->d_attrs_muex[index].attr.
> -					      name);
> -				}
> -				kfree(edev->d_attrs_muex);
> -				kfree(edev->attrs_muex);
> -				ret = -ENOMEM;
> -				goto err_muex;
> -			}
> -			sysfs_attr_init(&edev->d_attrs_muex[index].attr);
> -			edev->d_attrs_muex[index].attr.name = name;
> -			edev->d_attrs_muex[index].attr.mode = 0000;
> -			edev->attrs_muex[index] = &edev->d_attrs_muex[index]
> -							.attr;
> -		}
> -		edev->attr_g_muex.name = muex_name;
> -		edev->attr_g_muex.attrs = edev->attrs_muex;
> -
> -	}
> +	ret = extcon_alloc_muex(edev);
> +	if (ret < 0)
> +		goto err_alloc_muex;
>  
>  	if (edev->max_supported) {
>  		edev->extcon_dev_type.groups =
> @@ -1292,7 +1302,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  		kfree(edev->d_attrs_muex);
>  		kfree(edev->attrs_muex);
>  	}
> -err_muex:
> +err_alloc_muex:
>  	for (index = 0; index < edev->max_supported; index++)
>  		kfree(edev->cables[index].attr_g.name);
>  	if (edev->max_supported)

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

