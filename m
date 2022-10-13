Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0609E5FDBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJMN7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJMN6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:58:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F2082D18;
        Thu, 13 Oct 2022 06:57:54 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id l6so1611280pgu.7;
        Thu, 13 Oct 2022 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sGCbtoZq8xW4BBmJD2BEfn6t+q0YI6YvtbXTTyy1Hmg=;
        b=UYnj+gymmvoScgVRFsb1PbkuongBvFu8ViIlnB5PjY+maxFwN1+uRES1RT/tV4Rxjt
         a+hVclk3CYldUXokamV8PRaEfhLNfUD0+eALszPYucB7VsNml+yJJegS+EcySTJk9n/p
         Bg/bkxZGpENHcpVrU+Xva0O+Cn85LBCpHXsisk/bKLo3qzW55Ithj61nzdFCIS1Onr8M
         KO6tWTd4qSTahlHWlUjpZtfr72NshYpzhL9u0X92eGPUEnIis4ejiYAMIAz1mR4/VqBT
         fOWWFR51JMmzX1daLh0lF8NSaTlus5jZhOtcsatrEg9bgAKmDIDnrdmGBcjl7HrjryMt
         GCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sGCbtoZq8xW4BBmJD2BEfn6t+q0YI6YvtbXTTyy1Hmg=;
        b=QbqoavSY3usJNYaMlWY4WsWgiGPdnNWh/sL+LMnbCYRgzzOCQECScbzSkyODS32VrL
         CTvK+ptHmwlRriaDw/smlyQn+CSG2gUVc6Cg3KijOti3b1LIKllt+sYKshhxQ2vjlSFb
         m/d5XFFUlE+dAQpybgK/7qa0dCuvN3MP4AHQ6MYIsTpCY+X0J7A65P7zA8F2r6BkrsB4
         VcTB7/e0vDuY+MuaJPFzkSwQjqGuSVqxZnnZCKl7lyLskxbsQXN/XQbCwUte9Yu1ZdVa
         Hcrf1JW2mhL19xRXQdgUKcrJckMdH+Phhe5m2kcfILNwgk91+hLzmVBxI0JU7bqEPCWf
         8x8Q==
X-Gm-Message-State: ACrzQf36Fv+oUdjhKxyn06qWf6B3V5OT7mQpCIXx/k9s4lBjj1+kmd34
        64gd/p1zx3bV4wlGmKdu1GITRuK5jGU=
X-Google-Smtp-Source: AMsMyM4LjSCoI19v1XmUSYkhwWFIO0pn2oRii409dEnca/pF5rbqf1z/h6ZWGEZoY4f6vfFJtqLWGg==
X-Received: by 2002:a05:6a00:7ce:b0:562:b271:9854 with SMTP id n14-20020a056a0007ce00b00562b2719854mr35435951pfu.46.1665669198242;
        Thu, 13 Oct 2022 06:53:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9-20020a17090a054900b0020adf65cebbsm3295915pjf.8.2022.10.13.06.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:53:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <29536273-4cd5-5530-083a-c8b8e42e1eb1@roeck-us.net>
Date:   Thu, 13 Oct 2022 06:53:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drivers: watchdog: exar_wdt.c fix use after free
Content-Language: en-US
To:     Manank Patel <pmanank200502@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013095439.1425108-1-pmanank200502@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221013095439.1425108-1-pmanank200502@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 02:54, Manank Patel wrote:
> fix use after free by storing the result of PTR_ERR(n->pdev)
> to a local variable before returning.
> 
> Signed-off-by: Manank Patel <pmanank200502@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/exar_wdt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/exar_wdt.c b/drivers/watchdog/exar_wdt.c
> index 35058d8b21bc..7c61ff343271 100644
> --- a/drivers/watchdog/exar_wdt.c
> +++ b/drivers/watchdog/exar_wdt.c
> @@ -355,8 +355,10 @@ static int __init exar_wdt_register(struct wdt_priv *priv, const int idx)
>   						    &priv->wdt_res, 1,
>   						    priv, sizeof(*priv));
>   	if (IS_ERR(n->pdev)) {
> +		int err = PTR_ERR(n->pdev);
> +
>   		kfree(n);
> -		return PTR_ERR(n->pdev);
> +		return err;
>   	}
>   
>   	list_add_tail(&n->list, &pdev_list);

