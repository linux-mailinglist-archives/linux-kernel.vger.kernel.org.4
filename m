Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF897448B0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGALJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGALJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 07:09:34 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EC13C07;
        Sat,  1 Jul 2023 04:09:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f9fdb0ef35so4639458e87.0;
        Sat, 01 Jul 2023 04:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688209771; x=1690801771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LyQo7oGCzL0q4nMHdOWsUgl2XzXKe7BOngdS1hsphWI=;
        b=MpzVOfkTDGXum05mEE1Aa8/iBIcGLFakyuf9yYZoTYeGHZXIZ16CO5E5H8jLQ9lyUY
         BhAOA/GGqNh3NEz45nHeZb1wJsqptZXbB0ZY19HUvc0cCo337TWu4OEYjlRpFPBSQEa8
         3DvQ3sful+ygfpyRjqf9YU8nwUqQCq1OflOIThjnA39YC3EFgjgidkkreL1PcQBa56XX
         uoDVGeOA/Dha/OoKocTDMDJAJk/iz3E2+fl2KmZjgZjXePXEm1grGoWgMwxnSzVN93DF
         +VD1Y0buGkf0Ec1dk/ZOAHD74ITsKXHMFgA/T+ywwc6+b0wpKs3+Zj01lAX9tLo4lQLW
         HP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688209771; x=1690801771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyQo7oGCzL0q4nMHdOWsUgl2XzXKe7BOngdS1hsphWI=;
        b=B+8fSDQuZseJWyeh3zS6+p8XKFegF0A/zQHV/z65QoUKhR4GK587bbKlxy4/dexScF
         uIXOj6VZnfqPaHW/qx84QO46tHwcTmLFIidCNdcxnHX0gyFTRMzuqSyXd5xS0dNpiyeJ
         qfGlXpn7g25jiFQbkoy9Kf6PEVjlbIQf5N3PxMIpQjYaj4LYbvqnRPlJCThlVhWowKzx
         mtQDNSq1DCxyVBQlyA4SJEtQFwyiGeG8E8ZZUvGuEWp6QrwD0IcBSl5JDANvc/LYQPFd
         7f2Ou9vfR4FyhZjUcxDQbqD5J6tkrSH8LKNERQPm6EkjtTMuWUy539/Uxpk1kPhI1dPP
         C8Hw==
X-Gm-Message-State: ABy/qLYPuTNKo/PkGAaWZqkPgkrAHMTPuxM3w6HhiPB8xQaNmiKIkzEg
        ELBZey6HFRTKuGM2nI9XLy4Jo8DWXFo=
X-Google-Smtp-Source: APBJJlFJBnGRzqT/F8NwRkkxu9Uzyos7FGd6xZUEAGWgt3eTPo2M8RsX63JR4a+zwEAn05FPhtSxBw==
X-Received: by 2002:a05:6512:3991:b0:4f8:49a8:a0e2 with SMTP id j17-20020a056512399100b004f849a8a0e2mr4796943lfu.16.1688209771171;
        Sat, 01 Jul 2023 04:09:31 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004f3945751b2sm3350944lfh.43.2023.07.01.04.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 04:09:30 -0700 (PDT)
Message-ID: <3e8e7834-fe0e-7e92-5472-cb9fd223980e@gmail.com>
Date:   Sat, 1 Jul 2023 13:09:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] led: led-class: Read max-brightness from
 devicetree
To:     Astrid Rost <astrid.rost@axis.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     kernel@axis.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230630092248.4146169-1-astrid.rost@axis.com>
 <20230630092248.4146169-2-astrid.rost@axis.com>
Content-Language: en-US
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20230630092248.4146169-2-astrid.rost@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Astrid,

On 6/30/23 11:22, Astrid Rost wrote:
> Add max-brightness in order to reduce the current on the connected LEDs.
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions. Note that led-max-microamp should be preferably used, if it
> is supported by the controller.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>   drivers/leds/led-class.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 9255bc11f99d..ce652abf9336 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -457,6 +457,10 @@ int led_classdev_register_ext(struct device *parent,
>   			if (fwnode_property_present(init_data->fwnode,
>   						    "retain-state-shutdown"))
>   				led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
> +
> +			fwnode_property_read_u32(init_data->fwnode,
> +				"max-brightness",
> +				&led_cdev->max_brightness);
>   		}
>   	} else {
>   		proposed_name = led_cdev->name;

We have led-max-microamp for that and every LED class driver is supposed
to calculate its max brightness level basing on it.

-- 
Best regards,
Jacek Anaszewski
