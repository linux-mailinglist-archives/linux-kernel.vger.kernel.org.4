Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5322B6D464C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjDCN4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjDCN4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:56:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9D635BB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:56:41 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id x15so27277630pjk.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XwtKbntfzXP2y+F0GxcVhJw+QB/Lj55Ci5OMf8SD9og=;
        b=icMm/PgpFIhMB8AthGyMVnaPDHSIrTDWD2zcYBe0GbIT1kfzK6WPpYNjvQ3P237bSc
         w7k9Y17ihmJMieofIbOnZG7A1V+uaNAiroxbouvsQEc1Rfazex0D+WIeiU7EBnJyqVJD
         wX2/g34SzJm5CtrmWAhBk2kM4S4rvn1kLrlPIwdHPewAEoxVBO0JV7TV4y2PDJ42+t9i
         Wmh17r9D+pyJHXLN/DoOkzXQBQKcfyqD00Ft9qg8xsNJhn10JfDu+qYtsYlRbj3aUkAJ
         QZmhPi1oNO4rIPoG1EtzaRh8LxLc8tICFIf3eeQRvLJ+uDKpaDcjnGAmwPaiso1DPrpY
         a5mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwtKbntfzXP2y+F0GxcVhJw+QB/Lj55Ci5OMf8SD9og=;
        b=W574crAAgJkyyfACB5lvQqdDKSDyuyQKWhyf7gBHChMXhQW52jZvW2mb6bY8Ja42z1
         GJ6ihiPXOnV9E0UjiKcbDJDq7YCxoaxxjMILAr8DJdxmrsdQzl67ykJXb42g92yxGquj
         a7vgcmU5BONB50NPcCinm8mkmnArx8gMLG9oBw39vdDkUMpx9Zz5wmUe/O8NM1I2Ai+1
         maRJf/3/NZudwHJ2vNZO86tANoKbe0EICJmfWjwRlxNZjqObXuNw4e3w8ECpwStFvqF/
         +TeB3AAGLzdqJ8/LvxFkh+IK5NB7xxjQ1GJNlj1gx5FRiX5uGWx9BtJGDB4nEvnwbtiK
         bGDw==
X-Gm-Message-State: AAQBX9efvQ92mxXpr8ZqQA9OOjyXkiDoHPe273WHzY+777xbZZ0PSRCz
        jmLZSu6yvwLjyoPJHwpk0WymfG/jC7vPhw==
X-Google-Smtp-Source: AKy350ZycLZMOk3YPS4HhAsLnuuP/bUQpfAh9p9U/WSjil4gcAaLJJRr6kJMnMIFcaRmj4lb8as4NA==
X-Received: by 2002:a17:903:28c4:b0:1a2:8f43:5449 with SMTP id kv4-20020a17090328c400b001a28f435449mr13033082plb.54.1680530200777;
        Mon, 03 Apr 2023 06:56:40 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b001a2574813b8sm6174859plb.278.2023.04.03.06.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:56:40 -0700 (PDT)
Message-ID: <294ce7fa-3256-72aa-b3f7-07fce2e3d43a@gmail.com>
Date:   Mon, 3 Apr 2023 22:56:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 06/14] extcon: Allow name to be assigned outside of the
 framework
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-7-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-7-andriy.shevchenko@linux.intel.com>
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

On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> The documentation states that name of the extcon can be assigned
> outside of the framework, however code does something different.
> Fix the code to be aligned with the documentation.

Actually, it is not possible to initialize the name outside of the framework
because commit 20f7b53dfc24 ("extcon: Move struct extcon_cable from header file to core")
moved the 'struct extcon_dev' into drivers/extcon/extcon.c in order to prevent
the direct accessing of struct extcon_dev.

Instead of this patch, need to change the description of struct extcon_dev.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index ac84f4aafc69..14e66e21597f 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1269,10 +1269,10 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	edev->dev.class = extcon_class;
>  	edev->dev.release = extcon_dev_release;
>  
> -	edev->name = dev_name(edev->dev.parent);
> -	if (IS_ERR_OR_NULL(edev->name)) {
> -		dev_err(&edev->dev,
> -			"extcon device name is null\n");
> +	if (!edev->name)
> +		edev->name = dev_name(edev->dev.parent);
> +	if (!edev->name) {
> +		dev_err(&edev->dev, "extcon device name is null\n");
>  		return -EINVAL;
>  	}
>  	dev_set_name(&edev->dev, "extcon%lu",

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

