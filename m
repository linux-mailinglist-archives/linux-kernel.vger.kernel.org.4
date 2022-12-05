Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0F36421E6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiLEDff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLEDfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:35:32 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14C12A8C;
        Sun,  4 Dec 2022 19:35:31 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bd2aea61bso12141991fac.0;
        Sun, 04 Dec 2022 19:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMnuA9x0tni6jdbz8IETQH4PKR2JxjpdpXSjW6Bvtlg=;
        b=PECQeuSlCZnVWOKcIGsSyugPeTMsSrI1MD9OAo9owsdljqefrdzKcv3HKs1+w2yljn
         PxwHjN+Q/8qS8ldqGEo+zpfCtehk+yxf5HTJwoz4VC1YnzurUcHNhzXF3Oq0YbetJhoD
         iaJMe77pDlCwOdc/znnqcCpX+QcYRrcSyARTlMSHN6FWsKpVknx81ghvHxbefKR35r10
         8yn7L4Ir197J0THAR47RbJhoDv6S+q7ZjEJqcm4JDQD7c8L6hXkuD9yR/KfoFnF7+tXw
         R6X8FPXuSMq7tbgX6m7Ht2H4tIKRd09DEJdN/YT26KuZ9oSzHXsHdHjWkqMfh+PhA4DC
         RJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMnuA9x0tni6jdbz8IETQH4PKR2JxjpdpXSjW6Bvtlg=;
        b=LbPVkEfi8W6uF1Lr/q9aN/3pdnTFoqahhw2Cswx/oA9gJuHpP9omYA87E5WsU3s1kF
         MFJKEU2v35t18XnZ0U0ZjZiNzO29ZfBUSrsXkfAezyLQIRsQr7IZLov891PNubqPrOC6
         PKyokpDipk6fxwNiW5kHiVvbLs4EE17Z3B1nSoIwHqxcAMB96M4MKgh7JfllJ3x+7ZSn
         zzyxdoGkrnnkVr2VVtif0FTu8Ux90idqMZvxLZNPsYTEeRDN7bva20Sq/Ud8dcvk1vEP
         g+MW2WdsO04itdWkB3k0Q835uDEFerWfaiM/5/OHX4xhKsJkLRX4fJliXbZ3QhlAx55u
         IqAA==
X-Gm-Message-State: ANoB5pkFMkfD52f7cMzR/JoJYH7k0ejvbldi7Dy7m3jRhPX6IPGmaftX
        LO/ShD8063OMmwQCPQUwiJg=
X-Google-Smtp-Source: AA0mqf7Ok2tqZ7gMfBU7Hx1BDNO66r6pXXwvjUN8vVqZYWwU/b/xuRU9IQ8RXu5OKv/IoGpAaZm1ag==
X-Received: by 2002:a05:6870:562b:b0:144:a773:550c with SMTP id m43-20020a056870562b00b00144a773550cmr678157oao.19.1670211330725;
        Sun, 04 Dec 2022 19:35:30 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d6f19000000b00660e833baddsm7164202otq.29.2022.12.04.19.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 19:35:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Dec 2022 19:35:29 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     pali@kernel.org, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Move error message to make probing
 silent
Message-ID: <20221205033529.GA1908323@roeck-us.net>
References: <20221130183418.357246-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130183418.357246-1-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 07:34:18PM +0100, Armin Wolf wrote:
> If dell-smm-hwmon loads on unsupported hardware like the
> Dell XPS 17 9710, an error message is printed.
> This might confuse users, as drivers are expected to be
> silent if no supported hardware is found.
> Reorder the error message so its only printed when the
> driver is loaded with the "force" option being set.
> Also reword the error message slightly.
> 
> Tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/dell-smm-hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --
> 2.30.2
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index 1572b5416015..7ac778aedc68 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1447,9 +1447,10 @@ static int __init i8k_init(void)
>  	 */
>  	if (i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG1) &&
>  	    i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG2)) {
> -		pr_err("unable to get SMM Dell signature\n");
>  		if (!force)
>  			return -ENODEV;
> +
> +		pr_err("Unable to get Dell SMM signature\n");
>  	}
> 
>  	dell_smm_device = platform_create_bundle(&dell_smm_driver, dell_smm_probe, NULL, 0, NULL,
