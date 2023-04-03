Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545B26D4989
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjDCOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjDCOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:38:47 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460FD6A5E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:38:46 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y35so17616082pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680532726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyKOUnifa/Kg22j76h04QR7te4Idgi07oXm9sbFwHTc=;
        b=KGk98ifSovqY1DZzni9nQX86O6dvZhMCGhFiyEk+E6VaCSoZjcC7+TyemNrWo3Mhd2
         LrzuJtwdh4L5mQcUPTRHiALC6UcPjGrajEecpM1JVZUPf2RLdsbJTgE7AHr2nIvNfmUW
         VOBG2BkED3Wll2t9g35yGdI5+5DVUFrdX4LGDzYCf7yjvLveGeFqmhAncz2y2nEr7Tgw
         E249YmpDfnol03jHXu/itbnglHaUQjbMepDHAs+2SubyoPmsiF5gFwW5H9Y1+w+rAhs8
         uu0Bcgv+KouDZJ1ybtOPl7mWin3BXTyDXQCklBxqcZKM6zK+IiJuNhI+xcwjGGGhHa7Y
         yEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680532726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyKOUnifa/Kg22j76h04QR7te4Idgi07oXm9sbFwHTc=;
        b=mZCi1nwQiPjDFz8K0ZwLRLqVdjhaWfTZbaru5UxVJOSAYMLRa+fM83gin5b9Gifcm6
         vpHWWhE46cd2Od1BW4yJIAOubtgtH31wsMYabD7uOuvRsMe2AKO5iBqMYZjf+76fprIK
         394w/aWi53o/5zjTmIrYddNkpdsDWCl8E7XYDupo4n1S4ouW7s+wywa86FsFQRcJFBn8
         c+4SeCyp0Cl/rbOojts0OWGU5LtFTdbeD/CoRWmuiQtwfWja5JM4nddaHy/6PDM1hUBg
         9O05DmoyH3iglTZ1lK6jH5v0UK8To3eFkRcNya9+xvLQjGMgJKd12sNllwfnT9OAXzxb
         7OOQ==
X-Gm-Message-State: AAQBX9dz4RabfKD4wWnkC1/dvXz74LlcekJjrB7BkVZxX0pm1a8qWriE
        kqd3yJTZHW6p4ABTkHp7mWRhJCd3v1Hpow==
X-Google-Smtp-Source: AKy350brf4/MqosM9A30E/a84WMe+/DtNcTPaN8L/dQOF+cx3zbrIio0D1AHjaDaKXoe76VB7swmDg==
X-Received: by 2002:a62:63c2:0:b0:62d:8376:3712 with SMTP id x185-20020a6263c2000000b0062d83763712mr23958519pfb.28.1680532725560;
        Mon, 03 Apr 2023 07:38:45 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id e24-20020a62ee18000000b0062dcaa50a9asm7033339pfi.58.2023.04.03.07.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:38:45 -0700 (PDT)
Message-ID: <6bb15158-829e-f032-dc10-110e831da8c3@gmail.com>
Date:   Mon, 3 Apr 2023 23:38:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 14/14] extcon: Use positive conditional in ternary
 operator
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-15-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-15-andriy.shevchenko@linux.intel.com>
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
> It's easier to parse by a human being the positive conditional.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index edfa0450e605..3e8522d522b4 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1466,7 +1466,7 @@ EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
>   */
>  const char *extcon_get_edev_name(struct extcon_dev *edev)
>  {
> -	return !edev ? NULL : edev->name;
> +	return edev ? edev->name : NULL;
>  }
>  EXPORT_SYMBOL_GPL(extcon_get_edev_name);
>  

It is not fix-up patch and I'm not sure that it is beneficial patch. 
I will not apply it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

