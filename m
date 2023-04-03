Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C636D4B11
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbjDCOxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjDCOxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:53:21 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B2328E86
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:52:50 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so30799336pjl.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680533569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L58ore7rc3KMeRRhxz4jXT8BuC5rytou4tTyy0BwwyA=;
        b=nmefKah4ce2DwgPcLC+BopmlMgQb9z5tPcoNgJj79IWE3OSVCsvu2vl+rpsyNkpolZ
         R86TW2GHzYKPU2YHCqIfcpNfVlgUsKR7t9WPvDGPLCPX9aGs4y+AMlv1FvsBTdyYVWbQ
         pVUnLjy2x51qtg7mP7f2GMq+YToSPFzv4q7rW1LHEf+SLe/UrUzuiFmfufbVjr7FPGDL
         hTK00Bga/19iW3FPmnWmBhrkYhVlJinshAbN1FVcfUqOHJXQJm36HrLp8Ru15JoqSEsC
         //weI0lyfVuC8yQdlUapBMQPT66O8+WoHZVEaBCLV5yLDuRuFOVpno1T3TP7QP5SHPUr
         cYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533569;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L58ore7rc3KMeRRhxz4jXT8BuC5rytou4tTyy0BwwyA=;
        b=w10dVfTOiODqrxO66nn90wdqIE8NXcNSshYdGLhpE1r1RBr6NJB4AM/J6xxzKceya6
         Www52X3Rvx3tFwf6AV6nkpP5xSNrUfDQpgYwYVwyJl0vjskENwy9E+9A38zKmQFVZ4qX
         Yo+czeBdJbypsOxiDeP1gLanKedThEO7cKTpS9ljVYO3J4rbqw6vqrOoV8QHJqtbkZrf
         8ETB6NUtVY6KU5aA4Oe+8HCPnSBlsCl3p3RedBENbuEhNs8E4tI/pVCcDZ3GMntZER3Y
         +tOfhtRN1x9yHyEeN5pBsaSC43S/DAW7ufpZavRod2jrrDp3ShDD/DD0hqXpx8pZtc//
         DP1A==
X-Gm-Message-State: AAQBX9cWoI9Aen2CqVKeQDxjMYjOqaBK4b92LK7BP98iEbJFXiR/VPAB
        yYDCQdAHEJYeLKqzsR0hDYI=
X-Google-Smtp-Source: AKy350afAU/ENwmLgD/WAv9nlH8fc1cb5hHzoHXfQxWgDsYx0gwRqSnaOrNXqkEcSff6KWDHwRFeug==
X-Received: by 2002:a17:903:228f:b0:1a2:185f:f199 with SMTP id b15-20020a170903228f00b001a2185ff199mr44658983plh.63.1680533569387;
        Mon, 03 Apr 2023 07:52:49 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902748700b0019f0ef910f7sm6685366pll.123.2023.04.03.07.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:52:48 -0700 (PDT)
Message-ID: <f0a40f3a-2ff6-5529-ad84-1c66f7e381ea@gmail.com>
Date:   Mon, 3 Apr 2023 23:52:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 07/14] extcon: Use unique number for the extcon device
 ID
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-8-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-8-andriy.shevchenko@linux.intel.com>
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
> The use of atomic variable is still racy when we do not control which
> device has been unregistered and there is a (theoretical) possibility
> of the overflow that may cause a duplicate extcon device ID number
> to be allocated next time a device is registered.
> 
> Replace above mentioned approach by using IDA framework.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 15 ++++++++++++---
>  drivers/extcon/extcon.h |  2 ++
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 14e66e21597f..0d261ec6c473 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -16,6 +16,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/types.h>
> +#include <linux/idr.h>
>  #include <linux/init.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
> @@ -238,6 +239,7 @@ struct extcon_cable {
>  
>  static struct class *extcon_class;
>  
> +static DEFINE_IDA(extcon_dev_ids);
>  static LIST_HEAD(extcon_dev_list);
>  static DEFINE_MUTEX(extcon_dev_list_lock);
>  
> @@ -1248,7 +1250,6 @@ static int extcon_alloc_groups(struct extcon_dev *edev)
>  int extcon_dev_register(struct extcon_dev *edev)
>  {
>  	int ret, index = 0;
> -	static atomic_t edev_no = ATOMIC_INIT(-1);
>  
>  	ret = create_extcon_class();
>  	if (ret < 0)
> @@ -1275,8 +1276,14 @@ int extcon_dev_register(struct extcon_dev *edev)
>  		dev_err(&edev->dev, "extcon device name is null\n");
>  		return -EINVAL;
>  	}
> -	dev_set_name(&edev->dev, "extcon%lu",
> -			(unsigned long)atomic_inc_return(&edev_no));
> +
> +	ret = ida_simple_get(&extcon_dev_ids, 0, INT_MAX, GFP_KERNEL);


ida_simple_get and ida_simple_remove are deprecated on 
commit 3264ceec8f17 ("lib/idr.c: document that ida_simple_{get,remove}()
are deprecated"). Instead of them, better to use ida_alloc and ida_free 
according to the comments.


> +	if (ret < 0)
> +		return ret;
> +
> +	edev->id = ret;
> +
> +	dev_set_name(&edev->dev, "extcon%d", edev->id);
>  
>  	ret = extcon_alloc_cables(edev);
>  	if (ret < 0)
> @@ -1368,6 +1375,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
>  		return;
>  	}
>  
> +	ida_simple_remove(&extcon_dev_ids, edev->id);

ditto.

> +
>  	device_unregister(&edev->dev);
>  
>  	if (edev->mutually_exclusive && edev->max_supported) {
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 15616446140d..877c0860e300 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -20,6 +20,7 @@
>   *			{0x3, 0x6, 0x5, 0}. If it is {0xFFFFFFFF, 0}, there
>   *			can be no simultaneous connections.
>   * @dev:		Device of this extcon.
> + * @id:			Unique device ID of this extcon.
>   * @state:		Attach/detach state of this extcon. Do not provide at
>   *			register-time.
>   * @nh_all:		Notifier for the state change events for all supported
> @@ -46,6 +47,7 @@ struct extcon_dev {
>  
>  	/* Internal data. Please do not set. */
>  	struct device dev;
> +	int id;
>  	struct raw_notifier_head nh_all;
>  	struct raw_notifier_head *nh;
>  	struct list_head entry;

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

