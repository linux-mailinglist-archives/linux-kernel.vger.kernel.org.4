Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9DB6D4B5E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjDCPGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjDCPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:06:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDFF269D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:06:41 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l7so27482831pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680534401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtB732qUvTTgNCmRqTe3AjBowm/N/XqcqejYeifOY7U=;
        b=Kyhp9nbCn7lZVucvnSMo1R+OYBjOieC24CY9MlqgKBm5AF7YAy/9G3IBT5GoKMeXTB
         YVSYj7KvI46Gix0LR4GixCkBETP1S7tsspJa6eKY1mNfWvAzbq4JOK7lfCYsp+2VQ8QP
         fv3mloB9nYiVbcQtAg+CeY24/KKMLlYLUCWdyHApJjRObLYeJNgTgJEIDBOUvjwEW9e2
         wnPkPoIzJuQWJcGXjxQNQNVoOp6LxDZn+lkzzRnYrtGvYXWMq2V1+mUAL3LIQ7aeGbMB
         fTvMLJArOnGipO+kf/R7DeJ66FhCqFys+srKPii+M3vdJxGfMljKIMRc05Yqlgdyr3az
         RdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtB732qUvTTgNCmRqTe3AjBowm/N/XqcqejYeifOY7U=;
        b=sHhBT4Sq37GtVvE5HFyixSAAlvN/mvqTkEaLiboGPbJ8Y+4eyLQr8/5voigcXMj7B1
         xRcSeIvFi4VNpkDIFRbB/cZx1aKPVT2ohNMC13+6hkfaNV/idvI/K522C7lvbIPM9JKI
         Sh6u+PTnwfFm799FVg9pZJp232z5yW23UZU/FgyGwbHixTUjbr4B+kMZAec/Ie6oGRTH
         TVRwUkr+RTtFdUIj5YJFnKYnvqrRgcVltaloN0PWy4YzM0E4y4vjRTh0uV7cYYV9tMiS
         Yt+ffqLaPpz9pDs9bjp532wctep7kZTEv/RmUbFjTqUpQz2jlLLvqO3kNhqsq3LPL+g7
         ghsg==
X-Gm-Message-State: AAQBX9c79ZnifLRiPHlHpSELaazbJgO1SjI9HkH5xYBN2mIgZNPnA1ky
        b+QpWuw7yBpW0Ate8qkPrBZ71m0Wtg/6Wg==
X-Google-Smtp-Source: AKy350ZdcThAKMfiwIoxA8iw3XP0Y6suTUVaij3kBTYRZ8WWkjRcNnfLSlfjAJ5E2LeSbHmFBJS/6g==
X-Received: by 2002:a17:903:41c6:b0:1a1:b137:4975 with SMTP id u6-20020a17090341c600b001a1b1374975mr48744276ple.49.1680534401169;
        Mon, 03 Apr 2023 08:06:41 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c7-20020a656187000000b00513468106d8sm6154359pgv.1.2023.04.03.08.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:06:40 -0700 (PDT)
Message-ID: <9b3e8eb1-0e24-322e-641e-a78a12c8c249@gmail.com>
Date:   Tue, 4 Apr 2023 00:06:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 13/14] extcon: Drop unneeded assignments
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-14-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-14-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
> In one case the assignment is duplicative, in the other,
> it's better to move it into the loop — the user of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index b3f038639cd6..edfa0450e605 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -246,7 +246,7 @@ static DEFINE_MUTEX(extcon_dev_list_lock);
>  
>  static int check_mutually_exclusive(struct extcon_dev *edev, u32 new_state)
>  {
> -	int i = 0;
> +	int i;
>  
>  	if (!edev->mutually_exclusive)
>  		return 0;
> @@ -1244,7 +1244,7 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
>   */
>  int extcon_dev_register(struct extcon_dev *edev)
>  {
> -	int ret, index = 0;
> +	int ret, index;
>  
>  	ret = create_extcon_class();
>  	if (ret < 0)
> @@ -1253,7 +1253,7 @@ int extcon_dev_register(struct extcon_dev *edev)
>  	if (!edev || !edev->supported_cable)
>  		return -EINVAL;
>  
> -	for (; edev->supported_cable[index] != EXTCON_NONE; index++);
> +	for (index = 0; edev->supported_cable[index] != EXTCON_NONE; index++);
>  
>  	edev->max_supported = index;
>  	if (index > SUPPORTED_CABLE_MAX) {

It has the dependency with patch7. When I try to apply it, the conflict happen.
When you are sending v2 patches, I'll apply it if there are no conflict.
[1] [PATCH v1 07/14] extcon: Use unique number for the extcon device ID

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

