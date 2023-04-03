Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD16D4B41
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjDCO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjDCO7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:59:34 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7F6A77
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:59:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so32826490pjp.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680533973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2z5860QTlM9JkUlVzDVObEYBXhTDENhgCL0bmdrvI5E=;
        b=GDt0g2EU03RU31NAL3miPzuCjKM+bLRF/u1jNBfghUs00vMqwGRmm1cBbq1FS6Zed8
         w6XpqVZHMVuKjwHU8MXk4iuI7L6DPqI93OnoT5CK34QkF1lTo/OgQesifMsurxp92mHz
         xbrLYS1HvAfcf9QTnUOVRCh+u9ciYrk+QwmffkRZp7k2jmWdQecP08R9ySKWxEGwtcxE
         37nAUixgEG10JlF+vx7dJgr3a6KaWtvRr321uMM3EeCmfnN2tmnVMw+yt2l0EQAqvqiT
         pV6He55vecMwzeenpEneOObQcc7Y4Fv9GD9MuVITqKJFqAV7qS/2EqOi5z6K28YxgMYe
         AREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2z5860QTlM9JkUlVzDVObEYBXhTDENhgCL0bmdrvI5E=;
        b=FbaH7NhBzfW1JhU5ZXLIu4A2LNn+cGr86P5yvJrppdy7gKZsw2Y/5vgTZmMNeDKPYl
         TJm/rfVyKud2nCP9vkOIhseojEuOKzMTpnig4Xqt/wWxq+kdvQRaHZdD9mGNaVpksDyU
         Vq/NPlG0kRGIgudyNW2W/89279ZPW6NavmvWj3ZWRG97XpXyZfITsVSBGK8BGmnPMGHK
         xduG4obOtZT0Y7RyuH6z/WjrkFVeFjiRhJS8PcfG/Ik49tFUxtWr3gIDYSZH4zT+MsQf
         bAEdABTfUs5wsKaAA/hDUhtGzPxdimlRHix8B16mXUAnU+2IHQCGB6nVcn3Qx16lT3Et
         MMjQ==
X-Gm-Message-State: AAQBX9dHjZN8ZY/juaxHoccV28RCUeGWp/vlGbiGPAwO0Z1a34LZatuE
        W7QjMdoa5dez35zMMT3OT+qPqg1hKffzXw==
X-Google-Smtp-Source: AKy350aoJugm3Qdyt0vGQ26lYQzNpIalAatKfs9eLMSm0NIYsrngyIorXdc50CDRguFA4XlMFqYpWg==
X-Received: by 2002:a17:90b:314c:b0:23d:42d4:b9f5 with SMTP id ip12-20020a17090b314c00b0023d42d4b9f5mr43198123pjb.37.1680533972991;
        Mon, 03 Apr 2023 07:59:32 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id kq3-20020a17090aed0300b00233b18e6fb3sm6270500pjb.1.2023.04.03.07.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:59:32 -0700 (PDT)
Message-ID: <789f5aaa-77fa-d656-95d2-ec75857fa266@gmail.com>
Date:   Mon, 3 Apr 2023 23:59:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 11/14] extcon: Remove dup device name in the message
 and unneeded error check
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-12-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-12-andriy.shevchenko@linux.intel.com>
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
> The device name is already printed with dev_err(), no need to repeat.
> The device pointer itself is not supposed to be an error point, drop
> that check.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 32e96cb49067..0e04ea185c26 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1367,9 +1367,8 @@ void extcon_dev_unregister(struct extcon_dev *edev)
>  	list_del(&edev->entry);
>  	mutex_unlock(&extcon_dev_list_lock);
>  
> -	if (IS_ERR_OR_NULL(get_device(&edev->dev))) {
> -		dev_err(&edev->dev, "Failed to unregister extcon_dev (%s)\n",
> -				dev_name(&edev->dev));
> +	if (!get_device(&edev->dev)) {
> +		dev_err(&edev->dev, "Failed to unregister extcon_dev\n");
>  		return;
>  	}
>  

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

