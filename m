Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826376C6A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjCWOT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjCWOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:19:07 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B52A35EFD
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:19:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id cu12so8081786pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BsqfAlFXxtiA1PbvhRzrmLRJN9trI/DIwa6fuyTqGnk=;
        b=ZRy1VXithiY3rIINrCyFpiy3Xk8gGaERr5HvnoJQvT42UYkiIZNgT/7AfyXMGwejlP
         DMQyoF2hyZNoqT5+5XHonaDkJealNqxDEMU6ZrhytrMudG1FfL88D3smySjCfHPcNsKH
         ilI7U2atyJii+bmB2QGdhmP6PohPkI290N38IabLGqJ311uI2XKvxqhj7f9mrs0STrgX
         JJLCkA5BGbgemqwhSpqlxCoWHj1VP5dMKi1mWAswGLxpIcA8QbH+DG7rT3CXLVwcCOpm
         ETF74n6Apqdi/3fwhjsapxWxx+BWrXpAneR+23N+r4xAp8G2YFCGXCl1JYKeLrb8phn7
         6s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581144;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BsqfAlFXxtiA1PbvhRzrmLRJN9trI/DIwa6fuyTqGnk=;
        b=l4T4RgX6cHMpPSVw2NHRIDEG3Qy8ZreYjHpJWu32rDVsVwDvDa+zKeK1p/rqSsCzfN
         TonbAtV8g+YiQ53WXkYZFDvgqI4xj9E47pwFTG0S4+iwPSj7Ppm+Sguq2V++cpiUKVbV
         Zop65vXxL0zTrFuuMqGpKuABzXWMuPqg4/v7hteZAPghoLji4HYubrFFMqpu6Up/eAJg
         OakzVMGC86kc5RJmGxnO9LsyP3NojJ/x6MQnDXBG6f1wlulzOCSK8OJGX5d1tKBXPzSV
         VO/zfm5i3M+W3cYmojGTB4LobRaZLccO2OmIt3gZd71zlP5f3kJ1d/QogjhTdp2zP567
         7wZg==
X-Gm-Message-State: AO0yUKWIKIETyPmT4qbx8lMCDRB+WK73ZCu0eL9pOsvQdthiqiBbaF6W
        /lqlVdHlPv2zuGb853C2N1Q+ur0LAqUv/Q==
X-Google-Smtp-Source: AK7set8GQKvsz0gM4hnDxvG1l/9SfZLRSB2tW1R3pmu9XVratK0hDwyYzMaX2q7uHMrk2bK54s//ww==
X-Received: by 2002:aa7:951d:0:b0:625:e3be:a3c5 with SMTP id b29-20020aa7951d000000b00625e3bea3c5mr6593389pfp.28.1679581144399;
        Thu, 23 Mar 2023 07:19:04 -0700 (PDT)
Received: from [172.30.1.36] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d17-20020aa78e51000000b00627fea66a4asm7220300pfr.39.2023.03.23.07.19.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:19:03 -0700 (PDT)
Message-ID: <328208b5-f276-0099-e476-8fa721178916@gmail.com>
Date:   Thu, 23 Mar 2023 23:19:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
References: <20230322111708.1042312-1-arnd@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322111708.1042312-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 20:16, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_USB_ROLE_SWITCH=m, tusb320 cannot be built-in:
> 
> ld.lld: error: undefined symbol: fwnode_usb_role_switch_get
>>>> referenced by extcon-usbc-tusb320.c
>>>>               drivers/extcon/extcon-usbc-tusb320.o:(tusb320_probe) in archive vmlinux.a
> ld.lld: error: undefined symbol: usb_role_switch_set_role
>>>> referenced by extcon-usbc-tusb320.c
>>>>               drivers/extcon/extcon-usbc-tusb320.o:(tusb320_state_update_handler) in archive vmlinux.a
> 
> Add the appropriate Kconfig dependency to prevent this
> configuration but still allow the driver to be built-in
> when USB_ROLE_SWITCH is disabled.
> 
> Fixes: 19685ae43489 ("extcon: usbc-tusb320: add usb_role_switch support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/extcon/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 290186e44e6b..0ef1971d22bb 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -185,6 +185,7 @@ config EXTCON_USBC_TUSB320
>  	tristate "TI TUSB320 USB-C extcon support"
>  	depends on I2C && TYPEC
>  	select REGMAP_I2C
> +	depends on USB_ROLE_SWITCH || !USB_ROLE_SWITCH
>  	help
>  	  Say Y here to enable support for USB Type C cable detection extcon
>  	  support using a TUSB320.

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

