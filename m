Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63496DA161
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjDFTdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236539AbjDFTdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:33:50 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541D4EFA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:33:48 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q2so2349341pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680809628; x=1683401628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVITSJikc5MYH2eGs3jv67wrpfk1hvjhoJNpLp9dD3I=;
        b=kQUCbLeoUNTfZeonYihjvFTpqqsuwCJ4NSA8Tx00Bk2qGOnb2hwqX8LIr43IkKNZMw
         V4n+y2MRZ/6aEwbTxJgboK3dRqECb9kUftcnTVukgY81l3jSg7roXxeL0ZpO+A5cZ9Km
         Ks4NPnyvuf/yCOgis3b0L/C9/pOwDNZWlag7DklaR8jQsAz2WJMDUbBIMiCxvoxkObne
         FZtM79N0IMAvcw70y6r+F7XQxweJUTDDb8/mV2+/Fde/OdZeg+EmAzMoA8Q3R7CFlrsE
         LOvpA0OY0jGebdK7bZT8upvv1aowsZsmlmxDOZFGdCMO/3yC69Jz2H0KCGqcGiQoH5fD
         MALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680809628; x=1683401628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVITSJikc5MYH2eGs3jv67wrpfk1hvjhoJNpLp9dD3I=;
        b=u03HIDm2zXCNFRWyeOK7B5osuT99KNtqT+J+ticlFhNDjMTKZZXkUwzqKb/024MCeQ
         vngOk9aIGh2pRGi1zKnNlKimKGIXHa4x7butZ7Km39Y/LTH2yf8qItFQ7rFrztiIISCZ
         cB8UEFoNqArb1RnnK0SF2hNi0rQCpsfdm+ziENGUaNCzdRSjFzeOGsZobr1sGh+lqOp3
         XnutxB2fXQRteLGuJVEY/qK8861tGSsygOe87TMEcGM6E/A4bUprplbyo2//BtzTd6sd
         wyQO77devVc4L49IwayLgruwtLZMumW2hiAKARQ+0uV5HaEtQB1v5hVKoByUIXGAzLoP
         nyqA==
X-Gm-Message-State: AAQBX9c8ur6WFIl2wwAxOxHzrCdrAJ/q1s3pLfkBh0qBwFfbZZ9/kKXm
        Q6JFaxR0R+JiCSfpPdDCkDagUmh9jG/vXw==
X-Google-Smtp-Source: AKy350bZ+AXbzB325DI2b4DAyd4+apFzZqRQpuqDERA2UnmmWHbRNsf3WpCzkKZTFoW1UsMjfMOzyA==
X-Received: by 2002:a17:903:705:b0:19e:73a9:c21b with SMTP id kk5-20020a170903070500b0019e73a9c21bmr193740plb.45.1680809627840;
        Thu, 06 Apr 2023 12:33:47 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id jm24-20020a17090304d800b0019c91989a1csm1700088plb.300.2023.04.06.12.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:33:47 -0700 (PDT)
Message-ID: <68d4f415-fd7f-dd12-7b14-c81842aa1f19@gmail.com>
Date:   Fri, 7 Apr 2023 04:33:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/5] extcon: Use sizeof(*pointer) instead of
 sizeof(type)
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-5-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230405152745.24959-5-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 4. 6. 00:27, Andy Shevchenko wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type).
> The type of the variable can change and one needs not change
> the former (unlike the latter). No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
> ---
>  drivers/extcon/extcon.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index daaded92cf80..50c5fd454488 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1098,8 +1098,7 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
>  	if (!edev->max_supported)
>  		return 0;
>  
> -	edev->cables = kcalloc(edev->max_supported,
> -			       sizeof(struct extcon_cable),
> +	edev->cables = kcalloc(edev->max_supported, sizeof(*edev->cables),
>  			       GFP_KERNEL);
>  	if (!edev->cables)
>  		return -ENOMEM;
> @@ -1161,14 +1160,12 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
>  	for (index = 0; edev->mutually_exclusive[index]; index++)
>  		;
>  
> -	edev->attrs_muex = kcalloc(index + 1,
> -				   sizeof(struct attribute *),
> +	edev->attrs_muex = kcalloc(index + 1, sizeof(*edev->attrs_muex),
>  				   GFP_KERNEL);
>  	if (!edev->attrs_muex)
>  		return -ENOMEM;
>  
> -	edev->d_attrs_muex = kcalloc(index,
> -				     sizeof(struct device_attribute),
> +	edev->d_attrs_muex = kcalloc(index, sizeof(*edev->d_attrs_muex),
>  				     GFP_KERNEL);
>  	if (!edev->d_attrs_muex) {
>  		kfree(edev->attrs_muex);
> @@ -1214,8 +1211,8 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
>  		return 0;
>  
>  	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
> -			sizeof(struct attribute_group *),
> -			GFP_KERNEL);
> +					  sizeof(*edev->extcon_dev_type.groups),
> +					  GFP_KERNEL);
>  	if (!edev->extcon_dev_type.groups)
>  		return -ENOMEM;
>  
> @@ -1293,7 +1290,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	spin_lock_init(&edev->lock);
>  	if (edev->max_supported) {
>  		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh),
> -				GFP_KERNEL);
> +				   GFP_KERNEL);

Looks good to me. 

But, actually, this line change is not related to role of this patch.
If possible, we have to keep the only one role on one patch. Don't touch it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

