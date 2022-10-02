Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12D45F2597
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 00:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiJBWAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 18:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJBWAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 18:00:36 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F926AF7;
        Sun,  2 Oct 2022 15:00:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 83so1708184pfw.10;
        Sun, 02 Oct 2022 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=3L1SFoyI/CodJZCKCKOYJhtVOFo0BvZvPrThQ28zRVQ=;
        b=Q6BZR792ePTLBqCbJaF1I5YzCzH84/KIWfrK9YaVCVc+lQ9C6UaWU0UkohX4dygjci
         tVHqlm41s5eZXBIqd3ccFXtEBtLUBPglKqHd3ZLcsQ+YhbUVl3oS7y/OpCCX47bgDSNx
         NoY58Pok/9inbk83MbHJRoPOpmkeZX4o+TAgD5mXp7aXZww1l5SEUcGXx68534uOfjPz
         DGE8n2WQ4RFQD8bqsTK4+XFPSsRg1mvaQZKQl6m59briKERdgMKxi0T7GmDC141f47nU
         6CJvJIhuqLCr8U9K8Ia3S3dsEQji6mmpFFWEH9gUo9AgiS/EtH5+FOJvJab7vXP0wknU
         10tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=3L1SFoyI/CodJZCKCKOYJhtVOFo0BvZvPrThQ28zRVQ=;
        b=zMORkb1tUpRw20bMxhzXjZGpuPOIGBg09dnb5cUlYpTfwFTTaY/jca8F4NvODHvD42
         BDhkctykUZQQZhvZIGxRtSBTOJXMn82UViUDsN8R5Cr13Jq3h5PmkwNBSigMMUrX2gDV
         kZhu0V9V77YTZrYm/P37D6Eeo4js5hRb4iqgCDvE/0rg7qrCPw+LLaAaqR1gW1nKcYpu
         QHFDQW0J4TFQGq/VsdJ+O1Qr4e7zYdiDBG9NQgZrfDGZ2KeS+ASjg9YJljFDdJDr3NDI
         9xc4QcqUqN4j07csF0dKkN4Q2sLb8sH0TYAVTeM6Adrb6QFBNR5IwgNxQ3IAOB5ktQ9+
         yf5w==
X-Gm-Message-State: ACrzQf315nmds4Qvvv3yrInsKUtcrMWeK157yir35wpE7x2b7CAHUvGZ
        8KEVQEueXcx1CaFbo9hNwwc=
X-Google-Smtp-Source: AMsMyM4GP95zn07FyoDm5gMRESVJP/FCAPIF9txyyj0WHai/a5UP729gHwIs3zaozT0rXU0T0FcnPw==
X-Received: by 2002:a62:1b8f:0:b0:54b:8114:e762 with SMTP id b137-20020a621b8f000000b0054b8114e762mr19694390pfb.7.1664748032495;
        Sun, 02 Oct 2022 15:00:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t6-20020a17090a3b4600b002098f3b4c67sm5208131pjf.34.2022.10.02.15.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 15:00:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 2 Oct 2022 15:00:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add USB id of new revision of the
 HX1000i psu
Message-ID: <20221002220029.GA591488@roeck-us.net>
References: <YznOUQ7Pijedu0NW@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YznOUQ7Pijedu0NW@monster.localdomain>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 05:45:53PM +0000, Wilken Gottwalt wrote:
> Also updates the documentation accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/corsair-psu.rst | 2 +-
>  drivers/hwmon/corsair-psu.c         | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index c3a76305c587..3c1b164eb3c0 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -15,7 +15,7 @@ Supported devices:
>  
>    Corsair HX850i
>  
> -  Corsair HX1000i
> +  Corsair HX1000i (revision 1 and 2)
>  
>    Corsair HX1200i
>  
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index c99e4c6afc2d..345d883ab044 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -813,13 +813,14 @@ static const struct hid_device_id corsairpsu_idtable[] = {
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c04) }, /* Corsair HX650i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c05) }, /* Corsair HX750i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c06) }, /* Corsair HX850i */
> -	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c07) }, /* Corsair HX1000i revision 1 */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c08) }, /* Corsair HX1200i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c09) }, /* Corsair RM550i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0a) }, /* Corsair RM650i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0b) }, /* Corsair RM750i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsaur HX1000i revision 2 */
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
