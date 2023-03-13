Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396A76B755D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 12:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjCMLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 07:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCMLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:08:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80F74390F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so1721014pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678705713;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qU6irfxPf0SLrlNDbr/P64/uIv+s5d6r3Tj9isKveus=;
        b=Ee9UU5UKiRb8bjJfay7RGmiqugjVNzMmZSdZ+hhW52vCDA8n5VU+9IdtnrZgchp56M
         TApyViOxC2mUn0bKBhv2aXvhfJzLGpjA+iEwSEChrqHsrQumr0tO/kULpcxdXlOSZoNz
         jyflFKQ4d19i8H8flxrDftLmksUuxDYad1bGBNYXIX/cNvdeNc1bCuo4UzrjThz/tfBe
         STiK4xcoZ4eilttZTmDQ37pv0/HNgwTYOHL1XtQFWLYR6LdlzsGjW+OeGnxpjeWHPCyl
         m3GMtBbSo0U/NGpelOIpe+h2GWzKbHo2Omc52Xfrgjlasrg06dJAohmeEgze+LoqZhYv
         HyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678705713;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qU6irfxPf0SLrlNDbr/P64/uIv+s5d6r3Tj9isKveus=;
        b=1aC9ecsTN3vVcAc5mtFXJKoRzzx32eY46zba+4u3oPKf/lGkX5H23ckzQ6g+qkqKBh
         9DXOSB+zoW6B9avtfgUpoN39gCTLIskPB+91oKBPQTqcXlsIoyac7l2nzAls29niDvqF
         43ha4zIFFPMQoby4SAA4OTt+IYOvXD1W23pJcu8fExkCwZIrBnBq9EB1J0ccNEXLaxyl
         UDYke6FJTVywjUZtx0TpazENE5IMwIjKc4UcB8Akix3Q6aUiifhg842NN91YXfg9d2xL
         4EqUbThsPRhya/D8/4fFZN7KuiNn9AzFOyQ23XgFSAcYmPKooloqyOHbnnyt4oqkUNu8
         HXzA==
X-Gm-Message-State: AO0yUKWm1UwJVg9N8f1RHSVJipVHo3IoQAfq1JYwvgze8Gh0gvWFDpN6
        uqXj9eIMoXYsqFaDo2Cb28UyX6MpGWiDLA==
X-Google-Smtp-Source: AK7set8q3curyQI83qNTMjFfXAldGYhJOBMu9VtmHg4gJ9PVWA2NPiaQXUP43P2DhBqXBG0BTvTuNg==
X-Received: by 2002:a17:902:8307:b0:19c:fa22:e98e with SMTP id bd7-20020a170902830700b0019cfa22e98emr28746153plb.33.1678705713192;
        Mon, 13 Mar 2023 04:08:33 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ik5-20020a170902ab0500b001a04d37a4acsm1488723plb.9.2023.03.13.04.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 04:08:32 -0700 (PDT)
Message-ID: <3de6d1b0-51f8-368b-e73f-8c1e007bf7f8@gmail.com>
Date:   Mon, 13 Mar 2023 20:08:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] extcon: Added extcon_alloc_groups to simplify
 extcon register function
Content-Language: en-US
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <20230302090143.46678-1-bw365.lee@samsung.com>
 <CGME20230302090149epcas1p33a5cd34ed350301b547c2ac3914569d4@epcas1p3.samsung.com>
 <20230302090143.46678-5-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230302090143.46678-5-bw365.lee@samsung.com>
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
> The alloc groups is functionalized from extcon_dev_register.
> 
> Signed-off-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 58 +++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 321988231806..c366a7988daf 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1181,6 +1181,39 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
>  	return 0;
>  }
>  
> +/**
> + * extcon_alloc_groups() - alloc the groups for extcon device
> + * @edev:	extcon device
> + *
> + * Returns 0 if success or error number if fail.
> + */
> +static int extcon_alloc_groups(struct extcon_dev *edev)
> +{
> +	int index;
> +

ditto.

	if (!edev)
		return -EINVAL;

> +	if (!edev->max_supported)
> +		return 0;
> +
> +	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
> +			sizeof(struct attribute_group *),
> +			GFP_KERNEL);
> +	if (!edev->extcon_dev_type.groups)
> +		return -ENOMEM;
> +
> +	edev->extcon_dev_type.name = dev_name(&edev->dev);
> +	edev->extcon_dev_type.release = dummy_sysfs_dev_release;
> +
> +	for (index = 0; index < edev->max_supported; index++)
> +		edev->extcon_dev_type.groups[index] = &edev->cables[index].attr_g;
> +
> +	if (edev->mutually_exclusive)
> +		edev->extcon_dev_type.groups[index] = &edev->attr_g_muex;
> +
> +	edev->dev.type = &edev->extcon_dev_type;
> +
> +	return 0;
> +}
> +
>  /**
>   * extcon_dev_register() - Register an new extcon device
>   * @edev:	the extcon device to be registered
> @@ -1236,28 +1269,9 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	if (ret < 0)
>  		goto err_alloc_muex;
>  
> -	if (edev->max_supported) {
> -		edev->extcon_dev_type.groups =
> -			kcalloc(edev->max_supported + 2,
> -				sizeof(struct attribute_group *),
> -				GFP_KERNEL);
> -		if (!edev->extcon_dev_type.groups) {
> -			ret = -ENOMEM;
> -			goto err_alloc_groups;
> -		}
> -
> -		edev->extcon_dev_type.name = dev_name(&edev->dev);
> -		edev->extcon_dev_type.release = dummy_sysfs_dev_release;
> -
> -		for (index = 0; index < edev->max_supported; index++)
> -			edev->extcon_dev_type.groups[index] =
> -				&edev->cables[index].attr_g;
> -		if (edev->mutually_exclusive)
> -			edev->extcon_dev_type.groups[index] =
> -				&edev->attr_g_muex;
> -
> -		edev->dev.type = &edev->extcon_dev_type;
> -	}
> +	ret = extcon_alloc_groups(edev);
> +	if (ret < 0)
> +		goto err_alloc_groups;
>  
>  	spin_lock_init(&edev->lock);
>  	if (edev->max_supported) {

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

