Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B055FF289
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJNQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJNQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:50:13 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFCD936097;
        Fri, 14 Oct 2022 09:50:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so8402387pjq.3;
        Fri, 14 Oct 2022 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkMsvdLbBeZZxwn3yy2WbY/9rIDQ+8vzAzzyaobi6r0=;
        b=e/yFi6KoJg3I6g+3aCX1L13tFLk8xN1MaLDGjbvGvDV9NzmLEfo5Y8DS+xrzlQEPph
         tt/bI3cJ799bfNiOBC3/9plGkHl3w5n5Nl6DdZEPs8YRtS6XO7sBdItiwvk3VA/M4J0a
         qXoRsCZ2EPkHwMM53B/6NPI6vRaDF4vEldxsDlgevrLz5mAlSXiF9XNM1NJHkc/kB3MG
         jjG12+SxzSgZVU+owkdizHWafdQkbwcn7b9bU69EYs5/pkSyZNGxtCaPwOV+WrCxQpt4
         CEfnXplHtM/TcfB7ASjd03BW2BmCVpAzfamdTOBAQFJ7HH7kILATDbMg3tkNwmdf9PDO
         rx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkMsvdLbBeZZxwn3yy2WbY/9rIDQ+8vzAzzyaobi6r0=;
        b=sSo6+vJzbo+LZ/5sRS90JNzJuX9sYKnRfsRChLFQ0AOnBNUbDEO2zB3NPxlsqYuls3
         bYhjCCi5H4WkaK3UpG2lCq748eTws8dYa3ktHHPGlVTGZalDLExEL+IUHsgaHjCX6v/E
         hawwTajBESoRrdTbiJcMM+CAUBuhMuW7PH/ziQRmpAhAgGfPzC/n6sdEvGNXW6FcehaT
         x/xRbxa4+p5+B3a7ggvwpe7mYoWIAI2RsWVBWLczbPwIhBI70RfsQSyllLNxPbNI/Kbj
         f0a9kle6N699PlKHY25k6cZkT30eprPqHU/wEqPXUGaZ7IVXy8cbXV3ahF0d76hUQ4zI
         PDnQ==
X-Gm-Message-State: ACrzQf2CttZKarjO6mKf+60zdvIzqnudK/Yt3srab1loRTPWXDQb6jsc
        peX9+8Le/TJfRrL2JqUDa0E=
X-Google-Smtp-Source: AMsMyM6+3hGyBVVJgqRpA70C+EAQ4HDMDpyknsRATrg9MgyWgx/BN3rh/VZwr75LuQq2VkEuXCNGLg==
X-Received: by 2002:a17:90b:2247:b0:20d:a2be:95ae with SMTP id hk7-20020a17090b224700b0020da2be95aemr12041409pjb.244.1665766208022;
        Fri, 14 Oct 2022 09:50:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v6-20020a632f06000000b0046497308480sm1684127pgv.77.2022.10.14.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 09:50:07 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 14 Oct 2022 09:50:06 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] hwmon: corsair-psu: add USB id of the new HX1500i psu
Message-ID: <20221014165006.GA201666@roeck-us.net>
References: <Y0FghqQCHG/cX5Jz@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0FghqQCHG/cX5Jz@monster.localdomain>
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

On Sat, Oct 08, 2022 at 11:35:34AM +0000, Wilken Gottwalt wrote:
> Also updates the documentation accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  Documentation/hwmon/corsair-psu.rst | 2 ++
>  drivers/hwmon/corsair-psu.c         | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index 3c1b164eb3c0..6a03edb551a8 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -19,6 +19,8 @@ Supported devices:
>  
>    Corsair HX1200i
>  
> +  Corsair HX1500i
> +
>    Corsair RM550i
>  
>    Corsair RM650i
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index c1c27e475f6d..2210aa62e3d0 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -821,6 +821,7 @@ static const struct hid_device_id corsairpsu_idtable[] = {
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0c) }, /* Corsair RM850i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c0d) }, /* Corsair RM1000i */
>  	{ HID_USB_DEVICE(0x1b1c, 0x1c1e) }, /* Corsair HX1000i revision 2 */
> +	{ HID_USB_DEVICE(0x1b1c, 0x1c1f) }, /* Corsair HX1500i */
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(hid, corsairpsu_idtable);
