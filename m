Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA9C6D4637
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjDCNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjDCNvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:51:07 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5723FF7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:51:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j13so27272551pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680529860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZfdPtDc3/0plZLygzC8wNRVQl1868mypq8pERERsC4=;
        b=A2U3Q6pFykkMJqLCYbbJdArN+tfPTfeic4GwcRsu/qB6UVZD1mayF4QnkStkIHdm8i
         lLYAxgLx4VGj+ZGtw9qlOksu4tmR4NGFZu/BhPOBDZtukDo1bG9omz5aOcgXOERaSxD/
         4HA1JoNW0VXEqiLelmoD4iUYkuF/8aliSa3EIlUbZoHiDS/bhVOEzU4x1seWl65VTRzA
         7vB+fxkbc5TB+doNlGXHMXUmvFwDpo1DTBcsxkJMlNFmpZ7h5JO7BKEf6ajjg9W1mI+X
         GTH1TtatedOs5CwgxKj+Kmgm1E75fZLpFqpTvyuI62A2IRV6SYFR3Aj6Ajcdy9GJwDW/
         94xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529860;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YZfdPtDc3/0plZLygzC8wNRVQl1868mypq8pERERsC4=;
        b=B2SGiQLNfHNk4fhAEzyUqAvMNb2iWTg390c0+Xq/px1byNMGHQEgE9McR6YzPAUxay
         owB5962M0pROh6ZswOZAtVtVEZjWkR4ZQH/hmSsMIyKOpcPIQ8Lu6NjhDizbNgkGHxf/
         Rd3GsL2FspUP1Kakh24DMrEmtahd5BOnB5hesVZ5KK+lQtECetXqr7IedytIwKIBIPuV
         rLQVL6YSkPG/O9jx6JfP/X35qCq9zLM/8yHtIS3R8kDkSjV3ZM/Vl+IHWx+eI1awszQx
         L01qgf8pF0ofj4t75Rsr3wL27NnAlXNHe/ICWn2qsEvxJuTbB8wAW0NwLKfAqaJ3U141
         0LSw==
X-Gm-Message-State: AAQBX9ecGUy+3Rm0ef7eKy9hLAyhreIpgPamNjQS3uzPqXXY3b62tKtw
        qQLHxodbi/YwXhYTwJsFUxHHBe2N7dKXHg==
X-Google-Smtp-Source: AKy350Y0mAKcB2jRoFocvNgzYQJy0OZO9CDmPOc4eJCrLzMNRZBqrILWijMYwI6JboTCeyy9lkSqBA==
X-Received: by 2002:a05:6a20:6daa:b0:de:8f7d:dc09 with SMTP id gl42-20020a056a206daa00b000de8f7ddc09mr29478398pzb.8.1680529860426;
        Mon, 03 Apr 2023 06:51:00 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7928f000000b00628e9871c24sm6941056pfa.183.2023.04.03.06.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:51:00 -0700 (PDT)
Message-ID: <ef4fd49b-cc00-8af4-f2fa-473ecc0c98af@gmail.com>
Date:   Mon, 3 Apr 2023 22:50:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 01/14] extcon: Fix kernel doc of property fields to
 avoid warnings
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-2-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-2-andriy.shevchenko@linux.intel.com>
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
> Kernel documentation has to be synchronized with a code, otherwise
> the validator is not happy:
> 
>      Function parameter or member 'usb_propval' not described in 'extcon_cable'
>      Function parameter or member 'chg_propval' not described in 'extcon_cable'
>      Function parameter or member 'jack_propval' not described in 'extcon_cable'
>      Function parameter or member 'disp_propval' not described in 'extcon_cable'
> 
> Describe the fields added in the past.
> 
> Fixes: 067c1652e7a7 ("extcon: Add the support for extcon property according to extcon type")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 3997b39680b7..1bc2639704c2 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -206,6 +206,10 @@ static const struct __extcon_info {
>   * @attr_name:		"name" sysfs entry
>   * @attr_state:		"state" sysfs entry
>   * @attrs:		the array pointing to attr_name and attr_state for attr_g
> + * @usb_propval:	the array of USB connector properties
> + * @chg_propval:	the array of charger connector properties
> + * @jack_propval:	the array of jack connector properties
> + * @disp_propval:	the array of display connector properties
>   */
>  struct extcon_cable {
>  	struct extcon_dev *edev;

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

