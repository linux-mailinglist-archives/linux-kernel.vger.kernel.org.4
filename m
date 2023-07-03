Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1657464F7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGCVj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGCVj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:39:56 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E64188;
        Mon,  3 Jul 2023 14:39:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-992acf67388so460008566b.1;
        Mon, 03 Jul 2023 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688420392; x=1691012392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnScrT58IPOQ6IQbOdPCDhwqrpLVze5GGMmWKWocEXk=;
        b=LahOVHAz96Sa6CSzDyFSP2EGSTtFxXNGkYEM7psXzzUn4I0xK0jR/ot8miWlbf8VhZ
         0aXWpjD13wvDMn0q09VXQZqUhu8b82DFvLqu2lFsuJXxvJQSbMdxT2Kf34a1AF9LXSSC
         nTk57a75pitsnVtWVkJGI+gnZDLiWfAk+bLOGMf3V/VvxsDHXuN2hxidQGTndXoCnVMj
         ZW9JgP+37opkIzy4FWrnEe5Fj0npnnhe36b9/j35R2rr3TS/65sW2lFQ4EcFiIASPRq3
         4klScZw+x3Ft4RfNhKzqgW+BZyo5i7LgxG6IITFMTmddRvLgmG9LXnkcVhEXJe5qdXag
         ip0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688420392; x=1691012392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XnScrT58IPOQ6IQbOdPCDhwqrpLVze5GGMmWKWocEXk=;
        b=UgeYuUzY5MNM6IK8xaaW8qo/ZTqCnNHd66LrArj213qaj55/x9jmcG78JCJbvhO70X
         zXOYwi5o8S6q8/cgdFh8T1wNEqYoQWfdp61BEMSVn5KMLhaCim5aefFNMN1VLWKSgDHh
         9snY0jV72DsDfM8LHSkVNypP22Z8Ag809108Nd1FN6kkrYMJNBHOgxwSaz+WN56tYy22
         44EHZ8jMGSXX0i9++Y+7ElW5aDGoo4ZUCEBg4vfPWq2nG8vkqZliB68TT10Ty6B6bJEx
         9kKkDN52zbr0vukQEul6ESNPTOQ6FIRdraprpAArT+FubYN87H1r2rDqaJW9grgG0Jqn
         Wwww==
X-Gm-Message-State: ABy/qLaoO80AxriJLOHRmhMNQ4NQAa7c7AK/ZAtIe8o1uqWQHhFe4u/k
        gMy8hos8xPS8NqdriQmmjm4=
X-Google-Smtp-Source: APBJJlGO1qyHaeLZOpX30YXuB+PvL4nj5I05rml9JAoJPSbWxMR93SCt8P8az4jvQ84AYVZ1KvVN7g==
X-Received: by 2002:a17:907:76ab:b0:992:d013:1132 with SMTP id jw11-20020a17090776ab00b00992d0131132mr6507534ejc.1.1688420392253;
        Mon, 03 Jul 2023 14:39:52 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id ci8-20020a170906c34800b00982d0563b11sm12332470ejb.197.2023.07.03.14.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 14:39:51 -0700 (PDT)
Message-ID: <6895344b-fe6f-f79e-806b-d77f20ea76e5@gmail.com>
Date:   Mon, 3 Jul 2023 23:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/2] led: led-class: Read max-brightness from
 devicetree
Content-Language: en-US
To:     Astrid Rost <astrid.rost@axis.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>
Cc:     kernel@axis.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230703130313.548519-1-astrid.rost@axis.com>
 <20230703130313.548519-3-astrid.rost@axis.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20230703130313.548519-3-astrid.rost@axis.com>
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

Thanks for the update.

On 7/3/23 15:03, Astrid Rost wrote:
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.
> Note that this flag is mainly used for PWM-LEDs, where it is not possible
> to map brightness to current. Drivers for other controllers should use
> led-max-microamp.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

For the whole set:

Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski
