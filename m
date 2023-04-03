Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC68B6D48D3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjDCOcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjDCOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:32:16 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D59D4F8F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:32:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id iw3so28187608plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680532328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQejbzM8otZssOfEt8r92QXWeGQPsXlAdd7Frf3phW0=;
        b=YUi/bNdpRGojU9A4bb1p7QnR8PjSqwd6ggYByNiWdYnmTTea43qJgvDXl+FaOvNoxG
         9uEYiUJzC7MQq4tnzg4Dt1mfidmBKpbMRCMg2gh3PDWgB/qMeaajakil5rOtcj85oFjV
         C0PwxTwuRssyipJvfNrPQ1fmIR+0v2XxOmmxfDgQSjkh/Um0Yiksh4B3J2XnZvQoiLbN
         NsJcfXtJNA1soZGkeJW0byaXzI7q0W8D3BJtQICE6tiM/bAGMK3xorK2gsS8RUC8AOOs
         xV63QOzKFpSEBKKqA7Bf0WDJUYu/fv2+35COSXgSzSaGXRhMsMECSvQLL1Llf4b/RrSx
         WpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680532328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQejbzM8otZssOfEt8r92QXWeGQPsXlAdd7Frf3phW0=;
        b=q8OJCpUdlhOUW3Cp36RYkrAhBiHH8Me8XDlPJRnUDpblvxWZuymHhgs5HfwoSmD0qA
         WKjOuroE0kTLP6v8o8UArfl3HM14kJiGK/heMhgqZyFn5WvabjDktTV7xfaW1pfQObE6
         Gio20bm5JGeNLDZWdGoURskjlE74HrxHQeFpx8s1E+nsogqlVPawZTYz8A3HT3RVleIy
         BNGcBGXJ4CnvjCNo6ovBazACYzyfKLMsJ5oIClM067oLC5mPZ13YlTaalJn+kdq7Uy3z
         kSiyAEuUYAGJszQ2GTBzOdf7Tlk4qnMPCfdgO8PhfZmy6JO1OcMZEuDMAXkxaLo0nJD6
         YLVQ==
X-Gm-Message-State: AAQBX9coQkpblfEGDrLbIK3OY4HkzWuSkSeWuzc1zAGGYt1qxhNkAg9X
        zRS1B1ALDjN4T3mMTpymjQCux+WT33OkLg==
X-Google-Smtp-Source: AKy350YW8G+aQdUMHxWGFY4AIoBWgodAX8Y1Xa85QcDq0ibMv9X1KMPAl9HpkY4zrl4pgwQbw6awuQ==
X-Received: by 2002:a17:903:124d:b0:19a:aaac:f4d1 with SMTP id u13-20020a170903124d00b0019aaaacf4d1mr19844628plh.13.1680532327738;
        Mon, 03 Apr 2023 07:32:07 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e1-20020a170902d38100b0019ee0ad15b4sm6688525pld.191.2023.04.03.07.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:32:07 -0700 (PDT)
Message-ID: <56c49141-c9c4-6b03-7ecf-74f6fdb1209e@gmail.com>
Date:   Mon, 3 Apr 2023 23:32:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 12/14] extcon: Use sizeof(*pointer) instead of
 sizeof(type)
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-13-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-13-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:40, Andy Shevchenko wrote:
> It is preferred to use sizeof(*pointer) instead of sizeof(type).
> The type of the variable can change and one needs not change
> the former (unlike the latter). No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 0e04ea185c26..b3f038639cd6 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1099,9 +1099,7 @@ static int extcon_alloc_cables(struct extcon_dev *edev)
>  	if (!edev->max_supported)
>  		return 0;
>  
> -	edev->cables = kcalloc(edev->max_supported,
> -			       sizeof(struct extcon_cable),
> -			       GFP_KERNEL);
> +	edev->cables = kcalloc(edev->max_supported, sizeof(*edev->cables), GFP_KERNEL);

Even if there are strictly not limitation of the number of maximum char
at the one line, But, I recommend to keep the 80 char at the one line
for the readability as following.

-       edev->cables = kcalloc(edev->max_supported, sizeof(*edev->cables), GFP_KERNEL);
+       edev->cables = kcalloc(edev->max_supported,
+                       sizeof(*edev->cables), GFP_KERNEL);


>  	if (!edev->cables)
>  		return -ENOMEM;
>  
> @@ -1160,14 +1158,12 @@ static int extcon_alloc_muex(struct extcon_dev *edev)
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
> @@ -1213,8 +1209,8 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
>  		return 0;
>  
>  	edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
> -			sizeof(struct attribute_group *),
> -			GFP_KERNEL);
> +					       sizeof(*edev->extcon_dev_type.groups),
> +					       GFP_KERNEL);

ditto.

        edev->extcon_dev_type.groups = kcalloc(edev->max_supported + 2,
-                                              sizeof(*edev->extcon_dev_type.groups),
-                                              GFP_KERNEL);
+                                      sizeof(*edev->extcon_dev_type.groups),
+                                      GFP_KERNEL);


>  	if (!edev->extcon_dev_type.groups)
>  		return -ENOMEM;
>  
> @@ -1298,8 +1294,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  
>  	spin_lock_init(&edev->lock);
>  	if (edev->max_supported) {
> -		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh),
> -				GFP_KERNEL);
> +		edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh), GFP_KERNEL);

-               edev->nh = kcalloc(edev->max_supported, sizeof(*edev->nh), GFP_KERNEL);
+               edev->nh = kcalloc(edev->max_supported,
+                               sizeof(*edev->nh), GFP_KERNEL);


>  		if (!edev->nh) {
>  			ret = -ENOMEM;
>  			goto err_alloc_nh;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

