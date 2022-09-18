Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A295BBDF7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIRNTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIRNTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:19:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0CE1DA5D;
        Sun, 18 Sep 2022 06:19:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id a14so28791829ljj.8;
        Sun, 18 Sep 2022 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=xAdSK4zu9i7/4F3vbyt9vJTdO/EeNs3jhLAC5qAxHlM=;
        b=W0D4NJHj4WhKsQEzfkFQzsjqbNtHK5nprPPQ+ayEUqtUV/MO5kpVFT3Nz0PxmDJjdS
         kO4m1nhyrrrr5knXRbnLQ+Fum1Oepae5/VyBa+tpX679skZH3oMhJQoMV2ULpweJKMio
         IiIr+ysJK/gm2CDVEjAtOj5OF1DrlNHJtcSWtC5F9J4FScEYGDiY9AEBxry7x2DPH9wo
         M/F7m5gVA1lxfoXBo/VwPfN6826kEu3caZx8M1cNRByB3QG8x7nuO9AkWuiT1dMtOOA+
         YOP4lyYbgYgy9dr9V/jXvcc4zIOX3aK9rMBmuLLOuBt6UuL8daDtkdAJgUaP3O1stUDE
         8sJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xAdSK4zu9i7/4F3vbyt9vJTdO/EeNs3jhLAC5qAxHlM=;
        b=qNxRHXfQrbFMRbcAUCuDNfqDVTfHwZwyn/Ge5WYb/g4mwxSCatPakqFUUyLMeVmRMd
         tP4U9wp9kumVeyqMC/SWBeQaLZXm0SJ40XOqDrnnfMEAaIvEhpPCh1AFMui9yzD5a2+k
         W34xd3FXZImTu3FYKX843H1+o2IHUn0Ng6w177BB7EVsVRlTefL8BxgeiqWsc0fkfyus
         S4sPGebRFYCiHVE/e/VHrMDjvn6kFs/oZxInMf5yQ+lOnnEI1thdIPukl3G3B6Gee3EM
         kxjph6zjP69GrEKS3oZpOfbM1UIqUpxP3AmtS+XUSZLIRkFSCmywNcYKpOvWGntUGulY
         yftw==
X-Gm-Message-State: ACrzQf1Ik9EFfDjpVChObkCPSkF0bTIR7TCLrrEm62sooig4w4oAGhib
        yxHXABayoy5eOpqCZfC3Ook=
X-Google-Smtp-Source: AMsMyM6x6U00y3HV9+Di6Pr9U/lk2StLpSXfImiA89LyVdUJDE/Jg33zDeiLl0j1RLU7l+yS5Y/eIQ==
X-Received: by 2002:a2e:9a88:0:b0:26a:c4d2:3418 with SMTP id p8-20020a2e9a88000000b0026ac4d23418mr4028141lji.81.1663507164056;
        Sun, 18 Sep 2022 06:19:24 -0700 (PDT)
Received: from [192.168.0.131] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id 2-20020ac25f02000000b00499a6ef78a7sm4623969lfq.66.2022.09.18.06.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 06:19:23 -0700 (PDT)
Message-ID: <57b8c30f-08be-b34d-d85c-6545af8b0338@gmail.com>
Date:   Sun, 18 Sep 2022 15:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND PATCH v3 2/4] leds: class: store the color index in
 struct led_classdev
Content-Language: en-US
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, pavel@ucw.cz,
        robh+dt@kernel.org, sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, marijn.suijten@somainline.org,
        bjorn.andersson@linaro.org, andy.shevchenko@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-3-jjhiblot@traphandler.com>
 <0f6e0dc0-7101-ff17-09ce-14bd2a0189fb@gmail.com>
In-Reply-To: <0f6e0dc0-7101-ff17-09ce-14bd2a0189fb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/22 13:25, Jacek Anaszewski wrote:
> Hi Jean,
> 
> On 9/17/22 10:13, Jean-Jacques Hiblot wrote:
>> This information might be useful for more than only deriving the led's
>> name.
>>
>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>> ---
>>   drivers/leds/led-class.c | 7 +++++++
>>   include/linux/leds.h     | 1 +
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
>> index 2c0d979d0c8a..537379f09801 100644
>> --- a/drivers/leds/led-class.c
>> +++ b/drivers/leds/led-class.c
>> @@ -350,6 +350,10 @@ int led_classdev_register_ext(struct device *parent,
>>               if (fwnode_property_present(init_data->fwnode,
>>                               "retain-state-shutdown"))
>>                   led_cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
>> +
>> +            if (fwnode_property_present(init_data->fwnode, "color"))
>> +                fwnode_property_read_u32(init_data->fwnode, "color",
>> +                             &led_cdev->color);
>>           }
>>       } else {
>>           proposed_name = led_cdev->name;
>> @@ -359,6 +363,9 @@ int led_classdev_register_ext(struct device *parent,
>>       if (ret < 0)
>>           return ret;
>> +    if (led_cdev->color >= LED_COLOR_ID_MAX)
>> +        dev_warn(parent, "LED %s color identifier out of range\n", 
>> final_name);
>> +
>>       mutex_init(&led_cdev->led_access);
>>       mutex_lock(&led_cdev->led_access);
>>       led_cdev->dev = device_create_with_groups(leds_class, parent, 0,
>> diff --git a/include/linux/leds.h b/include/linux/leds.h
>> index ba4861ec73d3..fe6346604e36 100644
>> --- a/include/linux/leds.h
>> +++ b/include/linux/leds.h
>> @@ -71,6 +71,7 @@ struct led_classdev {
>>       const char        *name;
>>       unsigned int brightness;
>>       unsigned int max_brightness;
>> +    unsigned int color;
> 
> We have color_index in struct mc_subled. What would this serve for?

OK, I missed that you're using it leds-group-multicolor.c.

-- 
Best regards,
Jacek Anaszewski
